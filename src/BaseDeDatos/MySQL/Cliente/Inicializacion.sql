USE `Cliente`;

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

DELETE from Inventario;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

/*
*******************************************************
*							  		*
*			     INVENTARIO 				*
*									*
*******************************************************
*/

/* 
   Se crea solo un producto para probar el funcionamiento de la base de datos
*/

INSERT INTO Inventario VALUES(NULL, "Silicon Graphics 02", 1025.50, 2);
INSERT INTO Inventario VALUES(NULL, "Creative Inspire 5.1", 1499.99, 5);
INSERT INTO Inventario VALUES(NULL, "Modelo a escala del Apollo 11", 520.50, 12);
INSERT INTO Inventario VALUES(NULL, "PC Intel Core 2 Duo E7400", 2500.00, 10);
INSERT INTO Inventario VALUES(NULL, "Telefono Nokia N78", 1000.0, 6);
INSERT INTO Inventario VALUES(NULL, "Boligrafo Parker Jotter", 100.00, 4);
INSERT INTO Inventario VALUES(NULL, "Pen Drive Kingston 4GB", 210.00, 30);
INSERT INTO Inventario VALUES(NULL, "Reloj Casio Edifice", 475.00, 4);
INSERT INTO Inventario VALUES(NULL, "Router Linksys WG1521", 1200.44, 7);
INSERT INTO Inventario VALUES(NULL, "Archivo vertical de plastico", 400.00, 9);
INSERT INTO Inventario VALUES(NULL, "Cama de madera", 6500.00, 1);
INSERT INTO Inventario VALUES(NULL, "Ventilador de piso", 250.00, 3);