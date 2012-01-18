USE `Spuria`;

/*
*************************************************************
*				FacturaCrear				*
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `FacturaCrear`;
DELIMITER $$

CREATE FUNCTION `FacturaCrear` (a_Creador INT, a_Cliente CHAR(10), a_InicioDeMedicion DATETIME, a_FinDeMedicion DATETIME)

RETURNS INT DETERMINISTIC
BEGIN
	DECLARE Rastreable_P INT;
/*
	DECLARE EXIT HANDLER FOR 1452
	BEGIN
		SET @MensajeDeError = 'Error de clave externa en FacturaCrear()';
		SET @CodigoDeError = 1452;
		RETURN -1452;
	END; 

	DECLARE EXIT HANDLER FOR 1048
	BEGIN
		SET @MensajeDeError = 'Error de valor nulo en FacturaCrear()';
		SET @CodigoDeError = 1048;
		RETURN -1048;
	END;
*/
	SELECT RastreableCrear(a_Creador) INTO Rastreable_P;

	INSERT INTO Factura VALUES (
		Rastreable_P,
		NULL,
		a_Cliente,
		a_InicioDeMedicion,
		a_FinDeMedicion,
		0, 0, 0
	);
	
	RETURN LAST_INSERT_ID();	
END$$

/*
*************************************************************
*			ServicioVendidoCrear				*
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `ServicioVendidoCrear`;
DELIMITER $$

CREATE FUNCTION `ServicioVendidoCrear` (a_FacturaID INT, a_CobrableID INT)
RETURNS INT NOT DETERMINISTIC
BEGIN
/*
	DECLARE EXIT HANDLER FOR 1452
	BEGIN
		SET @MensajeDeError = 'Error de clave externa en ServicioVendidoCrear()';
		SET @CodigoDeError = 1452;
		RETURN -1452;
	END; 

	DECLARE EXIT HANDLER FOR 1062
	BEGIN
		SET @MensajeDeError = 'Error de valor duplicado en ServicioVendidoCrear()';
		SET @CodigoDeError = 1062;
		RETURN -1062;
	END; 

	DECLARE EXIT HANDLER FOR 1048
	BEGIN
		SET @MensajeDeError = 'Error de valor nulo en ServicioVendidoCrear()';
		SET @CodigoDeError = 1048;
		RETURN -1048;
	END;
*/
	INSERT INTO ServicioVendido VALUES (
		a_FacturaID,
		a_CobrableID,
		0
	);

	RETURN TRUE;
END$$

/***********************************************************/
DELIMITER ;
/***********************************************************/