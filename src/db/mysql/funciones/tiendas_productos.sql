SELECT 'tiendas_productos.sql';
USE `spuria`;

/*
*************************************************************
*                       InsertarTienda					            *
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarTienda`;
SELECT 'InsertarTienda';

DELIMITER $$

CREATE FUNCTION `InsertarTienda` (a_Creador INT, a_Parroquia INT, a_CorreoElectronico VARCHAR(45), 
                                  a_Contrasena VARCHAR(45), a_RIF CHAR(10), a_Categoria INT, a_Estatus CHAR(9), 
                                  a_NombreLegal VARCHAR(45), a_NombreComun VARCHAR(45), a_Telefono CHAR(12), 
                                  a_Edificio_CC CHAR(20), a_Piso CHAR(12), a_Apartamento CHAR(12), a_Local CHAR(12), 
                                  a_Casa CHAR(20), a_Calle CHAR(12), a_Sector_Urb_Barrio CHAR(20), a_PaginaWeb CHAR(40), 
                                  a_Facebook CHAR(80), a_Twitter CHAR(80))
RETURNS INT NOT DETERMINISTIC
BEGIN
    DECLARE Buscable_P, CalificableSeguible_P, Interlocutor_P, Dibujable_P, Resultado, T INT;
    DECLARE Cliente_P CHAR(10);
        
    DECLARE EXIT HANDLER FOR 1048
    BEGIN
        SET @MensajeDeError = 'Error de valor nulo en InsertarTienda()';
        SET @CodigoDeError = 1048;
        RETURN -1048;
    END; 

    DECLARE EXIT HANDLER FOR 1452
    BEGIN
        SET @MensajeDeError = 'Error de clave externa en InsertarTienda()';
        SET @CodigoDeError = 1452;
        RETURN -1452;
    END;

    DECLARE EXIT HANDLER FOR 1062
    BEGIN
        SET @MensajeDeError = 'Error de valor duplicado en InsertarTienda()';
        SET @CodigoDeError = 1062;
        RETURN -1062;
    END;
        
    SELECT InsertarCliente (
        a_Creador, 
        a_Parroquia, 
        a_CorreoElectronico, 
        a_Contrasena, 
        a_RIF, 
        a_Categoria, 
        a_Estatus, 
        a_NombreLegal, 
        a_NombreComun, 
        a_Telefono, 
        a_Edificio_CC, 
        a_Piso, 
        a_Apartamento, 
        a_Local, 
        a_Casa, 
        a_Calle, 
        a_Sector_Urb_Barrio, 
        a_PaginaWeb, 
        a_Facebook, 
        a_Twitter
    ) INTO Cliente_P;
    
    SELECT InsertarBuscable() INTO Buscable_P;
    SELECT InsertarCalificableSeguible() INTO CalificableSeguible_P;
    SELECT InsertarInterlocutor() INTO Interlocutor_P;
    SELECT InsertarDibujable() INTO Dibujable_P;

    INSERT INTO tienda VALUES (
        Buscable_P,
        Cliente_P,
        CalificableSeguible_P,
        Interlocutor_P,
        Dibujable_P,
        NULL,
        FALSE
    );

    SELECT LAST_INSERT_ID() INTO T;
    SELECT InsertarTamano(T, 0, 0, 0) INTO Resultado;

    RETURN T;
END$$

/*
*************************************************************
*                   InsertarHorarioDeTrabajo		            *
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarHorarioDeTrabajo`;
SELECT 'InsertarHorarioDeTrabajo';

DELIMITER $$

CREATE FUNCTION `InsertarHorarioDeTrabajo` (a_TiendaID INT, a_Dia CHAR(9), a_Laborable BOOLEAN)
RETURNS INT NOT DETERMINISTIC
BEGIN
    DECLARE EXIT HANDLER FOR 1048
    BEGIN
        SET @MensajeDeError = 'Error de valor nulo en InsertarHorarioDeTrabajo()';
        SET @CodigoDeError = 1048;
        RETURN -1048;
    END; 

    DECLARE EXIT HANDLER FOR 1452
    BEGIN
        SET @MensajeDeError = 'Error de clave externa en InsertarHorarioDeTrabajo()';
        SET @CodigoDeError = 1452;
        RETURN -1452;
    END;

    DECLARE EXIT HANDLER FOR 1062
    BEGIN
        SET @MensajeDeError = 'Error de valor duplicado en InsertarHorarioDeTrabajo()';
        SET @CodigoDeError = 1062;
        RETURN -1062;
    END;

    INSERT INTO horario_de_trabajo VALUES (
        a_TiendaID, 
        a_Dia,
        a_Laborable
    );

    RETURN TRUE;
END$$

/*
*************************************************************
*				                InsertarTurno					              *
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarTurno`;
SELECT 'InsertarTurno';

DELIMITER $$

CREATE FUNCTION `InsertarTurno` (a_TiendaID INT, a_Dia CHAR(9), a_HoraDeApertura TIME, a_HoraDeCierre TIME)
RETURNS INT NOT DETERMINISTIC
BEGIN
    DECLARE EXIT HANDLER FOR 1048
    BEGIN
        SET @MensajeDeError = 'Error de valor nulo en InsertarTurno()';
        SET @CodigoDeError = 1048;
        RETURN -1048;
    END; 

    DECLARE EXIT HANDLER FOR 1452
    BEGIN
        SET @MensajeDeError = 'Error de clave externa en InsertarTurno()';
        SET @CodigoDeError = 1452;
        RETURN -1452;
    END;

    DECLARE EXIT HANDLER FOR 1062
    BEGIN
        SET @MensajeDeError = 'Error de valor duplicado en InsertarTurno()';
        SET @CodigoDeError = 1062;
        RETURN -1062;
    END;

    INSERT INTO turno VALUES (  
        a_TiendaID,
        a_Dia,
        a_HoraDeApertura,
        a_HoraDeCierre
    );

    RETURN TRUE;
END$$

/*
*************************************************************
*                       InsertarTamano					            *
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarTamano`;
SELECT 'InsertarTamano';

DELIMITER $$

CREATE FUNCTION `InsertarTamano` (a_TiendaID INT, a_NumeroTotalDeProductos INT, a_CantidadTotalDeProductos INT, a_Valor INT)
RETURNS INT NOT DETERMINISTIC
BEGIN
    DECLARE C INT;
	DECLARE Ahora DECIMAL(17,3);

    DECLARE EXIT HANDLER FOR 1048   
    BEGIN
        SET @MensajeDeError = 'Error de valor nulo en InsertarTamano()';
        SET @CodigoDeError = 1048;
        RETURN -1048;
    END; 

    DECLARE EXIT HANDLER FOR 1452
    BEGIN
        SET @MensajeDeError = 'Error de clave externa en InsertarTamano()';
        SET @CodigoDeError = 1452;
        RETURN -1452;
    END;

    DECLARE EXIT HANDLER FOR 1062
    BEGIN
        SET @MensajeDeError = 'Error de valor duplicado en InsertarTamano()';
        SET @CodigoDeError = 1062;
        RETURN -1062;
    END;

    /* Vemos si ya existe un registro "Tamano" ya asociado a la tabla */    	
    SELECT COUNT(*) FROM tamano
    WHERE tienda_id = a_TiendaID
    INTO C;

    SELECT DATE_FORMAT(now_msec(), '%Y%m%d%H%i%S.%f') INTO Ahora;
		
    IF C > 0 THEN
        UPDATE tamano
        SET fecha_fin = Ahora
        WHERE tienda_id = a_TiendaID AND fecha_fin IS NULL;
    END IF;
		
    INSERT INTO tamano VALUES (
        a_TiendaID,
        Ahora,
        NULL,
        a_NumeroTotalDeProductos,
        a_CantidadTotalDeProductos,
        a_Valor
    );
	
    RETURN TRUE;
