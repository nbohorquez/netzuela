USE `Spuria`;

/*
*************************************************************
*				UsuarioCrear				*
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `UsuarioCrear`;
DELIMITER $$

CREATE FUNCTION `UsuarioCrear` (a_Parroquia INT, a_CorreoElectronico VARCHAR(45), a_Contraseña VARCHAR(45))

RETURNS INT NOT DETERMINISTIC
BEGIN
	DECLARE AccesoID INT;
/*
	DECLARE EXIT HANDLER FOR 1048
	BEGIN
		SET @MensajeDeError = 'Error de valor nulo en UsuarioCrear()';
		SET @CodigoDeError = 1048;
		RETURN -1048;
	END; 

	DECLARE EXIT HANDLER FOR 1062
	BEGIN
		SET @MensajeDeError = 'Error de valor duplicado en UsuarioCrear()';
		SET @CodigoDeError = 1062;
		RETURN -1062;
	END;

	DECLARE EXIT HANDLER FOR 1452
	BEGIN
		SET @MensajeDeError = 'Error de clave externa en UsuarioCrear()';
		SET @CodigoDeError = 1452;
		RETURN -1452;
	END;
*/
	INSERT INTO Usuario VALUES (
		NULL,
		a_Parroquia
	);

	SELECT LAST_INSERT_ID() INTO AccesoID; 

	INSERT INTO Acceso VALUES (
		AccesoID,
		FALSE,
		a_CorreoElectronico,
		a_Contraseña,
		NOW(),
		NULL,
		'00:00',
		0, '00:00', '00:00'
	);

	RETURN AccesoID;
END$$

/*
*************************************************************
*				AdministradorCrear			*
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `AdministradorCrear`;
DELIMITER $$

CREATE FUNCTION `AdministradorCrear` (a_Creador INT, a_Usuario_P INT, a_Estatus CHAR(9), a_Privilegios VARCHAR(45), 
							a_Nombre VARCHAR(45), a_Apellido VARCHAR(45))

RETURNS INT NOT DETERMINISTIC
BEGIN
	DECLARE Rastreable_P INT;
/*
	DECLARE EXIT HANDLER FOR 1048
	BEGIN
		SET @MensajeDeError = 'Error de valor nulo en AdministradorCrear()';
		SET @CodigoDeError = 1048;
		RETURN -1048;
	END; 

	DECLARE EXIT HANDLER FOR 1452
	BEGIN
		SET @MensajeDeError = 'Error de clave externa en AdministradorCrear()';
		SET @CodigoDeError = 1452;
		RETURN -1452;
	END;
*/
	SELECT RastreableCrear(a_Creador) INTO Rastreable_P;

	INSERT INTO Administrador VALUES (
		Rastreable_P,
		a_Usuario_P,
		NULL,
		a_Estatus,
		a_Privilegios,
		a_Nombre,
		a_Apellido
	);
	RETURN LAST_INSERT_ID();
END$$

