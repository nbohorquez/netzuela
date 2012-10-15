SELECT 'territorios.sql';
USE `spuria`;

/*
*************************************************************
*				InsertarTiendasConsumidores					*
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarTiendasConsumidores`;
SELECT 'InsertarTiendasConsumidores';

DELIMITER $$

CREATE FUNCTION `InsertarTiendasConsumidores` (a_TerritorioID CHAR(16), a_NumeroDeConsumidores INT, a_NumeroDeTiendas INT)
RETURNS INT NOT DETERMINISTIC
BEGIN
    DECLARE C, Pob INT;
	DECLARE Ahora DECIMAL(17,3);

    DECLARE EXIT HANDLER FOR 1452
    BEGIN
        SET @MensajeDeError = 'Error de clave externa en InsertarTiendasConsumidores()';
        SET @CodigoDeError = 1452;
        RETURN -1452;
    END; 

    DECLARE EXIT HANDLER FOR 1048
    BEGIN
        SET @MensajeDeError = 'Error de valor nulo en InsertarTiendasConsumidores()';
        SET @CodigoDeError = 1048;
        RETURN -1048;
    END;

	SELECT DATE_FORMAT(now_msec(), '%Y%m%d%H%i%S.%f') INTO Ahora;

    UPDATE tiendas_consumidores
    SET fecha_fin = IF ((SELECT COUNT(*) FROM (SELECT * FROM tiendas_consumidores) AS c) > 0, Ahora, fecha_fin)
    WHERE territorio_id = a_TerritorioID AND fecha_fin IS NULL;

    INSERT INTO tiendas_consumidores VALUES (
        a_TerritorioID,
        Ahora,
        NULL,
        a_NumeroDeConsumidores,
        a_NumeroDeTiendas
    );

    SELECT poblacion FROM territorio 
    WHERE territorio_id = a_TerritorioID INTO Pob;

	UPDATE territorio 
    SET consumidores_poblacion = IF(Pob > 0, a_NumeroDeConsumidores/Pob, 0), tiendas_poblacion = IF(Pob > 0, a_NumeroDeTiendas/Pob, 0),
	tiendas_consumidores = IF(a_NumeroDeConsumidores > 0, a_NumeroDeTiendas/a_NumeroDeConsumidores, NULL)
    WHERE territorio_id = a_TerritorioID;

    RETURN TRUE;
END$$

/*
*************************************************************
*					InsertarTerritorio						*
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarTerritorio`;
SELECT 'InsertarTerritorio';

DELIMITER $$

CREATE FUNCTION `InsertarTerritorio` (a_Creador INT, a_Nombre VARCHAR(45), a_Poblacion INT UNSIGNED, a_Idioma CHAR(10), a_Nivel INT UNSIGNED, a_TerritorioPadre CHAR(16), a_CodigoPostal CHAR(10), a_PIB DECIMAL(15,0))
RETURNS CHAR(16) NOT DETERMINISTIC
BEGIN
    DECLARE Dibujable_P, Rastreable_P, Resultado, Punto, C INT;
	DECLARE N CHAR(2);
	DECLARE ID, ACambiar, ADejarIgual CHAR(16);

    DECLARE EXIT HANDLER FOR 1048
    BEGIN
        SET @MensajeDeError = 'Error de valor nulo en InsertarTerritorio()';
        SET @CodigoDeError = 1048;
        RETURN -1048;
    END;

    SELECT InsertarDibujable() INTO Dibujable_P;
    SELECT InsertarRastreable(a_Creador) INTO Rastreable_P;

	SELECT COUNT(*) FROM territorio
	WHERE territorio_padre = a_TerritorioPadre
	INTO C;

	SELECT LPAD(HEX(C + 1), 2, '0') INTO N;
	SELECT LOCATE('00', a_TerritorioPadre) INTO Punto;
	SELECT LEFT(a_TerritorioPadre, Punto + 1) INTO ACambiar;
	SELECT RIGHT(a_TerritorioPadre, LENGTH(a_TerritorioPadre) - Punto - 1) INTO ADejarIgual;
	SELECT CONCAT(REPLACE(ACambiar, '00', N), ADejarIgual) INTO ID;

    INSERT INTO territorio VALUES (
        Rastreable_P,
        Dibujable_P,
        ID,
        a_Nombre,
        a_Poblacion,
		a_Idioma,
		a_Nivel,
		a_TerritorioPadre,
        0, 0, NULL,
		a_CodigoPostal, 
		a_PIB
    );

    SELECT InsertarTiendasConsumidores(ID, 0, 0) INTO Resultado;
    RETURN ID;
END$$

/*
*************************************************************
*						InsertarPais						*
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarPais`;
SELECT 'InsertarPais';

DELIMITER $$

CREATE FUNCTION `InsertarPais` (a_Creador INT, a_Nombre VARCHAR(45), a_Poblacion INT UNSIGNED, a_Idioma CHAR(10), a_CodigoPostal CHAR(10), a_PIB DECIMAL(15,0))
RETURNS CHAR(16) NOT DETERMINISTIC
BEGIN
    DECLARE C INT;
	DECLARE Territorio_P CHAR(16);

    DECLARE EXIT HANDLER FOR 1452
    BEGIN
        SET @MensajeDeError = 'Error de clave externa en InsertarPais()';
        SET @CodigoDeError = 1452;  
        RETURN -1452;
    END; 

    DECLARE EXIT HANDLER FOR 1048
    BEGIN
        SET @MensajeDeError = 'Error de valor nulo en InsertarPais()';
        SET @CodigoDeError = 1048;
        RETURN -1048;
    END;

    DECLARE EXIT HANDLER FOR 1062
    BEGIN
        SET @MensajeDeError = 'Error de valor duplicado en InsertarPais()';
        SET @CodigoDeError = 1062;
        RETURN -1062;
    END;
        
    /* Comprobamos que no haya otro pais en el mundo con el mismo nombre */
	SELECT COUNT(*) FROM territorio AS t
    WHERE t.nombre = a_Nombre AND t.nivel = 1
    INTO C;

    IF C = 0 THEN
		SELECT InsertarTerritorio(a_Creador, a_Nombre, a_Poblacion, a_Idioma, 1, '0.00.00.00.00.00', a_CodigoPostal, a_PIB) INTO Territorio_P;
        RETURN Territorio_P;
    ELSE    
        RETURN FALSE;
    END IF;
