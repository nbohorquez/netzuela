# -*- coding: utf-8 -*-

from comunes import Base, DBSession
from rastreable import EsRastreable
from sqlalchemy import *
from sqlalchemy.orm import relationship, backref

class Estadisticas(EsRastreable, Base):
    __tablename__ = 'estadisticas'

    # Columnas
    """
    rastreable_p = Column(
        Integer, ForeignKey('rastreable.rastreable_id'), 
        nullable=False, unique=True, index=True
    )
    """
    estadisticas_id = Column(Integer, primary_key=True, autoincrement=True)
    territorio_id = Column(
        CHAR(16), ForeignKey('territorio.territorio_id'), nullable=False
    )
    tipo = Column(String(45), nullable=False)

    # Propiedades
    __mapper_args__ = {'polymorphic_on': tipo}
    territorio = relationship(
        "Territorio", backref="estadisticas",
        primaryjoin='Estadisticas.territorio_id == Territorio.territorio_id' 
    )
    
    def __init__(self, territorio_id=None, *args, **kwargs):
        super(Estadisticas, self).__init__(*args, **kwargs)
        self.territorio_id = territorio_id
        estadisticas_temporales = EstadisticasTemporales(
            self.estadisticas_id, 0, 0, 0
        )
        DBSession.add(estadisticas_temporales)

class EstadisticasTemporales(Base):
    __tablename__ = 'estadisticas_temporales'

    # Columnas
    estadisticas_id = Column(
        Integer, ForeignKey('estadisticas.estadisticas_id'), primary_key=True,
        autoincrement=False
    )
    fecha_inicio = Column(Numeric(17,3), primary_key=True, autoincrement=False)
    fecha_fin = Column(Numeric(17,3), nullable=True)
    contador = Column(Integer, nullable=False)
    ranking = Column(Integer, nullable=False)
    indice = Column(Integer, nullable=False)
    
    # Propiedades
    estadisticas = relationship(
        'Estadisticas', backref='estadisticas_temporales'
    )

    def __init__(self, estadisticas_id=None, contador=0, ranking=0, indice=0):
        estadisticas_temporales = EstadisticasTemporales.__table__
        ya = ahorita()
        
        expirar_stats_tmp_anteriores = estadisticas_temporales.update().\
        values(fecha_fin = func.IF(
            exists(estadisticas_temporales.select()), ya, fecha_fin
        )).where(and_(
            estadisticas_temporales.c.estadisticas_id == estadisticas_id,
            estadisticas_temporales.c.fecha_fin is None
        ))
        DBSession.execute(expirar_stats_tmp_anteriores)

        self.fecha_inicio = ya
        self.fecha_fin = None
        self.contador = contador
        self.ranking = ranking
        self.indice = indice

class EstadisticasDePopularidad(Estadisticas):
    __tablename__ = 'estadisticas_de_popularidad'
    __mapper_args__ = {'polymorphic_identity': 'estadisticas_de_popularidad'}

    # Columnas
    estadisticas_p = Column(
        Integer, ForeignKey('estadisticas.estadisticas_id'),
        nullable=False, unique=True, index=True        
    )
    estadisticas_de_popularidad_id = Column(
        Integer, primary_key=True, autoincrement=True
    )
    calificable_seguible_id = Column(
        Integer, ForeignKey('calificable_seguible.calificable_seguible_id'), 
        nullable=False
    )
    numero_de_calificaciones = Column(Integer, nullable=False)
    numero_de_resenas = Column(Integer, nullable=False)
    numero_de_seguidores = Column(Integer, nullable=False)
    numero_de_menciones = Column(Integer, nullable=False)
    numero_de_vendedores = Column(Integer)
    numero_de_mensajes = Column(Integer)

    # Propiedades
    calificable_seguible = relationship(
        'CalificableSeguible', backref='estadisticas_de_popularidad'
    )
    
    def __init__(self, calificable_seguible_id=None, *args, **kwargs):
        super(EstadisticasDePopularidad, self).__init__(*args, **kwargs)
        self.calificable_seguible_id = calificable_seguible_id
        self.numero_de_calificaciones = 0
        self.numero_de_resenas = 0
        self.numero_de_seguidores = 0
        self.numero_de_menciones = 0
        self.numero_de_vendedores = 0
        self.numero_de_mensajes = 0
    
