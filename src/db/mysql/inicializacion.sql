SELECT 'inicializacion.sql';
USE `spuria`;

/*
*************************************************************
*							  			                    *
*						TABLAS DE BUSQUEDA					*
*										                    *
*************************************************************
*/

SELECT 'codigo_de_error';
/* Estos codigos son inventados... todavia no se ha fijado su utilidad */
INSERT INTO codigo_de_error VALUES("OK");
INSERT INTO codigo_de_error VALUES("Privilegios insuficientes");
INSERT INTO codigo_de_error VALUES("Accion imposible");

SELECT 'privilegios';
/* Estos codigos son inventados... todavia no se ha fijado su utilidad */
INSERT INTO privilegios VALUES("Todos");
INSERT INTO privilegios VALUES("Ninguno");

SELECT 'idioma';
INSERT INTO idioma VALUES("Espanol");
INSERT INTO idioma VALUES("English");
INSERT INTO idioma VALUES("Francais");
INSERT INTO idioma VALUES("Deutsch");

SELECT 'tipo_de_codigo';
/* Hay que considerar tambien otros codigos que no contempla GS-1 como los automotrices */
INSERT INTO tipo_de_codigo VALUES("GTIN-13");
INSERT INTO tipo_de_codigo VALUES("GTIN-8");
INSERT INTO tipo_de_codigo VALUES("GTIN-14");
INSERT INTO tipo_de_codigo VALUES("GS1-128");
INSERT INTO tipo_de_codigo VALUES("Otro");

SELECT 'sexo';
INSERT INTO sexo VALUES("Hombre");
INSERT INTO sexo VALUES("Mujer");

SELECT 'grado_de_instruccion';
INSERT INTO grado_de_instruccion VALUES("Primaria");
INSERT INTO grado_de_instruccion VALUES("Secundaria");
INSERT INTO grado_de_instruccion VALUES("Tecnico Medio");
INSERT INTO grado_de_instruccion VALUES("Tecnico Superior");
INSERT INTO grado_de_instruccion VALUES("Universitaria");
INSERT INTO grado_de_instruccion VALUES("Especializacion");
INSERT INTO grado_de_instruccion VALUES("Maestria");
INSERT INTO grado_de_instruccion VALUES("Doctorado");

SELECT 'visibilidad';
INSERT INTO visibilidad VALUES("Ninguno visible");
INSERT INTO visibilidad VALUES("Cantidad visible");
INSERT INTO visibilidad VALUES("Precio visible");
INSERT INTO visibilidad VALUES("Ambos visibles");

SELECT 'accion';
INSERT INTO accion VALUES("Crear");
INSERT INTO accion VALUES("Abrir");
INSERT INTO accion VALUES("Actualizar");
INSERT INTO accion VALUES("Eliminar");
INSERT INTO accion VALUES("Bloquear");
INSERT INTO accion VALUES("Abrir sesion");
INSERT INTO accion VALUES("Cerrar sesion");

SELECT 'calificacion';
INSERT INTO calificacion VALUES("Bien");
INSERT INTO calificacion VALUES("Mal");

SELECT 'grupo_de_edad';
INSERT INTO grupo_de_edad VALUES("Adolescentes");
INSERT INTO grupo_de_edad VALUES("Adultos jovenes");
INSERT INTO grupo_de_edad VALUES("Adultos maduros");
INSERT INTO grupo_de_edad VALUES("Adultos mayores");
INSERT INTO grupo_de_edad VALUES("Tercera edad");

SELECT 'estatus';
INSERT INTO estatus VALUES("Activo");
INSERT INTO estatus VALUES("Bloqueado");
INSERT INTO estatus VALUES("Eliminado");

SELECT 'dia';
INSERT INTO dia VALUES("Lunes");
INSERT INTO dia VALUES("Martes");
INSERT INTO dia VALUES("Miercoles");
INSERT INTO dia VALUES("Jueves");
INSERT INTO dia VALUES("Viernes");
INSERT INTO dia VALUES("Sabado");
INSERT INTO dia VALUES("Domingo");

