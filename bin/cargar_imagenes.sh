#!/bin/bash

# Comprobamos que el script de procesamiento existe
if [ ! -f procesar_imagen.sh ]; then
	echo "El archivo 'procesar_imagen.sh' no existe en este directorio"
	exit 0
fi

# Comprobamos los parametros de entrada
if [ ! $1 -o ! $2 ]; then
	echo "Uso correcto: ./cargar_imagenes.sh <dir_entrada> <dir_salida>"
	exit 0
fi

if [ ! -d $1 ]; then
	echo "El directorio de entrada no existe"
	exit 0
fi

if [ ! -d $2 ]; then
	echo "El directorio de salida no existe"
	exit 0
fi

# Procesamos cada imagen del directorio especificado
for i in "$1"/*
do
	echo "Procesando $i..."
	./procesar_imagen.sh "$i" "$2"
done