class EstadisticasDeInfluencia(Estadisticas):
    __tablename__ = 'estadisticas_de_influencia'
    __mapper_args__ = {'polymorphic_identity': 'estadisticas_de_influencia'}

    # Columnas
    estadisticas_p = Column(
        Integer, ForeignKey('estadisticas.estadisticas_id'), nullable=False, 
        unique=True, index=True
    )
    estadisticas_de_influencia_id = Column(
        Integer, primary_key=True, autoincrement=True
    )
    palabra_id = Column(
        Integer, ForeignKey('palabra.palabra_id'), nullable=False
    )
    numero_de_descripciones = Column(Integer, nullable=False)
    numero_de_mensajes = Column(Integer, nullable=False)
    numero_de_categorias = Column(Integer, nullable=False)
    numero_de_resenas = Column(Integer, nullable=False)
    numero_de_publicidades = Column(Integer, nullable=False)

    # Propiedades
    palabra = relationship('Palabra', backref='estadisticas_de_influencia')
        
    def __init__(self, palabra_id=None, *args, **kwargs):
        super(EstadisticasDeInfluencia, self).__init__(*args, **kwargs)
        self.palabra_id = palabra_id
        self.numero_de_descripciones = 0
        self.numero_de_mensajes = 0
        self.numero_de_categorias = 0
        self.numero_de_resenas = 0
        self.numero_de_publicidades = 0

class EstadisticasDeVisitas(Estadisticas):
    __tablename__ = 'estadisticas_de_visitas'
    __mapper_args__ = {'polymorphic_identity': 'estadisticas_de_visitas'}

    # Columnas
    estadisticas_p = Column(
        Integer, ForeignKey('estadisticas.estadisticas_id'), nullable=False, 
        unique=True, index=True
    )
    estadisticas_de_visitas_id = Column(
        Integer, primary_key=True, autoincrement=True
    )
    buscable_id = Column(
        Integer, ForeignKey('buscable.buscable_id'), nullable=False
    )

    # Propiedades
    buscable = relationship('Buscable', backref='estadisticas_de_visitas')

    def __init__(self, buscable_id=None, *args, **kwargs):
        super(EstadisticasDeVisitas, self).__init__(*args, **kwargs)
        self.buscable_id = buscable_id
        contador_de_exhibiciones = ContadorDeExhibiciones(
            self.estadisticas_de_visitas_id, 0
        )
        DBSession.add(contador_de_exhibiciones)

class ContadorDeExhibiciones(Base):
    __tablename__ = 'contador_de_exhibiciones'

    # Columnas
    estadisticas_de_visitas_id = Column(
        Integer, 
        ForeignKey('estadisticas_de_visitas.estadisticas_de_visitas_id'),
        primary_key=True, autoincrement=False
    )
    fecha_inicio = Column(Numeric(17,3), primary_key=True, autoincrement=False)
    fecha_fin = Column(Numeric(17,3), nullable=True)
    valor = Column(Integer, nullable=False)
    
    # Propiedades
    estadisticas_de_visitas = relationship(
        'EstadisticasDeVisitas', backref='contadores_de_exhibiciones'
    )

    def __init__(self, estadisticas_de_visitas_id=None, valor=0):
        contador = ContadorDeExhibiciones.__table__
        ya = ahorita()
        
        expirar_contador_anterior = contador.update().\
        values(fecha_fin = func.IF(
            exists(contador.select()), ya, fecha_fin
        )).where(and_(
            contador.c.estadisticas_de_visitas_id == estadisticas_de_visitas_id,
            contador.c.fecha_fin is None
        ))
        DBSession.execute(expirar_contador_anterior)

        self.fecha_inicio = ya
        self.fecha_fin = None
        self.valor = valor