SELECT 'huso_horario';
INSERT INTO huso_horario VALUES("-12:00");
INSERT INTO huso_horario VALUES("-11:00");
INSERT INTO huso_horario VALUES("-10:00");
INSERT INTO huso_horario VALUES("-09:30");
INSERT INTO huso_horario VALUES("-09:00");
INSERT INTO huso_horario VALUES("-08:00");
INSERT INTO huso_horario VALUES("-07:00");
INSERT INTO huso_horario VALUES("-06:00");
INSERT INTO huso_horario VALUES("-05:00");
INSERT INTO huso_horario VALUES("-04:30");
INSERT INTO huso_horario VALUES("-04:00");
INSERT INTO huso_horario VALUES("-03:30");
INSERT INTO huso_horario VALUES("-03:00");
INSERT INTO huso_horario VALUES("-02:00");
INSERT INTO huso_horario VALUES("-01:00");
INSERT INTO huso_horario VALUES("00:00");
INSERT INTO huso_horario VALUES("01:00");
INSERT INTO huso_horario VALUES("02:00");
INSERT INTO huso_horario VALUES("03:00");
INSERT INTO huso_horario VALUES("03:30");
INSERT INTO huso_horario VALUES("04:00");
INSERT INTO huso_horario VALUES("04:30");
INSERT INTO huso_horario VALUES("05:00");
INSERT INTO huso_horario VALUES("05:30");
INSERT INTO huso_horario VALUES("05:45");
INSERT INTO huso_horario VALUES("06:00");
INSERT INTO huso_horario VALUES("06:30");
INSERT INTO huso_horario VALUES("07:00");
INSERT INTO huso_horario VALUES("08:00");
INSERT INTO huso_horario VALUES("08:45");
INSERT INTO huso_horario VALUES("09:00");
INSERT INTO huso_horario VALUES("09:30");
INSERT INTO huso_horario VALUES("10:00");
INSERT INTO huso_horario VALUES("10:30");
INSERT INTO huso_horario VALUES("11:00");
INSERT INTO huso_horario VALUES("11:30");
INSERT INTO huso_horario VALUES("12:00");
INSERT INTO huso_horario VALUES("12:45");
INSERT INTO huso_horario VALUES("13:00");
INSERT INTO huso_horario VALUES("14:00");

/*
*********************************************************
*														*
*						CATEGORIAS						*
*														*
*********************************************************
*/

SELECT 'categorias';

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

/* La categoria 'Inicio' es hija de ella misma */
SELECT InsertarCategoria('Inicio', -1) INTO @Cat_0000;
UPDATE categoria SET hijo_de_categoria = @Cat_0000 WHERE categoria_id = @Cat_0000;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

/* Hay que agregarle las subdivisiones (mas adelante) */
SELECT InsertarCategoria('Libros', @Cat_0000) INTO @Cat_1000;
SELECT InsertarCategoria('Novelas', @Cat_1000) INTO @Cat_1100;
SELECT InsertarCategoria('Poesia', @Cat_1000) INTO @Cat_1200;
SELECT InsertarCategoria('Tecnicos', @Cat_1000) INTO @Cat_1300;
SELECT InsertarCategoria('Negocios', @Cat_1000) INTO @Cat_1400;
SELECT InsertarCategoria('Cocina', @Cat_1000) INTO @Cat_1500;

SELECT InsertarCategoria('Computacion - Electronica', @Cat_0000) INTO @Cat_2000;
SELECT InsertarCategoria('Instrumentos musicales', @Cat_2000) INTO @Cat_2100;
SELECT InsertarCategoria('Consolas de videojuegos', @Cat_2000) INTO @Cat_2200;
SELECT InsertarCategoria('Juegos de video', @Cat_2000) INTO @Cat_2300;
SELECT InsertarCategoria('Procesadores', @Cat_2000) INTO @Cat_2400;
SELECT InsertarCategoria('Tarjetas madres', @Cat_2000) INTO @Cat_2500;
SELECT InsertarCategoria('Memorias', @Cat_2000) INTO @Cat_2600;
SELECT InsertarCategoria('Discos duros', @Cat_2000) INTO @Cat_2700;
SELECT InsertarCategoria('Camaras fotograficas', @Cat_2000) INTO @Cat_2800;
SELECT InsertarCategoria('Camaras de video', @Cat_2000) INTO @Cat_2900;
SELECT InsertarCategoria('Telefonos celulares', @Cat_2000) INTO @Cat_2A00;
SELECT InsertarCategoria('Computadoras de escritorio', @Cat_2000) INTO @Cat_2B00;
SELECT InsertarCategoria('Computadoras portatiles', @Cat_2000) INTO @Cat_2C00;

