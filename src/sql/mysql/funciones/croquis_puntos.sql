SELECT 'croquis_puntos.sql';
USE `spuria`;

/*
*************************************************************
*				              InsertarDibujable				              *
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarDibujable`;
SELECT 'InsertarDibujable';

DELIMITER $$

CREATE FUNCTION `InsertarDibujable` ()
RETURNS INT NOT DETERMINISTIC
BEGIN
    INSERT INTO dibujable VALUES (NULL);
    RETURN LAST_INSERT_ID();
END$$

/*
*************************************************************
*				                  InsertarPunto					            *
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarPunto`;
SELECT 'InsertarPunto';

DELIMITER $$

CREATE FUNCTION `InsertarPunto` (a_Latitud DECIMAL(9,6), a_Longitud DECIMAL(9,6))
RETURNS INT NOT DETERMINISTIC
BEGIN
    DECLARE EXIT HANDLER FOR 1048
    BEGIN
        SET @MensajeDeError = 'Error de valor nulo en InsertarPunto()';
        SET @CodigoDeError = 1048;
        RETURN -1048;
    END; 

    DECLARE EXIT HANDLER FOR 1062
    BEGIN
        SET @MensajeDeError = 'Error de valor duplicado en InsertarPunto()';
        SET @CodigoDeError = 1062;
        RETURN -1062;
    END;

    INSERT INTO punto VALUES (
        NULL,
        a_Latitud,
        a_Longitud
    );
	
    RETURN LAST_INSERT_ID();
END$$

/*
*************************************************************
*				                InsertarCroquis				              *
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarCroquis`;
SELECT 'InsertarCroquis';

DELIMITER $$

CREATE FUNCTION `InsertarCroquis` (a_Creador INT, a_Dibujable INT)
RETURNS INT NOT DETERMINISTIC
BEGIN
    DECLARE Rastreable_P INT;

    DECLARE EXIT HANDLER FOR 1452
    BEGIN
        SET @MensajeDeError = 'Error de clave externa en InsertarCroquis()';
        SET @CodigoDeError = 1452;
        RETURN -1452;
    END;

    DECLARE EXIT HANDLER FOR 1062
    BEGIN
        SET @MensajeDeError = 'Error de valor duplicado en InsertarCroquis()';
        SET @CodigoDeError = 1062;
        RETURN -1062;
    END;

    DECLARE EXIT HANDLER FOR 1048
    BEGIN
        SET @MensajeDeError = 'Error de valor nulo en InsertarCroquis()';
        SET @CodigoDeError = 1048;
        RETURN -1048;
    END; 

    SELECT InsertarRastreable(a_Creador) INTO Rastreable_P;

    INSERT INTO croquis VALUES (
        Rastreable_P,
		NULL,
        a_Dibujable,
        -1, -1
    );

    RETURN LAST_INSERT_ID();
END$$

/*
*************************************************************
*				             InsertarPuntoDeCroquis			            *
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarPuntoDeCroquis`;
SELECT 'InsertarPuntoDeCroquis';

DELIMITER $$

CREATE FUNCTION `InsertarPuntoDeCroquis` (a_CroquisID INT, a_PuntoID INT)
RETURNS INT NOT DETERMINISTIC
BEGIN
    DECLARE EXIT HANDLER FOR 1452   
    BEGIN
        SET @MensajeDeError = 'Error de clave externa en InsertarPuntoDeCroquis()';
        SET @CodigoDeError = 1452;
        RETURN -1452;
    END;

    DECLARE EXIT HANDLER FOR 1062
    BEGIN
        SET @MensajeDeError = 'Error de valor duplicado en InsertarPuntoDeCroquis()';
        SET @CodigoDeError = 1062;
        RETURN -1062;
    END;

    INSERT INTO punto_de_croquis VALUES (
        a_CroquisID,
        a_PuntoID
    );
    
    RETURN TRUE;
END$$

/*
*************************************************************
*						InsertarPuntos						*
*************************************************************
*/

DELIMITER ;

DROP PROCEDURE IF EXISTS `InsertarPuntos`;
SELECT 'InsertarPuntos';

DELIMITER $$

CREATE PROCEDURE `InsertarPuntos` (a_CroquisID INT)
BEGIN
    DECLARE completado INT DEFAULT 0;
	DECLARE punto_id, bobo INT;
	DECLARE lat, lon DECIMAL(9,6);
  	DECLARE cur1 CURSOR FOR SELECT latitud, longitud FROM puntos;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET completado = 1;
  	
  	OPEN cur1;

  	REPEAT
    	FETCH cur1 INTO lat, lon;
    	IF NOT completado THEN
       		SELECT InsertarPunto(lat, lon) INTO punto_id;
			SELECT InsertarPuntoDeCroquis(a_CroquisID, punto_id) INTO bobo;
    	END IF;
  	UNTIL completado END REPEAT;

  	CLOSE cur1;
END$$

/***********************************************************/
DELIMITER ;
/***********************************************************/
