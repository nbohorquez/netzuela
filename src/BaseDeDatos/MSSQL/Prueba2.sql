SELECT 'Prueba2.sql';
USE spuria;

EXEC sp_msforeachtable "ALTER TABLE ? NOCHECK CONSTRAINT all";

DELETE FROM Producto;
DELETE FROM Tienda;
DELETE FROM Patrocinante;
DELETE FROM Consumidor;

EXEC sp_msforeachtable @command1="ALTER TABLE ? WITH CHECK CHECK CONSTRAINT all";

/*
*******************************************************
*							  		                  *
*				         PRODUCTOS 				      *
*									                  *
*******************************************************
*/

/* 
   Se crea solo un producto para probar el funcionamiento de la base de datos
*/

SELECT 'Productos.sql';
DECLARE @ProductoID1 int, @ProductoID2 int, @ProductoID3 int, @ProductoID4 int
DECLARE @Creador int, @CategoriaID int, @VenezuelaID int

SET @Creador =
(
	SELECT Rastreable_P
	FROM Administrador
	WHERE Nombre = 'Nestor' AND Apellido = 'Bohorquez'
);

SET @CategoriaID =
(
	SELECT CategoriaID FROM Categoria 
	WHERE Nombre = 'Electronica' 
);

SET @VenezuelaID =
(
	SELECT Pais.PaisID
	FROM RegionGeografica, Pais
	WHERE RegionGeografica.Nombre = 'Venezuela' AND Pais.RegionGeografica_P = RegionGeografica.RegionGeograficaID
);

EXEC dbo.InsertarProducto$IMPL 
	@a_Creador = @Creador, 
	@a_TipoDeCodigo = 'GTIN-13', 
	@a_Codigo = 'P-001', 
	@a_Estatus = 'Activo',
	@a_Fabricante = 'Silicon Graphics', 
	@a_Modelo = 'CMN B014ANT300', 
	@a_Nombre = 'O2', 
	@a_Categoria = @CategoriaID, 
	@a_DebutEnElMercado = '2001/02/20', 
	@a_Largo = 3.64,
	@a_Ancho = 2.18, 
	@a_Alto = 2.18, 
	@a_Peso = 3.94, 
	@a_PaisDeOrigen = @VenezuelaID, 
	@returnvalue = @ProductoID1 OUTPUT;
	
EXEC dbo.InsertarProducto$IMPL 
	@a_Creador = @Creador, 
	@a_TipoDeCodigo = 'GTIN-13', 
	@a_Codigo = 'P-002', 
	@a_Estatus = 'Activo',
	@a_Fabricante = 'Nokia', 
	@a_Modelo = 'N78', 
	@a_Nombre = 'Nokia N78', 
	@a_Categoria = @CategoriaID, 
	@a_DebutEnElMercado = '1994/08/15', 
	@a_Largo = 3.64,
	@a_Ancho = 2.18, 
	@a_Alto = 2.18, 
	@a_Peso = 0.14, 
	@a_PaisDeOrigen = @VenezuelaID, 
	@returnvalue = @ProductoID2 OUTPUT;

EXEC dbo.InsertarProducto$IMPL 
	@a_Creador = @Creador, 
	@a_TipoDeCodigo = 'GTIN-13', 
	@a_Codigo = 'P-003', 
	@a_Estatus = 'Activo',
	@a_Fabricante = 'Nintendo', 
	@a_Modelo = 'NUS-001', 
	@a_Nombre = 'Nintendo 64 Control', 
	@a_Categoria = @CategoriaID, 
	@a_DebutEnElMercado = '1996/09/23', 
	@a_Largo = 3.64,
	@a_Ancho = 2.18, 
	@a_Alto = 2.18, 
	@a_Peso = 0.21, 
	@a_PaisDeOrigen = @VenezuelaID, 
	@returnvalue = @ProductoID3 OUTPUT;
	
