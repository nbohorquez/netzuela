# -*- coding: utf-8 -*-

from pykml import parser
from os import path
from sqlalchemy import create_engine, and_, MetaData, Table
from sqlalchemy.orm import sessionmaker, aliased, mapper
from sqlalchemy.sql import select, func, bindparam
from sqlalchemy.types import Numeric
from sys import stdout
from decimal import *
import ConfigParser

"""
TERRITORIO esta ordenado deliberadamente de esta forma para que para cualquier 
i dado, el TERRITORIO en i-1 representa el territorio contenedor. Ej:

Para i = 1: TERRITORIO[i] = MUNICIPIO contenido en TERRITORIO[i-1] = ESTADO
"""

ARCHIVO_CONFIG = 'config.ini'

config = ConfigParser.ConfigParser()
with open(ARCHIVO_CONFIG) as fp:
        config.readfp(fp)

TERRITORIO = ['PLANETA', 'PAIS', 'ESTADO', 'MUNICIPIO', 'PARROQUIA']
TABLAS = ['territorio']
PLANETA = 0
PAIS = 1
ESTADO = 2
MUNICIPIO = 3
PARROQUIA = 4
ARCHIVOS = config.get('mapas', 'archivos').split(',')

def cargar_tablas(motor):
        metadata = MetaData(motor)
        for asociacion in TABLAS:
                tabla = asociacion
                objeto = asociacion
                esquema_tabla = Table(tabla, metadata, autoload=True)
                mixIn(objeto, [object])
                mapper(globals()[objeto], esquema_tabla)

# Codigo tomado de: 
# http://danielkaes.wordpress.com/2009/07/30/create-new-classes-with-python-at-runtime/ 
def mixIn(classname, parentclasses):
        if len(parentclasses) > 0:
                parents = map(lambda p:p.__name__, parentclasses)
                createclass = "class {} ({}):\n\tpass".format(
                        classname, ",".join(parents)
                )
        else:
                createclass = "class {}:\n\tpass".format(classname)
        exec createclass
        globals()[classname] = eval(classname)

motor = create_engine(config.get('base_de_datos', 'mysql'), echo=False)
cargar_tablas(motor)
conexion = motor.connect()
Sesion = sessionmaker()
Sesion.configure(bind=motor)
sesion = Sesion()

def analizar_esquema(esquema):
        resultado = None
        campos = []
        for campo in esquema.SimpleField:
                campos.append(campo.get("name"))
        for i in range(len(TERRITORIO)-1, -1, -1):
                if TERRITORIO[i] in campos:
                        resultado = i
                        break
        return resultado

def analizar_placemark(placemark, tipo_de_placemark):
        if placemark is None:
                raise Exception("placemark no puede ser nulo")
        if tipo_de_placemark is None:
                raise Exception("tipo_de_placemark no puede ser nulo")

        metadata = placemark.ExtendedData.SchemaData
        terr = ['']*len(TERRITORIO)
        resultado = None

        parroquia = metadata.xpath(".//*[@name='PARROQUIA']")
        municipio = metadata.xpath(".//*[@name='MUNICIPIO']")   
        estado = metadata.xpath(".//*[@name='ESTADO']")
        
        terr[PLANETA] = 'La Tierra'
        terr[PAIS] = 'Venezuela'
        terr[ESTADO] = estado[0].text.title() if len(estado) > 0 else ''
        terr[MUNICIPIO] = municipio[0].text.title() \
        if len(municipio) > 0 else ''
        terr[PARROQUIA] = parroquia[0].text.title() \
        if len(parroquia) > 0 else ''

        def insertar_estado():
                return select([func.InsertarEstado(
                        bindparam('a_creador'),
                        bindparam('a_nombre'),
                        bindparam('a_poblacion'),
                        bindparam('a_idioma'),
                        bindparam('a_territorio_padre'),
                        bindparam('a_codigo_postal'),
                        bindparam('a_pib')
            )])
        def insertar_municipio():
                return select([func.InsertarMunicipio(
                        bindparam('a_creador'),
                        bindparam('a_nombre'),
                        bindparam('a_poblacion'),
                        bindparam('a_idioma'),
                        bindparam('a_territorio_padre'),
                        bindparam('a_codigo_postal'),
                        bindparam('a_pib')
            )])
        def insertar_parroquia():
                return select([func.InsertarParroquia(
                        bindparam('a_creador'),
                        bindparam('a_nombre'),
                        bindparam('a_poblacion'),
                        bindparam('a_idioma'),
                        bindparam('a_territorio_padre'),
                        bindparam('a_codigo_postal'),
                        bindparam('a_pib')
            )])

        sql = {
                ESTADO: lambda: insertar_estado(),
                MUNICIPIO: lambda: insertar_municipio(),
                PARROQUIA: lambda: insertar_parroquia()
        }[tipo_de_placemark]()

        padre = aliased(territorio)
        abuelo = aliased(territorio)

        territorio_padre = sesion.query(padre.territorio_id).\
        join(abuelo, padre.territorio_padre == abuelo.territorio_id).\
        filter(and_(
                padre.nombre == terr[tipo_de_placemark-1],
                padre.nivel == tipo_de_placemark-1,
                abuelo.nombre == terr[tipo_de_placemark-2]
        )).first()[0]

        sesion.execute('begin')
        terro = sesion.execute(sql, params = dict(
                a_creador = 1,
                a_nombre = terr[tipo_de_placemark],
                a_poblacion = 0,
                a_idioma = 'Espanol',
                a_territorio_padre = territorio_padre,
                a_codigo_postal = '',
                a_pib = 0
        )).scalar()
        sesion.execute('commit')

        resultado = sesion.query(territorio.dibujable_p).\
                filter_by(territorio_id = terro).first()[0]
        return resultado
                
