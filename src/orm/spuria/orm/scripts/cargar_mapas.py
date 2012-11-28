# -*- coding: utf-8 -*-

from comunes import ARCHIVO_CONFIG
from constantes import puntos_venezuela
from decimal import *
from spuria.orm import (
    inicializar, DBSession, Croquis, Dibujable, Punto, Territorio
)
from os import path
from pykml import parser
from sqlalchemy import create_engine, and_, MetaData, Table
from sqlalchemy.orm import sessionmaker, aliased, mapper
from sqlalchemy.sql import select, func, bindparam
from sqlalchemy.types import Numeric
from sys import stdout
import ConfigParser, transaction

"""
TERRITORIO esta ordenado deliberadamente de esta forma para que para cualquier 
i dado, el TERRITORIO en i-1 representa el territorio contenedor. Ej:

Para i = 1: TERRITORIO[i] = MUNICIPIO contenido en TERRITORIO[i-1] = ESTADO
"""

config = ConfigParser.ConfigParser()
with open(ARCHIVO_CONFIG) as fp:
        config.readfp(fp)

TERRITORIO = ['PLANETA', 'PAIS', 'ESTADO', 'MUNICIPIO', 'PARROQUIA']
TABLAS = ['Territorio']
PLANETA = 0
PAIS = 1
ESTADO = 2
MUNICIPIO = 3
PARROQUIA = 4
ARCHIVOS = config.get('mapas', 'archivos').split(',')

def analizar_esquema(esquema):
    if esquema is None:
        raise Exception("esquema no puede ser nulo")
        
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
    terr[ESTADO] = estado[0].text.title() \
    if len(estado) > 0 else ''
    terr[MUNICIPIO] = municipio[0].text.title() \
    if len(municipio) > 0 else ''
    terr[PARROQUIA] = parroquia[0].text.title() \
    if len(parroquia) > 0 else ''

    padre = aliased(Territorio)
    abuelo = aliased(Territorio)

    territorio_padre = DBSession.query(padre.territorio_id).\
    join(abuelo, padre.territorio_padre_id == abuelo.territorio_id).\
    filter(and_(
        padre.nombre == terr[tipo_de_placemark-1],
        padre.nivel == tipo_de_placemark-1,
        abuelo.nombre == terr[tipo_de_placemark-2]
    )).first()[0]

    terro = Territorio(
        creador=1, nombre=terr[tipo_de_placemark], poblacion=0, 
        idioma='Espanol', territorio_padre_id=territorio_padre, 
        codigo_postal='', pib=0, nivel=tipo_de_placemark
    )
    DBSession.add(terro)

    return terro.dibujable if terro is not None else None
                
def analizar_poligono(poligono, dibujable):
    if poligono is None:
        raise Exception("poligono no puede ser nulo")
    if dibujable is None:
        raise Exception("dibujable no puede ser nulo")

    ingresar_silueta(poligono.outerBoundaryIs, dibujable)
    if hasattr(poligono, 'innerBoundaryIs'):
        for silueta_interna in poligono.innerBoundaryIs:
            ingresar_silueta(silueta_interna, dibujable)

def ingresar_silueta(silueta, dibujable):
    if silueta is None:
        raise Exception("silueta no puede ser nulo")
    if dibujable is None:
        raise Exception("dibujable no puede ser nulo")

    dibujable.croquis.append(Croquis(dibujable=dibujable, creador=1))
    for coordenadas in silueta.LinearRing.coordinates.text.split(' '):
        par = coordenadas.split(',')
        dibujable.croquis[-1].puntos.append(
            Punto(latitud=Decimal(par[1]), longitud=Decimal(par[0]))
        )
        
def main():
    inicializar(archivo=ARCHIVO_CONFIG)

    with transaction.manager:
        mun = Territorio(
            raiz=True, creador=1, nombre='La Tierra', poblacion=0, 
            territorio_id='0.00.00.00.00.00', idioma='Mandarin', 
            territorio_padre_id='0.00.00.00.00.00', codigo_postal='', 
            pib=0, nivel=0
        )
        DBSession.add(mun)

        ven = Territorio(
            creador=1, nombre='Venezuela', poblacion=0, 
            idioma='Espanol', territorio_padre_id=mun.territorio_id, 
            codigo_postal='', pib=0
        )
        DBSession.add(ven)

        chi = Territorio(
            creador=1, nombre='China', poblacion=0,
            idioma='Mandarin', territorio_padre_id=mun.territorio_id,
            codigo_postal='', pib=0
        )
        DBSession.add(chi)

        ven.dibujable.croquis.append(Croquis(creador=1))
        for punto in puntos_venezuela:
            ven.dibujable.croquis[0].puntos.append(
                Punto(latitud=punto[0], longitud=punto[1])
            )

        cantidad_arch = len(ARCHIVOS)

        for num_arch, archivo in enumerate(ARCHIVOS):
            archivo_corregido = path.abspath(archivo)
            with open(archivo_corregido) as a:
                print "Archivo ({0},{1}): {2}".format(
                    num_arch + 1, cantidad_arch, archivo_corregido
                )
                doc = parser.parse(a).getroot()
                tipo_de_placemark = analizar_esquema(doc.Document.Folder.Schema)

                if tipo_de_placemark is None:
                     print "No se reconoce el esquema del documento"
                     exit()

                cantidad_i = len(doc.Document.Folder.Placemark)
                for i, pm in enumerate(doc.Document.Folder.Placemark):
                    try:
                        dibujable = analizar_placemark(pm, tipo_de_placemark)
                        DBSession.flush()
                    except Exception, e:
                        print "Error analizando el placemark: {}".format(e)
                        DBSession.rollback()
                        continue
                    if hasattr(pm, 'MultiGeometry'):
                        pm = pm.MultiGeometry
    
                    cantidad_j = len(pm.Polygon)
                    for j, poligono in enumerate(pm.Polygon):
                        stdout.write("\r\t")
                        stdout.write("Analizando: Placemark({},".format(i + 1))
                        stdout.write("{}) =>".format(cantidad_i))
                        stdout.write(" Poligono({},".format(j + 1))
                        stdout.write("{})".format(cantidad_j))
                        stdout.flush()
    
                        try:
                            analizar_poligono(poligono, dibujable)
                        except Exception, e:
                            print "Error analizando el poligono: {}".format(e)
                            continue
     
                stdout.write("\n")

if __name__ == '__main__':
    main()
