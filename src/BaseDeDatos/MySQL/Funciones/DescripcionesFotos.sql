SELECT 'DescripcionesFotos.sql';
USE `Spuria`;

/*
*************************************************************
*				              InsertarDescribible				            *
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarDescribible`;
SELECT 'InsertarDescribible';

DELIMITER $$

CREATE FUNCTION `InsertarDescribible` ()
RETURNS INT NOT DETERMINISTIC
BEGIN
    INSERT INTO Describible VALUES (NULL);
    RETURN LAST_INSERT_ID();
END$$

/*
*************************************************************
*				              InsertarDescripcion				            *
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarDescripcion`;
SELECT 'InsertarDescripcion';

DELIMITER $$

CREATE FUNCTION `InsertarDescripcion` (a_Creador INT, a_Describible INT, a_Contenido TEXT)
RETURNS INT NOT DETERMINISTIC
BEGIN
    DECLARE Etiquetable_P, Rastreable_P INT;

    DECLARE EXIT HANDLER FOR 1452
    BEGIN
        SET @MensajeDeError = 'Error de clave externa en InsertarDescripcion()';
        SET @CodigoDeError = 1452;
        RETURN -1452;
    END; 

    DECLARE EXIT HANDLER FOR 1048
    BEGIN
        SET @MensajeDeError = 'Error de valor nulo en InsertarDescripcion()';
        SET @CodigoDeError = 1048;
        RETURN -1048;
    END; 

    SELECT InsertarRastreable(a_Creador) INTO Rastreable_P;
    SELECT InsertarEtiquetable() INTO Etiquetable_P;

    INSERT INTO Descripcion VALUES (
        Rastreable_P,
        Etiquetable_P,
        NULL,
        a_Describible,
        a_Contenido
    );
    
    RETURN LAST_INSERT_ID();
END $$

/*
*************************************************************
*				                 InsertarFoto					              *
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarFoto`;
SELECT 'InsertarFoto';

DELIMITER $$

CREATE FUNCTION `InsertarFoto` (a_RutaDeFoto CHAR(80), a_Describible INT)
RETURNS INT NOT DETERMINISTIC
BEGIN
    DECLARE EXIT HANDLER FOR 1452
    BEGIN
        SET @MensajeDeError = 'Error de clave externa en InsertarFoto()';
        SET @CodigoDeError = 1452;
        RETURN -1452;
    END; 

    DECLARE EXIT HANDLER FOR 1048
    BEGIN
        SET @MensajeDeError = 'Error de valor nulo enInsertarFoto()';
        SET @CodigoDeError = 1048;
        RETURN -1048;
    END; 

    INSERT INTO Foto VALUES (
        NULL,
        a_RutaDeFoto,
        a_Describible
    );

    RETURN LAST_INSERT_ID();
END$$



/***********************************************************/
DELIMITER ;
/***********************************************************/