# -*- coding: utf-8 -*-

from comunes import Base, DBSession
from busquedas import EsBuscable
from descripciones_fotos import EsDescribible
from rastreable import EsRastreable
from palabras import EsEtiquetable
from ventas import EsCobrable
from usuarios import Cliente
from sqlalchemy import *
from sqlalchemy.orm import relationship, backref

class Patrocinante(Cliente):
    __tablename__ = 'patrocinante'
    __mapper_args__ = {'polymorphic_identity': 'patrocinante'}
    
    # Columnas
    cliente_p = Column(
        CHAR(10), ForeignKey('cliente.rif'), nullable=False, unique=True, 
        index=True
    )
    patrocinante_id = Column(
        Integer, primary_key=True, autoincrement=True, index=True
    )

    def __init__(self, *args, **kwargs):
        super(Patrocinante, self).__init__(*args, **kwargs)

class Publicidad(EsBuscable, EsDescribible, EsRastreable, EsEtiquetable, 
                 EsCobrable, Base):
    __tablename__ = 'publicidad'

    # Columnas
    publicidad_id = Column(Integer, primary_key=True, autoincrement=True)
    patrocinante_id = Column(
        Integer, ForeignKey('patrocinante.patrocinante_id'), nullable=False
    )
    nombre = Column(String(45), nullable=False)
    tamano_de_poblacion_objetivo = Column(Integer)

    # Propiedades
    patrocinante = relationship(
        'Patrocinante', 
        primaryjoin='Publicidad.patrocinante_id==Patrocinante.patrocinante_id', 
        backref='publicidades'
    )
    consumidores = relationship(
        "Consumidor", secondary=lambda:ConsumidorObjetivo.__table__, 
        backref="publicidades"
    )
    grupos_de_edades = relationship(
        "GrupoDeEdad", secondary=lambda:GrupoDeEdadObjetivo.__table__, 
        backref="publicidades"
    )
    grados_de_instruccion = relationship(
        "GradoDeInstruccion", 
        secondary=lambda:GradoDeInstruccionObjetivo.__table__, 
        backref="publicidades"
    )
    territorios = relationship(
        "Territorio", secondary=lambda:TerritorioObjetivo.__table__, 
        backref="publicidades"
    )
    sexos = relationship(
        "Sexo", secondary=lambda:SexoObjetivo.__table__, 
        backref="publicidades"
    )

    def __init__(self, patrocinante=None, nombre=None, *args, **kwargs):
        super(Publicidad, self).__init__(
            creador=patrocinante.rastreable.rastreable_id, *args, **kwargs
        )
        self.patrocinante = patrocinante
        self.nombre = nombre
        self.tamano_de_poblacion_objetivo = None

class ConsumidorObjetivo(Base):
    __tablename__ = 'consumidor_objetivo'

    # Columnas
    consumidor_id = Column(
        Integer, ForeignKey('consumidor.consumidor_id'), 
        primary_key=True, autoincrement=False
    )
    publicidad_id = Column(
        Integer, ForeignKey('publicidad.publicidad_id'), 
        primary_key=True, autoincrement=False
    )

    def __init__(self, consumidor_id=None, publicidad_id=None):
        self.consumidor_id = consumidor_id
        self.publicidad_id = publicidad_id

class GrupoDeEdadObjetivo(Base):
    __tablename__ = 'grupo_de_edad_objetivo'

    # Columnas
    grupo_de_edad = Column(
        CHAR(15), ForeignKey('grupo_de_edad.valor'), 
        primary_key=True, autoincrement=False
    )
    publicidad_id = Column(
        Integer, ForeignKey('publicidad.publicidad_id'), 
        primary_key=True, autoincrement=False
    )

    def __init__(self, grupo_de_edad=None, publicidad_id=None):
        self.grupo_de_edad = grupo_de_edad
        self.publicidad_id = publicidad_id

class GradoDeInstruccionObjetivo(Base):
    __tablename__ = 'grado_de_instruccion_objetivo'

    # Columnas
    grado_de_instruccion = Column(
        CHAR(16), ForeignKey('grado_de_instruccion.valor'), 
        primary_key=True, autoincrement=False
    )
    publicidad_id = Column(
        Integer, ForeignKey('publicidad.publicidad_id'), 
        primary_key=True, autoincrement=False
    )

    def __init__(self, grado_de_instruccion=None, publicidad_id=None):
        self.grado_de_instruccion = grado_de_instruccion
        self.publicidad_id = publicidad_id

class TerritorioObjetivo(Base):
    __tablename__ = 'territorio_objetivo'

    # Columnas
    territorio_id = Column(
        CHAR(16), ForeignKey('territorio.territorio_id'), 
        primary_key=True, autoincrement=False
    )
    publicidad_id = Column(
        Integer, ForeignKey('publicidad.publicidad_id'), 
        primary_key=True, autoincrement=False
    )

    def __init__(self, territorio_id=None, publicidad_id=None):
        self.territorio_id = territorio_id
        self.publicidad_id = publicidad_id

class SexoObjetivo(Base):
    __tablename__ = 'sexo_objetivo'

    # Columnas
    sexo = Column(
        CHAR(6), ForeignKey('sexo.valor'), 
        primary_key=True, autoincrement=False
    )
    publicidad_id = Column(
        Integer, ForeignKey('publicidad.publicidad_id'), 
        primary_key=True, autoincrement=False
    )

    def __init__(self, sexo=None, publicidad_id=None):
        self.sexo = sexo
        self.publicidad_id = publicidad_id
