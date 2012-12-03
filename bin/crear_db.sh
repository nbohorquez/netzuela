#!/bin/bash

source comunes.sh
parse_config "$archivo_config"

dir_img="$dir_salida"
var_img="/var/www/img"
ingresar_mysql="mysql -u $usuario -p'$contrasena'"
prueba="$ingresar_mysql << EOF
source ../src/sql/mysql/prueba_1.sql
EOF
"
crear_spuria="$ingresar_mysql << EOF
create database if not exists spuria;
EOF
"
crear_env() {
    virtualenv --no-site-packages --distribute env
    rm *.tar.gz
    dir=`pwd`
    source env/bin/activate
    easy_install -U distribute
    cd ../src
    python setup.py develop
    deactivate
    cd "$dir"
}

instalar_libxml() {
    apt-get install -y libxml2-dev
}

instalar_libxslt() {
    apt-get install -y libxslt1-dev
}

crear_db() {
    eval "$crear_spuria"

    source env/bin/activate
    cargar_constantes
    echo "Constantes de la base de datos cargadas"
    cargar_mapas
    echo "Mapas de Venezuela cargados"
    deactivate
}

cargar_codigo_prueba() {
    source env/bin/activate
    codigo_prueba
    deactivate
}

# Chequeamos root
if [ "$USER" != "root" ]; then
        echo "Error: Debe correr este script como root"
        exit 1;
fi
echo "Ejecutando script como root"

# Instalamos componentes necesarios para cargar los mapas
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

# Creamos la base de datos
crear_db

# Creamos el directorio de imagenes
if [ ! -d "$dir_img" ]; then
    echo "Directorio $dir_img no existe, creandolo..."
    mkdir "$dir_img" || abortar "No se pudo crear el directorio $dir_img"
fi
echo "$dir_img creado"

# Creamos el directorio simbolico de imagenes
if [ ! -L "$var_img" ]; then
    echo "El directorio /var/www/ no esta configurado, trabajando..."
    ln -s "$dir_img" "$var_img"
fi
echo "Directorio /var/www/ configurado"

if [ "$codigo_de_muestra" == "si" ]; then
    ./cargar_imagenes.sh "$dir_entrada" "$dir_salida" > "$archivo_imagenes"
    cargar_codigo_prueba
    echo "Datos de prueba instalados"
fi
