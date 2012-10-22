# -*- coding: utf-8 -*-

from comunes import ahorita, Base, CreateView, DBSession
from rastreable import EsRastreable
from ventas import EsCobrable
from descripciones_fotos import EsDescribible
from busquedas import EsBuscable
from calificaciones_resenas import EsCalificableSeguible
from usuarios import Cliente
from croquis_puntos import EsDibujable
from mensajes import EsInterlocutor
from sqlalchemy import *
from sqlalchemy.orm import relationship, backref

class TipoDeCodigo(Base):
    __tablename__ = 'tipo_de_codigo'

    # Columnas
    valor = Column(CHAR(7), primary_key=True)

    def __init__(self, valor=None):
        self.valor = valor

class Visibilidad(Base):
    __tablename__ = 'visibilidad'
 
    # Columnas
    valor = Column(CHAR(16), primary_key=True)

    def __init__(self, valor=None):
        self.valor = valor

class PrecioCantidad(Base):
    __tablename__ = 'precio_cantidad'

    # Columnas
    tienda_id = Column(
        Integer, ForeignKey('inventario.tienda_id'), primary_key=True,
        autoincrement=False
    )
    codigo = Column(
        CHAR(15), ForeignKey('inventario.codigo'), primary_key=True,
        autoincrement=False
    )
    fecha_inicio = Column(Numeric(17,3), primary_key=True, autoincrement=False)
    fecha_fin = Column(Numeric(17,3))
    precio = Column(Numeric(10,2), nullable=False)
    cantidad = Column(Numeric(9,3), nullable=False)

    def __init__(self, tienda_id=None, codigo=None, precio=0, cantidad=0):
        precio_cantidad = PrecioCantidad.__table__
        ya = ahorita()
        
        expirar_precio_cantidad_anterior = precio_cantidad.update().\
        values(fecha_fin = func.IF(
            exists(precio_cantidad.select()), ya, fecha_fin
        )).where(and_(
            precio_cantidad.c.tienda_id == tienda_id,
            precio_cantidad.c.codigo == codigo,
            precio_cantidad.c.fecha_fin is None
        ))
        DBSession.execute(expirar_precio_cantidad_anterior)

        self.tienda_id = tienda_id
        self.fecha_inicio = ya
        self.fecha_fin = None
        self.codigo = codigo
        self.precio = precio
        self.cantidad = cantidad

class Tamano(Base):
    __tablename__ = 'tamano'

    # Columnas
    tienda_id = Column(
        Integer, ForeignKey('tienda.tienda_id'), primary_key=True,
        autoincrement=False
    )
    fecha_inicio = Column(Numeric(17,3), primary_key=True, autoincrement=False)
    fecha_fin = Column(Numeric(17,3))
    numero_total_de_productos = Column(Integer, nullable=False)
    cantidad_total_de_productos = Column(Integer)
    valor = Column(Integer)

    def __init__(self, tienda_id=None, numero_total_de_productos=0,
                 cantidad_total_de_productos=None, valor=0):
        tamano = Tamano.__table__
        ya = ahorita()
        
        expirar_tamano_anterior = tamano.update().\
        values(fecha_fin = func.IF(
            exists(tamano.select()), ya, fecha_fin
        )).where(and_(
            tamano.c.tienda_id == tienda_id,
            tamano.c.fecha_fin is None
        ))
        DBSession.execute(expirar_tamano_anterior)

        self.tienda_id = tienda_id
        self.fecha_inicio = ahorita()
        self.fecha_fin = None
        self.numero_total_de_productos = numero_total_de_productos
        self.cantidad_total_de_productos = cantidad_total_de_productos
        self.valor = valor

class Dia(Base):
    __tablename__ = 'dia'

    # Columnas
    valor = Column(CHAR(9), primary_key=True)
    orden = Column(Integer, nullable=False, index=True, unique=True)

    def __init__(self, valor=None, orden=0):
        self.valor = valor
        self.orden = orden

class Turno(Base):
    __tablename__ = 'turno'

    # Columnas
    tienda_id = Column(
        Integer, ForeignKey('horario_de_trabajo.tienda_id'), 
        primary_key=True, autoincrement=False
    )
    dia = Column(
        CHAR(9), ForeignKey('horario_de_trabajo.dia'), primary_key=True
    )
    hora_de_apertura = Column(Time, primary_key=True)
    hora_de_cierre = Column(Time, nullable=False)

    def __init__(self, tienda_id=None, dia=None, hora_de_apertura="08:00:00",
                 hora_de_cierre="16:00:00"):
        self.tienda_id = tienda_id
        self.dia = dia
        self.hora_de_apertura = hora_de_apertura
        self.hora_de_cierre = hora_de_cierre

