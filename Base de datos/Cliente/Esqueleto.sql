SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `Cliente` DEFAULT CHARACTER SET latin1 COLLATE latin1_spanish_ci ;
USE `Cliente` ;

-- -----------------------------------------------------
-- Table `Cliente`.`Inventario`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Cliente`.`Inventario` (
  `Codigo` INT NOT NULL AUTO_INCREMENT ,
  `Descripcion` VARCHAR(30) NULL ,
  `Precio` DECIMAL(10,2) NOT NULL ,
  `Cantidad` INT NOT NULL ,
  PRIMARY KEY (`Codigo`) )
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
