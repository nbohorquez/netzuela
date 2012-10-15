SELECT 'registro.sql';
USE `spuria`;

/*
*************************************************************
*						InsertarRegistro					*
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarRegistro`;
SELECT 'InsertarRegistro';

DELIMITER $$

CREATE FUNCTION `InsertarRegistro` (a_ActorActivo INT, a_Accion CHAR(13), a_ActorPasivo INT, a_Columna TEXT, a_Valor TEXT)
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
        
    INSERT INTO registro VALUES (
        NULL,
        DATE_FORMAT(now_msec(), '%Y%m%d%H%i%S.%f'),
        a_ActorActivo,
		a_Accion,
        a_ActorPasivo,
        a_Columna,
        a_Valor
    );
	
    RETURN LAST_INSERT_ID();
END$$

/*
*************************************************************
*                     RegistrarEliminacion					*
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `RegistrarEliminacion`;
SELECT 'RegistrarEliminacion';

DELIMITER $$

CREATE FUNCTION `RegistrarEliminacion` (a_Rastreable INT)
RETURNS INT NOT DETERMINISTIC
BEGIN
    DECLARE actorActivo, resultado INT;

    SELECT eliminado_por FROM rastreable
    WHERE rastreable_id = a_Rastreable
    INTO actorActivo;

    SELECT InsertarRegistro (
        actorActivo,
		'Eliminar',
        a_Rastreable,
        NULL,
        NULL
    ) INTO resultado;

    RETURN resultado;
END$$

/*
*************************************************************
*                      RegistrarInsercion					*
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `RegistrarInsercion`;
SELECT 'RegistrarInsercion';

DELIMITER $$

CREATE FUNCTION `RegistrarInsercion` (a_Rastreable INT, a_Columnas TEXT, a_Valores TEXT)
RETURNS INT NOT DETERMINISTIC
BEGIN
    DECLARE ActorActivo, Resultado INT;
	
    SELECT creado_por FROM rastreable
    WHERE rastreable_id = a_Rastreable
    INTO ActorActivo;

   	SELECT InsertarRegistro (
        ActorActivo,
        'Insertar',
        a_Rastreable,
        a_Columnas,
        a_Valores
    ) INTO Resultado;

    RETURN Resultado;
END$$

/*
*************************************************************
*                   RegistrarActualizacion					*
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `RegistrarActualizacion`;
SELECT 'RegistrarActualizacion';

DELIMITER $$

CREATE FUNCTION `RegistrarActualizacion` (a_Rastreable INT, a_Columna TEXT, a_Valor TEXT)
RETURNS INT NOT DETERMINISTIC
BEGIN
    DECLARE actorActivo, resultado INT;

   	SELECT modificado_por FROM rastreable
   	WHERE rastreable_id = a_Rastreable
   	INTO actorActivo;

   	SELECT InsertarRegistro (
        actorActivo,
		'Actualizar',
        a_Rastreable,
        a_Columna,
      	a_Valor
    ) INTO resultado;

    RETURN resultado;
END$$

/***********************************************************/
DELIMITER ;
/***********************************************************/
