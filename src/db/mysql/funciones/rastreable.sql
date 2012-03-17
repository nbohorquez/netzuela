SELECT 'rastreable.sql';
USE `spuria`;

/*
*************************************************************
*				               InsertarRastreable                   *
*************************************************************
*/

DROP FUNCTION IF EXISTS `InsertarRastreable`;
SELECT 'InsertarRastreable';

DELIMITER $$

CREATE FUNCTION `InsertarRastreable` (a_Creador INT)
RETURNS INT NOT DETERMINISTIC
BEGIN
    DECLARE Ahora DECIMAL(17,3);
    SELECT DATE_FORMAT(now_msec(), '%Y%m%d%H%i%S.%f') INTO Ahora;

    INSERT INTO rastreable VALUES ( 
        NULL,
        Ahora, a_Creador,
        Ahora, a_Creador,
        NULL, NULL,
        Ahora, a_Creador
    );	

    RETURN LAST_INSERT_ID();
END$$

/***********************************************************/
DELIMITER ;
/***********************************************************/
