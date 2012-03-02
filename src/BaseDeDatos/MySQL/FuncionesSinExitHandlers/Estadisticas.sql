SELECT 'Funciones sobre estadisticas.sql';
USE `Spuria`;

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

    SELECT COUNT(*) FROM EstadisticasTemporales
    WHERE EstadisticasID = a_EstadisticasID
    INTO C;
  
    IF C > 0 THEN /* Hay ya por lo menos un valor historico almacenado; hay que sustituirlo */
        UPDATE EstadisticasTemporales
        SET FechaFin = NOW() 
        WHERE EstadisticasID = a_EstadisticasID AND FechaFin IS NULL;
    END IF;
	
    INSERT INTO EstadisticasTemporales VALUES (
        a_EstadisticasID,
        NOW(),
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

    SELECT COUNT(*) FROM ContadorDeExhibiciones
    WHERE EstadisticasDeVisitasID = a_EstadisticasDeVisitasID
    INTO C;

    IF C > 0 THEN /* Hay ya por lo menos un valor historico almacenado; hay que sustituirlo */
        UPDATE ContadorDeExhibiciones
        SET FechaFin = NOW() 
        WHERE EstadisticasDeVisitasID = a_EstadisticasDeVisitasID AND FechaFin IS NULL;
    END IF;
	
    INSERT INTO ContadorDeExhibiciones VALUES (
        a_EstadisticasDeVisitasID,
        NOW(),
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

CREATE FUNCTION `InsertarEstadisticas` (a_Creador INT, a_RegionGeografica INT)
RETURNS INT NOT DETERMINISTIC
BEGIN
    DECLARE v_Rastreable_P, EstaID, Resultado INT;

    SELECT InsertarRastreable(a_Creador) INTO v_Rastreable_P;

    INSERT INTO Estadisticas (
        Rastreable_P,
        RegionGeografica
    ) VALUES (
        v_Rastreable_P,
        a_RegionGeografica
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

CREATE FUNCTION `InsertarEstadisticasDeInfluencia` (a_Creador INT, a_Palabra INT, a_RegionGeografica INT)
RETURNS INT NOT DETERMINISTIC
BEGIN
    DECLARE v_Estadisticas_P INT;
        
    SELECT InsertarEstadisticas(a_Creador, a_RegionGeografica) INTO v_Estadisticas_P;
	
    INSERT INTO EstadisticasDeInfluencia (
        Estadisticas_P,
        Palabra,
        NumeroDeDescripciones,
        NumeroDeMensajes,
        NumeroDeCategorias,
        NumeroDeResenas,
        NumeroDePublicidades
    ) VALUES (
        v_Estadisticas_P,
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

CREATE FUNCTION `InsertarEstadisticasDePopularidad` (a_Creador INT, a_CalificableSeguible INT, a_RegionGeografica INT)
RETURNS INT NOT DETERMINISTIC
BEGIN
    DECLARE v_Estadisticas_P INT;

    SELECT InsertarEstadisticas(a_Creador, a_RegionGeografica) INTO v_Estadisticas_P;
	
    INSERT INTO EstadisticasDePopularidad (
        Estadisticas_P,
        CalificableSeguible,
        NumeroDeCalificaciones,
        NumeroDeResenas,
        NumeroDeSeguidores,
        NumeroDeMenciones,
        NumeroDeVendedores,
        NumeroDeMensajes
    ) VALUES (
        v_Estadisticas_P,
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

CREATE FUNCTION `InsertarEstadisticasDeVisitas` (a_Creador INT, a_Buscable INT, a_RegionGeografica INT)
RETURNS INT NOT DETERMINISTIC
BEGIN
    DECLARE v_Estadisticas_P, EstaID, Resultado INT;
    
    SELECT InsertarEstadisticas(a_Creador, a_RegionGeografica) INTO v_Estadisticas_P;

    INSERT INTO EstadisticasDeVisitas (
        Estadisticas_P,
        Buscable
    ) VALUES (
        v_Estadisticas_P,
        a_Buscable
    );

    SELECT LAST_INSERT_ID() INTO EstaID;
    SELECT InsertarContadorDeExhibiciones(EstaID, 0) INTO Resultado;
    
    RETURN EstaID; 
END$$

/***********************************************************/
DELIMITER ;
/***********************************************************/