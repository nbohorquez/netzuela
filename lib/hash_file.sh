#!/bin/bash
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

#Llamamos a sha1sum para que calcule el hash SHA-1 sobre el archivo encomendado
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

echo ${ARREGLO[0]}
echo $dir1 $dir2 $archivo

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

# Chequeamos que el primer directorio exista
if [ ! -d "$base"/"$dir1" ];
then
	mkdir "$base"/"$dir1"
fi

# Chequeamos que el segundo directorio exista
if [ ! -d "$base"/"$dir1"/"$dir2" ];
then
	mkdir "$base"/"$dir1"/"$dir2"
fi

# Copiamos el archivo "hasheado" al directorio de salida
cp $1 "$base"/"$dir1"/"$dir2"/"$archivo"
echo 'El archivo' $1 'fue copiado a la ubicacion: ' $base'/'$dir1'/'$dir2'/'$archivo

exit 1