SELECT InsertarCategoria('Alimentos - Hogar', @Cat_0000) INTO @Cat_3000;
SELECT InsertarCategoria('Canasta basica', @Cat_3000) INTO @Cat_3100;
SELECT InsertarCategoria('Limpieza', @Cat_3000) INTO @Cat_3200;
SELECT InsertarCategoria('Aseo personal', @Cat_3000) INTO @Cat_3300;
SELECT InsertarCategoria('Viveres', @Cat_3000) INTO @Cat_3400;
SELECT InsertarCategoria('Carnes', @Cat_3000) INTO @Cat_3500;
SELECT InsertarCategoria('Enlatados', @Cat_3000) INTO @Cat_3600;

SELECT InsertarCategoria('Juguetes - Ninos', @Cat_0000) INTO @Cat_4000;
SELECT InsertarCategoria('Peluches', @Cat_4000) INTO @Cat_4100;
SELECT InsertarCategoria('Figuras de accion', @Cat_4000) INTO @Cat_4200;
SELECT InsertarCategoria('Munecas', @Cat_4000) INTO @Cat_4300;
SELECT InsertarCategoria('Trenes', @Cat_4000) INTO @Cat_4400;
SELECT InsertarCategoria('Aviones', @Cat_4000) INTO @Cat_4500;

SELECT InsertarCategoria('Ropa - Calzado', @Cat_0000) INTO @Cat_5000;
SELECT InsertarCategoria('Ropa para damas', @Cat_5000) INTO @Cat_5100;
SELECT InsertarCategoria('Ropa para caballeros', @Cat_5000) INTO @Cat_5200;
SELECT InsertarCategoria('Calzado para damas', @Cat_5000) INTO @Cat_5300;
SELECT InsertarCategoria('Calzado para caballeros', @Cat_5000) INTO @Cat_5400;

SELECT InsertarCategoria('Deportes - Aire libre', @Cat_0000) INTO @Cat_6000;
SELECT InsertarCategoria('Futbol', @Cat_6000) INTO @Cat_6100;
SELECT InsertarCategoria('Baloncesto', @Cat_6000) INTO @Cat_6200;
SELECT InsertarCategoria('Tenis', @Cat_6000) INTO @Cat_6300;
SELECT InsertarCategoria('Rugby', @Cat_6000) INTO @Cat_6400;
SELECT InsertarCategoria('Beisbol', @Cat_6000) INTO @Cat_6500;
SELECT InsertarCategoria('Rapel', @Cat_6000) INTO @Cat_6600;
SELECT InsertarCategoria('Montanismo', @Cat_6000) INTO @Cat_6700;

SELECT InsertarCategoria('Ferreterias', @Cat_0000) INTO @Cat_7000;
SELECT InsertarCategoria('Herramientas electricas', @Cat_7000) INTO @Cat_7100;
SELECT InsertarCategoria('Construccion', @Cat_7000) INTO @Cat_7200;
SELECT InsertarCategoria('Herramientas manuales', @Cat_7000) INTO @Cat_7300;
SELECT InsertarCategoria('Pinturas', @Cat_7000) INTO @Cat_7400;
SELECT InsertarCategoria('Lamparas', @Cat_7000) INTO @Cat_7500;
SELECT InsertarCategoria('Electricidad', @Cat_7000) INTO @Cat_7600;

SELECT InsertarCategoria('Automotriz - Industrial', @Cat_0000) INTO @Cat_8000;
SELECT InsertarCategoria('Motores', @Cat_8000) INTO @Cat_8100;
SELECT InsertarCategoria('Alternadores', @Cat_8000) INTO @Cat_8200;
SELECT InsertarCategoria('Autoperiquitos', @Cat_8000) INTO @Cat_8300;
SELECT InsertarCategoria('Baterias', @Cat_8000) INTO @Cat_8400;

SELECT InsertarCategoria('No asignada', @Cat_0000) INTO @CategoriaNoAsignada;

/*
*************************************************************
*							  								*
*						ADMINISTRADOR		                *
*															*
*************************************************************
*/

SELECT 'administrador';

/* Las condiciones de borde (el primero y el ultimo) siempre joden. En este caso, el primer administrador... */

SELECT InsertarAdministrador (
    1, NULL,
    'admin@netzuela.com', 
    '1asdXzp91',
    'Activo', 
    'Todos', 
    'Nestor',
    'Bohorquez'
) INTO @Creador;

