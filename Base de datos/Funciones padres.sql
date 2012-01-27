SELECT 'Funciones padres.sql';
USE `Spuria`;

/*
*************************************************************
*				RastreableCrear				*
*************************************************************
*/

DROP FUNCTION IF EXISTS `RastreableCrear`;
SELECT 'RastreableCrear';

DELIMITER $$

CREATE FUNCTION `RastreableCrear` (a_Creador INT)
RETURNS INT NOT DETERMINISTIC
BEGIN
	INSERT INTO Rastreable VALUES (
		NULL,
		NOW(), a_Creador,
		NOW(), a_Creador,
		NULL, NULL,
		NOW(), a_Creador
	);	
	RETURN LAST_INSERT_ID();
END$$

/*
*************************************************************
*				CobrableCrear				*
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `CobrableCrear`;
SELECT 'CobrableCrear';

DELIMITER $$

CREATE FUNCTION `CobrableCrear` ()
RETURNS INT NOT DETERMINISTIC
BEGIN
	INSERT INTO Cobrable VALUES (NULL);
	RETURN LAST_INSERT_ID();
END$$

/*
*************************************************************
*				DescribibleCrear				*
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `DescribibleCrear`;
SELECT 'DescribibleCrear';

DELIMITER $$

CREATE FUNCTION `DescribibleCrear` ()
RETURNS INT NOT DETERMINISTIC
BEGIN
	INSERT INTO Describible VALUES (NULL);
	RETURN LAST_INSERT_ID();
END$$

/*
*************************************************************
*				BuscableCrear				*
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `BuscableCrear`;
SELECT 'BuscableCrear';

DELIMITER $$

CREATE FUNCTION `BuscableCrear` ()
RETURNS INT NOT DETERMINISTIC
BEGIN
	INSERT INTO Buscable VALUES (NULL);
	RETURN LAST_INSERT_ID();
END$$

/*
*************************************************************
*			CalificableSeguibleCrear			*
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `CalificableSeguibleCrear`;
SELECT 'CalificableSeguibleCrear';

DELIMITER $$

CREATE FUNCTION `CalificableSeguibleCrear` ()
RETURNS INT NOT DETERMINISTIC
BEGIN
	INSERT INTO CalificableSeguible VALUES (NULL, 0);
	RETURN LAST_INSERT_ID();
END$$

/*
*************************************************************
*				EtiquetableCrear				*
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `EtiquetableCrear`;
SELECT 'EtiquetableCrear';

DELIMITER $$

CREATE FUNCTION `EtiquetableCrear` ()
RETURNS INT NOT DETERMINISTIC
BEGIN
	INSERT INTO Etiquetable VALUES (NULL);
	RETURN LAST_INSERT_ID();
END$$

/*
*************************************************************
*				DibujableCrear				*
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `DibujableCrear`;
SELECT 'DibujableCrear';

DELIMITER $$

CREATE FUNCTION `DibujableCrear` ()
RETURNS INT NOT DETERMINISTIC
BEGIN
	INSERT INTO Dibujable VALUES (NULL);
	RETURN LAST_INSERT_ID();
END$$

/*
*************************************************************
*				InterlocutorCrear				*
*************************************************************
*/

DELIMITER ;

DROP FUNCTION IF EXISTS `InterlocutorCrear`;
SELECT 'InterlocutorCrear';

DELIMITER $$

CREATE FUNCTION `InterlocutorCrear` ()
RETURNS INT NOT DETERMINISTIC
BEGIN
	INSERT INTO Interlocutor VALUES (NULL);
	RETURN LAST_INSERT_ID();
END$$

/***********************************************************/
DELIMITER ;
/***********************************************************/