SELECT 'Consumidores.sql';
USE `Spuria`;

/*
*************************************************************
*				               InsertarSeguidor			                *
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarSeguidor`;
SELECT 'InsertarSeguidor';

DELIMITER $$

CREATE FUNCTION `InsertarSeguidor` (a_Creador INT, a_CalificableSeguibleID INT, a_ConsumidorID INT, a_AvisarSi CHAR(40))
RETURNS INT NOT DETERMINISTIC
BEGIN
    DECLARE v_Rastreable_P INT;

    SELECT InsertarRastreable(a_Creador) INTO v_Rastreable_P;

    INSERT INTO Seguidor VALUES (
        v_Rastreable_P,
        a_ConsumidorID,
        a_CalificableSeguibleID,
        a_AvisarSi
    );

    RETURN TRUE;
END$$

/*
*************************************************************
*                    InsertarConsumidor				              *
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarConsumidor`;
SELECT 'InsertarConsumidor';

DELIMITER $$

CREATE FUNCTION `InsertarConsumidor` (a_Creador INT, a_Nombre VARCHAR(45), a_Apellido VARCHAR(45), 
                                      a_Estatus CHAR(9), a_Sexo CHAR(6), a_FechaDeNacimiento DATE, 
                                      a_GrupoDeEdad CHAR(15), a_GradoDeInstruccion CHAR(16), a_Parroquia INT, 
                                      a_CorreoElectronico VARCHAR(45), a_Contrasena VARCHAR(45))
RETURNS INT NOT DETERMINISTIC
BEGIN
    DECLARE v_Rastreable_P, v_Interlocutor_P, v_UsuarioID INT;
        
    SELECT InsertarUsuario (
        a_Parroquia, 
        a_CorreoElectronico, 
        a_Contrasena
    ) INTO v_UsuarioID;

    SELECT InsertarRastreable(a_Creador) INTO v_Rastreable_P;    
    SELECT InsertarInterlocutor() INTO v_Interlocutor_P;

    INSERT INTO Consumidor (
        Rastreable_P, 
        Interlocutor_P, 
        Usuario_P, 
        Nombre, 
        Apellido, 
        Estatus, 
        Sexo, 
        FechaDeNacimiento, 
        GrupoDeEdad, 
        GradoDeInstruccion
    ) VALUES (
        v_Rastreable_P,
        v_Interlocutor_P,
        v_UsuarioID,
        a_Nombre,
        a_Apellido,
        a_Estatus,
        a_Sexo,
        a_FechaDeNacimiento,
        a_GrupoDeEdad,
        a_GradoDeInstruccion
    );

    RETURN LAST_INSERT_ID();
END$$

/***********************************************************/
DELIMITER ;
/***********************************************************/