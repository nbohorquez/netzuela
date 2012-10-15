SELECT 'estadisticas.sql';
USE `spuria`;

/*
*************************************************************
*			           InsertarEstadisticasTemporales			        *
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarEstadisticasTemporales`;
SELECT 'InsertarEstadisticasTemporales';

DELIMITER $$

CREATE FUNCTION `InsertarEstadisticasTemporales` (a_EstadisticasID INT, a_Contador INT, a_Ranking INT, a_Indice INT)
RETURNS INT NOT DETERMINISTIC
BEGIN
    DECLARE C INT;
	DECLARE Ahora DECIMAL(17,3);

    DECLARE EXIT HANDLER FOR 1452
    BEGIN
        SET @MensajeDeError = 'Error de clave externa en InsertarEstadisticasTemporales()';
        SET @CodigoDeError = 1452;
        RETURN -1452;
    END; 

    DECLARE EXIT HANDLER FOR 1048
    BEGIN
        SET @MensajeDeError = 'Error de valor nulo en InsertarEstadisticasTemporales()';
        SET @CodigoDeError = 1048;
        RETURN -1048;
    END; 

	SELECT DATE_FORMAT(now_msec(), '%Y%m%d%H%i%S.%f') INTO Ahora;
  
	UPDATE estadisticas_temporales
    SET fecha_fin = IF ((SELECT COUNT(*) FROM (SELECT * FROM estadisticas_temporales) AS c) > 0, Ahora, fecha_fin)
    WHERE estadisticas_id = a_EstadisticasID AND fecha_fin IS NULL;

    INSERT INTO estadisticas_temporales VALUES (
        a_EstadisticasID,
        Ahora,
        NULL,
        a_Contador,
        a_Ranking,
        a_Indice
    );

    RETURN TRUE;
END$$

/*
*************************************************************
*			          InsertarContadorDeExhibiciones			        *
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarContadorDeExhibiciones`;
SELECT 'InsertarContadorDeExhibiciones';

DELIMITER $$

CREATE FUNCTION `InsertarContadorDeExhibiciones` (a_EstadisticasDeVisitasID INT, a_ContadorDeExhibiciones INT)
RETURNS INT NOT DETERMINISTIC
BEGIN
    DECLARE C INT;
    DECLARE Ahora DECIMAL(17,3);

    DECLARE EXIT HANDLER FOR 1452
    BEGIN
        SET @MensajeDeError = 'Error de clave externa en InsertarContadorDeExhibiciones()';
        SET @CodigoDeError = 1452;
        RETURN -1452;
    END; 

    DECLARE EXIT HANDLER FOR 1048
    BEGIN
        SET @MensajeDeError = 'Error de valor nulo en InsertarContadorDeExhibiciones()';
        SET @CodigoDeError = 1048;
        RETURN -1048;
    END; 

	SELECT DATE_FORMAT(now_msec(), '%Y%m%d%H%i%S.%f') INTO Ahora;

    UPDATE contador_de_exhibiciones
    SET fecha_fin = IF ((SELECT COUNT(*) FROM (SELECT * FROM contador_de_exhibiciones) AS c) > 0, Ahora, fecha_fin)
    WHERE estadisticas_de_visitas_id = a_EstadisticasDeVisitasID AND fecha_fin IS NULL;
	
    INSERT INTO contador_de_exhibiciones VALUES (
        a_EstadisticasDeVisitasID,
        Ahora,
        NULL,
        a_ContadorDeExhibiciones
    );

    RETURN TRUE;
END$$

/*
*************************************************************
*				             InsertarEstadisticas				            *
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarEstadisticas`;
SELECT 'InsertarEstadisticas';

DELIMITER $$

CREATE FUNCTION `InsertarEstadisticas` (a_Creador INT, a_Territorio CHAR(16))
RETURNS INT NOT DETERMINISTIC
BEGIN
    DECLARE Rastreable_P, EstaID, Resultado INT;

    DECLARE EXIT HANDLER FOR 1452
    BEGIN
        SET @MensajeDeError = 'Error de clave externa en InsertarEstadisticas()';
        SET @CodigoDeError = 1452;
        RETURN -1452;
    END; 

    DECLARE EXIT HANDLER FOR 1048
    BEGIN
        SET @MensajeDeError = 'Error de valor nulo en InsertarEstadisticas()';
        SET @CodigoDeError = 1048;
        RETURN -1048;
    END; 

    DECLARE EXIT HANDLER FOR 1062
    BEGIN
        SET @MensajeDeError = 'Error de valor duplicado en InsertarEstadisticas()';
        SET @CodigoDeError = 1062;
        RETURN -1062;
    END; 

    SELECT InsertarRastreable(a_Creador) INTO Rastreable_P;

    INSERT INTO estadisticas VALUES (
        Rastreable_P,
        NULL,
        a_Territorio
    );
    
    SELECT LAST_INSERT_ID() INTO EstaID;
    SELECT InsertarEstadisticasTemporales(EstaID, 0, 0, 0) INTO Resultado;
    
    RETURN EstaID;
END$$

/*
*************************************************************
*			          InsertarEstadisticasDeInfluencia		        *
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarEstadisticasDeInfluencia`;
SELECT 'InsertarEstadisticasDeInfluencia';

DELIMITER $$

CREATE FUNCTION `InsertarEstadisticasDeInfluencia` (a_Creador INT, a_Palabra INT, a_Territorio CHAR(16))
RETURNS INT NOT DETERMINISTIC
BEGIN
    DECLARE Estadisticas_P INT;
        
    DECLARE EXIT HANDLER FOR 1452
    BEGIN
        SET @MensajeDeError = 'Error de clave externa en InsertarEstadisticasDeInfluencia()';
        SET @CodigoDeError = 1452;
        RETURN -1452;
    END; 

    DECLARE EXIT HANDLER FOR 1048
    BEGIN
        SET @MensajeDeError = 'Error de valor nulo en InsertarEstadisticasDeInfluencia()';
        SET @CodigoDeError = 1048;
        RETURN -1048;
    END; 

    DECLARE EXIT HANDLER FOR 1062
    BEGIN
        SET @MensajeDeError = 'Error de valor duplicado en InsertarEstadisticasDeInfluencia()';
        SET @CodigoDeError = 1062;
        RETURN -1062;
    END; 

    SELECT InsertarEstadisticas(a_Creador, a_Territorio) INTO Estadisticas_P;
	
    INSERT INTO estadisticas_de_influencia VALUES (
        Estadisticas_P,
        NULL,
        a_Palabra,
        0, 0, 0, 0, 0
    );
	
    RETURN LAST_INSERT_ID();
END$$

/*
*************************************************************
*			          InsertarEstadisticasDePopularidad		        *
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarEstadisticasDePopularidad`;
SELECT 'InsertarEstadisticasDePopularidad';

DELIMITER $$

CREATE FUNCTION `InsertarEstadisticasDePopularidad` (a_Creador INT, a_CalificableSeguible INT, a_Territorio CHAR(16))
RETURNS INT NOT DETERMINISTIC
BEGIN
    DECLARE Estadisticas_P INT;

    DECLARE EXIT HANDLER FOR 1452
    BEGIN
        SET @MensajeDeError = 'Error de clave externa en InsertarEstadisticasDePopularidad()';
        SET @CodigoDeError = 1452;
        RETURN -1452;
    END; 

    DECLARE EXIT HANDLER FOR 1048
    BEGIN
        SET @MensajeDeError = 'Error de valor nulo en InsertarEstadisticasDePopularidad()';
        SET @CodigoDeError = 1048;
        RETURN -1048;
    END; 

    DECLARE EXIT HANDLER FOR 1062
    BEGIN
        SET @MensajeDeError = 'Error de valor duplicado en InsertarEstadisticasDePopularidad()';
        SET @CodigoDeError = 1062;
        RETURN -1062;
    END; 

    SELECT InsertarEstadisticas(a_Creador, a_Territorio) INTO Estadisticas_P;
	
    INSERT INTO estadisticas_de_popularidad VALUES (
        Estadisticas_P,
        NULL,
        a_CalificableSeguible,
        0, 0, 0, 0, 0, 0
    );
	
    RETURN LAST_INSERT_ID();
END$$

/*
*************************************************************
*                InsertarEstadisticasDeVisitas			        *
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarEstadisticasDeVisitas`;
SELECT 'InsertarEstadisticasDeVisitas';

DELIMITER $$

CREATE FUNCTION `InsertarEstadisticasDeVisitas` (a_Creador INT, a_Buscable INT, a_Territorio CHAR(16))
RETURNS INT NOT DETERMINISTIC
BEGIN
    DECLARE Estadisticas_P, EstaID, Resultado INT;
    
    DECLARE EXIT HANDLER FOR 1452
    BEGIN
        SET @MensajeDeError = 'Error de clave externa en InsertarEstadisticasDeVisitas()';
        SET @CodigoDeError = 1452;
        RETURN -1452;
    END; 

    DECLARE EXIT HANDLER FOR 1048
    BEGIN
        SET @MensajeDeError = 'Error de valor nulo en InsertarEstadisticasDeVisitas()';
        SET @CodigoDeError = 1048;
        RETURN -1048;
    END; 

    DECLARE EXIT HANDLER FOR 1062
    BEGIN
        SET @MensajeDeError = 'Error de valor duplicado en InsertarEstadisticasDeVisitas()';
        SET @CodigoDeError = 1062;
        RETURN -1062;
    END; 

    SELECT InsertarEstadisticas(a_Creador, a_Territorio) INTO Estadisticas_P;

    INSERT INTO estadisticas_de_visitas VALUES (
        Estadisticas_P,
        NULL,
        a_Buscable
    );

    SELECT LAST_INSERT_ID() INTO EstaID;
    SELECT InsertarContadorDeExhibiciones(EstaID, 0) INTO Resultado;
    
    RETURN EstaID; 
END$$

/***********************************************************/
DELIMITER ;
/***********************************************************/
