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
INSERT INTO idioma VALUES("Mandarin");

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
INSERT INTO accion VALUES("Insertar");
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
SELECT InsertarEtiquetable() INTO @Etiquetable_P;
SELECT '0.00.00.00.00.00' INTO @Cat_0000;
INSERT INTO categoria VALUES (@Etiquetable_P, '0.00.00.00.00.00', 'Inicio', '0.00.00.00.00.00');

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
*						TERRITORIOS						*
*														*
*********************************************************
*/

/* 
   Se crean solo los terriotorios del estado Zulia
*/

/* Insertamos al planeta Tierra primero */
SELECT 'mundo';
SELECT InsertarDibujable() INTO @Dibujable_P;
SELECT InsertarRastreable(@Creador) INTO @Rastreable_P;
SELECT '0.00.00.00.00.00' INTO @Mundo;
INSERT INTO territorio VALUES (@Rastreable_P, @Dibujable_P, @Mundo, 'La Tierra', 0,	'Mandarin',	0, @Mundo, 0, 0, NULL, '', 0);

SELECT InsertarTiendasConsumidores(@Mundo, 0, 0);

SELECT 'paises';
SELECT InsertarPais (
	@Creador, 
	'Venezuela', 
    0,
	'Espanol',
	'', 
	326498000000
) INTO @pyVenezuela;

SELECT 'estados';
SELECT InsertarEstado(@Creador, 'Zulia', 0, 'Espanol', @pyVenezuela, '', 0) INTO @eZulia;

SELECT 'municipios';
/* Municipios del Zulia */
SELECT InsertarMunicipio(@Creador, 'Almirante Padilla', 		0, 		'Espanol', @eZulia, '', 0) INTO @mAPadilla;
SELECT InsertarMunicipio(@Creador, 'Baralt', 					0, 		'Espanol', @eZulia, '', 0) INTO @mBaralt;
SELECT InsertarMunicipio(@Creador, 'Cabimas', 					0, 		'Espanol', @eZulia, '', 0) INTO @mCabimas;
SELECT InsertarMunicipio(@Creador, 'Catatumbo', 				0, 		'Espanol', @eZulia, '', 0) INTO @mCatatumbo;
SELECT InsertarMunicipio(@Creador, 'Colon', 					0, 		'Espanol', @eZulia, '', 0) INTO @mColon;
SELECT InsertarMunicipio(@Creador, 'Francisco Javier Pulgar',	0, 		'Espanol', @eZulia, '', 0) INTO @mFJPulgar;
SELECT InsertarMunicipio(@Creador, 'Jesus Enrique Lossada', 	0, 		'Espanol', @eZulia, '', 0) INTO @mJELossada;
SELECT InsertarMunicipio(@Creador, 'Jesus Maria Semprun', 		0, 		'Espanol', @eZulia, '', 0) INTO @mJMSemprun;
SELECT InsertarMunicipio(@Creador, 'La Canada de Urdaneta', 	0, 		'Espanol', @eZulia, '', 0) INTO @mLaCanada;
SELECT InsertarMunicipio(@Creador, 'Lagunillas', 				0, 		'Espanol', @eZulia, '', 0) INTO @mLagunillas;
SELECT InsertarMunicipio(@Creador, 'Machiques de Perija',		0, 		'Espanol', @eZulia, '', 0) INTO @mMachiques;
SELECT InsertarMunicipio(@Creador, 'Mara', 						0, 		'Espanol', @eZulia, '', 0) INTO @mMara;
SELECT InsertarMunicipio(@Creador, 'Maracaibo', 				0, 		'Espanol', @eZulia, '', 0) INTO @mMaracaibo;
SELECT InsertarMunicipio(@Creador, 'Miranda', 					0, 		'Espanol', @eZulia, '', 0) INTO @mMiranda;
SELECT InsertarMunicipio(@Creador, 'Guajira', 					0, 		'Espanol', @eZulia, '', 0) INTO @mGuajira;
SELECT InsertarMunicipio(@Creador, 'Rosario de Perija', 		0, 		'Espanol', @eZulia, '', 0) INTO @mRosario;
SELECT InsertarMunicipio(@Creador, 'San Francisco', 			0, 		'Espanol', @eZulia, '', 0) INTO @mSanFrancisco;
SELECT InsertarMunicipio(@Creador, 'Santa Rita', 				0, 		'Espanol', @eZulia, '', 0) INTO @mStaRita;
SELECT InsertarMunicipio(@Creador, 'Simon Bolivar', 			0, 		'Espanol', @eZulia, '', 0) INTO @mSBolivar;
SELECT InsertarMunicipio(@Creador, 'Sucre', 					0, 		'Espanol', @eZulia, '', 0) INTO @mSucre;
SELECT InsertarMunicipio(@Creador, 'Valmore Rodriguez', 		0, 		'Espanol', @eZulia, '', 0) INTO @mVRodriguez;

