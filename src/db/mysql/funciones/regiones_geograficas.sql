SELECT 'regiones_geograficas.sql';
USE `spuria`;

/*
*************************************************************
*			            InsertarTiendasConsumidores			          *
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarTiendasConsumidores`;
SELECT 'InsertarTiendasConsumidores';

DELIMITER $$

CREATE FUNCTION `InsertarTiendasConsumidores` (a_RegionGeograficaID INT, a_NumeroDeConsumidores INT, a_NumeroDeTiendas INT)
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

    SELECT COUNT(*) FROM tiendas_consumidores
    WHERE region_geografica_id = a_RegionGeograficaID
    INTO C;

	SELECT DATE_FORMAT(now_msec(), '%Y%m%d%H%i%S.%f') INTO Ahora;

    IF C > 0 THEN /* Hay ya por lo menos un valor historico almacenado; hay que sustituirlo */
        UPDATE tiendas_consumidores
        SET fecha_fin = Ahora
        WHERE region_geografica_id = a_RegionGeograficaID AND fecha_fin IS NULL;
    END IF;

    INSERT INTO tiendas_consumidores VALUES (
        a_RegionGeograficaID,
        Ahora,
        NULL,
        a_NumeroDeConsumidores,
        a_NumeroDeTiendas
    );

    SELECT poblacion FROM region_geografica 
    WHERE region_geografica_id = a_RegionGeograficaID INTO Pob;

    UPDATE region_geografica 
    SET consumidores_poblacion = IF(Pob > 0, a_NumeroDeConsumidores/Pob, 0), tiendas_poblacion = IF(Pob > 0, a_NumeroDeTiendas/Pob, 0)
    WHERE region_geografica_id = a_RegionGeograficaID;
        
    UPDATE region_geografica 
    SET tiendas_consumidores = IF(a_NumeroDeConsumidores > 0, a_NumeroDeTiendas/a_NumeroDeConsumidores, NULL)
    WHERE region_geografica_id = a_RegionGeograficaID;

    RETURN TRUE;
END$$

/*
*************************************************************
*			             InsertarRegionGeografica				          *
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarRegionGeografica`;
SELECT 'InsertarRegionGeografica';

DELIMITER $$

CREATE FUNCTION `InsertarRegionGeografica` (a_Creador INT, a_Nombre VARCHAR(45), a_Poblacion INT UNSIGNED)
RETURNS INT NOT DETERMINISTIC
BEGIN
    DECLARE RegionGeografica_P, Dibujable_P, Rastreable_P, Resultado INT;

    DECLARE EXIT HANDLER FOR 1048
    BEGIN
        SET @MensajeDeError = 'Error de valor nulo en InsertarRegionGeografica()';
        SET @CodigoDeError = 1048;
        RETURN -1048;
    END;

    SELECT InsertarDibujable() INTO Dibujable_P;
    SELECT InsertarRastreable(a_Creador) INTO Rastreable_P;
	
    INSERT INTO region_geografica VALUES (
        Rastreable_P,
        Dibujable_P,
        NULL,
        a_Nombre,
        a_Poblacion,
        0, 0, NULL
    );

    SELECT LAST_INSERT_ID() INTO RegionGeografica_P;
    SELECT InsertarTiendasConsumidores(RegionGeografica_P, 0, 0) INTO Resultado;
    
    RETURN RegionGeografica_P;
END$$

/*
*************************************************************
*				              InsertarContinente				            *
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarContinente`;
SELECT 'InsertarContinente';

DELIMITER $$

CREATE FUNCTION `InsertarContinente` (a_Creador INT, a_Nombre VARCHAR(45), a_Poblacion INT UNSIGNED)
RETURNS INT NOT DETERMINISTIC
BEGIN
    DECLARE C, RegionGeografica_P INT;

    DECLARE EXIT HANDLER FOR 1452
    BEGIN
        SET @MensajeDeError = 'Error de clave externa en InsertarContinente()';
        SET @CodigoDeError = 1452;
        RETURN -1452;
    END; 

    /* Comprobamos que no haya otro continente en el mundo con el mismo nombre */
    SELECT COUNT(*) FROM continente, region_geografica
    WHERE nombre = a_Nombre AND region_geografica_id = continente.region_geografica_p
    INTO C;

    IF C = 0 THEN
        SELECT InsertarRegionGeografica(a_Creador, a_Nombre, a_Poblacion) INTO RegionGeografica_P;
        INSERT INTO continente VALUES(RegionGeografica_P, NULL);
        RETURN LAST_INSERT_ID();
    ELSE
        RETURN FALSE;
    END IF;