END$$

/*
*************************************************************
*				              InsertarProducto				              *
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarProducto`;
SELECT 'InsertarProducto';

DELIMITER $$

CREATE FUNCTION `InsertarProducto` (a_Creador INT, a_TipoDeCodigo CHAR(7), a_Codigo CHAR(15), 
						a_Estatus CHAR(9), a_Fabricante VARCHAR(45), a_Modelo VARCHAR(45), 
						a_Nombre VARCHAR(45), a_Categoria INT, a_DebutEnElMercado DATE, 
						a_Largo FLOAT, a_Ancho FLOAT, a_Alto FLOAT, a_Peso FLOAT, a_PaisDeOrigen INT)
RETURNS INT NOT DETERMINISTIC
BEGIN
    DECLARE Rastreable_P, Describible_P, Buscable_P, CalificableSeguible_P INT;
        
    DECLARE EXIT HANDLER FOR 1452
    BEGIN
        SET @MensajeDeError = 'Error de clave externa en InsertarProducto()';
        SET @CodigoDeError = 1452;
        RETURN -1452;
    END; 

    DECLARE EXIT HANDLER FOR 1048
    BEGIN
        SET @MensajeDeError = 'Error de valor nulo en InsertarProducto()';
        SET @CodigoDeError = 1048;
        RETURN -1048;
    END;

    DECLARE EXIT HANDLER FOR 1062
    BEGIN
        SET @MensajeDeError = 'Error de valor duplicado en InsertarProducto()';
        SET @CodigoDeError = 1062;
        RETURN -1062;
    END; 

    SELECT InsertarRastreable(a_Creador) INTO Rastreable_P;
    SELECT InsertarDescribible() INTO Describible_P;
    SELECT InsertarBuscable() INTO Buscable_P;
    SELECT InsertarCalificableSeguible() INTO CalificableSeguible_P;

    INSERT INTO producto VALUES (
        Rastreable_P,
        Describible_P,
        Buscable_P,
        CalificableSeguible_P,
        NULL,
        a_TipoDeCodigo,
        a_Codigo,
        a_Estatus,
        a_Fabricante,
        a_Modelo,
        a_Nombre,
        a_Categoria,
        a_DebutEnElMercado,
        a_Largo,
        a_Ancho,
        a_Alto,
        a_Peso,
        a_PaisDeOrigen
    );

    RETURN LAST_INSERT_ID();
END$$

/*
*************************************************************
*				               InsertarInventario				            *
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarInventario`;
SELECT 'InsertarInventario';

DELIMITER $$

CREATE FUNCTION `InsertarInventario` (a_Creador INT, a_TiendaID INT, a_Codigo CHAR(15), a_Descripcion VARCHAR(45), 
						a_Visibilidad CHAR(16), a_ProductoID INT, a_Precio DECIMAL(10,2), a_Cantidad INT)
RETURNS INT DETERMINISTIC
BEGIN
    DECLARE Rastreable_P, Cobrable_P, Resultado, ResultadoSecundario, Numero, Cantidad, Tamano INT;

    DECLARE EXIT HANDLER FOR 1452
    BEGIN
        SET @MensajeDeError = 'Error de clave externa en InsertarInventario()';
        SET @CodigoDeError = 1452;
        RETURN -1452;
    END;

    DECLARE EXIT HANDLER FOR 1048
    BEGIN
        SET @MensajeDeError = 'Error de valor nulo en InsertarInventario()';
        SET @CodigoDeError = 1048;
        RETURN -1048;
    END;

    DECLARE EXIT HANDLER FOR 1062
    BEGIN
        SET @MensajeDeError = 'Error de valor duplicado en InsertarInventario()';
        SET @CodigoDeError = 1062;
        RETURN -1062;
    END;

    SELECT InsertarRastreable(a_Creador) INTO Rastreable_P;
    SELECT InsertarCobrable() INTO Cobrable_P;

    INSERT INTO inventario VALUES (
        Rastreable_P,
        Cobrable_P,
        a_TiendaID,
        a_Codigo,
        a_Descripcion,
        a_Visibilidad,
        a_ProductoID
    );

    SELECT LAST_INSERT_ID() INTO Resultado;
    SELECT InsertarPrecioCantidad(a_TiendaID, a_Codigo, a_Precio, a_Cantidad) INTO ResultadoSecundario;

    SELECT numero_total_de_productos + 1, cantidad_total_de_productos + a_Cantidad
    FROM tamano
    WHERE tienda_id = a_TiendaID AND fecha_fin IS NULL
    INTO Numero, Cantidad;

    SELECT Numero * Cantidad INTO Tamano;
    SELECT InsertarTamano(a_TiendaID, Numero, Cantidad, Tamano) INTO ResultadoSecundario;

    RETURN TRUE;
END$$

/*
*************************************************************
*				            InsertarPrecioCantidad			            *
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarPrecioCantidad`;
SELECT 'InsertarPrecioCantidad';

DELIMITER $$

CREATE FUNCTION `InsertarPrecioCantidad` (a_TiendaID INT, a_Codigo CHAR(15), a_Precio DECIMAL(10,2), a_Cantidad INT)
RETURNS INT DETERMINISTIC
BEGIN
    DECLARE C INT;
	DECLARE Ahora DECIMAL(17,3);

    DECLARE EXIT HANDLER FOR 1452   
    BEGIN
        SET @MensajeDeError = 'Error de clave externa en InsertarPrecioCantidad()';
        SET @CodigoDeError = 1452;
        RETURN -1452;
    END; 

    DECLARE EXIT HANDLER FOR 1048
    BEGIN
        SET @MensajeDeError = 'Error de valor nulo en InsertarPrecioCantidad()';
        SET @CodigoDeError = 1048;
        RETURN -1048;
    END;

    /* Vemos si ya existe un registro "PrecioCantidad" ya asociado al inventario */
    SELECT COUNT(*) FROM precio_cantidad
    WHERE tienda_id = a_TiendaID AND codigo = a_Codigo
    INTO C;

	SELECT DATE_FORMAT(now_msec(), '%Y%m%d%H%i%S.%f') INTO Ahora;
		
    IF C > 0 THEN
        UPDATE precio_cantidad
        SET fecha_fin = Ahora
   		WHERE tienda_id = a_TiendaID AND codigo = a_Codigo AND fecha_fin IS NULL;
    END IF;

    INSERT INTO precio_cantidad VALUES (
        a_TiendaID,
        a_Codigo,
        Ahora,
        NULL,
        a_Precio,
        a_Cantidad
    );

    RETURN TRUE;
END$$

/***********************************************************/
DELIMITER ;
/***********************************************************/
