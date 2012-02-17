SELECT 'SpuriaSinExitHandlers.sql';
DROP DATABASE IF EXISTS `Spuria`;

/* DEBE ejecutarse en este orden */

SOURCE D:\Netzuela\Spuria\BaseDeDatos\MySQL\Esqueleto.sql

SOURCE D:\Netzuela\Spuria\BaseDeDatos\MySQL\FuncionesSinExitHandlers\Rastreable.sql
SOURCE D:\Netzuela\Spuria\BaseDeDatos\MySQL\FuncionesSinExitHandlers\Generales.sql
SOURCE D:\Netzuela\Spuria\BaseDeDatos\MySQL\FuncionesSinExitHandlers\Busquedas.sql
SOURCE D:\Netzuela\Spuria\BaseDeDatos\MySQL\FuncionesSinExitHandlers\CalificacionesResenas.sql
SOURCE D:\Netzuela\Spuria\BaseDeDatos\MySQL\FuncionesSinExitHandlers\Consumidores.sql
SOURCE D:\Netzuela\Spuria\BaseDeDatos\MySQL\FuncionesSinExitHandlers\CroquisPuntos.sql
SOURCE D:\Netzuela\Spuria\BaseDeDatos\MySQL\FuncionesSinExitHandlers\DescripcionesFotos.sql
SOURCE D:\Netzuela\Spuria\BaseDeDatos\MySQL\FuncionesSinExitHandlers\Estadisticas.sql
SOURCE D:\Netzuela\Spuria\BaseDeDatos\MySQL\FuncionesSinExitHandlers\Mensajes.sql
SOURCE D:\Netzuela\Spuria\BaseDeDatos\MySQL\FuncionesSinExitHandlers\Palabras.sql
SOURCE D:\Netzuela\Spuria\BaseDeDatos\MySQL\FuncionesSinExitHandlers\PatrocinantesPublicidades.sql
SOURCE D:\Netzuela\Spuria\BaseDeDatos\MySQL\FuncionesSinExitHandlers\RegionesGeograficas.sql
SOURCE D:\Netzuela\Spuria\BaseDeDatos\MySQL\FuncionesSinExitHandlers\Registros.sql
SOURCE D:\Netzuela\Spuria\BaseDeDatos\MySQL\FuncionesSinExitHandlers\TiendasProductos.sql
SOURCE D:\Netzuela\Spuria\BaseDeDatos\MySQL\FuncionesSinExitHandlers\Usuarios.sql
SOURCE D:\Netzuela\Spuria\BaseDeDatos\MySQL\FuncionesSinExitHandlers\Ventas.sql
/*
SOURCE D:\Netzuela\Spuria\BaseDeDatos\MySQL\FuncionesSinExitHandlers\UsuariosDelSistema.sql
SOURCE D:\Netzuela\Spuria\BaseDeDatos\MySQL\FuncionesSinExitHandlers\LlamadasAlSistema.sql
*/
SOURCE D:\Netzuela\Spuria\BaseDeDatos\MySQL\Inicializacion.sql

/*
CALL CrearUsuarioValeria();
FLUSH PRIVILEGES;

CALL CrearUsuarioParis();
FLUSH PRIVILEGES;
*/