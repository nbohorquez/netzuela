SELECT 'Palabras.sql';
USE `Spuria`;

/*
*************************************************************
*				              InsertarEtiquetable				            *
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarEtiquetable`;
SELECT 'InsertarEtiquetable';

DELIMITER $$

CREATE FUNCTION `InsertarEtiquetable` ()
RETURNS INT NOT DETERMINISTIC
BEGIN
    INSERT INTO Etiquetable VALUES (NULL);
    RETURN LAST_INSERT_ID();
END$$

/*
*************************************************************
*				                InsertarPalabra		                  *
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarPalabra`;
SELECT 'InsertarPalabra';

DELIMITER $$

CREATE FUNCTION `InsertarPalabra` (a_Palabra_Frase CHAR(15))
RETURNS INT NOT DETERMINISTIC
BEGIN
    DECLARE EXIT HANDLER FOR 1048   
    BEGIN
        SET @MensajeDeError = 'Error de valor nulo en InsertarPalabra()';
        SET @CodigoDeError = 1048;
        RETURN -1048;
    END; 
	
    DECLARE EXIT HANDLER FOR 1062
    BEGIN
        SET @MensajeDeError = 'Error de valor duplicado en InsertarPalabra()';
        SET @CodigoDeError = 1062;
        RETURN -1062;
    END; 

    INSERT INTO Palabra VALUES (
        NULL,
        a_Palabra_Frase
    );

    RETURN LAST_INSERT_ID();
END$$

/*
*************************************************************
*			             InsertarRelacionDePalabras		   	        *
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarRelacionDePalabras`;
SELECT 'InsertarRelacionDePalabras';

DELIMITER $$

CREATE FUNCTION `InsertarRelacionDePalabras` (a_Palabra1ID INT, a_Palabra2ID INT)
RETURNS INT NOT DETERMINISTIC
BEGIN   
    DECLARE EXIT HANDLER FOR 1452
    BEGIN
        SET @MensajeDeError = 'Error de clave externa en InsertarRelacionDePalabras()';
        SET @CodigoDeError = 1452;
        RETURN -1452;
    END; 

    DECLARE EXIT HANDLER FOR 1062
    BEGIN
        SET @MensajeDeError = 'Error de valor duplicado en InsertarRelacionDePalabras()';
        SET @CodigoDeError = 1062;
        RETURN -1062;
    END; 

    INSERT INTO RelacionDePalabras VALUES (
        a_Palabra1ID,
        a_Palabra2ID
    );
	
    RETURN TRUE;
END$$

/*
*************************************************************
*				               InsertarEtiqueta				              *
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarEtiqueta`;
SELECT 'InsertarEtiqueta';

DELIMITER $$

CREATE FUNCTION `InsertarEtiqueta` (a_EtiquetableID INT, a_PalabraID INT)
RETURNS INT NOT DETERMINISTIC
BEGIN
    DECLARE EXIT HANDLER FOR 1452   	
    BEGIN
        SET @MensajeDeError = 'Error de clave externa en InsertarEtiqueta()';
        SET @CodigoDeError = 1452;
        RETURN -1452;
    END; 

    DECLARE EXIT HANDLER FOR 1062
    BEGIN
        SET @MensajeDeError = 'Error de valor duplicado en InsertarEtiqueta()';
        SET @CodigoDeError = 1062;
        RETURN -1062;
    END;

    DECLARE EXIT HANDLER FOR 1048
    BEGIN
        SET @MensajeDeError = 'Error de valor nulo en InsertarEtiqueta()';
        SET @CodigoDeError = 1048;
        RETURN -1048;
    END; 

    INSERT INTO Etiqueta VALUES (
        a_EtiquetableID,
        a_PalabraID
    );
    
    RETURN TRUE;
END$$

/***********************************************************/
DELIMITER ;
/***********************************************************/