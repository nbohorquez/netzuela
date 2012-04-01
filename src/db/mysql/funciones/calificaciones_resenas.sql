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

CREATE FUNCTION `InsertarCalificacionResena` (a_CalificableSeguibleID INT, a_ConsumidorID INT, a_Calificacion CHAR(4), a_Resena TEXT)
RETURNS INT NOT DETERMINISTIC
BEGIN
    DECLARE etiquetable, rastreable, creador INT;

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

	SELECT u.rastreable_p
	FROM usuario AS u
	LEFT JOIN consumidor AS c ON u.usuario_id = c.usuario_p
	WHERE c.consumidor_id = a_ConsumidorID 
	INTO creador;

    SELECT InsertarRastreable(creador) INTO rastreable;
    SELECT InsertarEtiquetable() INTO etiquetable;

    INSERT INTO calificacion_resena VALUES (
		rastreable,
        etiquetable,
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
