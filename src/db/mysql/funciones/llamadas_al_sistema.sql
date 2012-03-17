SELECT 'llamadas_al_sistema.sql';
USE `spuria`;

/*
*************************************************************
*			                   SepararString				              *
*************************************************************
*/

/* 
 * Codigo importado
 * ================
 * 
 * Autor: Jay Pipes
 * Titulo: Split a Delimited String in SQL
 * Licencia: 
 * Fuente: http://forge.mysql.com/tools/tool.php?id=4
 * 
 * Tipo de uso
 * ===========
 * 
 * Textual                                              []
 * Adaptado                                             [X]
 * Solo se cambiaron los nombres de las variables       []
 * 
 */

DELIMITER ;

DROP PROCEDURE IF EXISTS `SepararString`;
SELECT 'SepararString';

DELIMITER $$

CREATE PROCEDURE `SepararString` (IN input TEXT, IN `delimiter` VARCHAR(10))
BEGIN
    DECLARE cur_position INT DEFAULT 1;
    DECLARE remainder TEXT;
    DECLARE cur_string VARCHAR(1000);
    DECLARE delimiter_length TINYINT UNSIGNED;
 
    DROP TEMPORARY TABLE IF EXISTS Parametros;

    CREATE TEMPORARY TABLE Parametros (
        `ID` INT NOT NULL AUTO_INCREMENT,
        `Valor` VARCHAR(1000) NOT NULL,
        PRIMARY KEY (`ID`)
    ) ENGINE=MyISAM;
 
    SET remainder = input;
    SET delimiter_length = CHAR_LENGTH(delimiter);
 
    WHILE CHAR_LENGTH(remainder) > 0 AND cur_position > 0 DO
        SET cur_position = INSTR(remainder, `delimiter`);
		
        IF cur_position = 0 THEN
            SET cur_string = remainder;
        ELSE
            SET cur_string = LEFT(remainder, cur_position - 1);
        END IF;
		
        IF TRIM(cur_string) != '' THEN
            INSERT INTO Parametros VALUES (NULL, cur_string);
        END IF;
	
        SET remainder = SUBSTRING(remainder, cur_position + delimiter_length);
    END WHILE;
END$$

/*
*************************************************************
*				                    Insertar				                *
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

    SELECT cliente.rastreable_p
    FROM cliente, tienda
    WHERE tienda.tienda_id = TiendaID AND cliente.rif = tienda.cliente_p
    INTO Creador;

    SELECT InsertarInventario(Creador, TiendaID, Codigo, Descripcion, 'Ambos visibles', NULL, Precio, Cantidad) INTO Resultado;

    /* COMMIT; */
END$$

/*
*************************************************************
*                           Actualizar				              *
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
	
    SELECT precio_cantidad.precio, precio_cantidad.cantidad
    FROM precio_cantidad 
    WHERE precio_cantidad.tienda_id = TiendaID AND precio_cantidad.codigo = Codigo AND fecha_fin IS NULL
    INTO PrecioViejo, CantidadVieja;

    IF (PrecioViejo != Precio OR CantidadVieja != Cantidad) THEN 
        SET Resultado = PrecioCantidadCrear(TiendaID, Codigo, Precio, Cantidad);
    END IF;

    UPDATE inventario
    SET inventario.descripcion = Descripcion
    WHERE inventario.tienda_id = TiendaID AND inventario.codigo = Codigo;

    /*COMMIT;*/
END$$

/*
*************************************************************
*                           Borrar 				                  *
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
    FROM inventario
    WHERE inventario.tienda_id = TiendaID AND inventario.codigo = Codigo;

    /* COMMIT; */
END$$

/***********************************************************/
DELIMITER ;
/***********************************************************/
