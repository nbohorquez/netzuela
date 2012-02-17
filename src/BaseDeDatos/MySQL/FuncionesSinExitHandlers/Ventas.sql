SELECT 'Ventas.sql';
USE `Spuria`;

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
    INSERT INTO Cobrable VALUES ();
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
    DECLARE v_Rastreable_P INT;
    
    SELECT InsertarRastreable(a_Creador) INTO v_Rastreable_P;

    INSERT INTO Factura (
        Rastreable_P,
        Cliente,
        InicioDeMedicion,
        FinDeMedicion,
        Subtotal,
        Impuestos,
        Total
    ) VALUES (
        v_Rastreable_P,
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
    INSERT INTO ServicioVendido VALUES (
        a_FacturaID,
        a_CobrableID,
        0
    );

    RETURN TRUE;
END$$

/***********************************************************/
DELIMITER ;
/***********************************************************/