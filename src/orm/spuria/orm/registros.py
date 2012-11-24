# -*- coding: utf-8 -*-

from comunes import ahorita, Base
from sqlalchemy import *
from sqlalchemy.orm import  relationship, backref

class Accion(Base):
    __tablename__ = 'accion'

    # Columnas
    valor = Column(CHAR(13), primary_key=True, autoincrement=False)

    def __init__(self, valor=None):
        self.valor = valor

class CodigoDeError(Base):
    __tablename__ = 'codigo_de_error'

    # Columnas
    valor = Column(CHAR(40), primary_key=True, autoincrement=False)

    def __init__(self, valor=None):
        self.valor = valor

class Registro(Base):
    __tablename__ = 'registro'
    
    # Columnas
    registro_id = Column(Integer, primary_key=True, autoincrement=True)
    fecha_hora = Column(Numeric(17,3), nullable=False)
    actor_activo_id = Column(Integer, nullable=False, index=True)
    accion = Column(CHAR(13), ForeignKey('accion.valor'), nullable=False)
    actor_pasivo_id = Column(Integer, nullable=True, index=True)
    detalles = Column(Text, nullable=True)

    # Propiedades
    actor_activo = relationship(
        "Rastreable", backref="registro_activo", 
		foreign_keys='Registro.actor_activo_id',
        primaryjoin="Registro.actor_activo_id == Rastreable.rastreable_id"
    )
    actor_pasivo = relationship(
        "Rastreable", backref="registro_pasivo",
		foreign_keys='Registro.actor_pasivo_id',
        primaryjoin="Registro.actor_pasivo_id == Rastreable.rastreable_id"
    )
    
    def __init__(self, actor_activo=None, accion=None, actor_pasivo=None, 
                 detalles=''):
        self.fecha_hora = ahorita()
        self.actor_activo = actor_activo
        self.accion = accion
        self.actor_pasivo = actor_pasivo
        self.detalles = detalles
