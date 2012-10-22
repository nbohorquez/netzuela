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
    #tipo = Column(String(45), nullable=False)

    # Propiedades
    #__mapper_args__ = {'polymorphic_on': tipo}
    asociacion = relationship(
        'CalificableSeguibleAsociacion', 
        backref=backref('calificable_seguible', uselist=False)
    )
    padre = association_proxy('asociacion', 'padre')
    seguidores = relationship(
        "Consumidor", secondary=lambda:Seguidor.__table__, 
        backref="seguidos"
    )
    calificadores = relationship(
        "Consumidor", secondary=lambda:CalificacionResena.__table__,
        backref="calificados"
    )

    def __init__(self, calificable_seguible_id=None, calificacion_general=0):
        self.calificable_seguible_id = calificable_seguible_id
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
    #__mapper_args__ = {'polymorphic_identity': 'calificacion_resena'}
    
    # Columnas
    """
    rastreable_p = Column(
        Integer, ForeignKey('rastreable.rastreable_id'), nullable=False, 
        unique=True, index=True
    )
    etiquetable_p = Column(
        Integer, ForeignKey('etiquetable.etiquetable_id'), nullable=False, 
        unique=True, index=True
    )
    """
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

    def __init__(self, calificable_seguible_id=None, consumidor_id=None,
                 calificacion='Bien', resena=''):
        #super(CalificacionResena, self).__init__(*args, **kwargs)
        self.calificable_seguible_id = calificable_seguible_id
        self.consumidor_id = consumidor_id
        self.calificacion = calificacion
        self.resena = resena

class Seguidor(EsRastreable, Base):
    __tablename__ = 'seguidor'
    #__mapper_args__ = {'polymorphic_identity': 'seguidor'}

    # Columnas
    """
    rastreable_p = Column(
        Integer, ForeignKey('rastreable.rastreable_id'), nullable=False, 
        unique=True, index=True
    )
    """
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

    def __init__(self, calificable_seguible_id=None, consumidor_id=None,
                 avisar_si=''):
        #super(Seguidor, self).__init__(*args, **kwargs)
        self.calificable_seguible_id = calificable_seguible_id
        self.consumidor_id = consumidor_id
        self.avisar_si = avisar_si
