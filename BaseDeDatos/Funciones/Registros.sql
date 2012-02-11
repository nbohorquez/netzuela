SELECT 'Registro.sql';
USE `Spuria`;

/*
*************************************************************
*				               InsertarRegistro			  	            *
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarRegistro`;
SELECT 'InsertarRegistro';

DELIMITER $$

CREATE FUNCTION `InsertarRegistro` (a_ActorActivo INT, a_ActorPasivo INT, a_Accion CHAR(13), a_Parametros TEXT, a_CodigoDeError CHAR(10))
RETURNS INT NOT DETERMINISTIC
BEGIN
    DECLARE EXIT HANDLER FOR 1452   
    BEGIN
        SET @MensajeDeError = 'Error de clave externa en InsertarRegistro()';
        SET @CodigoDeError = 1452;
        RETURN -1452;
    END; 

    DECLARE EXIT HANDLER FOR 1048
    BEGIN
        SET @MensajeDeError = 'Error de valor nulo en InsertarRegistro()';
        SET @CodigoDeError = 1048;
        RETURN -1048;
    END; 
        
    INSERT INTO Registro VALUES (
        NULL,
        NOW(),
        a_ActorActivo,
        a_ActorPasivo,
        a_Accion,
        a_Parametros,
        a_CodigoDeError
    );
	
    RETURN LAST_INSERT_ID();
END$$

/*
*************************************************************
*                     RegistrarEliminacion				          *
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `RegistrarEliminacion`;
SELECT 'RegistrarEliminacion';

DELIMITER $$

CREATE FUNCTION `RegistrarEliminacion` (a_Rastreable INT, a_Parametros TEXT)
RETURNS INT NOT DETERMINISTIC
BEGIN
    DECLARE ActorActivo, Resultado INT;

    SELECT EliminadoPor FROM Rastreable
    WHERE RastreableID = a_Rastreable
    INTO ActorActivo;

    SELECT InsertarRegistro (
        ActorActivo,    
        a_Rastreable,
        'Eliminar',
        a_Parametros,
        'OK'
    ) INTO Resultado;

    RETURN Resultado;
END$$

/*
*************************************************************
*                      RegistrarCreacion				            *
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `RegistrarCreacion`;
SELECT 'RegistrarCreacion';

DELIMITER $$

CREATE FUNCTION `RegistrarCreacion` (a_Rastreable INT, a_Parametros TEXT)
RETURNS INT NOT DETERMINISTIC
BEGIN
    DECLARE ActorActivo, Resultado INT;

   	SELECT CreadoPor FROM Rastreable
   	WHERE RastreableID = a_Rastreable
    INTO ActorActivo;

   	SELECT InsertarRegistro (
        ActorActivo,
        a_Rastreable,
        'Crear',
        a_Parametros,
        'OK'
    ) INTO Resultado;

    RETURN Resultado;
END$$

/*
*************************************************************
*                   RegistrarModificacion				            *
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `RegistrarModificacion`;
SELECT 'RegistrarModificacion';

DELIMITER $$

CREATE FUNCTION `RegistrarModificacion` (a_Rastreable INT, a_Parametros TEXT)
RETURNS INT NOT DETERMINISTIC
BEGIN
    DECLARE ActorActivo, Resultado INT;

   	SELECT ModificadoPor FROM Rastreable
   	WHERE RastreableID = a_Rastreable
   	INTO ActorActivo;

   	SELECT InsertarRegistro (
        ActorActivo,
        a_Rastreable,
        'Actualizar',
        a_Parametros,
      	'OK'
    ) INTO Resultado;

    RETURN Resultado;
END$$

/***********************************************************/
DELIMITER ;
/***********************************************************/