# -*- coding: utf-8 -*-

from comunes import Base, DBSession
from mensajes import EsInterlocutor
from rastreable import EsRastreable
from sqlalchemy import *
from sqlalchemy.ext.associationproxy import association_proxy
from sqlalchemy.orm import relationship, backref
from usuarios import Usuario

class GradoDeInstruccion(Base):
    __tablename__ = 'grado_de_instruccion'
    
    # Columnas
    valor = Column(CHAR(16), primary_key=True, autoincrement=False)
    orden = Column(Integer, nullable=False, unique=True)

    # Propiedades
    consumidores = relationship('Consumidor')

    def __init__(self, valor=None, orden=None):
        self.valor = valor
        self.orden = orden

class GrupoDeEdad(Base):
    __tablename__ = 'grupo_de_edad'
    
    # Columnas
    valor = Column(CHAR(15), primary_key=True, autoincrement=False)

    # Propiedades
    consumidores = relationship('Consumidor')

    def __init__(self, valor=None):
        self.valor = valor

class Sexo(Base):
    __tablename__ = 'sexo'
    
    # Columnas
    valor = Column(CHAR(6), primary_key=True, autoincrement=False)

    # Propiedades
    consumidores = relationship('Consumidor')

    def __init__(self, valor=None):
        self.valor = valor

class Consumidor(EsInterlocutor, Usuario):
    __tablename__ = 'consumidor'
    __mapper_args__ = {'polymorphic_identity': 'consumidor'}
    
    # Columnas
    usuario_p = Column(
        Integer, ForeignKey('usuario.usuario_id'), nullable=False, unique=True,
		index=True
    )
    consumidor_id = Column(Integer, primary_key=True, autoincrement=True)
    sexo = Column(
        CHAR(6), ForeignKey('sexo.valor'), nullable=False
    )
    fecha_de_nacimiento = Column(Date, nullable=False)
    grupo_de_edad = Column(
        CHAR(15), ForeignKey('grupo_de_edad.valor'), nullable=False
    )
    grado_de_instruccion = Column(
        CHAR(16), ForeignKey('grado_de_instruccion.valor'), nullable=False
    )

    # Propiedades
    calificados = association_proxy(
        'calificaciones_resenas', 'calificable_seguible'
    )
    seguidos = association_proxy('seguimientos', 'calificable_seguible')

    def __init__(self, sexo=None, fecha_de_nacimiento=None, grupo_de_edad=None,
                 grado_de_instruccion=None, *args, **kwargs):
        super(Consumidor, self).__init__(*args, **kwargs)
        self.sexo = sexo
        self.fecha_de_nacimiento = fecha_de_nacimiento
        self.grupo_de_edad = grupo_de_edad
        self.grado_de_instruccion = grado_de_instruccion
