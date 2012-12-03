SELECT 'Generales.sql';
USE `Spuria`;

/*
*************************************************************
*				                InsertarCategoria			              *
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarCategoria`;
SELECT 'InsertarCategoria';

DELIMITER $$

CREATE FUNCTION `InsertarCategoria` (a_Nombre CHAR(30), a_HijoDeCategoria INT)
RETURNS INT NOT DETERMINISTIC
BEGIN
    DECLARE C, v_Etiquetable_P INT;

    SELECT InsertarEtiquetable() INTO v_Etiquetable_P;
    
    /* Comprobamos que no haya otra categoria hermana con el mismo nombre */
    SELECT COUNT(*) FROM Categoria
    WHERE Nombre = a_Nombre AND HijoDeCategoria = a_HijoDeCategoria
    INTO C;

    IF C = 0 THEN
        INSERT INTO Categoria (
            Etiquetable_P,
            Nombre,
            HijoDeCategoria
        ) VALUES (
            v_Etiquetable_P,
            a_Nombre,
            a_HijoDeCategoria
        );
    ELSE
        RETURN FALSE;
    END IF;

    RETURN LAST_INSERT_ID();
END$$

/***********************************************************/
DELIMITER ;
/***********************************************************/