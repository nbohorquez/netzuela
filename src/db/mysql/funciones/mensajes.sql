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

CREATE FUNCTION `InsertarMensaje` (a_Remitente INT, a_Destinatario INT, a_Contenido TEXT)
RETURNS INT NOT DETERMINISTIC
BEGIN
    DECLARE rastreable, etiquetable, tienda_rastreable, consumidor_rastreable, creador INT;

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

	SELECT u.rastreable_p 
	FROM usuario AS u
	LEFT JOIN consumidor AS c ON u.usuario_id = c.usuario_p
	WHERE c.interlocutor_p = a_Remitente
	INTO consumidor_rastreable;

	SELECT u.rastreable_p 
	FROM usuario AS u
	LEFT JOIN cliente AS c ON u.usuario_id = c.usuario_p
	LEfT JOIN tienda AS t ON c.rif = t.cliente_p
	WHERE t.interlocutor_p = a_Remitente
	INTO tienda_rastreable;

	SELECT IF(consumidor_rastreable IS NULL, tienda_rastreable, consumidor_rastreable) INTO creador;

    SELECT InsertarRastreable(creador) INTO rastreable;
    SELECT InsertarEtiquetable() INTO etiquetable;

    INSERT INTO mensaje VALUES (
        rastreable,
        etiquetable,
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
