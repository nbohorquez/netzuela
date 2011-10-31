USE `Spuria`;

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

DELETE from Producto;

SET @Millijigui = 'Hola';

DELETE from Cliente;
DELETE from Consumidor;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

/*
*******************************************************
*							  		*
*				PRODUCTOS 				*
*									*
*******************************************************
*/

/* 
   Se crea solo un producto para probar el funcionamiento de la base de datos
*/

SELECT CategoriaID FROM Categoria 
WHERE Nombre = 'Automotriz e industrial' 
INTO @CategoriaID;

SELECT ProductoCrear (
	@Creador,
	'GTIN-13', 
	'AB123456789CD', 
	'Activo', 
	'ZuliaWorks C.A.', 
	'PAE-1516', 
	'Silicio', 
	@CategoriaID, 
	'2011/07/04', 
	3.64, 2.18, 
	2.18, 1649.94, 
	@VenezuelaID
) INTO @ProductoID;

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

SELECT ParroquiaID FROM Parroquia, RegionGeografica 
WHERE RegionGeografica.Nombre = 'Ambrosio' AND Parroquia.RegionGeografica_P = RegionGeografica.RegionGeograficaID
INTO @ParroquiaID;

SELECT UsuarioCrear(
	@ParroquiaID, 
	'molleja@abc.com', 
	'41ssdas#ASX'
) INTO @UsuarioID;

SELECT ClienteCrear(
	@Creador,
	@UsuarioID, 
	'V180638080', 
	@CategoriaID, 
	'Activo', 
	'TiendaABC C.A.', 
	'La Tiendita', 
	'0264-2415497', 
	NULL, NULL, NULL,
	'3194', NULL,
	'Zulia',
	'Delicias N.',
	NULL,
	'www.facebook.com/tienditadejose',
	NULL
) INTO @ClienteID;

SELECT TiendaCrear(@ClienteID) INTO @TiendaID;

SELECT HorarioDeTrabajoCrear(@TiendaID, 'Lunes', TRUE) INTO @HT1ID;
SELECT HorarioDeTrabajoCrear(@TiendaID, 'Martes', TRUE) INTO @HT2ID;
SELECT HorarioDeTrabajoCrear(@TiendaID, 'Miercoles', TRUE) INTO @HT3ID;
SELECT HorarioDeTrabajoCrear(@TiendaID, 'Jueves', TRUE) INTO @HT4ID;
SELECT HorarioDeTrabajoCrear(@TiendaID, 'Viernes', TRUE) INTO @HT5ID;
SELECT HorarioDeTrabajoCrear(@TiendaID, 'Sabado', FALSE) INTO @HT6ID;
SELECT HorarioDeTrabajoCrear(@TiendaID, 'Domingo', FALSE) INTO @HT7ID;

SELECT TurnoCrear(@TiendaID, 'Lunes', '08:00:00', '16:00:00') INTO @HT1ID;
SELECT TurnoCrear(@TiendaID, 'Martes', '08:00:00', '16:00:00') INTO @HT2ID;
SELECT TurnoCrear(@TiendaID, 'Miercoles', '08:00:00', '16:00:00') INTO @HT3ID;
SELECT TurnoCrear(@TiendaID, 'Jueves', '08:00:00', '16:00:00') INTO @HT4ID;
SELECT TurnoCrear(@TiendaID, 'Viernes', '08:00:00', '16:00:00') INTO @HT5ID;
SELECT TurnoCrear(@TiendaID, 'Sabado', '00:00:00', '00:00:00') INTO @HT6ID;
SELECT TurnoCrear(@TiendaID, 'Domingo', '00:00:00', '00:00:00') INTO @HT7ID;

/*
*******************************************************
*							  		*
*				INVENTARIO 				*
*									*
*******************************************************
*/

SELECT Rastreable_P FROM Cliente, Tienda
WHERE Tienda.TiendaID = @TiendaID AND Tienda.Cliente_P = Cliente.RIF
INTO @TiendaRastreable;

SELECT InventarioCrear(@TiendaRastreable, @TiendaID, @ProductoID, 'Ambos visibles', NULL, 640.00, 12);

/*
*******************************************************
*							  		*
*				CONSUMIDOR 				*
*									*
*******************************************************
*/

SELECT UsuarioCrear (
	@ParroquiaID, 
	'mandoca@merey.com', 
	'AceFoD_591dS'
) INTO @UsuarioID;

SELECT ConsumidorCrear (
	@Creador,
	@UsuarioID,
	'Alberto',
	'Atkins',
	'Activo',
	'Hombre',
	'1988-06-09',
	'Adultos jovenes',
	'Universitaria'
) INTO @ConsumidorID;

/*
*******************************************************
*							  		*
*				MENSAJE 				*
*									*
*******************************************************
*/

SELECT Interlocutor_P, Rastreable_P FROM Consumidor 
WHERE Nombre = 'Alberto' AND Apellido = 'Atkins' 
INTO @InterlocutorA, @ConsumidorRastreable;

SELECT Interlocutor_P FROM Tienda 
WHERE TiendaID = @TiendaID 
INTO @InterlocutorB;

SELECT MensajeCrear (
	@ConsumidorRastreable,
	@InterlocutorA, 
	@InterlocutorB, 
	'Hey marico... ¿vos de casualidad teneis un pedal reverb asi cachuo?'
);

