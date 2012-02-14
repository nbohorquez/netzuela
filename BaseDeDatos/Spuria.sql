SELECT 'Spuria.sql';
DROP DATABASE IF EXISTS `Spuria`;

/* DEBE ejecutarse en este orden */

SOURCE D:\Netzuela\Spuria\BaseDeDatos\Esqueleto.sql

SOURCE D:\Netzuela\Spuria\BaseDeDatos\Funciones\Rastreable.sql
SOURCE D:\Netzuela\Spuria\BaseDeDatos\Funciones\Generales.sql
SOURCE D:\Netzuela\Spuria\BaseDeDatos\Funciones\Busquedas.sql
SOURCE D:\Netzuela\Spuria\BaseDeDatos\Funciones\CalificacionesResenas.sql
SOURCE D:\Netzuela\Spuria\BaseDeDatos\Funciones\Consumidores.sql
SOURCE D:\Netzuela\Spuria\BaseDeDatos\Funciones\CroquisPuntos.sql
SOURCE D:\Netzuela\Spuria\BaseDeDatos\Funciones\DescripcionesFotos.sql
SOURCE D:\Netzuela\Spuria\BaseDeDatos\Funciones\Estadisticas.sql
SOURCE D:\Netzuela\Spuria\BaseDeDatos\Funciones\Mensajes.sql
SOURCE D:\Netzuela\Spuria\BaseDeDatos\Funciones\Palabras.sql
SOURCE D:\Netzuela\Spuria\BaseDeDatos\Funciones\PatrocinantesPublicidades.sql
SOURCE D:\Netzuela\Spuria\BaseDeDatos\Funciones\RegionesGeograficas.sql
SOURCE D:\Netzuela\Spuria\BaseDeDatos\Funciones\Registros.sql
SOURCE D:\Netzuela\Spuria\BaseDeDatos\Funciones\TiendasProductos.sql
SOURCE D:\Netzuela\Spuria\BaseDeDatos\Funciones\Usuarios.sql
SOURCE D:\Netzuela\Spuria\BaseDeDatos\Funciones\Ventas.sql
SOURCE D:\Netzuela\Spuria\BaseDeDatos\Funciones\UsuariosDelSistema.sql
SOURCE D:\Netzuela\Spuria\BaseDeDatos\Funciones\LlamadasAlSistema.sql

SOURCE D:\Netzuela\Spuria\BaseDeDatos\Inicializacion.sql

CALL CrearUsuarioValeria();
FLUSH PRIVILEGES;

CALL CrearUsuarioParis();
FLUSH PRIVILEGES;