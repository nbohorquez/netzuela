SELECT 'Funciones miscelaneas.sql';
USE `Spuria`;

/*
*************************************************************
*				CategoriaCrear				*
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `CategoriaCrear`;
SELECT 'CategoriaCrear';

DELIMITER $$

CREATE FUNCTION `CategoriaCrear` (a_Nombre CHAR(30), a_HijoDeCategoria INT)
RETURNS INT NOT DETERMINISTIC
BEGIN
	DECLARE C, Etiquetable_P INT;
/*
	DECLARE EXIT HANDLER FOR 1452
	BEGIN
		SET @MensajeDeError = 'Error de clave externa en CategoriaCrear()';
		SET @CodigoDeError = 1452;
		RETURN -1452;
	END; 
*/
	SELECT EtiquetableCrear() INTO Etiquetable_P;

	/* Comprobamos que no haya otra categoria hermana con el mismo nombre */
	SELECT COUNT(*) FROM Categoria
	WHERE Nombre = a_Nombre AND HijoDeCategoria = a_HijoDeCategoria
	INTO C;

	IF C = 0 THEN
		INSERT INTO Categoria VALUES (
			Etiquetable_P,
			NULL,
			a_Nombre,
			a_HijoDeCategoria
		);
	ELSE
		RETURN FALSE;
	END IF;

	RETURN LAST_INSERT_ID();
END$$

/*
*************************************************************
*				MensajeCrear				*
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `MensajeCrear`;
SELECT 'MensajeCrear';

DELIMITER $$

CREATE FUNCTION `MensajeCrear` (a_Creador INT, a_Remitente INT, a_Destinatario INT, a_Contenido TEXT)
RETURNS INT NOT DETERMINISTIC
BEGIN
	DECLARE Rastreable_P, Etiquetable_P INT;
/*
	DECLARE EXIT HANDLER FOR 1452
	BEGIN
		SET @MensajeDeError = 'Error de clave externa en MensajeCrear()';
		SET @CodigoDeError = 1452;
		RETURN -1452;
	END; 
	
	DECLARE EXIT HANDLER FOR 1048
	BEGIN
		SET @MensajeDeError = 'Error de valor nulo en MensajeCrear()';
		SET @CodigoDeError = 1048;
		RETURN -1048;
	END; 
*/
	SELECT RastreableCrear(a_Creador) INTO Rastreable_P;
	SELECT EtiquetableCrear() INTO Etiquetable_P;

	INSERT INTO Mensaje VALUES (
		Rastreable_P,
		Etiquetable_P,
		NULL,
		a_Remitente,
		a_Destinatario,
		a_Contenido
	);

	RETURN LAST_INSERT_ID();
END$$

/*
*************************************************************
*				DescripcionCrear				*
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `DescripcionCrear`;
SELECT 'DescripcionCrear';

DELIMITER $$

CREATE FUNCTION `DescripcionCrear` (a_Creador INT, a_Describible INT, a_Contenido TEXT)
RETURNS INT NOT DETERMINISTIC
BEGIN
	DECLARE Etiquetable_P, Rastreable_P INT;
/*	
	DECLARE EXIT HANDLER FOR 1452
	BEGIN
		SET @MensajeDeError = 'Error de clave externa en DescripcionCrear()';
		SET @CodigoDeError = 1452;
		RETURN -1452;
	END; 

	DECLARE EXIT HANDLER FOR 1048
	BEGIN
		SET @MensajeDeError = 'Error de valor nulo en DescripcionCrear()';
		SET @CodigoDeError = 1048;
		RETURN -1048;
	END; 
*/
	SELECT RastreableCrear(a_Creador) INTO Rastreable_P;
	SELECT EtiquetableCrear() INTO Etiquetable_P;

	INSERT INTO Descripcion VALUES (
		Rastreable_P,
		Etiquetable_P,
		NULL,
		a_Describible,
		a_Contenido
	);

	RETURN LAST_INSERT_ID();
END $$

/*
*************************************************************
*				FotoCrear					*
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `FotoCrear`;
SELECT 'FotoCrear';

DELIMITER $$

CREATE FUNCTION `FotoCrear` (a_RutaDeFoto CHAR(80), a_Describible INT)
RETURNS INT NOT DETERMINISTIC
BEGIN
/*
	DECLARE EXIT HANDLER FOR 1452
	BEGIN
		SET @MensajeDeError = 'Error de clave externa en FotoCrear()';
		SET @CodigoDeError = 1452;
		RETURN -1452;
	END; 
	
	DECLARE EXIT HANDLER FOR 1048
	BEGIN
		SET @MensajeDeError = 'Error de valor nulo en FotoCrear()';
		SET @CodigoDeError = 1048;
		RETURN -1048;
	END; 
*/
	INSERT INTO Foto VALUES (
		NULL,
		a_RutaDeFoto,
		a_Describible
	);
	RETURN LAST_INSERT_ID();
