# -*- coding: utf-8 -*-

from datetime import datetime
from decimal import Decimal
from sqlalchemy import Table, event
from sqlalchemy.ext.compiler import compiles
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import scoped_session, sessionmaker
from sqlalchemy.sql.expression import Executable, ClauseElement
from zope.sqlalchemy import ZopeTransactionExtension
from time import strftime

DBSession = scoped_session(sessionmaker(extension=ZopeTransactionExtension()))

def fecha_hora_a_mysql(fecha_hora):
    return "{}.{}".format(
        fecha_hora.strftime("%Y%m%d%H%M%S"), 
        int(round(Decimal(fecha_hora.microsecond)/1000))
    )
    
def ahorita():
    return fecha_hora_a_mysql(datetime.now())

# Toma en cuenta lo que dice esta pagina para cuando vayais a utilizar el Base 
# que aqui se define:
# http://xion.org.pl/2012/06/12/interesting-problem-with-mysql-sqlalchemy/
class _Base(object):
    __table_args__ = {'mysql_engine': 'InnoDB'}

    @staticmethod
    def antes_de_insertar(mapper, connection, target):
        pass

    @staticmethod
    def despues_de_insertar(mapper, connection, target):
        from registros import Registro
        from rastreable import EsRastreable
        import cPickle

        if not isinstance(target, EsRastreable):
            return

        registro = Registro.__table__

        # Solamente incluimos aquellas claves que sean columnas en la base
        # de datos. No queremos guardar vainas locas de SQLAlchemy
        datos = {key:value for (key, value) in target.__dict__.iteritems() \
        if key in target.__table__.columns}

        registrar_insercion = registro.insert().\
        values(
            fecha_hora = ahorita(),
            actor_activo_id = target.rastreable.creado_por,
            accion = 'Insertar',
            actor_pasivo_id = target.rastreable.rastreable_id,
            detalles = cPickle.dumps(datos)
        )
        DBSession.execute(registrar_insercion)

    @staticmethod
    def antes_de_actualizar(mapper, connection, target):
        pass

    @staticmethod
    def antes_de_eliminar(mapper, connection, target):
        pass

    @classmethod
    def registrar_eventos(cls):
        event.listen(cls, 'before_insert', cls.antes_de_insertar)
        event.listen(cls, 'after_insert', cls.despues_de_insertar)
        event.listen(cls, 'before_update', cls.antes_de_actualizar)
        event.listen(cls, 'before_delete', cls.antes_de_eliminar)

	def __init__(self, *args, **kwargs):
		super(_Base, self).__init__(*args, **kwargs)

Base = declarative_base(cls=_Base)

# Codigo para crear 'views' tomado de: 
# http://stackoverflow.com/questions/9766940/how-to-create-an-sql-view-with-sqlalchemy
class CreateView(Executable, ClauseElement):
    def __init__(self, name, select):
        self.name = name
        self.select = select

@compiles(CreateView)
def visit_create_view(element, compiler, **kw):
    return "CREATE OR REPLACE VIEW {} AS {}".format(
        element.name, compiler.process(element.select, literal_binds=True)
    )
