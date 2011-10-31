USE `Spuria`;

/*
*************************************************************
*			EstadisticasTemporalesCrear			*
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `EstadisticasTemporalesCrear`;
DELIMITER $$

CREATE FUNCTION `EstadisticasTemporalesCrear` (a_EstadisticasID INT, a_Contador INT, a_Ranking INT, a_Indice INT)
RETURNS INT NOT DETERMINISTIC
BEGIN
	DECLARE C INT;
/*
	DECLARE EXIT HANDLER FOR 1452
	BEGIN
		SET @MensajeDeError = 'Error de clave externa en EstadisticasTemporalesCrear()';
		SET @CodigoDeError = 1452;
		RETURN -1452;
	END; 

	DECLARE EXIT HANDLER FOR 1048
	BEGIN
		SET @MensajeDeError = 'Error de valor nulo en EstadisticasTemporalesCrear()';
		SET @CodigoDeError = 1048;
		RETURN -1048;
	END; 
*/
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
*			ContadorDeExhibicionesCrear			*
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `ContadorDeExhibicionesCrear`;
DELIMITER $$

CREATE FUNCTION `ContadorDeExhibicionesCrear` (a_EstadisticasDeVisitasID INT, a_ContadorDeExhibiciones INT)
RETURNS INT NOT DETERMINISTIC
BEGIN
	DECLARE C INT;
/*
	DECLARE EXIT HANDLER FOR 1452
	BEGIN
		SET @MensajeDeError = 'Error de clave externa en ContadorDeExhibicionesCrear()';
		SET @CodigoDeError = 1452;
		RETURN -1452;
	END; 

	DECLARE EXIT HANDLER FOR 1048
	BEGIN
		SET @MensajeDeError = 'Error de valor nulo en ContadorDeExhibicionesCrear()';
		SET @CodigoDeError = 1048;
		RETURN -1048;
	END; 
*/
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
*				EstadisticasCrear				*
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `EstadisticasCrear`;
DELIMITER $$

CREATE FUNCTION `EstadisticasCrear` (a_Creador INT, a_RegionGeografica INT)
RETURNS INT NOT DETERMINISTIC
BEGIN
	DECLARE Rastreable_P, EstaID, bobo INT;
/*
	DECLARE EXIT HANDLER FOR 1452
	BEGIN
		SET @MensajeDeError = 'Error de clave externa en EstadisticasCrear()';
		SET @CodigoDeError = 1452;
		RETURN -1452;
	END; 

	DECLARE EXIT HANDLER FOR 1048
	BEGIN
		SET @MensajeDeError = 'Error de valor nulo en EstadisticasCrear()';
		SET @CodigoDeError = 1048;
		RETURN -1048;
	END; 

	DECLARE EXIT HANDLER FOR 1062
	BEGIN
		SET @MensajeDeError = 'Error de valor duplicado en EstadisticasCrear()';
		SET @CodigoDeError = 1062;
		RETURN -1062;
	END; 
*/
	SELECT RastreableCrear(a_Creador) INTO Rastreable_P;

	INSERT INTO Estadisticas VALUES (
		Rastreable_P,
		NULL,
		a_RegionGeografica
	);

	SELECT LAST_INSERT_ID() INTO EstaID;
	SELECT EstadisticasTemporalesCrear(EstaID, 0, 0, 0) INTO bobo;
	RETURN EstaID;
END$$

