SELECT 'Mensajes.sql';
USE `Spuria`;

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
    INSERT INTO Interlocutor VALUES ();
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
    DECLARE v_Rastreable_P, v_Etiquetable_P INT;

    SELECT InsertarRastreable(a_Creador) INTO v_Rastreable_P;
    SELECT InsertarEtiquetable() INTO v_Etiquetable_P;

    INSERT INTO Mensaje (
        Rastreable_P,
        Etiquetable_P,
        Remitente,
        Destinatario,
        Contenido
    ) VALUES (
        v_Rastreable_P,
        v_Etiquetable_P,
        a_Remitente,
        a_Destinatario,
        a_Contenido
    );

    RETURN LAST_INSERT_ID();
END$$

/***********************************************************/
DELIMITER ;
/***********************************************************/