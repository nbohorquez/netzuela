#!/bin/bash

source comunes.sh
parse_config "$archivo_config" || warning "Advertencia: error al leer $archivo_config"

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

instalar_libxml() {
    apt-get install -y libxml2-dev > /dev/null 2>&1 || return 1
    return 0
}

instalar_libxslt() {
    apt-get install -y libxslt1-dev > /dev/null 2>&1 || return 1
    return 0
}

crear_db() {
    eval "$crear_spuria" || return 1
    info "\tEsquema de la base de datos cargado"
    source env/bin/activate
    cargar_constantes || return 1
    info "\tConstantes de la base de datos cargadas"
    cargar_mapas || return 1
    info "\tMapas de Venezuela cargados"
    deactivate
}

crear_carpeta_imagenes() {
    rm -rf "$dir_img" 2>/dev/null
    mkdir "$dir_img" || return 1
    #if [ ! -d "$dir_img" ]; then
    #    echo "Directorio $dir_img no existe, creandolo..."
    #    mkdir "$dir_img" || abortar "No se pudo crear el directorio $dir_img"
    #fi
    
    # Creamos el directorio simbolico de imagenes
    rm "$var_img" 2>/dev/null
    ln -s "$dir_img" "$var_img"
    if [ ! -L "$var_img" ]; then
        return 1
    fi
    #if [ ! -L "$var_img" ]; then
    #    echo "El directorio /var/www/ no esta configurado, trabajando..."
    #    ln -s "$dir_img" "$var_img"
    #fi
    return 0
}

cargar_codigo_prueba() {
    source env/bin/activate
    codigo_prueba
    deactivate
}

# Chequeamos root
if [ "$USER" != "root" ]; then
    abortar "Error: Debe correr este script como root"
fi
info "Ejecutando script como root"

# Instalamos componentes necesarios para cargar los mapas
#existe_libxml=`dpkg -l | grep 'libxml2-dev'`
#existe_libxslt=`dpkg -l | grep 'libxslt1-dev'`

instalar_libxml || abortar "No se pudo instalar libxml2-dev"
#if [ -z "$existe_libxml"  ]; then
#    echo "La biblioteca libxml2-dev no esta instalada, instalando..."
#    instalar_libxml
#fi
info "libxml2-dev instalado"

instalar_libxslt || abortar "No se pudo instalar libxslt1-dev"
#if [ -z "$existe_libxslt" ]; then
#    echo "La biblioteca libxslt1-dev no esta instalada, instalando..."
#    instalar_libxslt
#fi
info "libxslt1-dev instalado"

crear_env || abortar "No se pudo crear el ambiente virtual"
info "Ambiente virtual creado"

# Creamos la base de datos
crear_db || abortar "No se pudo crear la base de datos"
info "Base de datos creada"

# Creamos el directorio de imagenes
crear_carpeta_imagenes || abortar "No se pudo crear la carpeta $var_img"
info "Carpeta $var_img configurada"

if [ "$codigo_de_muestra" == "si" ]; then
    ./cargar_imagenes.sh "$dir_entrada" "$dir_salida" > "$archivo_imagenes"
    cargar_codigo_prueba
    info "Datos de prueba instalados"
fi