SELECT 'parroquias';

/* Parroquias de Almirante Padilla */
SELECT InsertarParroquia(@Creador, 'Isla de Toas', 				9210, 	'Espanol', @mAPadilla, '4031', 0);
SELECT InsertarParroquia(@Creador, 'Monagas', 					3429, 	'Espanol', @mAPadilla, '3429', 0);

/* Parroquias de Baralt */
SELECT InsertarParroquia(@Creador, 'San Timoteo', 				7214, 	'Espanol', @mBaralt, '4018', 0);
SELECT InsertarParroquia(@Creador, 'General Urdaneta', 			13736, 	'Espanol', @mBaralt, '4001', 0);
SELECT InsertarParroquia(@Creador, 'Libertador', 				24112, 	'Espanol', @mBaralt, '4015', 0);
SELECT InsertarParroquia(@Creador, 'Manuel Guanipa Matos', 		10702, 	'Espanol', @mBaralt, '4022', 0);
SELECT InsertarParroquia(@Creador, 'Marcelino Briceno', 		11245, 	'Espanol', @mBaralt, '4018', 0);
SELECT InsertarParroquia(@Creador, 'Pueblo Nuevo', 				29247, 	'Espanol', @mBaralt, '4015', 0);

/* Parroquias de Cabimas - Poblacion 2012 http://es.wikipedia.org/wiki/Municipio_Cabimas_(Zulia,_Venezuela)) */
SELECT InsertarParroquia(@Creador, 'Ambrosio', 					54412, 	'Espanol', @mCabimas, '4013', 0) INTO @paAmbrosio;

/* ¡El Administrador es de Ambrosio! */
UPDATE usuario
SET usuario.ubicacion = @paAmbrosio
WHERE usuario_id = 1;

SELECT InsertarParroquia(@Creador, 'Aristides Calvani', 		6148, 	'Espanol', @mCabimas, '4013', 0);
SELECT InsertarParroquia(@Creador, 'Carmen Herrera', 			37197, 	'Espanol', @mCabimas, '4013', 0) INTO @paCHerrera;
SELECT InsertarParroquia(@Creador, 'German Rios Linares', 		46195, 	'Espanol', @mCabimas, '4013', 0);
SELECT InsertarParroquia(@Creador, 'Jorge Hernandez', 			56158, 	'Espanol', @mCabimas, '4013', 0);
SELECT InsertarParroquia(@Creador, 'La Rosa', 					29326, 	'Espanol', @mCabimas, '4013', 0) INTO @paLaRosa;
SELECT InsertarParroquia(@Creador, 'Punta Gorda', 				9316, 	'Espanol', @mCabimas, '4013', 0) INTO @paPtaGorda;
SELECT InsertarParroquia(@Creador, 'Romulo Betancourt', 		32302, 	'Espanol', @mCabimas, '4013', 0);
SELECT InsertarParroquia(@Creador, 'San Benito', 				22604, 	'Espanol', @mCabimas, '4013', 0) INTO @paSBenito;

/* Parroquias de Catatumbo - Proyecciones 2010 http://iies.faces.ula.ve/Proyecciones_de_Poblacion/Zulia.htm */
SELECT InsertarParroquia(@Creador, 'Encontrados', 				25525, 	'Espanol', @mCatatumbo, '5101', 0);
SELECT InsertarParroquia(@Creador, 'Udon Perez', 				18692, 	'Espanol', @mCatatumbo, '5101', 0);

