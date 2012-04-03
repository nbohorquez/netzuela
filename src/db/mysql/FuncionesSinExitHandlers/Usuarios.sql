SELECT 'Usuarios.sql';
USE `Spuria`;

/*
*************************************************************
*                      InsertarUsuario				              *
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarUsuario`;
SELECT 'InsertarUsuario';

DELIMITER $$

CREATE FUNCTION `InsertarUsuario` (a_Parroquia INT, a_CorreoElectronico VARCHAR(45), a_Contrasena VARCHAR(45))
RETURNS INT NOT DETERMINISTIC
BEGIN
    DECLARE AccesoID INT;

    INSERT INTO Usuario (
        Parroquia
    ) VALUES (    
        a_Parroquia
    );

    SELECT LAST_INSERT_ID() INTO AccesoID; 

    INSERT INTO Acceso VALUES (
        AccesoID,
        FALSE,
        a_CorreoElectronico,
        a_Contrasena,
        NOW(),
        NULL,
        MAKETIME(0,0,0),
        0, MAKETIME(0,0,0), MAKETIME(0,0,0)
    );

    RETURN AccesoID;
END$$

/*
*************************************************************
*                    InsertarAdministrador			            *
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarAdministrador`;
SELECT 'InsertarAdministrador';

DELIMITER $$

CREATE FUNCTION `InsertarAdministrador` (a_Creador INT, a_Parroquia INT, a_CorreoElectronico VARCHAR(45), 
                                         a_Contrasena VARCHAR(45), a_Estatus CHAR(9), a_Privilegios VARCHAR(45), 
                                         a_Nombre VARCHAR(45), a_Apellido VARCHAR(45))
RETURNS INT NOT DETERMINISTIC
BEGIN
    DECLARE v_Rastreable_P, v_Usuario_P, AdministradorID INT;
    
    SELECT InsertarUsuario (
        a_Parroquia, 
        a_CorreoElectronico, a_Contrasena
    ) INTO v_Usuario_P;

    SELECT InsertarRastreable(a_Creador) INTO v_Rastreable_P;

    INSERT INTO Administrador (
        Rastreable_P,
        Usuario_P,
        Estatus,
        Privilegios,
        Nombre,
        Apellido
  ) VALUES (
        v_Rastreable_P,
        v_Usuario_P,
        a_Estatus,
        a_Privilegios,
        a_Nombre,
        a_Apellido
    );
    
    RETURN LAST_INSERT_ID();
END$$

/*
*************************************************************
*                      InsertarCliente				              *
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarCliente`;
SELECT 'InsertarCliente';

DELIMITER $$

CREATE FUNCTION `InsertarCliente` (a_Creador INT, a_Parroquia INT, a_CorreoElectronico VARCHAR(45), 
                                   a_Contrasena VARCHAR(45), a_RIF CHAR(10), a_Categoria INT, a_Estatus CHAR(9), 
                                   a_NombreLegal VARCHAR(45), a_NombreComun VARCHAR(45), a_Telefono CHAR(12), 
                                   a_Edificio_CC CHAR(20), a_Piso CHAR(12), a_Apartamento CHAR(12), a_Local CHAR(12), 
                                   a_Casa CHAR(20), a_Calle CHAR(12), a_Sector_Urb_Barrio CHAR(20), a_PaginaWeb CHAR(40), 
                                   a_Facebook CHAR(80), a_Twitter CHAR(80))
RETURNS CHAR(10) NOT DETERMINISTIC
BEGIN
    DECLARE v_Rastreable_P, v_Describible_P, v_Usuario_P INT;

    SELECT InsertarUsuario (
        a_Parroquia, 
        a_CorreoElectronico, 
        a_Contrasena
    ) INTO v_Usuario_P;
    
    SELECT InsertarRastreable(a_Creador) INTO v_Rastreable_P;
    SELECT InsertarDescribible() INTO v_Describible_P;
        
    INSERT INTO Cliente VALUES (
        v_Rastreable_P,
        v_Describible_P,
        v_Usuario_P,
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
    );  
        
    RETURN a_RIF;
END$$

/***********************************************************/
DELIMITER ;
/***********************************************************/