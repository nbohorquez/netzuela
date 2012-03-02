SELECT 'TiendasProductos.sql';
USE `Spuria`;

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
    DECLARE v_Buscable_P, v_CalificableSeguible_P, v_Interlocutor_P, v_Dibujable_P, Resultado, T INT;
    DECLARE v_Cliente_P CHAR(10);
        
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
    ) INTO v_Cliente_P;
    
    SELECT InsertarBuscable() INTO v_Buscable_P;
    SELECT InsertarCalificableSeguible() INTO v_CalificableSeguible_P;
    SELECT InsertarInterlocutor() INTO v_Interlocutor_P;
    SELECT InsertarDibujable() INTO v_Dibujable_P;

    INSERT INTO Tienda (
        Buscable_P,
        Cliente_P,
        CalificableSeguible_P,
        Interlocutor_P,
        Dibujable_P,
        Abierto
    ) VALUES (
        v_Buscable_P,
        v_Cliente_P,
        v_CalificableSeguible_P,
        v_Interlocutor_P,
        v_Dibujable_P,
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
    INSERT INTO HorarioDeTrabajo VALUES (
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
    INSERT INTO Turno VALUES (  
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

    /* Vemos si ya existe un registro "Tamano" ya asociado a la tabla */    	
    SELECT COUNT(*) FROM Tamano
    WHERE TiendaID = a_TiendaID
    INTO C;
		
    IF C > 0 THEN
        UPDATE Tamano
        SET FechaFin = NOW()
        WHERE TiendaID = a_TiendaID AND FechaFin IS NULL;
    END IF;
		
    INSERT INTO Tamano VALUES (
        a_TiendaID,
        NOW(),
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
    DECLARE v_Rastreable_P, v_Describible_P, v_Buscable_P, v_CalificableSeguible_P INT;
        
    SELECT InsertarRastreable(a_Creador) INTO v_Rastreable_P;
    SELECT InsertarDescribible() INTO v_Describible_P;
    SELECT InsertarBuscable() INTO v_Buscable_P;
    SELECT InsertarCalificableSeguible() INTO v_CalificableSeguible_P;

    INSERT INTO Producto (
        Rastreable_P,
        Describible_P,
        Buscable_P,
        CalificableSeguible_P,
        TipoDeCodigo,
        Codigo,
        Estatus,
        Fabricante,
        Modelo,
        Nombre,
        Categoria,
        DebutEnElMercado,
        Largo,
        Ancho,
        Alto,
        Peso,
        PaisDeOrigen
  ) VALUES (
        v_Rastreable_P,
        v_Describible_P,
        v_Buscable_P,
        v_CalificableSeguible_P,
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
    DECLARE v_Rastreable_P, v_Cobrable_P, Resultado, ResultadoSecundario INT;

    SELECT InsertarRastreable(a_Creador) INTO v_Rastreable_P;
    SELECT InsertarCobrable() INTO v_Cobrable_P;

    INSERT INTO Inventario VALUES (
        v_Rastreable_P,
        v_Cobrable_P,
        a_TiendaID,
        a_Codigo,
        a_Descripcion,
        a_Visibilidad,
        a_ProductoID
    );

    SELECT LAST_INSERT_ID() INTO Resultado;
    SELECT InsertarPrecioCantidad(a_TiendaID, a_Codigo, a_Precio, a_Cantidad) INTO ResultadoSecundario;

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

    /* Vemos si ya existe un registro "PrecioCantidad" ya asociado al inventario */
    SELECT COUNT(*) FROM PrecioCantidad
    WHERE TiendaID = a_TiendaID AND Codigo = a_Codigo
    INTO C;
		
    IF C > 0 THEN
        UPDATE PrecioCantidad
        SET FechaFin = NOW()
     		WHERE TiendaID = a_TiendaID AND Codigo = a_Codigo AND FechaFin IS NULL;
    END IF;

    INSERT INTO PrecioCantidad VALUES (
        a_TiendaID,
        a_Codigo,
        NOW(),
        NULL,
        a_Precio,
        a_Cantidad
    );

    RETURN TRUE;
END$$

/***********************************************************/
DELIMITER ;
/***********************************************************/