/*
*********************************************************
*                                                     	*
*					REGIONES GEOGRAFICAS				*
*														*
*********************************************************
*/

/* 
   Se crean solo las regiones geograficas necesarias para representar 
   completamente a las parroquias de Cabimas
*/

SELECT 'continentes';
/* Continentes del mundo */
SELECT InsertarContinente(@Creador, 'Africa', 1000000000);
SELECT InsertarContinente(@Creador, 'America', 910717000) INTO @coAmerica;
SELECT InsertarContinente(@Creador, 'Asia', 3879000000);
SELECT InsertarContinente(@Creador, 'Europa', 739000000);
SELECT InsertarContinente(@Creador, 'Oceania', 33000000);

SELECT 'ciudades';
/* Es necesario crear Caracas D.C. para poder definir a Venezuela */
SELECT InsertarCiudad(@Creador, 'Caracas D.C.', 2109166) INTO @ciCaracas;
SELECT InsertarCiudad(@Creador, 'Maracaibo', 1897655) INTO @ciMaracaibo;

SELECT 'paises';
SELECT InsertarPais (
    @Creador, 
    'Venezuela', 
    28892735, 
    @coAmerica, 
    @ciCaracas, 
    'Espanol', 
    'Bolivar', 
    4.30, 326498000000
) INTO @pyVenezuela;

SELECT 'estados';
SELECT InsertarEstado(@Creador, 'Zulia', 3887171, @pyVenezuela, '-04:30', NULL) INTO @eZulia;

SELECT 'municipios';
/* Municipios del Zulia */
SELECT InsertarMunicipio(@Creador, 'Almirante Padilla',         0,	@eZulia, NULL) INTO @mAPadilla;
SELECT InsertarMunicipio(@Creador, 'Baralt',                    0,	@eZulia, NULL) INTO @mBaralt;
SELECT InsertarMunicipio(@Creador, 'Cabimas',                   0,	@eZulia, NULL) INTO @mCabimas;
SELECT InsertarMunicipio(@Creador, 'Catatumbo',                 0,	@eZulia, NULL) INTO @mCatatumbo;
SELECT InsertarMunicipio(@Creador, 'Colon',                     0,	@eZulia, NULL) INTO @mColon;
SELECT InsertarMunicipio(@Creador, 'Francisco Javier Pulgar',   0,	@eZulia, NULL) INTO @mFJPulgar;
SELECT InsertarMunicipio(@Creador, 'Jesus Enrique Lossada',     0,	@eZulia, NULL) INTO @mJELossada;
SELECT InsertarMunicipio(@Creador, 'Jesus Maria Semprun', 	    0,	@eZulia, NULL) INTO @mJMSemprun;
SELECT InsertarMunicipio(@Creador, 'La Canada de Urdaneta',     0,	@eZulia, NULL) INTO @mLaCanada;
SELECT InsertarMunicipio(@Creador, 'Lagunillas',                0,	@eZulia, NULL) INTO @mLagunillas;
SELECT InsertarMunicipio(@Creador, 'Machiques de Perija', 	    0,	@eZulia, NULL) INTO @mMachiques;
SELECT InsertarMunicipio(@Creador, 'Mara',                      0,	@eZulia, NULL) INTO @mMara;
SELECT InsertarMunicipio(@Creador, 'Maracaibo',                 0,	@eZulia, @MaracaiboID) INTO @mMaracaibo;
SELECT InsertarMunicipio(@Creador, 'Miranda',					0,	@eZulia, NULL) INTO @mMiranda;
SELECT InsertarMunicipio(@Creador, 'Guajira',					0,	@eZulia, NULL) INTO @mGuajira;
SELECT InsertarMunicipio(@Creador, 'Rosario de Perija',         0,	@eZulia, NULL) INTO @mRosario;
SELECT InsertarMunicipio(@Creador, 'San Francisco',             0,	@eZulia, @MaracaiboID) INTO @mSanFranciso;
SELECT InsertarMunicipio(@Creador, 'Santa Rita',                0,	@eZulia, NULL) INTO @mStaRita;
SELECT InsertarMunicipio(@Creador, 'Simon Bolivar',             0,	@eZulia, NULL) INTO @mSBolivar;
SELECT InsertarMunicipio(@Creador, 'Sucre',                     0,	@eZulia, NULL) INTO @mSucre;
SELECT InsertarMunicipio(@Creador, 'Valmore Rodriguez',         0,	@eZulia, NULL) INTO @mVRodriguez;

