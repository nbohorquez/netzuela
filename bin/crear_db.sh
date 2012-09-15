#!/bin/bash

source comunes.sh
parse_config $archivo_config

ingresar_mysql="mysql -u $usuario -p'$contrasena'"
crear_db="$ingresar_mysql << EOF
source ../src/db/mysql/spuria_srv.sql
EOF
"
prueba="$ingresar_mysql << EOF
source ../src/db/mysql/prueba_1.sql
EOF
"
crear_now_msec="$ingresar_mysql << EOF
CREATE FUNCTION now_msec RETURNS STRING SONAME 'now_msec.so';
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

instalar_now_msec() {
	dir=`pwd`
	cd ../src/db/mysql
	gcc -shared -o now_msec.so now_msec.cc -I /usr/include/mysql
	mv now_msec.so /usr/lib/mysql/plugin
	eval "$crear_now_msec"
	cd "$dir"
}

# Chequeamos root
if [ "$USER" != "root" ]; then
        echo "Error: Debe correr este script como root"
        exit 1;
fi
echo "Ejecutando script como root"

# Chequeamos que now_msec.so este en su sitio
if [ ! -f /usr/lib/mysql/plugin/now_msec.so ]; then
	echo "La funcion 'now_msec()' no esta instalada, instalando..."
	instalar_now_msec
fi
echo "now_msec() instalada"

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
cargar_mapas
deactivate
echo "Mapas de Venezuela cargados"

if [ "$codigo_de_muestra" == "si" ]; then
	eval "$prueba"
	./cargar_imagenes.sh "$directorio_entrada" "$directorio_salida"
	echo "Datos de prueba instalados"
fi
