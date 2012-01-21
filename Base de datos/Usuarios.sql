/*
*******************************************************
*							  		*
*				USUARIOS 				*
*									*
*******************************************************
*/
USE `Spuria`;

/*
*******************************************************
*			   	Valeria 				*
*******************************************************
*/

DELIMITER ;

DROP PROCEDURE IF EXISTS `CrearUsuarioValeria`;

DELIMITER $$

CREATE PROCEDURE CrearUsuarioValeria() 

BEGIN
	DECLARE ExisteValeria INT;

	SELECT COUNT(*) FROM mysql.user 
	WHERE user = 'Valeria' AND host = 'localhost' 
	INTO ExisteValeria;

	IF ExisteValeria > 0 THEN DROP USER 'Valeria'@'localhost';
	END IF;

	CREATE USER 'Valeria'@'localhost' IDENTIFIED BY '#25pAz7_?Xx#OR9?';
END$$

DELIMITER ;

CALL CrearUsuarioValeria();

GRANT SELECT (TiendaID, ProductoID, SKU, Precio, Cantidad, Visibilidad) ON InventarioTienda TO 'Valeria'@'localhost';
GRANT EXECUTE ON PROCEDURE Spuria.Actualizar TO 'Valeria'@'localhost';
GRANT EXECUTE ON PROCEDURE Spuria.Insertar TO 'Valeria'@'localhost';
GRANT EXECUTE ON PROCEDURE Spuria.Borrar TO 'Valeria'@'localhost';

FLUSH PRIVILEGES;

/*
*******************************************************
*			   	 Paris 				*
*******************************************************
*/

DROP PROCEDURE IF EXISTS `CrearUsuarioParis`;

DELIMITER $$

CREATE PROCEDURE CrearUsuarioParis() 

BEGIN
	DECLARE ExisteParis INT;

	SELECT COUNT(*) FROM mysql.user 
	WHERE user = 'Paris' AND host = 'localhost' 
	INTO ExisteParis;

	IF ExisteParis > 0 THEN DROP USER 'Paris'@'localhost';
	END IF;

	CREATE USER 'Paris'@'localhost' IDENTIFIED BY '#37KhVFmG1_Lp@#j?R4';
END$$

DELIMITER ;

CALL CrearUsuarioParis();

FLUSH PRIVILEGES;

/******************************************************/
DELIMITER ;
/******************************************************/