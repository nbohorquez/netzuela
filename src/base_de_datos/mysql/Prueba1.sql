SELECT 'Prueba1.sql';
USE `Spuria`;

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

DELETE FROM Producto;
DELETE FROM Tienda;
DELETE FROM Patrocinante;
DELETE FROM Consumidor;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

/*
*******************************************************
*							  		                                  *
*				                PRODUCTOS 				            *
*									                                    *
*******************************************************
*/

/* 
   Se crea solo un producto para probar el funcionamiento de la base de datos
*/

SELECT CategoriaID FROM Categoria 
WHERE Nombre = 'Electronica' 
INTO @CategoriaID;

SELECT InsertarProducto (
    @Creador,
    'GTIN-13', 
    'P-001', 
    'Activo', 
    'Silicon Graphics', 
    'CMN B014ANT300', 
    'O2', 
    @CategoriaID, 
    '2001/02/20', 
    3.64, 2.18, 
    2.18, 3.94, 
    @VenezuelaID
) INTO @ProductoID1;

SELECT InsertarProducto (
    @Creador,
    'GTIN-13', 
    'P-002', 
    'Activo', 
    'Nokia', 
    'N78', 
    'Nokia N78', 
    @CategoriaID, 
    '1994/08/15', 
    3.64, 2.18, 
    2.18, 0.14, 
    @VenezuelaID
) INTO @ProductoID2;

SELECT InsertarProducto (
    @Creador,
    'GTIN-13', 
    'P-003', 
    'Activo', 
    'Nintendo', 
    'NUS-001', 
    'Nintendo 64 Control', 
    @CategoriaID, 
    '1996/09/23', 
    3.64, 2.18, 
    2.18, 0.21, 
    @VenezuelaID
) INTO @ProductoID3;

SELECT InsertarProducto (
    @Creador,
    'GTIN-13', 
    'P-004', 
    'Activo', 
    'Shure', 
    'SM57', 
    'Microfono SM57', 
    @CategoriaID, 
    '1996/09/23', 
    3.64, 2.18, 
    2.18, 0.45, 
    @VenezuelaID
) INTO @ProductoID4;

/*
*******************************************************
*							  		                                  *
*				                TIENDA 				                *
*									                                    *
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

SELECT InsertarTienda (
    @Creador, 
    @ParroquiaID, 
    'molleja@abc.com', 
    '41ssdas#ASX',
    'V180638080', 
    @CategoriaID, 
    'Activo', 
    'TiendaABC C.A.', 
    'La Tiendita', 
    '0264-2415497', 
    NULL, NULL, NULL, 
    '3194', NULL,
    'Zulia',
    'Delicias Nuevas', 
    NULL,
    'www.facebook.com/tienditadejose',
    NULL
) INTO @TiendaID1;

SELECT InsertarHorarioDeTrabajo(@TiendaID1, 'Lunes', TRUE) INTO @HT1ID;
SELECT InsertarHorarioDeTrabajo(@TiendaID1, 'Martes', TRUE) INTO @HT2ID;
SELECT InsertarHorarioDeTrabajo(@TiendaID1, 'Miercoles', TRUE) INTO @HT3ID;
SELECT InsertarHorarioDeTrabajo(@TiendaID1, 'Jueves', TRUE) INTO @HT4ID;
SELECT InsertarHorarioDeTrabajo(@TiendaID1, 'Viernes', TRUE) INTO @HT5ID;
SELECT InsertarHorarioDeTrabajo(@TiendaID1, 'Sabado', FALSE) INTO @HT6ID;
SELECT InsertarHorarioDeTrabajo(@TiendaID1, 'Domingo', FALSE) INTO @HT7ID;

SELECT InsertarTurno(@TiendaID1, 'Lunes', '08:00:00', '16:00:00') INTO @HT1ID;
SELECT InsertarTurno(@TiendaID1, 'Martes', '08:00:00', '16:00:00') INTO @HT2ID;
SELECT InsertarTurno(@TiendaID1, 'Miercoles', '08:00:00', '16:00:00') INTO @HT3ID;
SELECT InsertarTurno(@TiendaID1, 'Jueves', '08:00:00', '16:00:00') INTO @HT4ID;
SELECT InsertarTurno(@TiendaID1, 'Viernes', '08:00:00', '16:00:00') INTO @HT5ID;
SELECT InsertarTurno(@TiendaID1, 'Sabado', '00:00:00', '00:00:00') INTO @HT6ID;
SELECT InsertarTurno(@TiendaID1, 'Domingo', '00:00:00', '00:00:00') INTO @HT7ID;

/* TIENDA 2 */

SELECT ParroquiaID FROM Parroquia, RegionGeografica 
WHERE RegionGeografica.Nombre = 'La Rosa' AND Parroquia.RegionGeografica_P = RegionGeografica.RegionGeograficaID
INTO @ParroquiaID;