END$$

/*
*************************************************************
*				PuntoCrear					*
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `PuntoCrear`;
SELECT 'PuntoCrear';

DELIMITER $$

CREATE FUNCTION `PuntoCrear` (a_Latitud DECIMAL(9,6), a_Longitud DECIMAL(9,6))
RETURNS INT NOT DETERMINISTIC
BEGIN
/* 
	DECLARE EXIT HANDLER FOR 1048
	BEGIN
		SET @MensajeDeError = 'Error de valor nulo en PuntoCrear()';
		SET @CodigoDeError = 1048;
		RETURN -1048;
	END; 

	DECLARE EXIT HANDLER FOR 1062
	BEGIN
		SET @MensajeDeError = 'Error de valor duplicado en PuntoCrear()';
		SET @CodigoDeError = 1062;
		RETURN -1062;
	END;
*/
	INSERT INTO Punto VALUES (
		NULL,
		a_Latitud,
		a_Longitud
	);
	RETURN LAST_INSERT_ID();
END$$

/*
*************************************************************
*				CroquisCrear				*
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `CroquisCrear`;
SELECT 'CroquisCrear';

DELIMITER $$

CREATE FUNCTION `CroquisCrear` (a_Creador INT, a_Dibujable INT)
RETURNS INT NOT DETERMINISTIC
BEGIN
	DECLARE Rastreable_P INT;
/*
	DECLARE EXIT HANDLER FOR 1452
	BEGIN
		SET @MensajeDeError = 'Error de clave externa en CroquisCrear()';
		SET @CodigoDeError = 1452;
		RETURN -1452;
	END;

	DECLARE EXIT HANDLER FOR 1062
	BEGIN
		SET @MensajeDeError = 'Error de valor duplicado en CroquisCrear()';
		SET @CodigoDeError = 1062;
		RETURN -1062;
	END;

	DECLARE EXIT HANDLER FOR 1048
	BEGIN
		SET @MensajeDeError = 'Error de valor nulo en CroquisCrear()';
		SET @CodigoDeError = 1048;
		RETURN -1048;
	END; 
*/
	SELECT RastreableCrear(a_Creador) INTO Rastreable_P;

	INSERT INTO Croquis VALUES (
		Rastreable_P,
		a_Dibujable,
		-1, -1
	);

	RETURN a_Dibujable;
END$$

/*
*************************************************************
*				PuntoDeCroquisCrear			*
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `PuntoDeCroquisCrear`;
SELECT 'PuntoDeCroquisCrear';

DELIMITER $$

CREATE FUNCTION `PuntoDeCroquisCrear` (a_CroquisID INT, a_PuntoID INT)
RETURNS INT NOT DETERMINISTIC
BEGIN
/*
	DECLARE EXIT HANDLER FOR 1452
	BEGIN
		SET @MensajeDeError = 'Error de clave externa en PuntoDeCroquisCrear()';
		SET @CodigoDeError = 1452;
		RETURN -1452;
	END;

	DECLARE EXIT HANDLER FOR 1062
	BEGIN
		SET @MensajeDeError = 'Error de valor duplicado en PuntoDeCroquisCrear()';
		SET @CodigoDeError = 1062;
		RETURN -1062;
	END;
*/
	INSERT INTO PuntoDeCroquis VALUES (
		a_CroquisID,
		a_PuntoID
	);
	RETURN TRUE;
END$$

/*
*************************************************************
*				PalabraCrear				*
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `PalabraCrear`;
SELECT 'PalabraCrear';

DELIMITER $$

CREATE FUNCTION `PalabraCrear` (a_Palabra_Frase CHAR(15))
RETURNS INT NOT DETERMINISTIC
BEGIN
/*
	DECLARE EXIT HANDLER FOR 1048
	BEGIN
		SET @MensajeDeError = 'Error de valor nulo en PalabraCrear()';
		SET @CodigoDeError = 1048;
		RETURN -1048;
	END; 
	
	DECLARE EXIT HANDLER FOR 1062
	BEGIN
		SET @MensajeDeError = 'Error de valor duplicado en PalabraCrear()';
		SET @CodigoDeError = 1062;
		RETURN -1062;
	END; 
*/
	INSERT INTO Palabra VALUES (
		NULL,
		a_Palabra_Frase
	);

	RETURN LAST_INSERT_ID();
