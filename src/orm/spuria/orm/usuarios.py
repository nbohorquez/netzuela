# -*- coding: utf-8 -*-

from comunes import ahorita, Base, DBSession
from rastreable import EsRastreable
from descripciones_fotos import EsDescribible
from sqlalchemy import *
from sqlalchemy import event
from rastreable import Rastreable, RastreableAsociacion
from sqlalchemy.orm import relationship, backref
from datetime import timedelta

class Usuario(EsRastreable, EsDescribible, Base):
    __tablename__ = 'usuario'

    # Columnas
    usuario_id = Column(
        Integer, primary_key=True, autoincrement=True, index=True
    )
    nombre = Column(String(45), nullable=False)
    apellido = Column(String(45), nullable=False)
    estatus = Column(CHAR(9), ForeignKey('estatus.valor'), nullable=False)
    ubicacion_id = Column(
        CHAR(16), ForeignKey('territorio.territorio_id'), nullable=True
    )
    tipo = Column(String(45), nullable=False)

    # Propiedades
    __mapper_args__ = {
        'polymorphic_on': tipo, 
        'polymorphic_identity': 'usuario'
    }
    ubicacion = relationship(
        'Territorio', backref='usuarios',
        primaryjoin='Usuario.ubicacion_id==Territorio.territorio_id'
    )
    acceso = relationship(
        'Acceso', uselist=False,
        primaryjoin='Usuario.usuario_id == Acceso.acceso_id'
    )
    
    def __init__(self, nombre='', apellido='', estatus='Activo', 
                 ubicacion=None, correo_electronico=None, contrasena=None,
                 *args, **kwargs):
        super(Usuario, self).__init__(*args, **kwargs)
        self.nombre = nombre
        self.apellido = apellido
        self.estatus = estatus
        self.ubicacion = ubicacion
        self.acceso = Acceso(correo_electronico, contrasena)

class Acceso(Base):
    __tablename__ = 'acceso'

    # Columnas
    acceso_id = Column(
        Integer, ForeignKey('usuario.usuario_id'), primary_key=True,
        autoincrement=False
    )
    conectado = Column(Boolean, nullable=False)
    correo_electronico = Column(
        String(45), nullable=False, unique=True, index=True
    )
    contrasena = Column(VARBINARY(60), nullable=False)
    fecha_de_registro = Column(Numeric(17,3), nullable=False)
    fecha_de_ultimo_acceso = Column(Numeric(17,3), nullable=True)
    duracion_de_ultimo_acceso = Column(Interval, nullable=False)
    numero_total_de_accesos = Column(Integer, nullable=False)
    tiempo_total_de_accesos = Column(Interval, nullable=False)
    tiempo_promedio_por_acceso = Column(Interval, nullable=False)

    def __init__(self, correo_electronico=None, contrasena=None):
        #self.acceso_id = acceso_id
        self.conectado = False
        self.correo_electronico = correo_electronico
        self.contrasena = contrasena
        self.fecha_de_registro = ahorita()
        self.fecha_de_ultimo_acceso = None
        self.duracion_de_ultimo_acceso = timedelta(0)
        self.numero_total_de_accesos = 0
        self.tiempo_total_de_accesos = timedelta(0)
        self.tiempo_promedio_por_acceso = timedelta(0)

class Administrador(Usuario):
    __tablename__ = 'administrador'
    __mapper_args__ = {'polymorphic_identity': 'administrador'}

    # Columnas
    usuario_p = Column(
        Integer, ForeignKey('usuario.usuario_id'), nullable=False, unique=True,
        index=True
    )
    administrador_id = Column(Integer, primary_key=True, autoincrement=True)
    privilegios = Column(
        CHAR(7), ForeignKey('privilegios.valor'), nullable=False
    )

    def __init__(self, privilegios, *args, **kwargs):
        super(Administrador, self).__init__(*args, **kwargs)
        self.privilegios = privilegios

class Privilegios(Base):
    __tablename__ = 'privilegios'

    # Columnas
    valor = Column(CHAR(7), primary_key=True, autoincrement=False)

    # Propiedades
    administradores = relationship('Administrador')

    def __init__(self, valor=None):
        self.valor = valor
    
class Cliente(EsRastreable, EsDescribible, Base):
    __tablename__ = 'cliente'

    # Columnas
    rif = Column(CHAR(10), primary_key=True, autoincrement=False, index=True)
    propietario_id = Column(
        Integer, ForeignKey('usuario.usuario_id'), nullable=False
    )
    categoria_id = Column(
        CHAR(16), ForeignKey('categoria.categoria_id'), nullable=False
    )
    estatus = Column(
        CHAR(9), ForeignKey('estatus.valor'), nullable=False
    )
    nombre_legal = Column(String(45), unique=True, nullable=False, index=True)
    nombre_comun = Column(String(45))
    telefono = Column(CHAR(12), nullable=False, unique=True)
    edificio_cc = Column(CHAR(22))
    piso = Column(CHAR(12))
    apartamento = Column(CHAR(12))
    local_no = Column(CHAR(12))
    casa = Column(CHAR(20))
    calle = Column(CHAR(12), nullable=False)
    sector_urb_barrio = Column(CHAR(20), nullable=False)
    pagina_web = Column(CHAR(40))
    facebook = Column(CHAR(80))
    twitter = Column(CHAR(80))
    correo_electronico = Column(String(45))
    ubicacion_id = Column(
        CHAR(16), ForeignKey('territorio.territorio_id'), nullable=True
    )
    tipo = Column(String(45), nullable=False)

    # Propiedades
    __mapper_args__ = {'polymorphic_on': tipo}
    ubicacion = relationship(
        'Territorio', backref='clientes',
        primaryjoin='Cliente.ubicacion_id==Territorio.territorio_id'
    )
    propietario = relationship(
        'Usuario', primaryjoin='Cliente.propietario_id==Usuario.usuario_id',
        backref='propiedades'
    )

    def __init__(self, propietario=None, ubicacion=None, rif=None, 
                 categoria=None, estatus='Activo', nombre_legal=None,
                 nombre_comun='', telefono=None, edificio_cc='', piso='', 
                 apartamento='', local='', casa='', calle=None, 
                 sector_urb_barrio=None, pagina_web='', facebook='', twitter='',
                 correo_electronico_publico='', *args, **kwargs):
        if propietario is None:
            raise Exception('propietario no puede ser nulo')

        super(Cliente, self).__init__(
            creador=propietario.rastreable.rastreable_id, *args, **kwargs
        )
        self.propietario = propietario
        self.ubicacion = ubicacion
        self.rif = rif
        self.categoria = categoria
        self.estatus = estatus
        self.nombre_legal = nombre_legal
        self.nombre_comun = nombre_comun
        self.telefono = telefono
        self.edificio_cc = edificio_cc
        self.piso = piso
        self.apartamento = apartamento
        self.local = local
        self.casa = casa
        self.calle = calle
        self.sector_urb_barrio = sector_urb_barrio
        self.pagina_web = pagina_web
        self.facebook = facebook
        self.twitter = twitter
        self.correo_electronico_publico = correo_electronico_publico
