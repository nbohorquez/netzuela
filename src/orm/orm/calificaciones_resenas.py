# -*- coding: utf-8 -*-

from comunes import Base, DBSession
from consumidores import Consumidor
from palabras import EsEtiquetable
from rastreable import EsRastreable
from sqlalchemy import *
from sqlalchemy.ext.associationproxy import association_proxy
from sqlalchemy.ext.declarative import declared_attr
from sqlalchemy.orm import relationship, backref

class CalificableSeguibleAsociacion(Base):
    __tablename__ = 'calificable_seguible_asociacion'

    # Columnas
    calificable_seguible_asociacion_id = Column(
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
        return lambda calificable_seguible:CalificableSeguibleAsociacion(
            calificable_seguible=calificable_seguible, 
            discriminante=discriminante
        )

class CalificableSeguible(Base):
    __tablename__ = 'calificable_seguible'

    # Columnas    
    calificable_seguible_id = Column(
        Integer, primary_key=True, autoincrement=True
    )
    asociacion_id = Column(
        Integer, ForeignKey('calificable_seguible_asociacion.calificable_seguible_asociacion_id')
    )
    calificacion_general = Column(Integer)

    # Propiedades
    asociacion = relationship(
        'CalificableSeguibleAsociacion', 
        backref=backref('calificable_seguible', uselist=False)
    )
    padre = association_proxy('asociacion', 'padre')
    seguidores = association_proxy('seguimientos', 'consumidor')
    calificadores = association_proxy('calificaciones_resenas','consumidor')

    def __init__(self, calificacion_general=0):
        self.calificacion_general = calificacion_general

class EsCalificableSeguible(object):
    @declared_attr
    def calificable_seguible_asociacion_id(cls):
        return Column(
            Integer, ForeignKey("calificable_seguible_asociacion.calificable_seguible_asociacion_id")
        )

    @declared_attr
    def calificable_seguible_asociacion(cls):
        discriminante = cls.__tablename__
        cls.calificable_seguible = association_proxy(
            'calificable_seguible_asociacion', 'calificable_seguible', 
            creator=CalificableSeguibleAsociacion.creador(discriminante)
        )
        return relationship(
            'CalificableSeguibleAsociacion', 
            backref=backref("{}_padre".format(discriminante), uselist=False)
        )

    def __init__(self, *args, **kwargs):
        super(EsCalificableSeguible, self).__init__(*args, **kwargs)
        self.calificable_seguible = CalificableSeguible()

class Calificacion(Base):
    __tablename__ = 'calificacion'

    # Columnas
    valor = Column(CHAR(4), primary_key=True, autoincrement=False)

    def __init__(self, valor=None):
        self.valor = valor

class CalificacionResena(EsRastreable, EsEtiquetable, Base):
    __tablename__ = 'calificacion_resena'
    
    # Columnas
    calificable_seguible_id = Column(
        Integer, ForeignKey('calificable_seguible.calificable_seguible_id'), 
        primary_key=True, autoincrement=False
    )
    consumidor_id = Column(
        Integer, ForeignKey('consumidor.consumidor_id'), 
        primary_key=True, autoincrement=False
    )
    calificacion = Column(
        CHAR(4), ForeignKey('calificacion.valor'), nullable=False
    )
    resena = Column(Text)

    # Propiedades
    calificable_seguible = relationship(
        'CalificableSeguible', backref='calificaciones_resenas'
    )
    consumidor = relationship('Consumidor', backref='calificaciones_resenas')

    def __init__(self, calificable_seguible=None, consumidor=None, 
                 calificacion='Bien', resena='', *args, **kwargs):
        super(CalificacionResena, self).__init__(
            creador=consumidor.rastreable.rastreable_id, *args, **kwargs
        )
        self.calificable_seguible = calificable_seguible
        self.consumidor = consumidor
        self.calificacion = calificacion
        self.resena = resena

class Seguimiento(EsRastreable, Base):
    __tablename__ = 'seguimiento'

    # Columnas
    consumidor_id = Column(
        Integer, ForeignKey('consumidor.consumidor_id'), 
        primary_key=True, autoincrement=False
    )
    calificable_seguible_id = Column(
        Integer,
        ForeignKey('calificable_seguible.calificable_seguible_id'), 
        primary_key=True, autoincrement=False
    )
    avisar_si = Column(String(45), nullable=False)

    # Propiedades
    calificable_seguible = relationship(
        'CalificableSeguible', backref='seguimientos'
    )
    consumidor = relationship('Consumidor', backref='seguimientos')

    def __init__(self, calificable_seguible=None, consumidor=None,
                 avisar_si='', *args, **kwargs):
        super(Seguimiento, self).__init__(
            creador=consumidor.rastreable.rastreable_id, *args, **kwargs
        )
        self.calificable_seguible = calificable_seguible
        self.consumidor = consumidor
        self.avisar_si = avisar_si