END$$

/*
*************************************************************
*			RelacionDePalabrasCrear				*
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `RelacionDePalabrasCrear`;
SELECT 'RelacionDePalabrasCrear';

DELIMITER $$

CREATE FUNCTION `RelacionDePalabrasCrear` (a_Palabra1ID INT, a_Palabra2ID INT)
RETURNS INT NOT DETERMINISTIC
BEGIN
/*
	DECLARE EXIT HANDLER FOR 1452
	BEGIN
		SET @MensajeDeError = 'Error de clave externa en RelacionDePalabrasCrear()';
		SET @CodigoDeError = 1452;
		RETURN -1452;
	END; 

	DECLARE EXIT HANDLER FOR 1062
	BEGIN
		SET @MensajeDeError = 'Error de valor duplicado en RelacionDePalabrasCrear()';
		SET @CodigoDeError = 1062;
		RETURN -1062;
	END; 
*/
	INSERT INTO RelacionDePalabras VALUES (
		a_Palabra1ID,
		a_Palabra2ID
	);
	RETURN TRUE;
END$$

/*
*************************************************************
*				EtiquetaCrear				*
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `EtiquetaCrear`;
SELECT 'EtiquetaCrear';

DELIMITER $$

CREATE FUNCTION `EtiquetaCrear` (a_EtiquetableID INT, a_PalabraID INT)
RETURNS INT NOT DETERMINISTIC
BEGIN
/*
	DECLARE EXIT HANDLER FOR 1452
	BEGIN
		SET @MensajeDeError = 'Error de clave externa en EtiquetaCrear()';
		SET @CodigoDeError = 1452;
		RETURN -1452;
	END; 

	DECLARE EXIT HANDLER FOR 1062
	BEGIN
		SET @MensajeDeError = 'Error de valor duplicado en EtiquetaCrear()';
		SET @CodigoDeError = 1062;
		RETURN -1062;
	END;

	DECLARE EXIT HANDLER FOR 1048
	BEGIN
		SET @MensajeDeError = 'Error de valor nulo en EtiquetaCrear()';
		SET @CodigoDeError = 1048;
		RETURN -1048;
	END; 
*/
	INSERT INTO Etiqueta VALUES (
		a_EtiquetableID,
		a_PalabraID
	);
	RETURN TRUE;
END$$

/*
*************************************************************
*			CalificionResenaCrear				*
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `CalificacionResenaCrear`;
SELECT 'CalificacionResenaCrear';

DELIMITER $$

CREATE FUNCTION `CalificacionResenaCrear` (a_Creador INT, a_CalificableSeguibleID INT, a_ConsumidorID INT, a_Calificacion CHAR(4), a_Resena TEXT)
RETURNS INT NOT DETERMINISTIC
BEGIN
	DECLARE Etiquetable_P, Rastreable_P INT;
/*
	DECLARE EXIT HANDLER FOR 1452
	BEGIN
		SET @MensajeDeError = 'Error de clave externa en CalificionResenaCrear()';
		SET @CodigoDeError = 1452;
		RETURN -1452;
	END;

	DECLARE EXIT HANDLER FOR 1062
	BEGIN
		SET @MensajeDeError = 'Error de valor duplicado en CalificionResenaCrear()';
		SET @CodigoDeError = 1062;
		RETURN -1062;
	END;

	DECLARE EXIT HANDLER FOR 1048
	BEGIN
		SET @MensajeDeError = 'Error de valor nulo en CalificionResenaCrear()';
		SET @CodigoDeError = 1048;
		RETURN -1048;
	END;
*/
	SELECT RastreableCrear(a_Creador) INTO Rastreable_P;
	SELECT EtiquetableCrear() INTO Etiquetable_P;

	INSERT INTO CalificacionResena VALUES (
		Rastreable_P,
		Etiquetable_P,
		a_CalificableSeguibleID,
		a_ConsumidorID,
		a_Calificacion,
		a_Resena
	);
	RETURN TRUE;
END$$

