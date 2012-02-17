SELECT 'CroquisPuntos.sql';
USE `Spuria`;

/*
*************************************************************
*				              InsertarDibujable				              *
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarDibujable`;
SELECT 'InsertarDibujable';

DELIMITER $$

CREATE FUNCTION `InsertarDibujable` ()
RETURNS INT NOT DETERMINISTIC
BEGIN
    INSERT INTO Dibujable VALUES ();
    RETURN LAST_INSERT_ID();
END$$

/*
*************************************************************
*				                  InsertarPunto					            *
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarPunto`;
SELECT 'InsertarPunto';

DELIMITER $$

CREATE FUNCTION `InsertarPunto` (a_Latitud DECIMAL(9,6), a_Longitud DECIMAL(9,6))
RETURNS INT NOT DETERMINISTIC
BEGIN
    INSERT INTO Punto (
        Latitud,
        Longitud
    ) VALUES (
        a_Latitud,
        a_Longitud
    );
	
    RETURN LAST_INSERT_ID();
END$$

/*
*************************************************************
*				                InsertarCroquis				              *
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarCroquis`;
SELECT 'InsertarCroquis';

DELIMITER $$

CREATE FUNCTION `InsertarCroquis` (a_Creador INT, a_Dibujable INT)
RETURNS INT NOT DETERMINISTIC
BEGIN
    DECLARE v_Rastreable_P INT;

    SELECT InsertarRastreable(a_Creador) INTO v_Rastreable_P;

    INSERT INTO Croquis VALUES (
        v_Rastreable_P,
        a_Dibujable,
        -1, -1
    );

    RETURN a_Dibujable;
END$$

/*
*************************************************************
*				             InsertarPuntoDeCroquis			            *
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarPuntoDeCroquis`;
SELECT 'InsertarPuntoDeCroquis';

DELIMITER $$

CREATE FUNCTION `InsertarPuntoDeCroquis` (a_CroquisID INT, a_PuntoID INT)
RETURNS INT NOT DETERMINISTIC
BEGIN
    INSERT INTO PuntoDeCroquis VALUES (
        a_CroquisID,
        a_PuntoID
    );
    
    RETURN TRUE;
END$$

/***********************************************************/
DELIMITER ;
/***********************************************************/