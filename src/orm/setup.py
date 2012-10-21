from os import path
from setuptools import setup, find_packages

here = path.abspath(path.dirname(__file__))
README = open(path.join(here, 'README.rst')).read()
CHANGES = open(path.join(here, 'CHANGES.txt')).read()
requires=['mysql-python', 'SQLAlchemy', 'zope.sqlalchemy', 'transaction']

setup(name='orm', 
      version='0.0.1', 
      description='Capa de abstraccion de la base de datos de Netzuela',
      packages=find_packages(),
      install_requires=requires,
      entry_points="""
      [console_scripts]
      cargar_modelos = orm.inicializar:main
      """
)
