#!/bin/bash
for i in "$1"/*
do
	echo "Procesando $i..."
	../../../lib/hash_file.sh "$i" "$2"
done
