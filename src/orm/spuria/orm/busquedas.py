# -*- coding: utf-8 -*-

from comunes import Base, DBSession, ahorita
from palabras import EsEtiquetable
from rastreable import EsRastreable, RastreableAsociacion, Rastreable
from usuarios import Usuario
from sqlalchemy import *
from sqlalchemy.ext.associationproxy import association_proxy
from sqlalchemy.ext.declarative import declared_attr
from sqlalchemy.orm import relationship, backref

class BuscableAsociacion(Base):
    __tablename__ = 'buscable_asociacion'

    # Columnas
    buscable_asociacion_id = Column(
        Integer, primary_key=True, autoincrement=True
    )
    discriminante = Column(String(45))

    # Propiedades
    @property
    def padre(self):
        return getattr(self, "{}_padre".format(self.discriminante))

    # Funciones
    @classmethod
    def creador(cls, discriminante):
        return lambda buscable:BuscableAsociacion(
            buscable=buscable, discriminante=discriminante
        )

class Buscable(Base):
    __tablename__ = 'buscable'

    # Columnas
    buscable_id = Column(Integer, primary_key=True, autoincrement=True)
    asociacion_id = Column(
        Integer, ForeignKey('buscable_asociacion.buscable_asociacion_id')
    )

    # Propiedades
    asociacion = relationship(
        'BuscableAsociacion', backref=backref('buscable', uselist=False)
    )
    padre = association_proxy('asociacion', 'padre')
    busquedas = association_proxy('resultados_de_busquedas', 'busqueda')

class EsBuscable(object):
    @declared_attr
    def buscable_asociacion_id(cls):
        return Column(
            Integer, 
            ForeignKey("buscable_asociacion.buscable_asociacion_id")
        )

    @declared_attr
    def buscable_asociacion(cls):
        discriminante = cls.__tablename__
        cls.buscable = association_proxy(
            'buscable_asociacion', 'buscable', 
            creator=BuscableAsociacion.creador(discriminante)
        )
        return relationship(
            'BuscableAsociacion', backref=backref(
                "{}_padre".format(discriminante), uselist=False
            )
        )
    
    def __init__(self, *args, **kwargs):
        super(EsBuscable, self).__init__(*args, **kwargs)
        self.buscable = Buscable()

class Busqueda(EsRastreable, EsEtiquetable, Base):
    __tablename__ = 'busqueda'
    
    # Columnas
    busqueda_id = Column(Integer, primary_key=True, autoincrement=True)
    usuario_id = Column(
        Integer, ForeignKey('usuario.usuario_id'), nullable=False
    )
    fecha_hora = Column(Numeric(17,3), nullable=False)
    contenido = Column(Text, nullable=False)

    # Propiedades
    usuario = relationship(
        'Usuario', primaryjoin='Busqueda.usuario_id==Usuario.usuario_id',
        backref='busquedas'
    )
    buscables = association_proxy('resultados_de_busqueda', 'buscable')

    def __init__(self, usuario=None, contenido=None, *args, **kwargs):
        super(Busqueda, self).__init__(
            creador=usuario.rastreable.rastreable_id, *args, **kwargs
        )
        self.usuario = usuario
        self.contenido = contenido
        self.fecha_hora = ahorita()

class ResultadoDeBusqueda(Base):
    __tablename__ = 'resultado_de_busqueda'
    
    # Columnas
    busqueda_id = Column(
        Integer, ForeignKey('busqueda.busqueda_id'), 
        primary_key=True, autoincrement=False
    )
    buscable_id = Column(
        Integer, ForeignKey('buscable.buscable_id'), 
        primary_key=True, autoincrement=False
    )
    visitado = Column(Boolean, nullable=False)
    relevancia = Column(Float, nullable=False)

    # Propiedades
    busqueda = relationship('Busqueda', backref='resultados_de_busquedas')
    buscable = relationship('Buscable', backref='resultados_de_busquedas')

    def __init__(self, busqueda=None, buscable=None, relevancia=0, 
                 visitado=False):
        self.busqueda = busqueda
        self.buscable = buscable
        self.visitado = visitado
        self.relevancia = relevancia