/*
*************************************************************
*			EstadisticasDeInfluenciaCrear			*
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `EstadisticasDeInfluenciaCrear`;
DELIMITER $$

CREATE FUNCTION `EstadisticasDeInfluenciaCrear` (a_Creador INT, a_Palabra INT, a_RegionGeografica INT)
RETURNS INT NOT DETERMINISTIC
BEGIN
	DECLARE Estadisticas_P INT;
/*
	DECLARE EXIT HANDLER FOR 1452
	BEGIN
		SET @MensajeDeError = 'Error de clave externa en EstadisticasDeInfluenciaCrear()';
		SET @CodigoDeError = 1452;
		RETURN -1452;
	END; 

	DECLARE EXIT HANDLER FOR 1048
	BEGIN
		SET @MensajeDeError = 'Error de valor nulo en EstadisticasDeInfluenciaCrear()';
		SET @CodigoDeError = 1048;
		RETURN -1048;
	END; 

	DECLARE EXIT HANDLER FOR 1062
	BEGIN
		SET @MensajeDeError = 'Error de valor duplicado en EstadisticasDeInfluenciaCrear()';
		SET @CodigoDeError = 1062;
		RETURN -1062;
	END; 
*/
	SELECT EstadisticasCrear(a_Creador, a_RegionGeografica) INTO Estadisticas_P;
	
	INSERT INTO EstadisticasDeInfluencia VALUES (
		Estadisticas_P,
		NULL,
		a_Palabra,
		0, 0, 0, 0, 0
	);
	
	RETURN LAST_INSERT_ID();
END$$

/*
*************************************************************
*			EstadisticasDePopularidadCrear		*
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `EstadisticasDePopularidadCrear`;
DELIMITER $$

CREATE FUNCTION `EstadisticasDePopularidadCrear` (a_Creador INT, a_CalificableSeguible INT, a_RegionGeografica INT)
RETURNS INT NOT DETERMINISTIC
BEGIN
	DECLARE Estadisticas_P INT;
/*
	DECLARE EXIT HANDLER FOR 1452
	BEGIN
		SET @MensajeDeError = 'Error de clave externa en EstadisticasDePopularidadCrear()';
		SET @CodigoDeError = 1452;
		RETURN -1452;
	END; 

	DECLARE EXIT HANDLER FOR 1048
	BEGIN
		SET @MensajeDeError = 'Error de valor nulo en EstadisticasDePopularidadCrear()';
		SET @CodigoDeError = 1048;
		RETURN -1048;
	END; 

	DECLARE EXIT HANDLER FOR 1062
	BEGIN
		SET @MensajeDeError = 'Error de valor duplicado en EstadisticasDePopularidadCrear()';
		SET @CodigoDeError = 1062;
		RETURN -1062;
	END; 
*/
	SELECT EstadisticasCrear(a_Creador, a_RegionGeografica) INTO Estadisticas_P;
	
	INSERT INTO EstadisticasDePopularidad VALUES (
		Estadisticas_P,
		NULL,
		a_CalificableSeguible,
		0, 0, 0, 0, 0, 0
	);
	
	RETURN LAST_INSERT_ID();
END$$

/*
*************************************************************
*			EstadisticasDeVisitasCrear			*
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `EstadisticasDeVisitasCrear`;
DELIMITER $$

CREATE FUNCTION `EstadisticasDeVisitasCrear` (a_Creador INT, a_Buscable INT, a_RegionGeografica INT)
RETURNS INT NOT DETERMINISTIC
BEGIN
	DECLARE Estadisticas_P, bobo INT;
/*
	DECLARE EXIT HANDLER FOR 1452
	BEGIN
		SET @MensajeDeError = 'Error de clave externa en EstadisticasDeVisitasCrear()';
		SET @CodigoDeError = 1452;
		RETURN -1452;
	END; 

	DECLARE EXIT HANDLER FOR 1048
	BEGIN
		SET @MensajeDeError = 'Error de valor nulo en EstadisticasDeVisitasCrear()';
		SET @CodigoDeError = 1048;
		RETURN -1048;
	END; 

	DECLARE EXIT HANDLER FOR 1062
	BEGIN
		SET @MensajeDeError = 'Error de valor duplicado en EstadisticasDeVisitasCrear()';
		SET @CodigoDeError = 1062;
		RETURN -1062;
	END; 
*/
	SELECT EstadisticasCrear(a_Creador, a_RegionGeografica) INTO Estadisticas_P;
	
	INSERT INTO EstadisticasDeVisitas VALUES (
		Estadisticas_P,
		NULL,
		a_Buscable
	);

	SELECT LAST_INSERT_ID() INTO bobo;
	SELECT ContadorDeExhibicionesCrear(bobo, 0) INTO bobo;
	RETURN bobo; 
END$$

/***********************************************************/
DELIMITER ;
/***********************************************************/