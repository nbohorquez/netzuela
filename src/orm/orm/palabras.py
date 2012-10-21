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
    #tipo = Column(String(45), nullable=False)

    # Propiedades
    asociacion = relationship(
        'EtiquetableAsociacion', backref=backref('etiquetable', uselist=False)
    )
    padre = association_proxy('asociacion', 'padre')
    #__mapper_args__ = {'polymorphic_on': tipo}

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
    palabra_x = relationship(
        "Palabra", foreign_keys=[palabra_id], backref="etiquetas"
    )
    
    def __init__(self, etiquetable_id=None, palabra_id=None):
        self.etiquetable_id = etiquetable_id
        self.palabra_id = palabra_id

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

    def __init__(self, palabra1_id=None, palabra2_id=None):
        self.palabra1_id = palabra1_id
        self.palabra2_id = palabra2_id
