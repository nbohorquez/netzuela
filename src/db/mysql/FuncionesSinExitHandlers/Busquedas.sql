SELECT 'Busquedas.sql';
USE `Spuria`;

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
    INSERT INTO Buscable VALUES ();
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
    DECLARE v_Etiquetable_P, v_Rastreable_P INT;
    
    SELECT InsertarRastreable(a_Creador) INTO v_Rastreable_P;
    SELECT InsertarEtiquetable() INTO v_Etiquetable_P;

    INSERT INTO Busqueda (
        Rastreable_P, 
        Etiquetable_P, 
        Usuario, 
        FechaHora, 
        Contenido
    ) VALUES (
        v_Rastreable_P,
        v_Etiquetable_P,
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
    INSERT INTO ResultadoDeBusqueda VALUES (
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