END$$

/*
*************************************************************
*                      InsertarEstado						*
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarEstado`;
SELECT 'InsertarEstado';

DELIMITER $$

CREATE FUNCTION `InsertarEstado` (a_Creador INT, a_Nombre VARCHAR(45), a_Poblacion INT UNSIGNED, a_Idioma CHAR(10), a_TerritorioPadre CHAR(16), a_CodigoPostal CHAR(10), a_PIB DECIMAL(15,0))
RETURNS CHAR(16) NOT DETERMINISTIC
BEGIN
    DECLARE C INT;
	DECLARE Territorio_P CHAR(16);

    DECLARE EXIT HANDLER FOR 1452
    BEGIN
        SET @MensajeDeError = 'Error de clave externa en InsertarEstado()';
        SET @CodigoDeError = 1452;
        RETURN -1452;
    END; 

    DECLARE EXIT HANDLER FOR 1048
    BEGIN
        SET @MensajeDeError = 'Error de valor nulo en InsertarEstado()';
        SET @CodigoDeError = 1048;
        RETURN -1048;
    END;
        
    /* Comprobamos que no haya otro estado hermano con el mismo nombre */
	SELECT COUNT(*) FROM territorio AS t
    WHERE t.nombre = a_Nombre AND t.nivel = 2 AND t.territorio_padre = a_TerritorioPadre
    INTO C;
