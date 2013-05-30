#!/bin/bash

source color-echo.sh
archivo_config="config.ini"
archivo_imagenes="imagenes.ini"

parse_config() {
    if [ ! -f "$1" ]; then
        error "$1 no existe"
        return 1
    fi

    # Hay muchas formas de leer un config file sin usar source:
    # http://stackoverflow.com/questions/4434797/read-a-config-file-in-bash-without-using-source
    while read linea; do
    if [[ "$linea" =~ ^[^#]*= ]]; then
        variable=`echo $linea | cut -d'=' -f 1 | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//'`
        #variable=`echo $linea | cut -d'=' -f 1 | tr -d ' '`
        valor=`echo $linea | cut -d'=' -f 2- | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//'`
        #valor=`echo $linea | cut -d'=' -f 2- | tr -d ' '`
        eval "$variable"="'$valor'"
    fi
    done < "$1"
}

crear_env() {
    alias rollback="rm -rf env 2>/dev/null; return 1"

    if [ ! -f env/bin/python ]; then
        virtualenv --no-site-packages --distribute env 2>&1 || rollback
        rm *.tar.gz 2>/dev/null
    fi

    source env/bin/activate
    easy_install -U distribute 2>&1 || { deactivate; rollback; }
    pip install python-dateutil || rollback

    dir=`pwd`
    cd ../src
    python setup.py install 2>&1 || { deactivate; cd "$dir"; rollback; }
    deactivate
    cd "$dir"
 
    return 0
}

abortar() {
    error "ERROR: $1. Abortando"
    exit 1
}
