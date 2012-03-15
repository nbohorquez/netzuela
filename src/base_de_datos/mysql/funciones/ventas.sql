SELECT 'ventas.sql';
USE `spuria`;

/*
*************************************************************
*				                InsertarCobrable				            *
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarCobrable`;
SELECT 'InsertarCobrable';

DELIMITER $$

CREATE FUNCTION `InsertarCobrable` ()
RETURNS INT NOT DETERMINISTIC
BEGIN
    INSERT INTO cobrable VALUES (NULL);
    RETURN LAST_INSERT_ID();
END$$

/*
*************************************************************
*                       InsertarFactura				              *
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarFactura`;
SELECT 'InsertarFactura';

DELIMITER $$

CREATE FUNCTION `InsertarFactura` (a_Creador INT, a_Cliente CHAR(10), a_InicioDeMedicion DATETIME, a_FinDeMedicion DATETIME)
RETURNS INT DETERMINISTIC
BEGIN
    DECLARE Rastreable_P INT;
    
    DECLARE EXIT HANDLER FOR 1452
    BEGIN
        SET @MensajeDeError = 'Error de clave externa en InsertarFactura()';
        SET @CodigoDeError = 1452;
        RETURN -1452;
    END; 

    DECLARE EXIT HANDLER FOR 1048
    BEGIN
        SET @MensajeDeError = 'Error de valor nulo en InsertarFactura()';
        SET @CodigoDeError = 1048;
        RETURN -1048;
    END;
    
    SELECT InsertarRastreable(a_Creador) INTO Rastreable_P;

    INSERT INTO factura VALUES (
        Rastreable_P,
        NULL,
        a_Cliente,
        a_InicioDeMedicion,
        a_FinDeMedicion,
        0, 0, 0
    );
	
    RETURN LAST_INSERT_ID();	
END$$

/*
*************************************************************
*                   InsertarServicioVendido				          *
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarServicioVendido`;
SELECT 'InsertarServicioVendido';

DELIMITER $$

CREATE FUNCTION `InsertarServicioVendido` (a_FacturaID INT, a_CobrableID INT)
RETURNS INT NOT DETERMINISTIC
BEGIN   
    DECLARE EXIT HANDLER FOR 1452   
    BEGIN
        SET @MensajeDeError = 'Error de clave externa en InsertarServicioVendido()';
        SET @CodigoDeError = 1452;
        RETURN -1452;
    END; 

    DECLARE EXIT HANDLER FOR 1062
    BEGIN
        SET @MensajeDeError = 'Error de valor duplicado en InsertarServicioVendido()';
        SET @CodigoDeError = 1062;
        RETURN -1062;
    END; 

    DECLARE EXIT HANDLER FOR 1048
    BEGIN
        SET @MensajeDeError = 'Error de valor nulo en InsertarServicioVendido()';
        SET @CodigoDeError = 1048;
        RETURN -1048;
    END;
        
    INSERT INTO servicio_vendido VALUES (
        a_FacturaID,
        a_CobrableID,
        0
    );

    RETURN TRUE;
END$$

/***********************************************************/
DELIMITER ;
/***********************************************************/
