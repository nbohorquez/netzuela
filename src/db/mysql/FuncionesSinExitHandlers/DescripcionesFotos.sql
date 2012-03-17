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
    INSERT INTO Describible VALUES ();
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
    DECLARE v_Etiquetable_P, v_Rastreable_P INT;

    SELECT InsertarRastreable(a_Creador) INTO v_Rastreable_P;
    SELECT InsertarEtiquetable() INTO v_Etiquetable_P;

    INSERT INTO Descripcion (
        Rastreable_P,
        Etiquetable_P,
        Describible,
        Contenido
    ) VALUES (
        v_Rastreable_P,
        v_Etiquetable_P,
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
    INSERT INTO Foto (
        RutaDeFoto,
        Describible
    ) VALUES (
        a_RutaDeFoto,
        a_Describible
    );

    RETURN LAST_INSERT_ID();
END$$



/***********************************************************/
DELIMITER ;
/***********************************************************/