class HorarioDeTrabajo(Base):
    __tablename__ = 'horario_de_trabajo'

    # Columnas
    tienda_id = Column(
        Integer, ForeignKey('tienda.tienda_id'), primary_key=True,
        autoincrement=False
    )
    dia = Column(
        CHAR(9), ForeignKey('dia.valor'), primary_key=True, autoincrement=False
    )
    laborable = Column(Boolean, nullable=False)

    # Propiedades
    #dia = relationship('Dia', backref='horarios_de_trabajo')
    tienda = relationship('Tienda', backref='horarios_de_trabajo')

    def __init__(self, tienda_id=None, dia=None, laborable=True):
        self.tienda_id = tienda_id
        self.dia = dia
        self.laborable = laborable

class Tienda(EsBuscable, EsCalificableSeguible, EsInterlocutor, EsDibujable, 
             Cliente):
    __tablename__ = 'tienda'
    __mapper_args__ = {'polymorphic_identity': 'tienda'}

    # Columnas
    """
    buscable_p = Column(
        Integer, ForeignKey('buscable.buscable_id'), nullable=False, 
        unique=True, index=True
    )
    """
    cliente_p = Column(
        CHAR(10), ForeignKey('cliente.rif'), nullable=False, unique=True, 
        index=True
    )
    """
    calificable_seguible_p = Column(
        Integer, ForeignKey('calificable_seguible.calificable_seguible_id'), 
        nullable=False, unique=True, index=True
    )
    interlocutor_p = Column(
        Integer, ForeignKey('interlocutor.interlocutor_id'), nullable=False, 
        unique=True, index=True
    )
    dibujable_p = Column(
        Integer, ForeignKey('dibujable.dibujable_id'), nullable=False, 
        unique=True, index=True
    )
    """
    tienda_id = Column(Integer, primary_key=True, autoincrement=True)
    abierto = Column(Boolean, nullable=False)
    
    # Propiedades
    productos = relationship(
        "Producto", secondary=lambda:Inventario.__table__, 
        backref="tiendas"
    )
    dias = relationship(
        "Dia", secondary=lambda:HorarioDeTrabajo.__table__, 
        backref="tiendas"
    )

    def __init__(self, abierto=True, *args, **kwargs):
        super(Tienda, self).__init__(*args, **kwargs)
        self.abierto = abierto
        tamano_nuevo = Tamano(self.tienda_id, 0, 0, 0)
        DBSession.add(tamano_nuevo)

class Inventario(EsRastreable, EsCobrable, Base):
    __tablename__ = 'inventario'
    #__mapper_args__ = {'polymorphic_identity': 'inventario'}

    # Columnas
    """
    rastreable_p = Column(
        Integer, ForeignKey('rastreable.rastreable_id'), nullable=False, 
        unique=True, index=True
    )
    cobrable_p = Column(
        Integer, ForeignKey('cobrable.cobrable_id'), nullable=False, 
        unique=True, index=True
    )
    """
    """
    Tanto 'tienda_id' como 'codigo' tienen que ser indices por lo que se 
    explica en la documentacion de MySQL:

    If you re-create a table that was dropped, it must have a definition that 
    conforms to the foreign key constraints referencing it. It must have the 
    right column names and types, and it must have indexes on the referenced 
    keys, as stated earlier. If these are not satisfied, MySQL returns error 
    number 1005 and refers to error 150 in the error message.

    If MySQL reports an error number 1005 from a CREATE TABLE statement, and 
    the error message refers to error 150, table creation failed because a 
    foreign key constraint was not correctly formed. Similarly, if an ALTER 
    TABLE fails and it refers to error 150, that means a foreign key definition 
    would be incorrectly formed for the altered table. To display a detailed 
    explanation of the most recent InnoDB foreign key error in the server, 
    issue SHOW ENGINE INNODB STATUS.

    http://dev.mysql.com/doc/refman/5.1/en/innodb-foreign-key-constraints.html
    """
    tienda_id = Column(
        Integer, ForeignKey('tienda.tienda_id'), primary_key=True,
        autoincrement=False, index=True
    )
    codigo = Column(CHAR(15), primary_key=True, autoincrement=False, index=True)
    descripcion = Column(String(45))
    visibilidad = Column(
        CHAR(16), ForeignKey('visibilidad.valor'), nullable=False
    )
    producto_id = Column(Integer, ForeignKey('producto.producto_id'))

    # Propiedades
    tienda = relationship('Tienda', backref='inventario')
    producto = relationship(
		'Producto', primaryjoin='Inventario.producto_id==Producto.producto_id',
		 backref='inventario'
	)

    def __init__(self, tienda_id=None, codigo=None, descripcion='', 
                 visibilidad="Ambos visibles", producto_id=None, precio=0, 
                 cantidad=0):
        #super(Inventario, self).__init__(*args, **kwargs)
        self.tienda_id = tienda_id
        self.codigo = codigo
        self.descripcion = descripcion
        self.visibilidad = visibilidad
        self.producto_id = producto_id
        # Agregamos una columna en precio_cantidad para seguir a este item
        precio_cantidad_nuevo = PrecioCantidad(
            tienda_id, codigo, precio, cantidad
        )
        # Actualizamos el tamano de la tienda
        tamano_viejo = DBSession.query(Tamano).filter(and_(
            tienda_id == tienda_id, 
            fecha_fin is None
        )).first()
        numero_nuevo = tamano_viejo.numero_total_de_productos + 1
        cantidad_nueva = tamano_viejo.cantidad_total_de_productos + cantidad
        tamano_nuevo = Tamano(
            tienda_id, numero_nuevo, cantidad_nueva, 
            numero_nuevo*cantidad_nueva
        )
        DBSession.add_all(precio_cantidad_nuevo, tamano_nuevo)