/* Parroquias de Colon - Proyecciones 2010 http://iies.faces.ula.ve/Proyecciones_de_Poblacion/Zulia.htm */
SELECT InsertarParroquia(@Creador, 'San Carlos del Zulia', 		21842, 	'Espanol', @mColon, '4001', 0);
SELECT InsertarParroquia(@Creador, 'Moralito', 					30428, 	'Espanol', @mColon, '4001', 0);
SELECT InsertarParroquia(@Creador, 'Santa Barbara', 			49039, 	'Espanol', @mColon, '4001', 0);
SELECT InsertarParroquia(@Creador, 'San Cruz del Zulia', 		7576, 	'Espanol', @mColon, '4001', 0);
SELECT InsertarParroquia(@Creador, 'Urribarri', 				6858, 	'Espanol', @mColon, '4001', 0);

/* Parroquias de Francisco Javier Pulgar - Proyecciones 2010 http://iies.faces.ula.ve/Proyecciones_de_Poblacion/Zulia.htm */
SELECT InsertarParroquia(@Creador, 'Simon Rodriguez', 			6975, 	'Espanol', @mFJPulgar, '4001', 0);
SELECT InsertarParroquia(@Creador, 'Carlos Quevedo', 			6386, 	'Espanol', @mFJPulgar, '4001', 0);
SELECT InsertarParroquia(@Creador, 'Francisco Javier Pulgar', 	13077, 	'Espanol', @mFJPulgar, '4001', 0);

/* Parroquias de Jesus Enrique Lossada - Poblacion 2012 http://es.wikipedia.org/wiki/Municipio_Jes%C3%BAs_Enrique_Losada_(Zulia,_Venezuela) */
SELECT InsertarParroquia(@Creador, 'La Concepcion', 			67157, 	'Espanol', @mJELossada, '4032', 0);
SELECT InsertarParroquia(@Creador, 'San Jose', 					23897, 	'Espanol', @mJELossada, '4021', 0);
SELECT InsertarParroquia(@Creador, 'Mariano Parra Leon', 		9912, 	'Espanol', @mJELossada, '4032', 0);
SELECT InsertarParroquia(@Creador, 'Jose Ramon Yepez', 			14861, 	'Espanol', @mJELossada, '4032', 0);

/* Parroquias de Jesus Maria Semprun - Proyecciones 2010 http://iies.faces.ula.ve/Proyecciones_de_Poblacion/Zulia.htm */
SELECT InsertarParroquia(@Creador, 'Jesus Maria Semprun', 		13349, 	'Espanol', @mJMSemprun, '4032', 0);
SELECT InsertarParroquia(@Creador, 'Bari', 						1561, 	'Espanol', @mJMSemprun, '4032', 0);

/* Parroquias de La Cañada de Urdanta - Poblacion 2012 http://es.wikipedia.org/wiki/Municipio_La_Ca%C3%B1ada_de_Urdaneta_(Zulia,_Venezuela) */
SELECT InsertarParroquia(@Creador, 'Concepcion', 				37680, 	'Espanol', @mLaCanada, '4032', 0);
SELECT InsertarParroquia(@Creador, 'Andres Bello', 				11028, 	'Espanol', @mLaCanada, '4032', 0);
SELECT InsertarParroquia(@Creador, 'Chiquinquira', 				13251, 	'Espanol', @mLaCanada, '4032', 0);
SELECT InsertarParroquia(@Creador, 'El Carmelo', 				9745, 	'Espanol', @mLaCanada, '4032', 0);
SELECT InsertarParroquia(@Creador, 'Potreritos', 				8843, 	'Espanol', @mLaCanada, '4032', 0);

/* Parroquias de Lagunillas - Poblacion 2012 http://es.wikipedia.org/wiki/Municipio_Lagunillas_(Zulia,_Venezuela) */
SELECT InsertarParroquia(@Creador, 'Alonso de Ojeda', 			122124, 'Espanol', @mLagunillas, '4019', 0);
SELECT InsertarParroquia(@Creador, 'Libertad', 					56191, 	'Espanol', @mLagunillas, '4019', 0);
SELECT InsertarParroquia(@Creador, 'Campo Lara', 				5126, 	'Espanol', @mLagunillas, '4019', 0);
SELECT InsertarParroquia(@Creador, 'Eleazar Lopez Contreras', 	3384, 	'Espanol', @mLagunillas, '4019', 0);
SELECT InsertarParroquia(@Creador, 'Venezuela', 				52459, 	'Espanol', @mLagunillas, '4016', 0);