EXEC dbo.InsertarProducto$IMPL 
	@a_Creador = @Creador, 
	@a_TipoDeCodigo = 'GTIN-13', 
	@a_Codigo = 'P-004', 
	@a_Estatus = 'Activo',
	@a_Fabricante = 'Shure', 
	@a_Modelo = 'SM57', 
	@a_Nombre = 'Microfono SM57', 
	@a_Categoria = @CategoriaID, 
	@a_DebutEnElMercado = '1996/09/23', 
	@a_Largo = 3.64,
	@a_Ancho = 2.18, 
	@a_Alto = 2.18, 
	@a_Peso = 0.45, 
	@a_PaisDeOrigen = @VenezuelaID, 
	@returnvalue = @ProductoID4 OUTPUT;

/*
*******************************************************
*							  		                  *
*						 TIENDA 				      *
*									                  *
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
DECLARE @TiendaID1 int, @TiendaID2 int
DECLARE @ParroquiaID int

SET @ParroquiaID =
(
	SELECT ParroquiaID 
	FROM Parroquia, RegionGeografica 
	WHERE RegionGeografica.Nombre = 'Ambrosio' AND Parroquia.RegionGeografica_P = RegionGeografica.RegionGeograficaID	
);

EXEC dbo.InsertarTienda$IMPL 
	@a_Creador = @Creador, 
	@a_Parroquia = @ParroquiaID, 
	@a_CorreoElectronico = 'molleja@abc.com', 
	@a_Contrasena = '41ssdas#ASX', 
	@a_RIF = 'V180638080', 
	@a_Categoria = @CategoriaID,
	@a_Estatus = 'Activo', 
	@a_NombreLegal = 'TiendaABC C.A.', 
	@a_NombreComun = 'La Tiendita', 
	@a_Telefono = '0264-2415497', 
	@a_Edificio_CC = NULL, 
	@a_Piso = NULL, 
	@a_Apartamento = NULL, 
	@a_Local = '3194', 
	@a_Casa = NULL, 
	@a_Calle = 'Zulia', 
	@a_Sector_Urb_Barrio = 'Delicias N.', 
	@a_PaginaWeb = NULL, 
	@a_Facebook = 'www.facebook.com/tienditadejose', 
	@a_Twitter = NULL, 
	@returnvalue = @TiendaID1 OUTPUT;
	
DECLARE @HT1ID int, @HT2ID int, @HT3ID int, @HT4ID int, @HT5ID int, @HT6ID int, @HT7ID int
	
EXEC dbo.InsertarHorarioDeTrabajo$IMPL @a_TiendaID = @TiendaID1, @a_Dia = 'Lunes', @a_Laborable = TRUE, @returnvalue = @HT1ID OUTPUT;
EXEC dbo.InsertarHorarioDeTrabajo$IMPL @a_TiendaID = @TiendaID1, @a_Dia = 'Martes', @a_Laborable = TRUE, @returnvalue = @HT2ID OUTPUT;
EXEC dbo.InsertarHorarioDeTrabajo$IMPL @a_TiendaID = @TiendaID1, @a_Dia = 'Miercoles', @a_Laborable = TRUE, @returnvalue = @HT3ID OUTPUT;
EXEC dbo.InsertarHorarioDeTrabajo$IMPL @a_TiendaID = @TiendaID1, @a_Dia = 'Jueves', @a_Laborable = TRUE, @returnvalue = @HT4ID OUTPUT;
EXEC dbo.InsertarHorarioDeTrabajo$IMPL @a_TiendaID = @TiendaID1, @a_Dia = 'Viernes', @a_Laborable = TRUE, @returnvalue = @HT5ID OUTPUT;
EXEC dbo.InsertarHorarioDeTrabajo$IMPL @a_TiendaID = @TiendaID1, @a_Dia = 'Sabado', @a_Laborable = FALSE, @returnvalue = @HT6ID OUTPUT;
EXEC dbo.InsertarHorarioDeTrabajo$IMPL @a_TiendaID = @TiendaID1, @a_Dia = 'Domingo', @a_Laborable = FALSE, @returnvalue = @HT7ID OUTPUT;

EXEC dbo.InsertarTurno$IMPL @a_TiendaID = @TiendaID1, @a_Dia = 'Lunes', @a_HoraDeApertura = '08:00:00', @a_HoraDeCierre = '16:00:00', @returnvalue = @HT1ID OUTPUT;
EXEC dbo.InsertarTurno$IMPL @a_TiendaID = @TiendaID1, @a_Dia = 'Martes', @a_HoraDeApertura = '08:00:00', @a_HoraDeCierre = '16:00:00', @returnvalue = @HT2ID OUTPUT;
EXEC dbo.InsertarTurno$IMPL @a_TiendaID = @TiendaID1, @a_Dia = 'Miercoles', @a_HoraDeApertura = '08:00:00', @a_HoraDeCierre = '16:00:00', @returnvalue = @HT3ID OUTPUT;
EXEC dbo.InsertarTurno$IMPL @a_TiendaID = @TiendaID1, @a_Dia = 'Jueves', @a_HoraDeApertura = '08:00:00', @a_HoraDeCierre = '16:00:00', @returnvalue = @HT4ID OUTPUT;
EXEC dbo.InsertarTurno$IMPL @a_TiendaID = @TiendaID1, @a_Dia = 'Viernes', @a_HoraDeApertura = '08:00:00', @a_HoraDeCierre = '16:00:00', @returnvalue = @HT5ID OUTPUT;
EXEC dbo.InsertarTurno$IMPL @a_TiendaID = @TiendaID1, @a_Dia = 'Sabado', @a_HoraDeApertura = '00:00:00', @a_HoraDeCierre = '00:00:00', @returnvalue = @HT6ID OUTPUT;
EXEC dbo.InsertarTurno$IMPL @a_TiendaID = @TiendaID1, @a_Dia = 'Domingo', @a_HoraDeApertura = '00:00:00', @a_HoraDeCierre = '00:00:00', @returnvalue = @HT7ID OUTPUT;
 
/* TIENDA 2 */