class Producto(EsRastreable, EsDescribible, EsBuscable, EsCalificableSeguible,
               Base):
    __tablename__ = 'producto'
    #__mapper_args__ = {'polymorphic_identity': 'producto'}

    # Columnas
    """
    rastreable_p = Column(
        Integer, ForeignKey('rastreable.rastreable_id'), nullable=False, 
        unique=True, index=True
    )
    describible_p = Column(
        Integer, ForeignKey('describible.describible_id'), nullable=False, 
        unique=True, index=True
    )
    buscable_p = Column(
        Integer, ForeignKey('buscable.buscable_id'), nullable=False, 
        unique=True, index=True
    )
    calificable_seguible_p = Column(
        Integer, ForeignKey('calificable_seguible.calificable_seguible_id'), 
        nullable=False, unique=True, index=True
    )
    """
    producto_id = Column(
		Integer, autoincrement=True, primary_key=True, index=True
	)
    tipo_de_codigo = Column(
        CHAR(7), ForeignKey('tipo_de_codigo.valor'), nullable=False
    )
    codigo = Column(CHAR(15), nullable=False, unique=True, index=True)
    estatus = Column(CHAR(9), ForeignKey('estatus.valor'), nullable=False)
    fabricante = Column(String(45), nullable=False)
    modelo = Column(String(45))
    nombre = Column(String(45), nullable=False)
    categoria = Column(
        CHAR(16), ForeignKey('categoria.categoria_id'), nullable=False
    )
    debut_en_el_mercado = Column(Date)
    largo = Column(Float)
    ancho = Column(Float)
    alto = Column(Float)
    peso = Column(Float)
    pais_de_origen = Column(CHAR(16), ForeignKey('territorio.territorio_id'))

    def __init__(self, tipo_de_codigo, codigo, estatus, fabricante, 
                 modelo, nombre, categoria, debut_en_el_mercado, largo, ancho,
                 alto, peso, pais_de_origen):
        #super(Producto, self).__init__(*args, **kwargs)
        self.tipo_de_codigo = tipo_de_codigo
        self.codigo = codigo
        self.estatus = estatus
        self.fabricante = fabricante
        self.modelo = modelo
        self.nombre = nombre
        self.categoria = categoria
        self.largo = largo
        self.ancho = ancho
        self.alto = alto
        self.peso = peso
        self.pais_de_origen = pais_de_origen

inventario = Inventario.__table__
precio_cantidad = PrecioCantidad.__table__
tamano = Tamano.__table__

crear_inventario_tienda = CreateView('inventario_tienda', 
    select(
        [
            inventario.c.tienda_id,
            inventario.c.codigo,
            inventario.c.descripcion,
            precio_cantidad.c.precio,
            precio_cantidad.c.cantidad
        ], 
        from_obj=[
            inventario.join(
                precio_cantidad, 
                onclause='and_('
                    'inventario.tienda_id == precio_cantidad.tienda_id,'
                    'inventario.codigo == precio_cantidad.codigo)'
            )
        ]
    ).where(precio_cantidad.c.fecha_fin is None)
)

crear_inventario_reciente = CreateView('inventario_reciente', 
    select(
        [
            inventario.c.tienda_id,
            inventario.c.producto_id,
            inventario.c.codigo,
            inventario.c.descripcion,
            precio_cantidad.c.precio,
            precio_cantidad.c.cantidad
        ], 
        from_obj=[
            inventario.join(
                precio_cantidad,
                onclause='and_('
                    'inventario.tienda_id == precio_cantidad.tienda_id,'
                    'inventario.codigo == precio_cantidad.codigo)'
            )
        ]
    ).where(precio_cantidad.c.fecha_fin is None)
)

crear_tamano_reciente = CreateView('tamano_reciente', 
    select([
        tamano.c.tienda_id,
        tamano.c.fecha_inicio,
        tamano.c.numero_total_de_productos,
        tamano.c.cantidad_total_de_productos,
        tamano.c.valor
    ]).where(tamano.c.fecha_fin is None)
)

"""
DBSession.execute(crear_inventario_tienda)
DBSession.execute(crear_inventario_reciente)
DBSession.execute(crear_tamano_reciente)
"""
