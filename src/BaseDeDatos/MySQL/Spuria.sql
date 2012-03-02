SELECT 'Spuria.sql';
DROP DATABASE IF EXISTS `Spuria`;

/* DEBE ejecutarse en este orden */

SOURCE ~/netzuela/spuria/src/BaseDeDatos/MySQL/Esqueleto.sql

SOURCE ~/netzuela/spuria/src/BaseDeDatos/MySQL/Funciones/Rastreable.sql
SOURCE ~/netzuela/spuria/src/BaseDeDatos/MySQL/Funciones/Generales.sql
SOURCE ~/netzuela/spuria/src/BaseDeDatos/MySQL/Funciones/Busquedas.sql
SOURCE ~/netzuela/spuria/src/BaseDeDatos/MySQL/Funciones/CalificacionesResenas.sql
SOURCE ~/netzuela/spuria/src/BaseDeDatos/MySQL/Funciones/Consumidores.sql
SOURCE ~/netzuela/spuria/src/BaseDeDatos/MySQL/Funciones/CroquisPuntos.sql
SOURCE ~/netzuela/spuria/src/BaseDeDatos/MySQL/Funciones/DescripcionesFotos.sql
SOURCE ~/netzuela/spuria/src/BaseDeDatos/MySQL/Funciones/Estadisticas.sql
SOURCE ~/netzuela/spuria/src/BaseDeDatos/MySQL/Funciones/Mensajes.sql
SOURCE ~/netzuela/spuria/src/BaseDeDatos/MySQL/Funciones/Palabras.sql
SOURCE ~/netzuela/spuria/src/BaseDeDatos/MySQL/Funciones/PatrocinantesPublicidades.sql
SOURCE ~/netzuela/spuria/src/BaseDeDatos/MySQL/Funciones/RegionesGeograficas.sql
SOURCE ~/netzuela/spuria/src/BaseDeDatos/MySQL/Funciones/Registros.sql
SOURCE ~/netzuela/spuria/src/BaseDeDatos/MySQL/Funciones/TiendasProductos.sql
SOURCE ~/netzuela/spuria/src/BaseDeDatos/MySQL/Funciones/Usuarios.sql
SOURCE ~/netzuela/spuria/src/BaseDeDatos/MySQL/Funciones/Ventas.sql
SOURCE ~/netzuela/spuria/src/BaseDeDatos/MySQL/Funciones/UsuariosDelSistema.sql
SOURCE ~/netzuela/spuria/src/BaseDeDatos/MySQL/Funciones/LlamadasAlSistema.sql

SOURCE ~/netzuela/spuria/src/BaseDeDatos/MySQL/Inicializacion.sql

CALL CrearUsuarioValeria();
FLUSH PRIVILEGES;

CALL CrearUsuarioParis();
FLUSH PRIVILEGES;
