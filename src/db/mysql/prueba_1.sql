SELECT 'prueba_1.sql';
USE `spuria`;

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

DELETE FROM producto;
DELETE FROM tienda;
DELETE FROM patrocinante;
DELETE FROM consumidor;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

/*
*********************************************************
*														*
*						PRODUCTOS						*
*														*
*********************************************************
*/

/* 
   Se crea solo un producto para probar el funcionamiento de la base de datos
*/

SELECT InsertarProducto (
    @Creador,
    'GTIN-13', 
    'P-001', 
    'Activo', 
    'Silicon Graphics', 
    'CMN B014ANT300', 
    'O2', 
    @Cat_2B00, 
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
    @Cat_2A00, 
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
    @Cat_2200, 
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
    @Cat_2100, 
    '1996/09/23', 
    3.64, 2.18, 
    2.18, 0.45, 
    @VenezuelaID
) INTO @ProductoID4;

/*
*********************************************************
*														*
*						TIENDA							*
*														*
*********************************************************
*/

/*
1)		    	2)	 	          3)
Usuario --------> Administrador
	   |
	   |
	   |------> Cliente ------------> Tienda
	   |	  			   |
	   |				   ---------> Patrocinante
	   |------> Consumidor	
*/

/* TIENDA 1 */

SELECT parroquia_id 
FROM parroquia JOIN region_geografica 
ON parroquia.region_geografica_p = region_geografica.region_geografica_id
WHERE region_geografica.nombre = 'Ambrosio'
INTO @AmbrosioID;