/*
*************************************************************
*				ConsumidorCrear				*
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `ConsumidorCrear`;
DELIMITER $$

CREATE FUNCTION `ConsumidorCrear` (a_Creador INT, a_Usuario_P INT, a_Nombre VARCHAR(45), a_Apellido VARCHAR(45), 
						a_Estatus CHAR(9), a_Sexo CHAR(6), a_FechaDeNacimiento DATE, 
						a_GrupoDeEdad CHAR(15), a_GradoDeInstruccion CHAR(16))

RETURNS INT NOT DETERMINISTIC
BEGIN
	DECLARE Rastreable_P, Interlocutor_P INT;
/*
	DECLARE EXIT HANDLER FOR 1048
	BEGIN
		SET @MensajeDeError = 'Error de valor nulo en ConsumidorCrear()';
		SET @CodigoDeError = 1048;
		RETURN -1048;
	END; 

	DECLARE EXIT HANDLER FOR 1452
	BEGIN
		SET @MensajeDeError = 'Error de clave externa en ConsumidorCrear()';
		SET @CodigoDeError = 1452;
		RETURN -1452;
	END;
*/
	SELECT RastreableCrear(a_Creador) INTO Rastreable_P;
	SELECT InterlocutorCrear() INTO Interlocutor_P;

	INSERT INTO Consumidor VALUES (
		Rastreable_P,
		Interlocutor_P,
		a_Usuario_P,
		NULL,
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

/*
*************************************************************
*				ClienteCrear				*
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `ClienteCrear`;
DELIMITER $$

CREATE FUNCTION `ClienteCrear` (a_Creador INT, a_Usuario_P INT, a_RIF CHAR(10), a_Categoria INT, a_Estatus CHAR(9), 
						a_NombreLegal VARCHAR(45), a_NombreComun VARCHAR(45), a_Telefono CHAR(12), 
						a_Edificio_CC CHAR(20), a_Piso CHAR(12), a_Apartamento CHAR(12), a_Local CHAR(12), 
						a_Casa CHAR(20), a_Calle CHAR(12), a_Sector_Urb_Barrio CHAR(20), a_PaginaWeb CHAR(40), 
						a_Facebook CHAR(80), a_Twitter CHAR(80))
RETURNS CHAR(10) NOT DETERMINISTIC
BEGIN
	DECLARE Rastreable_P, Describible_P INT;
/*
	DECLARE EXIT HANDLER FOR 1048
	BEGIN
		SET @MensajeDeError = 'Error de valor nulo en ClienteCrear()';
		SET @CodigoDeError = 1048;
		RETURN -1048;
	END; 

	DECLARE EXIT HANDLER FOR 1452
	BEGIN
		SET @MensajeDeError = 'Error de clave externa en ClienteCrear()';
		SET @CodigoDeError = 1452;
		RETURN -1452;
	END;

	DECLARE EXIT HANDLER FOR 1062
	BEGIN
		SET @MensajeDeError = 'Error de valor duplicado en ClienteCrear()';
		SET @CodigoDeError = 1062;
		RETURN -1062;
	END;
*/
	SELECT RastreableCrear(a_Creador) INTO Rastreable_P;
	SELECT DescribibleCrear() INTO Describible_P;

	INSERT INTO Cliente VALUES (
		Rastreable_P,
		Describible_P,
		a_Usuario_P,
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

/*
*************************************************************
*				TiendaCrear					*
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `TiendaCrear`;
DELIMITER $$

CREATE FUNCTION `TiendaCrear` (a_Cliente_P CHAR(10))

RETURNS INT NOT DETERMINISTIC
BEGIN
	DECLARE Buscable_P, CalificableSeguible_P, Interlocutor_P, Dibujable_P, Resultado, T INT;
/*
	DECLARE EXIT HANDLER FOR 1048
	BEGIN
		SET @MensajeDeError = 'Error de valor nulo en TiendaCrear()';
		SET @CodigoDeError = 1048;
		RETURN -1048;
	END; 

	DECLARE EXIT HANDLER FOR 1452
	BEGIN
		SET @MensajeDeError = 'Error de clave externa en TiendaCrear()';
		SET @CodigoDeError = 1452;
		RETURN -1452;
	END;

	DECLARE EXIT HANDLER FOR 1062
	BEGIN
		SET @MensajeDeError = 'Error de valor duplicado en TiendaCrear()';
		SET @CodigoDeError = 1062;
		RETURN -1062;
	END;
*/
	SELECT BuscableCrear() INTO Buscable_P;
	SELECT CalificableSeguibleCrear() INTO CalificableSeguible_P;
	SELECT InterlocutorCrear() INTO Interlocutor_P;
	SELECT DibujableCrear() INTO Dibujable_P;

	INSERT INTO Tienda VALUES (
		Buscable_P,
		a_Cliente_P,
		CalificableSeguible_P,
		Interlocutor_P,
		Dibujable_P,
		NULL,
		FALSE
	);

	SELECT LAST_INSERT_ID() INTO T;
	SELECT TamanoCrear(T, 0, 0, 0) INTO Resultado;

	RETURN T;
END$$

/*
*************************************************************
*			HorarioDeTrabajoCrear				*
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `HorarioDeTrabajoCrear`;
DELIMITER $$

CREATE FUNCTION `HorarioDeTrabajoCrear` (a_TiendaID INT, a_Dia CHAR(9), a_Laborable BOOLEAN)

RETURNS INT NOT DETERMINISTIC
BEGIN
/*
	DECLARE EXIT HANDLER FOR 1048
	BEGIN
		SET @MensajeDeError = 'Error de valor nulo en HorarioDeTrabajoCrear()';
		SET @CodigoDeError = 1048;
		RETURN -1048;
	END; 

	DECLARE EXIT HANDLER FOR 1452
	BEGIN
		SET @MensajeDeError = 'Error de clave externa en HorarioDeTrabajoCrear()';
		SET @CodigoDeError = 1452;
		RETURN -1452;
	END;

	DECLARE EXIT HANDLER FOR 1062
	BEGIN
		SET @MensajeDeError = 'Error de valor duplicado en HorarioDeTrabajoCrear()';
		SET @CodigoDeError = 1062;
		RETURN -1062;
	END;
*/
	INSERT INTO HorarioDeTrabajo VALUES (
		a_TiendaID,
		a_Dia,
		a_Laborable
	);

	RETURN TRUE;
END$$

/*
*************************************************************
*				TurnoCrear					*
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `TurnoCrear`;
DELIMITER $$

CREATE FUNCTION `TurnoCrear` (a_TiendaID INT, a_Dia CHAR(9), a_HoraDeApertura TIME, a_HoraDeCierre TIME)

RETURNS INT NOT DETERMINISTIC
BEGIN
/*
	DECLARE EXIT HANDLER FOR 1048
	BEGIN
		SET @MensajeDeError = 'Error de valor nulo en TurnoCrear()';
		SET @CodigoDeError = 1048;
		RETURN -1048;
	END; 

	DECLARE EXIT HANDLER FOR 1452
	BEGIN
		SET @MensajeDeError = 'Error de clave externa en TurnoCrear()';
		SET @CodigoDeError = 1452;
		RETURN -1452;
	END;

	DECLARE EXIT HANDLER FOR 1062
	BEGIN
		SET @MensajeDeError = 'Error de valor duplicado en TurnoCrear()';
		SET @CodigoDeError = 1062;
		RETURN -1062;
	END;
*/
	INSERT INTO Turno VALUES (
		a_TiendaID,
		a_Dia,
		a_HoraDeApertura,
		a_HoraDeCierre
	);

	RETURN TRUE;
END$$

/*
*************************************************************
*				TamanoCrear					*
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `TamanoCrear`;
DELIMITER $$

CREATE FUNCTION `TamanoCrear` (a_TiendaID INT, a_NumeroTotalDeProductos INT, a_CantidadTotalDeProductos INT, a_Tamano INT)

RETURNS INT NOT DETERMINISTIC
BEGIN
	DECLARE C INT;
/*
	DECLARE EXIT HANDLER FOR 1048
	BEGIN
		SET @MensajeDeError = 'Error de valor nulo en TamanoCrear()';
		SET @CodigoDeError = 1048;
		RETURN -1048;
	END; 

	DECLARE EXIT HANDLER FOR 1452
	BEGIN
		SET @MensajeDeError = 'Error de clave externa en TamanoCrear()';
		SET @CodigoDeError = 1452;
		RETURN -1452;
	END;

	DECLARE EXIT HANDLER FOR 1062
	BEGIN
		SET @MensajeDeError = 'Error de valor duplicado en TamanoCrear()';
		SET @CodigoDeError = 1062;
		RETURN -1062;
	END;
*/
	/* Vemos si ya existe un registro "Tamano" ya asociado a la tabla */
	SELECT COUNT(*) FROM Tamano
	WHERE TiendaID = a_TiendaID
	INTO C;
		
	IF C > 0 THEN
		UPDATE Tamano
     		SET FechaFin = NOW()
     		WHERE TiendaID = a_TiendaID AND FechaFin IS NULL;
	END IF;
		
	INSERT INTO Tamano VALUES (
		a_TiendaID,
		NOW(),
		NULL,
		a_NumeroTotalDeProductos,
		a_CantidadTotalDeProductos,
		a_Tamano
	);
	
	RETURN TRUE;
END$$

/*
*************************************************************
*				PatrocinanteCrear				*
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `PatrocinanteCrear`;
DELIMITER $$

CREATE FUNCTION `PatrocinanteCrear` (a_Cliente_P CHAR(10))

RETURNS INT DETERMINISTIC
BEGIN
/*
	DECLARE EXIT HANDLER FOR 1048
	BEGIN
		SET @MensajeDeError = 'Error de valor nulo en PatrocinanteCrear()';
		SET @CodigoDeError = 1048;
		RETURN -1048;
	END; 

	DECLARE EXIT HANDLER FOR 1452
	BEGIN
		SET @MensajeDeError = 'Error de clave externa en PatrocinanteCrear()';
		SET @CodigoDeError = 1452;
		RETURN -1452;
	END;

	DECLARE EXIT HANDLER FOR 1062
	BEGIN
		SET @MensajeDeError = 'Error de valor duplicado en PatrocinanteCrear()';
		SET @CodigoDeError = 1062;
		RETURN -1062;
	END;
*/
	INSERT INTO Patrocinante VALUES (
		a_Cliente_P,
		NULL
	);
	RETURN LAST_INSERT_ID();
END$$

/***********************************************************/
DELIMITER ;
/***********************************************************/