SELECT 'parroquias';

/* Parroquias de Almirante Padilla */
SELECT InsertarParroquia(@Creador, 'Isla de Toas',				9210, 	@mAPadilla, '4031');
SELECT InsertarParroquia(@Creador, 'Monagas',					3429, 	@mAPadilla, '4044');

/* Parroquias de Baralt */
SELECT InsertarParroquia(@Creador, 'San Timoteo', 				7214,	@mBaralt, '4018');
SELECT InsertarParroquia(@Creador, 'General Urdaneta', 			13736,	@mBaralt, '4001');
SELECT InsertarParroquia(@Creador, 'Libertador', 				24112,	@mBaralt, '4015');
SELECT InsertarParroquia(@Creador, 'Manuel Guanipa Matos',		10702,	@mBaralt, '4022');
SELECT InsertarParroquia(@Creador, 'Marcelino Briceno', 		11245,	@mBaralt, '4018');
SELECT InsertarParroquia(@Creador, 'Pueblo Nuevo', 				29247,	@mBaralt, '4015');

/* Parroquias de Cabimas - Poblacion 2012 http://es.wikipedia.org/wiki/Municipio_Cabimas_(Zulia,_Venezuela)) */
SELECT InsertarParroquia(@Creador, 'Ambrosio',					54412, 	@mCabimas, '4013') INTO @paAmbrosio;

/* ¡El Administrador es de Ambrosio! */
UPDATE usuario
SET usuario.parroquia = @paAmbrosio
WHERE usuario_id = 1;

SELECT InsertarParroquia(@Creador, 'Aristides Calvani', 		6148, 	@mCabimas, '4013');
SELECT InsertarParroquia(@Creador, 'Carmen Herrera',        	37197, 	@mCabimas, '4013');
SELECT InsertarParroquia(@Creador, 'German Rios Linares', 		46195, 	@mCabimas, '4013');
SELECT InsertarParroquia(@Creador, 'Jorge Hernandez',       	56158, 	@mCabimas, '4013');
SELECT InsertarParroquia(@Creador, 'La Rosa', 			        29326, 	@mCabimas, '4013') INTO @paLaRosa;
SELECT InsertarParroquia(@Creador, 'Punta Gorda', 			    9316, 	@mCabimas, '4013') INTO @paPtaGorda;
SELECT InsertarParroquia(@Creador, 'Romulo Betancourt', 		32302, 	@mCabimas, '4013');
SELECT InsertarParroquia(@Creador, 'San Benito',            	22604, 	@mCabimas, '4013') INTO @paSBenito;

/* Parroquias de Catatumbo - Proyecciones 2010 http://iies.faces.ula.ve/Proyecciones_de_Poblacion/Zulia.htm */
SELECT InsertarParroquia(@Creador, 'Encontrados', 				25525, 	@mCatatumbo, '5101');
SELECT InsertarParroquia(@Creador, 'Udon Perez', 				18692, 	@mCatatumbo, '5101');

/* Parroquias de Colon - Proyecciones 2010 http://iies.faces.ula.ve/Proyecciones_de_Poblacion/Zulia.htm */
SELECT InsertarParroquia(@Creador, 'San Carlos del Zulia', 		21842, 	@mColon, '4001');
SELECT InsertarParroquia(@Creador, 'Moralito', 					30428, 	@mColon, '4001');
SELECT InsertarParroquia(@Creador, 'Santa Barbara', 			49039, 	@mColon, '4001');
SELECT InsertarParroquia(@Creador, 'San Cruz del Zulia', 		7576, 	@mColon, '4001');
SELECT InsertarParroquia(@Creador, 'Urribarri', 				6858, 	@mColon, '4001');

/* Parroquias de Francisco Javier Pulgar - Proyecciones 2010 http://iies.faces.ula.ve/Proyecciones_de_Poblacion/Zulia.htm */
SELECT InsertarParroquia(@Creador, 'Simon Rodriguez', 			6975, 	@mFJPulgar, '4001');
SELECT InsertarParroquia(@Creador, 'Carlos Quevedo', 			6386, 	@mFJPulgar, '4001');
SELECT InsertarParroquia(@Creador, 'Francisco Javier Pulgar', 	13077, 	@mFJPulgar, '4001');

