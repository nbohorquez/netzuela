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
	DECLARE TiendaID INT;
	DECLARE CodigoUniversal CHAR(15);
	DECLARE Nombre CHAR(45);
	DECLARE SKU CHAR(15);
	DECLARE Precio DECIMAL(10,2);
	DECLARE Cantidad INT;
	DECLARE Visibilidad CHAR(16);

	DECLARE Resultado INT;
	DECLARE ProductoID INT;
	DECLARE PrecioViejo DECIMAL(10,2);
	DECLARE CantidadVieja INT;
	DECLARE Creador INT;

	/*START TRANSACTION;*/

	CALL SepararString(`a_Parametros`, ",");
	
	SELECT CONVERT(Valor, SIGNED) FROM Parametros WHERE ID = 1 INTO TiendaID;
	SELECT CONVERT(Valor, CHAR(15)) FROM Parametros WHERE ID = 2 INTO CodigoUniversal;
	SELECT CONVERT(Valor, CHAR(45)) FROM Parametros WHERE ID = 3 INTO Nombre;
	SELECT CONVERT(Valor, CHAR(15)) FROM Parametros WHERE ID = 3 INTO SKU;
	SELECT CONVERT(Valor, DECIMAL(10,2)) FROM Parametros WHERE ID = 4 INTO Precio;
	SELECT CONVERT(Valor, SIGNED) FROM Parametros WHERE ID = 5 INTO Cantidad;
	SELECT CONVERT(Valor, CHAR(16)) FROM Parametros WHERE ID = 6 INTO Visibilidad;
	
	DROP TEMPORARY TABLE IF EXISTS Parametros;

	SELECT Producto.ProductoID 
	FROM Producto 
	WHERE Producto.CodigoUniversal = CodigoUniversal LIMIT 1 
	INTO ProductoID;

	SELECT Cliente.Rastreable_P
	FROM Cliente, Tienda
	WHERE Tienda.Cliente_P = Cliente.RIF
	INTO Creador;

	/* El producto no existe, hay que crearlo */
	IF ProductoID IS NULL THEN SET Resultado = ProductoCrear(Creador, 'Desconocido', CodigoUniversal, 
											'Activo', 'Desconocido', a_Modelo VARCHAR(45), 
											Nombre, 'No asignada', NULL, NULL, NULL, NULL, NULL, NULL);


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
	DECLARE TiendaID INT;
	DECLARE CodigoUniversal CHAR(15);
	DECLARE Nombre CHAR(45);
	DECLARE SKU CHAR(15);
	DECLARE Precio DECIMAL(10,2);
	DECLARE Cantidad INT;
	DECLARE Visibilidad CHAR(16);

	DECLARE Resultado INT;
	DECLARE ProductoID INT;
	DECLARE PrecioViejo DECIMAL(10,2);
	DECLARE CantidadVieja INT;

	/*START TRANSACTION;*/

	CALL SepararString(`a_Parametros`, ",");
	
	SELECT CONVERT(Valor, SIGNED) FROM Parametros WHERE ID = 1 INTO TiendaID;
	SELECT CONVERT(Valor, CHAR(15)) FROM Parametros WHERE ID = 2 INTO CodigoUniversal;
	SELECT CONVERT(Valor, CHAR(45)) FROM Parametros WHERE ID = 3 INTO Nombre;
	SELECT CONVERT(Valor, CHAR(15)) FROM Parametros WHERE ID = 3 INTO SKU;
	SELECT CONVERT(Valor, DECIMAL(10,2)) FROM Parametros WHERE ID = 4 INTO Precio;
	SELECT CONVERT(Valor, SIGNED) FROM Parametros WHERE ID = 5 INTO Cantidad;
	SELECT CONVERT(Valor, CHAR(16)) FROM Parametros WHERE ID = 6 INTO Visibilidad;
	
	DROP TEMPORARY TABLE IF EXISTS Parametros;
	
	SELECT Producto.ProductoID 
	FROM Producto 
	WHERE Producto.CodigoUniversal = CodigoUniversal LIMIT 1 
	INTO ProductoID;

	SELECT PrecioCantidad.Precio, PrecioCantidad.Cantidad
	FROM PrecioCantidad 
	WHERE PrecioCantidad.TiendaID = TiendaID AND PrecioCantidad.ProductoID = ProductoID AND FechaFin IS NULL
	INTO PrecioViejo, CantidadVieja;

	IF (PrecioViejo != Precio OR CantidadVieja != Cantidad) THEN SET Resultado = PrecioCantidadCrear(TiendaID, ProductoID, Precio, Cantidad);
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