END$$

/*
*************************************************************
*			               InsertarSubcontinente				          *
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarSubcontinente`;
SELECT 'InsertarSubcontinente';

DELIMITER $$

CREATE FUNCTION `InsertarSubcontinente` (a_Creador INT, a_Nombre VARCHAR(45), a_Poblacion INT UNSIGNED, a_Continente INT)
RETURNS INT NOT DETERMINISTIC
BEGIN
    DECLARE C, RegionGeografica_P INT;

    DECLARE EXIT HANDLER FOR 1452
    BEGIN
        SET @MensajeDeError = 'Error de clave externa en InsertarSubcontinente()';
        SET @CodigoDeError = 1452;
        RETURN -1452;
    END; 

    DECLARE EXIT HANDLER FOR 1048
    BEGIN
        SET @MensajeDeError = 'Error de valor nulo en InsertarSubcontinente()';
        SET @CodigoDeError = 1048;
        RETURN -1048;
    END;

    /* Comprobamos que no haya otro subcontinente en el continente con el mismo nombre */
    SELECT COUNT(*) FROM subcontinente, region_geografica
    WHERE nombre = a_Nombre AND continente = a_Continente
    INTO C;

    IF C = 0 THEN
        SELECT InsertarRegionGeografica(a_Creador, a_Nombre, a_Poblacion) INTO RegionGeografica_P;
        INSERT INTO subcontinente VALUES(RegionGeografica_P, NULL, a_Continente);
        RETURN LAST_INSERT_ID();
    ELSE
        RETURN FALSE;
    END IF;
END$$