SET @ParroquiaID =
(
	SELECT ParroquiaID 
	FROM Parroquia, RegionGeografica 
	WHERE RegionGeografica.Nombre = 'La Rosa' AND Parroquia.RegionGeografica_P = RegionGeografica.RegionGeograficaID
);

EXEC dbo.InsertarTienda$IMPL 
	@a_Creador = @Creador, 
	@a_Parroquia = @ParroquiaID, 
	@a_CorreoElectronico = 'tca7410nb@gmail.com', 
	@a_Contrasena = '444544sd54sd4sd4s4548494s', 
	@a_RIF = 'J-1515151D', 
	@a_Categoria = @CategoriaID,
	@a_Estatus = 'Activo', 
	@a_NombreLegal = 'FRALNECA C.A.', 
	@a_NombreComun = 'Subway La Rosa', 
	@a_Telefono = '0264-3711515', 
	@a_Edificio_CC = NULL, 
	@a_Piso = NULL, 
	@a_Apartamento = NULL, 
	@a_Local = '4754', 
	@a_Casa = NULL, 
	@a_Calle = 'Zulia', 
	@a_Sector_Urb_Barrio = 'La Rosa', 
	@a_PaginaWeb = NULL, 
	@a_Facebook = 'www.facebook.com/subwaylarosa', 
	@a_Twitter = NULL, 
	@returnvalue = @TiendaID2 OUTPUT;
	
