# -*- coding: utf-8 -*-

from comunes import Base, DBSession
from sqlalchemy import Column, Integer, ForeignKey
from sqlalchemy.orm import relationship, backref

class CalificableSeguible(Base):
    __tablename__ = 'calificable_seguible'
    __mapper_args__ = {'polymorphic_on': tipo}

    # Columnas    
    calificable_seguible_id = Column(
        Integer, primary_key=True, autoincrement=True
    )
    calificacion_general = Column(Integer)
    tipo = Column(String(45), nullable=False)

    # Propiedades
    calificadores_seguidores = relationship(
        "Consumidor", secondary=CalificacionesResenas.__table__, 
        backref="calificados_seguidos"
    )

    def __init__(self, calificable_seguible_id=None, calificacion_general=0):
        self.calificable_seguible_id = calificable_seguible_id
        self.calificacion_general = calificacion_general

class Calificacion(Base):
    __tablename__ = 'calificacion'
    valor = Column(CHAR(4), primary_key=True)

    def __init__(self, valor=None):
        self.valor = valor

class CalificacionResena(Rastreable, Etiquetable):
    __tablename__ = 'calificacion_resena'
    __mapper_args__ = {'polymorphic_identity': 'calificacion_resena'}
    
    # Columnas
    rastreable_p = Column(
        Integer, nullable=False, unique=True, index=True
        ForeignKey('rastreable.rastreable_id')
    )
    etiquetable_p = Column(
        Integer, nullable=False, unique=True, index=True
        ForeignKey('etiquetable.etiquetable_id')
    )
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
    consumidor_x = relationship("Consumidor", backref="calificaciones_resenas")
    calificable_seguible_x = relationship(
        "CalificableSeguible", backref="calificaciones_resenas"
    )

    def __init__(self, calificable_seguible_id=None, consumidor_id=None,
                 calificacion='Bien', resena='',  *args, **kwargs):
        super(CalificacionResena, self).__init__(*args, **kwargs)
        self.calificable_seguible_id = calificable_seguible_id
        self.consumidor_id = consumidor_id
        self.calificacion = calificacion
        self.resena = resena
