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
    INSERT INTO Registro (
        FechaHora,
        ActorActivo,
        ActorPasivo,
        Accion,
        Parametros,
        CodigoDeError
    ) VALUES (
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
    DECLARE Accion, Error CHAR(40);

    SELECT EliminadoPor FROM Rastreable
    WHERE RastreableID = a_Rastreable
    INTO ActorActivo;
    
    SELECT 'Eliminar' INTO Accion;
    SELECT 'OK' INTO Error;

    SELECT InsertarRegistro (
        ActorActivo,    
        a_Rastreable,
        Accion,
        a_Parametros,
        Error
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
    DECLARE Accion, Error CHAR(40);

   	SELECT CreadoPor FROM Rastreable
   	WHERE RastreableID = a_Rastreable
    INTO ActorActivo;
    
    SELECT 'Crear' INTO Accion;
    SELECT 'OK' INTO Error;

   	SELECT InsertarRegistro (
        ActorActivo,
        a_Rastreable,
        Accion,
        a_Parametros,
        Error
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
    DECLARE Accion, Error CHAR(40);

   	SELECT ModificadoPor FROM Rastreable
   	WHERE RastreableID = a_Rastreable
   	INTO ActorActivo;
    
    SELECT 'Actualizar' INTO Accion;
    SELECT 'OK' INTO Error;

   	SELECT InsertarRegistro (
        ActorActivo,
        a_Rastreable,
        Accion,
        a_Parametros,
      	Error
    ) INTO Resultado;

    RETURN Resultado;
END$$

/***********************************************************/
DELIMITER ;
/***********************************************************/