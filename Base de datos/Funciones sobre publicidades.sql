SELECT 'Funciones sobre publicidades.sql';
USE `Spuria`;

/*
*************************************************************
*				PublicidadCrear				*
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `PublicidadCrear`;
SELECT 'PublicidadCrear';

DELIMITER $$

CREATE FUNCTION `PublicidadCrear` (a_Creador INT, a_Patrocinante INT)

RETURNS INT NOT DETERMINISTIC
BEGIN
	DECLARE Buscable_P, Describible_P, Rastreable_P, Etiquetable_P, Cobrable_P INT;
/*	
	DECLARE EXIT HANDLER FOR 1452
	BEGIN
		SET @MensajeDeError = 'Error de clave externa en PublicidadCrear()';
		SET @CodigoDeError = 1452;
		RETURN -1452;
	END; 

	DECLARE EXIT HANDLER FOR 1048
	BEGIN
		SET @MensajeDeError = 'Error de valor nulo en PublicidadCrear()';
		SET @CodigoDeError = 1048;
		RETURN -1048;
	END;
*/
	SELECT BuscableCrear() INTO Buscable_P;
	SELECT DescribibleCrear() INTO Describible_P;
	SELECT RastreableCrear(a_Creador) INTO Rastreable_P;
	SELECT EtiquetableCrear() INTO Etiquetable_P;
	SELECT CobrableCrear() INTO Cobrable_P;

	INSERT INTO Publicidad VALUES (
		Buscable_P,
		Describible_P,
		Rastreable_P,
		Etiquetable_P,
		Cobrable_P,
		NULL,
		a_Patrocinante, 
		NULL
	);
		
	RETURN LAST_INSERT_ID();
END$$

/*
*************************************************************
*			ConsumidorObjetivoCrear				*
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `ConsumidorObjetivoCrear`;
SELECT 'ConsumidorObjetivoCrear';

DELIMITER $$

CREATE FUNCTION `ConsumidorObjetivoCrear` (a_PublicidadID INT, a_ConsumidorID INT)

RETURNS INT NOT DETERMINISTIC
BEGIN
/*
	DECLARE EXIT HANDLER FOR 1452
	BEGIN
		SET @MensajeDeError = 'Error de clave externa en ConsumidorObjetivoCrear()';
		SET @CodigoDeError = 1452;
		RETURN -1452;
	END; 

	DECLARE EXIT HANDLER FOR 1048
	BEGIN
		SET @MensajeDeError = 'Error de valor nulo en ConsumidorObjetivoCrear()';
		SET @CodigoDeError = 1048;
		RETURN -1048;
	END;

	DECLARE EXIT HANDLER FOR 1062
	BEGIN
		SET @MensajeDeError = 'Error de valor duplicado en ConsumidorObjetivoCrear()';
		SET @CodigoDeError = 1062;
		RETURN -1062;
	END; 
*/
	INSERT INTO ConsumidorObjetivo VALUES (
		a_PublicidadID,
		a_ConsumidorID
	);
	RETURN TRUE;
END $$

/*
*************************************************************
*			GrupoDeEdadObjetivoCrear			*
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `GrupoDeEdadObjetivoCrear`;
SELECT 'GrupoDeEdadObjetivoCrear';

DELIMITER $$

CREATE FUNCTION `GrupoDeEdadObjetivoCrear` (a_PublicidadID INT, a_GrupoDeEdad CHAR(15))

RETURNS INT NOT DETERMINISTIC
BEGIN
/*
	DECLARE EXIT HANDLER FOR 1452
	BEGIN
		SET @MensajeDeError = 'Error de clave externa en GrupoDeEdadObjetivoCrear()';
		SET @CodigoDeError = 1452;
		RETURN -1452;
	END; 

	DECLARE EXIT HANDLER FOR 1048
	BEGIN
		SET @MensajeDeError = 'Error de valor nulo en GrupoDeEdadObjetivoCrear()';
		SET @CodigoDeError = 1048;
		RETURN -1048;
	END;

	DECLARE EXIT HANDLER FOR 1062
	BEGIN
		SET @MensajeDeError = 'Error de valor duplicado en GrupoDeEdadObjetivoCrear()';
		SET @CodigoDeError = 1062;
		RETURN -1062;
	END; 
*/
	INSERT INTO GrupoDeEdadObjetivo VALUES (
		a_PublicidadID,
		a_GrupoDeEdad
	);

	RETURN TRUE;
