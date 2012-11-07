# -*- coding: utf-8 -*-

from comunes import Base, DBSession
from busquedas import Buscable, ResultadoDeBusqueda, Busqueda
from estadisticas import (
    Estadisticas,
    EstadisticasTemporales, 
    EstadisticasDePopularidad, 
    EstadisticasDeInfluencia, 
    EstadisticasDeVisitas, 
    ContadorDeExhibiciones
)
from rastreable import Rastreable
from generales import Estatus, Categoria
from registros import Accion, CodigoDeError, Registro
from territorios import (
    Territorio, 
    TiendasConsumidores, 
    Region, 
    RegionTerritorio, 
    Idioma
)
from mensajes import Mensaje, Interlocutor
from tiendas_productos import (
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
from croquis_puntos import Punto, Croquis, PuntoDeCroquis, Dibujable
from palabras import Etiquetable, Etiqueta, Palabra, RelacionDePalabras
from usuarios import Cliente, Usuario, Acceso, Administrador, Privilegios
from descripciones_fotos import Describible, Foto, Descripcion
from patrocinantes_publicidades import (
    Patrocinante, 
    Publicidad, 
    ConsumidorObjetivo, 
    GrupoDeEdadObjetivo, 
    GradoDeInstruccionObjetivo, 
    TerritorioObjetivo, 
    SexoObjetivo
)
from ventas import Cobrable, ServicioVendido, Factura
from calificaciones_resenas import (
    Calificacion, 
    CalificacionResena, 
    CalificableSeguible,
    Seguimiento
)
from consumidores import (
    Consumidor, 
    Sexo, 
    GrupoDeEdad, 
    GradoDeInstruccion
)
from sqlalchemy import create_engine
import ConfigParser

def inicializar(archivo, **kwargs):
    if archivo is not None:
        config = ConfigParser.ConfigParser()
        with open(archivo) as fp:
    	    config.readfp(fp)

        motor = create_engine(
            config.get('base_de_datos', 'sqlalchemy.url'), 
            echo=True if config.get('base_de_datos', 'textual')=='si' else False
        )
    elif kwargs is not None and 'sqlalchemy.url' in kwargs:
        motor = create_engine(kwargs['sqlalchemy.url'], echo=True)

    DBSession.configure(bind=motor)
    Base.metadata.create_all(motor)

    """
    DBSession.execute(crear_inventario_tienda)
    DBSession.execute(crear_inventario_reciente)
    DBSession.execute(crear_tamano_reciente)
    """
