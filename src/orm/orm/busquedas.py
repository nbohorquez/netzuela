# -*- coding: utf-8 -*-

from comunes import Base, DBSession
from palabras import EsEtiquetable
from rastreable import EsRastreable
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
    #tipo = Column(String(45), nullable=False)

    # Propiedades
    asociacion = relationship(
        'BuscableAsociacion', backref=backref('buscable', uselist=False)
    )
    padre = association_proxy('asociacion', 'padre')
    #__mapper_args__ = {'polymorphic_on': tipo}

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
    #__mapper_args__ = {'polymorphic_identity': 'busqueda'}
    
    # Columnas
    """
    rastreable_p = Column(
        Integer, ForeignKey('rastreable.rastreable_id'),
        nullable=False, unique=True, index=True
    )
    etiquetable_p = Column(
        Integer, ForeignKey('etiquetable.etiquetable_id'),
        nullable=False, unique=True, index=True
    )
    """
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
    buscables = relationship(
        "Buscable", secondary=lambda: ResultadoDeBusqueda.__table__, 
        backref="busquedas"
    )

    def __init__(self, usuario_id=None, contenido=None):
        """
        super(Busqueda, self).__init__(
            creador=usuario_x.rastreable_p, *args, **kwargs
        )
        """
        self.usuario_id = usuario_id
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
    busqueda = relationship('Busqueda', backref='resultados')
    cobrable = relationship('Buscable', backref='resultados')
        
    def __init__(self, busqueda_id=None, buscable_id=None, relevancia=None):
        self.busqueda_id = busqueda_id
        self.buscable_id = buscable_id
        self.visitado = False
        self.relevancia = relevancia
