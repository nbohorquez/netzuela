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
    'pykml',
    'pyelasticsearch',
    'celery', 
    'beautifulsoup4',
    'python-dateutil'
]

setup(name='spuria', 
      version='0.1', 
      description='Base de datos de Netzuela',
      long_description=README + '\n\n' +  CHANGES,
      classifiers=[
        "Programming Language :: Python",
        "Topic :: Database :: Database Engines/Servers",
        "Topic :: Internet :: WWW/HTTP :: Indexing/Search"
      ],
      author='Zuliaworks C.A.',
      author_email='contacto@zuliaworks.com',
      url='www.zuliaworks.com',
      keywords='web database netzuela sqlalchemy elasticsearch celery',
      packages=find_packages(),
      include_package_data=True,
      zip_safe=False,
      test_suite='spuria',
      install_requires=requires,
      entry_points="""
      [console_scripts]
      cargar_constantes = spuria.scripts.cargar_constantes:main
      cargar_mapas = spuria.scripts.cargar_mapas:main
      codigo_prueba = spuria.scripts.codigo_prueba:main
      inicializar_buscador = spuria.scripts.inicializar_buscador:main
      """
)
