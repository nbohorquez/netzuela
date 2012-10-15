# -*- coding: utf-8 -*-

from comunes import ahorita, Base, DBSession
from sqlalchemy import Column, Integer, Numeric, Boolean, ForeignKey
from sqlalchemy.orm import relationship, backref

class Rastreable(Base):
    __tablename__ = 'rastreable'

    # Columnas
    rastreable_id = Column(Integer, primary_key=True, autoincrement=True)
    fecha_de_creacion = Column(Numeric(17,3), nullable=False)
    creado_por = Column(Integer, nullable=False)
    fecha_de_modificacion = Column(Numeric(17,3), nullable=False)
    modificado_por = Column(Integer, nullable=False)
    fecha_de_eliminacion = Column(Numeric(17,3), nullable=True)
    eliminado_por = Column(Integer, nullable=True)
    fecha_de_acceso = Column(Numeric(17,3), nullable=False)
    accesado_por = Column(Integer, nullable=False)

    # Propiedades
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
