# -*- coding: utf-8 -*-

from comunes import Base, DBSession
from sqlalchemy import Column, Integer, Numeric, Boolean, ForeignKey
from sqlalchemy.orm import relationship, backref

class Describible(Base):
    __tablename__ = 'describible'
    __mapper_args__ = {'polymorphic_on': tipo}

    # Columnas
    describible_id = Column(Integer, primary_key=True, autoincrement=True)
    tipo = Column(String(45), nullable=False)

class Foto(Base):
    __tablename__ = 'foto'

    # Columnas
    foto_id = Column(Integer, primary_key=True, autoincrement=True)
    ruta_de_foto = Column(CHAR(80), nullable=False)
    describible = Column(
        Integer, ForeignKey('describible.describible_id'), nullable=False
    )

    # Propiedades
    describle_x = relationship(
        "Describible", ForeignKey[describible], backref="fotos"
    )

    def __init__(self, ruta_de_foto=None, describible=None):
        self.ruta_de_foto = ruta_de_foto
        self.describible = describible

class Descripcion(Rastreable, Etiquetable):
    __tablename__ = 'descripcion'
    __mapper_args__ = {'polymorphic_identity': 'descripcion'}

    # Columnas
    rastreable_p = Column(
        Integer, nullable=False, unique=True, index=True
        ForeignKey('rastreable.rastreable_id')
    )
    etiquetable_p = Column(
        Integer, nullable=False, unique=True, index=True
        ForeignKey('etiquetable.etiquetable_id')
    )
    describible_id = Column(Integer, primary_key=True, autoincrement=True)
    describible = Column(
        Integer, ForeignKey('describible.describible_id'), nullable=False
    )
    contenido = Column(Text, nullable=False)

    # Propiedades
    describle_x = relationship(
        "Describible", ForeignKey[describible], backref="descripciones"
    )

    def __init__(self, describible=None, contenido='', *args, **kwargs)
        super(Descripcion, self).__init__(*args, **kwargs)
        self.describible = describible
        self.contenido = contenido