EXEC dbo.InsertarHorarioDeTrabajo$IMPL @a_TiendaID = @TiendaID2, @a_Dia = 'Lunes', @a_Laborable = TRUE, @returnvalue = @HT1ID OUTPUT;
EXEC dbo.InsertarHorarioDeTrabajo$IMPL @a_TiendaID = @TiendaID2, @a_Dia = 'Martes', @a_Laborable = TRUE, @returnvalue = @HT2ID OUTPUT;
EXEC dbo.InsertarHorarioDeTrabajo$IMPL @a_TiendaID = @TiendaID2, @a_Dia = 'Miercoles', @a_Laborable = TRUE, @returnvalue = @HT3ID OUTPUT;
EXEC dbo.InsertarHorarioDeTrabajo$IMPL @a_TiendaID = @TiendaID2, @a_Dia = 'Jueves', @a_Laborable = TRUE, @returnvalue = @HT4ID OUTPUT;
EXEC dbo.InsertarHorarioDeTrabajo$IMPL @a_TiendaID = @TiendaID2, @a_Dia = 'Viernes', @a_Laborable = TRUE, @returnvalue = @HT5ID OUTPUT;
EXEC dbo.InsertarHorarioDeTrabajo$IMPL @a_TiendaID = @TiendaID2, @a_Dia = 'Sabado', @a_Laborable = FALSE, @returnvalue = @HT6ID OUTPUT;
EXEC dbo.InsertarHorarioDeTrabajo$IMPL @a_TiendaID = @TiendaID2, @a_Dia = 'Domingo', @a_Laborable = FALSE, @returnvalue = @HT7ID OUTPUT;

EXEC dbo.InsertarTurno$IMPL @a_TiendaID = @TiendaID2, @a_Dia = 'Lunes', @a_HoraDeApertura = '11:00:00', @a_HoraDeCierre = '22:00:00', @returnvalue = @HT1ID OUTPUT;
EXEC dbo.InsertarTurno$IMPL @a_TiendaID = @TiendaID2, @a_Dia = 'Martes', @a_HoraDeApertura = '11:00:00', @a_HoraDeCierre = '22:00:00', @returnvalue = @HT2ID OUTPUT;
EXEC dbo.InsertarTurno$IMPL @a_TiendaID = @TiendaID2, @a_Dia = 'Miercoles', @a_HoraDeApertura = '11:00:00', @a_HoraDeCierre = '22:00:00', @returnvalue = @HT3ID OUTPUT;
EXEC dbo.InsertarTurno$IMPL @a_TiendaID = @TiendaID2, @a_Dia = 'Jueves', @a_HoraDeApertura = '11:00:00', @a_HoraDeCierre = '22:00:00', @returnvalue = @HT4ID OUTPUT;
EXEC dbo.InsertarTurno$IMPL @a_TiendaID = @TiendaID2, @a_Dia = 'Viernes', @a_HoraDeApertura = '11:00:00', @a_HoraDeCierre = '23:30:00', @returnvalue = @HT5ID OUTPUT;
EXEC dbo.InsertarTurno$IMPL @a_TiendaID = @TiendaID2, @a_Dia = 'Sabado', @a_HoraDeApertura = '11:00:00', @a_HoraDeCierre = '23:30:00', @returnvalue = @HT6ID OUTPUT;
EXEC dbo.InsertarTurno$IMPL @a_TiendaID = @TiendaID2, @a_Dia = 'Domingo', @a_HoraDeApertura = '11:00:00', @a_HoraDeCierre = '22:00:00', @returnvalue = @HT7ID OUTPUT;

/*
*******************************************************
*							  		                  *
*				      CONSUMIDOR 				      *
*									                  *
*******************************************************
*/

DECLARE @ConsumidorID int

