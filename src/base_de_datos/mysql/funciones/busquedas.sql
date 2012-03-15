SELECT 'busquedas.sql';
USE `spuria`;

/*
*************************************************************
*				                InsertarBuscable			              *
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarBuscable`;
SELECT 'InsertarBuscable';

DELIMITER $$

CREATE FUNCTION `InsertarBuscable` ()
RETURNS INT NOT DETERMINISTIC
BEGIN
    INSERT INTO buscable VALUES (NULL);
    RETURN LAST_INSERT_ID();
END$$

/*
*************************************************************
*				               InsertarBusqueda				              *
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarBusqueda`;
SELECT 'InsertarBusqueda';

DELIMITER $$

CREATE FUNCTION `InsertarBusqueda` (a_Creador INT, a_UsuarioID INT, a_Contenido TEXT)
RETURNS INT NOT DETERMINISTIC
BEGIN
    DECLARE Etiquetable_P, Rastreable_P INT;
    
    DECLARE EXIT HANDLER FOR 1452
    BEGIN
        SET @MensajeDeError = 'Error de clave externa en InsertarBusqueda()';
        SET @CodigoDeError = 1452;
        RETURN -1452;
    END; 

    DECLARE EXIT HANDLER FOR 1062
    BEGIN
        SET @MensajeDeError = 'Error de valor duplicado en InsertarBusqueda()';
        SET @CodigoDeError = 1062;
        RETURN -1062;
    END;

    DECLARE EXIT HANDLER FOR 1048
    BEGIN
        SET @MensajeDeError = 'Error de valor nulo en InsertarBusqueda()';
        SET @CodigoDeError = 1048;
        RETURN -1048;
    END; 

    SELECT InsertarRastreable(a_Creador) INTO Rastreable_P;
    SELECT InsertarEtiquetable() INTO Etiquetable_P;

    INSERT INTO busqueda VALUES (
        Rastreable_P,
        Etiquetable_P,
        NULL,
        a_UsuarioID,
        NOW(),
        a_Contenido
    );

    RETURN LAST_INSERT_ID();
END$$

/*
*************************************************************
*			            InsertarResultadoDeBusqueda		            *
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarResultadoDeBusqueda`;
SELECT 'InsertarResultadoDeBusqueda';

DELIMITER $$

CREATE FUNCTION `InsertarResultadoDeBusqueda` (a_BusquedaID INT, a_BuscableID INT, a_Relevancia FLOAT)
RETURNS INT NOT DETERMINISTIC
BEGIN
    DECLARE EXIT HANDLER FOR 1452
    BEGIN
        SET @MensajeDeError = 'Error de clave externa en InsertarResultadoDeBusqueda()';
        SET @CodigoDeError = 1452;
        RETURN -1452;
    END; 

    DECLARE EXIT HANDLER FOR 1062
    BEGIN
        SET @MensajeDeError = 'Error de valor duplicado en InsertarResultadoDeBusqueda()';
        SET @CodigoDeError = 1062;
        RETURN -1062;
    END;

    DECLARE EXIT HANDLER FOR 1048
    BEGIN
        SET @MensajeDeError = 'Error de valor nulo en InsertarResultadoDeBusqueda()';
        SET @CodigoDeError = 1048;
        RETURN -1048;
    END; 

    INSERT INTO resultado_de_busqueda VALUES (
        a_BusquedaID,
        a_BuscableID,
        FALSE, 
        a_Relevancia
    );

    RETURN TRUE;
END$$

/***********************************************************/
DELIMITER ;
/***********************************************************/