SELECT InsertarTienda (
    @Creador, 
    @ParroquiaID, 
    'tca7410nb@gmail.com', 
    '444544sd54sd4sd4s4548494s',
    'J-1515151D', 
    @CategoriaID, 
    'Activo', 
    'FRALNECA C.A.', 
    'Subway La Rosa', 
    '0264-3711515', 
    NULL, NULL, NULL,
    '3194', NULL,
    'Zulia',
    'La Rosa',
    NULL,
    'www.facebook.com/subwaylarosa',
    NULL
) INTO @TiendaID2;

SELECT InsertarHorarioDeTrabajo(@TiendaID2, 'Lunes', TRUE) INTO @HT1ID;
SELECT InsertarHorarioDeTrabajo(@TiendaID2, 'Martes', TRUE) INTO @HT2ID;
SELECT InsertarHorarioDeTrabajo(@TiendaID2, 'Miercoles', TRUE) INTO @HT3ID;
SELECT InsertarHorarioDeTrabajo(@TiendaID2, 'Jueves', TRUE) INTO @HT4ID;
SELECT InsertarHorarioDeTrabajo(@TiendaID2, 'Viernes', TRUE) INTO @HT5ID;
SELECT InsertarHorarioDeTrabajo(@TiendaID2, 'Sabado', TRUE) INTO @HT6ID;
SELECT InsertarHorarioDeTrabajo(@TiendaID2, 'Domingo', TRUE) INTO @HT7ID;

SELECT InsertarTurno(@TiendaID2, 'Lunes', '11:00:00', '22:00:00') INTO @HT1ID;
SELECT InsertarTurno(@TiendaID2, 'Martes', '11:00:00', '22:00:00') INTO @HT2ID;
SELECT InsertarTurno(@TiendaID2, 'Miercoles', '11:00:00', '22:00:00') INTO @HT3ID;
SELECT InsertarTurno(@TiendaID2, 'Jueves', '11:00:00', '22:00:00') INTO @HT4ID;
SELECT InsertarTurno(@TiendaID2, 'Viernes', '11:00:00', '23:30:00') INTO @HT5ID;
SELECT InsertarTurno(@TiendaID2, 'Sabado', '11:00:00', '23:30:00') INTO @HT6ID;
SELECT InsertarTurno(@TiendaID2, 'Domingo', '11:00:00', '22:00:00') INTO @HT7ID;

/*
*******************************************************
*							  		                                  *
*				                INVENTARIO 				            *
*									                                    *
*******************************************************
*/

SELECT Rastreable_P FROM Tienda, Cliente
WHERE Tienda.TiendaID = @TiendaID1 AND Cliente.RIF = Tienda.Cliente_P
INTO @TiendaRastreable;

SELECT InsertarInventario(@TiendaRastreable, @TiendaID1, 'TD-015SC', 'Computadora SGI 02', 'Ambos visibles', @ProductoID1, 640.00, 12);
SELECT InsertarInventario(@TiendaRastreable, @TiendaID1, 'TD-1841C', 'Celular N78 Ve', 'Ambos visibles', @ProductoID2, 104.00, 9);
SELECT InsertarInventario(@TiendaRastreable, @TiendaID1, 'TD-99410', 'Control de N64 Gris', 'Ambos visibles', @ProductoID3, 8400.00, 2);

SELECT Rastreable_P FROM Tienda, Cliente
WHERE Tienda.TiendaID = @TiendaID2 AND Cliente.RIF = Tienda.Cliente_P
INTO @TiendaRastreable;

SELECT InsertarInventario(@TiendaRastreable, @TiendaID2, 'PSDC-41C', 'Microfono en vivo SM57 XLR', 'Ambos visibles', @ProductoID4, 1500.00, 4);

/*
*******************************************************
*							  		                                  *
*				                CONSUMIDOR 				            *
*									                                    *
*******************************************************
*/

SELECT InsertarConsumidor (
    @Creador, 
    'Alberto',
    'Atkins',
    'Activo',
    'Hombre',
    '1988-06-09',
    'Adultos jovenes',
    'Universitaria',
    @ParroquiaID, 
    'mandoca@merey.com', 
    'AceFoD_591dS'
) INTO @ConsumidorID;

/*
*******************************************************
*							  		                                  *
*				                MENSAJE 				              *
*									                                    *
*******************************************************
*/

SELECT Interlocutor_P, Rastreable_P FROM Consumidor 
WHERE Nombre = 'Alberto' AND Apellido = 'Atkins' 
INTO @InterlocutorA, @ConsumidorRastreable;

SELECT Interlocutor_P FROM Tienda 
WHERE TiendaID = @TiendaID1
INTO @InterlocutorB;

SELECT InsertarMensaje (
    @ConsumidorRastreable,
    @InterlocutorA, 
    @InterlocutorB, 
    'Hey marico... vos de casualidad teneis un pedal reverb asi cachuo?'
);

/*
*******************************************************
*							  		                                  *
*			                PATROCINANTE 				            *
*									                                    *
*******************************************************
*/

SELECT InsertarPatrocinante (
    @Creador, 
    @ParroquiaID, 
    'hola@comoestais.com', 
    'pAA101D54Om_4aidf18',
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
) INTO @PatrocinanteID;

