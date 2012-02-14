SELECT 'CalificacionesResenas.sql';
USE `Spuria`;

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
    INSERT INTO CalificableSeguible (CalificacionGeneral) VALUES (0);
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
    DECLARE v_Etiquetable_P, v_Rastreable_P INT;

    SELECT InsertarRastreable(a_Creador) INTO v_Rastreable_P;
    SELECT InsertarEtiquetable() INTO v_Etiquetable_P;

    INSERT INTO CalificacionResena VALUES (
        v_Rastreable_P,
        v_Etiquetable_P,
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