/* Parroquias de Machiques de Perija - Proyecciones 2010 http://iies.faces.ula.ve/Proyecciones_de_Poblacion/Zulia.htm */
SELECT InsertarParroquia(@Creador, 'Libertad', 					99410, 	'Espanol', @mMachiques, '4021', 0);
SELECT InsertarParroquia(@Creador, 'Bartolome de las Casas', 	11346, 	'Espanol', @mMachiques, '4021', 0);
SELECT InsertarParroquia(@Creador, 'Rio Negro', 				4977, 	'Espanol', @mMachiques, '4021', 0);
SELECT InsertarParroquia(@Creador, 'San Jose de Perija', 		9991, 	'Espanol', @mMachiques, '4021', 0);

/* Parroquias de Mara - Poblacion 2012 http://es.wikipedia.org/wiki/Municipio_Mara_(Zulia,_Venezuela) */
SELECT InsertarParroquia(@Creador, 'San Rafael', 					58107, 	'Espanol', @mMara, '4044', 0);
SELECT InsertarParroquia(@Creador, 'La Sierrita', 					55285, 	'Espanol', @mMara, '4044', 0);
SELECT InsertarParroquia(@Creador, 'Las Parcelitas', 				19232, 	'Espanol', @mMara, '4044', 0);
SELECT InsertarParroquia(@Creador, 'Luis de Vicente', 				24141, 	'Espanol', @mMara, '4044', 0);
SELECT InsertarParroquia(@Creador, 'Monsenor Marcos Sergio Godoy',	6651, 	'Espanol', @mMara, '4044', 0);
SELECT InsertarParroquia(@Creador, 'Ricaurte', 						67413, 	'Espanol', @mMara, '4045', 0);
SELECT InsertarParroquia(@Creador, 'Tamare', 						10215, 	'Espanol', @mMara, '4044', 0);

/* Parroquias de Maracaibo - Poblacion 2012 http://es.wikipedia.org/wiki/Municipio_Maracaibo_(Zulia,_Venezuela) */
SELECT InsertarParroquia(@Creador, 'Antonio Borjas Romero', 		63468, 	'Espanol', @mMaracaibo, '4005', 0);
SELECT InsertarParroquia(@Creador, 'Bolivar', 						29491, 	'Espanol', @mMaracaibo, '4001', 0);
SELECT InsertarParroquia(@Creador, 'Cacique Mara', 					76788, 	'Espanol', @mMaracaibo, '4001', 0);
SELECT InsertarParroquia(@Creador, 'Carracciolo Parra Perez', 		62069, 	'Espanol', @mMaracaibo, '4005', 0);
SELECT InsertarParroquia(@Creador, 'Cecilio Acosta', 				71002, 	'Espanol', @mMaracaibo, '4001', 0);
SELECT InsertarParroquia(@Creador, 'Chiquinquira', 					80646, 	'Espanol', @mMaracaibo, '4004 4005', 0);
SELECT InsertarParroquia(@Creador, 'Coquivacoa', 					105880, 'Espanol', @mMaracaibo, '4002', 0);
SELECT InsertarParroquia(@Creador, 'Cristo de Aranza', 				145485, 'Espanol', @mMaracaibo, '4001', 0);
SELECT InsertarParroquia(@Creador, 'Francisco Eugenio Bustamante', 	151121, 'Espanol', @mMaracaibo, '4005', 0);
SELECT InsertarParroquia(@Creador, 'Idelfonso Vasquez', 			112361, 'Espanol', @mMaracaibo, '4005', 0);
SELECT InsertarParroquia(@Creador, 'Juana de Avila', 				90404, 	'Espanol', @mMaracaibo, '4002 4005', 0);
SELECT InsertarParroquia(@Creador, 'Luis Hurtado Higuera', 			75904, 	'Espanol', @mMaracaibo, '4004', 0);
SELECT InsertarParroquia(@Creador, 'Manuel Dagnino', 				106119, 'Espanol', @mMaracaibo, '4001', 0);
SELECT InsertarParroquia(@Creador, 'Olegario Villalobos', 			99881, 	'Espanol', @mMaracaibo, '4002', 0);
SELECT InsertarParroquia(@Creador, 'Raul Leoni', 					83432, 	'Espanol', @mMaracaibo, '4005', 0);
SELECT InsertarParroquia(@Creador, 'Santa Lucia', 					46402, 	'Espanol', @mMaracaibo, '4001', 0);
SELECT InsertarParroquia(@Creador, 'San Isidro', 					11447, 	'Espanol', @mMaracaibo, '', 0);
SELECT InsertarParroquia(@Creador, 'Venancio Pulgar', 				126415, 'Espanol', @mMaracaibo, '', 0);

