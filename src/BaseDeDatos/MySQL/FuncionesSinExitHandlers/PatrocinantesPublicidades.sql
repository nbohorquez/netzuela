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

CREATE FUNCTION `InsertarPatrocinante` (a_Creador INT, a_Parroquia INT, a_CorreoElectronico VARCHAR(45), 
                                        a_Contrasena VARCHAR(45), a_RIF CHAR(10), a_Categoria INT, a_Estatus CHAR(9), 
                                        a_NombreLegal VARCHAR(45), a_NombreComun VARCHAR(45), a_Telefono CHAR(12), 
                                        a_Edificio_CC CHAR(20), a_Piso CHAR(12), a_Apartamento CHAR(12), a_Local CHAR(12), 
                                        a_Casa CHAR(20), a_Calle CHAR(12), a_Sector_Urb_Barrio CHAR(20), a_PaginaWeb CHAR(40), 
                                        a_Facebook CHAR(80), a_Twitter CHAR(80))
RETURNS INT DETERMINISTIC
BEGIN
    DECLARE v_Cliente_P CHAR(10);
    
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
    ) INTO v_Cliente_P;
        
    INSERT INTO Patrocinante (
        Cliente_P
    ) VALUES (
        v_Cliente_P
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
    DECLARE v_Buscable_P, v_Describible_P, v_Rastreable_P, v_Etiquetable_P, v_Cobrable_P INT;

    SELECT InsertarBuscable() INTO v_Buscable_P;
    SELECT InsertarDescribible() INTO v_Describible_P;
    SELECT InsertarRastreable(a_Creador) INTO v_Rastreable_P;
    SELECT InsertarEtiquetable() INTO v_Etiquetable_P;
    SELECT InsertarCobrable() INTO v_Cobrable_P;

    INSERT INTO Publicidad (
        Buscable_P,
        Describible_P,
        Rastreable_P,
        Etiquetable_P,
        Cobrable_P,
        Patrocinante,
        TamanoDePoblacionObjetivo
    ) VALUES (
        v_Buscable_P,
        v_Describible_P,
        v_Rastreable_P,
        v_Etiquetable_P,
        v_Cobrable_P,
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
    INSERT INTO SexoObjetivo VALUES (
        a_PublicidadID,
        a_Sexo
    );

    RETURN TRUE;
END $$

/***********************************************************/
DELIMITER ;
/***********************************************************/