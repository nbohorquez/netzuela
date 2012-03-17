SELECT 'calificaciones_resenas.sql';
USE `spuria`;

/*
*************************************************************
*			             InsertarCalificableSeguible			        *
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarCalificableSeguible`;
SELECT 'InsertarCalificableSeguible';

DELIMITER $$

CREATE FUNCTION `InsertarCalificableSeguible` ()
RETURNS INT NOT DETERMINISTIC
BEGIN
    INSERT INTO calificable_seguible VALUES (NULL, 0);
    RETURN LAST_INSERT_ID();
END$$

/*
*************************************************************
*			             InsertarCalificacionResena				        *
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarCalificacionResena`;
SELECT 'InsertarCalificacionResena';

DELIMITER $$

CREATE FUNCTION `InsertarCalificacionResena` (a_Creador INT, a_CalificableSeguibleID INT, a_ConsumidorID INT, a_Calificacion CHAR(4), a_Resena TEXT)
RETURNS INT NOT DETERMINISTIC
BEGIN
    DECLARE Etiquetable_P, Rastreable_P INT;

    DECLARE EXIT HANDLER FOR 1452
    BEGIN
        SET @MensajeDeError = 'Error de clave externa en InsertarCalificacionResena()';
        SET @CodigoDeError = 1452;
        RETURN -1452;
    END;

    DECLARE EXIT HANDLER FOR 1062
    BEGIN
        SET @MensajeDeError = 'Error de valor duplicado en InsertarCalificacionResena()';
        SET @CodigoDeError = 1062;
        RETURN -1062;
    END;

    DECLARE EXIT HANDLER FOR 1048
    BEGIN
        SET @MensajeDeError = 'Error de valor nulo en InsertarCalificacionResena()';
        SET @CodigoDeError = 1048;
        RETURN -1048;
    END;

    SELECT InsertarRastreable(a_Creador) INTO Rastreable_P;
    SELECT InsertarEtiquetable() INTO Etiquetable_P;

    INSERT INTO calificacion_resena VALUES (
        Rastreable_P,
        Etiquetable_P,
        a_CalificableSeguibleID,
        a_ConsumidorID,
        a_Calificacion,
        a_Resena
    );

    RETURN TRUE;
END$$


/***********************************************************/
DELIMITER ;
/***********************************************************/