EXEC dbo.InsertarConsumidor$IMPL 
	@a_Creador = @Creador, 
	@a_Nombre = 'Alberto', 
	@a_Apellido = 'Atkins', 
	@a_Estatus = 'Activo', 
	@a_Sexo ='Hombre',
	@a_FechaDeNacimiento = '1988-06-09', 
	@a_GrupoDeEdad = 'Adultos jovenes', 
	@a_GradoDeInstruccion = 'Universitaria', 
	@a_Parroquia = @ParroquiaID, 
	@a_CorreoElectronico = 'mandoca@merey.com', 
	@a_Contrasena = 'AceFoD_591dS',
	@returnvalue = @ConsumidorID OUTPUT;

/*
*******************************************************
*							  		                  *
*						MENSAJE 				      *
*									                  *
*******************************************************
*/

DECLARE @bobo int;
DECLARE @InterlocutorA int, @InterlocutorB int, @ConsumidorRastreable int;

DECLARE @Resultado TABLE
(
	Interlocutor_P int,
	Rastreable_P int
);

INSERT @Resultado  
SELECT Interlocutor_P, Rastreable_P 
FROM Consumidor 
WHERE Nombre = 'Alberto' AND Apellido = 'Atkins' 

SET @ConsumidorRastreable = (SELECT Rastreable_P FROM @Resultado);
SET @InterlocutorA = (SELECT Interlocutor_P FROM @Resultado);

SET @InterlocutorB = 
(
	SELECT Interlocutor_P 
	FROM Tienda 
	WHERE TiendaID = @TiendaID1
);

EXEC dbo.InsertarMensaje$IMPL 
	@a_Creador = @ConsumidorRastreable, 
	@a_Remitente = @InterlocutorA, 
	@a_Destinatario = @InterlocutorB, 
	@a_Contenido = 'Hey marico... vos de casualidad teneis un pedal reverb asi cachuo?', 
	@returnvalue = @bobo OUTPUT;

/*
*******************************************************
*							  		                  *
*			           PATROCINANTE 				  *
*									                  *
*******************************************************
*/

DECLARE @PatrocinanteID int

EXEC dbo.InsertarPatrocinante$IMPL 
	@a_Creador = @Creador, 
	@a_Parroquia = @ParroquiaID, 
	@a_CorreoElectronico = 'hola@comoestais.com', 
	@a_Contrasena = 'pAA101D54Om_4aidf18', 
	@a_RIF = 'V195445890', 
	@a_Categoria = @CategoriaID,
	@a_Estatus = 'Activo', 
	@a_NombreLegal = 'Yordonal C.A.', 
	@a_NombreComun = 'Yordonal', 
	@a_Telefono = '0264-2518490', 
	@a_Edificio_CC = NULL, 
	@a_Piso = NULL, 
	@a_Apartamento = NULL, 
	@a_Local = '13', 
	@a_Casa = NULL,
	@a_Calle = 'Igualdad', 
	@a_Sector_Urb_Barrio = 'Ambrosio', 
	@a_PaginaWeb = NULL, 
	@a_Facebook = 'www.facebook.com/yordonal', 
	@a_Twitter = NULL, 
	@returnvalue = @PatrocinanteID OUTPUT;
   
/*
*******************************************************
*							  		                  *
*			           PUBLICIDAD    			      *
*									                  *
*******************************************************
*/

DECLARE @ClienteRastreable int, @PublicidadID int

SET @ClienteRastreable =
(
	SELECT Cliente.Rastreable_P 
	FROM Cliente, Patrocinante
	WHERE Patrocinante.PatrocinanteID = @PatrocinanteID AND Patrocinante.Cliente_P = Cliente.RIF
);

EXEC dbo.InsertarPublicidad$IMPL 
	@a_Creador = @ClienteRastreable, 
	@a_Patrocinante = @PatrocinanteID, 
	@returnvalue = @PublicidadID OUTPUT;

EXEC dbo.InsertarGrupoDeEdadObjetivo$IMPL 
	@a_PublicidadID = @PublicidadID, 
	@a_GrupoDeEdad = 'Adultos jovenes', 
	@returnvalue = @bobo OUTPUT;

