# -*- coding: utf-8 -*-

from comunes import Base, DBSession
from palabras import EsEtiquetable
from rastreable import EsRastreable
from sqlalchemy import *
from sqlalchemy.ext.associationproxy import association_proxy
from sqlalchemy.ext.declarative import declared_attr
from sqlalchemy.orm import relationship, backref

class DescribibleAsociacion(Base):
    __tablename__ = 'describible_asociacion'

    # Columnas
    describible_asociacion_id = Column(
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
        return lambda describible:DescribibleAsociacion(
            describible=describible, discriminante=discriminante
        )

class Describible(Base):
    __tablename__ = 'describible'

    # Columnas
    describible_id = Column(Integer, primary_key=True, autoincrement=True)
    asociacion_id = Column(
        Integer, ForeignKey('describible_asociacion.describible_asociacion_id')
    )
    #tipo = Column(String(45), nullable=False)

	# Propiedades
    asociacion = relationship(
        'DescribibleAsociacion', backref=backref('describible', uselist=False)
    )
    padre = association_proxy('asociacion', 'padre')
    #__mapper_args__ = {'polymorphic_on': tipo}

class EsDescribible(object):
    @declared_attr
    def describible_asociacion_id(cls):
        return Column(
            Integer, 
            ForeignKey("describible_asociacion.describible_asociacion_id")
        )

    @declared_attr
    def describible_asociacion(cls):
        discriminante = cls.__tablename__
        cls.describible = association_proxy(
            'describible_asociacion', 'describible', 
            creator=DescribibleAsociacion.creador(discriminante)
        )
        return relationship(
            'DescribibleAsociacion', backref=backref(
                "{}_padre".format(discriminante), uselist=False
            )
        )

class Foto(Base):
    __tablename__ = 'foto'

    # Columnas
    foto_id = Column(Integer, primary_key=True, autoincrement=True)
    ruta_de_foto = Column(CHAR(80), nullable=False)
    describible_id = Column(
        Integer, ForeignKey('describible.describible_id'), nullable=False
    )

    # Propiedades
    describle = relationship('Describible', backref='fotos')

    def __init__(self, ruta_de_foto=None, describible_id=None):
        self.ruta_de_foto = ruta_de_foto
        self.describible_id = describible_id

class Descripcion(EsRastreable, EsEtiquetable, Base):
    __tablename__ = 'descripcion'
    #__mapper_args__ = {'polymorphic_identity': 'descripcion'}

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
    descripcion_id = Column(Integer, primary_key=True, autoincrement=True)
    describible_id = Column(
        Integer, ForeignKey('describible.describible_id'), nullable=False
    )
    contenido = Column(Text, nullable=False)

    # Propiedades
    describle = relationship("Describible", backref="descripciones")

    def __init__(self, describible_id=None, contenido=''):
        #super(Descripcion, self).__init__(*args, **kwargs)
        self.describible_id = describible_id
        self.contenido = contenido
