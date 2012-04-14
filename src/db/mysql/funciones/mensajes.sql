SELECT 'mensajes.sql';
USE `spuria`;

/*
*************************************************************
*					InsertarInterlocutor					*
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
*						InsertarMensaje						*
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarMensaje`;
SELECT 'InsertarMensaje';

DELIMITER $$

CREATE FUNCTION `InsertarMensaje` (a_Remitente INT, a_Destinatario INT, a_Contenido TEXT)
RETURNS INT NOT DETERMINISTIC
BEGIN
    DECLARE rastreable, etiquetable, creador INT;

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

	SELECT DISTINCT
	CASE 
	WHEN co.interlocutor_p = a_Remitente THEN u.rastreable_p
	WHEN ti.interlocutor_p = a_Remitente THEN cl.rastreable_p
	END
	FROM (usuario AS u, cliente AS cl)
	JOIN consumidor AS co ON u.usuario_id = co.usuario_p
	JOIN tienda AS ti ON cl.rif = ti.cliente_p
	WHERE co.interlocutor_p = a_Remitente OR ti.interlocutor_p = a_Remitente
	INTO creador;

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
