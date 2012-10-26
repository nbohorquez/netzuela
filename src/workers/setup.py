from os import path
from setuptools import setup, find_packages

here = path.abspath(path.dirname(__file__))
README = open(path.join(here, 'README.rst')).read()
CHANGES = open(path.join(here, 'CHANGES.txt')).read()
requires=['celery', 'beautifulsoup4']

setup(name='workers', 
      version='0.0.1', 
      description='Conjunto de trabajadores que ejecutan de forma concurrente una serie de tareas delegadas por la base de datos o el servidor valeria.',
      packages=find_packages(),
      install_requires=requires,
      entry_points="""
      [console_scripts]
      """
)