/* Parroquias de Jesus Enrique Lossada - Poblacion 2012 http://es.wikipedia.org/wiki/Municipio_Jes%C3%BAs_Enrique_Losada_(Zulia,_Venezuela) */
SELECT InsertarParroquia(@Creador, 'La Concepcion', 			67157, 	@mJELossada, '4032');
SELECT InsertarParroquia(@Creador, 'San Jose', 					23897, 	@mJELossada, '4021');
SELECT InsertarParroquia(@Creador, 'Mariano Parra Leon', 		9912, 	@mJELossada, '4032');
SELECT InsertarParroquia(@Creador, 'Jose Ramon Yepez', 			14861, 	@mJELossada, '4032');

/* Parroquias de Jesus Maria Semprun - Proyecciones 2010 http://iies.faces.ula.ve/Proyecciones_de_Poblacion/Zulia.htm */

SELECT InsertarParroquia(@Creador, 'Jesus Maria Semprun', 		13349, 	@mJMSemprun, '4032');
SELECT InsertarParroquia(@Creador, 'Bari', 						1561, 	@mJMSemprun, '4032');

/* Parroquias de La Cañada de Urdanta - Poblacion 2012 http://es.wikipedia.org/wiki/Municipio_La_Ca%C3%B1ada_de_Urdaneta_(Zulia,_Venezuela) */

SELECT InsertarParroquia(@Creador, 'Concepcion', 				37680, 	@mLaCanada, '4001');
SELECT InsertarParroquia(@Creador, 'Andres Bello', 				11028, 	@mLaCanada, '4001');
SELECT InsertarParroquia(@Creador, 'Chiquinquira', 				13251, 	@mLaCanada, '4001');
SELECT InsertarParroquia(@Creador, 'El Carmelo', 				9745, 	@mLaCanada, '4005');
SELECT InsertarParroquia(@Creador, 'Potreritos', 				8843, 	@mLaCanada, '4001');

/* Parroquias de Lagunillas - Poblacion 2012 http://es.wikipedia.org/wiki/Municipio_Lagunillas_(Zulia,_Venezuela) */
SELECT InsertarParroquia(@Creador, 'Alonso de Ojeda', 			122124, @mLagunillas, '4019');
SELECT InsertarParroquia(@Creador, 'Libertad', 					56191, 	@mLagunillas, '4019');
SELECT InsertarParroquia(@Creador, 'Campo Lara', 				5126, 	@mLagunillas, '4019');
SELECT InsertarParroquia(@Creador, 'Eleazar Lopez Contreras', 	3384, 	@mLagunillas, '4019');
SELECT InsertarParroquia(@Creador, 'Venezuela', 				52459, 	@mLagunillas, '4016');

/* Parroquias de Machiques de Perija - Proyecciones 2010 http://iies.faces.ula.ve/Proyecciones_de_Poblacion/Zulia.htm */
SELECT InsertarParroquia(@Creador, 'Libertad', 					99410, 	@mMachiques, '4021');
SELECT InsertarParroquia(@Creador, 'Bartolome de las Casas', 	11346, 	@mMachiques, '4021');
SELECT InsertarParroquia(@Creador, 'Rio Negro', 				4977, 	@mMachiques, '4021');
SELECT InsertarParroquia(@Creador, 'San Jose de Perija', 		9991, 	@mMachiques, '4021');

/* Parroquias de Mara - Poblacion 2012 http://es.wikipedia.org/wiki/Municipio_Mara_(Zulia,_Venezuela) */
SELECT InsertarParroquia(@Creador, 'San Rafael', 					58107, 	@mMachiques, '4044');
SELECT InsertarParroquia(@Creador, 'La Sierrita', 					55285, 	@mMachiques, '4044');
SELECT InsertarParroquia(@Creador, 'Las Parcelitas', 				19232, 	@mMachiques, '4044');
SELECT InsertarParroquia(@Creador, 'Luis de Vicente', 				24141, 	@mMachiques, '4044');
SELECT InsertarParroquia(@Creador, 'Monsenor Marcos Sergio Godoy', 	6651, 	@mMachiques, '4044');
SELECT InsertarParroquia(@Creador, 'Ricaurte', 						67413, 	@mMachiques, '4045');
SELECT InsertarParroquia(@Creador, 'Tamare', 						10215, 	@mMachiques, '4044');

