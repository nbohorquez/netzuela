# -*- coding: utf-8 -*-

from datetime import datetime
from decimal import Decimal
from sqlalchemy import Table
from sqlalchemy.ext.compiler import compiles
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import scoped_session, sessionmaker
from sqlalchemy.sql.expression import Executable, ClauseElement
from zope.sqlalchemy import ZopeTransactionExtension
from time import strftime

DBSession = scoped_session(sessionmaker(extension=ZopeTransactionExtension()))

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
        pass

    @staticmethod
    def antes_de_actualizar(mapper, connection, target):
        pass

    @staticmethod
    def ante_de_eliminar(mapper, connection, target):
        pass

    @classmethod
    def registrar_eventos(cls):
        event.listen(cls, 'before_insert', cls.antes_de_insertar)
        event.listen(cls, 'after_insert', cls.despues_de_insertar)
        event.listen(cls, 'before_update', cls.antes_de_actualizar)
        event.listen(cls, 'before_delete', cls.antes_de_eliminar)

Base = declarative_base(cls=_Base)

def ahorita():
    ahora = datetime.now()
    return "{}.{}".format(
        ahora.strftime("%Y%m%d%H%M%S"), 
        int(round(Decimal(ahora.microsecond)/1000))
    )

# Codigo para crear 'views' tomado de: 
# http://stackoverflow.com/questions/9766940/how-to-create-an-sql-view-with-sqlalchemy
class CreateView(Executable, ClauseElement):
    def __init__(self, name, select):
        self.name = name
        self.select = select

@compiles(CreateView)
def visit_create_view(element, compiler, **kw):
    return "CREATE VIEW {} AS {}".format(
        element.name, compiler.process(element.select, literal_binds=True)
    )
