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
    INSERT INTO Etiquetable VALUES ();
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
    INSERT INTO Palabra (
        Palabra_Frase
    ) VALUES (
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
    INSERT INTO Etiqueta VALUES (
        a_EtiquetableID,
        a_PalabraID
    );
    
    RETURN TRUE;
END$$

/***********************************************************/
DELIMITER ;
/***********************************************************/