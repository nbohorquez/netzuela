# -*- coding: utf-8 -*-

from datetime import datetime
from sqlalchemy import Table
from sqlalchemy.ext.compiler import compiles
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import scoped_session, sessionmaker
from sqlalchemy.sql.expression import Executable, ClauseElement
from time import strftime
from zope.sqlalchemy import ZopeTransactionExtension

DBSession = scoped_session(sessionmaker(extension=ZopeTransactionExtension()))
Base = declarative_base()

def ahorita()
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
