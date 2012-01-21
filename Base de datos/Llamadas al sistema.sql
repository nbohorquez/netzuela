USE `Spuria`;

/*
*************************************************************
*				    Insertar				*
*************************************************************
*/

DELIMITER ;

DROP PROCEDURE IF EXISTS `Insertar`;
DELIMITER $$

CREATE PROCEDURE `Insertar` (a_Parametros TEXT)

BEGIN
	START TRANSACTION;
	SELECT '1';
	COMMIT;	
END$$

/*
*************************************************************
*				  Actualizar				*
*************************************************************
*/

DELIMITER ;

DROP PROCEDURE IF EXISTS `Actualizar`;
DELIMITER $$

CREATE PROCEDURE `Actualizar` (a_Parametros TEXT)

BEGIN
	DECLARE BOBO INT;
	DECLARE TiendaID INT;
	DECLARE ProductoID INT;
	DECLARE SKU CHAR(15);
	DECLARE Precio DECIMAL(10,2);
	DECLARE PrecioViejo DECIMAL(10,2);
	DECLARE Cantidad INT;
	DECLARE CantidadVieja INT;
	DECLARE Visibilidad CHAR(16);

	/*START TRANSACTION;*/

	CALL SepararString(`a_Parametros`, ",");
	
	SELECT CONVERT(Valor, SIGNED) FROM Parametros WHERE ID = 1 INTO TiendaID;
	SELECT CONVERT(Valor, SIGNED) FROM Parametros WHERE ID = 2 INTO ProductoID;
	SELECT CONVERT(Valor, CHAR(15)) FROM Parametros WHERE ID = 3 INTO SKU;
	SELECT CONVERT(Valor, DECIMAL(10,2)) FROM Parametros WHERE ID = 4 INTO Precio;
	SELECT CONVERT(Valor, SIGNED) FROM Parametros WHERE ID = 5 INTO Cantidad;
	SELECT CONVERT(Valor, CHAR(16)) FROM Parametros WHERE ID = 6 INTO Visibilidad;
	
	DROP TEMPORARY TABLE IF EXISTS Parametros;
	
	SELECT PrecioCantidad.Precio, PrecioCantidad.Cantidad 
	FROM PrecioCantidad 
	WHERE PrecioCantidad.TiendaID = TiendaID AND PrecioCantidad.ProductoID = ProductoID AND FechaFin IS NULL
	INTO PrecioViejo, CantidadVieja;

	IF (PrecioViejo != Precio OR CantidadVieja != Cantidad) THEN SET BOBO = PrecioCantidadCrear(TiendaID, ProductoID, Precio, Cantidad);
	END IF;

	UPDATE Inventario 
	SET Inventario.SKU = SKU, Inventario.Visibilidad = Visibilidad
	WHERE Inventario.TiendaID = TiendaID AND Inventario.ProductoID = ProductoID;

	/*COMMIT;*/
END$$

/*
*************************************************************
*				     Borrar 				*
*************************************************************
*/

DELIMITER ;

DROP PROCEDURE IF EXISTS `Borrar`;
DELIMITER $$

CREATE PROCEDURE `Borrar` (a_Parametros TEXT)

BEGIN
	START TRANSACTION;
	SELECT '1';
	COMMIT;
END$$

/***********************************************************/
DELIMITER ;
/***********************************************************/