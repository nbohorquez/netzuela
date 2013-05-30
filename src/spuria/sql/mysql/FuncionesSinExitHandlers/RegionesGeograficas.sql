SELECT 'RegionesGeograficas.sql';
USE `Spuria`;

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

    SELECT COUNT(*) FROM TiendasConsumidores
    WHERE RegionGeograficaID = a_RegionGeograficaID
    INTO C;

    IF C > 0 THEN /* Hay ya por lo menos un valor historico almacenado; hay que sustituirlo */
        UPDATE TiendasConsumidores
        SET FechaFin = NOW() 
        WHERE RegionGeograficaID = a_RegionGeograficaID AND FechaFin IS NULL;
    END IF;

    INSERT INTO TiendasConsumidores VALUES (
        a_RegionGeograficaID,
        NOW(),
        NULL,
        a_NumeroDeConsumidores,
        a_NumeroDeTiendas
    );

    SELECT Poblacion FROM RegionGeografica 
    WHERE RegionGeograficaID = a_RegionGeograficaID INTO Pob;

    UPDATE RegionGeografica 
    SET Consumidores_Poblacion = IF(Pob > 0, a_NumeroDeConsumidores/Pob, 0), Tiendas_Poblacion = IF(Pob > 0, a_NumeroDeTiendas/Pob, 0)
    WHERE RegionGeograficaID = a_RegionGeograficaID;
        
    UPDATE RegionGeografica 
    SET Tiendas_Consumidores = IF(a_NumeroDeConsumidores > 0, a_NumeroDeTiendas/a_NumeroDeConsumidores, NULL)
    WHERE RegionGeograficaID = a_RegionGeograficaID;

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
    DECLARE v_RegionGeografica_P, v_Dibujable_P, v_Rastreable_P, Resultado INT;

    SELECT InsertarDibujable() INTO v_Dibujable_P;
    SELECT InsertarRastreable(a_Creador) INTO v_Rastreable_P;
	
    INSERT INTO RegionGeografica (
        Rastreable_P,
        Dibujable_P,
        Nombre,
        Poblacion,
        Consumidores_Poblacion,
        Tiendas_Poblacion,
        Tiendas_Consumidores
    ) VALUES (
        v_Rastreable_P,
        v_Dibujable_P,
        a_Nombre,
        a_Poblacion,
        0, 0, NULL
    );

    SELECT LAST_INSERT_ID() INTO v_RegionGeografica_P;
    SELECT InsertarTiendasConsumidores(v_RegionGeografica_P, 0, 0) INTO Resultado;
    
    RETURN v_RegionGeografica_P;
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
    DECLARE C, v_RegionGeografica_P INT;

    /* Comprobamos que no haya otro continente en el mundo con el mismo nombre */
    SELECT COUNT(*) FROM Continente, RegionGeografica
    WHERE Nombre = a_Nombre AND RegionGeograficaID = Continente.RegionGeografica_P
    INTO C;

    IF C = 0 THEN
        SELECT InsertarRegionGeografica(a_Creador, a_Nombre, a_Poblacion) INTO v_RegionGeografica_P;
        
        INSERT INTO Continente (
            RegionGeografica_P
        ) VALUES (
            v_RegionGeografica_P
        );
        
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
    DECLARE C, v_RegionGeografica_P INT;

    /* Comprobamos que no haya otro subcontinente en el continente con el mismo nombre */
    SELECT COUNT(*) FROM Subcontinente, RegionGeografica
    WHERE Nombre = a_Nombre AND Continente = a_Continente
    INTO C;

    IF C = 0 THEN
        SELECT InsertarRegionGeografica(a_Creador, a_Nombre, a_Poblacion) INTO v_RegionGeografica_P;
        
        INSERT INTO Subcontinente (
            RegionGeografica_P,
            Continente
        ) VALUES (
            v_RegionGeografica_P, 
            a_Continente
        );
        
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

CREATE FUNCTION `InsertarPais` (a_Creador INT, a_Nombre VARCHAR(45), a_Poblacion INT UNSIGNED, a_Continente INT, 
                                a_Capital INT, a_Idioma CHAR(10), a_MonedaLocal VARCHAR(45), a_MonedaLocal_Dolar DECIMAL(10,2),
                                a_PIB DECIMAL(15,0))
RETURNS INT NOT DETERMINISTIC
BEGIN
    DECLARE C, v_RegionGeografica_P INT;

    /* Comprobamos que no haya otro pais en el mundo con el mismo nombre */
    SELECT COUNT(*) FROM Pais, RegionGeografica
    WHERE Nombre = a_Nombre AND RegionGeograficaID = Pais.RegionGeografica_P
    INTO C;

    IF C = 0 THEN
        SELECT InsertarRegionGeografica(a_Creador, a_Nombre, a_Poblacion) INTO v_RegionGeografica_P;
	
        INSERT INTO Pais (
            RegionGeografica_P,
            Continente,
            Capital,
            Idioma,
            MonedaLocal,
            MonedaLocal_Dolar,
            PIB
        ) VALUES (
            v_RegionGeografica_P,
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
    INSERT INTO PaisSubcontinente VALUES (
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
    DECLARE C, v_RegionGeografica_P INT;

    /* Comprobamos que no haya otro estado hermano con el mismo nombre */
    SELECT COUNT(*) FROM Estado, RegionGeografica
    WHERE Nombre = a_Nombre AND Pais = a_Pais
    INTO C;

    IF C = 0 THEN
        SELECT InsertarRegionGeografica(a_Creador, a_Nombre, a_Poblacion) INTO v_RegionGeografica_P;

        INSERT INTO Estado (
            RegionGeografica_P,
            Pais,
            HusoHorarioNormal,
            HusoHorarioVerano
        ) VALUES (
            v_RegionGeografica_P,
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
    DECLARE v_RegionGeografica_P INT;
        
    SELECT InsertarRegionGeografica(a_Creador, a_Nombre, a_Poblacion) INTO v_RegionGeografica_P;
    
    INSERT INTO Ciudad (
        RegionGeografica_P
    ) VALUES (
        v_RegionGeografica_P
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
    DECLARE C, v_RegionGeografica_P INT;

  	/* Comprobamos que no haya otro municipio hermano con el mismo nombre */    	
    SELECT COUNT(*) FROM Municipio, RegionGeografica
    WHERE Nombre = a_Nombre AND Estado = a_Estado
    INTO C;

    IF C = 0 THEN
        SELECT InsertarRegionGeografica(a_Creador, a_Nombre, a_Poblacion) INTO v_RegionGeografica_P;
        
        INSERT INTO Municipio (
            RegionGeografica_P,
            Estado,
            Ciudad
        ) VALUES (
            v_RegionGeografica_P,
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
    DECLARE C, v_RegionGeografica_P INT;

    /* Comprobamos que no haya otra parroquia hermana con el mismo nombre */    
    SELECT COUNT(*) FROM Parroquia, RegionGeografica
    WHERE Nombre = a_Nombre AND Municipio = a_Municipio
    INTO C;

    IF C = 0 THEN
        SELECT InsertarRegionGeografica(a_Creador, a_Nombre, a_Poblacion) INTO v_RegionGeografica_P;

        INSERT INTO Parroquia (
            RegionGeografica_P,
            CodigoPostal,
            Municipio
        ) VALUES (
            v_RegionGeografica_P,
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