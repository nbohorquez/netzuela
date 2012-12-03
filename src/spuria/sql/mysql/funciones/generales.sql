SELECT 'generales.sql';
USE `spuria`;

/*
*************************************************************
*				                InsertarCategoria			              *
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InsertarCategoria`;
SELECT 'InsertarCategoria';

DELIMITER $$

CREATE FUNCTION `InsertarCategoria` (a_Nombre CHAR(30), a_HijoDeCategoria CHAR(16))
RETURNS CHAR(16) NOT DETERMINISTIC
BEGIN
    DECLARE C, Etiquetable_P, Punto, NivelPadre INT;
	DECLARE N CHAR(2);
	DECLARE ID, ACambiar, ADejarIgual CHAR(16);

    DECLARE EXIT HANDLER FOR 1452
    BEGIN
        SET @MensajeDeError = 'Error de clave externa en InsertarCategoria()';
        SET @CodigoDeError = 1452;
        RETURN -1452;
    END; 

    SELECT InsertarEtiquetable() INTO Etiquetable_P;
    
    /* Comprobamos que no haya otra categoria hermana con el mismo nombre */
    SELECT COUNT(*) FROM categoria
    WHERE nombre = a_Nombre AND hijo_de_categoria = a_HijoDeCategoria
    INTO C;

    IF C = 0 THEN
		SELECT COUNT(*) FROM categoria
		WHERE hijo_de_categoria = a_HijoDeCategoria
		INTO C;

		SELECT nivel FROM categoria
		WHERE categoria_id = a_HijoDeCategoria
		INTO NivelPadre;

		SELECT LPAD(HEX(C + 1), 2, '0') INTO N;
		SELECT LOCATE('00', a_HijoDeCategoria) INTO Punto;
		SELECT LEFT(a_HijoDeCategoria, Punto + 1) INTO ACambiar;
		SELECT RIGHT(a_HijoDeCategoria, LENGTH(a_HijoDeCategoria) - Punto - 1) INTO ADejarIgual;
		SELECT CONCAT(REPLACE(ACambiar, '00', N), ADejarIgual) INTO ID;

        INSERT INTO categoria VALUES (
            Etiquetable_P,
            ID,
            a_Nombre,
            a_HijoDeCategoria,
			NivelPadre + 1
        );

		RETURN ID;
    ELSE
        RETURN FALSE;
    END IF;
END$$

/***********************************************************/
DELIMITER ;
/***********************************************************/