END $$

/*
*************************************************************
*		GradoDeInstruccionObjetivoCrear			*
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `GradoDeInstruccionObjetivoCrear`;
SELECT 'GradoDeInstruccionObjetivoCrear';

DELIMITER $$

CREATE FUNCTION `GradoDeInstruccionObjetivoCrear` (a_PublicidadID INT, a_GradoDeInstruccion CHAR(16))

RETURNS INT NOT DETERMINISTIC
BEGIN
/*
	DECLARE EXIT HANDLER FOR 1452
	BEGIN
		SET @MensajeDeError = 'Error de clave externa en GradoDeInstruccionObjetivoCrear()';
		SET @CodigoDeError = 1452;
		RETURN -1452;
	END; 

	DECLARE EXIT HANDLER FOR 1048
	BEGIN
		SET @MensajeDeError = 'Error de valor nulo en GradoDeInstruccionObjetivoCrear()';
		SET @CodigoDeError = 1048;
		RETURN -1048;
	END;

	DECLARE EXIT HANDLER FOR 1062
	BEGIN
		SET @MensajeDeError = 'Error de valor duplicado en GradoDeInstruccionObjetivoCrear()';
		SET @CodigoDeError = 1062;
		RETURN -1062;
	END; 
*/
	INSERT INTO GradoDeInstruccionObjetivo VALUES (
		a_PublicidadID,
		a_GradoDeInstruccion
	);

	RETURN TRUE;
END $$

/*
*************************************************************
*			RegionGeograficaObjetivoCrear			*
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `RegionGeograficaObjetivoCrear`;
SELECT 'RegionGeograficaObjetivoCrear';

DELIMITER $$

CREATE FUNCTION `RegionGeograficaObjetivoCrear` (a_PublicidadID INT, a_RegionGeograficaID INT)

RETURNS INT NOT DETERMINISTIC
BEGIN
/*
	DECLARE EXIT HANDLER FOR 1452
	BEGIN
		SET @MensajeDeError = 'Error de clave externa en RegionGeograficaObjetivoCrear()';
		SET @CodigoDeError = 1452;
		RETURN -1452;
	END; 

	DECLARE EXIT HANDLER FOR 1048
	BEGIN
		SET @MensajeDeError = 'Error de valor nulo en RegionGeograficaObjetivoCrear()';
		SET @CodigoDeError = 1048;
		RETURN -1048;
	END;

	DECLARE EXIT HANDLER FOR 1062
	BEGIN
		SET @MensajeDeError = 'Error de valor duplicado en RegionGeograficaObjetivoCrear()';
		SET @CodigoDeError = 1062;
		RETURN -1062;
	END; 
*/
	INSERT INTO RegionGeograficaObjetivo VALUES (
		a_PublicidadID,
		a_RegionGeograficaID
	);

	RETURN TRUE;
END $$

/*
*************************************************************
*				SexoObjetivoCrear				*
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `SexoObjetivoCrear`;
SELECT 'SexoObjetivoCrear';

DELIMITER $$

CREATE FUNCTION `SexoObjetivoCrear` (a_PublicidadID INT, a_Sexo CHAR(6))

RETURNS INT NOT DETERMINISTIC
BEGIN
/*
	DECLARE EXIT HANDLER FOR 1452
	BEGIN
		SET @MensajeDeError = 'Error de clave externa en SexoObjetivoCrear()';
		SET @CodigoDeError = 1452;
		RETURN -1452;
	END; 

	DECLARE EXIT HANDLER FOR 1048
	BEGIN
		SET @MensajeDeError = 'Error de valor nulo en SexoObjetivoCrear()';
		SET @CodigoDeError = 1048;
		RETURN -1048;
	END;

	DECLARE EXIT HANDLER FOR 1062
	BEGIN
		SET @MensajeDeError = 'Error de valor duplicado en SexoObjetivoCrear()';
		SET @CodigoDeError = 1062;
		RETURN -1062;
	END; 
*/
	INSERT INTO SexoObjetivo VALUES (
		a_PublicidadID,
		a_Sexo
	);

	RETURN TRUE;
END $$

/***********************************************************/
DELIMITER ;
/***********************************************************/