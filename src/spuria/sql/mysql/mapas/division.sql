/*
*********************************************************
*                                                     	*
*	DIVISON POLITICO-ADMINISTRATIVA DE VENEZUELA		*
*														*
*********************************************************
*/

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
SELECT InsertarEstado(@Creador, 'Amazonas', 		0, 'Espanol', @pyVenezuela, '', 0) INTO @eAmazonas;
SELECT InsertarEstado(@Creador, 'Anzoategui', 		0, 'Espanol', @pyVenezuela, '', 0) INTO @eAnzoategui;
SELECT InsertarEstado(@Creador, 'Apure', 			0, 'Espanol', @pyVenezuela, '', 0) INTO @eApure;
SELECT InsertarEstado(@Creador, 'Aragua', 			0, 'Espanol', @pyVenezuela, '', 0) INTO @eAragua;
SELECT InsertarEstado(@Creador, 'Barinas', 			0, 'Espanol', @pyVenezuela, '', 0) INTO @eBarinas;
SELECT InsertarEstado(@Creador, 'Bolivar', 			0, 'Espanol', @pyVenezuela, '', 0) INTO @eBolivar;
SELECT InsertarEstado(@Creador, 'Carabobo',			0, 'Espanol', @pyVenezuela, '', 0) INTO @eCarabobo;
SELECT InsertarEstado(@Creador, 'Cojedes', 			0, 'Espanol', @pyVenezuela, '', 0) INTO @eCojedes;
SELECT InsertarEstado(@Creador, 'Delta Amacuro', 	0, 'Espanol', @pyVenezuela, '', 0) INTO @eDeltaAmacuro;
SELECT InsertarEstado(@Creador, 'Distrito Capital', 0, 'Espanol', @pyVenezuela, '', 0) INTO @eCaracas;
SELECT InsertarEstado(@Creador, 'Falcon', 			0, 'Espanol', @pyVenezuela, '', 0) INTO @eFalcon;
SELECT InsertarEstado(@Creador, 'Guarico', 			0, 'Espanol', @pyVenezuela, '', 0) INTO @eGuarico;
SELECT InsertarEstado(@Creador, 'Lara', 			0, 'Espanol', @pyVenezuela, '', 0) INTO @eLara;
SELECT InsertarEstado(@Creador, 'Merida', 			0, 'Espanol', @pyVenezuela, '', 0) INTO @eMerida;
SELECT InsertarEstado(@Creador, 'Miranda', 			0, 'Espanol', @pyVenezuela, '', 0) INTO @eMiranda;
SELECT InsertarEstado(@Creador, 'Monagas', 			0, 'Espanol', @pyVenezuela, '', 0) INTO @eMonagas;
SELECT InsertarEstado(@Creador, 'Nueva Esparta', 	0, 'Espanol', @pyVenezuela, '', 0) INTO @eNuevaEsparta;
SELECT InsertarEstado(@Creador, 'Portuguesa', 		0, 'Espanol', @pyVenezuela, '', 0) INTO @ePortuguesa;
SELECT InsertarEstado(@Creador, 'Sucre', 			0, 'Espanol', @pyVenezuela, '', 0) INTO @eSucre;
SELECT InsertarEstado(@Creador, 'Tachira', 			0, 'Espanol', @pyVenezuela, '', 0) INTO @eTachira;
SELECT InsertarEstado(@Creador, 'Trujillo', 		0, 'Espanol', @pyVenezuela, '', 0) INTO @eTrujillo;
SELECT InsertarEstado(@Creador, 'Vargas', 			0, 'Espanol', @pyVenezuela, '', 0) INTO @eVargas;
SELECT InsertarEstado(@Creador, 'Yaracuy', 			0, 'Espanol', @pyVenezuela, '', 0) INTO @eYaracuy;
SELECT InsertarEstado(@Creador, 'Zulia', 			0, 'Espanol', @pyVenezuela, '', 0) INTO @eZulia;

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
