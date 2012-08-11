#!/bin/bash

crear_db="source ../src/db/mysql/spuria.sql"
prueba="source ../src/db/mysql/prueba_1.sql"
mysql="mysql -u chivo -p'#HK_@20MamA!pAPa13?#3864'"

echo "Creando la base de datos, calmate..."
eval $mysql << eof
$crear_db
eof

echo "Ahora cargamos los mapas"
source env/bin/activate
python cargar_mapas.py
deactivate

echo "Por ultimo agregamos algo de codigo de prueba"
eval $mysql << eof
$prueba
eof
