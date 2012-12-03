# -*- coding: utf-8 -*-

from comunes import ahorita, Base, DBSession
from sqlalchemy import Column, Integer, Numeric, String, ForeignKey
from sqlalchemy.orm import relationship, backref
from sqlalchemy.ext.declarative import declared_attr
from sqlalchemy.ext.associationproxy import association_proxy

class RastreableAsociacion(Base):
    __tablename__ = 'rastreable_asociacion'

    # Columnas
    rastreable_asociacion_id = Column(
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
        return lambda rastreable:RastreableAsociacion(
            rastreable=rastreable, discriminante=discriminante
        )

class Rastreable(Base):
    __tablename__ = 'rastreable'

    # Columnas
    rastreable_id = Column(
        Integer, primary_key=True, autoincrement=True, index=True
    )
    asociacion_id = Column(
        Integer, ForeignKey('rastreable_asociacion.rastreable_asociacion_id')
    )
    fecha_de_creacion = Column(Numeric(20,6), nullable=False)
    creado_por = Column(Integer, nullable=False)
    fecha_de_modificacion = Column(Numeric(20,6), nullable=False)
    modificado_por = Column(Integer, nullable=False)
    fecha_de_eliminacion = Column(Numeric(20,6), nullable=True)
    eliminado_por = Column(Integer, nullable=True)
    fecha_de_acceso = Column(Numeric(20,6), nullable=False)
    accesado_por = Column(Integer, nullable=False)

    # Propiedades
    # asociacion = relationship('RastreableAsociacion', backref='rastreable')
    asociacion = relationship(
        'RastreableAsociacion', backref=backref('rastreable', uselist=False)
    )
    padre = association_proxy('asociacion', 'padre')
    """
    creado_por_x = relationship(
        "Rastreable", backref="entidades_creadas_x",
        primaryjoin="Rastreable.creado_por == Rastreable.rastreable_id"
    )
    modificado_por_x = relationship(
        "Rastreable", backref="entidades_modificadas_x",
        primaryjoin="Rastreable.modificado_por == Rastreable.rastreable_id"
    )
    eliminado_por_x = relationship(
        "Rastreable", backref="entidades_eliminadas_x",
        primaryjoin="Rastreable.eliminado_por == Rastreable.rastreable_id"
    )
    accesado_por_x = relationship(
        "Rastreable", backref="entidades_accesadas_x",
        primaryjoin="Rastreable.eliminado_por == Rastreable.rastreable_id"
    )
    """
    def __init__(self, creador=None):
        ya = ahorita()
        self.fecha_de_creacion = ya
        self.creado_por = creador
        self.fecha_de_modificacion = ya
        self.modificado_por = creador
        self.fecha_de_eliminacion = None
        self.eliminado_por = None
        self.fecha_de_acceso = ya
        self.accesado_por = creador

class EsRastreable(object):
    @declared_attr
    def rastreable_asociacion_id(cls):
        return Column(
            Integer, 
            ForeignKey("rastreable_asociacion.rastreable_asociacion_id")
        )

    @declared_attr
    def rastreable_asociacion(cls):
        discriminante = cls.__tablename__
        cls.rastreable = association_proxy(
            'rastreable_asociacion', 'rastreable', 
            creator=RastreableAsociacion.creador(discriminante)
        )
        return relationship(
            'RastreableAsociacion', backref=backref(
                "{}_padre".format(discriminante), uselist=False
            )
        )
    
    def __init__(self, creador=None, *args, **kwargs):
        super(EsRastreable, self).__init__(*args, **kwargs)
        self.rastreable = Rastreable(creador)
