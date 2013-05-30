# -*- coding: utf-8 -*

from comunes import Base, DBSession, fecha_hora_a_mysql
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

    # Propiedades
    asociacion = relationship(
        'CobrableAsociacion', backref=backref('cobrable', uselist=False)
    )
    padre = association_proxy('asociacion', 'padre')
    facturas = association_proxy('servicios_vendidos', 'factura')

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

    def __init__(self, *args, **kwargs):
        super(EsCobrable, self).__init__(*args, **kwargs)
        self.cobrable = Cobrable()

class Factura(EsRastreable, Base):
    __tablename__ = 'factura'
    
    # Columnas
    factura_id = Column(Integer, primary_key=True, autoincrement=True)
    cliente_id = Column(CHAR(10), ForeignKey('cliente.rif'), nullable=False)
    inicio_de_medicion = Column(Numeric(20,6), nullable=False)
    fin_de_medicion = Column(Numeric(20,6), nullable=False)
    subtotal = Column(Numeric, nullable=False)
    impuestos = Column(Numeric, nullable=False)
    total = Column(Numeric, nullable=False)

    # Propiedades
    cliente = relationship(
        'Cliente', primaryjoin='Factura.cliente_id==Cliente.rif', 
        backref='facturas'
    )
    cobrables = association_proxy('servicios_vendidos', 'cobrable')

    def __init__(self, cliente=None, inicio_de_medicion=None, 
                 fin_de_medicion=None, *args, **kwargs):
        super(Factura, self).__init__(
            creador=cliente.rastreable.rastreable_id,*args, **kwargs
        )
        self.cliente = cliente
        self.inicio_de_medicion = fecha_hora_a_mysql(inicio_de_medicion)
        self.fin_de_medicion = fecha_hora_a_mysql(fin_de_medicion)
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

    def __init__(self, factura=None, cobrable=None, acumulado=0):
        self.factura = factura
        self.cobrable = cobrable
        self.acumulado = acumulado