/*
	SELECT
	CASE
	WHEN tmp.cuenta = 0 THEN InsertarTerritorio(a_Creador, a_Nombre, a_Poblacion, a_Idioma, 1, a_TerritorioPadre, a_CodigoPostal, a_PIB)
	ELSE FALSE
	END
	FROM (
		SELECT COUNT(*) cuenta
		FROM territorio AS t 
		WHERE t.nombre = a_Nombre AND t.nivel = 1 AND t.territorio_padre = a_TerritorioPadre
	) AS tmp
	INTO Territorio_P;
*/
    IF C = 0 THEN
        SELECT InsertarTerritorio(a_Creador, a_Nombre, a_Poblacion, a_Idioma, 2, a_TerritorioPadre, a_CodigoPostal, a_PIB) INTO Territorio_P;
        RETURN Territorio_P;
    ELSE
        RETURN FALSE;
    END IF;
/*
	RETURN Territorio_P;
*/
END$$

/*
*************************************************************
*                     InsertarMunicipio				        *
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarMunicipio`;
SELECT 'InsertarMunicipio';

DELIMITER $$

CREATE FUNCTION `InsertarMunicipio` (a_Creador INT, a_Nombre VARCHAR(45), a_Poblacion INT UNSIGNED, a_Idioma CHAR(10), a_TerritorioPadre CHAR(16), a_CodigoPostal CHAR(10), a_PIB DECIMAL(15,0))
RETURNS CHAR(16) NOT DETERMINISTIC
BEGIN
    DECLARE C INT;
	DECLARE Territorio_P CHAR(16);

    DECLARE EXIT HANDLER FOR 1452
    BEGIN
        SET @MensajeDeError = 'Error de clave externa en InsertarMunicipio()';
        SET @CodigoDeError = 1452;
        RETURN -1452;
    END; 

    DECLARE EXIT HANDLER FOR 1048
    BEGIN
        SET @MensajeDeError = 'Error de valor nulo en InsertarMunicipio()';
        SET @CodigoDeError = 1048;
        RETURN -1048;
    END;

	/* Comprobamos que no haya otro municipio hermano con el mismo nombre */    	
	SELECT COUNT(*) FROM territorio AS t
    WHERE t.nombre = a_Nombre AND t.nivel = 3 AND t.territorio_padre = a_TerritorioPadre
    INTO C;

	IF C = 0 THEN
        SELECT InsertarTerritorio(a_Creador, a_Nombre, a_Poblacion, a_Idioma, 3, a_TerritorioPadre, a_CodigoPostal, a_PIB) INTO Territorio_P;
        RETURN Territorio_P;
    ELSE
        RETURN FALSE;
    END IF;
END$$

/*
*************************************************************
*                     InsertarParroquia						*
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarParroquia`;
SELECT 'InsertarParroquia';

DELIMITER $$

CREATE FUNCTION `InsertarParroquia` (a_Creador INT, a_Nombre VARCHAR(45), a_Poblacion INT UNSIGNED, a_Idioma CHAR(10), a_TerritorioPadre CHAR(16), a_CodigoPostal CHAR(10), a_PIB DECIMAL(15,0))
RETURNS CHAR(16) NOT DETERMINISTIC
BEGIN
    DECLARE C INT;
	DECLARE Territorio_P CHAR(16);

    DECLARE EXIT HANDLER FOR 1452
    BEGIN
        SET @MensajeDeError = 'Error de clave externa en InsertarParroquia()';
        SET @CodigoDeError = 1452;
        RETURN -1452;
    END; 

    DECLARE EXIT HANDLER FOR 1048
    BEGIN
        SET @MensajeDeError = 'Error de valor nulo en InsertarParroquia()';
        SET @CodigoDeError = 1048;
        RETURN -1048;
    END;

    /* Comprobamos que no haya otra parroquia hermana con el mismo nombre */
	SELECT COUNT(*) FROM territorio AS t
    WHERE t.nombre = a_Nombre AND t.nivel = 4 AND t.territorio_padre = a_TerritorioPadre
    INTO C;

    IF C = 0 THEN
        SELECT InsertarTerritorio(a_Creador, a_Nombre, a_Poblacion, a_Idioma, 4, a_TerritorioPadre, a_CodigoPostal, a_PIB) INTO Territorio_P;
        RETURN Territorio_P;
    ELSE
        RETURN FALSE;
    END IF;	
END$$

/***********************************************************/
DELIMITER ;
/***********************************************************/