/* Parroquias de Maracaibo - Poblacion 2012 http://es.wikipedia.org/wiki/Municipio_Maracaibo_(Zulia,_Venezuela) */
SELECT InsertarParroquia(@Creador, 'Antonio Borjas Romero', 		63468, 	@mMaracaibo, '4005');
SELECT InsertarParroquia(@Creador, 'Bolivar', 						29491, 	@mMaracaibo, '4001');
SELECT InsertarParroquia(@Creador, 'Cacique Mara', 					76788, 	@mMaracaibo, '4001');
SELECT InsertarParroquia(@Creador, 'Carracciolo Parra Perez', 		62069, 	@mMaracaibo, '4005');
SELECT InsertarParroquia(@Creador, 'Cecilio Acosta', 				71002, 	@mMaracaibo, '4001');
SELECT InsertarParroquia(@Creador, 'Chiquinquira', 					80646, 	@mMaracaibo, '4004 4005');
SELECT InsertarParroquia(@Creador, 'Coquivacoa', 					105880, @mMaracaibo, '4002');
SELECT InsertarParroquia(@Creador, 'Cristo de Aranza', 				145485, @mMaracaibo, '4001');
SELECT InsertarParroquia(@Creador, 'Francisco Eugenio Bustamante', 	151121, @mMaracaibo, '4005');
SELECT InsertarParroquia(@Creador, 'Idelfonso Vasquez', 			112361, @mMaracaibo, '4005');
SELECT InsertarParroquia(@Creador, 'Juana de Avila', 				90404, 	@mMaracaibo, '4002 4005');
SELECT InsertarParroquia(@Creador, 'Luis Hurtado Higuera', 			75904, 	@mMaracaibo, '4004');
SELECT InsertarParroquia(@Creador, 'Manuel Dagnino', 				106119, @mMaracaibo, '4001');
SELECT InsertarParroquia(@Creador, 'Olegario Villalobos', 			99881, 	@mMaracaibo, '4002');
SELECT InsertarParroquia(@Creador, 'Raul Leoni', 					83432, 	@mMaracaibo, '4005');
SELECT InsertarParroquia(@Creador, 'Santa Lucia', 					46402, 	@mMaracaibo, '4001');
SELECT InsertarParroquia(@Creador, 'San Isidro', 					11447, 	@mMaracaibo, '');
SELECT InsertarParroquia(@Creador, 'Venancio Pulgar', 				126415, @mMaracaibo, '');

/* Parroquias de Miranda - Poblacion 2012 http://es.wikipedia.org/wiki/Municipio_Miranda_(Zulia,_Venezuela) */
SELECT InsertarParroquia(@Creador, 'Altagracia', 					55377, 	@mMiranda, '4036');
SELECT InsertarParroquia(@Creador, 'Ana Maria Campos', 				7995, 	@mMiranda, '4036');
SELECT InsertarParroquia(@Creador, 'Faria', 						5563, 	@mMiranda, '4036');
SELECT InsertarParroquia(@Creador, 'San Antonio', 					11147, 	@mMiranda, '4001');
SELECT InsertarParroquia(@Creador, 'San Jose', 						19696, 	@mMiranda, '4036');

/* Parroquias de Guajira - Proyecciones 2010 http://iies.faces.ula.ve/Proyecciones_de_Poblacion/Zulia.htm */
SELECT InsertarParroquia(@Creador, 'Sinamaica', 					6139, 	@mGuajira, '4046');
SELECT InsertarParroquia(@Creador, 'Alta Guajira', 					7846, 	@mGuajira, '4037');
SELECT InsertarParroquia(@Creador, 'Elias Sanchez Rubio', 			15809, 	@mGuajira, '4046');
SELECT InsertarParroquia(@Creador, 'Guajira', 						84226, 	@mGuajira, '4037');

/* Parroquias de Rosario de Perija - Proyecciones 2010 http://iies.faces.ula.ve/Proyecciones_de_Poblacion/Zulia.htm */
SELECT InsertarParroquia(@Creador, 'El Rosario', 					89687, 	@mRosario, '4047');
SELECT InsertarParroquia(@Creador, 'Donaldo Garcia', 				18945, 	@mRosario, '4047');
SELECT InsertarParroquia(@Creador, 'Sixto Zambrano', 				10146, 	@mRosario, '4047');