SELECT InsertarTienda (
    @Creador, 
    @AmbrosioID, 
    'molleja@abc.com', 
    '41ssdas#ASX',
    'V180638080', 
    @Cat_2000, 
    'Activo', 
    'Inversiones 2500 C.A.', 
    'La Boutique Electronica', 
    '0264-2415497', 
    NULL, NULL, NULL, 
    NULL, NULL,
    'La Estrella con Jose Maria Vargas',
    'Bello Monte', 
    NULL,
    'http://www.facebook.com/laboutiqueelectronica',
    NULL,
	'molleja@abc.com'
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

SELECT parroquia_id 
FROM parroquia JOIN region_geografica 
ON parroquia.region_geografica_p = region_geografica.region_geografica_id
WHERE region_geografica.nombre = 'La Rosa'
INTO @LaRosaID;

SELECT InsertarTienda (
    @Creador, 
    @LaRosaID, 
    'tca7410nb@gmail.com', 
    '444544sd54sd4sd4s4548494s',
    'J-1515151D', 
    @Cat_2000, 
    'Activo', 
    'FRALNECA C.A.', 
    'Planeta Virtual', 
    '0264-3711515', 
    NULL, NULL, NULL,
    '3194', NULL,
    'Zulia',
    'La Rosa',
    NULL,
    'http://www.facebook.com/planetavirtual',
    NULL,
	'tca7410nb@gmail.com'
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
*********************************************************
*														*
*						INVENTARIO						*
*														*
*********************************************************
*/

SELECT rastreable_p 
FROM cliente JOIN tienda
ON cliente.rif = tienda.cliente_p
WHERE tienda.tienda_id = @TiendaID1
INTO @Creador;

SELECT InsertarInventario(@TiendaID1, 'TD-015SC', 'Computadora SGI 02', 'Ambos visibles', @ProductoID1, 640.00, 12);
SELECT InsertarInventario(@TiendaID1, 'TD-1841C', 'Celular N78 Ve', 'Ambos visibles', @ProductoID2, 104.00, 9);
SELECT InsertarInventario(@TiendaID1, 'TD-99410', 'Control de N64 Gris', 'Ambos visibles', @ProductoID3, 8400.00, 2);
SELECT InsertarInventario(@TiendaID2, 'PSDC-SC0', 'Silicon Graphics 02', 'Ambos visibles', @ProductoID1, 605.95, 4);
SELECT InsertarInventario(@TiendaID2, 'PSDC-41C', 'Microfono en vivo SM57 XLR', 'Ambos visibles', @ProductoID4, 1500.00, 4);

/*
*********************************************************
*														*
*						CONSUMIDOR						*
*														*
*********************************************************
*/

SELECT parroquia_id 
FROM parroquia JOIN region_geografica 
ON parroquia.region_geografica_p = region_geografica.region_geografica_id
WHERE region_geografica.nombre = 'Punta Gorda'
INTO @PuntaGordaID;

SELECT parroquia_id 
FROM parroquia JOIN region_geografica 
ON parroquia.region_geografica_p = region_geografica.region_geografica_id
WHERE region_geografica.nombre = 'San Benito'
INTO @SanBenitoID;

SELECT InsertarConsumidor (
    @Creador, 
    'Alberto',
    'Atkins',
    'Activo',
    'Hombre',
    '1988-06-09',
    'Adultos jovenes',
    'Universitaria',
    @AmbrosioID, 
    'mandoca@merey.com', 
    'AceFoD_591dS'
) INTO @ConsumidorID1;

SELECT InsertarConsumidor (
    @Creador, 
    'Alejandro',
    'Ocando',
    'Activo',
    'Hombre',
    '1992-02-20',
    'Adultos jovenes',
    'Universitaria',
    @LaRosaID, 
    'asdfijnsad@dalepues.com', 
    '14a1c5a1sc5as1c'
) INTO @ConsumidorID2;

SELECT InsertarConsumidor (
    @Creador, 
    'Alejandro',
    'Maita',
    'Activo',
    'Hombre',
    '1987-05-28',
    'Adultos jovenes',
    'Universitaria',
    @PuntaGordaID, 
    '41dx_asde@osdae.com', 
    '51asc011.as'
) INTO @ConsumidorID3;

SELECT InsertarConsumidor (
    @Creador, 
    'Snaillyn',
    'Sosa',
    'Activo',
    'Mujer',
    '1987-09-14',
    'Adultos jovenes',
    'Universitaria',
    @SanBenitoID, 
    'quefuemarico@comoestais.com', 
    'AceFoD_591dS'
) INTO @ConsumidorID4;

/*
*********************************************************
*														*
*						MENSAJE							*
*														*
*********************************************************
*/

SELECT interlocutor_p FROM consumidor 
WHERE consumidor_id = @ConsumidorID2
INTO @InterlocutorA;

SELECT interlocutor_p FROM tienda 
WHERE tienda_id = @TiendaID1
INTO @InterlocutorB;

SELECT InsertarMensaje (
    @InterlocutorA, 
    @InterlocutorB, 
    'Hey marico... vos de casualidad teneis un pedal reverb asi cachuo?'
);

/*
*********************************************************
*														*
*						PATROCINANTE					*
*														*
*********************************************************
*/

SELECT InsertarPatrocinante (
    @Creador, 
    @AmbrosioID, 
    'hola@comoestais.com', 
    'pAA101D54Om_4aidf18',
    'V195445890', 
    @Cat_3000, 
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
    NULL,
	'hola@comoestais.com'
) INTO @PatrocinanteID;

/*
*********************************************************
*														*
*						PUBLICIDAD						*
*														*
*********************************************************
*/

SELECT InsertarPublicidad(@PatrocinanteID) INTO @PublicidadID;

SELECT InsertarGrupoDeEdadObjetivo(@PublicidadID, 'Adultos jovenes');
SELECT InsertarGradoDeInstruccionObjetivo(@PublicidadID, 'Universitaria');
SELECT InsertarRegionGeograficaObjetivo(@PublicidadID, @AmbrosioID);
SELECT InsertarSexoObjetivo(@PublicidadID, 'Hombre');
SELECT InsertarConsumidorObjetivo(@PublicidadID, @ConsumidorID2);

/*
*********************************************************
*														*
*						BUSCAR							*
*														*
*********************************************************
*/

SELECT usuario_p FROM consumidor
WHERE consumidor_id = @ConsumidorID3
INTO @UsuarioID;

SELECT buscable_p FROM producto
WHERE producto_id = @ProductoID1
INTO @BuscableID;

SELECT InsertarBusqueda(@UsuarioID, 'Motor de aviones') INTO @BusquedaID;
SELECT InsertarResultadoDeBusqueda(@BusquedaID, @BuscableID, 0.91);

/*
*********************************************************
*														*
*					CALIFICACION RESENA					*
*														*
*********************************************************
*/

SELECT calificable_seguible_p FROM producto
WHERE producto_id = @ProductoID1
INTO @Producto1Calificable;

SELECT calificable_seguible_p FROM producto
WHERE producto_id = @ProductoID2
INTO @Producto2Calificable;

SELECT calificable_seguible_p FROM producto
WHERE producto_id = @ProductoID3
INTO @Producto3Calificable;

SELECT calificable_seguible_p FROM producto
WHERE producto_id = @ProductoID4
INTO @Producto4Calificable;

SELECT calificable_seguible_p FROM tienda
WHERE tienda_id = @TiendaID1
INTO @Tienda1Calificable;

SELECT calificable_seguible_p FROM tienda
WHERE tienda_id = @TiendaID2
INTO @Tienda2Calificable;

SELECT InsertarCalificacionResena(@Producto1Calificable, @ConsumidorID3, 'Mal', 'Sed ut perspiciatis, unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam eaque ipsa, quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt, explicabo.');
SELECT InsertarCalificacionResena(@Producto1Calificable, @ConsumidorID2, 'Bien', 'Debet oporteat mel et. Mei eu modo referrentur dissentiunt, pri in viris singulis, dicam ancillae sed ad.');
SELECT InsertarCalificacionResena(@Producto1Calificable, @ConsumidorID1, 'Mal', 'Essent persecuti neglegentur sea no, qui forensibus deseruisse concludaturque ad. Veniam possit eos cu. Te quo partem quidam detraxit. Illum numquam no duo. Nihil pericula prodesset ea his, in pri sint possim accusamus.');
SELECT InsertarCalificacionResena(@Producto2Calificable, @ConsumidorID4, 'Bien', 'Graecis periculis ex nam, mel ridens persius et. In probatus reprehendunt duo, evertitur gloriatur est ad.');
SELECT InsertarCalificacionResena(@Producto2Calificable, @ConsumidorID1, 'Mal', 'Essent persecuti neglegentur sea no, qui forensibus deseruisse concludaturque ad. Veniam possit eos cu. Te quo partem quidam detraxit. Illum numquam no duo. Nihil pericula prodesset ea his, in pri sint possim accusamus.');
SELECT InsertarCalificacionResena(@Producto2Calificable, @ConsumidorID3, 'Bien', 'Graecis periculis ex nam, mel ridens persius et. In probatus reprehendunt duo, evertitur gloriatur est ad.');
SELECT InsertarCalificacionResena(@Producto3Calificable, @ConsumidorID1, 'Mal', 'Debet oporteat mel et. Mei eu modo referrentur dissentiunt, pri in viris singulis, dicam ancillae sed ad.');
SELECT InsertarCalificacionResena(@Producto3Calificable, @ConsumidorID4, 'Mal', 'Sed ut perspiciatis, unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam eaque ipsa, quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt, explicabo.');
SELECT InsertarCalificacionResena(@Producto3Calificable, @ConsumidorID2, 'Bien', 'Usu graeci scaevola in, ius elitr verear no. Sed ex brute integre maiestatis. Per an admodum recusabo, ne sit meis officiis aliquando.');
SELECT InsertarCalificacionResena(@Producto4Calificable, @ConsumidorID4, 'Bien', 'An hinc scripserit vel, ea omnis menandri referrentur usu.');
SELECT InsertarCalificacionResena(@Producto4Calificable, @ConsumidorID3, 'Mal', 'Usu graeci scaevola in, ius elitr verear no. Sed ex brute integre maiestatis. Per an admodum recusabo, ne sit meis officiis aliquando.');
SELECT InsertarCalificacionResena(@Producto4Calificable, @ConsumidorID1, 'Bien', 'Essent persecuti neglegentur sea no, qui forensibus deseruisse concludaturque ad. Veniam possit eos cu. Te quo partem quidam detraxit.');
SELECT InsertarCalificacionResena(@Tienda1Calificable, @ConsumidorID4, 'Mal', 'Simul singulis mea ei. Cum ad saepe eruditi pericula, habeo maluisset cu per. Ut vide quas qui, vim meis graece consequuntur ea, sit utinam laoreet habemus ea. At summo suscipit petentium est, dicit vidisse voluptua ei mei. Duo id aperiam menandri.');
SELECT InsertarCalificacionResena(@Tienda1Calificable, @ConsumidorID3, 'Bien', 'An hinc scripserit vel, ea omnis menandri referrentur usu.');
SELECT InsertarCalificacionResena(@Tienda1Calificable, @ConsumidorID1, 'Bien', 'Simul singulis mea ei. Cum ad saepe eruditi pericula, habeo maluisset cu per. Ut vide quas qui, vim meis graece consequuntur ea, sit utinam laoreet habemus ea. At summo suscipit petentium est, dicit vidisse voluptua ei mei. Duo id aperiam menandri.');
SELECT InsertarCalificacionResena(@Tienda2Calificable, @ConsumidorID2, 'Mal', 'Graecis periculis ex nam, mel ridens persius et. In probatus reprehendunt duo, evertitur gloriatur est ad.');
SELECT InsertarCalificacionResena(@Tienda2Calificable, @ConsumidorID1, 'Bien', 'Sed ut perspiciatis, unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam eaque ipsa, quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt, explicabo.');
SELECT InsertarCalificacionResena(@Tienda2Calificable, @ConsumidorID4, 'Mal', 'Essent persecuti neglegentur sea no, qui forensibus deseruisse concludaturque ad. Veniam possit eos cu. Te quo partem quidam detraxit. Illum numquam no duo. Nihil pericula prodesset ea his, in pri sint possim accusamus.');

/*
*********************************************************
*														*
*						SEGUIDOR						*
*														*
*********************************************************
*/

SELECT InsertarSeguidor(@Producto4Calificable, @ConsumidorID3, 'TENEIS QUE REVISAR LO DE AVISARSI');

/*
*********************************************************
*							  		                    *
*						DESCRIPCION						*
*									                    *
*********************************************************
*/

SELECT rastreable_p 
FROM cliente JOIN tienda
ON cliente.rif = tienda.cliente_p
WHERE tienda.tienda_id = @TiendaID1
INTO @Tienda1Rastreable;

SELECT describible_p FROM producto
WHERE producto_id = @ProductoID1
INTO @Producto1Describible;

SELECT describible_p 
FROM cliente JOIN tienda
ON cliente.rif = tienda.cliente_p
WHERE tienda.tienda_id = @TiendaID1
INTO @Tienda1Describible;

SELECT InsertarDescripcion(@Tienda1Rastreable, @Producto1Describible, 'El motor aeroespacial PAE-1516 de 20kN de empuje...');
SELECT InsertarDescripcion(@Tienda1Rastreable, @Tienda1Describible, 'Raw denim you probably haven\'t heard of them jean shorts Austin. Nesciunt tofu stumptown aliqua, retro synth master cleanse. Mustache cliche tempor, williamsburg carles vegan helvetica. Reprehenderit butcher retro keffiyeh dreamcatcher synth. Cosby sweater eu banh mi, qui irure terry richardson ex squid. Aliquip placeat salvia cillum iphone. Seitan aliquip quis cardigan american apparel, butcher voluptate nisi qui.');

/*
*********************************************************
*														*
*			               FOTO							*
*														*
*********************************************************
*/

/*
SELECT describible_p FROM producto
WHERE producto_id = @ProductoID1
INTO @Producto1Describible;
*/

SELECT describible_p FROM producto
WHERE producto_id = @ProductoID2
INTO @Producto2Describible;

SELECT describible_p FROM producto
WHERE producto_id = @ProductoID3
INTO @Producto3Describible;

SELECT describible_p FROM producto
WHERE producto_id = @ProductoID4
INTO @Producto4Describible;
/*
SELECT describible_p FROM cliente, tienda
WHERE tienda.tienda_id = @TiendaID1 AND cliente.rif = tienda.cliente_p
INTO @Tienda1Describible;
*/
SELECT describible_p FROM cliente, tienda
WHERE tienda.tienda_id = @TiendaID2 AND cliente.rif = tienda.cliente_p
INTO @Tienda2Describible;

SELECT InsertarFoto ('img/grandes/ca/b7/fedd1d4a20b1437e8c99e84afdbf5dba5975.jpg', @Producto1Describible);
SELECT InsertarFoto ('img/medianas/ca/b7/fedd1d4a20b1437e8c99e84afdbf5dba5975.jpg', @Producto1Describible);
SELECT InsertarFoto ('img/pequenas/ca/b7/fedd1d4a20b1437e8c99e84afdbf5dba5975.jpg', @Producto1Describible);

SELECT InsertarFoto ('img/grandes/e4/71/0923ec6527e7546eccc6f1e984eae96d7d24.jpg', @Producto2Describible);
SELECT InsertarFoto ('img/medianas/e4/71/0923ec6527e7546eccc6f1e984eae96d7d24.jpg', @Producto2Describible);
SELECT InsertarFoto ('img/pequenas/e4/71/0923ec6527e7546eccc6f1e984eae96d7d24.jpg', @Producto2Describible);

SELECT InsertarFoto ('img/grandes/fe/4f/84ca1019e0dbf638fe8589969ef6438841ec.jpg', @Producto3Describible);
SELECT InsertarFoto ('img/medianas/fe/4f/84ca1019e0dbf638fe8589969ef6438841ec.jpg', @Producto3Describible);
SELECT InsertarFoto ('img/pequenas/fe/4f/84ca1019e0dbf638fe8589969ef6438841ec.jpg', @Producto3Describible);

SELECT InsertarFoto ('img/grandes/bb/b9/5f60c4299607a49411be2d555ca21265186d.jpg', @Producto4Describible);
SELECT InsertarFoto ('img/medianas/bb/b9/5f60c4299607a49411be2d555ca21265186d.jpg', @Producto4Describible);
SELECT InsertarFoto ('img/pequenas/bb/b9/5f60c4299607a49411be2d555ca21265186d.jpg', @Producto4Describible);

SELECT InsertarFoto ('img/grandes/7f/55/0ef228ae58fcf572fe099c2aaf75f40950c2.jpg', @Tienda1Describible);
SELECT InsertarFoto ('img/medianas/7f/55/0ef228ae58fcf572fe099c2aaf75f40950c2.jpg', @Tienda1Describible);
SELECT InsertarFoto ('img/pequenas/7f/55/0ef228ae58fcf572fe099c2aaf75f40950c2.jpg', @Tienda1Describible);

SELECT InsertarFoto ('img/grandes/5a/ae/c182e3c94f7c40774bbdc0d97ff4cfaa776a.jpg', @Tienda1Describible);
SELECT InsertarFoto ('img/medianas/5a/ae/c182e3c94f7c40774bbdc0d97ff4cfaa776a.jpg', @Tienda1Describible);
SELECT InsertarFoto ('img/pequenas/5a/ae/c182e3c94f7c40774bbdc0d97ff4cfaa776a.jpg', @Tienda1Describible);

SELECT InsertarFoto ('img/grandes/5a/ae/c182e3c94f7c40774bbdc0d97ff4cfaa776a.jpg', @Tienda2Describible);
SELECT InsertarFoto ('img/medianas/5a/ae/c182e3c94f7c40774bbdc0d97ff4cfaa776a.jpg', @Tienda2Describible);
SELECT InsertarFoto ('img/pequenas/5a/ae/c182e3c94f7c40774bbdc0d97ff4cfaa776a.jpg', @Tienda2Describible);

/*
*********************************************************
*														*
*						FACTURA							*
*														*
*********************************************************
*/

SELECT cobrable_p FROM publicidad
WHERE publicidad_id = @PublicidadID
INTO @CobrableID;

SELECT cliente_p FROM patrocinante
WHERE patrocinante_id = @PatrocinanteID
INTO @ClienteID;

SELECT InsertarFactura(@Creador, @ClienteID, DATE_FORMAT(now_msec(), '%Y%m%d%H%i%S.%f'), DATE_FORMAT('2012-07-29 21:00:00', '%Y%m%d%H%i%S.%f')) INTO @FacturaID;
SELECT InsertarServicioVendido(@FacturaID, @CobrableID);

UPDATE servicio_vendido
SET acumulado = 45454
WHERE factura_id = @FacturaID AND cobrable_id = @CobrableID;

/*
*********************************************************
*														*
*						CROQUIS							*
*														*
*********************************************************
*/

SELECT dibujable_p FROM tienda
WHERE tienda_id = @TiendaID1
INTO @Tienda1Dibujable;

SELECT InsertarCroquis(@Tienda1Rastreable, @Tienda1Dibujable) INTO @Tienda1Croquis;
SELECT InsertarPunto(10.420891,-71.461491) INTO @PuntoID1;
SELECT InsertarPuntoDeCroquis(@Tienda1Croquis, @PuntoID1);

SELECT rastreable_p 
FROM cliente JOIN tienda
ON cliente.rif = tienda.cliente_p
WHERE tienda.tienda_id = @TiendaID2
INTO @Tienda2Rastreable;

SELECT dibujable_p FROM tienda
WHERE tienda_id = @TiendaID2
INTO @Tienda2Dibujable;

SELECT InsertarCroquis(@Tienda2Rastreable, @Tienda2Dibujable) INTO @Tienda2Croquis;
SELECT InsertarPunto(10.401457,-71.470045) INTO @PuntoID1;
SELECT InsertarPuntoDeCroquis(@Tienda2Croquis, @PuntoID1);

/*
*********************************************************
*														*
*						PALABRA							*
*														*
*********************************************************
*/

SELECT InsertarPalabra('Avion') INTO @PalabraID;

/*
*******************************************************
*							  		                  *
*						ESTADISTICAS		 		  *
*									                  *
*******************************************************
*/

SELECT buscable_P FROM tienda
WHERE tienda_id = @TiendaID1
INTO @BuscableID;

SELECT InsertarEstadisticasDeVisitas(@Creador, @BuscableID, @AmbrosioID);
SELECT InsertarEstadisticasDePopularidad(@Creador, @Producto4Calificable, @AmbrosioID);
SELECT InsertarEstadisticasDeInfluencia(@Creador, @PalabraID, @AmbrosioID);
