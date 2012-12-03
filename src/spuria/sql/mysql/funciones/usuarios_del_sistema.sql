SELECT 'usuarios_del_sistema.sql';
USE `spuria`;

/*
*******************************************************
*                       Valeria 				              *
*******************************************************
*/

DELIMITER ;

DROP PROCEDURE IF EXISTS `CrearUsuarioValeria`;
SELECT 'CrearUsuarioValeria';

DELIMITER $$

CREATE PROCEDURE CrearUsuarioValeria() 
BEGIN
    DECLARE ExisteValeria INT;

    SELECT COUNT(*) FROM mysql.user 
    WHERE user = 'valeria' AND host = 'localhost' 
    INTO ExisteValeria;

    IF ExisteValeria > 0 THEN 
        DROP USER 'valeria'@'localhost';
    END IF;

    CREATE USER 'valeria'@'localhost' IDENTIFIED BY '#25pAz7_?Xx#OR9?';
    
    GRANT SELECT (tienda_id, codigo, descripcion, precio, cantidad) ON inventario_tienda TO 'valeria'@'localhost';
    GRANT EXECUTE ON PROCEDURE spuria.Actualizar TO 'valeria'@'localhost';
    GRANT EXECUTE ON PROCEDURE spuria.Insertar TO 'valeria'@'localhost';
    GRANT EXECUTE ON PROCEDURE spuria.Eliminar TO 'valeria'@'localhost';
END$$

/*
*******************************************************
*                         Paris 				              *
*******************************************************
*/

DELIMITER ;

DROP PROCEDURE IF EXISTS `CrearUsuarioParis`;
SELECT 'CrearUsuarioParis';

DELIMITER $$

CREATE PROCEDURE CrearUsuarioParis() 
BEGIN
    DECLARE ExisteParis INT;

    SELECT COUNT(*) FROM mysql.user 
    WHERE user = 'paris' AND host = 'localhost' 
    INTO ExisteParis;

    IF ExisteParis > 0 THEN 
        DROP USER 'paris'@'localhost';
    END IF;

    CREATE USER 'paris'@'localhost' IDENTIFIED BY '#37KhVFmG1_Lp@#j?R4';
END$$

/******************************************************/
DELIMITER ;
/******************************************************/
