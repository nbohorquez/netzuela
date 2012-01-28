SELECT 'Llamadas al sistema.sql';
USE `Spuria`;

/*
*************************************************************
*				    Insertar				*
*************************************************************
*/

DELIMITER ;

DROP PROCEDURE IF EXISTS `Insertar`;
SELECT 'Insertar';

DELIMITER $$

CREATE PROCEDURE `Insertar` (a_Parametros TEXT)

BEGIN
	DECLARE TiendaID INT;
	DECLARE Codigo CHAR(15);
	DECLARE Descripcion VARCHAR(45);
	DECLARE Precio DECIMAL(10,2);
	DECLARE Cantidad INT;

	DECLARE Creador INT;
	DECLARE Resultado INT;
	DECLARE PrecioViejo DECIMAL(10,2);
	DECLARE CantidadVieja INT;

	/*START TRANSACTION;*/

	CALL SepararString(`a_Parametros`, ",");

	SELECT CONVERT(Valor, SIGNED) FROM Parametros WHERE ID = 1 INTO TiendaID;
	SELECT CONVERT(Valor, CHAR(15)) FROM Parametros WHERE ID = 2 INTO Codigo;
	SELECT CONVERT(Valor, CHAR) FROM Parametros WHERE ID = 3 INTO Descripcion;
	SELECT CONVERT(Valor, DECIMAL(10,2)) FROM Parametros WHERE ID = 4 INTO Precio;
	SELECT CONVERT(Valor, SIGNED) FROM Parametros WHERE ID = 5 INTO Cantidad;
	
	DROP TEMPORARY TABLE IF EXISTS Parametros;

	SELECT Cliente.Rastreable_P
	FROM Cliente, Tienda
	WHERE Tienda.TiendaID = TiendaID AND Cliente.RIF = Tienda.Cliente_P
	INTO Creador;

	SELECT InventarioCrear(Creador, TiendaID, Codigo, Descripcion, 'Ambos visibles', NULL, Precio, Cantidad) INTO Resultado;

	/* COMMIT; */
END$$

/*
*************************************************************
*				  Actualizar				*
*************************************************************
*/

DELIMITER ;

DROP PROCEDURE IF EXISTS `Actualizar`;
SELECT 'Actualizar';

DELIMITER $$

CREATE PROCEDURE `Actualizar` (a_Parametros TEXT)

BEGIN
	DECLARE TiendaID INT;
	DECLARE Codigo CHAR(15);
	DECLARE Descripcion VARCHAR(45);
	DECLARE Precio DECIMAL(10,2);
	DECLARE Cantidad INT;

	DECLARE Resultado INT;
	DECLARE PrecioViejo DECIMAL(10,2);
	DECLARE CantidadVieja INT;

	/*START TRANSACTION;*/

	CALL SepararString(`a_Parametros`, ",");

	SELECT CONVERT(Valor, SIGNED) FROM Parametros WHERE ID = 1 INTO TiendaID;
	SELECT CONVERT(Valor, CHAR(15)) FROM Parametros WHERE ID = 2 INTO Codigo;
	SELECT CONVERT(Valor, CHAR) FROM Parametros WHERE ID = 3 INTO Descripcion;
	SELECT CONVERT(Valor, DECIMAL(10,2)) FROM Parametros WHERE ID = 4 INTO Precio;
	SELECT CONVERT(Valor, SIGNED) FROM Parametros WHERE ID = 5 INTO Cantidad;
	
	DROP TEMPORARY TABLE IF EXISTS Parametros;
	
	SELECT PrecioCantidad.Precio, PrecioCantidad.Cantidad
	FROM PrecioCantidad 
	WHERE PrecioCantidad.TiendaID = TiendaID AND PrecioCantidad.Codigo = Codigo AND FechaFin IS NULL
	INTO PrecioViejo, CantidadVieja;

	IF (PrecioViejo != Precio OR CantidadVieja != Cantidad) THEN 
		SET Resultado = PrecioCantidadCrear(TiendaID, Codigo, Precio, Cantidad);
	END IF;

	UPDATE Inventario
	SET Inventario.Descripcion = Descripcion
	WHERE Inventario.TiendaID = TiendaID AND Inventario.Codigo = Codigo;

	/*COMMIT;*/
END$$

/*
*************************************************************
*				     Borrar 				*
*************************************************************
*/

DELIMITER ;

DROP PROCEDURE IF EXISTS `Eliminar`;
SELECT 'Eliminar';

DELIMITER $$

CREATE PROCEDURE `Eliminar` (a_Parametros TEXT)

BEGIN
	DECLARE TiendaID INT;
	DECLARE Codigo CHAR(15);
	DECLARE Descripcion VARCHAR(45);
	DECLARE Precio DECIMAL(10,2);
	DECLARE Cantidad INT;

	/*START TRANSACTION;*/

	CALL SepararString(`a_Parametros`, ",");

	SELECT CONVERT(Valor, SIGNED) FROM Parametros WHERE ID = 1 INTO TiendaID;
	SELECT CONVERT(Valor, CHAR(15)) FROM Parametros WHERE ID = 2 INTO Codigo;
	SELECT CONVERT(Valor, CHAR) FROM Parametros WHERE ID = 3 INTO Descripcion;
	SELECT CONVERT(Valor, DECIMAL(10,2)) FROM Parametros WHERE ID = 4 INTO Precio;
	SELECT CONVERT(Valor, SIGNED) FROM Parametros WHERE ID = 5 INTO Cantidad;
	
	DROP TEMPORARY TABLE IF EXISTS Parametros;

	DELETE 
	FROM Inventario
	WHERE Inventario.TiendaID = TiendaID AND Inventario.Codigo = Codigo;

	/* COMMIT; */
END$$

/***********************************************************/
DELIMITER ;
/***********************************************************/