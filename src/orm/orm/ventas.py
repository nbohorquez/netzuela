# -*- coding: utf-8 -*

from comunes import Base, DBSession
from rastreable import EsRastreable
from sqlalchemy import *
from sqlalchemy.ext.associationproxy import association_proxy
from sqlalchemy.ext.declarative import declared_attr
from sqlalchemy.orm import relationship, backref

class CobrableAsociacion(Base):
    __tablename__ = 'cobrable_asociacion'

    # Columnas
    cobrable_asociacion_id = Column(
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
        return lambda cobrable:CobrableAsociacion(
            cobrable=cobrable, discriminante=discriminante
        )

class Cobrable(Base):
    __tablename__ = 'cobrable'

    # Columnas
    cobrable_id = Column(Integer, primary_key=True, autoincrement=True)
    asociacion_id = Column(
        Integer, ForeignKey('cobrable_asociacion.cobrable_asociacion_id')
    )
    #tipo = Column(String(45), nullable=False)

	# Propiedades
    asociacion = relationship(
        'CobrableAsociacion', backref=backref('cobrable', uselist=False)
    )
    padre = association_proxy('asociacion', 'padre')
    #__mapper_args__ = {'polymorphic_on': tipo}

class EsCobrable(object):
    @declared_attr
    def cobrable_asociacion_id(cls):
        return Column(
            Integer, 
            ForeignKey('cobrable_asociacion.cobrable_asociacion_id')
        )

    @declared_attr
    def cobrable_asociacion(cls):
        discriminante = cls.__tablename__
        cls.cobrable = association_proxy(
            'cobrable_asociacion', 'cobrable', 
            creator=CobrableAsociacion.creador(discriminante)
        )
        return relationship(
            'CobrableAsociacion', backref=backref(
                "{}_padre".format(discriminante), uselist=False
            )
        )

class Factura(EsRastreable, Base):
    __tablename__ = 'factura'
    #__mapper_args__ = {'polymorphic_identity': 'factura'}
    
    # Columnas
    """
    rastreable_p = Column(
        Integer, ForeignKey('rastreable.rastreable_id'), nullable=False, 
		unique=True, index=True
    )
    """
    factura_id = Column(Integer, primary_key=True, autoincrement=True)
    cliente_id = Column(CHAR(10), ForeignKey('cliente.rif'), nullable=False)
    inicio_de_medicion = Column(Numeric(17,3), nullable=False)
    fin_de_medicion = Column(Numeric(17,3), nullable=False)
    subtotal = Column(Numeric, nullable=False)
    impuestos = Column(Numeric, nullable=False)
    total = Column(Numeric, nullable=False)

    # Propiedades
    cliente = relationship(
		'Cliente', primaryjoin='Factura.cliente_id==Cliente.rif', 
		backref='facturas'
	)
    cobrables = relationship(
        "Cobrable", secondary=lambda:ServicioVendido.__table__, 
        backref="facturas"
    )

    def __init__(self, cliente_id=None, inicio_de_medicion=None, 
                 fin_de_medicion=None):
        #super(Factura, self).__init__(*args, **kwargs)
        self.cliente_id = cliente_id
        self.inicio_de_medicion = inicio_de_medicion
        self.fin_de_medicion = fin_de_medicion
        self.subtotal = 0
        self.impuestos = 0
        self.total = 0
    
class ServicioVendido(Base):
    __tablename__ = 'servicio_vendido'

    # Columnas
    factura_id = Column(
        Integer, ForeignKey('factura.factura_id'), 
        primary_key=True, autoincrement=False
    )
    cobrable_id = Column(
        Integer, ForeignKey('cobrable.cobrable_id'), 
        primary_key=True, autoincrement=False
    )
    acumulado = Column(Numeric, nullable=False)

    # Propiedades
    factura = relationship('Factura', backref='servicios_vendidos')
    cobrable = relationship('Cobrable', backref='servicios_vendidos')

    def __init__(self, factura_id=None, cobrable_id=None):
        self.factura_id = factura_id
        self.cobrable_id = cobrable_id
        self.acumulado = 0
