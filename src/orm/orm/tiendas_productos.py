# -*- coding: utf-8 -*-

from comunes import ahorita, Base, CreateView, DBSession
from sqlalchemy import Column, Integer, Numeric, Boolean, ForeignKey
from sqlalchemy.orm import relationship, backref

class TipoDeCodigo(Base):
    __tablename__ = 'tipo_de_codigo'
    valor = Column(CHAR(7), primary_key=True)

    def __init__(self, valor=None):
        self.valor = valor

class Visibilidad(Base):
    __tablename__ = 'visibilidad'
    valor = Column(CHAR(16), primary_key=True)

    def __init__(self, valor=None):
        self.valor = valor

class PrecioCantidad(Base):
    __tablename__ = 'precio_cantidad'
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
    valor = Column(CHAR(9), primary_key=True)
    orden = Column(Integer, nullable=False, index=True, unique=True)

    def __init__(self, valor=None, orden=0):
        self.valor = valor
        self.orden = orden

class Turno(Base):
    __tablename__ = 'turno'
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
    tienda_id = Column(
        Integer, ForeignKey('tienda.tienda_id'), primary_key=True,
        autoincrement=False
    )
    dia = Column(CHAR(9), ForeignKey('dia.valor'), primary_key=True)
    laborable = Column(Boolean, nullable=False)

    def __init__(self, tienda_id=None, dia=None, laborable=True):
        self.tienda_id = tienda_id
        self.dia = dia
        self.laborable = laborable

class Tienda(Buscable, Cliente, CalificableSeguible, Interlocutor, Dibujable):
    __tablename__ = 'tienda'
    __mapper_args__ = {'polymorphic_identity': 'tienda'}
    buscable_p = Column(
        Integer, nullable=False, unique=True, index=True
        ForeignKey('buscable.buscable_id')
    )
    cliente_p = Column(
        CHAR(10), nullable=False, unique=True, index=True, 
    ForeignKey('cliente.rif')
    )
    calificable_seguible_p = Column(
        Integer, nullable=False, unique=True, index=True
        ForeignKey('calificable_seguible.calificable_seguible_id')
    )
    interlocutor_p = Column(
        Integer, nullable=False, unique=True, index=True
        ForeignKey('interlocutor.interlocutor_id')
    )
    dibujable_p = Column(
        Integer, nullable=False, unique=True, index=True
        ForeignKey('dibujable.dibujable_id')
    )
    tienda_id = Column(Integer, primary_key=True, autoincrement=True)
    abierto = Column(Boolean, nullable=False)
    
    def __init__(self, abierto=True, *args, **kwargs):
        super(Tienda, self).__init__(*args, **kwargs)
        self.abierto = abierto
        tamano_nuevo = Tamano(self.tienda_id, 0, 0, 0)
        DBSession.add(tamano_nuevo)

class Inventario(Rastreable, Cobrable):
    __tablename__ = 'inventario'
    __mapper_args__ = {'polymorphic_identity': 'inventario'}
    rastreable_p = Column(
        Integer, nullable=False, unique=True, index=True,
        ForeignKey('rastreable.rastreable_id')
    )
    cobrable_p = Column(
        Integer, nullable=False, unique=True, index=True,
        ForeignKey('cobrable.cobrable_id')
    )
    tienda_id = Column(
        Integer, ForeignKey('tienda.tienda_id'), primary_key=True,
        autoincrement=False
    )
    codigo = Column(CHAR(15), primary_key=True)
    descripcion = Column(String(45))
    visibilidad = Column(
        CHAR(16), ForeignKey('visibilidad.valor'), nullable=False
    )
    producto_id = Column(Integer, ForeignKey('producto.producto_id'))

    def __init__(self, tienda_id=None, codigo=None, descripcion='', 
                 visibilidad="Ambos visibles", producto_id=None, precio=0, 
                 cantidad=0, *args, **kwargs):
        super(Inventario, self).__init__(*args, **kwargs)
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
        cantidad nueva = tamano_viejo.cantidad_total_de_productos + cantidad
        tamano_nuevo = Tamano(
            tienda_id, numero_nuevo, cantidad_nueva, 
            numero_nuevo*cantidad_nueva
        )
        DBSession.add_all(precio_cantidad_nuevo, tamano_nuevo)

class Producto(Rastreable, Describible, Buscable, CalificableSeguible):
    __tablename__ = 'producto'
    __mapper_args__ = {'polymorphic_identity': 'producto'}
    rastreable_p = Column(
        Integer, nullable=False, unique=True, index=True
        ForeignKey('rastreable.rastreable_id')
    )
    describible_p = Column(
        Integer, nullable=False, unique=True, index=True 
        ForeignKey('describible.describible_id')
    )
    buscable_p = Column(
        Integer, nullable=False, unique=True, index=True 
        ForeignKey('buscable.buscable_id')
    )
    calificable_seguible_p = Column(
        Integer, nullable=False, unique=True, index=True 
        ForeignKey('calificable_seguible.calificable_seguible_id')
    )
    producto_id = Column(Integer, autoincrement=True, primary_key=True)
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
                 alto, peso, pais_de_origen, *args, **kwargs):
        super(Producto, self)__init__(*args, **kwargs)
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
precio_cantidad = PrecioCantidad.__table
tamano = Tamano.__table__

crear_inventario_tienda = CreateView('inventario_tienda', 
    select(
        [
            inventario.c.tienda_id,
            inventario.c.codigo,
            inventario.c.descripcion,
            inventario.c.precio,
            inventario.c.cantidad
        ], 
        from_obj=[inventario.join(precio_cantidad)]
    ).where(precio_cantidad.c.fecha_fin is None)
)

crear_inventario_reciente = CreateView('inventario_reciente', 
    select(
        [
            inventario.c.tienda_id,
            inventario.c.producto_id,
            inventario.c.codigo,
            inventario.c.descripcion,
            inventario.c.precio,
            inventario.c.cantidad
        ], 
        from_obj=[inventario.join(precio_cantidad)]
    ).where(precio_cantidad.c.fecha_fin is None)
)

crear_tamano_reciente = CreateView('tamano_reciente', 
    select([
        tamano.c.tienda_id,
        tamano.c.fecha_inicio
        tamano.c.numero_total_de_productos,
        tamano.c.cantidad_total_de_productos,
        tamano.c.valor
    ]).where(tamano.c.fecha_fin is None)
)

DBSession.execute(crear_inventario_tienda)
DBSession.execute(crear_inventario_reciente)
DBSession.execute(crear_tamano_reciente)