/*
*************************************************************
*				SeguidorCrear				*
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `SeguidorCrear`;
SELECT 'SeguidorCrear';

DELIMITER $$

CREATE FUNCTION `SeguidorCrear` (a_Creador INT, a_CalificableSeguibleID INT, a_ConsumidorID INT, a_AvisarSi CHAR(40))
RETURNS INT NOT DETERMINISTIC
BEGIN
	DECLARE Rastreable_P INT;
/*
	DECLARE EXIT HANDLER FOR 1452
	BEGIN
		SET @MensajeDeError = 'Error de clave externa en SeguidorCrear()';
		SET @CodigoDeError = 1452;
		RETURN -1452;
	END; 

	DECLARE EXIT HANDLER FOR 1062
	BEGIN
		SET @MensajeDeError = 'Error de valor duplicado en SeguidorCrear()';
		SET @CodigoDeError = 1062;
		RETURN -1062;
	END;

	DECLARE EXIT HANDLER FOR 1048
	BEGIN
		SET @MensajeDeError = 'Error de valor nulo en SeguidorCrear()';
		SET @CodigoDeError = 1048;
		RETURN -1048;
	END; 
*/
	SELECT RastreableCrear(a_Creador) INTO Rastreable_P;

	INSERT INTO Seguidor VALUES (
		Rastreable_P,
		a_ConsumidorID,
		a_CalificableSeguibleID,
		a_AvisarSi
	);

	RETURN TRUE;
END$$

/*
*************************************************************
*				BusquedaCrear				*
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `BusquedaCrear`;
SELECT 'BusquedaCrear';

DELIMITER $$

CREATE FUNCTION `BusquedaCrear` (a_Creador INT, a_UsuarioID INT, a_Contenido TEXT)
RETURNS INT NOT DETERMINISTIC
BEGIN
	DECLARE Etiquetable_P, Rastreable_P INT;
/*
	DECLARE EXIT HANDLER FOR 1452
	BEGIN
		SET @MensajeDeError = 'Error de clave externa en BusquedaCrear()';
		SET @CodigoDeError = 1452;
		RETURN -1452;
	END; 

	DECLARE EXIT HANDLER FOR 1062
	BEGIN
		SET @MensajeDeError = 'Error de valor duplicado en BusquedaCrear()';
		SET @CodigoDeError = 1062;
		RETURN -1062;
	END;

	DECLARE EXIT HANDLER FOR 1048
	BEGIN
		SET @MensajeDeError = 'Error de valor nulo en BusquedaCrear()';
		SET @CodigoDeError = 1048;
		RETURN -1048;
	END; 
*/
	SELECT RastreableCrear(a_Creador) INTO Rastreable_P;
	SELECT EtiquetableCrear() INTO Etiquetable_P;

	INSERT INTO Busqueda VALUES (
		Rastreable_P,
		Etiquetable_P,
		NULL,
		a_UsuarioID,
		NOW(),
		a_Contenido
	);

	RETURN LAST_INSERT_ID();
END$$

/*
*************************************************************
*			ResultadoDeBusquedaCrear			*
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `ResultadoDeBusquedaCrear`;
SELECT 'ResultadoDeBusquedaCrear';

DELIMITER $$

CREATE FUNCTION `ResultadoDeBusquedaCrear` (a_BusquedaID INT, a_BuscableID INT, a_Relevancia FLOAT)
RETURNS INT NOT DETERMINISTIC
BEGIN
/*
	DECLARE EXIT HANDLER FOR 1452
	BEGIN
		SET @MensajeDeError = 'Error de clave externa en ResultadoDeBusquedaCrear()';
		SET @CodigoDeError = 1452;
		RETURN -1452;
	END; 

	DECLARE EXIT HANDLER FOR 1062
	BEGIN
		SET @MensajeDeError = 'Error de valor duplicado en ResultadoDeBusquedaCrear()';
		SET @CodigoDeError = 1062;
		RETURN -1062;
	END;

	DECLARE EXIT HANDLER FOR 1048
	BEGIN
		SET @MensajeDeError = 'Error de valor nulo en ResultadoDeBusquedaCrear()';
		SET @CodigoDeError = 1048;
		RETURN -1048;
	END; 
*/
	INSERT INTO ResultadoDeBusqueda VALUES (
		a_BusquedaID,
		a_BuscableID,
		FALSE, 
		a_Relevancia
	);

	RETURN TRUE;
END$$

/*
*************************************************************
*			       SepararString				*
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

/***********************************************************/
DELIMITER ;
/***********************************************************/