SELECT 'spuria.sql';
DROP DATABASE IF EXISTS `spuria`;

/* DEBE ejecutarse en este orden */

SOURCE /home/nestor/netzuela/spuria/src/db/mysql/esqueleto.sql

SOURCE /home/nestor/netzuela/spuria/src/db/mysql/funciones/rastreable.sql
SOURCE /home/nestor/netzuela/spuria/src/db/mysql/funciones/generales.sql
SOURCE /home/nestor/netzuela/spuria/src/db/mysql/funciones/busquedas.sql
SOURCE /home/nestor/netzuela/spuria/src/db/mysql/funciones/calificaciones_resenas.sql
SOURCE /home/nestor/netzuela/spuria/src/db/mysql/funciones/consumidores.sql
SOURCE /home/nestor/netzuela/spuria/src/db/mysql/funciones/croquis_puntos.sql
SOURCE /home/nestor/netzuela/spuria/src/db/mysql/funciones/descripciones_fotos.sql
SOURCE /home/nestor/netzuela/spuria/src/db/mysql/funciones/estadisticas.sql
SOURCE /home/nestor/netzuela/spuria/src/db/mysql/funciones/mensajes.sql
SOURCE /home/nestor/netzuela/spuria/src/db/mysql/funciones/palabras.sql
SOURCE /home/nestor/netzuela/spuria/src/db/mysql/funciones/patrocinantes_publicidades.sql
SOURCE /home/nestor/netzuela/spuria/src/db/mysql/funciones/territorios.sql
SOURCE /home/nestor/netzuela/spuria/src/db/mysql/funciones/registros.sql
SOURCE /home/nestor/netzuela/spuria/src/db/mysql/funciones/tiendas_productos.sql
SOURCE /home/nestor/netzuela/spuria/src/db/mysql/funciones/usuarios.sql
SOURCE /home/nestor/netzuela/spuria/src/db/mysql/funciones/ventas.sql
SOURCE /home/nestor/netzuela/spuria/src/db/mysql/funciones/usuarios_del_sistema.sql
SOURCE /home/nestor/netzuela/spuria/src/db/mysql/funciones/llamadas_al_sistema.sql

SOURCE /home/nestor/netzuela/spuria/src/db/mysql/inicializacion.sql

CALL CrearUsuarioValeria();
FLUSH PRIVILEGES;

CALL CrearUsuarioParis();
FLUSH PRIVILEGES;
