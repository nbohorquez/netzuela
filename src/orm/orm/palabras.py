# -*- coding: utf-8 -*-

from comunes import Base, DBSession
from sqlalchemy import Column, Integer, Numeric, Boolean, ForeignKey
from sqlalchemy.orm import relationship, backref

class Etiquetable(Base):
    __tablename__ = 'etiquetable'
    __mapper_args__ = {'polymorphic_on': tipo}

    # Columnas
    etiquetable_id = Column(Integer, primary_key=True, autoincrement=True)
    tipo = Column(String(45), nullable=False)

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
    etiquetable_x = relationship(
        "Etiquetable", foreign_keys=[etiquetable_id], backref="etiquetas"
    )
    palabra_x = relationship(
        "Palabra", foreign_keys=[palabra_id], backref="etiquetas"
    )

    def __init__(self, etiquetable_id=None, palabra_id=None):
        self.etiquetable_id = etiquetable_id
        self.palabra_id = palabra_id

class Palabra(Base):
    __tablename__ = 'etiquetable'

    # Columnas
    palabra_id = Column(Integer, primary_key=True, autoincrement=True)
    palabra_frase = Column(CHAR(15), unique=True, nullable=False, index=True)

    # Propiedades
    palabras_relacionadas_x = relationship(
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
