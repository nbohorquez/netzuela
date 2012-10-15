SELECT 'spuria.sql';
DROP DATABASE IF EXISTS `spuria`;

/* DEBE ejecutarse en este orden */

SOURCE /srv/www/spuria/src/sql/mysql/esqueleto.sql

SOURCE /srv/www/spuria/src/sql/mysql/funciones/rastreable.sql
SOURCE /srv/www/spuria/src/sql/mysql/funciones/generales.sql
SOURCE /srv/www/spuria/src/sql/mysql/funciones/busquedas.sql
SOURCE /srv/www/spuria/src/sql/mysql/funciones/calificaciones_resenas.sql
SOURCE /srv/www/spuria/src/sql/mysql/funciones/consumidores.sql
SOURCE /srv/www/spuria/src/sql/mysql/funciones/croquis_puntos.sql
SOURCE /srv/www/spuria/src/sql/mysql/funciones/descripciones_fotos.sql
SOURCE /srv/www/spuria/src/sql/mysql/funciones/estadisticas.sql
SOURCE /srv/www/spuria/src/sql/mysql/funciones/mensajes.sql
SOURCE /srv/www/spuria/src/sql/mysql/funciones/palabras.sql
SOURCE /srv/www/spuria/src/sql/mysql/funciones/patrocinantes_publicidades.sql
SOURCE /srv/www/spuria/src/sql/mysql/funciones/territorios.sql
SOURCE /srv/www/spuria/src/sql/mysql/funciones/registros.sql
SOURCE /srv/www/spuria/src/sql/mysql/funciones/tiendas_productos.sql
SOURCE /srv/www/spuria/src/sql/mysql/funciones/usuarios.sql
SOURCE /srv/www/spuria/src/sql/mysql/funciones/ventas.sql
SOURCE /srv/www/spuria/src/sql/mysql/funciones/usuarios_del_sistema.sql
SOURCE /srv/www/spuria/src/sql/mysql/funciones/llamadas_al_sistema.sql

SOURCE /srv/www/spuria/src/sql/mysql/inicializacion.sql

CALL CrearUsuarioValeria();
FLUSH PRIVILEGES;

CALL CrearUsuarioParis();
FLUSH PRIVILEGES;
