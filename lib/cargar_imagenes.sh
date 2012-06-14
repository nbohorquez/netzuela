#!/bin/bash
for i in "$1"/*
do
	echo "Procesando $i..."
	./hash_file.sh "$i" "$2"
done