/*
*******************************************************
*							  		*
*			PATROCINANTE 				*
*									*
*******************************************************
*/

SELECT UsuarioCrear (
	@ParroquiaID, 
	'hola@comoestais.com', 
	'pAA101D54Om_4aidf18'
) INTO @UsuarioID;

SELECT ClienteCrear (
	@Creador,
	@UsuarioID, 
	'V195445890', 
	@CategoriaID, 
	'Activo', 
	'Yordonal C.A.', 
	'Yordonal', 
	'0264-2518490', 
	NULL, 
	NULL,
	NULL,
	'13',
	NULL,
	'Igualdad',
	'Ambrosio',
	NULL,
	'www.facebook.com/yordonal',
	NULL
) INTO @ClienteID;

SELECT PatrocinanteCrear(@ClienteID) INTO @PatrocinanteID;

/*
*******************************************************
*							  		*
*				PUBLICIDAD 				*
*									*
*******************************************************
*/

SELECT Rastreable_P FROM Cliente
WHERE Cliente.RIF = @ClienteID
INTO @ClienteRastreable;

SELECT PublicidadCrear(@ClienteRastreable, @PatrocinanteID) INTO @PublicidadID;

SELECT GrupoDeEdadObjetivoCrear(@PublicidadID, 'Adultos jovenes') INTO @bobo;
SELECT GradoDeInstruccionObjetivoCrear(@PublicidadID, 'Universitaria') INTO @bobo;
SELECT RegionGeograficaObjetivoCrear(@PublicidadID, @ParroquiaID) INTO @bobo;
SELECT SexoObjetivoCrear(@PublicidadID, 'Hombre') INTO @bobo;
SELECT ConsumidorObjetivoCrear(@PublicidadID, @ConsumidorID) INTO @bobo;

/*
*******************************************************
*							  		*
*				BUSCAR 				*
*									*
*******************************************************
*/

SELECT Usuario_P FROM Consumidor
WHERE Rastreable_P = @ConsumidorRastreable
INTO @UsuarioID;

SELECT Buscable_P FROM Producto
WHERE ProductoID = @ProductoID
INTO @BuscableID;

SELECT BusquedaCrear(@ConsumidorRastreable, @UsuarioID, 'Motor de aviones') INTO @BusquedaID;
SELECT ResultadoDeBusquedaCrear(@BusquedaID, @BuscableID, 0.91) INTO @bobo;

/*
*******************************************************
*							  		*
*			CALIFICACION RESENA 			*
*									*
*******************************************************
*/

SELECT CalificableSeguible_P FROM Tienda
WHERE TiendaID = @TiendaID
INTO @CalificableID;

SELECT CalificacionResenaCrear(@ConsumidorRastreable, @CalificableID, @ConsumidorID, 'Mal', 'Mas mala quer cono...') INTO @bobo;

/*
*******************************************************
*							  		*
*				SEGUIDOR				*
*									*
*******************************************************
*/

SELECT SeguidorCrear(@ConsumidorRastreable, @CalificableID, @ConsumidorID, 'TENEIS QUE REVISAR LO DE AVISARSI') INTO @bobo;

/*
*******************************************************
*							  		*
*				DESCRIPCION 			*
*									*
*******************************************************
*/

SELECT Describible_P FROM Producto
WHERE ProductoID = @ProductoID
INTO @ProductoDescribible;

SELECT DescripcionCrear(@ConsumidorRastreable, @ProductoDescribible, 'El motor aeroespacial PAE-1516 de 20kN de empuje...') INTO @bobo;

/*
*******************************************************
*							  		*
*				FACTURA	 			*
*									*
*******************************************************
*/

SELECT Cobrable_P FROM Publicidad
WHERE PublicidadID = @PublicidadID
INTO @CobrableID;

SELECT FacturaCrear(@Creador, @ClienteID, NOW(), '2011-07-29 21:00:00') INTO @FacturaID;
SELECT ServicioVendidoCrear(@FacturaID, @CobrableID) INTO @bobo;

UPDATE ServicioVendido
SET Acumulado = 45454
WHERE FacturaID = @FacturaID AND CobrableID = @CobrableID;

/*
*******************************************************
*							  		*
*				CROQUIS	 			*
*									*
*******************************************************
*/

SELECT Dibujable_P FROM Tienda
WHERE TiendaID = @TiendaID
INTO @DibujableID;

SELECT CroquisCrear(@Creador, @DibujableID) INTO @CroquisID;
SELECT PuntoCrear(10.411534, -71.454783) INTO @PuntoID;
SELECT PuntoDeCroquisCrear(@CroquisID, @PuntoID) INTO @bobo;

/*
*******************************************************
*							  		*
*				PALABRA	 			*
*									*
*******************************************************
*/

SELECT PalabraCrear('Avion') INTO @PalabraID;

/*
*******************************************************
*							  		*
*				ESTADISTICAS	 		*
*									*
*******************************************************
*/

SELECT Buscable_P FROM Tienda
WHERE TiendaID = @TiendaID
INTO @BuscableID;

SELECT EstadisticasDeVisitasCrear(@Creador, @BuscableID, @ParroquiaID) INTO @bobo;
SELECT EstadisticasDePopularidadCrear(@Creador, @CalificableID, @ParroquiaID) INTO @bobo;
SELECT EstadisticasDeInfluenciaCrear(@Creador, @PalabraID, @ParroquiaID) INTO @bobo;