# -*- coding: utf-8 -*-

from comunes import Base, DBSession
from sqlalchemy import *
from sqlalchemy.ext.associationproxy import association_proxy
from sqlalchemy.ext.declarative import declared_attr
from sqlalchemy.orm import relationship, backref

class EtiquetableAsociacion(Base):
    __tablename__ = 'etiquetable_asociacion'

    # Columnas
    etiquetable_asociacion_id = Column(
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
        return lambda etiquetable:EtiquetableAsociacion(
            etiquetable=etiquetable, discriminante=discriminante
        )

class Etiquetable(Base):
    __tablename__ = 'etiquetable'

    # Columnas
    etiquetable_id = Column(Integer, primary_key=True, autoincrement=True)
    asociacion_id = Column(
        Integer, ForeignKey('etiquetable_asociacion.etiquetable_asociacion_id')
    )

    # Propiedades
    asociacion = relationship(
        'EtiquetableAsociacion', backref=backref('etiquetable', uselist=False)
    )
    padre = association_proxy('asociacion', 'padre')
    palabras = association_proxy('etiquetas', 'palabra')

class EsEtiquetable(object):
    @declared_attr
    def etiquetable_asociacion_id(cls):
        return Column(
            Integer, 
            ForeignKey('etiquetable_asociacion.etiquetable_asociacion_id')
        )

    @declared_attr
    def etiquetable_asociacion(cls):
        discriminante = cls.__tablename__
        cls.etiquetable = association_proxy(
            'etiquetable_asociacion', 'etiquetable', 
            creator=EtiquetableAsociacion.creador(discriminante)
        )
        return relationship(
            'EtiquetableAsociacion', backref=backref(
                "{}_padre".format(discriminante), uselist=False
            )
        )

    def __init__(self, *args, **kwargs):
        super(EsEtiquetable, self).__init__(*args, **kwargs)
        self.etiquetable = Etiquetable()

class Etiqueta(Base):
    __tablename__ = 'etiqueta'

    # Columnas
    etiquetable_id = Column(
        Integer, ForeignKey('etiquetable.etiquetable_id'), 
        primary_key=True, autoincrement=False
    )
    palabra_id = Column(
        Integer, ForeignKey('palabra.palabra_id'), 
        primary_key=True, autoincrement=False
    )

    # Propiedades
    etiquetable = relationship(
        "Etiquetable", foreign_keys=[etiquetable_id], backref="etiquetas"
    )
    palabra = relationship(
        "Palabra", foreign_keys=[palabra_id], backref="etiquetas"
    )
    
    def __init__(self, etiquetable=None, palabra=None):
        self.etiquetable = etiquetable
        self.palabra = palabra

class Palabra(Base):
    __tablename__ = 'palabra'

    # Columnas
    palabra_id = Column(Integer, primary_key=True, autoincrement=True)
    palabra_frase = Column(CHAR(15), unique=True, nullable=False, index=True)

    # Propiedades
    palabras_relacionadas = relationship(
        "RelacionDePalabras", 
        primaryjoin='or_(Palabra.palabra_id == RelacionDePalabras.palabra1_id,'
        'Palabra.palabra_id == RelacionDePalabras.palabra2_id)'
    )
    etiquetables = association_proxy('etiquetas', 'etiquetable')

    def __init__(self, palabra_frase=None):
        self.palabra_frase = palabra_frase

class RelacionDePalabras(Base):
    __tablename__ = 'relacion_de_palabras'

    # Columnas
    palabra1_id = Column(
        Integer, ForeignKey('palabra.palabra_id'), 
        primary_key=True, autoincrement=False
    )
    palabra2_id = Column(
        Integer, ForeignKey('palabra.palabra_id'), 
        primary_key=True, autoincrement=False
    )

    # Propiedades
    palabra1 = relationship(
        'Palabra', 
        primaryjoin='Palabra.palabra_id==RelacionDePalabras.palabra1_id'
    )
    palabra2 = relationship(
        'Palabra', 
        primaryjoin='Palabra.palabra_id==RelacionDePalabras.palabra2_id'
    )

    def __init__(self, palabra1=None, palabra2=None):
        self.palabra1 = palabra1
        self.palabra2 = palabra2
