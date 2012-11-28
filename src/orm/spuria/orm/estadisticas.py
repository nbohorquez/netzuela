# -*- coding: utf-8 -*-

from comunes import Base, DBSession, ahorita
from rastreable import EsRastreable
from sqlalchemy import *
from sqlalchemy.orm import relationship, backref

class Estadisticas(EsRastreable, Base):
    __tablename__ = 'estadisticas'

    # Columnas
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
    
    def __init__(self, territorio=None, *args, **kwargs):
        super(Estadisticas, self).__init__(
            creador=territorio.rastreable.rastreable_id, *args, **kwargs
        )
        self.territorio = territorio
        self.estadisticas_temporales.append(EstadisticasTemporales(0, 0, 0))

class EstadisticasTemporales(Base):
    __tablename__ = 'estadisticas_temporales'

    # Columnas
    estadisticas_id = Column(
        Integer, ForeignKey('estadisticas.estadisticas_id'), primary_key=True,
        autoincrement=False
    )
    fecha_inicio = Column(Numeric(20,6), primary_key=True, autoincrement=False)
    fecha_fin = Column(Numeric(20,6), nullable=True)
    contador = Column(Integer, nullable=False)
    ranking = Column(Integer, nullable=False)
    indice = Column(Integer, nullable=False)
    
    # Propiedades
    estadisticas = relationship(
        'Estadisticas', backref='estadisticas_temporales'
    )

    # Metodos
    @staticmethod
    def antes_de_insertar(mapper, connection, target):
        estadisticas_temporales = EstadisticasTemporales.__table__
        estadisticas_temporales_alias = estadisticas_temporales.alias()
        
        expirar_stats_tmp_anteriores = estadisticas_temporales.update().\
        values(
            fecha_fin = func.IF(
                select(
                    [func.count('*')], 
                    from_obj=[estadisticas_temporales_alias]
                ) > 0, 
                ahorita(), estadisticas_temporales.c.fecha_fin
            )
        ).where(and_(
            estadisticas_temporales.c.estadisticas_id == target.estadisticas_id,
            estadisticas_temporales.c.fecha_fin == None
        ))
        DBSession.execute(expirar_stats_tmp_anteriores)

    def __init__(self, contador=0, ranking=0, indice=0):
        self.fecha_inicio = ahorita()
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
    
    def __init__(self, numero_de_calificaciones=0, numero_de_resenas=0,
                 numero_de_seguidores=0, numero_de_menciones=0, 
                 numero_de_vendedores=0, numero_de_mensajes=0, *args, **kwargs):
        super(EstadisticasDePopularidad, self).__init__(*args, **kwargs)
        #self.calificable_seguible_id = calificable_seguible_id
        self.numero_de_calificaciones = numero_de_calificaciones
        self.numero_de_resenas = numero_de_resenas
        self.numero_de_seguidores = numero_de_seguidores
        self.numero_de_menciones = numero_de_menciones
        self.numero_de_vendedores = numero_de_vendedores
        self.numero_de_mensajes = numero_de_mensajes
    
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
        
    def __init__(self, numero_de_descripciones=0, numero_de_mensajes=0,
                 numero_de_categorias=0, numero_de_resenas=0, 
                 numero_de_publicidades=0, *args, **kwargs):
        super(EstadisticasDeInfluencia, self).__init__(*args, **kwargs)
        #self.palabra_id = palabra_id
        self.numero_de_descripciones = numero_de_descripciones
        self.numero_de_mensajes = numero_de_mensajes
        self.numero_de_categorias = numero_de_categorias
        self.numero_de_resenas = numero_de_resenas
        self.numero_de_publicidades = numero_de_publicidades

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

    def __init__(self, *args, **kwargs):
        super(EstadisticasDeVisitas, self).__init__(*args, **kwargs)
        #self.buscable_id = buscable_id
        self.contadores_de_exhibiciones.append(ContadorDeExhibiciones(0))
        #DBSession.add(contador_de_exhibiciones)

class ContadorDeExhibiciones(Base):
    __tablename__ = 'contador_de_exhibiciones'

    # Columnas
    estadisticas_de_visitas_id = Column(
        Integer, 
        ForeignKey('estadisticas_de_visitas.estadisticas_de_visitas_id'),
        primary_key=True, autoincrement=False
    )
    fecha_inicio = Column(Numeric(20,6), primary_key=True, autoincrement=False)
    fecha_fin = Column(Numeric(20,6), nullable=True)
    valor = Column(Integer, nullable=False)
    
    # Propiedades
    estadisticas_de_visitas = relationship(
        'EstadisticasDeVisitas', backref='contadores_de_exhibiciones'
    )

    # Metodos
    @staticmethod
    def antes_de_insertar(mapper, connection, target):
        contador = ContadorDeExhibiciones.__table__
        contador_alias = contador.alias()
        
        expirar_contador_anterior = contador.update().\
        values(
            fecha_fin = func.IF(
                select(
                    [func.count('*')], 
                    from_obj=[contador_alias]
                ) > 0, 
                ahorita(), contador.c.fecha_fin
            )
        ).where(and_(
            contador.c.estadisticas_de_visitas_id == 
                target.estadisticas_de_visitas_id,
            contador.c.fecha_fin == None
        ))
        DBSession.execute(expirar_contador_anterior)

    def __init__(self, valor=0):
        self.fecha_inicio = ahorita()
        self.fecha_fin = None
        self.valor = valor
