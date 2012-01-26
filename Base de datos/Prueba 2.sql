USE `Spuria`;

/*
*******************************************************
*							  		*
*				TIENDA 				*
*									*
*******************************************************
*/

/*
1)		    	2)	 	          3)
Usuario --------> Administrador
	   |
	   |
	   |------> Cliente ------------> Tienda
	   |	  			   |
	   |				   -----> Patrocinante
	   |------> Consumidor	
*/

/* TIENDA 1 */

SELECT ParroquiaID FROM Parroquia, RegionGeografica 
WHERE RegionGeografica.Nombre = 'Ambrosio' AND Parroquia.RegionGeografica_P = RegionGeografica.RegionGeograficaID
INTO @ParroquiaID;

SELECT UsuarioCrear(
	@ParroquiaID, 
	'alejandroocando10@hotmail.com', 
	'41ssdas#ASX'
) INTO @UsuarioID;

SELECT ClienteCrear(
	@Creador,
	@UsuarioID, 
	'V20455347', 
	@CategoriaID, 
	'Activo', 
	'Cristo Viste C.A.', 
	'Cristo Viste', 
	'0424-6596385', 
	NULL, NULL, NULL,
	'3194', NULL,
	'Zulia',
	'Delicias N.',
	NULL,
	'www.facebook.com/cristoviste',
	NULL
) INTO @ClienteID;

SELECT TiendaCrear(@ClienteID) INTO @TiendaID1;

SELECT HorarioDeTrabajoCrear(@TiendaID1, 'Lunes', TRUE) INTO @HT1ID;
SELECT HorarioDeTrabajoCrear(@TiendaID1, 'Martes', TRUE) INTO @HT2ID;
SELECT HorarioDeTrabajoCrear(@TiendaID1, 'Miercoles', TRUE) INTO @HT3ID;
SELECT HorarioDeTrabajoCrear(@TiendaID1, 'Jueves', TRUE) INTO @HT4ID;
SELECT HorarioDeTrabajoCrear(@TiendaID1, 'Viernes', TRUE) INTO @HT5ID;
SELECT HorarioDeTrabajoCrear(@TiendaID1, 'Sabado', FALSE) INTO @HT6ID;
SELECT HorarioDeTrabajoCrear(@TiendaID1, 'Domingo', FALSE) INTO @HT7ID;

SELECT TurnoCrear(@TiendaID1, 'Lunes', '08:00:00', '18:00:00') INTO @HT1ID;
SELECT TurnoCrear(@TiendaID1, 'Martes', '08:00:00', '18:00:00') INTO @HT2ID;
SELECT TurnoCrear(@TiendaID1, 'Miercoles', '08:00:00', '18:00:00') INTO @HT3ID;
SELECT TurnoCrear(@TiendaID1, 'Jueves', '08:00:00', '18:00:00') INTO @HT4ID;
SELECT TurnoCrear(@TiendaID1, 'Viernes', '08:00:00', '18:00:00') INTO @HT5ID;
SELECT TurnoCrear(@TiendaID1, 'Sabado', '00:00:00', '00:00:00') INTO @HT6ID;
SELECT TurnoCrear(@TiendaID1, 'Domingo', '00:00:00', '00:00:00') INTO @HT7ID;
