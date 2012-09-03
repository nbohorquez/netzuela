#!/bin/bash

crear_db="source ../src/db/mysql/spuria.sql"
prueba="source ../src/db/mysql/prueba_1.sql"
ingresar_mysql="mysql -u chivo -p'#HK_@20MamA!pAPa13?#3864'"

# Creamos la base de datos
echo "Creando la base de datos, calmate..."
eval $ingresar_mysql << eof
$crear_db
eof

# Carga de los mapas
echo "Ahora cargamos los mapas"
echo "Chequeando si todos los componentes necesario estan instalados..."

existe_libxml=`dpkg -l | grep 'libxml2-dev'`
existe_libxslt=`dpkg -l | grep 'libxslt1-dev'`

if [ -z "$existe_libxml"  ]
then
	echo "La biblioteca libxml2-dev no esta instalada, instalando..."
	sudo apt-get install libxml2-dev
fi

if [ -z "$existe_libxslt" ]
then
	echo "La biblioteca libxslt1-dev no esta instalada, instalando..."
	sudo apt-get install libxslt1-dev
fi

if [ ! -f env/bin/python ]
then
	echo "No existe el ambiente virtual, creandolo..."
	virtualenv --no-site-packages --distribute env
	rm *.tar.gz
	source env/bin/activate
	cd ../src/mapas
	python setup.py install
	deactivate
	echo "Ambiente virtual creado y configurado"
	cd ../../bin
fi

echo "Componentes instalados"
source env/bin/activate
cargar_mapas mapas.ini
deactivate

# Codigo de prueba
echo "Por ultimo agregamos algo de codigo de prueba"
eval $ingresar_mysql << eof
$prueba
eof
