SELECT 'PatrocinantesPublicidades.sql';
USE `Spuria`;

/*
*************************************************************
*                    InsertarPatrocinante				            *
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarPatrocinante`;
SELECT 'InsertarPatrocinante';

DELIMITER $$

CREATE FUNCTION `InsertarPatrocinante` (a_Cliente_P CHAR(10))
RETURNS INT DETERMINISTIC
BEGIN
    DECLARE EXIT HANDLER FOR 1048   
    BEGIN
        SET @MensajeDeError = 'Error de valor nulo en InsertarPatrocinante()';
        SET @CodigoDeError = 1048;
        RETURN -1048;
    END; 

    DECLARE EXIT HANDLER FOR 1452
    BEGIN
        SET @MensajeDeError = 'Error de clave externa en InsertarPatrocinante()';
        SET @CodigoDeError = 1452;
        RETURN -1452;
    END;

    DECLARE EXIT HANDLER FOR 1062
    BEGIN
        SET @MensajeDeError = 'Error de valor duplicado en InsertarPatrocinante()';
        SET @CodigoDeError = 1062;
        RETURN -1062;
    END;
        
    INSERT INTO Patrocinante VALUES (
        a_Cliente_P,
        NULL
    );
	
    RETURN LAST_INSERT_ID();
END$$

/*
*************************************************************
*				               InsertarPublicidad				            *
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarPublicidad`;
SELECT 'InsertarPublicidad';

DELIMITER $$

CREATE FUNCTION `InsertarPublicidad` (a_Creador INT, a_Patrocinante INT)
RETURNS INT NOT DETERMINISTIC
BEGIN
    DECLARE Buscable_P, Describible_P, Rastreable_P, Etiquetable_P, Cobrable_P INT;

    DECLARE EXIT HANDLER FOR 1452
    BEGIN
        SET @MensajeDeError = 'Error de clave externa en InsertarPublicidad()';
        SET @CodigoDeError = 1452;
        RETURN -1452;
    END; 

    DECLARE EXIT HANDLER FOR 1048
    BEGIN
        SET @MensajeDeError = 'Error de valor nulo en InsertarPublicidad()';
        SET @CodigoDeError = 1048;
        RETURN -1048;
    END;

    SELECT InsertarBuscable() INTO Buscable_P;
    SELECT InsertarDescribible() INTO Describible_P;
    SELECT InsertarRastreable(a_Creador) INTO Rastreable_P;
    SELECT InsertarEtiquetable() INTO Etiquetable_P;
    SELECT InsertarCobrable() INTO Cobrable_P;

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
*			            InsertarConsumidorObjetivo				        *
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarConsumidorObjetivo`;
SELECT 'InsertarConsumidorObjetivo';

DELIMITER $$

CREATE FUNCTION `InsertarConsumidorObjetivo` (a_PublicidadID INT, a_ConsumidorID INT)
RETURNS INT NOT DETERMINISTIC
BEGIN
    DECLARE EXIT HANDLER FOR 1452
    BEGIN
        SET @MensajeDeError = 'Error de clave externa en InsertarConsumidorObjetivo()';
        SET @CodigoDeError = 1452;
        RETURN -1452;
    END; 

    DECLARE EXIT HANDLER FOR 1048
    BEGIN
        SET @MensajeDeError = 'Error de valor nulo en InsertarConsumidorObjetivo()';
        SET @CodigoDeError = 1048;
        RETURN -1048;
    END;

    DECLARE EXIT HANDLER FOR 1062
    BEGIN
        SET @MensajeDeError = 'Error de valor duplicado en InsertarConsumidorObjetivo()';
        SET @CodigoDeError = 1062;
        RETURN -1062;
    END; 

    INSERT INTO ConsumidorObjetivo VALUES (
        a_PublicidadID,
        a_ConsumidorID
    );
    
    RETURN TRUE;
END $$

/*
*************************************************************
*			            InsertarGrupoDeEdadObjetivo		            *
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarGrupoDeEdadObjetivo`;
SELECT 'InsertarGrupoDeEdadObjetivo';

DELIMITER $$

CREATE FUNCTION `InsertarGrupoDeEdadObjetivo` (a_PublicidadID INT, a_GrupoDeEdad CHAR(15))
RETURNS INT NOT DETERMINISTIC
BEGIN
    DECLARE EXIT HANDLER FOR 1452
    BEGIN
        SET @MensajeDeError = 'Error de clave externa en InsertarGrupoDeEdadObjetivo()';
        SET @CodigoDeError = 1452;
        RETURN -1452;
    END; 

    DECLARE EXIT HANDLER FOR 1048
    BEGIN
        SET @MensajeDeError = 'Error de valor nulo en InsertarGrupoDeEdadObjetivo()';
        SET @CodigoDeError = 1048;
        RETURN -1048;
    END;

    DECLARE EXIT HANDLER FOR 1062
    BEGIN
        SET @MensajeDeError = 'Error de valor duplicado en InsertarGrupoDeEdadObjetivo()';
        SET @CodigoDeError = 1062;
        RETURN -1062;
    END; 

    INSERT INTO GrupoDeEdadObjetivo VALUES (
        a_PublicidadID,
        a_GrupoDeEdad
    );

    RETURN TRUE;
END $$

/*
*************************************************************
*             InsertarGradoDeInstruccionObjetivo			      *
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarGradoDeInstruccionObjetivo`;
SELECT 'InsertarGradoDeInstruccionObjetivo';

DELIMITER $$

CREATE FUNCTION `InsertarGradoDeInstruccionObjetivo` (a_PublicidadID INT, a_GradoDeInstruccion CHAR(16))
RETURNS INT NOT DETERMINISTIC
BEGIN
    DECLARE EXIT HANDLER FOR 1452   	
    BEGIN
        SET @MensajeDeError = 'Error de clave externa en InsertarGradoDeInstruccionObjetivo()';
        SET @CodigoDeError = 1452;
        RETURN -1452;
    END; 

    DECLARE EXIT HANDLER FOR 1048
    BEGIN
        SET @MensajeDeError = 'Error de valor nulo en InsertarGradoDeInstruccionObjetivo()';
        SET @CodigoDeError = 1048;
        RETURN -1048;
    END;

    DECLARE EXIT HANDLER FOR 1062
    BEGIN
        SET @MensajeDeError = 'Error de valor duplicado en InsertarGradoDeInstruccionObjetivo()';
        SET @CodigoDeError = 1062;
        RETURN -1062;
    END;

    INSERT INTO GradoDeInstruccionObjetivo VALUES (
        a_PublicidadID,
        a_GradoDeInstruccion
    );

    RETURN TRUE;
END $$

/*
*************************************************************
*			         InsertarRegionGeograficaObjetivo			        *
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarRegionGeograficaObjetivo`;
SELECT 'InsertarRegionGeograficaObjetivo';

DELIMITER $$

CREATE FUNCTION `InsertarRegionGeograficaObjetivo` (a_PublicidadID INT, a_RegionGeograficaID INT)
RETURNS INT NOT DETERMINISTIC
BEGIN
    DECLARE EXIT HANDLER FOR 1452
    BEGIN
        SET @MensajeDeError = 'Error de clave externa en InsertarRegionGeograficaObjetivo()';
        SET @CodigoDeError = 1452;
        RETURN -1452;
    END; 

    DECLARE EXIT HANDLER FOR 1048
    BEGIN
        SET @MensajeDeError = 'Error de valor nulo en InsertarRegionGeograficaObjetivo()';
        SET @CodigoDeError = 1048;
        RETURN -1048;
    END;

    DECLARE EXIT HANDLER FOR 1062
    BEGIN
        SET @MensajeDeError = 'Error de valor duplicado en InsertarRegionGeograficaObjetivo()';
        SET @CodigoDeError = 1062;
        RETURN -1062;
    END; 

    INSERT INTO RegionGeograficaObjetivo VALUES (
        a_PublicidadID,
        a_RegionGeograficaID
    );

    RETURN TRUE;
END $$

/*
*************************************************************
*				            InsertarSexoObjetivo				            *
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarSexoObjetivo`;
SELECT 'InsertarSexoObjetivo';

DELIMITER $$

CREATE FUNCTION `InsertarSexoObjetivo` (a_PublicidadID INT, a_Sexo CHAR(6))
RETURNS INT NOT DETERMINISTIC
BEGIN
    DECLARE EXIT HANDLER FOR 1452
    BEGIN
        SET @MensajeDeError = 'Error de clave externa en InsertarSexoObjetivo()';
        SET @CodigoDeError = 1452;
        RETURN -1452;
    END; 

    DECLARE EXIT HANDLER FOR 1048
    BEGIN
        SET @MensajeDeError = 'Error de valor nulo en InsertarSexoObjetivo()';
        SET @CodigoDeError = 1048;
        RETURN -1048;
    END;

    DECLARE EXIT HANDLER FOR 1062
    BEGIN
        SET @MensajeDeError = 'Error de valor duplicado en InsertarSexoObjetivo()';
        SET @CodigoDeError = 1062;
        RETURN -1062;
    END; 

    INSERT INTO SexoObjetivo VALUES (
        a_PublicidadID,
        a_Sexo
    );

    RETURN TRUE;
END $$

/***********************************************************/
DELIMITER ;
/***********************************************************/