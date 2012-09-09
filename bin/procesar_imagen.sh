#!/bin/bash

instalar_imagemagick() {
	apt-get install -y imagemagick
}

declare -A TAMANOS=(["grandes"]="500" ["medianas"]="300" ["pequenas"]="160" ["miniaturas"]="70")
declare -a ARREGLO

# Hacemos las comprobaciones necesarias sobre el primer argumento
if [ ! $1 ]; then
	echo 'Teneis que especificar al menos un argumento'
	exit 0
elif [ ! -f $1 ]; then
	echo 'El archivo' $1 'no existe'
	exit 0
else
	entrada=`readlink -f $1`
fi

# Llamamos a sha1sum para que calcule el hash SHA-1 sobre el archivo encomendado
HASH=`sha1sum $entrada`

i=0
for x in $HASH; do
	ARREGLO[$i]=$x
	((i++))
done

dir1=${ARREGLO[0]:0:2}
dir2=${ARREGLO[0]:2:2}
archivo=${ARREGLO[0]:4}
indice_punto=$( expr index "${ARREGLO[1]}" . )
extension=$( echo ${ARREGLO[1]:$indice_punto} | tr '[A-Z]' '[a-z]')

# Comprobamos que el directorio de salida existe
if [ ! $2 ]; then
	echo 'No especificaste el directorio de salida'
	base=.
elif [ ! -d $2 ]; then
	echo 'El directorio de salida no existe'
	base=.
else
	base=`readlink -f $2`
fi

# Chequeamos imagemagick
command -v convert >/dev/null 2>&1 || { 
	echo "imagemagick no esta instalado, instalando...";
	instalar_imagemagick;
}
echo "imagemagick instalado"

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

	ancho=`identify -format '%w' $entrada`
	alto=`identify -format '%h' $entrada`
	ruta_archivo="$base"/"$i"/"$dir1"/"$dir2"/"$archivo"."$extension"

	if [ $ancho -gt $alto -a \( $i = 'medianas' -o $i = 'pequenas' -o $i = 'miniaturas' \) ];
	then
		convert "$entrada" -resize x"${TAMANOS[$i]}" "$ruta_archivo"
		ancho=`identify -format '%w' $ruta_archivo`
		alto=`identify -format '%h' $ruta_archivo`
		marco=$( echo "($ancho - $alto) / 2" | bc )
		convert "$ruta_archivo" -shave "$marco"x0 "$ruta_archivo"
	elif [ $alto -gt $ancho -a \( $i = 'medianas' -o $i = 'pequenas' -o $i = 'miniaturas' \) ];
	then
		convert "$entrada" -resize "${TAMANOS[$i]}"x "$ruta_archivo"
		ancho=`identify -format '%w' $ruta_archivo`
		alto=`identify -format '%h' $ruta_archivo`
		marco=$( echo "($alto - $ancho) / 2" | bc )
		convert "$ruta_archivo" -shave 0x"$marco" "$ruta_archivo"
	else
		convert -resize "${TAMANOS[$i]}" "$entrada" "$ruta_archivo"
	fi

	# Convertimos la imagen a los tamanos especificados en TAMANOS
	echo 'El archivo' $entrada 'fue copiado a la ubicacion: ' "$ruta_archivo"
done