/* Parroquias de Miranda - Poblacion 2012 http://es.wikipedia.org/wiki/Municipio_Miranda_(Zulia,_Venezuela) */
SELECT InsertarParroquia(@Creador, 'Altagracia', 				55377, 	'Espanol', @mMiranda, '4036', 0);
SELECT InsertarParroquia(@Creador, 'Ana Maria Campos', 			7995, 	'Espanol', @mMiranda, '4036', 0);
SELECT InsertarParroquia(@Creador, 'Faria', 					5563, 	'Espanol', @mMiranda, '4036', 0);
SELECT InsertarParroquia(@Creador, 'San Antonio', 				11147, 	'Espanol', @mMiranda, '4001', 0);
SELECT InsertarParroquia(@Creador, 'San Jose', 					19696, 	'Espanol', @mMiranda, '4036', 0);

/* Parroquias de Guajira - Proyecciones 2010 http://iies.faces.ula.ve/Proyecciones_de_Poblacion/Zulia.htm */
SELECT InsertarParroquia(@Creador, 'Sinamaica', 				6139, 	'Espanol', @mGuajira, '4046', 0);
SELECT InsertarParroquia(@Creador, 'Alta Guajira', 				7846, 	'Espanol', @mGuajira, '4037', 0);
SELECT InsertarParroquia(@Creador, 'Elias Sanchez Rubio', 		15809, 	'Espanol', @mGuajira, '4046', 0);
SELECT InsertarParroquia(@Creador, 'Guajira', 					84226, 	'Espanol', @mGuajira, '4037', 0);

/* Parroquias de Rosario de Perija - Proyecciones 2010 http://iies.faces.ula.ve/Proyecciones_de_Poblacion/Zulia.htm */
SELECT InsertarParroquia(@Creador, 'El Rosario', 				89687, 	'Espanol', @mRosario, '4047', 0);
SELECT InsertarParroquia(@Creador, 'Donaldo Garcia', 			18945, 	'Espanol', @mRosario, '4047', 0);
SELECT InsertarParroquia(@Creador, 'Sixto Zambrano', 			10146, 	'Espanol', @mRosario, '4047', 0);

/* Parroquias de San Francisco - Poblacion 2012 http://es.wikipedia.org/wiki/Municipio_San_Francisco_(Zulia,_Venezuela) */
SELECT InsertarParroquia(@Creador, 'San Francisco', 			154065, 'Espanol', @mSanFrancisco, '4004', 0);
SELECT InsertarParroquia(@Creador, 'El Bajo', 					12852, 	'Espanol', @mSanFrancisco, '4004', 0);
SELECT InsertarParroquia(@Creador, 'Domitila Flores', 			146912,	'Espanol', @mSanFrancisco, '4004', 0);
SELECT InsertarParroquia(@Creador, 'Francisco Ochoa', 			83371, 	'Espanol', @mSanFrancisco, '4004', 0);
SELECT InsertarParroquia(@Creador, 'Los Cortijos', 				12433, 	'Espanol', @mSanFrancisco, '4004', 0);
SELECT InsertarParroquia(@Creador, 'Marcial Hernandez', 		25337, 	'Espanol', @mSanFrancisco, '4004', 0);

/* Parroquias de Santa Rita - Poblacion 2012 http://es.wikipedia.org/wiki/Municipio_Santa_Rita_(Zulia,_Venezuela) */
SELECT InsertarParroquia(@Creador, 'Santa Rita', 				30409, 	'Espanol', @mStaRita, '4020', 0);
SELECT InsertarParroquia(@Creador, 'El Mene', 					6308, 	'Espanol', @mStaRita, '4020', 0);
SELECT InsertarParroquia(@Creador, 'Jose Cenobio Urribarri', 	14439, 	'Espanol', @mStaRita, '4001', 0);
SELECT InsertarParroquia(@Creador, 'Pedro Lucas Urribarri', 	2939, 	'Espanol', @mStaRita, '4001', 0);