EXEC dbo.InsertarGradoDeInstruccionObjetivo$IMPL 
	@a_PublicidadID = @PublicidadID, 
	@a_GradoDeInstruccion = 'Universitaria', 
	@returnvalue = @bobo OUTPUT;

DECLARE @RegionGeograficaID int;

SET @RegionGeograficaID =
(
	SELECT RegionGeograficaID
	FROM RegionGeografica
	WHERE Nombre = 'Ambrosio'
);
	
EXEC dbo.InsertarRegionGeograficaObjetivo$IMPL 
	@a_PublicidadID = @PublicidadID, 
	@a_RegionGeograficaID = @RegionGeograficaID, 
	@returnvalue = @bobo OUTPUT;

EXEC dbo.InsertarSexoObjetivo$IMPL 
	@a_PublicidadID = @PublicidadID, 
	@a_Sexo = 'Hombre', 
	@returnvalue = @bobo OUTPUT;

EXEC dbo.InsertarConsumidorObjetivo$IMPL 
	@a_PublicidadID = @PublicidadID, 
	@a_ConsumidorID = @ConsumidorID, 
	@returnvalue = @bobo OUTPUT;

/*
*******************************************************
*							  		                  *
*						BUSCAR 				          *
*									                  *
*******************************************************
*/

DECLARE @UsuarioID int, @BuscableID int, @BusquedaID int

SET @UsuarioID = 
(
	SELECT Usuario_P 
	FROM Consumidor
	WHERE Rastreable_P = @ConsumidorRastreable
);

SET @BuscableID = 
(
	SELECT Buscable_P 
	FROM Producto
	WHERE ProductoID = @ProductoID1
);

EXEC dbo.InsertarBusqueda$IMPL 
	@a_Creador = @ConsumidorRastreable, 
	@a_UsuarioID = @UsuarioID, 
	@a_Contenido = 'Motor de aviones', 
	@returnvalue = @BusquedaID OUTPUT;

EXEC dbo.InsertarResultadoDeBusqueda$IMPL 
	@a_BusquedaID = @BusquedaID, 
	@a_BuscableID = @BuscableID, 
	@a_Relevancia = 0.91, 
	@returnvalue = @bobo OUTPUT;

/*
*******************************************************
*							  		                  *
*					CALIFICACION RESENA 			  *
*									                  *
*******************************************************
*/

DECLARE @CalificableID int

SET @CalificableID =
(
	SELECT CalificableSeguible_P 
	FROM Tienda
	WHERE TiendaID = @TiendaID2
);

EXEC dbo.InsertarCalificacionResena$IMPL 
	@a_Creador = @ConsumidorRastreable, 
	@a_CalificableSeguibleID = @CalificableID, 
	@a_ConsumidorID = @ConsumidorID, 
	@a_Calificacion = 'Mal', 
	@a_Resena = 'Mas mala quer cono...', 
	@returnvalue = @bobo OUTPUT;

/*
*******************************************************
*							  		                  *
*						SEGUIDOR				      *
*									                  *
*******************************************************
*/

EXEC dbo.InsertarSeguidor$IMPL 
	@a_Creador = @ConsumidorRastreable, 
	@a_CalificableSeguibleID = @CalificableID, 
	@a_ConsumidorID = @ConsumidorID, 
	@a_AvisarSi = 'TENEIS QUE REVISAR LO DE AVISARSI', 
	@returnvalue = @bobo OUTPUT;

/*
*******************************************************
*							  		                  *
*						DESCRIPCION 				  *
*									                  *
*******************************************************
*/
DECLARE @ProductoDescribible int

SET @ProductoDescribible =
(
	SELECT Describible_P 
	FROM Producto
	WHERE ProductoID = @ProductoID1
);

EXEC dbo.InsertarDescripcion$IMPL 
	@a_Creador = @ConsumidorRastreable, 
	@a_Describible = @ProductoDescribible, 
	@a_Contenido = 'El motor aeroespacial PAE-1516 de 20kN de empuje...', 
	@returnvalue = @bobo OUTPUT;