/*
*************************************************************
*				                 InsertarPais					              *
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarPais`;
SELECT 'InsertarPais';

DELIMITER $$

CREATE FUNCTION `InsertarPais` (a_Creador INT, a_Nombre VARCHAR(45), a_Poblacion INT UNSIGNED, a_Continente INT, a_Capital INT, 
					a_Idioma CHAR(10), a_MonedaLocal VARCHAR(45), a_MonedaLocal_Dolar DECIMAL(10,2),
					a_PIB DECIMAL(15,0))
RETURNS INT NOT DETERMINISTIC
BEGIN
    DECLARE C, RegionGeografica_P INT;

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
    SELECT COUNT(*) FROM pais, region_geografica
    WHERE nombre = a_Nombre AND region_geografica_id = pais.region_geografica_p
    INTO C;

    IF C = 0 THEN
        SELECT InsertarRegionGeografica(a_Creador, a_Nombre, a_Poblacion) INTO RegionGeografica_P;
	
        INSERT INTO pais VALUES (
            RegionGeografica_P, 
            NULL,
            a_Continente,
            a_Capital,
            a_Idioma,
            a_MonedaLocal,
            a_MonedaLocal_Dolar,
            a_PIB
        );
        RETURN LAST_INSERT_ID();
    ELSE    
        RETURN FALSE;
    END IF;
END$$

/*
*************************************************************
*			             InsertarPaisSubcontinente				        *
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarPaisSubcontinente`;
SELECT 'InsertarPaisSubcontinente';

DELIMITER $$

CREATE FUNCTION `InsertarPaisSubcontinente` (a_PaisID INT, a_SubcontinenteID INT)
RETURNS INT NOT DETERMINISTIC
BEGIN   
    DECLARE EXIT HANDLER FOR 1452
    BEGIN
        SET @MensajeDeError = 'Error de clave externa en InsertarPaisSubcontinente()';
        SET @CodigoDeError = 1452;
        RETURN -1452;
    END; 

    DECLARE EXIT HANDLER FOR 1048
    BEGIN
        SET @MensajeDeError = 'Error de valor nulo en InsertarPaisSubcontinente()';
        SET @CodigoDeError = 1048;
        RETURN -1048;
    END;

    DECLARE EXIT HANDLER FOR 1062
    BEGIN
        SET @MensajeDeError = 'Error de valor duplicado en InsertarPaisSubcontinente()';
        SET @CodigoDeError = 1062;
        RETURN -1062;
    END; 
        
    INSERT INTO pais_subcontinente VALUES (
        a_PaisID,
        a_SubcontinenteID
    );
	
    RETURN TRUE;
END$$

/*
*************************************************************
*                      InsertarEstado					              *
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarEstado`;
SELECT 'InsertarEstado';

DELIMITER $$

CREATE FUNCTION `InsertarEstado` (a_Creador INT, a_Nombre VARCHAR(45), a_Poblacion INT UNSIGNED, a_Pais INT, a_HusoHorarioNormal TIME,
					a_HusoHorarioVerano TIME)
RETURNS INT NOT DETERMINISTIC
BEGIN
    DECLARE C, RegionGeografica_P INT;

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
    SELECT COUNT(*) FROM estado, region_geografica
    WHERE nombre = a_Nombre AND pais = a_Pais
    INTO C;

    IF C = 0 THEN
        SELECT InsertarRegionGeografica(a_Creador, a_Nombre, a_Poblacion) INTO RegionGeografica_P;

        INSERT INTO estado VALUES (
            RegionGeografica_P, 
            NULL,
            a_Pais,
            a_HusoHorarioNormal,
            a_HusoHorarioVerano
        );
        RETURN LAST_INSERT_ID();
    ELSE
        RETURN FALSE;
    END IF;
END$$

/*
*************************************************************
*				               InsertarCiudad					              *
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarCiudad`;
SELECT 'InsertarCiudad';

DELIMITER $$

CREATE FUNCTION `InsertarCiudad` (a_Creador INT, a_Nombre VARCHAR(45), a_Poblacion INT UNSIGNED)
RETURNS INT NOT DETERMINISTIC
BEGIN
    DECLARE RegionGeografica_P INT;
        
    DECLARE EXIT HANDLER FOR 1452
    BEGIN
        SET @MensajeDeError = 'Error de clave externa en InsertarCiudad()';
        SET @CodigoDeError = 1452;
        RETURN -1452;
    END; 

    DECLARE EXIT HANDLER FOR 1048
    BEGIN
        SET @MensajeDeError = 'Error de valor nulo en InsertarCiudad()';
        SET @CodigoDeError = 1048;
        RETURN -1048;
    END;

    SELECT InsertarRegionGeografica(a_Creador, a_Nombre, a_Poblacion) INTO RegionGeografica_P;
    
    INSERT INTO ciudad VALUES (
        RegionGeografica_P, 
        NULL
    );
    
    RETURN LAST_INSERT_ID();
END$$

/*
*************************************************************
*                     InsertarMunicipio				              *
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarMunicipio`;
SELECT 'InsertarMunicipio';

DELIMITER $$

CREATE FUNCTION `InsertarMunicipio` (a_Creador INT, a_Nombre VARCHAR(45), a_Poblacion INT UNSIGNED, a_Estado INT, a_Ciudad INT)
RETURNS INT NOT DETERMINISTIC
BEGIN
    DECLARE C, RegionGeografica_P INT;

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
    SELECT COUNT(*) FROM municipio, region_geografica
    WHERE nombre = a_Nombre AND estado = a_Estado
    INTO C;

    IF C = 0 THEN
        SELECT InsertarRegionGeografica(a_Creador, a_Nombre, a_Poblacion) INTO RegionGeografica_P;
        
        INSERT INTO municipio VALUES (
            RegionGeografica_P, 
            NULL,
            a_Estado,
            a_Ciudad
        );
    
        RETURN LAST_INSERT_ID();
    ELSE
        RETURN FALSE;
    END IF;
END$$

/*
*************************************************************
*                     InsertarParroquia				              *
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarParroquia`;
SELECT 'InsertarParroquia';

DELIMITER $$

CREATE FUNCTION `InsertarParroquia` (a_Creador INT, a_Nombre VARCHAR(45), a_Poblacion INT UNSIGNED, a_Municipio INT, a_CodigoPostal CHAR(10))
RETURNS INT NOT DETERMINISTIC
BEGIN
    DECLARE C, RegionGeografica_P INT;

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
    SELECT COUNT(*) FROM parroquia, region_geografica
    WHERE nombre = a_Nombre AND municipio = a_Municipio
    INTO C;

    IF C = 0 THEN
        SELECT InsertarRegionGeografica(a_Creador, a_Nombre, a_Poblacion) INTO RegionGeografica_P;

        INSERT INTO parroquia VALUES (
            RegionGeografica_P, 
            NULL,
            a_CodigoPostal,
            a_Municipio
        );
        
        RETURN LAST_INSERT_ID();
    ELSE
        RETURN FALSE;
    END IF;	
END$$

/***********************************************************/
DELIMITER ;
/***********************************************************/
