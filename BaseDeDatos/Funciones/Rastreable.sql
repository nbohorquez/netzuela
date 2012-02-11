SELECT 'Rastreable.sql';
USE `Spuria`;

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
    INSERT INTO Rastreable VALUES ( 
        NULL,
        NOW(), a_Creador,
        NOW(), a_Creador,
        NULL, NULL,
        NOW(), a_Creador
    );	

    RETURN LAST_INSERT_ID();
END$$

/***********************************************************/
DELIMITER ;
/***********************************************************/