/*
*******************************************************
*							  		                  *
*						FACTURA	 			          *
*									                  *
*******************************************************
*/

DECLARE @CobrableID int, @FacturaID int;
DECLARE @ClienteID char(10);
DECLARE @Hoy datetime2, @DentroDeUnMes datetime2;

SET @CobrableID =
(
	SELECT Cobrable_P 
	FROM Publicidad
	WHERE PublicidadID = @PublicidadID
);

SET @ClienteID =
(
	SELECT Cliente_P 
	FROM Patrocinante
	WHERE PatrocinanteID = @PatrocinanteID
);

SET @Hoy = GETDATE();
SET @DentroDeUnMes = DATEADD(MONTH, 1, @Hoy);

EXEC dbo.InsertarFactura$IMPL 
	@a_Creador = @Creador, 
	@a_Cliente = @ClienteID, 
	@a_InicioDeMedicion = @Hoy, 
	@a_FinDeMedicion = @DentroDeUnMes, 
	@returnvalue = @FacturaID OUTPUT;

EXEC dbo.InsertarServicioVendido$IMPL 
	@a_FacturaID = @FacturaID, 
	@a_CobrableID = @CobrableID, 
	@returnvalue = @bobo OUTPUT;

UPDATE ServicioVendido
SET Acumulado = 45454
WHERE FacturaID = @FacturaID AND CobrableID = @CobrableID;

/*
*******************************************************
*							  		                  *
*						CROQUIS	 			          *
*									                  *
*******************************************************
*/
DECLARE @DibujableID int, @CroquisID int, @PuntoID int;

SET @DibujableID = 
(
	SELECT Dibujable_P 
	FROM Tienda
	WHERE TiendaID = @TiendaID2
);

EXEC dbo.InsertarCroquis$IMPL 
	@a_Creador = @Creador, 
	@a_Dibujable = @DibujableID, 
	@returnvalue = @CroquisID OUTPUT;

EXEC dbo.InsertarPunto$IMPL 
	@a_Latitud = 10.411534, 
	@a_Longitud = -71.454783, 
	@returnvalue = @PuntoID OUTPUT;

EXEC dbo.InsertarPuntoDeCroquis$IMPL 
	@a_CroquisID = @CroquisID, 
	@a_PuntoID = @PuntoID, 
	@returnvalue = @bobo OUTPUT;

/*
*******************************************************
*							  		                  *
*						PALABRA	 			          *
*									                  *
*******************************************************
*/

DECLARE @PalabraID int;
EXEC dbo.InsertarPalabra$IMPL @a_Palabra_Frase = 'Avion', @returnvalue = @PalabraID OUTPUT;

/*
*******************************************************
*							  		                  *
*			          ESTADISTICAS		 		      *
*									                  *
*******************************************************
*/

SET @BuscableID =
(
	SELECT Buscable_P 
	FROM Tienda
	WHERE TiendaID = @TiendaID1
);

EXEC dbo.InsertarEstadisticasDeVisitas$IMPL 
	@a_Creador = @Creador, 
	@a_Buscable = @BuscableID, 
	@a_RegionGeografica = @RegionGeograficaID, 
	@returnvalue = @bobo OUTPUT;

EXEC dbo.InsertarEstadisticasDePopularidad$IMPL 
	@a_Creador = @Creador, 
	@a_CalificableSeguible = @CalificableID, 
	@a_RegionGeografica = @RegionGeograficaID, 
	@returnvalue = @bobo OUTPUT;

EXEC dbo.InsertarEstadisticasDeInfluencia$IMPL 
	@a_Creador = @Creador, 
	@a_Palabra = @PalabraID, 
	@a_RegionGeografica = @RegionGeograficaID, 
	@returnvalue = @bobo OUTPUT;