/* Parroquias de Simon Bolivar - Poblacion 2012 http://es.wikipedia.org/wiki/Municipio_Sim%C3%B3n_Bol%C3%ADvar_(Zulia,_Venezuela) */
SELECT InsertarParroquia(@Creador, 'Manuel Manrique', 			24458, 	'Espanol', @mSBolivar, '4017', 0);
SELECT InsertarParroquia(@Creador, 'Rafael Maria Baralt', 		17075, 	'Espanol', @mSBolivar, '4017', 0);
SELECT InsertarParroquia(@Creador, 'Rafael Urdaneta', 			5218, 	'Espanol', @mSBolivar, '4017', 0);

/* Parroquias de Sucre - Poblacion 2012 http://es.wikipedia.org/wiki/Municipio_Sim%C3%B3n_Bol%C3%ADvar_(Zulia,_Venezuela) */
SELECT InsertarParroquia(@Creador, 'Bobures', 								6041, 	'Espanol', @mSucre, '3158', 0);
SELECT InsertarParroquia(@Creador, 'El Batey', 								6801, 	'Espanol', @mSucre, '3101', 0);
SELECT InsertarParroquia(@Creador, 'Gibraltar', 							7968, 	'Espanol', @mSucre, '3158', 0);
SELECT InsertarParroquia(@Creador, 'Heras', 								6603, 	'Espanol', @mSucre, '3158', 0);
SELECT InsertarParroquia(@Creador, 'Monsenor Arturo Celestino Alvarez', 	6674, 	'Espanol', @mSucre, '3158', 0);
SELECT InsertarParroquia(@Creador, 'Romulo Gallegos', 						23165, 	'Espanol', @mSucre, '3158', 0);

/* Parroquias de Valmore Rodriguez - Poblacion 2012 http://es.wikipedia.org/wiki/Municipio_Sim%C3%B3n_Bol%C3%ADvar_(Zulia,_Venezuela) */
SELECT InsertarParroquia(@Creador, 'La Victoria', 				13652, 	'Espanol', @mVRodriguez, '4014', 0);
SELECT InsertarParroquia(@Creador, 'Rafael Urdaneta', 			13652, 	'Espanol', @mVRodriguez, '4014', 0);
SELECT InsertarParroquia(@Creador, 'Raul Cuenca', 				13652, 	'Espanol', @mVRodriguez, '4014', 0);
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

SELECT t.dibujable_p
FROM territorio AS t
WHERE t.territorio_id = @pyVenezuela COLLATE latin1_spanish_ci
INTO @VenezuelaDibujable;

SELECT InsertarCroquis(@Creador, @VenezuelaDibujable) INTO @VenezuelaCroquis;
SELECT InsertarPunto(12.200000, -59.797222) INTO @PuntoID1;
SELECT InsertarPunto(00.648056, -73.377222) INTO @PuntoID2;
SELECT InsertarPuntoDeCroquis(@VenezuelaCroquis, @PuntoID1);
SELECT InsertarPuntoDeCroquis(@VenezuelaCroquis, @PuntoID2);

SELECT t.dibujable_p
FROM territorio AS t
WHERE t.territorio_id = @eZulia COLLATE latin1_spanish_ci
INTO @ZuliaDibujable;

SELECT InsertarCroquis(@Creador, @ZuliaDibujable) INTO @ZuliaCroquis;
SELECT InsertarPunto(11.791667, -70.737500) INTO @PuntoID1;
SELECT InsertarPunto(08.208333, -73.378611) INTO @PuntoID2;
SELECT InsertarPuntoDeCroquis(@ZuliaCroquis, @PuntoID1);
SELECT InsertarPuntoDeCroquis(@ZuliaCroquis, @PuntoID2);

SELECT t.dibujable_p
FROM territorio AS t
WHERE t.territorio_id = @mCabimas COLLATE latin1_spanish_ci
INTO @CabimasDibujable;

SELECT InsertarCroquis(@Creador, @CabimasDibujable) INTO @CabimasCroquis;
SELECT InsertarPunto(10.316667, -71.450000) INTO @PuntoID1;
SELECT InsertarPunto(10.466667, -70.866667) INTO @PuntoID2;
SELECT InsertarPuntoDeCroquis(@CabimasCroquis, @PuntoID1);
SELECT InsertarPuntoDeCroquis(@CabimasCroquis, @PuntoID2);