/*
*******************************************************
*							  		                                  *
*			                  PUBLICIDAD    			          *
*									                                    *
*******************************************************
*/

SELECT Cliente.Rastreable_P FROM Cliente, Patrocinante
WHERE Patrocinante.PatrocinanteID = @PatrocinanteID AND Patrocinante.Cliente_P = Cliente.RIF
INTO @ClienteRastreable;

SELECT InsertarPublicidad(@ClienteRastreable, @PatrocinanteID) INTO @PublicidadID;

SELECT InsertarGrupoDeEdadObjetivo(@PublicidadID, 'Adultos jovenes') INTO @bobo;
SELECT InsertarGradoDeInstruccionObjetivo(@PublicidadID, 'Universitaria') INTO @bobo;
SELECT InsertarRegionGeograficaObjetivo(@PublicidadID, @ParroquiaID) INTO @bobo;
SELECT InsertarSexoObjetivo(@PublicidadID, 'Hombre') INTO @bobo;
SELECT InsertarConsumidorObjetivo(@PublicidadID, @ConsumidorID) INTO @bobo;

/*
*******************************************************
*							  		                                  *
*				                BUSCAR 				                *
*									                                    *
*******************************************************
*/

SELECT Usuario_P FROM Consumidor
WHERE Rastreable_P = @ConsumidorRastreable
INTO @UsuarioID;

SELECT Buscable_P FROM Producto
WHERE ProductoID = @ProductoID1
INTO @BuscableID;

SELECT InsertarBusqueda(@ConsumidorRastreable, @UsuarioID, 'Motor de aviones') INTO @BusquedaID;
SELECT InsertarResultadoDeBusqueda(@BusquedaID, @BuscableID, 0.91) INTO @bobo;

/*
*******************************************************
*							  		                                  *
*			            CALIFICACION RESENA 			          *
*									                                    *
*******************************************************
*/

SELECT CalificableSeguible_P FROM Tienda
WHERE TiendaID = @TiendaID2
INTO @CalificableID;

SELECT InsertarCalificacionResena(@ConsumidorRastreable, @CalificableID, @ConsumidorID, 'Mal', 'Mas mala quer cono...') INTO @bobo;

/*
*******************************************************
*							  		                                  *
*			                    SEGUIDOR				            *
*									                                    *
*******************************************************
*/

SELECT InsertarSeguidor(@ConsumidorRastreable, @CalificableID, @ConsumidorID, 'TENEIS QUE REVISAR LO DE AVISARSI') INTO @bobo;

/*
*******************************************************
*							  		                                  *
*			                DESCRIPCION 				            *
*									                                    *
*******************************************************
*/

SELECT Describible_P FROM Producto
WHERE ProductoID = @ProductoID1
INTO @ProductoDescribible;

SELECT InsertarDescripcion(@ConsumidorRastreable, @ProductoDescribible, 'El motor aeroespacial PAE-1516 de 20kN de empuje...') INTO @bobo;

/*
*******************************************************
*							  		                                  *
*				                FACTURA	 			                *
*									                                    *
*******************************************************
*/

SELECT Cobrable_P FROM Publicidad
WHERE PublicidadID = @PublicidadID
INTO @CobrableID;

SELECT Cliente_P FROM Patrocinante
WHERE PatrocinanteID = @PatrocinanteID
INTO @ClienteID;

SELECT InsertarFactura(@Creador, @ClienteID, NOW(), '2011-07-29 21:00:00') INTO @FacturaID;
SELECT InsertarServicioVendido(@FacturaID, @CobrableID) INTO @bobo;

UPDATE ServicioVendido
SET Acumulado = 45454
WHERE FacturaID = @FacturaID AND CobrableID = @CobrableID;

/*
*******************************************************
*							  		                                  *
*				                CROQUIS	 			                *
*									                                    *
*******************************************************
*/

SELECT Dibujable_P FROM Tienda
WHERE TiendaID = @TiendaID2
INTO @DibujableID;

SELECT InsertarCroquis(@Creador, @DibujableID) INTO @CroquisID;
SELECT InsertarPunto(10.411534, -71.454783) INTO @PuntoID;
SELECT InsertarPuntoDeCroquis(@CroquisID, @PuntoID) INTO @bobo;

/*
*******************************************************
*							  		                                  *
*				                PALABRA	 			                *
*									                                    *
*******************************************************
*/

SELECT InsertarPalabra('Avion') INTO @PalabraID;

/*
*******************************************************
*							  		                                  *
*			                 ESTADISTICAS		 		            *
*									                                    *
*******************************************************
*/

SELECT Buscable_P FROM Tienda
WHERE TiendaID = @TiendaID1
INTO @BuscableID;

SELECT InsertarEstadisticasDeVisitas(@Creador, @BuscableID, @ParroquiaID) INTO @bobo;
SELECT InsertarEstadisticasDePopularidad(@Creador, @CalificableID, @ParroquiaID) INTO @bobo;
SELECT InsertarEstadisticasDeInfluencia(@Creador, @PalabraID, @ParroquiaID) INTO @bobo;
