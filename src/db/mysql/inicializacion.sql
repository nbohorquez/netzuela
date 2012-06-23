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
INSERT INTO grado_de_instruccion VALUES("Primaria", 1);
INSERT INTO grado_de_instruccion VALUES("Secundaria", 2);
INSERT INTO grado_de_instruccion VALUES("Tecnico Medio", 3);
INSERT INTO grado_de_instruccion VALUES("Tecnico Superior", 4);
INSERT INTO grado_de_instruccion VALUES("Universitaria", 5);
INSERT INTO grado_de_instruccion VALUES("Especializacion", 6);
INSERT INTO grado_de_instruccion VALUES("Maestria", 7);
INSERT INTO grado_de_instruccion VALUES("Doctorado", 8);

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
INSERT INTO dia VALUES("Lunes", 1);
INSERT INTO dia VALUES("Martes", 2);
INSERT INTO dia VALUES("Miercoles", 3);
INSERT INTO dia VALUES("Jueves", 4);
INSERT INTO dia VALUES("Viernes", 5);
INSERT INTO dia VALUES("Sabado", 6);
INSERT INTO dia VALUES("Domingo", 7);

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

/* Contraseña = 1asdXzp91 */
SELECT InsertarAdministrador (
    1, NULL,
    'admin@netzuela.com', 
    '$2a$12$MOM8uMGo9XmH1BDYPrTns.k/WLl6vt45qeKEXn5ZqoiBsQeBMfTQG',
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
SELECT InsertarEstado(@Creador, 'Tachira', 0, 'Espanol', @pyVenezuela, '', 0) INTO @eTachira;

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

/* Esta tabla la vamos a usar para colocar temporalmente los puntos de los poligonos/croquis */
DROP TEMPORARY TABLE IF EXISTS puntos;
CREATE TEMPORARY TABLE puntos (
	`latitud` DECIMAL(9,6) NOT NULL,
	`longitud` DECIMAL(9,6) NOT NULL
) ENGINE=MyISAM;

/* Venezuela */
SELECT t.dibujable_p
FROM territorio AS t
WHERE t.territorio_id = @pyVenezuela COLLATE latin1_spanish_ci
INTO @VenezuelaDibujable;

SELECT InsertarCroquis(@Creador, @VenezuelaDibujable) INTO @VenezuelaCroquis;
DELETE FROM puntos;
INSERT INTO puntos VALUES
(5.178482,-60.688477),
(4.937724,-60.578613),
(4.67498,-60.864258),
(4.499762,-60.974121),
(4.54357,-61.303711),
(4.455951,-61.259766),
(4.390229,-61.501465),
(4.258768,-61.743164),
(4.127285,-61.918945),
(4.105369,-62.116699),
(4.171115,-62.468262),
(4.017699,-62.709961),
(3.710782,-62.731934),
(3.623071,-62.973633),
(3.93002,-63.215332),
(3.973861,-63.413086),
(3.864255,-63.479004),
(3.93002,-63.632812),
(3.951941,-63.830566),
(3.842332,-63.984375),
(4.105369,-64.116211),
(4.127285,-64.555664),
(4.258768,-64.819336),
(3.776559,-64.489746),
(3.623071,-64.182129),
(3.469557,-64.248047),
(3.184394,-64.204102),
(2.723583,-63.984375),
(2.482133,-64.072266),
(2.416276,-63.391113),
(2.196727,-63.369141),
(1.955187,-63.984375),
(1.647722,-64.072266),
(1.428075,-64.379883),
(1.493971,-64.401855),
(1.252342,-64.709473),
(1.120534,-65.01709),
(1.120534,-65.148926),
(0.900842,-65.214844),
(0.922812,-65.324707),
(0.659165,-65.522461),
(0.98872,-65.522461),
(0.966751,-65.786133),
(0.812961,-66.027832),
(0.747049,-66.269531),
(1.186439,-66.84082),
(2.262595,-67.192383),
(2.767478,-67.587891),
(2.855263,-67.851562),
(3.316018,-67.346191),
(3.754634,-67.478027),
(3.732708,-67.565918),
(4.236856,-67.785645),
(4.412137,-67.763672),
(4.54357,-67.82959),
(4.981505,-67.785645),
(5.266008,-67.851562),
(5.50664,-67.609863),
(5.747174,-67.631836),
(6.009459,-67.368164),
(6.227934,-67.5),
(6.293459,-67.82959),
(6.184246,-67.983398),
(6.118708,-68.532715),
(6.20609,-69.060059),
(6.053161,-69.257812),
(6.09686,-69.411621),
(6.926427,-70.070801),
(6.904614,-70.268555),
(7.057282,-70.576172),
(7.057282,-70.905762),
(6.948239,-71.015625),
(7.013668,-72.004395),
(7.340675,-72.158203),
(7.427837,-72.443848),
(7.993957,-72.443848),
(8.015716,-72.355957),
(8.363693,-72.37793),
(8.602747,-72.641602),
(9.123792,-72.773437),
(9.264779,-73.037109),
(9.18887,-73.344727),
(9.838979,-72.927246),
(9.903921,-72.971191),
(10.401378,-72.905273),
(11.070603,-72.487793),
(11.135287,-72.251587),
(11.641476,-71.971436),
(11.840471,-71.328735),
(11.732924,-71.367187),
(11.593051,-71.954956),
(11.275387,-71.905518),
(10.984335,-71.586914),
(10.984335,-71.773682),
(10.736175,-71.641846),
(10.660608,-71.575928),
(10.466206,-71.619873),
(10.09867,-71.905518),
(9.828154,-72.125244),
(9.665738,-72.015381),
(9.503244,-71.993408),
(9.373193,-71.71875),
(9.058702,-71.71875),
(9.134639,-71.268311),
(9.351513,-71.05957),
(9.838979,-71.092529),
(10.325728,-71.466064),
(10.790141,-71.5979),
(10.822515,-71.444092),
(10.898042,-71.422119),
(10.941192,-71.520996),
(11.18918,-70.85083),
(11.501557,-70.070801),
(11.415418,-69.807129),
(11.480025,-69.719238),
(11.673755,-69.807129),
(11.587669,-70.202637),
(11.845847,-70.3125),
(12.082296,-70.224609),
(12.189704,-70.026855),
(12.103781,-69.873047),
(11.759815,-69.763184),
(11.480025,-69.631348),
(11.523088,-69.23584),
(11.415418,-68.840332),
(11.156845,-68.422852),
(10.876465,-68.203125),
(10.790141,-68.291016),
(10.509417,-68.126221),
(10.617418,-67.016602),
(10.617418,-66.335449),
(10.649811,-66.236572),
(10.563422,-66.027832),
(10.509417,-66.115723),
(10.077037,-65.192871),
(10.141932,-64.6875),
(10.401378,-64.182129),
(10.466206,-63.676758),
(10.574222,-64.27002),
(10.660608,-63.808594),
(10.682201,-63.215332),
(10.746969,-62.753906),
(10.682201,-62.270508),
(10.703792,-61.896973),
(10.552622,-62.248535),
(10.53102,-62.819824),
(9.925566,-62.358398),
(10.033767,-62.226562),
(9.838979,-61.611328),
(9.449062,-60.820312),
(9.18887,-60.776367),
(8.581021,-60.600586),
(8.581021,-60.073242),
(8.320212,-59.853516),
(7.798079,-60.46875),
(7.493196,-60.688477),
(7.144499,-60.512695),
(7.144499,-60.292969),
(6.926427,-60.292969),
(6.664608,-61.12793),
(6.489983,-61.12793),
(6.271618,-61.12793),
(5.922045,-61.347656),
(5.178482,-60.688477);
CALL InsertarPuntos(@VenezuelaCroquis);

/* Zulia */
SELECT t.dibujable_p
FROM territorio AS t
WHERE t.territorio_id = @eZulia COLLATE latin1_spanish_ci
INTO @ZuliaDibujable;

SELECT InsertarCroquis(@Creador, @ZuliaDibujable) INTO @ZuliaOesteCroquis;
SELECT InsertarCroquis(@Creador, @ZuliaDibujable) INTO @ZuliaSurCroquis;
SELECT InsertarCroquis(@Creador, @ZuliaDibujable) INTO @ZuliaEsteCroquis;

DELETE FROM puntos;
INSERT INTO puntos VALUES
(8.379997,-72.427368),
(8.472372,-72.372437),
(8.523984,-72.375183),
(8.570158,-72.292786),
(8.553862,-72.226868),
(8.578305,-71.996155),
(8.665203,-71.996155),
(8.64348,-71.971436),
(8.662488,-71.954956),
(8.705929,-71.82312),
(8.659772,-71.765442),
(8.787368,-71.559448),
(8.917634,-71.400146),
(8.955619,-71.394653),
(9.004452,-71.334229),
(9.007164,-71.290283),
(9.047853,-71.229858),
(8.982749,-71.185913),
(9.053277,-71.136475),
(9.123792,-71.147461),
(9.172602,-71.213379),
(9.134639,-71.246338),
(9.107521,-71.323242),
(9.053277,-71.38916),
(9.053277,-71.625366),
(9.020728,-71.663818),
(9.118368,-71.751709),
(9.215982,-71.757202),
(9.270201,-71.751709),
(9.356933,-71.724243),
(9.411129,-71.806641),
(9.411129,-71.867065),
(9.546583,-72.015381),
(9.654908,-72.026367),
(9.817329,-72.13623),
(9.95262,-72.03186),
(10.093262,-71.971436),
(10.125709,-71.894531),
(10.212219,-71.828613),
(10.336536,-71.779175),
(10.439196,-71.619873),
(10.514818,-71.630859),
(10.579622,-71.608887),
(10.633615,-71.608887),
(10.648461,-71.591034),
(10.70649,-71.588287),
(10.757763,-71.669312),
(10.935798,-71.71875),
(10.99512,-71.757202),
(11.011297,-71.735229),
(10.951978,-71.603394),
(11.005904,-71.608887),
(11.119117,-71.795654),
(11.24845,-71.894531),
(11.463874,-71.960449),
(11.587669,-71.960449),
(11.646856,-71.82312),
(11.706031,-71.449585),
(11.743681,-71.427612),
(11.749059,-71.378174),
(11.786703,-71.361694),
(11.786703,-71.339722),
(11.851223,-71.328735),
(11.829718,-71.383667),
(11.813588,-71.383667),
(11.641476,-71.965942),
(11.135287,-72.251587),
(11.151456,-72.344971),
(11.108337,-72.432861),
(11.124507,-72.443848),
(11.081385,-72.487793),
(11.059821,-72.4823),
(10.876465,-72.603149),
(10.876465,-72.652588),
(10.768556,-72.680054),
(10.746969,-72.723999),
(10.703792,-72.718506),
(10.628216,-72.740479),
(10.574222,-72.822876),
(10.471607,-72.855835),
(10.433793,-72.905273),
(10.374362,-72.888794),
(10.131117,-72.91626),
(10.104078,-72.89978),
(10.049994,-72.954712),
(10.017539,-72.949219),
(9.96344,-72.982178),
(9.876864,-72.987671),
(9.833567,-72.938232),
(9.784851,-72.987671),
(9.692813,-73.053589),
(9.562834,-73.086548),
(9.552,-73.125),
(9.503244,-73.168945),
(9.470736,-73.207397),
(9.438224,-73.185425),
(9.40571,-73.240356),
(9.324411,-73.267822),
(9.321701,-73.287048),
(9.213271,-73.328247),
(9.21056,-73.344727),
(9.16989,-73.347473),
(9.150909,-73.251343),
(9.183447,-73.212891),
(9.175313,-73.174438),
(9.199715,-73.144226),
(9.221405,-73.092041),
(9.294596,-73.015137),
(9.243093,-72.979431),
(9.221405,-72.990417),
(9.183447,-72.954712),
(9.148198,-72.982178),
(9.083112,-72.932739),
(9.099385,-72.880554),
(9.131927,-72.880554),
(9.093961,-72.767944),
(8.619041,-72.652588),
(8.586453,-72.614136),
(8.379997,-72.427368);
CALL InsertarPuntos(@ZuliaOesteCroquis);

DELETE FROM puntos;
INSERT INTO puntos VALUES
(9.225471,-71.19278),
(9.16989,-71.118622),
(9.149554,-71.037598),
(9.16989,-70.989532),
(9.266135,-70.995026),
(9.347448,-70.990906),
(9.367773,-71.05545),
(9.317635,-71.060944),
(9.306793,-71.081543);
CALL InsertarPuntos(@ZuliaSurCroquis);

DELETE FROM puntos;
INSERT INTO puntos VALUES
(9.61429,-71.058197),
(9.595334,-70.86731),
(9.761844,-70.692902),
(9.790264,-70.63385),
(9.897157,-70.659943),
(9.902569,-70.684662),
(9.943151,-70.72998),
(9.96344,-70.793152),
(10.031062,-70.85083),
(10.086502,-70.861816),
(10.194649,-70.702515),
(10.298706,-70.655823),
(10.318973,-70.723114),
(10.381116,-70.743713),
(10.437845,-70.762939),
(10.45135,-70.801392),
(10.464855,-70.931854),
(10.506716,-70.999146),
(10.60527,-71.029358),
(10.675453,-71.065063),
(10.752366,-71.081543),
(10.803631,-71.115875),
(10.823864,-71.139221),
(10.841399,-71.148834),
(10.856235,-71.17218),
(10.981639,-71.251831),
(10.965461,-71.321869),
(10.980291,-71.3974),
(10.970854,-71.452332),
(10.954675,-71.460571),
(10.95063,-71.512756),
(10.899391,-71.438599),
(10.911527,-71.411133),
(10.888602,-71.420746),
(10.875116,-71.449585),
(10.825213,-71.434479),
(10.794188,-71.433105),
(10.790815,-71.449585),
(10.798909,-71.500397),
(10.792839,-71.569748),
(10.798235,-71.586914),
(10.785419,-71.591721),
(10.779348,-71.564941),
(10.762485,-71.560135),
(10.758437,-71.536102),
(10.746969,-71.542282),
(10.740898,-71.542969),
(10.738874,-71.533356),
(10.725381,-71.522369),
(10.705816,-71.529922),
(10.695021,-71.521683),
(10.680851,-71.529922),
(10.668705,-71.533699),
(10.654535,-71.521683),
(10.63429,-71.530952),
(10.62113,-71.504173),
(10.611344,-71.49765),
(10.602908,-71.496964),
(10.591771,-71.528206),
(10.587384,-71.531639),
(10.559035,-71.532326),
(10.549247,-71.541252),
(10.540809,-71.523399),
(10.516168,-71.507607),
(10.504691,-71.482201),
(10.491525,-71.461258),
(10.454051,-71.451645),
(10.426365,-71.468124),
(10.41556,-71.467781),
(10.392598,-71.480141),
(10.381454,-71.460228),
(10.359165,-71.433792),
(10.339576,-71.422119),
(10.341602,-71.419373),
(10.328768,-71.413193),
(10.326741,-71.414223),
(10.31323,-71.411133),
(10.269654,-71.37886),
(10.256817,-71.373024),
(10.240938,-71.369247),
(10.225734,-71.365128),
(10.208503,-71.348648),
(10.158491,-71.284447),
(10.119964,-71.259727),
(10.092924,-71.246681),
(10.067234,-71.239815),
(10.02971,-71.233635),
(9.997929,-71.216125),
(9.975275,-71.211319),
(9.968174,-71.203079),
(9.969189,-71.183167),
(9.962764,-71.16703),
(9.947547,-71.148491),
(9.912715,-71.121368),
(9.912715,-71.118965),
(9.886672,-71.100082),
(9.867055,-71.088753),
(9.839318,-71.076736),
(9.826801,-71.077766),
(9.830861,-71.08223),
(9.820374,-71.088066),
(9.808533,-71.086693),
(9.806165,-71.090126),
(9.798722,-71.087723),
(9.798046,-71.082916),
(9.778085,-71.066093),
(9.765566,-71.056824),
(9.751017,-71.048927),
(9.740189,-71.034164),
(9.716164,-71.023178),
(9.711764,-71.023865),
(9.713456,-71.029701),
(9.70838,-71.038971),
(9.678938,-71.048241),
(9.671492,-71.045494),
(9.651523,-71.049614),
(9.642046,-71.048584),
(9.61429,-71.058197);
CALL InsertarPuntos(@ZuliaEsteCroquis);

/* Tachira */
SELECT t.dibujable_p
FROM territorio AS t
WHERE t.territorio_id = @eTachira COLLATE latin1_spanish_ci
INTO @TachiraDibujable;

SELECT InsertarCroquis(@Creador, @TachiraDibujable) INTO @TachiraCroquis;

DELETE FROM puntos;
INSERT INTO puntos VALUES
(8.382714,-72.425995),
(8.443847,-72.405396),
(8.468297,-72.371063),
(8.526701,-72.375183),
(8.571516,-72.284546),
(8.552504,-72.226868),
(8.564726,-72.123871),
(8.570158,-72.014008),
(8.602747,-71.994781),
(8.667918,-71.997528),
(8.635334,-71.967316),
(8.608179,-71.83136),
(8.484597,-71.761322),
(8.428904,-71.792908),
(8.381355,-71.802521),
(8.360975,-71.819),
(8.215568,-71.889038),
(8.162556,-71.891785),
(8.116334,-71.766815),
(8.05515,-71.735229),
(8.022515,-71.688538),
(7.983078,-71.676178),
(7.972198,-71.645966),
(7.992597,-71.571808),
(7.949077,-71.555328),
(7.901471,-71.519623),
(7.663358,-71.512756),
(7.623887,-71.486664),
(7.619803,-71.499023),
(7.588495,-71.508636),
(7.565353,-71.474304),
(7.562631,-71.449585),
(7.528596,-71.434479),
(7.543571,-71.411133),
(7.493196,-71.402893),
(7.48775,-71.354828),
(7.463241,-71.346588),
(7.446901,-71.390533),
(7.464603,-71.445465),
(7.459156,-71.488037),
(7.483665,-71.654205),
(7.49592,-71.695404),
(7.486389,-71.761322),
(7.500004,-71.784668),
(7.494558,-71.850586),
(7.475496,-71.867065),
(7.465964,-71.836853),
(7.433284,-71.806641),
(7.370639,-71.878052),
(7.332503,-71.938477),
(7.340675,-72.034607),
(7.448263,-72.213135),
(7.471411,-72.288666),
(7.450986,-72.442474),
(7.490473,-72.47406),
(7.561269,-72.453461),
(7.645665,-72.475433),
(7.798079,-72.46582),
(7.848417,-72.441101),
(7.912353,-72.458954),
(7.942276,-72.48642),
(8.037473,-72.415009),
(8.006197,-72.346344),
(8.102739,-72.37381),
(8.166634,-72.35321),
(8.257701,-72.394409),
(8.317495,-72.379303),
(8.337877,-72.393036);
CALL InsertarPuntos(@TachiraCroquis);

/* Cabimas */
SELECT t.dibujable_p
FROM territorio AS t
WHERE t.territorio_id = @mCabimas COLLATE latin1_spanish_ci
INTO @CabimasDibujable;

SELECT InsertarCroquis(@Creador, @CabimasDibujable) INTO @CabimasCroquis;
DELETE FROM puntos;
INSERT INTO puntos VALUES
(10.316667, -71.450000),
(10.466667, -70.866667);
CALL InsertarPuntos(@CabimasCroquis);
