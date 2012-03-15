SELECT 'spuria.sql';
DROP DATABASE IF EXISTS `spuria`;

/* DEBE ejecutarse en este orden */

SOURCE ~/netzuela/spuria/src/base_de_datos/mysql/esqueleto.sql

SOURCE ~/netzuela/spuria/src/base_de_datos/mysql/funciones/rastreable.sql
SOURCE ~/netzuela/spuria/src/base_de_datos/mysql/funciones/generales.sql
SOURCE ~/netzuela/spuria/src/base_de_datos/mysql/funciones/busquedas.sql
SOURCE ~/netzuela/spuria/src/base_de_datos/mysql/funciones/calificaciones_resenas.sql
SOURCE ~/netzuela/spuria/src/base_de_datos/mysql/funciones/consumidores.sql
SOURCE ~/netzuela/spuria/src/base_de_datos/mysql/funciones/croquis_puntos.sql
SOURCE ~/netzuela/spuria/src/base_de_datos/mysql/funciones/descripciones_fotos.sql
SOURCE ~/netzuela/spuria/src/base_de_datos/mysql/funciones/estadisticas.sql
SOURCE ~/netzuela/spuria/src/base_de_datos/mysql/funciones/mensajes.sql
SOURCE ~/netzuela/spuria/src/base_de_datos/mysql/funciones/palabras.sql
SOURCE ~/netzuela/spuria/src/base_de_datos/mysql/funciones/patrocinantes_publicidades.sql
SOURCE ~/netzuela/spuria/src/base_de_datos/mysql/funciones/regiones_geograficas.sql
SOURCE ~/netzuela/spuria/src/base_de_datos/mysql/funciones/registros.sql
SOURCE ~/netzuela/spuria/src/base_de_datos/mysql/funciones/tiendas_productos.sql
SOURCE ~/netzuela/spuria/src/base_de_datos/mysql/funciones/usuarios.sql
SOURCE ~/netzuela/spuria/src/base_de_datos/mysql/funciones/ventas.sql
SOURCE ~/netzuela/spuria/src/base_de_datos/mysql/funciones/usuarios_del_sistema.sql
SOURCE ~/netzuela/spuria/src/base_de_datos/mysql/funciones/llamadas_al_sistema.sql

SOURCE ~/netzuela/spuria/src/base_de_datos/mysql/inicializacion.sql

CALL CrearUsuarioValeria();
FLUSH PRIVILEGES;

CALL CrearUsuarioParis();
FLUSH PRIVILEGES;
