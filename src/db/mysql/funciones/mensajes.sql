SELECT 'mensajes.sql';
USE `spuria`;

/*
*************************************************************
*				             InsertarInterlocutor				            *
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarInterlocutor`;
SELECT 'InsertarInterlocutor';

DELIMITER $$

CREATE FUNCTION `InsertarInterlocutor` ()
RETURNS INT NOT DETERMINISTIC
BEGIN
    INSERT INTO interlocutor VALUES (NULL);
    RETURN LAST_INSERT_ID();
END$$

/*
*************************************************************
*				                InsertarMensaje				              *
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarMensaje`;
SELECT 'InsertarMensaje';

DELIMITER $$

CREATE FUNCTION `InsertarMensaje` (a_Creador INT, a_Remitente INT, a_Destinatario INT, a_Contenido TEXT)
RETURNS INT NOT DETERMINISTIC
BEGIN
    DECLARE Rastreable_P, Etiquetable_P INT;

    DECLARE EXIT HANDLER FOR 1452   
    BEGIN
        SET @MensajeDeError = 'Error de clave externa en InsertarMensaje()';
        SET @CodigoDeError = 1452;
        RETURN -1452;
    END; 
	
    DECLARE EXIT HANDLER FOR 1048
    BEGIN
        SET @MensajeDeError = 'Error de valor nulo en InsertarMensaje()';
        SET @CodigoDeError = 1048;
        RETURN -1048;
    END; 

    SELECT InsertarRastreable(a_Creador) INTO Rastreable_P;
    SELECT InsertarEtiquetable() INTO Etiquetable_P;

    INSERT INTO mensaje VALUES (
        Rastreable_P,
        Etiquetable_P,
        NULL,
        a_Remitente,
        a_Destinatario,
        a_Contenido
    );

    RETURN LAST_INSERT_ID();
END$$

/***********************************************************/
DELIMITER ;
/***********************************************************/
