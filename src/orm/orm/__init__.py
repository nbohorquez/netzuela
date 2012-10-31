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
    Turno,
	crear_inventario_tienda,
	crear_inventario_reciente,
	crear_tamano_reciente
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
import ConfigParser

ARCHIVO_CONFIG = 'config.ini'

config = ConfigParser.ConfigParser()
with open(ARCHIVO_CONFIG) as fp:
	config.readfp(fp)

motor = create_engine(config.get('base_de_datos', 'mysql'), echo=True)
DBSession.configure(bind=motor)
Base.metadata.create_all(motor)
"""
DBSession.execute(crear_inventario_tienda)
DBSession.execute(crear_inventario_reciente)
DBSession.execute(crear_tamano_reciente)
"""