/* Parroquias de San Francisco - Poblacion 2012 http://es.wikipedia.org/wiki/Municipio_San_Francisco_(Zulia,_Venezuela) */
SELECT InsertarParroquia(@Creador, 'San Francisco', 				154065, @mSanFranciso, '4004');
SELECT InsertarParroquia(@Creador, 'El Bajo', 						12852, 	@mSanFranciso, '4004');
SELECT InsertarParroquia(@Creador, 'Domitila Flores', 				146912, @mSanFranciso, '4004');
SELECT InsertarParroquia(@Creador, 'Francisco Ochoa', 				83371, 	@mSanFranciso, '4004');
SELECT InsertarParroquia(@Creador, 'Los Cortijos', 					12433, 	@mSanFranciso, '4004');
SELECT InsertarParroquia(@Creador, 'Marcial Hernandez', 			25337, 	@mSanFranciso, '4004');

/* Parroquias de Santa Rita - Poblacion 2012 http://es.wikipedia.org/wiki/Municipio_Santa_Rita_(Zulia,_Venezuela) */
SELECT InsertarParroquia(@Creador, 'Santa Rita', 					30409, 	@mStaRita, '4020');
SELECT InsertarParroquia(@Creador, 'El Mene', 						6308, 	@mStaRita, '4020');
SELECT InsertarParroquia(@Creador, 'Jose Cenobio Urribarri', 		14439, 	@mStaRita, '4001');
SELECT InsertarParroquia(@Creador, 'Pedro Lucas Urribarri', 		2939, 	@mStaRita, '4001');

/* Parroquias de Simon Bolivar - Poblacion 2012 http://es.wikipedia.org/wiki/Municipio_Sim%C3%B3n_Bol%C3%ADvar_(Zulia,_Venezuela) */
SELECT InsertarParroquia(@Creador, 'Manuel Manrique', 				24458, 	@mSBolivar, '4017');
SELECT InsertarParroquia(@Creador, 'Rafael Maria Baralt', 			17075, 	@mSBolivar, '4017');
SELECT InsertarParroquia(@Creador, 'Rafael Urdaneta', 				5218, 	@mSBolivar, '4017');

/* Parroquias de Sucre - Poblacion 2012 http://es.wikipedia.org/wiki/Municipio_Sim%C3%B3n_Bol%C3%ADvar_(Zulia,_Venezuela) */
SELECT InsertarParroquia(@Creador, 'Bobures', 							6041, 	@mSucre, '3158');
SELECT InsertarParroquia(@Creador, 'El Batey', 							6801, 	@mSucre, '3101');
SELECT InsertarParroquia(@Creador, 'Gibraltar', 						7968, 	@mSucre, '3158');
SELECT InsertarParroquia(@Creador, 'Heras', 							6603, 	@mSucre, '3158');
SELECT InsertarParroquia(@Creador, 'Monsenor Arturo Celestino Alvarez', 6674, 	@mSucre, '3158');
SELECT InsertarParroquia(@Creador, 'Romulo Gallegos', 					23165, 	@mSucre, '3158');

/* Parroquias de Valmore Rodriguez - Poblacion 2012 http://es.wikipedia.org/wiki/Municipio_Sim%C3%B3n_Bol%C3%ADvar_(Zulia,_Venezuela) */
SELECT InsertarParroquia(@Creador, 'La Victoria', 					13652, 	@mVRodriguez, '4014');
SELECT InsertarParroquia(@Creador, 'Rafael Urdaneta', 				13652, 	@mVRodriguez, '4014');
SELECT InsertarParroquia(@Creador, 'Raul Cuenca', 					13652, 	@mVRodriguez, '4014');

/*
*********************************************************
*                                                     	*
*					PUNTOS Y CROQUIS					*
*														*
*********************************************************
*/

/* 
Deja de joderte la vida, Google ya hizo esta tarea por vos. Simplemente hace un sencillo programa en python que se encargue de pedir esa informacion. Ver: https://developers.google.com/maps/documentation/geocoding/?hl=es
*/
/*
SELECT r.dibujable_p
FROM region_geografica AS r
WHERE r.nombre = 'Zulia'
INTO @ZuliaDibujable;

SELECT InsertarCroquis(@Creador, @ZuliaDibujable) INTO @ZuliaCroquis;
SELECT InsertarPunto(10.401457,-71.470045) INTO @PuntoID1;
SELECT InsertarPuntoDeCroquis(@ZuliaCroquis, @PuntoID1);
*/
