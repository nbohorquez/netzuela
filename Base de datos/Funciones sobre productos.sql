USE `Spuria`;

/*
*************************************************************
*				PrecioCantidadCrear			*
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `PrecioCantidadCrear`;
DELIMITER $$

CREATE FUNCTION `PrecioCantidadCrear` (a_TiendaID INT, a_ProductoID INT, a_Precio DECIMAL(10,2), a_Cantidad INT)

RETURNS INT DETERMINISTIC
BEGIN
	DECLARE C INT;
/*
	DECLARE EXIT HANDLER FOR 1452
	BEGIN
		SET @MensajeDeError = 'Error de clave externa en PrecioCantidadCrear()';
		SET @CodigoDeError = 1452;
		RETURN -1452;
	END; 

	DECLARE EXIT HANDLER FOR 1048
	BEGIN
		SET @MensajeDeError = 'Error de valor nulo en PrecioCantidadCrear()';
		SET @CodigoDeError = 1048;
		RETURN -1048;
	END;
*/	
	/* Vemos si ya existe un registro "PrecioCantidad" ya asociado al inventario */
	SELECT COUNT(*) FROM PrecioCantidad
	WHERE TiendaID = a_TiendaID AND ProductoID = a_ProductoID
	INTO C;
		
	IF C > 0 THEN
		UPDATE PrecioCantidad
     		SET FechaFin = NOW()
     		WHERE TiendaID = a_TiendaID AND ProductoID = a_ProductoID AND FechaFin IS NULL;
	END IF;

	INSERT INTO PrecioCantidad VALUES (
		a_TiendaID,
		a_ProductoID,
		NOW(),
		NULL,
		a_Precio,
		a_Cantidad
	);
	RETURN TRUE;
END$$

/*
*************************************************************
*				ProductoCrear				*
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `ProductoCrear`;
DELIMITER $$

CREATE FUNCTION `ProductoCrear` (a_Creador INT, a_TipoDeCodigoUniversal CHAR(7), a_Codigo CHAR(15), 
						a_Estatus CHAR(9), a_Fabricante VARCHAR(45), a_Modelo VARCHAR(45), 
						a_Nombre VARCHAR(45), a_Categoria INT, a_DebutEnElMercado DATE, 
						a_Largo FLOAT, a_Ancho FLOAT, a_Alto FLOAT, a_Peso FLOAT, a_PaisDeOrigen INT)
RETURNS INT NOT DETERMINISTIC
BEGIN
	DECLARE Rastreable_P, Describible_P, Buscable_P, CalificableSeguible_P INT;
/*
	DECLARE EXIT HANDLER FOR 1452
	BEGIN
		SET @MensajeDeError = 'Error de clave externa en ProductoCrear()';
		SET @CodigoDeError = 1452;
		RETURN -1452;
	END; 

	DECLARE EXIT HANDLER FOR 1048
	BEGIN
		SET @MensajeDeError = 'Error de valor nulo en ProductoCrear()';
		SET @CodigoDeError = 1048;
		RETURN -1048;
	END;

	DECLARE EXIT HANDLER FOR 1062
	BEGIN
		SET @MensajeDeError = 'Error de valor duplicado en ProductoCrear()';
		SET @CodigoDeError = 1062;
		RETURN -1062;
	END; 
*/
	SELECT RastreableCrear(a_Creador) INTO Rastreable_P;
	SELECT DescribibleCrear() INTO Describible_P;
	SELECT BuscableCrear() INTO Buscable_P;
	SELECT CalificableSeguibleCrear() INTO CalificableSeguible_P;

	INSERT INTO Producto VALUES (
		Rastreable_P,
		Describible_P,
		Buscable_P,
		CalificableSeguible_P,
		NULL,
		a_TipoDeCodigoUniversal,
		a_Codigo,
		a_Estatus,
		a_Fabricante,
		a_Modelo,
		a_Nombre,
		a_Categoria,
		a_DebutEnElMercado,
		a_Largo,
		a_Ancho,
		a_Alto,
		a_Peso,
		a_PaisDeOrigen
	);

	RETURN LAST_INSERT_ID();
END$$

/*
*************************************************************
*				InventarioCrear				*
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InventarioCrear`;
DELIMITER $$

CREATE FUNCTION `InventarioCrear` (a_Creador INT, a_TiendaID INT, a_ProductoID INT, a_Visibilidad CHAR(16), a_SKU CHAR(15), 
						a_Precio DECIMAL(10,2), a_Cantidad INT)

RETURNS INT DETERMINISTIC
BEGIN
	DECLARE Rastreable_P, Cobrable_P, bobo INT;
/*
	DECLARE EXIT HANDLER FOR 1452
	BEGIN
		SET @MensajeDeError = 'Error de clave externa en InventarioCrear()';
		SET @CodigoDeError = 1452;
		RETURN -1452;
	END; 

	DECLARE EXIT HANDLER FOR 1048
	BEGIN
		SET @MensajeDeError = 'Error de valor nulo en InventarioCrear()';
		SET @CodigoDeError = 1048;
		RETURN -1048;
	END;

	DECLARE EXIT HANDLER FOR 1062
	BEGIN
		SET @MensajeDeError = 'Error de valor duplicado en InventarioCrear()';
		SET @CodigoDeError = 1062;
		RETURN -1062;
	END; 
*/
	SELECT RastreableCrear(a_Creador) INTO Rastreable_P;
	SELECT CobrableCrear() INTO Cobrable_P;

  	INSERT INTO Inventario VALUES (
		Rastreable_P,
		Cobrable_P,
		a_TiendaID,
		a_ProductoID,
		a_Visibilidad,
		a_SKU
	);

	SELECT PrecioCantidadCrear(a_TiendaID, a_ProductoID, a_Precio, a_Cantidad) INTO bobo;
	RETURN bobo;
END$$

/***********************************************************/
DELIMITER ;
/***********************************************************/