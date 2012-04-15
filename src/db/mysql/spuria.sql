SELECT 'spuria.sql';
DROP DATABASE IF EXISTS `spuria`;

/* DEBE ejecutarse en este orden */

SOURCE ~/netzuela/spuria/src/db/mysql/esqueleto.sql

SOURCE ~/netzuela/spuria/src/db/mysql/funciones/rastreable.sql
SOURCE ~/netzuela/spuria/src/db/mysql/funciones/generales.sql
SOURCE ~/netzuela/spuria/src/db/mysql/funciones/busquedas.sql
SOURCE ~/netzuela/spuria/src/db/mysql/funciones/calificaciones_resenas.sql
SOURCE ~/netzuela/spuria/src/db/mysql/funciones/consumidores.sql
SOURCE ~/netzuela/spuria/src/db/mysql/funciones/croquis_puntos.sql
SOURCE ~/netzuela/spuria/src/db/mysql/funciones/descripciones_fotos.sql
SOURCE ~/netzuela/spuria/src/db/mysql/funciones/estadisticas.sql
SOURCE ~/netzuela/spuria/src/db/mysql/funciones/mensajes.sql
SOURCE ~/netzuela/spuria/src/db/mysql/funciones/palabras.sql
SOURCE ~/netzuela/spuria/src/db/mysql/funciones/patrocinantes_publicidades.sql
SOURCE ~/netzuela/spuria/src/db/mysql/funciones/territorios.sql
SOURCE ~/netzuela/spuria/src/db/mysql/funciones/registros.sql
SOURCE ~/netzuela/spuria/src/db/mysql/funciones/tiendas_productos.sql
SOURCE ~/netzuela/spuria/src/db/mysql/funciones/usuarios.sql
SOURCE ~/netzuela/spuria/src/db/mysql/funciones/ventas.sql
SOURCE ~/netzuela/spuria/src/db/mysql/funciones/usuarios_del_sistema.sql
SOURCE ~/netzuela/spuria/src/db/mysql/funciones/llamadas_al_sistema.sql

SOURCE ~/netzuela/spuria/src/db/mysql/inicializacion.sql

CALL CrearUsuarioValeria();
FLUSH PRIVILEGES;

CALL CrearUsuarioParis();
FLUSH PRIVILEGES;
