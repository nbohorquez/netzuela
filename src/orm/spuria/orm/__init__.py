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
    TamanoReciente,
    InventarioReciente,
    InventarioTienda,
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

def inicializar(archivo, **kwargs):
    from sqlalchemy import (
        create_engine, MetaData, Table, Column, Integer, CHAR, Numeric
    )
    from sqlalchemy.orm import mapper
    import ConfigParser, sys, inspect

    if archivo is not None:
        config = ConfigParser.ConfigParser()
        with open(archivo) as fp:
    	    config.readfp(fp)

        motor = create_engine(
            config.get('base_de_datos', 'sqlalchemy.url'), 
            echo = { 
                'si': True, 'no': False
            }[config.get('base_de_datos', 'textual')]
        )
    elif kwargs is not None and 'sqlalchemy.url' in kwargs:
        motor = create_engine(kwargs['sqlalchemy.url'], echo=True)

    DBSession.configure(bind=motor)
    Base.metadata.create_all(motor)

    DBSession.execute(crear_inventario_tienda)
    DBSession.execute(crear_inventario_reciente)
    DBSession.execute(crear_tamano_reciente)

    metadata = MetaData(motor)

    # Cargamos el primer "diferente": la vista inventario_reciente. 
    # Esta no tiene PK definida.
    esquema_tabla = Table(
        'inventario_reciente', metadata,
        Column('tienda_id', Integer, primary_key=True),
        Column('codigo', CHAR(15), primary_key=True),
        autoload=True
    )
    mapper(InventarioReciente, esquema_tabla)
    
    # Cargamos el segundo "diferente": la vista inventario_tienda. 
    # Tampoco tiene PK definida.
    esquema_tabla = Table(
        'inventario_tienda', metadata,
        Column('tienda_id', Integer, primary_key=True),
        Column('codigo', CHAR(15), primary_key=True),
        autoload=True
    )
    mapper(InventarioTienda, esquema_tabla)

    # Cargamos el tercer "diferente": la vista tamano_reciente. 
    # Sin PK definida.
    esquema_tabla = Table(
        'tamano_reciente', metadata,
        Column('tienda_id', Integer, primary_key=True),
        Column('fecha_inicio', Numeric(20,6), primary_key=True),
        autoload=True
    )
    mapper(TamanoReciente, esquema_tabla)

    # Inicializamos los eventos insert, update y delete
    for nombre, objeto in inspect.getmembers(sys.modules[__name__]):
        try:
            objeto.registrar_eventos()
        except Exception as e:
            continue
        
