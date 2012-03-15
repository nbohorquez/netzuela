SELECT 'patrocinantes_publicidades.sql';
USE `spuria`;

/*
*************************************************************
*                    InsertarPatrocinante				            *
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarPatrocinante`;
SELECT 'InsertarPatrocinante';

DELIMITER $$

CREATE FUNCTION `InsertarPatrocinante` (a_Creador INT, a_Parroquia INT, a_CorreoElectronico VARCHAR(45), 
                                        a_Contrasena VARCHAR(45), a_RIF CHAR(10), a_Categoria INT, a_Estatus CHAR(9), 
                                        a_NombreLegal VARCHAR(45), a_NombreComun VARCHAR(45), a_Telefono CHAR(12), 
                                        a_Edificio_CC CHAR(20), a_Piso CHAR(12), a_Apartamento CHAR(12), a_Local CHAR(12), 
                                        a_Casa CHAR(20), a_Calle CHAR(12), a_Sector_Urb_Barrio CHAR(20), a_PaginaWeb CHAR(40), 
                                        a_Facebook CHAR(80), a_Twitter CHAR(80))
RETURNS INT DETERMINISTIC
BEGIN
    DECLARE Cliente_P CHAR(10);
    
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
    
    SELECT InsertarCliente (
        a_Creador, 
        a_Parroquia, 
        a_CorreoElectronico, 
        a_Contrasena, 
        a_RIF, 
        a_Categoria, 
        a_Estatus, 
        a_NombreLegal, 
        a_NombreComun, 
        a_Telefono, 
        a_Edificio_CC, 
        a_Piso, 
        a_Apartamento, 
        a_Local, 
        a_Casa, 
        a_Calle, 
        a_Sector_Urb_Barrio, 
        a_PaginaWeb, 
        a_Facebook, 
        a_Twitter
    ) INTO Cliente_P;
        
    INSERT INTO patrocinante VALUES (
        Cliente_P,
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

    INSERT INTO publicidad VALUES (
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

    INSERT INTO consumidor_objetivo VALUES (
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

    INSERT INTO grupo_de_edad_objetivo VALUES (
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

    INSERT INTO grado_de_instruccion_objetivo VALUES (
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

    INSERT INTO region_geografica_objetivo VALUES (
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

    INSERT INTO sexo_objetivo VALUES (
        a_PublicidadID,
        a_Sexo
    );

    RETURN TRUE;
END $$

/***********************************************************/
DELIMITER ;
/***********************************************************/
