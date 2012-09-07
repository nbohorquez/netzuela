#!/bin/bash

declare -A TAMANOS=(["grandes"]="500" ["medianas"]="300" ["pequenas"]="160" ["miniaturas"]="70")

# Hacemos las comprobaciones necesarias sobre el primer argumento
if [ ! $1 ];
then
	echo 'Teneis que especificar al menos un argumento'
	exit 0
elif [ ! -f $1 ];
then
	echo 'El archivo' $1 'no existe'
	exit 0
fi

# Llamamos a sha1sum para que calcule el hash SHA-1 sobre el archivo encomendado
HASH=`sha1sum $1`
declare -a ARREGLO

i=0
for x in $HASH
do
	ARREGLO[$i]=$x
	((i++))
done

dir1=${ARREGLO[0]:0:2}
dir2=${ARREGLO[0]:2:2}
archivo=${ARREGLO[0]:4}
indice_punto=$( expr index "${ARREGLO[1]}" . )
extension=$( echo ${ARREGLO[1]:$indice_punto} | tr '[A-Z]' '[a-z]')

# Comprobamos que el directorio de salida existe
if [ ! $2 ];
then
	echo 'No especificaste el directorio de salida'
	base=.
elif [ ! -d $2 ];
then
	echo 'El directorio de salida no existe'
	base=.
else
	base=$2
fi

for i in "${!TAMANOS[@]}"
do
	# Chequeamos que el primer directorio exista
	if [ ! -d "$base"/"$i" ];
	then
		mkdir "$base"/"$i"
	fi

	# Chequeamos que el segundo directorio exista
	if [ ! -d "$base"/"$i"/"$dir1" ];
	then
		mkdir "$base"/"$i"/"$dir1"
	fi

	# Chequeamos que el tercer directorio exista
	if [ ! -d "$base"/"$i"/"$dir1"/"$dir2" ];
	then
		mkdir "$base"/"$i"/"$dir1"/"$dir2"
	fi

	ancho=`identify -format '%w' $1`
	alto=`identify -format '%h' $1`
	ruta_archivo="$base"/"$i"/"$dir1"/"$dir2"/"$archivo"."$extension"

	if [ $ancho -gt $alto -a \( $i = 'medianas' -o $i = 'pequenas' -o $i = 'miniaturas' \) ];
	then
		convert "$1" -resize x"${TAMANOS[$i]}" "$ruta_archivo"
		ancho=`identify -format '%w' $ruta_archivo`
		alto=`identify -format '%h' $ruta_archivo`
		marco=$( echo "($ancho - $alto) / 2" | bc )
		convert "$ruta_archivo" -shave "$marco"x0 "$ruta_archivo"
	elif [ $alto -gt $ancho -a \( $i = 'medianas' -o $i = 'pequenas' -o $i = 'miniaturas' \) ];
	then
		convert "$1" -resize "${TAMANOS[$i]}"x "$ruta_archivo"
		ancho=`identify -format '%w' $ruta_archivo`
		alto=`identify -format '%h' $ruta_archivo`
		marco=$( echo "($alto - $ancho) / 2" | bc )
		convert "$ruta_archivo" -shave 0x"$marco" "$ruta_archivo"
	else
		convert -resize "${TAMANOS[$i]}" "$1" "$ruta_archivo"
	fi

	# Convertimos la imagen a los tamanos especificados en TAMANOS
	echo 'El archivo' $1 'fue copiado a la ubicacion: ' "$ruta_archivo"
done

exit 1
