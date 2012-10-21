# -*- coding: utf-8 -*-

from comunes import Base, DBSession
from palabras import EsEtiquetable
from sqlalchemy import *
from sqlalchemy.orm import relationship, backref

class Estatus(Base):
    __tablename__ = 'estatus'
    
    # Columnas
    valor = Column(CHAR(9), primary_key=True, autoincrement=False)
    
    def __init__(self, valor=None):
        self.valor = valor

class Categoria(EsEtiquetable, Base):
    __tablename__ = 'categoria'
    #__mapper_args__ = {'polymorphic_identity': 'categoria'}
    
    # Columnas
    """
    etiquetable_p = Column(
        Integer, ForeignKey('etiquetable.etiquetable_id'), nullable=False, 
        unique=True, index=True
    )
    """
    categoria_id = Column(CHAR(16), primary_key=True, autoincrement=False)
    nombre = Column(CHAR(30), nullable=False)
    hijo_de_categoria = Column(
        CHAR(16), ForeignKey('categoria.categoria_id'), nullable=False
    )
    nivel = Column(Integer, nullable=True)

    # Propiedades
    hijos = relationship(
        'Categoria', 
        primaryjoin='Categoria.hijo_de_categoria==Categoria.categoria_id',
        backref=backref('padre', remote_side='Categoria.categoria_id')
    )

    # 
    def __init__(self, nombre=None, hijo_de_categoria=None, *args, **kwargs):
        categoria = Categoria.__table__
        es_categoria_duplicada = DBSession.execute(
            exists().where(and_(
                categoria.c.nombre == nombre,
                categoria.c.hijo_de_categoria == hijo_de_categoria
            ))
        ).scalar()
        c = DBSession.query(Categoria).filter(
            Categoria.hijo_de_categoria == hijo_de_categoria
        ).count()
        nivel_padre = DBSession.execute(
            select([categoria.c.nivel]).\
            where(categoria.c.categoria_id == hijo_de_categoria)
        )
        n = '{0:02X}'.format(c + 1)
        i = hijo_de_categoria.find('00') + 2
        _id = hijo_de_categoria[:i].replace('00', n) + hijo_de_categoria[i:]

        #super(Categoria, self).__init__(*args, **kwargs)
        self.categoria_id = _id if not es_categoria_duplicada else None
        self.nombre = nombre
        self.hijo_de_categoria = hijo_de_categoria
        self.nivel = nivel_padre + 1
