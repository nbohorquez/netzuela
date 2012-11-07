from os import path
from setuptools import setup, find_packages

here = path.abspath(path.dirname(__file__))
README = open(path.join(here, 'README.rst')).read()
CHANGES = open(path.join(here, 'CHANGES.txt')).read()
requires = [
	'mysql-python', 
	'SQLAlchemy', 
	'zope.sqlalchemy', 
	'transaction', 
	'lxml', 
	'pykml'
]

setup(name='spuria.orm', 
      version='0.0.1', 
      description='Interfaz ORM de la base de datos de Netzuela',
      packages=find_packages(),
      install_requires=requires,
      entry_points="""
      [console_scripts]
      cargar_constantes = spuria.orm.scripts.cargar_constantes:main
	  cargar_mapas = spuria.orm.scripts.cargar_mapas:main
	  codigo_prueba = spuria.orm.scripts.codigo_prueba:main
      """
)
