#!/bin/bash

contrasena='#HK_@20MamA!pAPa13?#3864'
ingresar_mysql="mysql -u chivo -p'$contrasena'"
crear_db="$ingresar_mysql << EOF
source ../src/db/mysql/spuria.sql
EOF
"
prueba="$ingresar_mysql << EOF
source ../src/db/mysql/prueba_1.sql
EOF
"

crear_env() {
	virtualenv --no-site-packages --distribute env
	rm *.tar.gz
	source env/bin/activate
	cd ../src/mapas
	python setup.py install
	deactivate
	cd ../../bin
}

instalar_libxml() {
	apt-get install -y libxml2-dev
}

instalar_libxslt() {
	apt-get install -y libxslt1-dev
}

crear_db() {
	# Mas adelante debe haber algo aqui que no sea SQL (inicializacion ORM)
	eval "$crear_db"
}

# Chequeamos root
if [ "$USER" != "root" ]; then
        echo "Error: Debe correr este script como root"
        exit 1;
fi
echo "Ejecutando script como root"

# Creamos la base de datos
crear_db
echo "Esquema de la base de datos creada"

# Carga de los mapas
existe_libxml=`dpkg -l | grep 'libxml2-dev'`
existe_libxslt=`dpkg -l | grep 'libxslt1-dev'`

if [ -z "$existe_libxml"  ]; then
	echo "La biblioteca libxml2-dev no esta instalada, instalando..."
	instalar_libxml
fi
echo "libxml2-dev instalado"

if [ -z "$existe_libxslt" ]; then
	echo "La biblioteca libxslt1-dev no esta instalada, instalando..."
	instalar_libxslt
fi
echo "libxslt1-dev instalado"

if [ ! -f env/bin/python ]; then
	echo "No existe el ambiente virtual, creandolo..."
	crear_env
fi
echo "Ambiente virtual creado"

source env/bin/activate
cargar_mapas mapas.ini
deactivate
echo "Mapas de Venezuela cargados"

source config.ini

if [ $codigo_de_muestra == "si" ]; then
	eval $prueba
	./cargar_imagenes.sh "$directorio_entrada" "$directorio_salida"
	echo "Datos de prueba instalados"
fi
