# -*- coding: utf-8 -*-

from comunes import Base, DBSession
from rastreable import EsRastreable
from croquis_puntos import EsDibujable
from sqlalchemy import *
from sqlalchemy.orm import relationship, backref

class Territorio(EsRastreable, EsDibujable, Base):
    __tablename__ = 'territorio'
    #__mapper_args__ = {'polymorphic_identity': 'territorio'}
    
    # Columnas  
    """
    rastreable_p = Column(
        Integer, ForeignKey('rastreable.rastreable_id'), nullable=False, 
        unique=True, index=True
    )
    dibujable_p = Column(
        Integer, ForeignKey('dibujable.dibujable_id'), nullable=False, 
        unique=True, index=True
    )
    """
    territorio_id = Column(
        CHAR(16), primary_key=True, autoincrement=False, index=True
    )
    nombre = Column(String(45), nullable=False)
    poblacion = Column(Integer, nullable=False)
    idioma = Column(CHAR(10), ForeignKey('idioma.valor'), nullable=True)
    nivel = Column(Integer)
    territorio_padre_id = Column(
        CHAR(16), ForeignKey('territorio.territorio_id'), nullable=False
    )
    consumidores_poblacion = Column(Float, nullable=False)
    tiendas_poblacion = Column(Float, nullable=False)
    tiendas_consumidores = Column(Float)
    codigo_postal = Column(CHAR(10))
    pib = Column(Numeric(15,0))

    # Propiedades
    territorios_hijos = relationship(
        'Territorio', 
        primaryjoin='Territorio.territorio_padre_id==Territorio.territorio_id',
        backref=backref(
            'territorio_padre', remote_side='Territorio.territorio_id'
        )
    )
    """
    idioma = relationship(
        'Idioma', backref='hablantes', 
        primaryjoin='Territorio.idioma==Idioma.valor'
    )
    """
    regiones = relationship(
        "Region", secondary=lambda:RegionTerritorio.__table__, 
        backref="territorios"
    )
    
    def __init__(self, nombre=None, poblacion=None, idioma='Espanol', 
                 territorio_padre_id=None, codigo_postal=None, pib=None):
        territorio = Territorio.__table__
        es_territorio_duplicado = DBSession.execute(
            exists().where(and_(
                territorio.c.nombre == nombre,
                territorio.c.territorio_padre_id == territorio_padre_id
            ))
        ).scalar()
        c = DBSession.query(Territorio).filter(
            Territorio.territorio_padre_id == territorio_padre_id
        ).count()
        nivel_padre = DBSession.execute(
            select([territorio.c.nivel]).\
            where(territorio.c.territorio_id == territorio_padre_id)
        )
        n = '{0:02X}'.format(c + 1)
        i = territorio_padre_id.find('00') + 2
        _id = territorio_padre_id[:i].replace('00', n) + territorio_padre_id[i:]

        #super(Territorio, self).__init__(*args, **kwargs)
        self.territorio_id = _id if not es_territorio_duplicado else None
        self.nombre = nombre
        self.poblacion = poblacion
        self.idioma = idioma
        self.nivel = nivel_padre + 1
        self.territorio_padre_id = territorio_padre_id
        self.consumidores_poblacion = 0
        self.tiendas_poblacion = 0
        self.tiendas_consumidores = None
        self.codigo_postal = codigo_postal
        self.pib = pib

class TiendasConsumidores(Base):
    __tablename__ = 'tiendas_consumidores'

    # Columnas
    territorio_id = Column(
        CHAR(16), ForeignKey('territorio.territorio_id'), primary_key=True,
        autoincrement=False
    )
    fecha_inicio = Column(Numeric(17,3), primary_key=True, autoincrement=False)
    fecha_fin = Column(Numeric(17,3), nullable=True)
    numero_de_consumidores = Column(Integer, nullable=False)
    numero_de_tiendas = Column(Integer, nullable=False)
    
    # Propiedades
    territorio = relationship(
        'Territorio', backref='poblacion_de_usuarios'
    )

    def __init__(self, territorio_id=None, numero_de_consumidores=0, 
                 numero_de_tiendas=0):
        tiendas_consumidores = TiendasConsumidores.__table__
        territorio = Territorio.__table__
        ya = ahorita()
        
        expirar_tnds_cnsms_anteriores = tiendas_consumidores.update().\
        values(fecha_fin = func.IF(
            exists(tiendas_consumidores.select()), ya, fecha_fin
        )).where(and_(
            tiendas_consumidores.c.territorio_id == territorio_id,
            tiendas_consumidores.c.fecha_fin is None
        ))
        DBSession.execute(expirar_tnds_cnsms_anteriores)

        self.territorio_id = territorio_id
        self.fecha_inicio = ya
        self.fecha_fin = None
        self.numero_de_tiendas = numero_de_tiendas
        self.numero_de_consumidores = numero_de_consumidores

        pob = select([territorio.c.poblacion]).\
        where(territorio.c.territorio_id == territorio_id)
        pob = DBSession.execute(pob).scalar()

        actualizar_territorio = territorio.update().values(
            consumidores_poblacion = func.IF(
                pob > 0, numero_de_consumidores/pob, 0
            ),
            tiendas_poblacion = func.IF(
                pob > 0, numero_de_tiendas/pob, 0
            ),
            tiendas_consumidores = func.IF(
                numero_de_consumidores > 0, 
                numero_de_tiendas/numero_de_consumidores, None
            )
        ).where(territorio.c.territorio_id == territorio_id)
        DBSession.execute(actualizar_territorio)

class Idioma(Base):
    __tablename__ = 'idioma'

    # Columnas
    valor = Column(CHAR(10), primary_key=True, autoincrement=True)
    
    def __init__(self, valor=None):
        self.valor = valor

class Region(Base):
    __tablename__ = 'region'

    # Columnas
    region_id = Column(Integer, primary_key=True, autoincrement=True)
    nombre = Column(String(45), nullable=False)

    def __init__(self, nombre=None):
        self.nombre = nombre

class RegionTerritorio(Base):
    __tablename__ = 'region_territorio'

    # Columnas
    region_id = Column(
        Integer, ForeignKey('region.region_id'), 
        primary_key=True, autoincrement=False
    )
    territorio_id = Column(
        CHAR(16), ForeignKey('territorio.territorio_id'), 
        primary_key=True, autoincrement=False
    )

    # Propiedades
    region = relationship('Region', backref='region_territorio')
    territorio = relationship('Territorio', backref='region_territorio')

    def __init__(self, region_id=None, territorio_id=None):
        self.region_id = region_id
        self.territorio_id = territorio_id
