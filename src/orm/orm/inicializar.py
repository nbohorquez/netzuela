# -*- coding: utf-8 -*-

from orm.comunes import Base, DBSession
from orm.busquedas import Buscable, ResultadoDeBusqueda, Busqueda
from orm.estadisticas import (
    Estadisticas,
    EstadisticasTemporales, 
    EstadisticasDePopularidad, 
    EstadisticasDeInfluencia, 
    EstadisticasDeVisitas, 
    ContadorDeExhibiciones
)
from orm.rastreable import Rastreable
from orm.generales import Estatus, Categoria
from orm.registros import Accion, CodigoDeError, Registro
from orm.territorios import (
    Territorio, 
    TiendasConsumidores, 
    Region, 
    RegionTerritorio, 
    Idioma
)
from orm.mensajes import Mensaje, Interlocutor
from orm.tiendas_productos import (
    TipoDeCodigo, 
    Producto, 
    Visibilidad, 
    PrecioCantidad, 
    Inventario, 
    Tamano, 
    Tienda, 
    Dia, 
    HorarioDeTrabajo, 
    Turno
)
from orm.croquis_puntos import Punto, Croquis, PuntoDeCroquis, Dibujable
from orm.palabras import Etiquetable, Etiqueta, Palabra, RelacionDePalabras
from orm.usuarios import Cliente, Usuario, Acceso, Administrador, Privilegios
from orm.descripciones_fotos import Describible, Foto, Descripcion
from orm.patrocinantes_publicidades import (
    Patrocinante, 
    Publicidad, 
    ConsumidorObjetivo, 
    GrupoDeEdadObjetivo, 
    GradoDeInstruccionObjetivo, 
    TerritorioObjetivo, 
    SexoObjetivo
)
from orm.ventas import Cobrable, ServicioVendido, Factura
from orm.calificaciones_resenas import (
    Calificacion, 
    CalificacionResena, 
    CalificableSeguible
)
from orm.consumidores import (
    Consumidor, 
    Sexo, 
    GrupoDeEdad, 
    GradoDeInstruccion
)
from sqlalchemy import create_engine
import os, sys, transaction

"""
def usage(argv):
    cmd = os.path.basename(argv[0])
    print('usage: %s <config_uri>\n'
          '(example: "%s development.ini")' % (cmd, cmd)) 
    sys.exit(1)
"""
def constantes():
    with transaction.manager:
        cde = []
        cde.append(CodigoDeError("OK"))
        cde.append(CodigoDeError("Privilegios insuficientes"))
        cde.append(CodigoDeError("Accion imposible"))
        DBSession.add_all(cde)

        pri = []
        pri.append(Privilegios("Todos"))
        pri.append(Privilegios("Ninguno"))
        DBSession.add_all(pri)

        idi = []
        idi.append(Idioma("Espanol"))
        idi.append(Idioma("English"))
        idi.append(Idioma("Francais"))
        idi.append(Idioma("Deutsch"))
        idi.append(Idioma("Mandarin"))
        DBSession.add_all(idi)

        tdc = []
        tdc.append(TipoDeCodigo("GTIN-13"))
        tdc.append(TipoDeCodigo("GTIN-8"))
        tdc.append(TipoDeCodigo("GTIN-14"))
        tdc.append(TipoDeCodigo("GS1-128"))
        tdc.append(TipoDeCodigo("Otro"))
        DBSession.add_all(tdc)

        sex = []
        sex.append(Sexo("Hombre"))
        sex.append(Sexo("Mujer"))
        DBSession.add_all(sex)

        gdi = []
        gdi.append(GradoDeInstruccion("Primaria", 1))
        gdi.append(GradoDeInstruccion("Secundaria", 2))
        gdi.append(GradoDeInstruccion("Tecnico Medio", 3))
        gdi.append(GradoDeInstruccion("Tecnico Superior", 4))
        gdi.append(GradoDeInstruccion("Universitaria", 5))
        gdi.append(GradoDeInstruccion("Especializacion", 6))
        gdi.append(GradoDeInstruccion("Maestria", 7))
        gdi.append(GradoDeInstruccion("Doctorado", 8))
        DBSession.add_all(gdi)

        vis = []
        vis.append(Visibilidad("Ninguno visible"))
        vis.append(Visibilidad("Cantidad visible"))
        vis.append(Visibilidad("Precio visible"))
        vis.append(Visibilidad("Ambos visibles"))
        DBSession.add_all(vis)

        acc = []
        acc.append(Accion("Insertar"))
        acc.append(Accion("Abrir"))
        acc.append(Accion("Actualizar"))
        acc.append(Accion("Eliminar"))
        acc.append(Accion("Bloquear"))
        acc.append(Accion("Abrir sesion"))
        acc.append(Accion("Cerrar sesion"))
        DBSession.add_all(acc)

        cal = []
        cal.append(Calificacion("Bien"))
        cal.append(Calificacion("Mal"))
        DBSession.add_all(cal)

        gde = []
        gde.append(GrupoDeEdad("Adolescentes"))
        gde.append(GrupoDeEdad("Adultos jovenes"))
        gde.append(GrupoDeEdad("Adultos maduros"))
        gde.append(GrupoDeEdad("Adultos mayores"))
        gde.append(GrupoDeEdad("Tercera edad"))
        DBSession.add_all(gde)

        est = []
        est.append(Estatus("Activo"))
        est.append(Estatus("Bloqueado"))
        est.append(Estatus("Eliminado"))
        DBSession.add_all(est)

        dia = []
        dia.append(Dia("Lunes", 1))
        dia.append(Dia("Martes", 2))
        dia.append(Dia("Miercoles", 3))
        dia.append(Dia("Jueves", 4))
        dia.append(Dia("Viernes", 5))
        dia.append(Dia("Sabado", 6))
        dia.append(Dia("Domingo", 7))
        DBSession.add_all(dia)

		cat = []
		cat.append(Categoria())
    
        adm = Administrador(
            creador=1, ubicacion_id=None, nombre='Nestor', apellido='Bohorquez',
            privilegios='Todos', correo_electronico='admin@netzuela.com',
            contrasena='$2a$12$MOM8uMGo9XmH1BDYPrTns.k/WLl6vt45qeKEXn5ZqoiBsQeBMfTQG'
        )
        DBSession.add(adm)

def main():
    """
    if len(argv) != 2:
        usage(argv)
    config_uri = argv[1]
    setup_logging(config_uri)
    settings = get_appsettings(config_uri)
    """
    motor = create_engine('mysql://chivo:#HK_@20MamA!pAPa13?#3864@localhost:3306/spuria?charset=utf8&use_unicode=0', echo=True)
    DBSession.configure(bind=motor)
    Base.metadata.create_all(motor)
    constantes()

if __name__ == '__main__':
        main()