def analizar_poligono(poligono, dibujable):
        ingresar_silueta(poligono.outerBoundaryIs, dibujable)
        if hasattr(poligono, 'innerBoundaryIs'):
                for silueta_interna in poligono.innerBoundaryIs:
                        ingresar_silueta(silueta_interna, dibujable)

def ingresar_silueta(silueta, dibujable):
        sql0 = select([func.InsertarCroquis(
                bindparam('a_creador'),
                bindparam('a_dibujable')
        )])
        sql1 = select([func.InsertarPunto(
                bindparam(key='a_latitud', type_=Numeric(precision=6, scale=9)),
                bindparam(key='a_longitud', type_=Numeric(precision=6, scale=9))
        )])
        sql2 = select([func.InsertarPuntoDeCroquis(
                bindparam('a_croquis_id'),
                bindparam('a_punto_id')
        )])
        sesion.execute('begin')
        croquis = sesion.execute(
                sql0, 
                params = dict(a_creador = 1, a_dibujable = dibujable)
        ).scalar()
        for coordenadas in silueta.LinearRing.coordinates.text.split(' '):
                coo = coordenadas.split(',')
                punto = sesion.execute(sql1, params = dict(
                        a_latitud = Decimal(coo[1]), 
                        a_longitud = Decimal(coo[0])
                )).scalar()
                punto_de_croquis = sesion.execute(sql2, params = dict(
                        a_croquis_id = croquis,
                        a_punto_id = punto
                )).scalar()
        sesion.execute('commit')
        
def main():
        cantidad_arch = len(ARCHIVOS)

        for num_arch, archivo in enumerate(ARCHIVOS):
                archivo_corregido = path.abspath(archivo)
                with open(archivo_corregido) as a:
                        print "Archivo ({0},{1}): {2}".format(
                                num_arch, cantidad_arch, archivo_corregido
                        )
                        doc = parser.parse(a).getroot()
                        tipo_de_placemark = analizar_esquema(
                                doc.Document.Folder.Schema
                        )

                        if tipo_de_placemark is None:
                                print "No se reconoce el esquema del documento"
                                exit()

                        cantidad_i = len(doc.Document.Folder.Placemark)
                        for i, pm in enumerate(doc.Document.Folder.Placemark):
                                try:
                                        dibujable = analizar_placemark(
                                                pm, tipo_de_placemark
                                        )
                                except Exception, e:
                                        print "Error analizando el placemark: %s" % e
                                        continue
                                if hasattr(pm, 'MultiGeometry'):
                                        pm = pm.MultiGeometry
                                cantidad_j = len(pm.Polygon)    
                                for j, poligono in enumerate(pm.Polygon):
                                        stdout.write("\r\t")
                                        stdout.write("Analizando: Placemark(%d," % (i + 1))
                                        stdout.write("%d) =>" % cantidad_i)
                                        stdout.write(" Poligono(%d," % (j + 1))
                                        stdout.write("%d)" % cantidad_j)
                                        stdout.flush()
                                        try:
                                                analizar_poligono(
                                                        poligono, dibujable
                                                )
                                        except Exception, e:
                                                print "Error analizando el poligono: %s" % e
                                                continue
                        stdout.write("\n")

if __name__ == '__main__':
        main()
