SELECT 'SpuriaSinExitHandlers.sql';
DROP DATABASE IF EXISTS `Spuria`;

/* DEBE ejecutarse en este orden */

SOURCE D:\Netzuela\Spuria\BaseDeDatos\Esqueleto.sql

SOURCE D:\Netzuela\Spuria\BaseDeDatos\FuncionesSinExitHandlers\Rastreable.sql
SOURCE D:\Netzuela\Spuria\BaseDeDatos\FuncionesSinExitHandlers\Generales.sql
SOURCE D:\Netzuela\Spuria\BaseDeDatos\FuncionesSinExitHandlers\Busquedas.sql
SOURCE D:\Netzuela\Spuria\BaseDeDatos\FuncionesSinExitHandlers\CalificacionesResenas.sql
SOURCE D:\Netzuela\Spuria\BaseDeDatos\FuncionesSinExitHandlers\Consumidores.sql
SOURCE D:\Netzuela\Spuria\BaseDeDatos\FuncionesSinExitHandlers\CroquisPuntos.sql
SOURCE D:\Netzuela\Spuria\BaseDeDatos\FuncionesSinExitHandlers\DescripcionesFotos.sql
SOURCE D:\Netzuela\Spuria\BaseDeDatos\FuncionesSinExitHandlers\Estadisticas.sql
SOURCE D:\Netzuela\Spuria\BaseDeDatos\FuncionesSinExitHandlers\Mensajes.sql
SOURCE D:\Netzuela\Spuria\BaseDeDatos\FuncionesSinExitHandlers\Palabras.sql
SOURCE D:\Netzuela\Spuria\BaseDeDatos\FuncionesSinExitHandlers\PatrocinantesPublicidades.sql
SOURCE D:\Netzuela\Spuria\BaseDeDatos\FuncionesSinExitHandlers\RegionesGeograficas.sql
SOURCE D:\Netzuela\Spuria\BaseDeDatos\FuncionesSinExitHandlers\Registros.sql
SOURCE D:\Netzuela\Spuria\BaseDeDatos\FuncionesSinExitHandlers\TiendasProductos.sql
SOURCE D:\Netzuela\Spuria\BaseDeDatos\FuncionesSinExitHandlers\Usuarios.sql
SOURCE D:\Netzuela\Spuria\BaseDeDatos\FuncionesSinExitHandlers\Ventas.sql
/*
SOURCE D:\Netzuela\Spuria\BaseDeDatos\FuncionesSinExitHandlers\UsuariosDelSistema.sql
SOURCE D:\Netzuela\Spuria\BaseDeDatos\FuncionesSinExitHandlers\LlamadasAlSistema.sql
*/
SOURCE D:\Netzuela\Spuria\BaseDeDatos\Inicializacion.sql

/*
CALL CrearUsuarioValeria();
FLUSH PRIVILEGES;

CALL CrearUsuarioParis();
FLUSH PRIVILEGES;
*/