#!/bin/bash
for i in "$1"/*
do
	echo "Procesando $i..."
	./procesar_imagen.sh "$i" "$2"
done
