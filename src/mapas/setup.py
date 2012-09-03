from os import path
from setuptools import setup, find_packages

here = path.abspath(path.dirname(__file__))
README = open(path.join(here, 'README.rst')).read()
CHANGES = open(path.join(here, 'CHANGES.txt')).read()
requires=['lxml', 'pykml', 'mysql-python', 'SQLAlchemy']

setup(name='mapas', 
      version='0.0.1', 
      description='Carga el contenido de un archivo .kml a una base de datos',
      packages=find_packages(),
      install_requires=requires,
      entry_points="""
      [console_scripts]
      cargar_mapas = mapas.cargar_mapas:main
      """
)
