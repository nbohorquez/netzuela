# -*- coding: utf-8 -*-

from comunes import ahorita, Base, DBSession
from sqlalchemy import Column, Integer, Numeric, Boolean, ForeignKey
from sqlalchemy.orm import relationship, backref

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
    __tablename__ = 'registro_id'
    
    # Columnas
    registro_id = Column(Integer, primary_key=True, autoincrement=True)
    fecha_hora = Column(Numeric(17,3), nullable=False)
    actor_activo = Column(Integer, nullable=False, index=True)
    accion = Column(CHAR(13), ForeignKey('accion.valor'), nullable=False)
    actor_pasivo = Column(Integer, nullable=True, index=True)
    columna = Column(Text)
    valor = Column(Text)

    # Propiedades
    actor_activo_x = relationship(
        "Rastreable", backref="registro_activo",
        primaryjoin="Registro.actor_activo == Rastreable.rastreable_id"
    )
    actor_pasivo_x = relationship(
        "Rastreable", backref="registro_pasivo",
        primaryjoin="Registro.actor_pasivo == Rastreable.rastreable_id"
    )
    
    def __init__(self, actor_activo=None, accion=None, actor_pasivo=None, 
                 columna='', valor=''):
        self.fecha_hora = ahorita()
        self.actor_activo = actor_activo
        self.accion = accion
        self.actor_pasivo = actor_pasivo
        self.columna = columna
        self.valor = valor
