SELECT 'Spuria.sql';
DROP DATABASE IF EXISTS `Spuria`;

/* DEBE ejecutarse en este orden */

SOURCE D:\Netzuela\Spuria\BaseDeDatos\MySQL\Esqueleto.sql

SOURCE D:\Netzuela\Spuria\BaseDeDatos\MySQL\Funciones\Rastreable.sql
SOURCE D:\Netzuela\Spuria\BaseDeDatos\MySQL\Funciones\Generales.sql
SOURCE D:\Netzuela\Spuria\BaseDeDatos\MySQL\Funciones\Busquedas.sql
SOURCE D:\Netzuela\Spuria\BaseDeDatos\MySQL\Funciones\CalificacionesResenas.sql
SOURCE D:\Netzuela\Spuria\BaseDeDatos\MySQL\Funciones\Consumidores.sql
SOURCE D:\Netzuela\Spuria\BaseDeDatos\MySQL\Funciones\CroquisPuntos.sql
SOURCE D:\Netzuela\Spuria\BaseDeDatos\MySQL\Funciones\DescripcionesFotos.sql
SOURCE D:\Netzuela\Spuria\BaseDeDatos\MySQL\Funciones\Estadisticas.sql
SOURCE D:\Netzuela\Spuria\BaseDeDatos\MySQL\Funciones\Mensajes.sql
SOURCE D:\Netzuela\Spuria\BaseDeDatos\MySQL\Funciones\Palabras.sql
SOURCE D:\Netzuela\Spuria\BaseDeDatos\MySQL\Funciones\PatrocinantesPublicidades.sql
SOURCE D:\Netzuela\Spuria\BaseDeDatos\MySQL\Funciones\RegionesGeograficas.sql
SOURCE D:\Netzuela\Spuria\BaseDeDatos\MySQL\Funciones\Registros.sql
SOURCE D:\Netzuela\Spuria\BaseDeDatos\MySQL\Funciones\TiendasProductos.sql
SOURCE D:\Netzuela\Spuria\BaseDeDatos\MySQL\Funciones\Usuarios.sql
SOURCE D:\Netzuela\Spuria\BaseDeDatos\MySQL\Funciones\Ventas.sql
SOURCE D:\Netzuela\Spuria\BaseDeDatos\MySQL\Funciones\UsuariosDelSistema.sql
SOURCE D:\Netzuela\Spuria\BaseDeDatos\MySQL\Funciones\LlamadasAlSistema.sql

SOURCE D:\Netzuela\Spuria\BaseDeDatos\MySQL\Inicializacion.sql

CALL CrearUsuarioValeria();
FLUSH PRIVILEGES;

CALL CrearUsuarioParis();
FLUSH PRIVILEGES;