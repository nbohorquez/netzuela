SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `Spuria` DEFAULT CHARACTER SET latin1 COLLATE latin1_spanish_ci ;
USE `Spuria` ;

-- -----------------------------------------------------
-- Table `Spuria`.`Interlocutor`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`Interlocutor` (
  `InterlocutorID` INT NOT NULL AUTO_INCREMENT ,
  PRIMARY KEY (`InterlocutorID`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`CalificableSeguible`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`CalificableSeguible` (
  `CalificableSeguibleID` INT NOT NULL AUTO_INCREMENT ,
  `CalificacionGeneral` INT NULL ,
  PRIMARY KEY (`CalificableSeguibleID`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`Etiquetable`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`Etiquetable` (
  `EtiquetableID` INT NOT NULL AUTO_INCREMENT ,
  PRIMARY KEY (`EtiquetableID`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`Categoria`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`Categoria` (
  `Etiquetable_P` INT NOT NULL ,
  `CategoriaID` INT NOT NULL AUTO_INCREMENT ,
  `Nombre` CHAR(30) NOT NULL ,
  `HijoDeCategoria` INT NOT NULL ,
  PRIMARY KEY (`CategoriaID`) ,
  INDEX `fk_Categoria_Etiquetable` (`Etiquetable_P` ASC) ,
  INDEX `fk_Categoria_Categoria` (`HijoDeCategoria` ASC) ,
  UNIQUE INDEX `Etiquetable_P_UNIQUE` (`Etiquetable_P` ASC) ,
  CONSTRAINT `fk_Categoría_Etiquetable`
    FOREIGN KEY (`Etiquetable_P` )
    REFERENCES `Spuria`.`Etiquetable` (`EtiquetableID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Categoría_Categoría`
    FOREIGN KEY (`HijoDeCategoria` )
    REFERENCES `Spuria`.`Categoria` (`CategoriaID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`Dibujable`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`Dibujable` (
  `DibujableID` INT NOT NULL AUTO_INCREMENT ,
  PRIMARY KEY (`DibujableID`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`Rastreable`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`Rastreable` (
  `RastreableID` INT NOT NULL AUTO_INCREMENT ,
  `FechaDeCreacion` DATETIME NOT NULL ,
  `CreadoPor` INT NOT NULL ,
  `FechaDeModificacion` DATETIME NOT NULL ,
  `ModificadoPor` INT NOT NULL ,
  `FechaDeEliminacion` DATETIME NULL ,
  `EliminadoPor` INT NULL ,
  `FechaDeAcceso` DATETIME NOT NULL ,
  `AccesadoPor` INT NOT NULL ,
  PRIMARY KEY (`RastreableID`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`RegionGeografica`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`RegionGeografica` (
  `Rastreable_P` INT NOT NULL ,
  `Dibujable_P` INT NOT NULL ,
  `RegionGeograficaID` INT NOT NULL AUTO_INCREMENT ,
  `Nombre` VARCHAR(45) NOT NULL ,
  `Poblacion` INT UNSIGNED NOT NULL ,
  `Consumidores_Poblacion` FLOAT NOT NULL ,
  `Tiendas_Poblacion` FLOAT NOT NULL ,
  `Tiendas_Consumidores` FLOAT NULL ,
  PRIMARY KEY (`RegionGeograficaID`) ,
  INDEX `fk_RegionGeografica_Dibujable` (`Dibujable_P` ASC) ,
  INDEX `fk_RegionGeografica_Rastreable` (`Rastreable_P` ASC) ,
  UNIQUE INDEX `Dibujable_P_UNIQUE` (`Dibujable_P` ASC) ,
  UNIQUE INDEX `Rastreable_P_UNIQUE` (`Rastreable_P` ASC) ,
  CONSTRAINT `fk_RegionGeografica_Dibujable`
    FOREIGN KEY (`Dibujable_P` )
    REFERENCES `Spuria`.`Dibujable` (`DibujableID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RegionGeografica_Rastreable`
    FOREIGN KEY (`Rastreable_P` )
    REFERENCES `Spuria`.`Rastreable` (`RastreableID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`Continente`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`Continente` (
  `RegionGeografica_P` INT NOT NULL ,
  `ContinenteID` INT NOT NULL AUTO_INCREMENT ,
  PRIMARY KEY (`ContinenteID`) ,
  INDEX `fk_Continente_RegionGeografica` (`RegionGeografica_P` ASC) ,
  UNIQUE INDEX `RegionGeografica_P_UNIQUE` (`RegionGeografica_P` ASC) ,
  CONSTRAINT `fk_Continente_RegionGeografica`
    FOREIGN KEY (`RegionGeografica_P` )
    REFERENCES `Spuria`.`RegionGeografica` (`RegionGeograficaID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`Ciudad`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`Ciudad` (
  `RegionGeografica_P` INT NOT NULL ,
  `CiudadID` INT NOT NULL AUTO_INCREMENT ,
  PRIMARY KEY (`CiudadID`) ,
  INDEX `fk_Ciudad_RegionGeografica` (`RegionGeografica_P` ASC) ,
  UNIQUE INDEX `RegionGeografica_P_UNIQUE` (`RegionGeografica_P` ASC) ,
  CONSTRAINT `fk_Ciudad_RegionGeografica`
    FOREIGN KEY (`RegionGeografica_P` )
    REFERENCES `Spuria`.`RegionGeografica` (`RegionGeograficaID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`Idioma`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`Idioma` (
  `Idioma` CHAR(10) NOT NULL ,
  PRIMARY KEY (`Idioma`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`Pais`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`Pais` (
  `RegionGeografica_P` INT NOT NULL ,
  `PaisID` INT NOT NULL AUTO_INCREMENT ,
  `Continente` INT NOT NULL ,
  `Capital` INT NOT NULL ,
  `Idioma` CHAR(10) NOT NULL ,
  `MonedaLocal` VARCHAR(45) NULL ,
  `MonedaLocal_Dolar` DECIMAL(10,2) NULL ,
  `PIB` DECIMAL(15,0) NULL ,
  PRIMARY KEY (`PaisID`) ,
  INDEX `fk_Pais_RegionGeografica` (`RegionGeografica_P` ASC) ,
  INDEX `fk_Pais_Continente` (`Continente` ASC) ,
  INDEX `fk_Pais_Ciudad` (`Capital` ASC) ,
  UNIQUE INDEX `Capital_UNIQUE` (`Capital` ASC) ,
  UNIQUE INDEX `RegionGeografica_P_UNIQUE` (`RegionGeografica_P` ASC) ,
  INDEX `fk_Pais_Idioma` (`Idioma` ASC) ,
  CONSTRAINT `fk_Pais_RegionGeografica`
    FOREIGN KEY (`RegionGeografica_P` )
    REFERENCES `Spuria`.`RegionGeografica` (`RegionGeograficaID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pais_Continente`
    FOREIGN KEY (`Continente` )
    REFERENCES `Spuria`.`Continente` (`ContinenteID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pais_Ciudad`
    FOREIGN KEY (`Capital` )
    REFERENCES `Spuria`.`Ciudad` (`CiudadID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pais_Idioma`
    FOREIGN KEY (`Idioma` )
    REFERENCES `Spuria`.`Idioma` (`Idioma` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`HusoHorario`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`HusoHorario` (
  `HusoHorario` TIME NOT NULL ,
  PRIMARY KEY (`HusoHorario`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`Estado`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`Estado` (
  `RegionGeografica_P` INT NOT NULL ,
  `EstadoID` INT NOT NULL AUTO_INCREMENT ,
  `Pais` INT NOT NULL ,
  `HusoHorarioNormal` TIME NOT NULL ,
  `HusoHorarioVerano` TIME NULL ,
  PRIMARY KEY (`EstadoID`) ,
  INDEX `fk_Estado_Pais` (`Pais` ASC) ,
  INDEX `fk_Estado_RegionGeografica` (`RegionGeografica_P` ASC) ,
  INDEX `fk_Estado_HusoHorario1` (`HusoHorarioNormal` ASC) ,
  INDEX `fk_Estado_HusoHorario2` (`HusoHorarioVerano` ASC) ,
  UNIQUE INDEX `RegionGeografica_P_UNIQUE` (`RegionGeografica_P` ASC) ,
  CONSTRAINT `fk_Estado_Pais`
    FOREIGN KEY (`Pais` )
    REFERENCES `Spuria`.`Pais` (`PaisID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Estado_RegionGeografica`
    FOREIGN KEY (`RegionGeografica_P` )
    REFERENCES `Spuria`.`RegionGeografica` (`RegionGeograficaID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Estado_HusoHorario1`
    FOREIGN KEY (`HusoHorarioNormal` )
    REFERENCES `Spuria`.`HusoHorario` (`HusoHorario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Estado_HusoHorario2`
    FOREIGN KEY (`HusoHorarioVerano` )
    REFERENCES `Spuria`.`HusoHorario` (`HusoHorario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`Municipio`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`Municipio` (
  `RegionGeografica_P` INT NOT NULL ,
  `MunicipioID` INT NOT NULL AUTO_INCREMENT ,
  `Estado` INT NOT NULL ,
  `Ciudad` INT NULL ,
  PRIMARY KEY (`MunicipioID`) ,
  INDEX `fk_Municipio_RegionGeografica` (`RegionGeografica_P` ASC) ,
  INDEX `fk_Municipio_Estado` (`Estado` ASC) ,
  INDEX `fk_Municipio_Ciudad` (`Ciudad` ASC) ,
  UNIQUE INDEX `RegionGeografica_P_UNIQUE` (`RegionGeografica_P` ASC) ,
  CONSTRAINT `fk_Municipio_RegionGeografica`
    FOREIGN KEY (`RegionGeografica_P` )
    REFERENCES `Spuria`.`RegionGeografica` (`RegionGeograficaID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Municipio_Estado`
    FOREIGN KEY (`Estado` )
    REFERENCES `Spuria`.`Estado` (`EstadoID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Municipio_Ciudad`
    FOREIGN KEY (`Ciudad` )
    REFERENCES `Spuria`.`Ciudad` (`CiudadID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`Parroquia`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`Parroquia` (
  `RegionGeografica_P` INT NOT NULL ,
  `ParroquiaID` INT NOT NULL AUTO_INCREMENT ,
  `CodigoPostal` CHAR(10) NOT NULL ,
  `Municipio` INT NOT NULL ,
  PRIMARY KEY (`ParroquiaID`) ,
  INDEX `fk_Parroquia_RegionGeografica` (`RegionGeografica_P` ASC) ,
  INDEX `fk_Parroquia_Municipio` (`Municipio` ASC) ,
  UNIQUE INDEX `RegionGeografica_P_UNIQUE` (`RegionGeografica_P` ASC) ,
  CONSTRAINT `fk_Parroquia_RegionGeografica`
    FOREIGN KEY (`RegionGeografica_P` )
    REFERENCES `Spuria`.`RegionGeografica` (`RegionGeograficaID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Parroquia_Municipio`
    FOREIGN KEY (`Municipio` )
    REFERENCES `Spuria`.`Municipio` (`MunicipioID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`Usuario`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`Usuario` (
  `UsuarioID` INT NOT NULL AUTO_INCREMENT ,
  `Parroquia` INT NULL ,
  PRIMARY KEY (`UsuarioID`) ,
  INDEX `fk_Usuario_Parroquia` (`Parroquia` ASC) ,
  CONSTRAINT `fk_Usuario_Parroquia`
    FOREIGN KEY (`Parroquia` )
    REFERENCES `Spuria`.`Parroquia` (`ParroquiaID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`Describible`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`Describible` (
  `DescribibleID` INT NOT NULL AUTO_INCREMENT ,
  PRIMARY KEY (`DescribibleID`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`Estatus`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`Estatus` (
  `Estatus` CHAR(9) NOT NULL ,
  PRIMARY KEY (`Estatus`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`Cliente`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`Cliente` (
  `Rastreable_P` INT NOT NULL ,
  `Describible_P` INT NOT NULL ,
  `Usuario_P` INT NOT NULL ,
  `RIF` CHAR(10) NOT NULL ,
  `Categoria` INT NOT NULL ,
  `Estatus` CHAR(9) NOT NULL ,
  `NombreLegal` VARCHAR(45) NOT NULL ,
  `NombreComun` VARCHAR(45) NULL ,
  `Telefono` CHAR(12) NOT NULL ,
  `Edificio_CC` CHAR(20) NULL ,
  `Piso` CHAR(12) NULL ,
  `Apartamento` CHAR(12) NULL ,
  `LocalNo` CHAR(12) NULL ,
  `Casa` CHAR(20) NULL ,
  `Calle` CHAR(12) NOT NULL ,
  `Sector_Urb_Barrio` CHAR(20) NOT NULL ,
  `PaginaWeb` CHAR(40) NULL ,
  `Facebook` CHAR(80) NULL ,
  `Twitter` CHAR(80) NULL ,
  PRIMARY KEY (`RIF`) ,
  INDEX `fk_Cliente_Categoria` (`Categoria` ASC) ,
  INDEX `fk_Cliente_Usuario` (`Usuario_P` ASC) ,
  INDEX `fk_Cliente_Describible` (`Describible_P` ASC) ,
  INDEX `fk_Cliente_Estatus` (`Estatus` ASC) ,
  INDEX `fk_Cliente_Rastreable` (`Rastreable_P` ASC) ,
  UNIQUE INDEX `Facebook_UNIQUE` (`Facebook` ASC) ,
  UNIQUE INDEX `Twitter_UNIQUE` (`Twitter` ASC) ,
  UNIQUE INDEX `PaginaWeb_UNIQUE` (`PaginaWeb` ASC) ,
  UNIQUE INDEX `Telefono_UNIQUE` (`Telefono` ASC) ,
  UNIQUE INDEX `Usuario_P_UNIQUE` (`Usuario_P` ASC) ,
  UNIQUE INDEX `Describible_P_UNIQUE` (`Describible_P` ASC) ,
  UNIQUE INDEX `Rastreable_P_UNIQUE` (`Rastreable_P` ASC) ,
  UNIQUE INDEX `NombreLegal_UNIQUE` (`NombreLegal` ASC) ,
  CONSTRAINT `fk_Cliente_Categoría`
    FOREIGN KEY (`Categoria` )
    REFERENCES `Spuria`.`Categoria` (`CategoriaID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cliente_Usuario`
    FOREIGN KEY (`Usuario_P` )
    REFERENCES `Spuria`.`Usuario` (`UsuarioID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cliente_Describible`
    FOREIGN KEY (`Describible_P` )
    REFERENCES `Spuria`.`Describible` (`DescribibleID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cliente_Estatus`
    FOREIGN KEY (`Estatus` )
    REFERENCES `Spuria`.`Estatus` (`Estatus` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cliente_Rastreable`
    FOREIGN KEY (`Rastreable_P` )
    REFERENCES `Spuria`.`Rastreable` (`RastreableID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`Buscable`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`Buscable` (
  `BuscableID` INT NOT NULL AUTO_INCREMENT ,
  PRIMARY KEY (`BuscableID`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`Tienda`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`Tienda` (
  `Buscable_P` INT NOT NULL ,
  `Cliente_P` CHAR(10) NOT NULL ,
  `CalificableSeguible_P` INT NOT NULL ,
  `Interlocutor_P` INT NOT NULL ,
  `Dibujable_P` INT NOT NULL ,
  `TiendaID` INT NOT NULL AUTO_INCREMENT ,
  `Abierto` TINYINT(1)  NOT NULL ,
  PRIMARY KEY (`TiendaID`) ,
  INDEX `fk_Tienda_Interlocutor` (`Interlocutor_P` ASC) ,
  INDEX `fk_Tienda_CalificableSeguible` (`CalificableSeguible_P` ASC) ,
  INDEX `fk_Tienda_Cliente` (`Cliente_P` ASC) ,
  INDEX `fk_Tienda_Dibujable` (`Dibujable_P` ASC) ,
  INDEX `fk_Tienda_Buscable` (`Buscable_P` ASC) ,
  UNIQUE INDEX `Buscable_P_UNIQUE` (`Buscable_P` ASC) ,
  UNIQUE INDEX `Cliente_P_UNIQUE` (`Cliente_P` ASC) ,
  UNIQUE INDEX `Calificable/Seguible_P_UNIQUE` (`CalificableSeguible_P` ASC) ,
  UNIQUE INDEX `Interlocutor_P_UNIQUE` (`Interlocutor_P` ASC) ,
  UNIQUE INDEX `Dibujable_P_UNIQUE` (`Dibujable_P` ASC) ,
  CONSTRAINT `fk_Tienda_Interlocutor`
    FOREIGN KEY (`Interlocutor_P` )
    REFERENCES `Spuria`.`Interlocutor` (`InterlocutorID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Tienda_CalificableSeguible`
    FOREIGN KEY (`CalificableSeguible_P` )
    REFERENCES `Spuria`.`CalificableSeguible` (`CalificableSeguibleID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Tienda_Cliente`
    FOREIGN KEY (`Cliente_P` )
    REFERENCES `Spuria`.`Cliente` (`RIF` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Tienda_Dibujable`
    FOREIGN KEY (`Dibujable_P` )
    REFERENCES `Spuria`.`Dibujable` (`DibujableID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Tienda_Buscable`
    FOREIGN KEY (`Buscable_P` )
    REFERENCES `Spuria`.`Buscable` (`BuscableID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`TipoDeCodigoUniversal`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`TipoDeCodigoUniversal` (
  `TipoDeCodigoUniversal` CHAR(7) NOT NULL ,
  PRIMARY KEY (`TipoDeCodigoUniversal`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`Producto`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`Producto` (
  `Rastreable_P` INT NOT NULL ,
  `Describible_P` INT NOT NULL ,
  `Buscable_P` INT NOT NULL ,
  `CalificableSeguible_P` INT NOT NULL ,
  `ProductoID` INT NOT NULL AUTO_INCREMENT ,
  `TipoDeCodigoUniversal` CHAR(7) NOT NULL ,
  `CodigoUniversal` CHAR(15) NOT NULL ,
  `Estatus` CHAR(9) NOT NULL ,
  `Fabricante` VARCHAR(45) NOT NULL ,
  `Modelo` VARCHAR(45) NULL ,
  `Nombre` VARCHAR(45) NOT NULL ,
  `Categoria` INT NOT NULL ,
  `DebutEnElMercado` DATE NULL ,
  `Largo` FLOAT NULL ,
  `Ancho` FLOAT NULL ,
  `Alto` FLOAT NULL ,
  `Peso` FLOAT NULL ,
  `PaisDeOrigen` INT NULL ,
  PRIMARY KEY (`ProductoID`) ,
  INDEX `fk_Producto_Categoria` (`Categoria` ASC) ,
  INDEX `fk_Producto_Estatus` (`Estatus` ASC) ,
  INDEX `fk_Producto_Pais` (`PaisDeOrigen` ASC) ,
  INDEX `fk_Producto_CalificableSeguible` (`CalificableSeguible_P` ASC) ,
  INDEX `fk_Producto_Describible` (`Describible_P` ASC) ,
  INDEX `fk_Producto_Rastreable` (`Rastreable_P` ASC) ,
  INDEX `fk_Producto_Buscable` (`Buscable_P` ASC) ,
  UNIQUE INDEX `UPC/Otro_UNIQUE` (`CodigoUniversal` ASC) ,
  UNIQUE INDEX `Rastreable_P_UNIQUE` (`Rastreable_P` ASC) ,
  UNIQUE INDEX `Describible_P_UNIQUE` (`Describible_P` ASC) ,
  UNIQUE INDEX `Buscable_P_UNIQUE` (`Buscable_P` ASC) ,
  UNIQUE INDEX `Calificable/Seguible_P_UNIQUE` (`CalificableSeguible_P` ASC) ,
  INDEX `fk_Producto_TipoDeCodigoUniversal` (`TipoDeCodigoUniversal` ASC) ,
  CONSTRAINT `fk_Producto_Categoría`
    FOREIGN KEY (`Categoria` )
    REFERENCES `Spuria`.`Categoria` (`CategoriaID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Producto_Estatus`
    FOREIGN KEY (`Estatus` )
    REFERENCES `Spuria`.`Estatus` (`Estatus` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Producto_Pais`
    FOREIGN KEY (`PaisDeOrigen` )
    REFERENCES `Spuria`.`Pais` (`PaisID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Producto_CalificableSeguible`
    FOREIGN KEY (`CalificableSeguible_P` )
    REFERENCES `Spuria`.`CalificableSeguible` (`CalificableSeguibleID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Producto_Describible`
    FOREIGN KEY (`Describible_P` )
    REFERENCES `Spuria`.`Describible` (`DescribibleID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Producto_Rastreable`
    FOREIGN KEY (`Rastreable_P` )
    REFERENCES `Spuria`.`Rastreable` (`RastreableID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Producto_Buscable`
    FOREIGN KEY (`Buscable_P` )
    REFERENCES `Spuria`.`Buscable` (`BuscableID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Producto_TipoDeCodigoUniversal`
    FOREIGN KEY (`TipoDeCodigoUniversal` )
    REFERENCES `Spuria`.`TipoDeCodigoUniversal` (`TipoDeCodigoUniversal` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`Visibilidad`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`Visibilidad` (
  `Visibilidad` CHAR(16) NOT NULL ,
  PRIMARY KEY (`Visibilidad`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`Cobrable`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`Cobrable` (
  `CobrableID` INT NOT NULL AUTO_INCREMENT ,
  PRIMARY KEY (`CobrableID`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`Inventario`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`Inventario` (
  `Rastreable_P` INT NOT NULL ,
  `Cobrable_P` INT NOT NULL ,
  `TiendaID` INT NOT NULL ,
  `ProductoID` INT NOT NULL ,
  `Visibilidad` CHAR(16) NOT NULL ,
  `SKU` CHAR(15) NULL ,
  PRIMARY KEY (`TiendaID`, `ProductoID`) ,
  INDEX `fk_Inventario_Producto` (`ProductoID` ASC) ,
  INDEX `fk_Inventario_Tienda` (`TiendaID` ASC) ,
  INDEX `fk_Inventario_Visibilidad` (`Visibilidad` ASC) ,
  INDEX `fk_Inventario_Rastreable` (`Rastreable_P` ASC) ,
  UNIQUE INDEX `Rastreable_P_UNIQUE` (`Rastreable_P` ASC) ,
  INDEX `fk_Inventario_Cobrable1` (`Cobrable_P` ASC) ,
  UNIQUE INDEX `Cobrable_P_UNIQUE` (`Cobrable_P` ASC) ,
  CONSTRAINT `fk_Inventario_Tienda`
    FOREIGN KEY (`TiendaID` )
    REFERENCES `Spuria`.`Tienda` (`TiendaID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Inventario_Producto`
    FOREIGN KEY (`ProductoID` )
    REFERENCES `Spuria`.`Producto` (`ProductoID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Inventario_Visibilidad`
    FOREIGN KEY (`Visibilidad` )
    REFERENCES `Spuria`.`Visibilidad` (`Visibilidad` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Inventario_Rastreable`
    FOREIGN KEY (`Rastreable_P` )
    REFERENCES `Spuria`.`Rastreable` (`RastreableID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Inventario_Cobrable1`
    FOREIGN KEY (`Cobrable_P` )
    REFERENCES `Spuria`.`Cobrable` (`CobrableID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`Mensaje`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`Mensaje` (
  `Rastreable_P` INT NOT NULL ,
  `Etiquetable_P` INT NOT NULL ,
  `MensajeID` INT NOT NULL AUTO_INCREMENT ,
  `Remitente` INT NOT NULL ,
  `Destinatario` INT NOT NULL ,
  `Contenido` TEXT NOT NULL ,
  PRIMARY KEY (`MensajeID`) ,
  INDEX `fk_Mensaje_Etiquetable` (`Etiquetable_P` ASC) ,
  INDEX `fk_Mensaje_Interlocutor1` (`Remitente` ASC) ,
  INDEX `fk_Mensaje_Interlocutor2` (`Destinatario` ASC) ,
  INDEX `fk_Mensaje_Rastreable` (`Rastreable_P` ASC) ,
  UNIQUE INDEX `Etiquetable_P_UNIQUE` (`Etiquetable_P` ASC) ,
  UNIQUE INDEX `Rastreable_P_UNIQUE` (`Rastreable_P` ASC) ,
  CONSTRAINT `fk_Mensaje_Etiquetable`
    FOREIGN KEY (`Etiquetable_P` )
    REFERENCES `Spuria`.`Etiquetable` (`EtiquetableID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Mensaje_Interlocutor1`
    FOREIGN KEY (`Remitente` )
    REFERENCES `Spuria`.`Interlocutor` (`InterlocutorID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Mensaje_Interlocutor2`
    FOREIGN KEY (`Destinatario` )
    REFERENCES `Spuria`.`Interlocutor` (`InterlocutorID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Mensaje_Rastreable`
    FOREIGN KEY (`Rastreable_P` )
    REFERENCES `Spuria`.`Rastreable` (`RastreableID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`Sexo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`Sexo` (
  `Sexo` CHAR(6) NOT NULL ,
  PRIMARY KEY (`Sexo`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`GradoDeInstruccion`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`GradoDeInstruccion` (
  `GradoDeInstruccion` CHAR(16) NOT NULL ,
  PRIMARY KEY (`GradoDeInstruccion`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`GrupoDeEdad`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`GrupoDeEdad` (
  `GrupoDeEdad` CHAR(15) NOT NULL ,
  PRIMARY KEY (`GrupoDeEdad`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`Consumidor`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`Consumidor` (
  `Rastreable_P` INT NOT NULL ,
  `Interlocutor_P` INT NOT NULL ,
  `Usuario_P` INT NOT NULL ,
  `ConsumidorID` INT NOT NULL AUTO_INCREMENT ,
  `Nombre` VARCHAR(45) NOT NULL ,
  `Apellido` VARCHAR(45) NOT NULL ,
  `Estatus` CHAR(9) NOT NULL ,
  `Sexo` CHAR(6) NOT NULL ,
  `FechaDeNacimiento` DATE NOT NULL ,
  `GrupoDeEdad` CHAR(15) NOT NULL ,
  `GradoDeInstruccion` CHAR(16) NOT NULL ,
  PRIMARY KEY (`ConsumidorID`) ,
  INDEX `fk_Consumidor_Interlocutor` (`Interlocutor_P` ASC) ,
  INDEX `fk_Consumidor_Usuario` (`Usuario_P` ASC) ,
  INDEX `fk_Consumidor_Estatus` (`Estatus` ASC) ,
  INDEX `fk_Consumidor_Sexo` (`Sexo` ASC) ,
  INDEX `fk_Consumidor_GradoDeInstruccion` (`GradoDeInstruccion` ASC) ,
  INDEX `fk_Consumidor_GrupoDeEdad` (`GrupoDeEdad` ASC) ,
  INDEX `fk_Consumidor_Rastreable` (`Rastreable_P` ASC) ,
  UNIQUE INDEX `Interlocutor_P_UNIQUE` (`Interlocutor_P` ASC) ,
  UNIQUE INDEX `Rastreable_P_UNIQUE` (`Rastreable_P` ASC) ,
  UNIQUE INDEX `Usuario_P_UNIQUE` (`Usuario_P` ASC) ,
  CONSTRAINT `fk_Consumidor_Interlocutor`
    FOREIGN KEY (`Interlocutor_P` )
    REFERENCES `Spuria`.`Interlocutor` (`InterlocutorID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Consumidor_Usuario`
    FOREIGN KEY (`Usuario_P` )
    REFERENCES `Spuria`.`Usuario` (`UsuarioID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Consumidor_Estatus`
    FOREIGN KEY (`Estatus` )
    REFERENCES `Spuria`.`Estatus` (`Estatus` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Consumidor_Sexo`
    FOREIGN KEY (`Sexo` )
    REFERENCES `Spuria`.`Sexo` (`Sexo` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Consumidor_GradoDeInstruccion`
    FOREIGN KEY (`GradoDeInstruccion` )
    REFERENCES `Spuria`.`GradoDeInstruccion` (`GradoDeInstruccion` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Consumidor_GrupoDeEdad`
    FOREIGN KEY (`GrupoDeEdad` )
    REFERENCES `Spuria`.`GrupoDeEdad` (`GrupoDeEdad` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Consumidor_Rastreable`
    FOREIGN KEY (`Rastreable_P` )
    REFERENCES `Spuria`.`Rastreable` (`RastreableID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`Acceso`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`Acceso` (
  `AccesoID` INT NOT NULL ,
  `Conectado` TINYINT(1)  NOT NULL ,
  `CorreoElectronico` VARCHAR(45) NOT NULL ,
  `Contraseña` VARCHAR(45) NOT NULL ,
  `FechaDeRegistro` DATETIME NOT NULL ,
  `FechaDeUltimoAcceso` DATETIME NULL ,
  `DuracionDeUltimoAcceso` TIME NOT NULL ,
  `NumeroTotalDeAccesos` INT NOT NULL ,
  `TiempoTotalDeAccesos` TIME NOT NULL ,
  `TiempoPromedioPorAcceso` TIME NOT NULL ,
  PRIMARY KEY (`AccesoID`) ,
  INDEX `fk_Acceso_Usuario` (`AccesoID` ASC) ,
  UNIQUE INDEX `CorreoElectronico_UNIQUE` (`CorreoElectronico` ASC) ,
  CONSTRAINT `fk_Acceso_Usuario`
    FOREIGN KEY (`AccesoID` )
    REFERENCES `Spuria`.`Usuario` (`UsuarioID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`Busqueda`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`Busqueda` (
  `Rastreable_P` INT NOT NULL ,
  `Etiquetable_P` INT NOT NULL ,
  `BusquedaID` INT NOT NULL AUTO_INCREMENT ,
  `Usuario` INT NOT NULL ,
  `FechaHora` DATETIME NOT NULL ,
  `Contenido` TEXT NOT NULL ,
  PRIMARY KEY (`BusquedaID`) ,
  INDEX `fk_Búsqueda_Usuario` (`Usuario` ASC) ,
  INDEX `fk_Busqueda_Etiquetable` (`Etiquetable_P` ASC) ,
  INDEX `fk_Busqueda_Rastreable` (`Rastreable_P` ASC) ,
  UNIQUE INDEX `Etiquetable_P_UNIQUE` (`Etiquetable_P` ASC) ,
  UNIQUE INDEX `Rastreable_P_UNIQUE` (`Rastreable_P` ASC) ,
  CONSTRAINT `fk_Búsqueda_Usuario`
    FOREIGN KEY (`Usuario` )
    REFERENCES `Spuria`.`Usuario` (`UsuarioID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Busqueda_Etiquetable`
    FOREIGN KEY (`Etiquetable_P` )
    REFERENCES `Spuria`.`Etiquetable` (`EtiquetableID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Busqueda_Rastreable`
    FOREIGN KEY (`Rastreable_P` )
    REFERENCES `Spuria`.`Rastreable` (`RastreableID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`Palabra`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`Palabra` (
  `PalabraID` INT NOT NULL AUTO_INCREMENT ,
  `Palabra_Frase` CHAR(15) NOT NULL ,
  PRIMARY KEY (`PalabraID`) ,
  UNIQUE INDEX `Palabra/Frase_UNIQUE` (`Palabra_Frase` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`RelacionDePalabras`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`RelacionDePalabras` (
  `Palabra1ID` INT NOT NULL ,
  `Palabra2ID` INT NOT NULL ,
  PRIMARY KEY (`Palabra1ID`, `Palabra2ID`) ,
  INDEX `fk_RelacionDePalabras_Palabra2` (`Palabra2ID` ASC) ,
  INDEX `fk_RelacionDePalabras_Palabra1` (`Palabra1ID` ASC) ,
  CONSTRAINT `fk_RelacionDePalabras_Palabra1`
    FOREIGN KEY (`Palabra1ID` )
    REFERENCES `Spuria`.`Palabra` (`PalabraID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RelacionDePalabras_Palabra2`
    FOREIGN KEY (`Palabra2ID` )
    REFERENCES `Spuria`.`Palabra` (`PalabraID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`Estadisticas`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`Estadisticas` (
  `Rastreable_P` INT NOT NULL ,
  `EstadisticasID` INT NOT NULL AUTO_INCREMENT ,
  `RegionGeografica` INT NOT NULL ,
  PRIMARY KEY (`EstadisticasID`) ,
  INDEX `fk_Estadisticas_RegionGeografica` (`RegionGeografica` ASC) ,
  INDEX `fk_Estadisticas_Rastreable1` (`Rastreable_P` ASC) ,
  UNIQUE INDEX `Rastreable_P_UNIQUE` (`Rastreable_P` ASC) ,
  CONSTRAINT `fk_Estadisticas_RegionGeografica`
    FOREIGN KEY (`RegionGeografica` )
    REFERENCES `Spuria`.`RegionGeografica` (`RegionGeograficaID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Estadisticas_Rastreable1`
    FOREIGN KEY (`Rastreable_P` )
    REFERENCES `Spuria`.`Rastreable` (`RastreableID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`EstadisticasDeInfluencia`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`EstadisticasDeInfluencia` (
  `Estadisticas_P` INT NOT NULL ,
  `EstadisticasDeInfluenciaID` INT NOT NULL AUTO_INCREMENT ,
  `Palabra` INT NOT NULL ,
  `NumeroDeDescripciones` INT NOT NULL ,
  `NumeroDeMensajes` INT NOT NULL ,
  `NumeroDeCategorias` INT NOT NULL ,
  `NumeroDeResenas` INT NOT NULL ,
  `NumeroDePublicidades` INT NOT NULL ,
  PRIMARY KEY (`EstadisticasDeInfluenciaID`) ,
  INDEX `fk_EstadisticasDeInfluencia_Palabra` (`Palabra` ASC) ,
  INDEX `fk_EstadisticasDeInfluencia_Estadisticas` (`Estadisticas_P` ASC) ,
  UNIQUE INDEX `Estadisticas_P_UNIQUE` (`Estadisticas_P` ASC) ,
  CONSTRAINT `fk_EstadisticasDeInfluencia_Palabra`
    FOREIGN KEY (`Palabra` )
    REFERENCES `Spuria`.`Palabra` (`PalabraID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_EstadisticasDeInfluencia_Estadisticas`
    FOREIGN KEY (`Estadisticas_P` )
    REFERENCES `Spuria`.`Estadisticas` (`EstadisticasID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`Foto`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`Foto` (
  `FotoID` INT NOT NULL AUTO_INCREMENT ,
  `RutaDeFoto` CHAR(80) NOT NULL ,
  `Describible` INT NOT NULL ,
  PRIMARY KEY (`FotoID`) ,
  INDEX `fk_Foto_Describible` (`Describible` ASC) ,
  CONSTRAINT `fk_Foto_Describible`
    FOREIGN KEY (`Describible` )
    REFERENCES `Spuria`.`Describible` (`DescribibleID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`Calificacion`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`Calificacion` (
  `Calificacion` CHAR(4) NOT NULL ,
  PRIMARY KEY (`Calificacion`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`CalificacionResena`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`CalificacionResena` (
  `Rastreable_P` INT NOT NULL ,
  `Etiquetable_P` INT NOT NULL ,
  `CalificableSeguibleID` INT NOT NULL ,
  `ConsumidorID` INT NOT NULL ,
  `Calificacion` CHAR(4) NOT NULL ,
  `Resena` TEXT NULL ,
  INDEX `fk_CalificacionResena_Consumidor` (`ConsumidorID` ASC) ,
  INDEX `fk_CalificacionResena_CalificableSeguible` (`CalificableSeguibleID` ASC) ,
  INDEX `fk_CalificacionResena_Etiquetable` (`Etiquetable_P` ASC) ,
  INDEX `fk_CalificacionResena_Rastreable` (`Rastreable_P` ASC) ,
  PRIMARY KEY (`CalificableSeguibleID`, `ConsumidorID`) ,
  INDEX `fk_CalificacionResena_Calificacion` (`Calificacion` ASC) ,
  UNIQUE INDEX `Etiquetable_P_UNIQUE` (`Etiquetable_P` ASC) ,
  UNIQUE INDEX `Rastreable_P_UNIQUE` (`Rastreable_P` ASC) ,
  CONSTRAINT `fk_CalificacionResena_Consumidor`
    FOREIGN KEY (`ConsumidorID` )
    REFERENCES `Spuria`.`Consumidor` (`ConsumidorID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CalificacionResena_CalificableSeguible`
    FOREIGN KEY (`CalificableSeguibleID` )
    REFERENCES `Spuria`.`CalificableSeguible` (`CalificableSeguibleID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CalificacionResena_Etiquetable`
    FOREIGN KEY (`Etiquetable_P` )
    REFERENCES `Spuria`.`Etiquetable` (`EtiquetableID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CalificacionResena_Rastreable`
    FOREIGN KEY (`Rastreable_P` )
    REFERENCES `Spuria`.`Rastreable` (`RastreableID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CalificacionResena_Calificacion`
    FOREIGN KEY (`Calificacion` )
    REFERENCES `Spuria`.`Calificacion` (`Calificacion` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`Seguidor`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`Seguidor` (
  `Rastreable_P` INT NOT NULL ,
  `ConsumidorID` INT NOT NULL ,
  `CalificableSeguibleID` INT NOT NULL ,
  `AvisarSi` CHAR(40) NOT NULL ,
  PRIMARY KEY (`ConsumidorID`, `CalificableSeguibleID`) ,
  INDEX `fk_Seguidor_Calificable/Seguible` (`CalificableSeguibleID` ASC) ,
  INDEX `fk_Seguidor_Consumidor` (`ConsumidorID` ASC) ,
  INDEX `fk_Seguidor_Rastreable` (`Rastreable_P` ASC) ,
  UNIQUE INDEX `Rastreable_P_UNIQUE` (`Rastreable_P` ASC) ,
  CONSTRAINT `fk_Seguidor_Consumidor`
    FOREIGN KEY (`ConsumidorID` )
    REFERENCES `Spuria`.`Consumidor` (`ConsumidorID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Seguidor_Calificable/Seguible`
    FOREIGN KEY (`CalificableSeguibleID` )
    REFERENCES `Spuria`.`CalificableSeguible` (`CalificableSeguibleID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Seguidor_Rastreable`
    FOREIGN KEY (`Rastreable_P` )
    REFERENCES `Spuria`.`Rastreable` (`RastreableID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`EstadisticasDePopularidad`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`EstadisticasDePopularidad` (
  `Estadisticas_P` INT NOT NULL ,
  `EstadisticasDePopularidadID` INT NOT NULL AUTO_INCREMENT ,
  `CalificableSeguible` INT NOT NULL ,
  `NumeroDeCalificaciones` INT NOT NULL ,
  `NumeroDeResenas` INT NOT NULL ,
  `NumeroDeSeguidores` INT NOT NULL ,
  `NumeroDeMenciones` INT NOT NULL ,
  `NumeroDeVendedores` INT NULL ,
  `NumeroDeMensajes` INT NULL ,
  INDEX `fk_EstadisticasDePopularidad_CalificableSeguible` (`CalificableSeguible` ASC) ,
  INDEX `fk_EstadisticasDePopularidad_Estadisticas` (`Estadisticas_P` ASC) ,
  PRIMARY KEY (`EstadisticasDePopularidadID`) ,
  UNIQUE INDEX `Estadisticas_P_UNIQUE` (`Estadisticas_P` ASC) ,
  CONSTRAINT `fk_EstadisticasDePopularidad_CalificableSeguible`
    FOREIGN KEY (`CalificableSeguible` )
    REFERENCES `Spuria`.`CalificableSeguible` (`CalificableSeguibleID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_EstadisticasDePopularidad_Estadisticas`
    FOREIGN KEY (`Estadisticas_P` )
    REFERENCES `Spuria`.`Estadisticas` (`EstadisticasID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`Etiqueta`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`Etiqueta` (
  `EtiquetableID` INT NOT NULL ,
  `PalabraID` INT NOT NULL ,
  PRIMARY KEY (`EtiquetableID`, `PalabraID`) ,
  INDEX `fk_Etiqueta_Palabra` (`PalabraID` ASC) ,
  INDEX `fk_Etiqueta_Etiquetable` (`EtiquetableID` ASC) ,
  CONSTRAINT `fk_Etiqueta_Etiquetable`
    FOREIGN KEY (`EtiquetableID` )
    REFERENCES `Spuria`.`Etiquetable` (`EtiquetableID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Etiqueta_Palabra`
    FOREIGN KEY (`PalabraID` )
    REFERENCES `Spuria`.`Palabra` (`PalabraID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`Descripcion`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`Descripcion` (
  `Rastreable_P` INT NOT NULL ,
  `Etiquetable_P` INT NOT NULL ,
  `DescripcionID` INT NOT NULL AUTO_INCREMENT ,
  `Describible` INT NOT NULL ,
  `Contenido` TEXT NOT NULL ,
  PRIMARY KEY (`DescripcionID`) ,
  INDEX `fk_Descripcion_Etiquetable` (`Etiquetable_P` ASC) ,
  INDEX `fk_Descripcion_Describible` (`Describible` ASC) ,
  INDEX `fk_Descripcion_Rastreable` (`Rastreable_P` ASC) ,
  UNIQUE INDEX `Rastreable_P_UNIQUE` (`Rastreable_P` ASC) ,
  UNIQUE INDEX `Etiquetable_P_UNIQUE` (`Etiquetable_P` ASC) ,
  CONSTRAINT `fk_Descripcion_Etiquetable`
    FOREIGN KEY (`Etiquetable_P` )
    REFERENCES `Spuria`.`Etiquetable` (`EtiquetableID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Descripcion_Describible`
    FOREIGN KEY (`Describible` )
    REFERENCES `Spuria`.`Describible` (`DescribibleID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Descripcion_Rastreable`
    FOREIGN KEY (`Rastreable_P` )
    REFERENCES `Spuria`.`Rastreable` (`RastreableID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`Patrocinante`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`Patrocinante` (
  `Cliente_P` CHAR(10) NOT NULL ,
  `PatrocinanteID` INT NOT NULL AUTO_INCREMENT ,
  PRIMARY KEY (`PatrocinanteID`) ,
  INDEX `fk_Patrocinante_Cliente` (`Cliente_P` ASC) ,
  UNIQUE INDEX `Cliente_P_UNIQUE` (`Cliente_P` ASC) ,
  CONSTRAINT `fk_Patrocinante_Cliente`
    FOREIGN KEY (`Cliente_P` )
    REFERENCES `Spuria`.`Cliente` (`RIF` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`Publicidad`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`Publicidad` (
  `Buscable_P` INT NOT NULL ,
  `Describible_P` INT NOT NULL ,
  `Rastreable_P` INT NOT NULL ,
  `Etiquetable_P` INT NOT NULL ,
  `Cobrable_P` INT NOT NULL ,
  `PublicidadID` INT NOT NULL AUTO_INCREMENT ,
  `Patrocinante` INT NOT NULL ,
  `TamanoDePoblacionObjetivo` INT NULL ,
  PRIMARY KEY (`PublicidadID`) ,
  INDEX `fk_Publicidad_Etiquetable` (`Etiquetable_P` ASC) ,
  INDEX `fk_Publicidad_Describible` (`Describible_P` ASC) ,
  INDEX `fk_Publicidad_Patrocinante` (`Patrocinante` ASC) ,
  INDEX `fk_Publicidad_Buscable` (`Buscable_P` ASC) ,
  INDEX `fk_Publicidad_Cobrable` (`Cobrable_P` ASC) ,
  INDEX `fk_Publicidad_Rastreable` (`Rastreable_P` ASC) ,
  UNIQUE INDEX `Buscable_P_UNIQUE` (`Buscable_P` ASC) ,
  UNIQUE INDEX `Describible_P_UNIQUE` (`Describible_P` ASC) ,
  UNIQUE INDEX `Rastreable_P_UNIQUE` (`Rastreable_P` ASC) ,
  UNIQUE INDEX `Etiquetable_P_UNIQUE` (`Etiquetable_P` ASC) ,
  UNIQUE INDEX `Cobrable_P_UNIQUE` (`Cobrable_P` ASC) ,
  CONSTRAINT `fk_Publicidad_Etiquetable`
    FOREIGN KEY (`Etiquetable_P` )
    REFERENCES `Spuria`.`Etiquetable` (`EtiquetableID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Publicidad_Describible`
    FOREIGN KEY (`Describible_P` )
    REFERENCES `Spuria`.`Describible` (`DescribibleID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Publicidad_Patrocinante`
    FOREIGN KEY (`Patrocinante` )
    REFERENCES `Spuria`.`Patrocinante` (`PatrocinanteID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Publicidad_Buscable`
    FOREIGN KEY (`Buscable_P` )
    REFERENCES `Spuria`.`Buscable` (`BuscableID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Publicidad_Cobrable`
    FOREIGN KEY (`Cobrable_P` )
    REFERENCES `Spuria`.`Cobrable` (`CobrableID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Publicidad_Rastreable`
    FOREIGN KEY (`Rastreable_P` )
    REFERENCES `Spuria`.`Rastreable` (`RastreableID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`Accion`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`Accion` (
  `Accion` CHAR(13) NOT NULL ,
  PRIMARY KEY (`Accion`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`CodigoDeError`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`CodigoDeError` (
  `CodigoDeError` CHAR(40) NOT NULL ,
  PRIMARY KEY (`CodigoDeError`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`Registro`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`Registro` (
  `RegistroID` INT NOT NULL AUTO_INCREMENT ,
  `FechaHora` DATETIME NULL ,
  `ActorActivo` INT NOT NULL ,
  `ActorPasivo` INT NULL ,
  `Accion` CHAR(13) NOT NULL ,
  `Parametros` TEXT NULL ,
  `CodigoDeError` CHAR(10) NOT NULL ,
  PRIMARY KEY (`RegistroID`) ,
  INDEX `fk_Registro_Accion` (`Accion` ASC) ,
  INDEX `fk_Registro_CodigoDeError` (`CodigoDeError` ASC) ,
  CONSTRAINT `fk_Registro_Accion`
    FOREIGN KEY (`Accion` )
    REFERENCES `Spuria`.`Accion` (`Accion` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Registro_CodigoDeError`
    FOREIGN KEY (`CodigoDeError` )
    REFERENCES `Spuria`.`CodigoDeError` (`CodigoDeError` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`EstadisticasDeVisitas`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`EstadisticasDeVisitas` (
  `Estadisticas_P` INT NOT NULL ,
  `EstadisticasDeVisitasID` INT NOT NULL AUTO_INCREMENT ,
  `Buscable` INT NOT NULL ,
  PRIMARY KEY (`EstadisticasDeVisitasID`) ,
  INDEX `fk_EstadisticasDeVisitas_Buscable` (`Buscable` ASC) ,
  INDEX `fk_EstadisticasDeVisitas_Estadisticas` (`Estadisticas_P` ASC) ,
  UNIQUE INDEX `Estadisticas_P_UNIQUE` (`Estadisticas_P` ASC) ,
  CONSTRAINT `fk_EstadisticasDeVisitas_Buscable`
    FOREIGN KEY (`Buscable` )
    REFERENCES `Spuria`.`Buscable` (`BuscableID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_EstadisticasDeVisitas_Estadisticas`
    FOREIGN KEY (`Estadisticas_P` )
    REFERENCES `Spuria`.`Estadisticas` (`EstadisticasID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`ContadorDeExhibiciones`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`ContadorDeExhibiciones` (
  `EstadisticasDeVisitasID` INT NOT NULL ,
  `FechaInicio` DATETIME NOT NULL ,
  `FechaFin` DATETIME NULL ,
  `ContadorDeExhibiciones` INT NOT NULL ,
  PRIMARY KEY (`EstadisticasDeVisitasID`, `FechaInicio`) ,
  INDEX `fk_ContadorDeExhibiciones_EstadisticasDeVisitas` (`EstadisticasDeVisitasID` ASC) ,
  UNIQUE INDEX `FechaFin_UNIQUE` (`FechaFin` ASC) ,
  CONSTRAINT `fk_ContadorDeExhibiciones_EstadisticasDeVisitas`
    FOREIGN KEY (`EstadisticasDeVisitasID` )
    REFERENCES `Spuria`.`EstadisticasDeVisitas` (`EstadisticasDeVisitasID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`Tamano`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`Tamano` (
  `TiendaID` INT NOT NULL ,
  `FechaInicio` DATETIME NOT NULL ,
  `FechaFin` DATETIME NULL ,
  `NumeroTotalDeProductos` INT NOT NULL ,
  `CantidadTotalDeProductos` INT NULL ,
  `Tamano` INT NULL ,
  PRIMARY KEY (`TiendaID`, `FechaInicio`) ,
  INDEX `fk_Tamano_Tienda` (`TiendaID` ASC) ,
  UNIQUE INDEX `FechaFin_UNIQUE` (`FechaFin` ASC) ,
  CONSTRAINT `fk_Tamano_Tienda`
    FOREIGN KEY (`TiendaID` )
    REFERENCES `Spuria`.`Tienda` (`TiendaID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`Dia`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`Dia` (
  `Dia` CHAR(9) NOT NULL ,
  PRIMARY KEY (`Dia`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`HorarioDeTrabajo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`HorarioDeTrabajo` (
  `TiendaID` INT NOT NULL ,
  `Dia` CHAR(9) NOT NULL ,
  `Laborable` TINYINT(1)  NOT NULL ,
  PRIMARY KEY (`TiendaID`, `Dia`) ,
  INDEX `fk_HorarioDeTrabajo_Dia` (`Dia` ASC) ,
  INDEX `fk_HorarioDeTrabajo_Tienda` (`TiendaID` ASC) ,
  CONSTRAINT `fk_HorarioDeTrabajo_Tienda`
    FOREIGN KEY (`TiendaID` )
    REFERENCES `Spuria`.`Tienda` (`TiendaID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_HorarioDeTrabajo_Dia`
    FOREIGN KEY (`Dia` )
    REFERENCES `Spuria`.`Dia` (`Dia` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`Turno`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`Turno` (
  `TiendaID` INT NOT NULL ,
  `Dia` CHAR(9) NOT NULL ,
  `HoraDeApertura` TIME NOT NULL ,
  `HoraDeCierre` TIME NOT NULL ,
  INDEX `fk_Turno_HorarioDeTrabajo` (`TiendaID` ASC, `Dia` ASC) ,
  PRIMARY KEY (`TiendaID`, `Dia`, `HoraDeApertura`) ,
  CONSTRAINT `fk_Turno_HorarioDeTrabajo`
    FOREIGN KEY (`TiendaID` , `Dia` )
    REFERENCES `Spuria`.`HorarioDeTrabajo` (`TiendaID` , `Dia` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`GradoDeInstruccionObjetivo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`GradoDeInstruccionObjetivo` (
  `PublicidadID` INT NOT NULL ,
  `GradoDeInstruccion` CHAR(16) NOT NULL ,
  PRIMARY KEY (`PublicidadID`, `GradoDeInstruccion`) ,
  INDEX `fk_GradoDeInstruccionObjetivo_GradoDeInstruccion` (`GradoDeInstruccion` ASC) ,
  INDEX `fk_GradoDeInstruccionObjetivo_Publicidad` (`PublicidadID` ASC) ,
  CONSTRAINT `fk_GradoDeInstruccionObjetivo_Publicidad`
    FOREIGN KEY (`PublicidadID` )
    REFERENCES `Spuria`.`Publicidad` (`PublicidadID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_GradoDeInstruccionObjetivo_GradoDeInstruccion`
    FOREIGN KEY (`GradoDeInstruccion` )
    REFERENCES `Spuria`.`GradoDeInstruccion` (`GradoDeInstruccion` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`SexoObjetivo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`SexoObjetivo` (
  `PublicidadID` INT NOT NULL ,
  `Sexo` CHAR(6) NOT NULL ,
  PRIMARY KEY (`PublicidadID`, `Sexo`) ,
  INDEX `fk_SexoObjetivo_Sexo` (`Sexo` ASC) ,
  INDEX `fk_SexoObjetivo_Publicidad` (`PublicidadID` ASC) ,
  CONSTRAINT `fk_SexoObjetivo_Publicidad`
    FOREIGN KEY (`PublicidadID` )
    REFERENCES `Spuria`.`Publicidad` (`PublicidadID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SexoObjetivo_Sexo`
    FOREIGN KEY (`Sexo` )
    REFERENCES `Spuria`.`Sexo` (`Sexo` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`GrupoDeEdadObjetivo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`GrupoDeEdadObjetivo` (
  `PublicidadID` INT NOT NULL ,
  `GrupoDeEdad` CHAR(15) NOT NULL ,
  PRIMARY KEY (`PublicidadID`, `GrupoDeEdad`) ,
  INDEX `fk_GrupoDeEdadObjetivo_GrupoDeEdad` (`GrupoDeEdad` ASC) ,
  INDEX `fk_GrupoDeEdadObjetivo_Publicidad` (`PublicidadID` ASC) ,
  CONSTRAINT `fk_GrupoDeEdadObjetivo_Publicidad`
    FOREIGN KEY (`PublicidadID` )
    REFERENCES `Spuria`.`Publicidad` (`PublicidadID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_GrupoDeEdadObjetivo_GrupoDeEdad`
    FOREIGN KEY (`GrupoDeEdad` )
    REFERENCES `Spuria`.`GrupoDeEdad` (`GrupoDeEdad` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`RegionGeograficaObjetivo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`RegionGeograficaObjetivo` (
  `PublicidadID` INT NOT NULL ,
  `RegionGeograficaID` INT NOT NULL ,
  PRIMARY KEY (`PublicidadID`, `RegionGeograficaID`) ,
  INDEX `fk_RegionGeograficaObjetivo_RegionGeografica` (`RegionGeograficaID` ASC) ,
  INDEX `fk_RegionGeograficaObjetivo_Publicidad` (`PublicidadID` ASC) ,
  CONSTRAINT `fk_RegionGeograficaObjetivo_Publicidad`
    FOREIGN KEY (`PublicidadID` )
    REFERENCES `Spuria`.`Publicidad` (`PublicidadID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RegionGeograficaObjetivo_RegionGeografica`
    FOREIGN KEY (`RegionGeograficaID` )
    REFERENCES `Spuria`.`RegionGeografica` (`RegionGeograficaID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`ConsumidorObjetivo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`ConsumidorObjetivo` (
  `PublicidadID` INT NOT NULL ,
  `ConsumidorID` INT NOT NULL ,
  PRIMARY KEY (`PublicidadID`, `ConsumidorID`) ,
  INDEX `fk_ConsumidorObjetivo_Consumidor` (`ConsumidorID` ASC) ,
  INDEX `fk_ConsumidorObjetivo_Publicidad` (`PublicidadID` ASC) ,
  CONSTRAINT `fk_ConsumidorObjetivo_Publicidad`
    FOREIGN KEY (`PublicidadID` )
    REFERENCES `Spuria`.`Publicidad` (`PublicidadID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ConsumidorObjetivo_Consumidor`
    FOREIGN KEY (`ConsumidorID` )
    REFERENCES `Spuria`.`Consumidor` (`ConsumidorID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`Croquis`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`Croquis` (
  `Rastreable_P` INT NOT NULL ,
  `CroquisID` INT NOT NULL ,
  `Area` FLOAT NULL ,
  `Perimetro` FLOAT NULL ,
  PRIMARY KEY (`CroquisID`) ,
  INDEX `fk_Croquis_Dibujable` (`CroquisID` ASC) ,
  INDEX `fk_Croquis_Rastreable` (`Rastreable_P` ASC) ,
  UNIQUE INDEX `Rastreable_P_UNIQUE` (`Rastreable_P` ASC) ,
  CONSTRAINT `fk_Croquis_Dibujable`
    FOREIGN KEY (`CroquisID` )
    REFERENCES `Spuria`.`Dibujable` (`DibujableID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Croquis_Rastreable`
    FOREIGN KEY (`Rastreable_P` )
    REFERENCES `Spuria`.`Rastreable` (`RastreableID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`Punto`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`Punto` (
  `PuntoID` INT NOT NULL AUTO_INCREMENT ,
  `Latitud` DECIMAL(9,6) NOT NULL ,
  `Longitud` DECIMAL(9,6) NOT NULL ,
  PRIMARY KEY (`PuntoID`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`PuntoDeCroquis`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`PuntoDeCroquis` (
  `CroquisID` INT NOT NULL ,
  `PuntoID` INT NOT NULL ,
  PRIMARY KEY (`CroquisID`, `PuntoID`) ,
  INDEX `fk_PuntoDeCroquis_Punto` (`PuntoID` ASC) ,
  INDEX `fk_PuntoDeCroquis_Croquis` (`CroquisID` ASC) ,
  CONSTRAINT `fk_PuntoDeCroquis_Punto`
    FOREIGN KEY (`PuntoID` )
    REFERENCES `Spuria`.`Punto` (`PuntoID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PuntoDeCroquis_Croquis`
    FOREIGN KEY (`CroquisID` )
    REFERENCES `Spuria`.`Croquis` (`CroquisID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`Factura`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`Factura` (
  `Rastreable_P` INT NOT NULL ,
  `FacturaID` INT NOT NULL AUTO_INCREMENT ,
  `Cliente` CHAR(10) NOT NULL ,
  `InicioDeMedicion` DATETIME NOT NULL ,
  `FinDeMedicion` DATETIME NOT NULL ,
  `Subtotal` DECIMAL NOT NULL ,
  `Impuestos` DECIMAL NOT NULL ,
  `Total` DECIMAL NOT NULL ,
  PRIMARY KEY (`FacturaID`) ,
  INDEX `fk_Factura_Cliente` (`Cliente` ASC) ,
  INDEX `fk_Factura_Rastreable` (`Rastreable_P` ASC) ,
  UNIQUE INDEX `Rastreable_P_UNIQUE` (`Rastreable_P` ASC) ,
  CONSTRAINT `fk_Factura_Cliente`
    FOREIGN KEY (`Cliente` )
    REFERENCES `Spuria`.`Cliente` (`RIF` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Factura_Rastreable`
    FOREIGN KEY (`Rastreable_P` )
    REFERENCES `Spuria`.`Rastreable` (`RastreableID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`ServicioVendido`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`ServicioVendido` (
  `FacturaID` INT NOT NULL ,
  `CobrableID` INT NOT NULL ,
  `Acumulado` DECIMAL NOT NULL ,
  PRIMARY KEY (`FacturaID`, `CobrableID`) ,
  INDEX `fk_ServicioVendido_Cobrable` (`CobrableID` ASC) ,
  INDEX `fk_ServicioVendido_Factura` (`FacturaID` ASC) ,
  CONSTRAINT `fk_ServicioVendido_Cobrable`
    FOREIGN KEY (`CobrableID` )
    REFERENCES `Spuria`.`Cobrable` (`CobrableID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ServicioVendido_Factura`
    FOREIGN KEY (`FacturaID` )
    REFERENCES `Spuria`.`Factura` (`FacturaID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`Subcontinente`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`Subcontinente` (
  `RegionGeografica_P` INT NOT NULL ,
  `SubcontinenteID` INT NOT NULL AUTO_INCREMENT ,
  `Continente` INT NOT NULL ,
  PRIMARY KEY (`SubcontinenteID`) ,
  INDEX `fk_Subcontinente_Continente` (`Continente` ASC) ,
  INDEX `fk_Subcontinente_RegionGeografica` (`RegionGeografica_P` ASC) ,
  UNIQUE INDEX `RegionGeografica_P_UNIQUE` (`RegionGeografica_P` ASC) ,
  CONSTRAINT `fk_Subcontinente_Continente`
    FOREIGN KEY (`Continente` )
    REFERENCES `Spuria`.`Continente` (`ContinenteID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Subcontinente_RegionGeografica`
    FOREIGN KEY (`RegionGeografica_P` )
    REFERENCES `Spuria`.`RegionGeografica` (`RegionGeograficaID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`PaisSubcontinente`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`PaisSubcontinente` (
  `SubcontinenteID` INT NOT NULL ,
  `PaisID` INT NOT NULL ,
  PRIMARY KEY (`SubcontinenteID`, `PaisID`) ,
  INDEX `fk_PaisSubcontinente_Pais` (`PaisID` ASC) ,
  INDEX `fk_PaisSubcontinente_Subcontinente` (`SubcontinenteID` ASC) ,
  CONSTRAINT `fk_PaisSubcontinente_Subcontinente`
    FOREIGN KEY (`SubcontinenteID` )
    REFERENCES `Spuria`.`Subcontinente` (`SubcontinenteID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PaisSubcontinente_Pais`
    FOREIGN KEY (`PaisID` )
    REFERENCES `Spuria`.`Pais` (`PaisID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`Privilegios`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`Privilegios` (
  `Privilegios` CHAR(7) NOT NULL ,
  PRIMARY KEY (`Privilegios`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`Administrador`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`Administrador` (
  `Rastreable_P` INT NOT NULL ,
  `Usuario_P` INT NOT NULL ,
  `AdministradorID` INT NOT NULL AUTO_INCREMENT ,
  `Estatus` CHAR(9) NOT NULL ,
  `Privilegios` CHAR(7) NOT NULL ,
  `Nombre` VARCHAR(45) NOT NULL ,
  `Apellido` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`AdministradorID`) ,
  INDEX `fk_Administrador_Estatus` (`Estatus` ASC) ,
  INDEX `fk_Administrador_Usuario` (`Usuario_P` ASC) ,
  INDEX `fk_Administrador_Rastreable` (`Rastreable_P` ASC) ,
  INDEX `fk_Administrador_Privilegios` (`Privilegios` ASC) ,
  UNIQUE INDEX `Usuario_P_UNIQUE` (`Usuario_P` ASC) ,
  UNIQUE INDEX `Rastreable_P_UNIQUE` (`Rastreable_P` ASC) ,
  CONSTRAINT `fk_Administrador_Estatus`
    FOREIGN KEY (`Estatus` )
    REFERENCES `Spuria`.`Estatus` (`Estatus` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Administrador_Usuario`
    FOREIGN KEY (`Usuario_P` )
    REFERENCES `Spuria`.`Usuario` (`UsuarioID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Administrador_Rastreable`
    FOREIGN KEY (`Rastreable_P` )
    REFERENCES `Spuria`.`Rastreable` (`RastreableID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Administrador_Privilegios`
    FOREIGN KEY (`Privilegios` )
    REFERENCES `Spuria`.`Privilegios` (`Privilegios` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`ResultadoDeBusqueda`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`ResultadoDeBusqueda` (
  `BusquedaID` INT NOT NULL ,
  `BuscableID` INT NOT NULL ,
  `Visitado` TINYINT(1)  NOT NULL ,
  `Relevancia` FLOAT NOT NULL ,
  PRIMARY KEY (`BusquedaID`, `BuscableID`) ,
  INDEX `fk_ResultadoDeBusqueda_Busqueda` (`BusquedaID` ASC) ,
  INDEX `fk_ResultadoDeBusqueda_Buscable` (`BuscableID` ASC) ,
  CONSTRAINT `fk_ResultadoDeBusqueda_Buscable`
    FOREIGN KEY (`BuscableID` )
    REFERENCES `Spuria`.`Buscable` (`BuscableID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ResultadoDeBusqueda_Busqueda`
    FOREIGN KEY (`BusquedaID` )
    REFERENCES `Spuria`.`Busqueda` (`BusquedaID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`EstadisticasTemporales`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`EstadisticasTemporales` (
  `EstadisticasID` INT NOT NULL ,
  `FechaInicio` DATETIME NOT NULL ,
  `FechaFin` DATETIME NULL ,
  `Contador` INT NOT NULL ,
  `Ranking` INT NOT NULL ,
  `Indice` INT NOT NULL ,
  INDEX `fk_EstadisticasTemporales_Estadisticas` (`EstadisticasID` ASC) ,
  PRIMARY KEY (`EstadisticasID`, `FechaInicio`) ,
  CONSTRAINT `fk_EstadisticasTemporales_Estadisticas`
    FOREIGN KEY (`EstadisticasID` )
    REFERENCES `Spuria`.`Estadisticas` (`EstadisticasID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`PrecioCantidad`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`PrecioCantidad` (
  `TiendaID` INT NOT NULL ,
  `ProductoID` INT NOT NULL ,
  `FechaInicio` DATETIME NOT NULL ,
  `FechaFin` DATETIME NULL ,
  `Precio` DECIMAL(10,2) NOT NULL ,
  `Cantidad` INT NOT NULL ,
  PRIMARY KEY (`TiendaID`, `ProductoID`, `FechaInicio`) ,
  INDEX `fk_PrecioCantidad_Inventario` (`TiendaID` ASC, `ProductoID` ASC) ,
  CONSTRAINT `fk_PrecioCantidad_Inventario`
    FOREIGN KEY (`TiendaID` , `ProductoID` )
    REFERENCES `Spuria`.`Inventario` (`TiendaID` , `ProductoID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spuria`.`TiendasConsumidores`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Spuria`.`TiendasConsumidores` (
  `RegionGeograficaID` INT NOT NULL ,
  `FechaInicio` DATETIME NOT NULL ,
  `FechaFin` DATETIME NULL ,
  `NumeroDeConsumidores` INT UNSIGNED NOT NULL ,
  `NumeroDeTiendas` INT UNSIGNED NOT NULL ,
  PRIMARY KEY (`RegionGeograficaID`, `FechaInicio`) ,
  INDEX `fk_TiendasConsumidores_RegionGeografica` (`RegionGeograficaID` ASC) ,
  CONSTRAINT `fk_TiendasConsumidores_RegionGeografica`
    FOREIGN KEY (`RegionGeograficaID` )
    REFERENCES `Spuria`.`RegionGeografica` (`RegionGeograficaID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `Spuria`;

DELIMITER $$
USE `Spuria`$$


CREATE TRIGGER t_TiendaCrear AFTER INSERT ON Tienda
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE Rastreable_P, bobo INT;
    
    SELECT CONCAT(
        'Cliente->Tienda: ',
        CAST(NEW.Cliente_P AS CHAR),'->',
        CAST(NEW.TiendaID AS CHAR),',',
        CAST(NEW.Buscable_P AS CHAR),',',
        CAST(NEW.CalificableSeguible_P AS CHAR),',',
        CAST(NEW.Interlocutor_P AS CHAR),',',
        CAST(NEW.Dibujable_P AS CHAR),',',
        CAST(NEW.Abierto AS CHAR)
    ) INTO Parametros;
    
    SELECT Cliente.Rastreable_P FROM Cliente
    WHERE RIF = NEW.Cliente_P
    INTO Rastreable_P;
    
    SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
END $$

USE `Spuria`$$


CREATE TRIGGER t_TiendaModificarAntes BEFORE UPDATE ON Tienda
FOR EACH ROW
BEGIN
    IF NEW.Buscable_P != OLD.Buscable_P THEN
        SET NEW.Buscable_P = OLD.Buscable_P;
    END IF;
    IF NEW.Cliente_P != OLD.Cliente_P THEN
        SET NEW.Cliente_P = OLD.Cliente_P;
    END IF;
    IF NEW.CalificableSeguible_P != OLD.CalificableSeguible_P THEN
        SET NEW.CalificableSeguible_P = OLD.CalificableSeguible_P;
    END IF;
    IF NEW.Interlocutor_P != OLD.Interlocutor_P THEN
        SET NEW.Interlocutor_P = OLD.Interlocutor_P;
    END IF;
    IF NEW.Dibujable_P != OLD.Dibujable_P THEN
        SET NEW.Dibujable_P = OLD.Buscable_P;
    END IF;
    IF NEW.TiendaID != OLD.TiendaID THEN
        SET NEW.TiendaID = OLD.TiendaID;
    END IF;
END $$

USE `Spuria`$$


CREATE TRIGGER t_TiendaModificarDespues AFTER UPDATE ON Tienda
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE Rastreable_P, bobo INT;
    
    IF NEW.Abierto != OLD.Abierto THEN
        SELECT CONCAT(
            'Cliente->Tienda(columna): ',
            CAST(NEW.Cliente_P AS CHAR),'->',
            CAST(NEW.TiendaID AS CHAR),'(Abierto): ',
            CAST(OLD.Abierto AS CHAR),' ahora es ',
            CAST(NEW.Abierto AS CHAR)
        ) INTO Parametros;
    
        SELECT Cliente.Rastreable_P FROM Cliente
        WHERE RIF = NEW.Cliente_P
        INTO Rastreable_P;
    
        SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
    END IF;
END $$

USE `Spuria`$$


CREATE TRIGGER t_TiendaEliminar BEFORE DELETE ON Tienda
FOR EACH ROW
BEGIN
    DELETE FROM Interlocutor WHERE InterlocutorID = OLD.Interlocutor_P;
    DELETE FROM CalificableSeguible WHERE CalificableSeguibleID = OLD.CalificableSeguible_P;
    DELETE FROM Dibujable WHERE DibujableID = OLD.Dibujable_P;
    DELETE FROM Buscable WHERE BuscableID = OLD.Buscable_P;
    DELETE FROM Tamano WHERE TiendaID = OLD.TiendaID;
    DELETE FROM HorarioDeTrabajo WHERE TiendaID = OLD.TiendaID;
    DELETE FROM Inventario WHERE TiendaID = OLD.TiendaID;
END $$


DELIMITER ;

DELIMITER $$
USE `Spuria`$$


CREATE TRIGGER t_ProductoCrear AFTER INSERT ON Producto
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE bobo INT;
        
    SELECT CONCAT(
        'Producto: ',
        CAST(NEW.Rastreable_P AS CHAR),',',
        CAST(NEW.Describible_P AS CHAR),',',
        CAST(NEW.Buscable_P AS CHAR),',',
        CAST(NEW.CalificableSeguible_P AS CHAR),',',
        CAST(NEW.ProductoID AS CHAR),',',
        NEW.TipoDeCodigoUniversal,',',
        NEW.CodigoUniversal,',',
        NEW.Estatus,',',
        NEW.Fabricante,',',
        NEW.Nombre,',',
        CAST(NEW.Categoria AS CHAR)
    ) INTO Parametros;
    
    SELECT RegistrarCreacion(NEW.Rastreable_P, Parametros) INTO bobo;
END $$

USE `Spuria`$$


CREATE TRIGGER t_ProductoEliminar BEFORE DELETE ON Producto
FOR EACH ROW
BEGIN
    DECLARE bobo INT;

    SELECT RegistrarEliminacion(OLD.Rastreable_P, CONCAT('Producto: ', CAST(OLD.ProductoID AS CHAR), ', ', OLD.Nombre)) INTO bobo;

    DELETE FROM Inventario WHERE ProductoID = OLD.ProductoID;
    DELETE FROM Describible WHERE DescribibleID = OLD.Describible_P;
    DELETE FROM Buscable WHERE BuscableID = OLD.Buscable_P;
    DELETE FROM CalificableSeguible WHERE CalificableSeguibleID = OLD.CalificableSeguible_P;
    /* OJO: Rastreable tiene que ser obligatoriamente el ultimo en eliminarse... sino va a haber problemas con el registro */
    DELETE FROM Rastreable WHERE RastreableID = OLD.Rastreable_P;
END $$

USE `Spuria`$$


CREATE TRIGGER t_ProductoModificarAntes BEFORE UPDATE ON Producto
FOR EACH ROW
BEGIN
    IF NEW.Rastreable_P != OLD.Rastreable_P THEN
        SET NEW.Rastreable_P = OLD.Rastreable_P;
    END IF;
    IF NEW.Describible_P != OLD.Describible_P THEN
        SET NEW.Describible_P = OLD.Describible_P;
    END IF;
    IF NEW.Buscable_P != OLD.Buscable_P THEN
        SET NEW.Buscable_P = OLD.Buscable_P;
    END IF;    
    IF NEW.CalificableSeguible_P != OLD.CalificableSeguible_P THEN
        SET NEW.CalificableSeguible_P = OLD.CalificableSeguible_P;
    END IF;
    IF NEW.ProductoID != OLD.ProductoID THEN
        SET NEW.ProductoID = OLD.ProductoID;
    END IF;
    IF NEW.TipoDeCodigoUniversal != OLD.TipoDeCodigoUniversal THEN
        SET NEW.TipoDeCodigoUniversal = OLD.TipoDeCodigoUniversal;
    END IF;
    IF NEW.CodigoUniversal != OLD.CodigoUniversal THEN
        SET NEW.CodigoUniversal = OLD.CodigoUniversal;
    END IF;
    IF NEW.Fabricante != OLD.Fabricante THEN
        SET NEW.Fabricante = OLD.Fabricante;
    END IF;
    IF NEW.Nombre != OLD.Nombre THEN
        SET NEW.Nombre = OLD.Nombre;
    END IF;
END $$

USE `Spuria`$$


CREATE TRIGGER t_ProductoModificarDespues AFTER UPDATE ON Producto
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE Rastreable_P, bobo INT;
    
    IF NEW.Estatus != OLD.Estatus THEN
        SELECT CONCAT(
            'Producto(columna): ',
            CAST(NEW.ProductoID AS CHAR),'(Estatus): ',
            CAST(OLD.Estatus AS CHAR),' ahora es ',
            CAST(NEW.Estatus AS CHAR)
        ) INTO Parametros;
    
        SELECT RegistrarModificacion(NEW.Rastreable_P, Parametros) INTO bobo;
    END IF;
    
    IF NEW.Modelo != OLD.Modelo THEN
        SELECT CONCAT(
            'Producto(columna): ',
            CAST(NEW.ProductoID AS CHAR),'(Modelo): ',
            CAST(OLD.Modelo AS CHAR),' ahora es ',
            CAST(NEW.Modelo AS CHAR)
        ) INTO Parametros;
    
        SELECT RegistrarModificacion(NEW.Rastreable_P, Parametros) INTO bobo;
    END IF;
    
    IF NEW.Categoria != OLD.Categoria THEN
        SELECT CONCAT(
            'Producto(columna): ',
            CAST(NEW.ProductoID AS CHAR),'(Categoria): ',
            CAST(OLD.Categoria AS CHAR),' ahora es ',
            CAST(NEW.Categoria AS CHAR)
        ) INTO Parametros;
    
        SELECT RegistrarModificacion(NEW.Rastreable_P, Parametros) INTO bobo;
    END IF;
    
    IF NEW.DebutEnElMercado != OLD.DebutEnElMercado THEN
        SELECT CONCAT(
            'Producto(columna): ',
            CAST(NEW.ProductoID AS CHAR),'(DebutEnElMercado): ',
            CAST(OLD.DebutEnElMercado AS CHAR),' ahora es ',
            CAST(NEW.DebutEnElMercado AS CHAR)
        ) INTO Parametros;
    
        SELECT RegistrarModificacion(NEW.Rastreable_P, Parametros) INTO bobo;
    END IF;
    
    IF NEW.Largo != OLD.Largo THEN
        SELECT CONCAT(
            'Producto(columna): ',
            CAST(NEW.ProductoID AS CHAR),'(Largo): ',
            CAST(OLD.Largo AS CHAR),' ahora es ',
            CAST(NEW.Largo AS CHAR)
        ) INTO Parametros;
    
        SELECT RegistrarModificacion(NEW.Rastreable_P, Parametros) INTO bobo;
    END IF;
    
    IF NEW.Ancho != OLD.Ancho THEN
        SELECT CONCAT(
            'Producto(columna): ',
            CAST(NEW.ProductoID AS CHAR),'(Ancho): ',
            CAST(OLD.Ancho AS CHAR),' ahora es ',
            CAST(NEW.Ancho AS CHAR)
        ) INTO Parametros;
    
        SELECT RegistrarModificacion(NEW.Rastreable_P, Parametros) INTO bobo;
    END IF;
    
    IF NEW.Alto != OLD.Alto THEN
        SELECT CONCAT(
            'Producto(columna): ',
            CAST(NEW.ProductoID AS CHAR),'(Alto): ',
            CAST(OLD.Alto AS CHAR),' ahora es ',
            CAST(NEW.Alto AS CHAR)
        ) INTO Parametros;
    
        SELECT RegistrarModificacion(NEW.Rastreable_P, Parametros) INTO bobo;
    END IF;
    
    IF NEW.Peso != OLD.Peso THEN
        SELECT CONCAT(
            'Producto(columna): ',
            CAST(NEW.ProductoID AS CHAR),'(Peso): ',
            CAST(OLD.Peso AS CHAR),' ahora es ',
            CAST(NEW.Peso AS CHAR)
        ) INTO Parametros;
    
        SELECT RegistrarModificacion(NEW.Rastreable_P, Parametros) INTO bobo;
    END IF;
    
    IF NEW.PaisDeOrigen != OLD.PaisDeOrigen THEN
        SELECT CONCAT(
            'Producto(columna): ',
            CAST(NEW.ProductoID AS CHAR),'(PaisDeOrigen): ',
            CAST(OLD.PaisDeOrigen AS CHAR),' ahora es ',
            CAST(NEW.Peso AS CHAR)
        ) INTO Parametros;
    
        SELECT RegistrarModificacion(NEW.Rastreable_P, Parametros) INTO bobo;
    END IF;
END $$


DELIMITER ;

DELIMITER $$
USE `Spuria`$$


CREATE TRIGGER t_CategoriaEliminar BEFORE DELETE ON Categoria
FOR EACH ROW
BEGIN
    DELETE FROM Etiquetable WHERE EtiquetableID = OLD.Etiquetable_P;
    /* Esta siguiente instruccion no la puede ejecutar el MYSQL por ser recursiva */
    /* DELETE FROM Categoria WHERE HijoDeCategoria = OLD.CategoriaID; */
END $$

USE `Spuria`$$


CREATE TRIGGER t_CategoriaModificarAntes BEFORE UPDATE ON Categoria
FOR EACH ROW
BEGIN
    IF NEW.Etiquetable_P != OLD.Etiquetable_P THEN
        SET NEW.Etiquetable_P = OLD.Etiquetable_P;
    END IF;
    IF NEW.CategoriaID != OLD.CategoriaID THEN
        SET NEW.CategoriaID = OLD.CategoriaID;
    END IF;
END $$


DELIMITER ;

DELIMITER $$
USE `Spuria`$$


CREATE TRIGGER t_EtiquetableEliminar BEFORE DELETE ON Etiquetable
FOR EACH ROW
BEGIN
    DELETE FROM Etiqueta WHERE EtiquetableID = OLD.EtiquetableID;
END $$

USE `Spuria`$$


CREATE TRIGGER t_EtiquetableModificarAntes BEFORE UPDATE ON Etiquetable
FOR EACH ROW
BEGIN
    IF NEW.EtiquetableID != OLD.EtiquetableID THEN
        SET NEW.EtiquetableID = OLD.EtiquetableID;
    END IF;
END $$


DELIMITER ;

DELIMITER $$
USE `Spuria`$$


CREATE TRIGGER t_ClienteCrear AFTER INSERT ON Cliente
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE bobo INT;
        
    SELECT CONCAT(
        'Cliente: ',
        CAST(NEW.Rastreable_P AS CHAR),',',
        CAST(NEW.Describible_P AS CHAR),',',
        CAST(NEW.Usuario_P AS CHAR),',',
        NEW.RIF,',',
        CAST(NEW.Categoria AS CHAR),',',
        NEW.Estatus,',',
        NEW.NombreLegal,',',
        NEW.NombreComun,',',
        NEW.Telefono,',',
        NEW.Calle,',',
        NEW.Sector_Urb_Barrio
    ) INTO Parametros;
    
    SELECT RegistrarCreacion(NEW.Rastreable_P, Parametros) INTO bobo;
END $$

USE `Spuria`$$


CREATE TRIGGER t_ClienteEliminar BEFORE DELETE ON Cliente
FOR EACH ROW
BEGIN
    DECLARE bobo INT;
    
    SELECT RegistrarEliminacion(OLD.Rastreable_P, CONCAT('Cliente: ', OLD.RIF, ', ', OLD.NombreLegal)) INTO bobo;
    
    DELETE FROM Usuario WHERE UsuarioID = OLD.Usuario_P;
    DELETE FROM Describible WHERE DescribibleID = OLD.Describible_P;
    DELETE FROM Tienda WHERE Cliente_P = OLD.RIF;
    DELETE FROM Patrocinante WHERE Cliente_P = OLD.RIF;
    DELETE FROM Factura WHERE Cliente = OLD.RIF;
    /* OJO: Rastreable tiene que ser obligatoriamente el ultimo en eliminarse... sino va a haber problemas con el registro */
    DELETE FROM Rastreable WHERE RastreableID = OLD.Rastreable_P;
END $$

USE `Spuria`$$


CREATE TRIGGER t_ClienteModificarAntes BEFORE UPDATE ON Cliente
FOR EACH ROW
BEGIN
    IF NEW.Rastreable_P != OLD.Rastreable_P THEN
        SET NEW.Rastreable_P = OLD.Rastreable_P;
    END IF;
    IF NEW.Describible_P != OLD.Describible_P THEN
        SET NEW.Describible_P = OLD.Describible_P;
    END IF;
    IF NEW.Usuario_P != OLD.Usuario_P THEN
        SET NEW.Usuario_P = OLD.Usuario_P;
    END IF;
    IF NEW.RIF != OLD.RIF THEN
        SET NEW.RIF = OLD.RIF;
    END IF;
    IF NEW.NombreLegal != OLD.NombreLegal THEN
        SET NEW.NombreLegal = OLD.NombreLegal;
    END IF;
END $$

USE `Spuria`$$


CREATE TRIGGER t_ClienteModificarDespues AFTER UPDATE ON Cliente
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE bobo INT;
    
    IF NEW.Categoria != OLD.Categoria THEN
        SELECT CONCAT(
            'Cliente(columna): ', 
            CAST(NEW.RIF AS CHAR),'(Categoria)',
            CAST(OLD.Categoria AS CHAR),' ahora es ',
            CAST(NEW.Categoria AS CHAR)
        ) INTO Parametros;
    
        SELECT RegistrarModificacion(NEW.Rastreable_P, Parametros) INTO bobo;
    END IF;
    
    IF NEW.Estatus != OLD.Estatus THEN
        SELECT CONCAT(
            'Cliente(columna): ', 
            CAST(NEW.RIF AS CHAR),'(Estatus)',
            CAST(OLD.Estatus AS CHAR),' ahora es ',
            CAST(NEW.Estatus AS CHAR)
        ) INTO Parametros;
    
        SELECT RegistrarModificacion(NEW.Rastreable_P, Parametros) INTO bobo;
    END IF;
    
    IF NEW.NombreComun != OLD.NombreComun THEN
        SELECT CONCAT(
            'Cliente(columna): ', 
            CAST(NEW.RIF AS CHAR),'(NombreComun)',
            CAST(OLD.NombreComun AS CHAR),' ahora es ',
            CAST(NEW.NombreComun AS CHAR)
        ) INTO Parametros;
    
        SELECT RegistrarModificacion(NEW.Rastreable_P, Parametros) INTO bobo;
    END IF;
    
    IF NEW.Telefono != OLD.Telefono THEN
        SELECT CONCAT(
            'Cliente(columna): ', 
            CAST(NEW.RIF AS CHAR),'(Telefono)',
            CAST(OLD.Telefono AS CHAR),' ahora es ',
            CAST(NEW.Telefono AS CHAR)
        ) INTO Parametros;
    
        SELECT RegistrarModificacion(NEW.Rastreable_P, Parametros) INTO bobo;
    END IF;
    
    IF NEW.Edificio_CC != OLD.Edificio_CC THEN
        SELECT CONCAT(
            'Cliente(columna): ', 
            CAST(NEW.RIF AS CHAR),'(Edificio_CC)',
            CAST(OLD.Edificio_CC AS CHAR),' ahora es ',
            CAST(NEW.Edificio_CC AS CHAR)
        ) INTO Parametros;
    
        SELECT RegistrarModificacion(NEW.Rastreable_P, Parametros) INTO bobo;
    END IF;
    
    IF NEW.Piso != OLD.Piso THEN
        SELECT CONCAT(
            'Cliente(columna): ', 
            CAST(NEW.RIF AS CHAR),'(Piso)',
            CAST(OLD.Piso AS CHAR),' ahora es ',
            CAST(NEW.Piso AS CHAR)
        ) INTO Parametros;
    
        SELECT RegistrarModificacion(NEW.Rastreable_P, Parametros) INTO bobo;
    END IF;
    
    IF NEW.Apartamento != OLD.Apartamento THEN
        SELECT CONCAT(
            'Cliente(columna): ', 
            CAST(NEW.RIF AS CHAR),'(Apartamento)',
            CAST(OLD.Apartamento AS CHAR),' ahora es ',
            CAST(NEW.Apartamento AS CHAR)
        ) INTO Parametros;
    
        SELECT RegistrarModificacion(NEW.Rastreable_P, Parametros) INTO bobo;
    END IF;
    
    IF NEW.LocalNo != OLD.LocalNo THEN
        SELECT CONCAT(
            'Cliente(columna): ', 
            CAST(NEW.RIF AS CHAR),'(LocalNo)',
            CAST(OLD.LocalNo AS CHAR),' ahora es ',
            CAST(NEW.LocalNo AS CHAR)
        ) INTO Parametros;
    
        SELECT RegistrarModificacion(NEW.Rastreable_P, Parametros) INTO bobo;
    END IF;
    
    IF NEW.Casa != OLD.Casa THEN
        SELECT CONCAT(
            'Cliente(columna): ', 
            CAST(NEW.RIF AS CHAR),'(Casa)',
            CAST(OLD.Casa AS CHAR),' ahora es ',
            CAST(NEW.Casa AS CHAR)
        ) INTO Parametros;
    
        SELECT RegistrarModificacion(NEW.Rastreable_P, Parametros) INTO bobo;
    END IF;
    
    IF NEW.Calle != OLD.Calle THEN
        SELECT CONCAT(
            'Cliente(columna): ', 
            CAST(NEW.RIF AS CHAR),'(Calle)',
            CAST(OLD.Calle AS CHAR),' ahora es ',
            CAST(NEW.Calle AS CHAR)
        ) INTO Parametros;
    
        SELECT RegistrarModificacion(NEW.Rastreable_P, Parametros) INTO bobo;
    END IF;
    
    IF NEW.Sector_Urb_Barrio != OLD.Sector_Urb_Barrio THEN
        SELECT CONCAT(
            'Cliente(columna): ', 
            CAST(NEW.RIF AS CHAR),'(Sector_Urb_Barrio)',
            CAST(OLD.Sector_Urb_Barrio AS CHAR),' ahora es ',
            CAST(NEW.Sector_Urb_Barrio AS CHAR)
        ) INTO Parametros;
    
        SELECT RegistrarModificacion(NEW.Rastreable_P, Parametros) INTO bobo;
    END IF;
    
    IF NEW.PaginaWeb != OLD.PaginaWeb THEN
        SELECT CONCAT(
            'Cliente(columna): ', 
            CAST(NEW.RIF AS CHAR),'(PaginaWeb)',
            CAST(OLD.PaginaWeb AS CHAR),' ahora es ',
            CAST(NEW.PaginaWeb AS CHAR)
        ) INTO Parametros;
    
        SELECT RegistrarModificacion(NEW.Rastreable_P, Parametros) INTO bobo;
    END IF;
    
    IF NEW.Facebook != OLD.Facebook THEN
        SELECT CONCAT(
            'Cliente(columna): ', 
            CAST(NEW.RIF AS CHAR),'(Facebook)',
            CAST(OLD.Facebook AS CHAR),' ahora es ',
            CAST(NEW.Facebook AS CHAR)
        ) INTO Parametros;
    
        SELECT RegistrarModificacion(NEW.Rastreable_P, Parametros) INTO bobo;
    END IF;
    
    IF NEW.Twitter != OLD.Twitter THEN
        SELECT CONCAT(
            'Cliente(columna): ', 
            CAST(NEW.RIF AS CHAR),'(Twitter)',
            CAST(OLD.Twitter AS CHAR),' ahora es ',
            CAST(NEW.Twitter AS CHAR)
        ) INTO Parametros;
    
        SELECT RegistrarModificacion(NEW.Rastreable_P, Parametros) INTO bobo;
    END IF;
END $$


DELIMITER ;

DELIMITER $$
USE `Spuria`$$


CREATE TRIGGER t_InventarioModificarAntes BEFORE UPDATE ON Inventario
FOR EACH ROW
BEGIN
    IF NEW.Rastreable_P != OLD.Rastreable_P THEN
        SET NEW.Rastreable_P = OLD.Rastreable_P;
    END IF;
    IF NEW.Cobrable_P != OLD.Cobrable_P THEN
        SET NEW.Cobrable_P = OLD.Cobrable_P;
    END IF;
    IF NEW.TiendaID != OLD.TiendaID THEN
        SET NEW.TiendaID = OLD.TiendaID;
    END IF;
    IF NEW.ProductoID != OLD.ProductoID THEN
        SET NEW.ProductoID = OLD.ProductoID;
    END IF;
END $$

USE `Spuria`$$


CREATE TRIGGER t_InventarioEliminar BEFORE DELETE ON Inventario
FOR EACH ROW
BEGIN
    DECLARE Denominacion, Tienda CHAR(45);
    DECLARE bobo INT;
    
    SELECT Nombre FROM Producto 
    WHERE ProductoID = OLD.ProductoID
    INTO Denominacion;
    
    SELECT NombreLegal FROM Cliente, Tienda
    WHERE TiendaID = OLD.TiendaID AND RIF = Cliente_P
    INTO Tienda;
    
    SELECT RegistrarEliminacion(
        OLD.Rastreable_P, 
        CONCAT(
            'Inventario: ', 
            Denominacion, ' (producto) de ', 
            Tienda, ' (tienda)'
        )
    ) INTO bobo;

    DELETE FROM PrecioCantidad WHERE TiendaID = OLD.TiendaID AND ProductoID = OLD.ProductoID;
/*
    DELETE FROM Cantidad WHERE TiendaID = OLD.TiendaID AND ProductoID = OLD.ProductoID;
    DELETE FROM Precio WHERE TiendaID = OLD.TiendaID AND ProductoID = OLD.ProductoID;
*/
    DELETE FROM Cobrable WHERE CobrableID = OLD.Cobrable_P;
    /* OJO: Rastreable tiene que ser obligatoriamente el ultimo en eliminarse... sino va a haber problemas con el registro */
    DELETE FROM Rastreable WHERE RastreableID = OLD.Rastreable_P;
END $$

USE `Spuria`$$


CREATE TRIGGER t_InventarioModificarDespues AFTER UPDATE ON Inventario
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE bobo INT;
    
    IF NEW.Visibilidad != OLD.Visibilidad THEN
        SELECT CONCAT(
            'Inventario(columna): (', 
            CAST(NEW.TiendaID AS CHAR),',',
            CAST(NEW.ProductoID AS CHAR),'(Visibilidad)',
            CAST(NEW.Visibilidad AS CHAR),' ahora es ',
            CAST(NEW.Visibilidad AS CHAR)
        ) INTO Parametros;
    
        SELECT RegistrarModificacion(NEW.Rastreable_P, Parametros) INTO bobo;
    END IF;
    
    IF NEW.SKU != OLD.SKU THEN
        SELECT CONCAT(
            'Inventario(columna): (', 
            CAST(NEW.TiendaID AS CHAR),',',
            CAST(NEW.ProductoID AS CHAR),'(SKU)',
            CAST(NEW.SKU AS CHAR),' ahora es ',
            CAST(NEW.SKU AS CHAR)
        ) INTO Parametros;
    
        SELECT RegistrarModificacion(NEW.Rastreable_P, Parametros) INTO bobo;
    END IF;
END $$

USE `Spuria`$$


CREATE TRIGGER t_InventarioCrear AFTER INSERT ON Inventario
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE bobo INT;
    
    SELECT CONCAT(
        'Inventario: ', 
        CAST(NEW.Rastreable_P AS CHAR),',',
        CAST(NEW.Cobrable_P AS CHAR),',',
        CAST(NEW.TiendaID AS CHAR),',',
        CAST(NEW.ProductoID AS CHAR), ',',
        NEW.Visibilidad
    ) INTO Parametros;
        
    SELECT RegistrarCreacion (NEW.Rastreable_P, Parametros) INTO bobo;
END $$


DELIMITER ;

DELIMITER $$
USE `Spuria`$$


CREATE TRIGGER t_MensajeCrear AFTER INSERT ON Mensaje
FOR EACH ROW
BEGIN
    DECLARE bobo INT;
    
    SELECT RegistrarCreacion (
        NEW.Rastreable_P, 
        CONCAT(
            'Mensaje: ', 
            CAST(NEW.Rastreable_P AS CHAR), ',',
            CAST(NEW.Etiquetable_P AS CHAR), ',',
            CAST(NEW.MensajeID AS CHAR), ',',
            CAST(NEW.Rastreable_P AS CHAR), ',',
            CAST(NEW.Remitente AS CHAR), ',',
            CAST(NEW.Destinatario AS CHAR), ',',
            NEW.Contenido
        )
    ) INTO bobo;
END $$

USE `Spuria`$$


CREATE TRIGGER t_MensajeEliminar BEFORE DELETE ON Mensaje
FOR EACH ROW
BEGIN
    DECLARE bobo INT;

    SELECT RegistrarEliminacion (
        OLD.Rastreable_P, 
        CONCAT(
            'Mensaje: ', 
            'de ', CAST(OLD.Remitente AS CHAR), 
            ' a ', CAST(OLD.Destinatario AS CHAR)
        )
    ) INTO bobo;

    DELETE FROM Etiquetable WHERE EtiquetableID = OLD.Etiquetable_P;
    DELETE FROM Rastreable WHERE RastreableID = OLD.Rastreable_P;    
END $$

USE `Spuria`$$


CREATE TRIGGER t_MensajeModificarAntes BEFORE UPDATE ON Mensaje
FOR EACH ROW
BEGIN
    IF NEW.Rastreable_P != OLD.Rastreable_P THEN
        SET NEW.Rastreable_P = OLD.Rastreable_P;
    END IF;
    IF NEW.Etiquetable_P != OLD.Etiquetable_P THEN
        SET NEW.Etiquetable_P = OLD.Etiquetable_P;
    END IF;
    IF NEW.MensajeID != OLD.MensajeID THEN
        SET NEW.MensajeID = OLD.MensajeID;
    END IF;
    IF NEW.Remitente != OLD.Remitente THEN
        SET NEW.Remitente = OLD.Remitente;
    END IF;
    IF NEW.Destinatario != OLD.Destinatario THEN
        SET NEW.Destinatario = OLD.Destinatario;
    END IF;
    IF NEW.Contenido != OLD.Contenido THEN
        SET NEW.Destinatario = OLD.Contenido;
    END IF;
END $$


DELIMITER ;

DELIMITER $$
USE `Spuria`$$


CREATE TRIGGER t_InterlocutorEliminar BEFORE DELETE ON Interlocutor
FOR EACH ROW
BEGIN
    DELETE FROM Mensaje WHERE Remitente = OLD.InterlocutorID OR Destinatario = OLD.InterlocutorID;
END $$

USE `Spuria`$$


CREATE TRIGGER t_InterlocutorModificarAntes BEFORE UPDATE ON Interlocutor
FOR EACH ROW
BEGIN
    IF NEW.InterlocutorID != OLD.InterlocutorID THEN
        SET NEW.InterlocutorID = OLD.InterlocutorID;
    END IF;
END $$


DELIMITER ;

DELIMITER $$
USE `Spuria`$$


CREATE TRIGGER t_ConsumidorCrear AFTER INSERT ON Consumidor
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE bobo INT;
        
    SELECT CONCAT(
        'Consumidor: ',
        CAST(NEW.Rastreable_P AS CHAR),',',
        CAST(NEW.Interlocutor_P AS CHAR),',',
        CAST(NEW.Usuario_P AS CHAR),',',
        CAST(NEW.ConsumidorID AS CHAR),',',
        NEW.Nombre,',',
        NEW.Apellido,',',
        NEW.Estatus,',',
        NEW.Sexo,',',
        CAST(NEW.FechaDeNacimiento AS CHAR),',',
        NEW.GrupoDeEdad,',',
        NEW.GradoDeInstruccion
    ) INTO Parametros;
    
    SELECT RegistrarCreacion(NEW.Rastreable_P, Parametros) INTO bobo;
END $$

USE `Spuria`$$


CREATE TRIGGER t_ConsumidorEliminar BEFORE DELETE ON Consumidor
FOR EACH ROW
BEGIN
    DECLARE bobo INT;
    
    SELECT RegistrarEliminacion(OLD.Rastreable_P, CONCAT('Consumidor: ', OLD.Nombre, ' ', OLD.Apellido)) INTO bobo;
    
    DELETE FROM Usuario WHERE UsuarioID = OLD.Usuario_P;
    DELETE FROM Interlocutor WHERE InterlocutorID = OLD.Interlocutor_P;
    DELETE FROM Seguidor WHERE ConsumidorID = OLD.ConsumidorID;
    DELETE FROM CalificacionResena WHERE ConsumidorID = OLD.ConsumidorID;
    DELETE FROM ConsumidorObjetivo WHERE ConsumidorID = OLD.ConsumidorID;
    /* OJO: Rastreable tiene que ser obligatoriamente el ultimo en eliminarse... sino va a haber problemas con el registro */
    DELETE FROM Rastreable WHERE RastreableID = OLD.Rastreable_P;
END $$

USE `Spuria`$$


CREATE TRIGGER t_ConsumidorModificarAntes BEFORE UPDATE ON Consumidor
FOR EACH ROW
BEGIN
    IF NEW.Rastreable_P != OLD.Rastreable_P THEN
        SET NEW.Rastreable_P = OLD.Rastreable_P;
    END IF;
    IF NEW.Interlocutor_P != OLD.Interlocutor_P THEN
        SET NEW.Interlocutor_P = OLD.Interlocutor_P;
    END IF;
    IF NEW.Usuario_P != OLD.Usuario_P THEN
        SET NEW.Usuario_P = OLD.Usuario_P;
    END IF;
    IF NEW.ConsumidorID != OLD.ConsumidorID THEN
        SET NEW.ConsumidorID = OLD.ConsumidorID;
    END IF;
    IF NEW.FechaDeNacimiento != OLD.FechaDeNacimiento THEN
        SET NEW.FechaDeNacimiento = OLD.FechaDeNacimiento;
    END IF;
    IF NEW.GrupoDeEdad != OLD.GrupoDeEdad THEN
        SET NEW.GrupoDeEdad = OLD.GrupoDeEdad;
    END IF;
END $$

USE `Spuria`$$


CREATE TRIGGER t_ConsumidorModificarDespues AFTER UPDATE ON Consumidor
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE bobo INT;
    
    IF NEW.Nombre != OLD.Nombre THEN
        SELECT CONCAT(
            'Consumidor(columna): ', 
            CAST(NEW.ConsumidorID AS CHAR),'(Nombre)',
            CAST(OLD.Nombre AS CHAR),' ahora es ',
            CAST(NEW.Nombre AS CHAR)
        ) INTO Parametros;
    
        SELECT RegistrarModificacion(NEW.Rastreable_P, Parametros) INTO bobo;
    END IF;
    
    IF NEW.Apellido != OLD.Apellido THEN
        SELECT CONCAT(
            'Consumidor(columna): ', 
            CAST(NEW.ConsumidorID AS CHAR),'(Apellido)',
            CAST(OLD.Apellido AS CHAR),' ahora es ',
            CAST(NEW.Apellido AS CHAR)
        ) INTO Parametros;
    
        SELECT RegistrarModificacion(NEW.Rastreable_P, Parametros) INTO bobo;
    END IF;
    
    IF NEW.Estatus != OLD.Estatus THEN
        SELECT CONCAT(
            'Consumidor(columna): ', 
            CAST(NEW.ConsumidorID AS CHAR),'(Estatus)',
            CAST(OLD.Estatus AS CHAR),' ahora es ',
            CAST(NEW.Estatus AS CHAR)
        ) INTO Parametros;
    
        SELECT RegistrarModificacion(NEW.Rastreable_P, Parametros) INTO bobo;
    END IF;
    
    IF NEW.Sexo != OLD.Sexo THEN
        SELECT CONCAT(
            'Consumidor(columna): ', 
            CAST(NEW.ConsumidorID AS CHAR),'(Sexo)',
            CAST(OLD.Sexo AS CHAR),' ahora es ',
            CAST(NEW.Sexo AS CHAR)
        ) INTO Parametros;
    
        SELECT RegistrarModificacion(NEW.Rastreable_P, Parametros) INTO bobo;
    END IF;
    
    IF NEW.GradoDeInstruccion != OLD.GradoDeInstruccion THEN
        SELECT CONCAT(
            'Consumidor(columna): ', 
            CAST(NEW.ConsumidorID AS CHAR),'(GradoDeInstruccion)',
            CAST(OLD.GradoDeInstruccion AS CHAR),' ahora es ',
            CAST(NEW.GradoDeInstruccion AS CHAR)
        ) INTO Parametros;
    
        SELECT RegistrarModificacion(NEW.Rastreable_P, Parametros) INTO bobo;
    END IF;
END $$


DELIMITER ;

DELIMITER $$
USE `Spuria`$$


CREATE TRIGGER t_UsuarioModificarAntes BEFORE UPDATE ON Usuario
FOR EACH ROW
BEGIN
    IF NEW.UsuarioID != OLD.UsuarioID THEN
        SET NEW.UsuarioID = OLD.UsuarioID;
    END IF;
END $$

USE `Spuria`$$


CREATE TRIGGER t_UsuarioEliminar BEFORE DELETE ON Usuario
FOR EACH ROW
BEGIN
    DELETE FROM Acceso WHERE AccesoID = OLD.UsuarioID;
    DELETE FROM Busqueda WHERE UsuarioID = OLD.UsuarioID;
END $$

USE `Spuria`$$


CREATE TRIGGER t_UsuarioModificarDespues AFTER UPDATE ON Usuario
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE Cliente CHAR(10);
    DECLARE Cl, Ad, Co, Rastreable_P, bobo INT;
    
    IF NEW.Parroquia != OLD.Parroquia THEN
        SELECT COUNT(*) FROM Cliente
        WHERE Usuario_P = NEW.UsuarioID
        INTO Cl;
    
        SELECT COUNT(*) FROM Administrador
        WHERE Usuario_P = NEW.UsuarioID
        INTO Ad;
    
        SELECT COUNT(*) FROM Consumidor
        WHERE Usuario_P = NEW.UsuarioID
        INTO Co;
    
        IF Cl = 1 THEN
            SELECT RIF, Cliente.Rastreable_P FROM Cliente
            WHERE Usuario_P = NEW.UsuarioID
            INTO Cliente, Rastreable_P;
            
            SELECT CONCAT('Cliente<-Usuario(columna): ',Cliente,'<-') INTO Parametros;
        END IF;
        
        IF Ad = 1 THEN
            SELECT AdministradorID, Administrador.Rastreable_P FROM Administrador
            WHERE Usuario_P = NEW.UsuarioID
            INTO Ad, Rastreable_P;
            
            SELECT CONCAT('Administrador<-Usuario(columna): ', CAST(Ad AS CHAR),'<-') INTO Parametros;
        END IF;
        
        IF Co = 1 THEN
            SELECT ConsumidorID, Consumidor.Rastreable_P FROM Consumidor
            WHERE Usuario_P = NEW.UsuarioID
            INTO Co, Rastreable_P;
            
            SELECT CONCAT('Consumidor<-Usuario(columna): ', CAST(Co AS CHAR),'<-') INTO Parametros;
        END IF;
        
        SELECT CONCAT(
            Parametros,
            CAST(NEW.UsuarioID AS CHAR),'(Parroquia): ',
            CAST(OLD.Parroquia AS CHAR),' ahora es ',
            CAST(NEW.Parroquia AS CHAR)
        ) INTO Parametros;
                
        SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
    END IF;
END $$


DELIMITER ;

DELIMITER $$
USE `Spuria`$$


CREATE TRIGGER t_BusquedaCrear AFTER INSERT ON Busqueda
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE bobo INT;
    
    SELECT CONCAT(
        'Busqueda: ',
        CAST(NEW.Rastreable_P AS CHAR),',',
        CAST(NEW.Etiquetable_P AS CHAR),',',
        CAST(NEW.BusquedaID AS CHAR),',',
        CAST(NEW.Usuario AS CHAR),',',
        CAST(NEW.FechaHora AS CHAR),',',
        NEW.Contenido
    ) INTO Parametros;
    
    SELECT RegistrarCreacion(NEW.Rastreable_P, Parametros) INTO bobo;
END $$

USE `Spuria`$$


CREATE TRIGGER t_BusquedaEliminar BEFORE DELETE ON Busqueda
FOR EACH ROW
BEGIN
    DELETE FROM Etiquetable WHERE EtiquetableID = OLD.Etiquetable_P;
    DELETE FROM ResultadoDeBusqueda WHERE BusquedaID = OLD.BusquedaID;
    /* OJO: Rastreable tiene que ser obligatoriamente el ultimo en eliminarse... sino va a haber problemas con el registro */
    DELETE FROM Rastreable WHERE RastreableID = OLD.Rastreable_P;
END $$

USE `Spuria`$$


CREATE TRIGGER t_BusquedaModificarAntes BEFORE UPDATE ON Busqueda
FOR EACH ROW
BEGIN
    IF NEW.Rastreable_P != OLD.Rastreable_P THEN
        SET NEW.Rastreable_P = OLD.Rastreable_P;
    END IF;
    IF NEW.Etiquetable_P != OLD.Etiquetable_P THEN
        SET NEW.Etiquetable_P = OLD.Etiquetable_P;
    END IF;
    IF NEW.BusquedaID != OLD.BusquedaID THEN
        SET NEW.BusquedaID = OLD.BusquedaID;
    END IF;
    IF NEW.Usuario != OLD.Usuario THEN
        SET NEW.Usuario = OLD.Usuario;
    END IF;
    IF NEW.FechaHora != OLD.FechaHora THEN
        SET NEW.FechaHora = OLD.FechaHora;
    END IF;
    IF NEW.Contenido != OLD.Contenido THEN
        SET NEW.Contenido = OLD.Contenido;
    END IF;
END $$


DELIMITER ;

DELIMITER $$
USE `Spuria`$$


CREATE TRIGGER t_ParroquiaCrear AFTER INSERT ON Parroquia
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE Rastreable_P, bobo INT;

    SELECT CONCAT(
        'RegionGeografica->Parroquia: ',
        CAST(NEW.RegionGeografica_P AS CHAR),'->',
        CAST(NEW.ParroquiaID AS CHAR),',',
        CAST(NEW.Municipio AS CHAR),',',
        NEW.CodigoPostal
    ) INTO Parametros;
    
    SELECT RegionGeografica.Rastreable_P FROM RegionGeografica
    WHERE RegionGeograficaID = NEW.RegionGeografica_P
    INTO Rastreable_P;
    
    SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
END $$

USE `Spuria`$$


CREATE TRIGGER t_ParroquiaModificarAntes BEFORE UPDATE ON Parroquia
FOR EACH ROW
BEGIN
    IF NEW.RegionGeografica_P != OLD.RegionGeografica_P THEN
        SET NEW.RegionGeografica_P = OLD.RegionGeografica_P;
    END IF;
    IF NEW.ParroquiaID != OLD.ParroquiaID THEN
        SET NEW.ParroquiaID = OLD.ParroquiaID;
    END IF;
END $$

USE `Spuria`$$


CREATE TRIGGER t_ParroquiaEliminar BEFORE DELETE ON Parroquia
FOR EACH ROW
BEGIN
    /* ¡Vergacion! ¡La instruccion comentada abajo es demasiado peligrosa! */
    /* DELETE FROM Usuario WHERE Parroquia = OLD.ParroquiaID; */
    DELETE FROM RegionGeografica WHERE RegionGeograficaID = OLD.RegionGeografica_P;
END $$

USE `Spuria`$$


CREATE TRIGGER t_ParroquiaModificarDespues AFTER UPDATE ON Parroquia
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE Rastreable_P, bobo INT;
    
    SELECT RegionGeografica.Rastreable_P FROM RegionGeografica
    WHERE NEW.RegionGeografica_P = RegionGeograficaID
    INTO Rastreable_P;
    
    IF NEW.CodigoPostal != OLD.CodigoPostal THEN
        SELECT CONCAT(
            'RegionGeografica->Parroquia(columna): ',
            CAST(NEW.RegionGeografica_P AS CHAR),'->',
            CAST(NEW.ParroquiaID AS CHAR),'(CodigoPostal):',
            CAST(OLD.CodigoPostal AS CHAR),' ahora es ',
            CAST(NEW.CodigoPostal AS CHAR)
        ) INTO Parametros;
    
        SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
    END IF;

    IF NEW.Municipio != OLD.Municipio THEN
        SELECT CONCAT(
            'RegionGeografica->Parroquia(columna): ',
            CAST(NEW.RegionGeografica_P AS CHAR),'->',
            CAST(NEW.ParroquiaID AS CHAR),'(Municipio):',
            CAST(OLD.Municipio AS CHAR),' ahora es ',
            CAST(NEW.Municipio AS CHAR)
        ) INTO Parametros;
    
        SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
    END IF;
 END $$


DELIMITER ;

DELIMITER $$
USE `Spuria`$$


CREATE TRIGGER t_PalabraEliminar BEFORE DELETE ON Palabra
FOR EACH ROW
BEGIN
    DELETE FROM RelacionDePalabras WHERE Palabra1ID = OLD.PalabraID OR Palabra2ID = OLD.PalabraID;
    DELETE FROM EstadisticasDeInfluencia WHERE Palabra = OLD.PalabraID;
    DELETE FROM Etiqueta WHERE PalabraID = OLD.PalabraID;
END $$

USE `Spuria`$$


CREATE TRIGGER t_PalabraModificarAntes BEFORE UPDATE ON Palabra
FOR EACH ROW
BEGIN
    IF NEW.PalabraID != OLD.PalabraID THEN
        SET NEW.PalabraID = OLD.PalabraID;
    END IF;
    IF NEW.Palabra_Frase != OLD.Palabra_Frase THEN
        SET NEW.Palabra_Frase = OLD.Palabra_Frase;
    END IF;
END $$


DELIMITER ;

DELIMITER $$
USE `Spuria`$$


CREATE TRIGGER t_RelacionDePalabrasModificarAntes BEFORE UPDATE ON RelacionDePalabras
FOR EACH ROW
BEGIN
/*
    IF NEW.Palabra1ID != OLD.Palabra1ID THEN
        SET NEW.Palabra1ID = OLD.Palabra1ID;
    END IF;
    IF NEW.Palabra2ID != OLD.Palabra2ID THEN
        SET NEW.Palabra2ID = OLD.Palabra2ID;
    END IF;
*/
END $$


DELIMITER ;

DELIMITER $$
USE `Spuria`$$


CREATE TRIGGER t_EstadisticasDeInfluenciaEliminar BEFORE DELETE ON EstadisticasDeInfluencia
FOR EACH ROW
BEGIN
    DELETE FROM Estadisticas WHERE EstadisticasID = OLD.Estadisticas_P;
END $$

USE `Spuria`$$


CREATE TRIGGER t_EstadisticasDeInfluenciaCrear AFTER INSERT ON EstadisticasDeInfluencia
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE Rastreable_P, bobo INT;
    
    SELECT CONCAT(
        'Estadisticas->EstadisticasDeInfluencia: ',
        CAST(NEW.Estadisticas_P AS CHAR),'->',
        CAST(NEW.EstadisticasDeInfluenciaID AS CHAR),',',
        CAST(NEW.Palabra AS CHAR),',',
        CAST(NEW.NumeroDeDescripciones AS CHAR),',',
        CAST(NEW.NumeroDeMensajes AS CHAR),',',
        CAST(NEW.NumeroDeCategorias AS CHAR),',',
        CAST(NEW.NumeroDeResenas AS CHAR),',',
        CAST(NEW.NumeroDePublicidades AS CHAR)
    ) INTO Parametros;
    
    SELECT Estadisticas.Rastreable_P FROM Estadisticas
    WHERE EstadisticasID = NEW.Estadisticas_P
    INTO Rastreable_P;
    
    SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
END $$

USE `Spuria`$$


CREATE TRIGGER t_EstadisticasDeInfluenciaModificarAntes BEFORE UPDATE ON EstadisticasDeInfluencia
FOR EACH ROW
BEGIN
    IF NEW.Estadisticas_P != OLD.Estadisticas_P THEN
        SET NEW.Estadisticas_P = OLD.Estadisticas_P;
    END IF;
    IF NEW.EstadisticasDeInfluenciaID != OLD.EstadisticasDeInfluenciaID THEN
        SET NEW.EstadisticasDeInfluenciaID = OLD.EstadisticasDeInfluenciaID;
    END IF;
    IF NEW.Palabra != OLD.Palabra THEN
        SET NEW.Palabra = OLD.Palabra;
    END IF;
END $$

USE `Spuria`$$


CREATE TRIGGER t_EstadisticasDeInfluenciaModificarDespues AFTER UPDATE ON EstadisticasDeInfluencia
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE Rastreable_P, bobo INT;
    
    SELECT Estadisticas.Rastreable_P FROM Estadisticas
    WHERE EstadisticasID = NEW.Estadisticas_P
    INTO Rastreable_P;
            
    IF NEW.NumeroDeDescripciones != OLD.NumeroDeDescripciones THEN
        SELECT CONCAT(
            'Estadisticas->EstadisticasDeInfluencia(columna): ',
            CAST(NEW.Estadisticas_P AS CHAR),'->',
            CAST(NEW.EstadisticasDeInfluenciaID AS CHAR),'(NumeroDeDescripciones): ',
            CAST(OLD.NumeroDeDescripciones AS CHAR),' ahora es ',
            CAST(NEW.NumeroDeDescripciones AS CHAR)
        ) INTO Parametros;
        
        SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
    END IF;
    
    IF NEW.NumeroDeMensajes != OLD.NumeroDeMensajes THEN
        SELECT CONCAT(
            'Estadisticas->EstadisticasDeInfluencia(columna): ',
            CAST(NEW.Estadisticas_P AS CHAR),'->',
            CAST(NEW.EstadisticasDeInfluenciaID AS CHAR),'(NumeroDeMensajes): ',
            CAST(OLD.NumeroDeMensajes AS CHAR),' ahora es ',
            CAST(NEW.NumeroDeMensajes AS CHAR)
        ) INTO Parametros;
    
        SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
    END IF;
    
    IF NEW.NumeroDeCategorias != OLD.NumeroDeCategorias THEN
        SELECT CONCAT(
            'Estadisticas->EstadisticasDeInfluencia(columna): ',
            CAST(NEW.Estadisticas_P AS CHAR),'->',
            CAST(NEW.EstadisticasDeInfluenciaID AS CHAR),'(NumeroDeCategorias): ',
            CAST(OLD.NumeroDeCategorias AS CHAR),' ahora es ',
            CAST(NEW.NumeroDeCategorias AS CHAR)
        ) INTO Parametros;

        SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
    END IF;
    
    IF NEW.NumeroDeResenas != OLD.NumeroDeResenas THEN
        SELECT CONCAT(
            'Estadisticas->EstadisticasDeInfluencia(columna): ',
            CAST(NEW.Estadisticas_P AS CHAR),'->',
            CAST(NEW.EstadisticasDeInfluenciaID AS CHAR),'(NumeroDeResenas): ',
            CAST(OLD.NumeroDeResenas AS CHAR),' ahora es ',
            CAST(NEW.NumeroDeResenas AS CHAR)
        ) INTO Parametros;

        SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
    END IF;
    
    IF NEW.NumeroDePublicidades != OLD.NumeroDePublicidades THEN
        SELECT CONCAT(
            'Estadisticas->EstadisticasDeInfluencia(columna): ',
            CAST(NEW.Estadisticas_P AS CHAR),'->',
            CAST(NEW.EstadisticasDeInfluenciaID AS CHAR),'(NumeroDePublicidades): ',
            CAST(OLD.NumeroDePublicidades AS CHAR),' ahora es ',
            CAST(NEW.NumeroDePublicidades AS CHAR)
        ) INTO Parametros;

        SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
    END IF;
END $$


DELIMITER ;

DELIMITER $$
USE `Spuria`$$


CREATE TRIGGER t_PaisEliminar BEFORE DELETE ON Pais
FOR EACH ROW
BEGIN
    DELETE FROM Estado WHERE Pais = OLD.PaisID;
    DELETE FROM Ciudad WHERE CiudadID = OLD.Capital;
    DELETE FROM PaisSubcontinente WHERE PaisID = OLD.PaisID;
    DELETE FROM RegionGeografica WHERE RegionGeograficaID = OLD.RegionGeografica_P;
END $$

USE `Spuria`$$


CREATE TRIGGER t_PaisCrear AFTER INSERT ON Pais
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE Rastreable_P, bobo INT;

    SELECT CONCAT(
        'RegionGeografica->Pais: ',
        CAST(NEW.RegionGeografica_P AS CHAR),'->',
        CAST(NEW.PaisID AS CHAR),',',
        CAST(NEW.Continente AS CHAR),',',
        CAST(NEW.Capital AS CHAR),',',
        NEW.Idioma
    ) INTO Parametros;
    
    SELECT RegionGeografica.Rastreable_P FROM RegionGeografica
    WHERE RegionGeograficaID = NEW.RegionGeografica_P
    INTO Rastreable_P;
    
    SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
END $$

USE `Spuria`$$


CREATE TRIGGER t_PaisModificarAntes BEFORE UPDATE ON Pais
FOR EACH ROW
BEGIN
    IF NEW.RegionGeografica_P != OLD.RegionGeografica_P THEN
        SET NEW.RegionGeografica_P = OLD.RegionGeografica_P;
    END IF;
    IF NEW.PaisID != OLD.PaisID THEN
        SET NEW.PaisID = OLD.PaisID;
    END IF;
    IF NEW.Continente != OLD.Continente THEN
        SET NEW.Continente = OLD.Continente;
    END IF;
    IF NEW.Capital != OLD.Capital THEN
        SET NEW.Capital = OLD.Capital;
    END IF;
    IF NEW.Idioma != OLD.Idioma THEN
        SET NEW.Idioma = OLD.Idioma;
    END IF;
END $$

USE `Spuria`$$


CREATE TRIGGER t_PaisModificarDespues AFTER UPDATE ON Pais
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE Rastreable_P, bobo INT;
    
    SELECT RegionGeografica.Rastreable_P FROM RegionGeografica
    WHERE NEW.RegionGeografica_P = RegionGeograficaID
    INTO Rastreable_P;
    
    IF NEW.MonedaLocal != OLD.MonedaLocal THEN
        SELECT CONCAT(
            'RegionGeografica->Pais(columna): ',
            CAST(NEW.RegionGeografica_P AS CHAR),'->',
            CAST(NEW.PaisID AS CHAR),'(MonedaLocal):',
            CAST(OLD.MonedaLocal AS CHAR),' ahora es ',
            CAST(NEW.MonedaLocal AS CHAR)
        ) INTO Parametros;
    
        SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
    END IF;

    IF NEW.MonedaLocal_Dolar != OLD.MonedaLocal_Dolar THEN
        SELECT CONCAT(
            'RegionGeografica->Pais(columna): ',
            CAST(NEW.RegionGeografica_P AS CHAR),'->',
            CAST(NEW.PaisID AS CHAR),'(MonedaLocal_Dolar):',
            CAST(OLD.MonedaLocal_Dolar AS CHAR),' ahora es ',
            CAST(NEW.MonedaLocal_Dolar AS CHAR)
        ) INTO Parametros;
    
        SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
    END IF;
    
    IF NEW.PIB != OLD.PIB THEN
        SELECT CONCAT(
            'RegionGeografica->Pais(columna): ',
            CAST(NEW.RegionGeografica_P AS CHAR),'->',
            CAST(NEW.PaisID AS CHAR),'(PIB):',
            CAST(OLD.PIB AS CHAR),' ahora es ',
            CAST(NEW.PIB AS CHAR)
        ) INTO Parametros;
    
        SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
    END IF;
END $$


DELIMITER ;

DELIMITER $$
USE `Spuria`$$


CREATE TRIGGER t_CalificacionResenaCrear AFTER INSERT ON CalificacionResena
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE bobo INT;
    
    SELECT CONCAT(
        'CalificacionResena: ',
        CAST(NEW.Rastreable_P AS CHAR),',',
        CAST(NEW.Etiquetable_P AS CHAR),',',
        CAST(NEW.CalificableSeguibleID AS CHAR),',',
        CAST(NEW.ConsumidorID AS CHAR),',',
        NEW.Calificacion,',',
        NEW.Resena
    ) INTO Parametros;
    
    SELECT RegistrarCreacion(NEW.Rastreable_P, Parametros) INTO bobo;
END $$

USE `Spuria`$$


CREATE TRIGGER t_CalificacionResenaModificarAntes BEFORE UPDATE ON CalificacionResena
FOR EACH ROW
BEGIN
    IF NEW.Rastreable_P != OLD.Rastreable_P THEN
        SET NEW.Rastreable_P = OLD.Rastreable_P;
    END IF;
    IF NEW.Etiquetable_P != OLD.Etiquetable_P THEN
        SET NEW.Etiquetable_P = OLD.Etiquetable_P;
    END IF;
    IF NEW.CalificableSeguibleID != OLD.CalificableSeguibleID THEN
        SET NEW.CalificableSeguibleID = OLD.CalificableSeguibleID;
    END IF;
    IF NEW.ConsumidorID != OLD.ConsumidorID THEN
        SET NEW.ConsumidorID = OLD.ConsumidorID;
    END IF;
END $$

USE `Spuria`$$


CREATE TRIGGER t_CalificacionResenaEliminar BEFORE DELETE ON CalificacionResena
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE Denominacion CHAR(45);
    DECLARE C, D, bobo INT;
    
    SELECT COUNT(*) FROM Producto
    WHERE CalificableSeguible_P = OLD.CalificableSeguibleID
    INTO C;
    
    SELECT COUNT(*) FROM Tienda
    WHERE CalificableSeguible_P = OLD.CalificableSeguibleID
    INTO D;
    
    IF C = 1 THEN
        SELECT Nombre FROM Producto
        WHERE CalificableSeguible_P = OLD.CalificableSeguibleID
        INTO Denominacion;
       
        SELECT RegistrarEliminacion(OLD.Rastreable_P, CONCAT('CalificacionResena: ', Denominacion, ' (producto)')) INTO bobo;
    ELSE
        IF D = 1 THEN
            SELECT NombreLegal FROM Cliente, Tienda
            WHERE CalificableSeguible_P = OLD.CalificableSeguibleID AND RIF = Cliente_P
            INTO Denominacion;
        
            SELECT RegistrarEliminacion(OLD.Rastreable_P, CONCAT('CalificacionResena: ', Denominacion, ' (tienda)')) INTO bobo;
        END IF;
    END IF;
    
    DELETE FROM Etiquetable WHERE EtiquetableID = OLD.Etiquetable_P;
    /* OJO: Rastreable tiene que ser obligatoriamente el ultimo en eliminarse... sino va a haber problemas con el registro */
    DELETE FROM Rastreable WHERE RastreableID = OLD.Rastreable_P;
END $$

USE `Spuria`$$


CREATE TRIGGER t_CalificacionResenaModificarDespues AFTER UPDATE ON CalificacionResena
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE bobo INT;
    
    IF NEW.Calificacion != OLD.Calificacion THEN
        SELECT CONCAT(
            'CalificacionResena(columna): (', 
            CAST(NEW.CalificableSeguibleID AS CHAR),',',
            CAST(NEW.ConsumidorID AS CHAR),')(Calificacion): ',
            CAST(OLD.Calificacion AS CHAR),' ahora es ',
            CAST(NEW.Calificacion AS CHAR)
        ) INTO Parametros;
    
        SELECT RegistrarModificacion(NEW.Rastreable_P, Parametros) INTO bobo;
    END IF;
    
    IF NEW.Resena != OLD.Resena THEN
        SELECT CONCAT(
            'CalificacionResena(columna): (', 
            CAST(NEW.CalificableSeguibleID AS CHAR),',',
            CAST(NEW.ConsumidorID AS CHAR),')(Calificacion): ',
            ' Muy largo... '
        ) INTO Parametros;
    
        SELECT RegistrarModificacion(NEW.Rastreable_P, Parametros) INTO bobo;
    END IF;
END $$


DELIMITER ;

DELIMITER $$
USE `Spuria`$$


CREATE TRIGGER t_CalificableSeguibleEliminar BEFORE DELETE ON CalificableSeguible
FOR EACH ROW
BEGIN
    DELETE FROM CalificacionResena WHERE CalificableSeguibleID = OLD.CalificableSeguibleID;
    DELETE FROM Seguidor WHERE CalificableSeguibleID = OLD.CalificableSeguibleID;
    DELETE FROM EstadisticasDePopularidad WHERE CalificableSeguible = OLD.CalificableSeguibleID;
END $$

USE `Spuria`$$


CREATE TRIGGER t_CalificableSeguibleModificarAntes BEFORE UPDATE ON CalificableSeguible
FOR EACH ROW
BEGIN
    IF NEW.CalificableSeguibleID != OLD.CalificableSeguibleID THEN
        SET NEW.CalificableSeguibleID = OLD.CalificableSeguibleID;
    END IF;
END $$


DELIMITER ;

DELIMITER $$
USE `Spuria`$$


CREATE TRIGGER t_SeguidorCrear AFTER INSERT ON Seguidor
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE bobo INT;
        
    SELECT CONCAT(
        'Seguidor: ',
        CAST(NEW.Rastreable_P AS CHAR),',',
        CAST(NEW.ConsumidorID AS CHAR),',',
        CAST(NEW.CalificableSeguibleID AS CHAR),',',
        NEW.AvisarSi
    ) INTO Parametros;
    
    SELECT RegistrarCreacion(NEW.Rastreable_P, Parametros) INTO bobo;
END $$

USE `Spuria`$$


CREATE TRIGGER t_SeguidorEliminar BEFORE DELETE ON Seguidor
FOR EACH ROW
BEGIN
    DECLARE bobo INT;

    SELECT RegistrarEliminacion (
        OLD.Rastreable_P, 
        CONCAT(
            'Seguidor: ', 
            CAST(OLD.ConsumidorID AS CHAR),' (consumidor) de ',
            CAST(OLD.CalificableSeguibleID AS CHAR),' (calificable/seguible)'
        )
    ) INTO bobo;

    DELETE FROM Rastreable WHERE RastreableID = OLD.Rastreable_P;
END $$

USE `Spuria`$$


CREATE TRIGGER t_SeguidorModificarAntes BEFORE UPDATE ON Seguidor
FOR EACH ROW
BEGIN
    IF NEW.Rastreable_P != OLD.Rastreable_P THEN
        SET NEW.Rastreable_P = OLD.Rastreable_P;
    END IF;
    IF NEW.ConsumidorID != OLD.ConsumidorID THEN
        SET NEW.ConsumidorID = OLD.ConsumidorID;
    END IF;
    IF NEW.CalificableSeguibleID != OLD.CalificableSeguibleID THEN
        SET NEW.CalificableSeguibleID = OLD.CalificableSeguibleID;
    END IF;
END $$

USE `Spuria`$$


CREATE TRIGGER t_SeguidorModificarDespues AFTER UPDATE ON Seguidor
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE Rastreable_P, bobo INT;
    
    IF NEW.AvisarSi != OLD.AvisarSi THEN
        SELECT CONCAT(
            'Seguidor(columna): (',
            CAST(NEW.ConsumidorID AS CHAR),',',
            CAST(NEW.CalificableSeguibleID AS CHAR),')(AvisarSi): ',
            CAST(OLD.AvisarSi AS CHAR),' ahora es ',
            CAST(NEW.AvisarSi AS CHAR)
        ) INTO Parametros;
    
        SELECT RegistrarModificacion(NEW.Rastreable_P, Parametros) INTO bobo;
    END IF;
END $$


DELIMITER ;

DELIMITER $$
USE `Spuria`$$


CREATE TRIGGER t_EstadisticasDePopularidadCrear AFTER INSERT ON EstadisticasDePopularidad
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE Rastreable_P, bobo INT;
    
    SELECT CONCAT(
        'Estadisticas->EstadisticasDePopularidad: ',
        CAST(NEW.Estadisticas_P AS CHAR),'->',
        CAST(NEW.EstadisticasDePopularidadID AS CHAR),',',
        CAST(NEW.CalificableSeguible AS CHAR),',',
        CAST(NEW.NumeroDeCalificaciones AS CHAR),',',
        CAST(NEW.NumeroDeResenas AS CHAR),',',
        CAST(NEW.NumeroDeSeguidores AS CHAR),',',
        CAST(NEW.NumeroDeMenciones AS CHAR)
    ) INTO Parametros;
    
    SELECT Estadisticas.Rastreable_P FROM Estadisticas
    WHERE EstadisticasID = NEW.Estadisticas_P
    INTO Rastreable_P;
    
    SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
END $$

USE `Spuria`$$


CREATE TRIGGER t_EstadisticasDePopularidadModificarAntes BEFORE UPDATE ON EstadisticasDePopularidad
FOR EACH ROW
BEGIN
    IF NEW.Estadisticas_P != OLD.Estadisticas_P THEN
        SET NEW.Estadisticas_P = OLD.Estadisticas_P;
    END IF;
    IF NEW.EstadisticasDePopularidadID != OLD.EstadisticasDePopularidadID THEN
        SET NEW.EstadisticasDePopularidadID = OLD.EstadisticasDePopularidadID;
    END IF;
    IF NEW.CalificableSeguible != OLD.CalificableSeguible THEN
        SET NEW.CalificableSeguible = OLD.CalificableSeguible;
    END IF;
END $$

USE `Spuria`$$


CREATE TRIGGER t_EstadisticasDePopularidadModificarDespues AFTER UPDATE ON EstadisticasDePopularidad
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE Rastreable_P, bobo INT;
    
    SELECT Estadisticas.Rastreable_P FROM Estadisticas
    WHERE EstadisticasID = NEW.Estadisticas_P
    INTO Rastreable_P;
            
    IF NEW.NumeroDeCalificaciones != OLD.NumeroDeCalificaciones THEN
        SELECT CONCAT(
            'Estadisticas->EstadisticasDePopularidad(columna): ',
            CAST(NEW.Estadisticas_P AS CHAR),'->',
            CAST(NEW.EstadisticasDePopularidadID AS CHAR),'(NumeroDeCalificaciones): ',
            CAST(OLD.NumeroDeCalificaciones AS CHAR),' ahora es ',
            CAST(NEW.NumeroDeCalificaciones AS CHAR)
        ) INTO Parametros;
        
        SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
    END IF;
    
    IF NEW.NumeroDeResenas != OLD.NumeroDeResenas THEN
        SELECT CONCAT(
            'Estadisticas->EstadisticasDePopularidad(columna): ',
            CAST(NEW.Estadisticas_P AS CHAR),'->',
            CAST(NEW.EstadisticasDePopularidadID AS CHAR),'(NumeroDeResenas): ',
            CAST(OLD.NumeroDeResenas AS CHAR),' ahora es ',
            CAST(NEW.NumeroDeResenas AS CHAR)
        ) INTO Parametros;
    
        SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
    END IF;
    
    IF NEW.NumeroDeSeguidores != OLD.NumeroDeSeguidores THEN
        SELECT CONCAT(
            'Estadisticas->EstadisticasDePopularidad(columna): ',
            CAST(NEW.Estadisticas_P AS CHAR),'->',
            CAST(NEW.EstadisticasDePopularidadID AS CHAR),'(NumeroDeSeguidores): ',
            CAST(OLD.NumeroDeSeguidores AS CHAR),' ahora es ',
            CAST(NEW.NumeroDeSeguidores AS CHAR)
        ) INTO Parametros;

        SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
    END IF;
    
    IF NEW.NumeroDeMenciones != OLD.NumeroDeMenciones THEN
        SELECT CONCAT(
            'Estadisticas->EstadisticasDePopularidad(columna): ',
            CAST(NEW.Estadisticas_P AS CHAR),'->',
            CAST(NEW.EstadisticasDePopularidadID AS CHAR),'(NumeroDeMenciones): ',
            CAST(OLD.NumeroDeMenciones AS CHAR),' ahora es ',
            CAST(NEW.NumeroDeMenciones AS CHAR)
        ) INTO Parametros;

        SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
    END IF;
    
    IF NEW.NumeroDeVendedores != OLD.NumeroDeVendedores THEN
        SELECT CONCAT(
            'Estadisticas->EstadisticasDePopularidad(columna): ',
            CAST(NEW.Estadisticas_P AS CHAR),'->',
            CAST(NEW.EstadisticasDePopularidadID AS CHAR),'(NumeroDeVendedores): ',
            CAST(OLD.NumeroDeVendedores AS CHAR),' ahora es ',
            CAST(NEW.NumeroDeVendedores AS CHAR)
        ) INTO Parametros;

        SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
    END IF;
    
    IF NEW.NumeroDeMensajes != OLD.NumeroDeMensajes THEN
        SELECT CONCAT(
            'Estadisticas->EstadisticasDePopularidad(columna): ',
            CAST(NEW.Estadisticas_P AS CHAR),'->',
            CAST(NEW.EstadisticasDePopularidadID AS CHAR),'(NumeroDeMensajes): ',
            CAST(OLD.NumeroDeMensajes AS CHAR),' ahora es ',
            CAST(NEW.NumeroDeMensajes AS CHAR)
        ) INTO Parametros;

        SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
    END IF;
END $$

USE `Spuria`$$


CREATE TRIGGER t_EstadisticasDePopularidadEliminar BEFORE DELETE ON EstadisticasDePopularidad
FOR EACH ROW
BEGIN
    DELETE FROM Estadisticas WHERE EstadisticasID = OLD.Estadisticas_P;
END $$


DELIMITER ;

DELIMITER $$
USE `Spuria`$$


CREATE TRIGGER t_EtiquetaModificarAntes BEFORE UPDATE ON Etiqueta
FOR EACH ROW
BEGIN
    IF NEW.EtiquetableID != OLD.EtiquetableID THEN
        SET NEW.EtiquetableID = OLD.EtiquetableID;
    END IF;
    IF NEW.PalabraID != OLD.PalabraID THEN
        SET NEW.PalabraID = OLD.PalabraID;
    END IF;
END $$


DELIMITER ;

DELIMITER $$
USE `Spuria`$$


CREATE TRIGGER t_DescripcionCrear AFTER INSERT ON Descripcion
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE bobo INT;
    
    SELECT CONCAT(
        'Descripcion: ',
        CAST(NEW.Rastreable_P AS CHAR),',',
        CAST(NEW.Etiquetable_P AS CHAR),',',
        CAST(NEW.DescripcionID AS CHAR),',',
        CAST(NEW.Describible AS CHAR),',',
        NEW.Contenido
    ) INTO Parametros;
    
    SELECT RegistrarCreacion(NEW.Rastreable_P, Parametros) INTO bobo;
END $$

USE `Spuria`$$


CREATE TRIGGER t_DescripcionModificarAntes BEFORE UPDATE ON Descripcion
FOR EACH ROW
BEGIN
    IF NEW.Rastreable_P != OLD.Rastreable_P THEN
        SET NEW.Rastreable_P = OLD.Rastreable_P;
    END IF;
    IF NEW.Etiquetable_P != OLD.Etiquetable_P THEN
        SET NEW.Etiquetable_P = OLD.Etiquetable_P;
    END IF;
    IF NEW.DescripcionID != OLD.DescripcionID THEN
        SET NEW.DescripcionID = OLD.DescripcionID;
    END IF;
    IF NEW.Describible != OLD.Describible THEN
        SET NEW.Describible = OLD.Describible;
    END IF;
END $$

USE `Spuria`$$


CREATE TRIGGER t_DescripcionModificarDespues AFTER UPDATE ON Descripcion
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE bobo INT;
    
    IF NEW.Contenido != OLD.Contenido THEN
        SELECT CONCAT(
            'Descripcion(columna): ', 
            CAST(NEW.DescripcionID AS CHAR),'(Contenido): ',
            'Muy largo...'
        ) INTO Parametros;
    
        SELECT RegistrarModificacion(NEW.Rastreable_P, Parametros) INTO bobo;
    END IF;
END $$

USE `Spuria`$$


CREATE TRIGGER t_DescripcionEliminar BEFORE DELETE ON Descripcion
FOR EACH ROW
BEGIN
    DECLARE bobo INT;

    SELECT RegistrarEliminacion(OLD.Rastreable_P, CONCAT('Descripcion: de ', CAST(OLD.Describible AS CHAR))) INTO bobo;

    DELETE FROM Etiquetable WHERE EtiquetableID = OLD.Etiquetable_P;
    /* OJO: Rastreable tiene que ser obligatoriamente el ultimo en eliminarse... sino va a haber problemas con el registro */
    DELETE FROM Rastreable WHERE RastreableID = OLD.Rastreable_P;
END $$


DELIMITER ;

DELIMITER $$
USE `Spuria`$$


CREATE TRIGGER t_PublicidadCrear AFTER INSERT ON Publicidad
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE bobo INT;
    
    SELECT CONCAT(
        'Publicidad: ',
        CAST(NEW.Buscable_P AS CHAR),',',
        CAST(NEW.Describible_P AS CHAR),',',
        CAST(NEW.Rastreable_P AS CHAR),',',
        CAST(NEW.Etiquetable_P AS CHAR),',',
        CAST(NEW.Cobrable_P AS CHAR),',',
        CAST(NEW.PublicidadID AS CHAR),',',
        CAST(NEW.Patrocinante AS CHAR)
    ) INTO Parametros;
    
    SELECT RegistrarCreacion(NEW.Rastreable_P, Parametros) INTO bobo;
END $$

USE `Spuria`$$


CREATE TRIGGER t_PublicidadModificarAntes BEFORE UPDATE ON Publicidad
FOR EACH ROW
BEGIN
    IF NEW.Buscable_P != OLD.Buscable_P THEN
        SET NEW.Buscable_P = OLD.Buscable_P;
    END IF;
    IF NEW.Describible_P != OLD.Describible_P THEN
        SET NEW.Describible_P = OLD.Describible_P;
    END IF;
    IF NEW.Rastreable_P != OLD.Rastreable_P THEN
        SET NEW.Rastreable_P = OLD.Rastreable_P;
    END IF;
    IF NEW.Etiquetable_P != OLD.Etiquetable_P THEN
        SET NEW.Etiquetable_P = OLD.Etiquetable_P;
    END IF;
    IF NEW.Cobrable_P != OLD.Cobrable_P THEN
        SET NEW.Cobrable_P = OLD.Cobrable_P;
    END IF;
    IF NEW.PublicidadID != OLD.PublicidadID THEN
        SET NEW.PublicidadID = OLD.PublicidadID;
    END IF;
    IF NEW.Patrocinante != OLD.Patrocinante THEN
        SET NEW.Patrocinante = OLD.Patrocinante;
    END IF;
END $$

USE `Spuria`$$


CREATE TRIGGER t_PublicidadModificarDespues AFTER UPDATE ON Publicidad
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE Rastreable_P, bobo INT;
    
    IF NEW.TamanoDePoblacionObjetivo != OLD.TamanoDePoblacionObjetivo THEN
        SELECT CONCAT(
            'Publicidad(columna): ',
            CAST(NEW.PublicidadID AS CHAR),'(TamanoDePoblacionObjetivo): ',
            CAST(OLD.TamanoDePoblacionObjetivo AS CHAR),' ahora es ',
            CAST(NEW.TamanoDePoblacionObjetivo AS CHAR)
        ) INTO Parametros;
    
        SELECT RegistrarModificacion(NEW.Rastreable_P, Parametros) INTO bobo;
    END IF;
END $$

USE `Spuria`$$


CREATE TRIGGER t_PublicidadEliminar BEFORE DELETE ON Publicidad
FOR EACH ROW
BEGIN
    DECLARE bobo INT;

    SELECT RegistrarEliminacion(OLD.Rastreable_P, CONCAT('Publicidad: ', CAST(OLD.PublicidadID AS CHAR))) INTO bobo;

    DELETE FROM Etiquetable WHERE EtiquetableID = OLD.Etiquetable_P;
    DELETE FROM Describible WHERE DescribibleID = OLD.Describible_P;
    DELETE FROM Buscable WHERE BuscableID = OLD.Buscable_P;
    DELETE FROM Cobrable WHERE CobrableID = OLD.Cobrable_P;
    DELETE FROM ConsumidorObjetivo WHERE PublicidadID = OLD.PublicidadID;
    DELETE FROM GrupoDeEdadObjetivo WHERE PublicidadID = OLD.PublicidadID;
    DELETE FROM GradoDeInstruccionObjetivo WHERE PublicidadID = OLD.PublicidadID;
    DELETE FROM RegionGeograficaObjetivo WHERE PublicidadID = OLD.PublicidadID;
    DELETE FROM SexoObjetivo WHERE PublicidadID = OLD.PublicidadID;
    /* OJO: Rastreable tiene que ser obligatoriamente el ultimo en eliminarse... sino va a haber problemas con el registro */
    DELETE FROM Rastreable WHERE RastreableID = OLD.Rastreable_P;
END $$


DELIMITER ;

DELIMITER $$
USE `Spuria`$$


CREATE TRIGGER t_DescribibleEliminar BEFORE DELETE ON Describible
FOR EACH ROW
BEGIN
    DELETE FROM Descripcion WHERE Describible = OLD.DescribibleID;
    /* Este tal vez no sea necesario borrarlo... */
    DELETE FROM Foto WHERE Describible = OLD.DescribibleID;
END $$

USE `Spuria`$$


CREATE TRIGGER t_DescribibleModificarAntes BEFORE UPDATE ON Describible
FOR EACH ROW
BEGIN
    IF NEW.DescribibleID != OLD.DescribibleID THEN
        SET NEW.DescribibleID = OLD.DescribibleID;
    END IF;
END $$


DELIMITER ;

DELIMITER $$
USE `Spuria`$$


CREATE TRIGGER t_RegistroModificarAntes BEFORE UPDATE ON Registro
FOR EACH ROW
BEGIN
    IF NEW.RegistroID != OLD.RegistroID THEN
        SET NEW.RegistroID = OLD.RegistroID;
    END IF;
    IF NEW.FechaHora != OLD.FechaHora THEN
        SET NEW.FechaHora = OLD.FechaHora;
    END IF;
    IF NEW.ActorActivo != OLD.ActorActivo THEN
        SET NEW.ActorActivo = OLD.ActorActivo;
    END IF;
    IF NEW.ActorPasivo != OLD.ActorPasivo THEN
        SET NEW.ActorPasivo = OLD.ActorPasivo;
    END IF;
    IF NEW.Accion != OLD.Accion THEN
        SET NEW.Accion = OLD.Accion;
    END IF;
    IF NEW.Parametros != OLD.Parametros THEN
        SET NEW.Parametros = OLD.Parametros;
    END IF;
    IF NEW.CodigoDeError != OLD.CodigoDeError THEN
        SET NEW.CodigoDeError = OLD.CodigoDeError;
    END IF;
END $$


DELIMITER ;

DELIMITER $$
USE `Spuria`$$


CREATE TRIGGER t_RastreableModificarAntes BEFORE UPDATE ON Rastreable
FOR EACH ROW
BEGIN
    IF NEW.RastreableID != OLD.RastreableID THEN
        SET NEW.RastreableID = OLD.RastreableID;
    END IF;
    IF NEW.FechaDeCreacion != OLD.FechaDeCreacion THEN
        SET NEW.FechaDeCreacion = OLD.FechaDeCreacion;
    END IF;
    IF NEW.CreadoPor != OLD.CreadoPor THEN
        SET NEW.CreadoPor = OLD.CreadoPor;
    END IF;
END $$


DELIMITER ;

DELIMITER $$
USE `Spuria`$$


CREATE TRIGGER t_BuscableEliminar BEFORE DELETE ON Buscable
FOR EACH ROW
BEGIN
    DELETE FROM EstadisticasDeVisitas WHERE Buscable = OLD.BuscableID;
    DELETE FROM ResultadoDeBusqueda WHERE BuscableID = OLD.BuscableID;
END $$

USE `Spuria`$$


CREATE TRIGGER t_BuscableModificarAntes BEFORE UPDATE ON Buscable
FOR EACH ROW
BEGIN
    IF NEW.BuscableID != OLD.BuscableID THEN
        SET NEW.BuscableID = OLD.BuscableID;
    END IF;
END $$


DELIMITER ;

DELIMITER $$
USE `Spuria`$$


CREATE TRIGGER t_EstadisticasDeVisitasEliminar BEFORE DELETE ON EstadisticasDeVisitas
FOR EACH ROW
BEGIN
    DELETE FROM ContadorDeExhibiciones WHERE EstadisticasDeVisitasID = OLD.EstadisticasDeVisitasID;
    DELETE FROM Estadisticas WHERE EstadisticasID = OLD.Estadisticas_P;
END $$

USE `Spuria`$$


CREATE TRIGGER t_EstadisticasDeVisitasCrear AFTER INSERT ON EstadisticasDeVisitas
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE Rastreable_P, bobo INT;
    
    SELECT CONCAT(
        'Estadisticas->EstadisticasDeVisitas: ',
        CAST(NEW.Estadisticas_P AS CHAR),'->',
        CAST(NEW.EstadisticasDeVisitasID AS CHAR),',',
        CAST(NEW.Buscable AS CHAR)
    ) INTO Parametros;
    
    SELECT Estadisticas.Rastreable_P FROM Estadisticas
    WHERE EstadisticasID = NEW.Estadisticas_P
    INTO Rastreable_P;
    
    SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
END $$

USE `Spuria`$$


CREATE TRIGGER t_EstadisticasDeVisitasModificarAntes BEFORE UPDATE ON EstadisticasDeVisitas
FOR EACH ROW
BEGIN
    IF NEW.Estadisticas_P != OLD.Estadisticas_P THEN
        SET NEW.Estadisticas_P = OLD.Estadisticas_P;
    END IF;
    IF NEW.EstadisticasDeVisitasID != OLD.EstadisticasDeVisitasID THEN
        SET NEW.EstadisticasDeVisitasID = OLD.EstadisticasDeVisitasID;
    END IF;
    IF NEW.Buscable != OLD.Buscable THEN
        SET NEW.Buscable = OLD.EstadisticasDeVisitasID;
    END IF;
END $$


DELIMITER ;

DELIMITER $$
USE `Spuria`$$


CREATE TRIGGER t_EstadisticasCrear AFTER INSERT ON Estadisticas
FOR EACH ROW
BEGIN
    DECLARE bobo INT;
    
    SELECT RegistrarCreacion (
        NEW.Rastreable_P, 
        CONCAT(
            'Estadisticas: ', 
            CAST(NEW.Rastreable_P AS CHAR), ',',
            CAST(NEW.EstadisticasID AS CHAR), ',',
            CAST(NEW.RegionGeografica AS CHAR)
        )
    ) INTO bobo;
END $$

USE `Spuria`$$


CREATE TRIGGER t_EstadisticasEliminar BEFORE DELETE ON Estadisticas
FOR EACH ROW
BEGIN
    DELETE FROM EstadisticasTemporales WHERE EstadisticasID = OLD.EstadisticasID;
    /*
    DELETE FROM Contador WHERE EstadisticasID = OLD.EstadisticasID;
    DELETE FROM Ranking WHERE EstadisticasID = OLD.EstadisticasID;
    DELETE FROM Indice WHERE EstadisticasID = OLD.EstadisticasID;
    */
END $$

USE `Spuria`$$


CREATE TRIGGER t_EstadisticasModificarAntes BEFORE UPDATE ON Estadisticas
FOR EACH ROW
BEGIN
    IF NEW.Rastreable_P != OLD.Rastreable_P THEN
        SET NEW.Rastreable_P = OLD.Rastreable_P;
    END IF;
    IF NEW.EstadisticasID != OLD.EstadisticasID THEN
        SET NEW.EstadisticasID = OLD.EstadisticasID;
    END IF;
    IF NEW.RegionGeografica != OLD.RegionGeografica THEN
        SET NEW.EstadisticasID = OLD.RegionGeografica;
    END IF;
END $$


DELIMITER ;

DELIMITER $$
USE `Spuria`$$


CREATE TRIGGER t_ContadorDeExhibicionesCrear AFTER INSERT ON ContadorDeExhibiciones
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE EstadisticasID, Rastreable_P, bobo INT;
    
    SELECT Estadisticas.EstadisticasID, Estadisticas.Rastreable_P FROM Estadisticas, EstadisticasDeVisitas
    WHERE EstadisticasDeVisitas.EstadisticasDeVisitasID = NEW.EstadisticasDeVisitasID AND Estadisticas.EstadisticasID = EstadisticasDeVisitas.Estadisticas_P
    INTO EstadisticasID, Rastreable_P;
    
    SELECT CONCAT(
        'Estadisticas->EstadisticasDeVisitas->ContadorDeExhibiciones: ',
        CAST(EstadisticasID AS CHAR),'->',
        CAST(NEW.EstadisticasDeVisitasID AS CHAR),'->',
        CAST(NEW.FechaInicio AS CHAR),': ',
        CAST(NEW.ContadorDeExhibiciones AS CHAR)
    ) INTO Parametros;
    
    SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
END $$

USE `Spuria`$$


CREATE TRIGGER t_ContadorDeExhibicionesModificarAntes BEFORE UPDATE ON ContadorDeExhibiciones
FOR EACH ROW
BEGIN
    IF NEW.EstadisticasDeVisitasID != OLD.EstadisticasDeVisitasID THEN
        SET NEW.EstadisticasDeVisitasID = OLD.EstadisticasDeVisitasID;
    END IF;
    IF NEW.FechaInicio != OLD.FechaInicio THEN
        SET NEW.FechaInicio = OLD.FechaInicio;
    END IF;
END $$

USE `Spuria`$$


CREATE TRIGGER t_ContadorDeExhibicionesModificarDespues AFTER UPDATE ON ContadorDeExhibiciones
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE Estadisticas_P, Rastreable_P, bobo INT;
    
    SELECT Estadisticas.EstadisticasID, Estadisticas.Rastreable_P FROM Estadisticas, EstadisticasDeVisitas
    WHERE EstadisticasDeVisitasID = NEW.EstadisticasDeVisitasID AND EstadisticasDeVisitas.Estadisticas_P = Estadisticas.EstadisticasID
    INTO Estadisticas_P, Rastreable_P;
    
    IF NEW.FechaFin != OLD.FechaFin THEN
        SELECT CONCAT(
            'Estadisticas->EstadisticasDeVisitas->ContadorDeExhibiciones(columna): ',
            CAST(Estadisticas_P AS CHAR),'->',
            CAST(NEW.EstadisticasDeVisitasID AS CHAR),'->',
            CAST(NEW.FechaInicio AS CHAR),'(FechaFin): ',
            CAST(OLD.FechaFin AS CHAR),' ahora es ',
            CAST(NEW.FechaFin AS CHAR)
        ) INTO Parametros;
        
        SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
    END IF;
    
    IF NEW.ContadorDeExhibiciones != OLD.ContadorDeExhibiciones THEN
        SELECT CONCAT(
            'Estadisticas->EstadisticasDeVisitas->ContadorDeExhibiciones(columna): ',
            CAST(Estadisticas_P AS CHAR),'->',
            CAST(NEW.EstadisticasDeVisitasID AS CHAR),'->',
            CAST(NEW.FechaInicio AS CHAR),'(ContadorDeExhibiciones): ',
            CAST(OLD.ContadorDeExhibiciones AS CHAR),' ahora es ',
            CAST(NEW.ContadorDeExhibiciones AS CHAR)
        ) INTO Parametros;
    
        SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
    END IF;
END $$


DELIMITER ;

DELIMITER $$
USE `Spuria`$$


CREATE TRIGGER t_RegionGeograficaCrear AFTER INSERT ON RegionGeografica
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE bobo INT;
    
    SELECT CONCAT(
        'RegionGeografica: ',
        CAST(NEW.Rastreable_P AS CHAR),',',
        CAST(NEW.Dibujable_P AS CHAR),',' ,
        CAST(NEW.RegionGeograficaID AS CHAR),',' ,
        NEW.Nombre,',',
        CAST(NEW.Poblacion AS CHAR)
    ) INTO Parametros;
    
    SELECT RegistrarCreacion(NEW.Rastreable_P, Parametros) INTO bobo;
END $$

USE `Spuria`$$


CREATE TRIGGER t_RegionGeograficaModificarAntes BEFORE UPDATE ON RegionGeografica
FOR EACH ROW
BEGIN
    IF NEW.Rastreable_P != OLD.Rastreable_P THEN
        SET NEW.Rastreable_P = OLD.Rastreable_P;
    END IF;
    IF NEW.Dibujable_P != OLD.Dibujable_P THEN
        SET NEW.Dibujable_P = OLD.Dibujable_P;
    END IF;
    IF NEW.RegionGeograficaID != OLD.RegionGeograficaID THEN
        SET NEW.RegionGeograficaID = OLD.RegionGeograficaID;
    END IF;
END $$

USE `Spuria`$$


CREATE TRIGGER t_RegionGeograficaEliminar BEFORE DELETE ON RegionGeografica
FOR EACH ROW
BEGIN
    DECLARE bobo INT;

    SELECT RegistrarEliminacion(OLD.Rastreable_P, CONCAT('RegionGeografica: ',OLD.Nombre)) INTO bobo;

    DELETE FROM TiendasConsumidores WHERE RegionGeograficaID = OLD.RegionGeograficaID;
/*
    DELETE FROM NumeroDeConsumidores WHERE RegionGeograficaID = OLD.RegionGeograficaID;
    DELETE FROM NumeroDeTiendas WHERE RegionGeograficaID = OLD.RegionGeograficaID;
*/
    DELETE FROM RegionGeograficaObjetivo WHERE RegionGeograficaID = OLD.RegionGeograficaID;
    DELETE FROM Estadisticas WHERE RegionGeografica = OLD.RegionGeograficaID;
    DELETE FROM Dibujable WHERE DibujableID = OLD.Dibujable_P;
    /* OJO: Rastreable tiene que ser obligatoriamente el ultimo en eliminarse... sino va a haber problemas con el registro */
    DELETE FROM Rastreable WHERE RastreableID = OLD.Rastreable_P;
END $$

USE `Spuria`$$


CREATE TRIGGER t_RegionGeograficaModificarDespues AFTER UPDATE ON RegionGeografica
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE bobo INT;
    
    SELECT CONCAT('RegionGeografica(columna): ', CAST(NEW.RegionGeograficaID AS CHAR),'(') INTO Parametros;
    
    IF NEW.Nombre != OLD.Nombre THEN
        SELECT CONCAT(
            Parametros,
            'Nombre): ',
            OLD.Nombre,' ahora es ',
            NEW.Nombre
        ) INTO Parametros;
    
        SELECT RegistrarModificacion(NEW.Rastreable_P, Parametros) INTO bobo;
    END IF;
    
    IF NEW.Poblacion != OLD.Poblacion THEN
        SELECT CONCAT(
            Parametros,
            'Poblacion): ',
            OLD.Poblacion,' ahora es ',
            NEW.Poblacion
        ) INTO Parametros;
    
        SELECT RegistrarModificacion(NEW.Rastreable_P, Parametros) INTO bobo;
    END IF;
     
    IF NEW.Consumidores_Poblacion != OLD.Consumidores_Poblacion THEN
        SELECT CONCAT(
            Parametros,
            'Consumidores_Poblacion): ',
            OLD.Consumidores_Poblacion,' ahora es ',
            NEW.Consumidores_Poblacion
        ) INTO Parametros;
    
        SELECT RegistrarModificacion(NEW.Rastreable_P, Parametros) INTO bobo;
    END IF;
    
    IF NEW.Tiendas_Poblacion != OLD.Tiendas_Poblacion THEN
        SELECT CONCAT(
            Parametros,
            'Tiendas_Poblacion): ',
            OLD.Tiendas_Poblacion,' ahora es ',
            NEW.Tiendas_Poblacion
        ) INTO Parametros;
    
        SELECT RegistrarModificacion(NEW.Rastreable_P, Parametros) INTO bobo;
    END IF;

    IF NEW.Tiendas_Consumidores != OLD.Tiendas_Consumidores THEN
        SELECT CONCAT(
            Parametros,
            'Tiendas_Consumidores): ',
            OLD.Tiendas_Consumidores,' ahora es ',
            NEW.Tiendas_Consumidores
        ) INTO Parametros;
    
        SELECT RegistrarModificacion(NEW.Rastreable_P, Parametros) INTO bobo;
    END IF;    
END $$


DELIMITER ;

DELIMITER $$
USE `Spuria`$$


CREATE TRIGGER t_TamanoCrear AFTER INSERT ON Tamano
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE Cliente_P CHAR(10);
    DECLARE Rastreable_P, bobo INT;
    
    SELECT Tienda.Cliente_P FROM Tienda
    WHERE TiendaID = NEW.TiendaID
    INTO Cliente_P;
    
    SELECT CONCAT(
        'Cliente->Tienda->Tamano: ',
        Cliente_P,'->',
        CAST(NEW.TiendaID AS CHAR),'->',
        CAST(NEW.FechaInicio AS CHAR),': ',
        CAST(NEW.NumeroTotalDeProductos AS CHAR),',',
        CAST(NEW.CantidadTotalDeProductos AS CHAR),',',
        CAST(NEW.Tamano AS CHAR)
    ) INTO Parametros;
    
    SELECT Cliente.Rastreable_P FROM Cliente, Tienda
    WHERE TiendaID = NEW.TiendaID AND RIF = Cliente_P
    INTO Rastreable_P;
    
    SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
END $$

USE `Spuria`$$


CREATE TRIGGER t_TamanoModificarAntes BEFORE UPDATE ON Tamano
FOR EACH ROW
BEGIN
    IF NEW.TiendaID != OLD.TiendaID THEN
        SET NEW.TiendaID = OLD.TiendaID;
    END IF;
    IF NEW.FechaInicio != OLD.FechaInicio THEN
        SET NEW.FechaInicio = OLD.FechaInicio;
    END IF;
END $$

USE `Spuria`$$


CREATE TRIGGER t_TamanoModificarDespues AFTER UPDATE ON Tamano
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE Cliente_P CHAR(10);
    DECLARE Rastreable_P, bobo INT;
    
    SELECT Tienda.Cliente_P FROM Tienda
    WHERE TiendaID = NEW.TiendaID
    INTO Cliente_P;
        
    SELECT Cliente.Rastreable_P FROM Cliente
    WHERE RIF = Cliente_P
    INTO Rastreable_P;
        
    IF NEW.FechaFin != OLD.FechaFin THEN
        SELECT CONCAT(
            'Cliente->Tienda->Tamano(columna): ',
            Cliente_P,'->',
            CAST(NEW.TiendaID AS CHAR),'->',
            CAST(NEW.FechaInicio AS CHAR),'(FechaFin): ',
            CAST(OLD.FechaFin AS CHAR),' ahora es ',
            CAST(NEW.Tamano AS CHAR)
        ) INTO Parametros;

        SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
    END IF;
        
    IF NEW.NumeroTotalDeProductos != OLD.NumeroTotalDeProductos THEN
        SELECT CONCAT(
            'Cliente->Tienda->Tamano(columna): ',
            Cliente_P,'->',
            CAST(NEW.TiendaID AS CHAR),'->',
            CAST(NEW.FechaInicio AS CHAR),'(NumeroTotalDeProductos): ',
            CAST(OLD.NumeroTotalDeProductos AS CHAR),' ahora es ',
            CAST(NEW.NumeroTotalDeProductos AS CHAR)
        ) INTO Parametros;
        
        SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
    END IF;
    
    IF NEW.CantidadTotalDeProductos != OLD.CantidadTotalDeProductos THEN
        SELECT CONCAT(
            'Cliente->Tienda->Tamano(columna): ',
            Cliente_P,'->',
            CAST(NEW.TiendaID AS CHAR),'->',
            CAST(NEW.FechaInicio AS CHAR),'(CantidadTotalDeProductos): ',
            CAST(OLD.CantidadTotalDeProductos AS CHAR),' ahora es ',
            CAST(NEW.CantidadTotalDeProductos AS CHAR)
        ) INTO Parametros;
    
        SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
    END IF;
    
    IF NEW.Tamano != OLD.Tamano THEN
        SELECT CONCAT(
            'Cliente->Tienda->Tamano(columna): ',
            Cliente_P,'->',
            CAST(NEW.TiendaID AS CHAR),'->',
            CAST(NEW.FechaInicio AS CHAR),'(Tamano): ',
            CAST(OLD.Tamano AS CHAR),' ahora es ',
            CAST(NEW.Tamano AS CHAR)
        ) INTO Parametros;

        SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
    END IF;
END $$


DELIMITER ;

DELIMITER $$
USE `Spuria`$$


CREATE TRIGGER t_TurnoCrear AFTER INSERT ON Turno
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE Cliente_P CHAR(10);
    DECLARE Rastreable_P, bobo INT;
    
    SELECT Tienda.Cliente_P FROM Tienda
    WHERE TiendaID = NEW.TiendaID
    INTO Cliente_P;
    
    SELECT CONCAT(
        'Cliente->Tienda->HorarioDeTrabajo->Turno: ',
        Cliente_P,'->',
        CAST(NEW.TiendaID AS CHAR),'->',
        NEW.Dia,'->(',
        CAST(NEW.HoraDeApertura AS CHAR),',',
        CAST(NEW.HoraDeCierre AS CHAR),')'
    ) INTO Parametros;
    
    SELECT Cliente.Rastreable_P FROM Cliente, Tienda
    WHERE TiendaID = NEW.TiendaID AND RIF = Cliente_P
    INTO Rastreable_P;
    
    SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
END $$

USE `Spuria`$$


CREATE TRIGGER t_TurnoModificarAntes BEFORE UPDATE ON Turno
FOR EACH ROW
BEGIN
    IF NEW.TiendaID != OLD.TiendaID THEN
        SET NEW.TiendaID = OLD.TiendaID;
    END IF;
    IF NEW.Dia != OLD.Dia THEN
        SET NEW.Dia = OLD.Dia;
    END IF;
END $$

USE `Spuria`$$


CREATE TRIGGER t_TurnoModificarDespues AFTER UPDATE ON Turno
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE Cliente_P CHAR(10);
    DECLARE Rastreable_P, bobo INT;
    
    SELECT Tienda.Cliente_P FROM Tienda, Cliente
    WHERE TiendaID = NEW.TiendaID
    INTO Cliente_P, Rastreable_P;
    
    SELECT Cliente.Rastreable_P FROM Cliente
    WHERE RIF = Cliente_P
    INTO Rastreable_P;
            
    IF NEW.HoraDeApertura != OLD.HoraDeApertura THEN
        SELECT CONCAT(
            'Cliente->Tienda->HorarioDeTrabajo->Turno(columna): ',
            Cliente_P,'->',
            CAST(NEW.TiendaID AS CHAR),'->',
            NEW.Dia,'->(HoraDeApertura): ',
            CAST(OLD.HoraDeApertura AS CHAR),' ahora es ',
            CAST(NEW.HoraDeApertura AS CHAR)
        ) INTO Parametros;
    
        SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
    END IF;
    
    IF NEW.HoraDeCierre != OLD.HoraDeCierre THEN
        SELECT CONCAT(
            'Cliente->Tienda->HorarioDeTrabajo->Turno(columna): ',
            Cliente_P,'->',
            CAST(NEW.TiendaID AS CHAR),'->',
            NEW.Dia,'->(HoraDeCierre): ',
            CAST(OLD.HoraDeCierre AS CHAR),' ahora es ',
            CAST(NEW.HoraDeApertura AS CHAR)
        ) INTO Parametros;
    
        SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
    END IF;
END $$


DELIMITER ;

DELIMITER $$
USE `Spuria`$$


CREATE TRIGGER t_HorarioDeTrabajoEliminar BEFORE DELETE ON HorarioDeTrabajo
FOR EACH ROW
BEGIN
    DELETE FROM Turno WHERE TiendaID = OLD.TiendaID;
END $$

USE `Spuria`$$


CREATE TRIGGER t_HorarioDeTrabajoCrear AFTER INSERT ON HorarioDeTrabajo
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE Cliente_P CHAR(10);
    DECLARE Rastreable_P, bobo INT;
    
    SELECT Tienda.Cliente_P FROM Tienda
    WHERE TiendaID = NEW.TiendaID
    INTO Cliente_P;
    
    SELECT CONCAT(
        'Cliente->Tienda->HorarioDeTrabajo: ',
        Cliente_P,'->',
        CAST(NEW.TiendaID AS CHAR),'->(',
        NEW.Dia,',',
        CAST(NEW.Laborable AS CHAR),')'
    ) INTO Parametros;
    
    SELECT Cliente.Rastreable_P FROM Cliente, Tienda
    WHERE TiendaID = NEW.TiendaID AND RIF = Cliente_P
    INTO Rastreable_P;
    
    SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
END $$

USE `Spuria`$$


CREATE TRIGGER t_HorarioDeTrabajoModificarAntes BEFORE UPDATE ON HorarioDeTrabajo
FOR EACH ROW
BEGIN
    IF NEW.TiendaID != OLD.TiendaID THEN
        SET NEW.TiendaID = OLD.TiendaID;
    END IF;
    IF NEW.Dia != OLD.Dia THEN
        SET NEW.Dia = OLD.Dia;
    END IF;
END $$

USE `Spuria`$$


CREATE TRIGGER t_HorarioDeTrabajoModificarDespues AFTER UPDATE ON HorarioDeTrabajo
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE Cliente_P CHAR(10);
    DECLARE Rastreable_P, bobo INT;
    
    SELECT Tienda.Cliente_P FROM Tienda, Cliente
    WHERE TiendaID = NEW.TiendaID
    INTO Cliente_P, Rastreable_P;
    
    SELECT Cliente.Rastreable_P FROM Cliente
    WHERE RIF = Cliente_P
    INTO Rastreable_P;
            
    IF NEW.Laborable != OLD.Laborable THEN
        SELECT CONCAT(
            'Cliente->Tienda->HorarioDeTrabajo(columna): ',
            Cliente_P,'->',
            CAST(NEW.TiendaID AS CHAR),'->',
            NEW.Dia,'(Laborable): ',
            CAST(OLD.Laborable AS CHAR),' ahora es ',
            CAST(NEW.Laborable AS CHAR)
        ) INTO Parametros;
    
        SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
    END IF;
END $$


DELIMITER ;

DELIMITER $$
USE `Spuria`$$


CREATE TRIGGER t_PatrocinanteEliminar BEFORE DELETE ON Patrocinante
FOR EACH ROW
BEGIN
    DELETE FROM Publicidad WHERE Patrocinante = OLD.PatrocinanteID;
END $$

USE `Spuria`$$


CREATE TRIGGER t_PatrocinanteCrear AFTER INSERT ON Patrocinante
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE Rastreable_P, bobo INT;
    
    SELECT Cliente.Rastreable_P FROM Cliente
    WHERE RIF = NEW.Cliente_P
    INTO Rastreable_P;
    
    SELECT CONCAT(
        'Cliente->Patrocinante: ',
        CAST(NEW.Cliente_P AS CHAR),'->',
        CAST(NEW.PatrocinanteID AS CHAR)
    ) INTO Parametros;
    
    SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
END $$

USE `Spuria`$$


CREATE TRIGGER t_PatrocinanteModificarAntes BEFORE UPDATE ON Patrocinante
FOR EACH ROW
BEGIN
    IF NEW.Cliente_P != OLD.Cliente_P THEN
        SET NEW.Cliente_P = OLD.Cliente_P;
    END IF;
    IF NEW.PatrocinanteID != OLD.PatrocinanteID THEN
        SET NEW.PatrocinanteID = OLD.PatrocinanteID;
    END IF;
END $$


DELIMITER ;

DELIMITER $$
USE `Spuria`$$


CREATE TRIGGER t_GradoDeInstruccionObjetivoCrear AFTER INSERT ON GradoDeInstruccionObjetivo
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE Rastreable_P, bobo INT;
        
    SELECT CONCAT(
        'Publicidad->GradoDeInstruccionObjetivo: ',
        CAST(NEW.PublicidadID AS CHAR),'->',
        CAST(NEW.GradoDeInstruccion AS CHAR)
    ) INTO Parametros;
    
    SELECT Publicidad.Rastreable_P FROM Publicidad
    WHERE PublicidadID = NEW.PublicidadID
    INTO Rastreable_P;
    
    SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
END $$

USE `Spuria`$$


CREATE TRIGGER t_GradoDeInstruccionObjetivoModificarAntes BEFORE UPDATE ON GradoDeInstruccionObjetivo
FOR EACH ROW
BEGIN
    IF NEW.PublicidadID != OLD.PublicidadID THEN
        SET NEW.PublicidadID = OLD.PublicidadID;
    END IF;
END $$

USE `Spuria`$$


CREATE TRIGGER t_GradoDeInstruccionObjetivoModificarDespues AFTER UPDATE ON GradoDeInstruccionObjetivo
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE Rastreable_P, bobo INT;
    
    SELECT Publicidad.Rastreable_P FROM Publicidad
    WHERE PublicidadID = NEW.PublicidadID
    INTO Rastreable_P;
        
    IF NEW.GradoDeInstruccion != OLD.GradoDeInstruccion THEN
        SELECT CONCAT(
            'Publicidad->GradoDeInstruccionObjetivo(columna): ',
            CAST(NEW.PublicidadID AS CHAR),'->(',
            CAST(NEW.PublicidadID AS CHAR),',',
            CAST(NEW.GradoDeInstruccion AS CHAR),'(GradoDeInstruccion): ',
            CAST(OLD.GradoDeInstruccion AS CHAR),' ahora es ',
            CAST(NEW.GradoDeInstruccion AS CHAR)
        ) INTO Parametros;
        
        SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
    END IF;
END $$


DELIMITER ;

DELIMITER $$
USE `Spuria`$$


CREATE TRIGGER t_SexoObjetivoCrear AFTER INSERT ON SexoObjetivo
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE Rastreable_P, bobo INT;
        
    SELECT CONCAT(
        'Publicidad->SexoObjetivo: ',
        CAST(NEW.PublicidadID AS CHAR),'->',
        CAST(NEW.Sexo AS CHAR)
    ) INTO Parametros;
    
    SELECT Publicidad.Rastreable_P FROM Publicidad
    WHERE PublicidadID = NEW.PublicidadID
    INTO Rastreable_P;
    
    SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
END $$

USE `Spuria`$$


CREATE TRIGGER t_SexoObjetivoModificarAntes BEFORE UPDATE ON SexoObjetivo
FOR EACH ROW
BEGIN
    IF NEW.PublicidadID != OLD.PublicidadID THEN
        SET NEW.PublicidadID = OLD.PublicidadID;
    END IF;
END $$

USE `Spuria`$$


CREATE TRIGGER t_SexoObjetivoModificarDespues AFTER UPDATE ON SexoObjetivo
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE Rastreable_P, bobo INT;
    
    SELECT Publicidad.Rastreable_P FROM Publicidad
    WHERE PublicidadID = NEW.PublicidadID
    INTO Rastreable_P;
        
    IF NEW.Sexo != OLD.Sexo THEN
        SELECT CONCAT(
            'Publicidad->SexoObjetivo(columna): ',
            CAST(NEW.PublicidadID AS CHAR),'->(',
            CAST(NEW.PublicidadID AS CHAR),',',
            NEW.Sexo,')(Sexo): ',
            CAST(OLD.Sexo AS CHAR),' ahora es ',
            CAST(NEW.Sexo AS CHAR)
        ) INTO Parametros;
        
        SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
    END IF;
END $$


DELIMITER ;

DELIMITER $$
USE `Spuria`$$


CREATE TRIGGER t_GrupoDeEdadObjetivoCrear AFTER INSERT ON GrupoDeEdadObjetivo
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE Rastreable_P, bobo INT;
        
    SELECT CONCAT(
        'Publicidad->GrupoDeEdadObjetivo: ',
        CAST(NEW.PublicidadID AS CHAR),'->',
        CAST(NEW.GrupoDeEdad AS CHAR)
    ) INTO Parametros;
    
    SELECT Publicidad.Rastreable_P FROM Publicidad
    WHERE PublicidadID = NEW.PublicidadID
    INTO Rastreable_P;
    
    SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
END $$

USE `Spuria`$$


CREATE TRIGGER t_GrupoDeEdadObjetivoModificarAntes BEFORE UPDATE ON GrupoDeEdadObjetivo
FOR EACH ROW
BEGIN
    IF NEW.PublicidadID != OLD.PublicidadID THEN
        SET NEW.PublicidadID = OLD.PublicidadID;
    END IF;
END $$

USE `Spuria`$$


CREATE TRIGGER t_GrupoDeEdadObjetivoModificarDespues AFTER UPDATE ON GrupoDeEdadObjetivo
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE Rastreable_P, bobo INT;
    
    SELECT Publicidad.Rastreable_P FROM Publicidad
    WHERE PublicidadID = NEW.PublicidadID
    INTO Rastreable_P;
        
    IF NEW.GrupoDeEdad != OLD.GrupoDeEdad THEN
        SELECT CONCAT(
            'Publicidad->GrupoDeEdadObjetivo(columna): ',
            CAST(NEW.PublicidadID AS CHAR),'->(',
            CAST(NEW.PublicidadID AS CHAR),',',
            CAST(NEW.GrupoDeEdad AS CHAR),'(GrupoDeEdad): ',
            CAST(OLD.GrupoDeEdad AS CHAR),' ahora es ',
            CAST(NEW.GrupoDeEdad AS CHAR)
        ) INTO Parametros;
        
        SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
    END IF;
END $$


DELIMITER ;

DELIMITER $$
USE `Spuria`$$


CREATE TRIGGER t_RegionGeograficaObjetivoCrear AFTER INSERT ON RegionGeograficaObjetivo
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE Rastreable_P, bobo INT;
        
    SELECT CONCAT(
        'Publicidad->RegionGeograficaObjetivo: ',
        CAST(NEW.PublicidadID AS CHAR),'->',
        CAST(NEW.RegionGeograficaID AS CHAR)
    ) INTO Parametros;
    
    SELECT Publicidad.Rastreable_P FROM Publicidad
    WHERE PublicidadID = NEW.PublicidadID
    INTO Rastreable_P;
    
    SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
END $$

USE `Spuria`$$


CREATE TRIGGER t_RegionGeograficaObjetivoModificarAntes BEFORE UPDATE ON RegionGeograficaObjetivo
FOR EACH ROW
BEGIN
    IF NEW.PublicidadID != OLD.PublicidadID THEN
        SET NEW.PublicidadID = OLD.PublicidadID;
    END IF;
END $$

USE `Spuria`$$


CREATE TRIGGER t_RegionGeograficaObjetivoModificarDespues AFTER UPDATE ON RegionGeograficaObjetivo
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE Rastreable_P, bobo INT;
    
    SELECT Publicidad.Rastreable_P FROM Publicidad
    WHERE PublicidadID = NEW.PublicidadID
    INTO Rastreable_P;
        
    IF NEW.RegionGeograficaID != OLD.RegionGeograficaID THEN
        SELECT CONCAT(
            'Publicidad->RegionGeograficaObjetivo(columna): ',
            CAST(NEW.PublicidadID AS CHAR),'->(',
            CAST(NEW.PublicidadID AS CHAR),',',
            CAST(NEW.RegionGeograficaID AS CHAR),')(RegionGeograficaID): ',
            CAST(OLD.RegionGeograficaID AS CHAR),' ahora es ',
            CAST(NEW.RegionGeograficaID AS CHAR)
        ) INTO Parametros;
        
        SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
    END IF;
END $$


DELIMITER ;

DELIMITER $$
USE `Spuria`$$


CREATE TRIGGER t_ConsumidorObjetivoCrear AFTER INSERT ON ConsumidorObjetivo
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE Rastreable_P, bobo INT;
        
    SELECT CONCAT(
        'Publicidad->ConsumidorObjetivo: ',
        CAST(NEW.PublicidadID AS CHAR),'->',
        CAST(NEW.ConsumidorID AS CHAR)
    ) INTO Parametros;
    
    SELECT Publicidad.Rastreable_P FROM Publicidad
    WHERE PublicidadID = NEW.PublicidadID
    INTO Rastreable_P;
    
    SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
END $$

USE `Spuria`$$


CREATE TRIGGER t_ConsumidorObjetivoModificarAntes BEFORE UPDATE ON ConsumidorObjetivo
FOR EACH ROW
BEGIN
    IF NEW.PublicidadID != OLD.PublicidadID THEN
        SET NEW.PublicidadID = OLD.PublicidadID;
    END IF;
END $$

USE `Spuria`$$


CREATE TRIGGER t_ConsumidorObjetivoModificarDespues AFTER UPDATE ON ConsumidorObjetivo
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE Rastreable_P, bobo INT;
    
    SELECT Publicidad.Rastreable_P FROM Publicidad
    WHERE PublicidadID = NEW.PublicidadID
    INTO Rastreable_P;
        
    IF NEW.ConsumidorID != OLD.ConsumidorID THEN
        SELECT CONCAT(
            'Publicidad->ConsumidorObjetivo(columna): ',
            CAST(NEW.PublicidadID AS CHAR),'->(',
            CAST(NEW.PublicidadID AS CHAR),',',
            CAST(NEW.ConsumidorID AS CHAR),'(ConsumidorID): ',
            CAST(OLD.ConsumidorID AS CHAR),' ahora es ',
            CAST(NEW.ConsumidorID AS CHAR)
        ) INTO Parametros;
        
        SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
    END IF;
END $$


DELIMITER ;

DELIMITER $$
USE `Spuria`$$


CREATE TRIGGER t_CroquisCrear AFTER INSERT ON Croquis
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE bobo INT;
    
    SELECT CONCAT(
        'Croquis: ',
        CAST(NEW.Rastreable_P AS CHAR),',',
        CAST(NEW.CroquisID AS CHAR),',',
        CAST(NEW.Area AS CHAR),',',
        CAST(NEW.Perimetro AS CHAR)
    ) INTO Parametros;
    
    SELECT RegistrarCreacion(NEW.Rastreable_P, Parametros) INTO bobo;
END $$

USE `Spuria`$$


CREATE TRIGGER t_CroquisEliminar BEFORE DELETE ON Croquis
FOR EACH ROW
BEGIN
    DECLARE bobo INT;

    SELECT RegistrarEliminacion(OLD.Rastreable_P, CONCAT('Croquis: ', OLD.CroquisID)) INTO bobo;

    DELETE FROM PuntoDeCroquis WHERE CroquisID = OLD.CroquisID;
    /* OJO: Rastreable tiene que ser obligatoriamente el ultimo en eliminarse... sino va a haber problemas con el registro */
    DELETE FROM Rastreable WHERE RastreableID = OLD.Rastreable_P;
END$$

USE `Spuria`$$


CREATE TRIGGER t_CroquisModificarAntes BEFORE UPDATE ON Croquis
FOR EACH ROW
BEGIN
    IF NEW.Rastreable_P != OLD.Rastreable_P THEN
        SET NEW.Rastreable_P = OLD.Rastreable_P;
    END IF;
    IF NEW.CroquisID != OLD.CroquisID THEN
        SET NEW.CroquisID = OLD.CroquisID;
    END IF;
END $$

USE `Spuria`$$


CREATE TRIGGER t_CroquisModificarDespues AFTER UPDATE ON Croquis
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE bobo INT;
    
    IF NEW.Area != OLD.Area THEN
        SELECT CONCAT(
            'Croquis(columna): ',
            CAST(NEW.CroquisID AS CHAR),'(Area): ',
            CAST(OLD.Area AS CHAR),' ahora es ',
            CAST(NEW.Area AS CHAR)
        ) INTO Parametros;
        
        SELECT RegistrarModificacion(NEW.Rastreable_P, Parametros) INTO bobo;
    END IF;
    
    IF NEW.Perimetro != OLD.Perimetro THEN
        SELECT CONCAT(
            'Croquis(columna): ',
            CAST(NEW.CroquisID AS CHAR),'(Perimetro): ',
            CAST(OLD.Perimetro AS CHAR),' ahora es ',
            CAST(NEW.Perimetro AS CHAR)
        ) INTO Parametros;
        
        SELECT RegistrarModificacion(NEW.Rastreable_P, Parametros) INTO bobo;
    END IF;
END $$


DELIMITER ;

DELIMITER $$
USE `Spuria`$$


CREATE TRIGGER t_PuntoEliminar BEFORE DELETE ON Punto
FOR EACH ROW
BEGIN
    DELETE FROM PuntoDeCroquis WHERE PuntoID = OLD.PuntoID;
END$$

USE `Spuria`$$


CREATE TRIGGER t_PuntoModificarAntes BEFORE UPDATE ON Punto
FOR EACH ROW
BEGIN
    IF NEW.PuntoID != OLD.PuntoID THEN
        SET NEW.PuntoID = OLD.PuntoID;
    END IF;
    IF NEW.Latitud != OLD.Latitud THEN
        SET NEW.Latitud = OLD.Latitud;
    END IF;
    IF NEW.Longitud!= OLD.Longitud THEN
        SET NEW.Longitud = OLD.Longitud;
    END IF;
END $$


DELIMITER ;

DELIMITER $$
USE `Spuria`$$


CREATE TRIGGER t_PuntoDeCroquisCrear AFTER INSERT ON PuntoDeCroquis
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE Rastreable_P, Lat, Lon, bobo INT;

    SELECT Croquis.Rastreable_P FROM Croquis
    WHERE CroquisID = NEW.CroquisID
    INTO Rastreable_P;

    SELECT Latitud FROM Punto
    WHERE PuntoID = NEW.PuntoID
    INTO Lat;
    
    SELECT Longitud FROM Punto
    WHERE PuntoID = NEW.PuntoID
    INTO Lon;
    
    SELECT CONCAT(
        'Croquis->PuntoDeCroquis: ',
        CAST(NEW.CroquisID AS CHAR),'->(',
        CAST(NEW.CroquisID AS CHAR),',',
        CAST(NEW.PuntoID AS CHAR),'): ',
        CAST(Lat AS CHAR),' lat, ',
        CAST(Lon AS CHAR),' lon'
    ) INTO Parametros;
    
    SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
END $$

USE `Spuria`$$


CREATE TRIGGER t_PuntoDeCroquisModificarAntes BEFORE UPDATE ON PuntoDeCroquis
FOR EACH ROW
BEGIN
    IF NEW.CroquisID != OLD.CroquisID THEN
        SET NEW.CroquisID = OLD.CroquisID;
    END IF;
    IF NEW.PuntoID != OLD.PuntoID THEN
        SET NEW.PuntoID = OLD.PuntoID;
    END IF;
END $$


DELIMITER ;

DELIMITER $$
USE `Spuria`$$


CREATE TRIGGER t_DibujableEliminar BEFORE DELETE ON Dibujable
FOR EACH ROW
BEGIN
    DELETE FROM Croquis WHERE CroquisID = OLD.DibujableID;
END $$

USE `Spuria`$$


CREATE TRIGGER t_DibujableModificarAntes BEFORE UPDATE ON Dibujable
FOR EACH ROW
BEGIN
    IF NEW.DibujableID != OLD.DibujableID THEN
        SET NEW.DibujableID = OLD.DibujableID;
    END IF;
END $$


DELIMITER ;

DELIMITER $$
USE `Spuria`$$


CREATE TRIGGER t_FacturaCrear AFTER INSERT ON Factura
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE bobo INT;
    
    SELECT CONCAT(
        'Factura: ',
        CAST(NEW.Rastreable_P AS CHAR),',',
        CAST(NEW.FacturaID AS CHAR),',',
        NEW.Cliente,',',
        CAST(NEW.InicioDeMedicion AS CHAR),',',
        CAST(NEW.FinDeMedicion AS CHAR),',',
        CAST(NEW.Subtotal AS CHAR),',',
        CAST(NEW.Impuestos AS CHAR),',',
        CAST(NEW.Total AS CHAR)
    ) INTO Parametros;
    
    SELECT RegistrarCreacion(NEW.Rastreable_P, Parametros) INTO bobo;
END $$

USE `Spuria`$$


CREATE TRIGGER t_FacturaModificarAntes BEFORE UPDATE ON Factura
FOR EACH ROW
BEGIN
    IF NEW.Rastreable_P != OLD.Rastreable_P THEN
        SET NEW.Rastreable_P = OLD.Rastreable_P;
    END IF;
    IF NEW.FacturaID != OLD.FacturaID THEN
        SET NEW.FacturaID = OLD.FacturaID;
    END IF;
    IF NEW.Cliente != OLD.Cliente THEN
        SET NEW.Cliente = OLD.Cliente;
    END IF;
    IF NEW.InicioDeMedicion != OLD.InicioDeMedicion THEN
        SET NEW.InicioDeMedicion = OLD.InicioDeMedicion;
    END IF;
    IF NEW.FinDeMedicion != OLD.FinDeMedicion THEN
        SET NEW.FinDeMedicion = OLD.FinDeMedicion;
    END IF;
END $$

USE `Spuria`$$


CREATE TRIGGER t_FacturaModificarDespues AFTER UPDATE ON Factura
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE bobo INT;
    
    IF NEW.Subtotal != OLD.Subtotal THEN
        SELECT CONCAT(
            'Factura(columna): ', 
            CAST(NEW.FacturaID AS CHAR),'(Subtotal)',
            CAST(NEW.Subtotal AS CHAR),' ahora es ',
            CAST(NEW.Subtotal AS CHAR)
        ) INTO Parametros;

        SELECT RegistrarModificacion(NEW.Rastreable_P, Parametros) INTO bobo;
    END IF;
    
    IF NEW.Impuestos != OLD.Impuestos THEN
        SELECT CONCAT(
            'Factura(columna): ', 
            CAST(NEW.FacturaID AS CHAR),'(Impuestos)',
            CAST(NEW.Impuestos AS CHAR),' ahora es ',
            CAST(NEW.Impuestos AS CHAR)
        ) INTO Parametros;
    
        SELECT RegistrarModificacion(NEW.Rastreable_P, Parametros) INTO bobo;
    END IF;
    
    IF NEW.Total != OLD.Total THEN
        SELECT CONCAT(
            'Factura(columna): ', 
            CAST(NEW.FacturaID AS CHAR),'(Total)',
            CAST(NEW.Total AS CHAR),' ahora es ',
            CAST(NEW.Total AS CHAR)
        ) INTO Parametros;
    
        SELECT RegistrarModificacion(NEW.Rastreable_P, Parametros) INTO bobo;
    END IF;
END $$

USE `Spuria`$$


CREATE TRIGGER t_FacturaEliminar BEFORE DELETE ON Factura
FOR EACH ROW
BEGIN
    DECLARE bobo INT;
    
    SELECT RegistrarEliminacion(OLD.Rastreable_P, CONCAT('Factura: ', CAST(OLD.FacturaID AS CHAR), ' de ', OLD.Cliente)) INTO bobo;

    DELETE FROM ServicioVendido WHERE FacturaID = OLD.FacturaID;
    /* OJO: Rastreable tiene que ser obligatoriamente el ultimo en eliminarse... sino va a haber problemas con el registro */
    DELETE FROM Rastreable WHERE RastreableID = OLD.Rastreable_P;
END $$


DELIMITER ;

DELIMITER $$
USE `Spuria`$$


CREATE TRIGGER t_ServicioVendidoModificar AFTER UPDATE ON ServicioVendido
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE Rastreable_P, bobo INT;
    
    IF NEW.Acumulado != OLD.Acumulado THEN
        SELECT CONCAT(
            'Factura->ServicioVendido(columna): ',
            CAST(NEW.FacturaID AS CHAR),'->(',
            CAST(NEW.FacturaID AS CHAR),',',
            CAST(NEW.CobrableID AS CHAR),')(Acumulado): ',
            CAST(OLD.Acumulado AS CHAR), ' ahora es ',
            CAST(NEW.Acumulado AS CHAR)
        ) INTO Parametros;
    
        SELECT Factura.Rastreable_P FROM Factura
        WHERE FacturaID = NEW.FacturaID
        INTO Rastreable_P;
    
        SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
    END IF;
END $$

USE `Spuria`$$


CREATE TRIGGER t_ServicioVendidoCrear AFTER INSERT ON ServicioVendido
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE Rastreable_P, bobo INT;
    
    SELECT CONCAT(
        'Factura->ServicioVendido: ',
        CAST(NEW.FacturaID AS CHAR),'->(',
        CAST(NEW.FacturaID AS CHAR),',',
        CAST(NEW.CobrableID AS CHAR),'),',
        CAST(NEW.Acumulado AS CHAR)
    ) INTO Parametros;
    
    SELECT Factura.Rastreable_P FROM Factura
    WHERE FacturaID = NEW.FacturaID
    INTO Rastreable_P;
    
    SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
END $$

USE `Spuria`$$


CREATE TRIGGER t_ServicioVendidoModificarAntes BEFORE UPDATE ON ServicioVendido
FOR EACH ROW
BEGIN
    IF NEW.FacturaID != OLD.FacturaID THEN
        SET NEW.FacturaID = OLD.FacturaID;
    END IF;
    IF NEW.CobrableID != OLD.CobrableID THEN
        SET NEW.CobrableID = OLD.CobrableID;
    END IF;
END $$


DELIMITER ;

DELIMITER $$
USE `Spuria`$$


CREATE TRIGGER t_CobrableEliminar BEFORE DELETE ON Cobrable
FOR EACH ROW
BEGIN
    DELETE FROM ServicioVendido WHERE CobrableID = OLD.CobrableID;
END $$

USE `Spuria`$$


CREATE TRIGGER t_CobrableModificarAntes BEFORE UPDATE ON Cobrable
FOR EACH ROW
BEGIN
    IF NEW.CobrableID != OLD.CobrableID THEN
        SET NEW.CobrableID = OLD.CobrableID;
    END IF;
END $$


DELIMITER ;

DELIMITER $$
USE `Spuria`$$


CREATE TRIGGER t_MunicipioEliminar BEFORE DELETE ON Municipio
FOR EACH ROW
BEGIN
    DELETE FROM Parroquia WHERE Municipio = OLD.MunicipioID;
    DELETE FROM RegionGeografica WHERE RegionGeograficaID = OLD.RegionGeografica_P;
END $$

USE `Spuria`$$


CREATE TRIGGER t_MunicipioCrear AFTER INSERT ON Municipio
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE Rastreable_P, bobo INT;

    SELECT CONCAT(
        'RegionGeografica->Municipio: ',
        CAST(NEW.RegionGeografica_P AS CHAR),'->',
        CAST(NEW.MunicipioID AS CHAR),',',
        CAST(NEW.Estado AS CHAR)
    ) INTO Parametros;
    
    SELECT RegionGeografica.Rastreable_P FROM RegionGeografica
    WHERE RegionGeograficaID = NEW.RegionGeografica_P
    INTO Rastreable_P;
    
    SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
END $$

USE `Spuria`$$


CREATE TRIGGER t_MunicipioModificarAntes BEFORE UPDATE ON Municipio
FOR EACH ROW
BEGIN
    IF NEW.RegionGeografica_P != OLD.RegionGeografica_P THEN
        SET NEW.RegionGeografica_P = OLD.RegionGeografica_P;
    END IF;
    IF NEW.MunicipioID != OLD.MunicipioID THEN
        SET NEW.MunicipioID = OLD.MunicipioID;
    END IF;
END $$

USE `Spuria`$$


CREATE TRIGGER t_MunicipioModificarDespues AFTER UPDATE ON Municipio
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE Rastreable_P, bobo INT;
    
    SELECT RegionGeografica.Rastreable_P FROM RegionGeografica
    WHERE NEW.RegionGeografica_P = RegionGeograficaID
    INTO Rastreable_P;
    
    IF NEW.Estado != OLD.Estado THEN
        SELECT CONCAT(
            'RegionGeografica->Municipio(columna): ',
            CAST(NEW.RegionGeografica_P AS CHAR),'->',
            CAST(NEW.MunicipioID AS CHAR),'(Estado):',
            CAST(OLD.Estado AS CHAR),' ahora es ',
            CAST(NEW.Estado AS CHAR)
        ) INTO Parametros;
    
        SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
    END IF;

    IF NEW.Ciudad != OLD.Ciudad THEN
        SELECT CONCAT(
            'RegionGeografica->Municipio(columna): ',
            CAST(NEW.RegionGeografica_P AS CHAR),'->',
            CAST(NEW.MunicipioID AS CHAR),'(Ciudad):',
            CAST(OLD.Ciudad AS CHAR),' ahora es ',
            CAST(NEW.Ciudad AS CHAR)
        ) INTO Parametros;
    
        SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
    END IF;
END $$


DELIMITER ;

DELIMITER $$
USE `Spuria`$$


CREATE TRIGGER t_EstadoEliminar BEFORE DELETE ON Estado
FOR EACH ROW
BEGIN
    DELETE FROM Municipio WHERE Estado = OLD.EstadoID;
    DELETE FROM RegionGeografica WHERE RegionGeograficaID = OLD.RegionGeografica_P;
END $$

USE `Spuria`$$


CREATE TRIGGER t_EstadoCrear AFTER INSERT ON Estado
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE Rastreable_P, bobo INT;

    SELECT CONCAT(
        'RegionGeografica->Estado: ',
        CAST(NEW.RegionGeografica_P AS CHAR),'->',
        CAST(NEW.EstadoID AS CHAR),',',
        CAST(NEW.Pais AS CHAR),',',
        CAST(NEW.HusoHorarioNormal AS CHAR)
    ) INTO Parametros;
    
    SELECT RegionGeografica.Rastreable_P FROM RegionGeografica
    WHERE RegionGeograficaID = NEW.RegionGeografica_P
    INTO Rastreable_P;
    
    SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
END $$

USE `Spuria`$$


CREATE TRIGGER t_EstadoModificarAntes BEFORE UPDATE ON Estado
FOR EACH ROW
BEGIN
    IF NEW.RegionGeografica_P != OLD.RegionGeografica_P THEN
        SET NEW.RegionGeografica_P = OLD.RegionGeografica_P;
    END IF;
    IF NEW.EstadoID != OLD.EstadoID THEN
        SET NEW.EstadoID = OLD.EstadoID;
    END IF;
    IF NEW.Pais != OLD.Pais THEN
        SET NEW.Pais = OLD.Pais;
    END IF;
END $$

USE `Spuria`$$


CREATE TRIGGER t_EstadoModificarDespues AFTER UPDATE ON Estado
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE Rastreable_P, bobo INT;
    
    SELECT RegionGeografica.Rastreable_P FROM RegionGeografica
    WHERE NEW.RegionGeografica_P = RegionGeograficaID
    INTO Rastreable_P;
    
    IF NEW.HusoHorarioNormal != OLD.HusoHorarioNormal THEN
        SELECT CONCAT(
            'RegionGeografica->Estado(columna): ',
            CAST(NEW.RegionGeografica_P AS CHAR),'->',
            CAST(NEW.EstadoID AS CHAR),'(HusoHorarioNormal):',
            CAST(OLD.HusoHorarioNormal AS CHAR),' ahora es ',
            CAST(NEW.HusoHorarioNormal AS CHAR)
        ) INTO Parametros;
    
        SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
    END IF;

    IF NEW.HusoHorarioVerano != OLD.HusoHorarioVerano THEN
        SELECT CONCAT(
            'RegionGeografica->Estado(columna): ',
            CAST(NEW.RegionGeografica_P AS CHAR),'->',
            CAST(NEW.EstadoID AS CHAR),'(HusoHorarioVerano):',
            CAST(OLD.HusoHorarioVerano AS CHAR),' ahora es ',
            CAST(NEW.HusoHorarioVerano AS CHAR)
        ) INTO Parametros;
    
        SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
    END IF;
 END $$


DELIMITER ;

DELIMITER $$
USE `Spuria`$$


CREATE TRIGGER t_CiudadCrear AFTER INSERT ON Ciudad
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE Rastreable_P, bobo INT;

    SELECT CONCAT(
        'RegionGeografica->Ciudad: ',
        CAST(NEW.RegionGeografica_P AS CHAR),'->',
        CAST(NEW.CiudadID AS CHAR)        
    ) INTO Parametros;
    
    SELECT RegionGeografica.Rastreable_P FROM RegionGeografica
    WHERE RegionGeograficaID = NEW.RegionGeografica_P
    INTO Rastreable_P;

    SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
END $$

USE `Spuria`$$


CREATE TRIGGER t_CiudadEliminar BEFORE DELETE ON Ciudad
FOR EACH ROW
BEGIN
    UPDATE Municipio SET Ciudad = NULL WHERE Ciudad = OLD.CiudadID;
    DELETE FROM RegionGeografica WHERE RegionGeograficaID = OLD.RegionGeografica_P;
END $$

USE `Spuria`$$


CREATE TRIGGER t_CiudadModificarAntes BEFORE UPDATE ON Ciudad
FOR EACH ROW
BEGIN
    IF NEW.RegionGeografica_P != OLD.RegionGeografica_P THEN
        SET NEW.RegionGeografica_P = OLD.RegionGeografica_P;
    END IF;
    IF NEW.CiudadID != OLD.CiudadID THEN
        SET NEW.CiudadID = OLD.CiudadID;
    END IF;
END $$


DELIMITER ;

DELIMITER $$
USE `Spuria`$$


CREATE TRIGGER t_ContinenteEliminar BEFORE DELETE ON Continente
FOR EACH ROW
BEGIN
    DELETE FROM Subcontinente WHERE Continente = OLD.ContinenteID;
    DELETE FROM Pais WHERE Continente = OLD.ContinenteID;
    DELETE FROM RegionGeografica WHERE RegionGeograficaID = OLD.RegionGeografica_P;
END $$

USE `Spuria`$$


CREATE TRIGGER t_ContinenteCrear AFTER INSERT ON Continente
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE Rastreable_P, bobo INT;

    SELECT CONCAT(
        'RegionGeografica->Continente: ',
        CAST(NEW.RegionGeografica_P AS CHAR),'->',
        CAST(NEW.ContinenteID AS CHAR)        
    ) INTO Parametros;

    SELECT RegionGeografica.Rastreable_P FROM RegionGeografica
    WHERE RegionGeograficaID = NEW.RegionGeografica_P
    INTO Rastreable_P;
    
    SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
END $$

USE `Spuria`$$


CREATE TRIGGER t_ContinenteModificarAntes BEFORE UPDATE ON Continente
FOR EACH ROW
BEGIN
    IF NEW.RegionGeografica_P != OLD.RegionGeografica_P THEN
        SET NEW.RegionGeografica_P = OLD.RegionGeografica_P;
    END IF;
    IF NEW.ContinenteID != OLD.ContinenteID THEN
        SET NEW.ContinenteID = OLD.ContinenteID;
    END IF;
END $$


DELIMITER ;

DELIMITER $$
USE `Spuria`$$


CREATE TRIGGER t_SubcontinenteCrear AFTER INSERT ON Subcontinente
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE Rastreable_P, bobo INT;

    SELECT CONCAT(
        'RegionGeografica->Subcontinente: ',
        CAST(NEW.RegionGeografica_P AS CHAR),'->',
        CAST(NEW.SubcontinenteID AS CHAR)        
    ) INTO Parametros;
    
    SELECT RegionGeografica.Rastreable_P FROM RegionGeografica
    WHERE RegionGeograficaID = NEW.RegionGeografica_P
    INTO Rastreable_P;
    
    SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
END $$

USE `Spuria`$$


CREATE TRIGGER t_SubcontinenteModificarAntes BEFORE UPDATE ON Subcontinente
FOR EACH ROW
BEGIN
    IF NEW.RegionGeografica_P != OLD.RegionGeografica_P THEN
        SET NEW.RegionGeografica_P = OLD.RegionGeografica_P;
    END IF;
    IF NEW.SubcontinenteID != OLD.SubcontinenteID THEN
        SET NEW.SubcontinenteID = OLD.SubcontinenteID;
    END IF;
    IF NEW.Continente != OLD.Continente THEN
        SET NEW.Continente = OLD.Continente;
    END IF;
END $$

USE `Spuria`$$


CREATE TRIGGER t_SubcontinenteEliminar BEFORE DELETE ON Subcontinente
FOR EACH ROW
BEGIN
    DELETE FROM PaisSubcontinente WHERE SubcontinenteID = OLD.SubcontinenteID;
    DELETE FROM RegionGeografica WHERE RegionGeograficaID = OLD.RegionGeografica_P;
END $$


DELIMITER ;

DELIMITER $$
USE `Spuria`$$


CREATE TRIGGER t_PaisSubcontinenteCrear AFTER INSERT ON PaisSubcontinente
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE RegionGeografica_P, Rastreable_P, bobo INT;

    SELECT RegionGeografica.RegionGeograficaID, RegionGeografica.Rastreable_P FROM RegionGeografica, Subcontinente
    WHERE RegionGeograficaID = Subcontinente.RegionGeografica_P AND Subcontinente.SubcontinenteID = NEW.SubcontinenteID
    INTO RegionGeografica_P, Rastreable_P;
    
    SELECT CONCAT(
        'RegionGeografica->Subcontinente->PaisSubcontinente: ',
        CAST(RegionGeografica_P AS CHAR),'->',
        CAST(NEW.SubcontinenteID AS CHAR),'->(',
        CAST(NEW.SubcontinenteID AS CHAR),',',
        CAST(NEW.PaisID AS CHAR),')'
    ) INTO Parametros;
    
    SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
END $$

USE `Spuria`$$


CREATE TRIGGER t_PaisSubcontinenteModificarAntes BEFORE UPDATE ON PaisSubcontinente
FOR EACH ROW
BEGIN
    IF NEW.SubcontinenteID != OLD.SubcontinenteID THEN
        SET NEW.SubcontinenteID = OLD.SubcontinenteID;
    END IF;
    IF NEW.PaisID != OLD.PaisID THEN
        SET NEW.PaisID = OLD.PaisID;
    END IF;
END $$


DELIMITER ;

DELIMITER $$
USE `Spuria`$$


CREATE TRIGGER t_AdministradorCrear AFTER INSERT ON Administrador
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE bobo INT;
    
    SELECT CONCAT(
        'Administrador: ',
        CAST(NEW.Rastreable_P AS CHAR),',',
        CAST(NEW.Usuario_P AS CHAR),',',
        CAST(NEW.AdministradorID AS CHAR),',',
        NEW.Estatus,',',
        NEW.Privilegios,',',
        NEW.Nombre,',',
        NEW.Apellido
    ) INTO Parametros;
    
    SELECT RegistrarCreacion(NEW.Rastreable_P, Parametros) INTO bobo;
END $$

USE `Spuria`$$


CREATE TRIGGER t_AdministradorEliminar BEFORE DELETE ON Administrador
FOR EACH ROW
BEGIN
    DECLARE bobo INT;
    
    SELECT RegistrarEliminacion(OLD.Rastreable_P, CONCAT('Administrador: ', OLD.Nombre, ' ', OLD.Apellido)) INTO bobo;
        
    DELETE FROM Usuario WHERE UsuarioID = OLD.Usuario_P;
    /* OJO: Rastreable tiene que ser obligatoriamente el ultimo en eliminarse... sino va a haber problemas con el registro */
    DELETE FROM Rastreable WHERE RastreableID = OLD.Rastreable_P;
END $$

USE `Spuria`$$


CREATE TRIGGER t_AdministradorModificarAntes BEFORE UPDATE ON Administrador
FOR EACH ROW
BEGIN
    IF NEW.Rastreable_P != OLD.Rastreable_P THEN
        SET NEW.Rastreable_P = OLD.Rastreable_P;
    END IF;
    IF NEW.Usuario_P != OLD.Usuario_P THEN
        SET NEW.Usuario_P = OLD.Usuario_P;
    END IF;
    IF NEW.AdministradorID != OLD.AdministradorID THEN
        SET NEW.AdministradorID = OLD.AdministradorID;
    END IF;
    IF NEW.Nombre != OLD.Nombre THEN
        SET NEW.Nombre = OLD.Nombre;
    END IF;
    IF NEW.Apellido != OLD.Apellido THEN
        SET NEW.Apellido = OLD.Apellido;
    END IF;
END $$

USE `Spuria`$$


CREATE TRIGGER t_AdministradorModificarDespues AFTER UPDATE ON Administrador
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE bobo INT;
    
    IF NEW.Estatus != OLD.Estatus THEN
        SELECT CONCAT(
            'AdministradorID(columna): ', 
            CAST(NEW.AdministradorID AS CHAR),'(Estatus)',
            CAST(OLD.Estatus AS CHAR),' ahora es ',
            CAST(NEW.Estatus AS CHAR)
        ) INTO Parametros;
    
        SELECT RegistrarModificacion(NEW.Rastreable_P, Parametros) INTO bobo;
    END IF;
    
    IF NEW.Privilegios != OLD.Privilegios THEN
        SELECT CONCAT(
            'AdministradorID(columna): ', 
            CAST(NEW.AdministradorID AS CHAR),'(Privilegios)',
            CAST(OLD.Privilegios AS CHAR),' ahora es ',
            CAST(NEW.Privilegios AS CHAR)
        ) INTO Parametros;
    
        SELECT RegistrarModificacion(NEW.Rastreable_P, Parametros) INTO bobo;
    END IF;
END $$


DELIMITER ;

DELIMITER $$
USE `Spuria`$$


CREATE TRIGGER t_ResultadoDeBusquedaCrear AFTER INSERT ON ResultadoDeBusqueda
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE Rastreable_P, bobo INT;
    
    SELECT CONCAT(
        'Busqueda->ResultadoDeBusqueda: ',
        CAST(NEW.BusquedaID AS CHAR),'->(',
        CAST(NEW.BusquedaID AS CHAR),',',
        CAST(NEW.BuscableID AS CHAR),'): ',
        CAST(NEW.Visitado AS CHAR),',',
        CAST(NEW.Relevancia AS CHAR)
    ) INTO Parametros;
    
    SELECT Busqueda.Rastreable_P FROM Busqueda
    WHERE BusquedaID = NEW.BusquedaID
    INTO Rastreable_P;
    
    SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
END $$

USE `Spuria`$$


CREATE TRIGGER t_ResultadoDeBusquedaModificarDespues AFTER UPDATE ON ResultadoDeBusqueda
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE Rastreable_P, bobo INT;
    
    SELECT Busqueda.Rastreable_P FROM Busqueda
    WHERE BusquedaID = NEW.BusquedaID
    INTO Rastreable_P;
    
    IF NEW.Visitado != OLD.Visitado THEN
        SELECT CONCAT(
            'Busqueda->ResultadoDeBusqueda(columna): ',
            CAST(NEW.BusquedaID AS CHAR),'->(',
            CAST(NEW.BusquedaID AS CHAR),',',
            CAST(NEW.BuscableID AS CHAR),')(Visitado): ',
            CAST(OLD.Visitado AS CHAR),' ahora es ',
            CAST(NEW.Visitado AS CHAR)
        ) INTO Parametros;
    
        SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
    END IF;
    
    IF NEW.Relevancia != OLD.Relevancia THEN
        SELECT CONCAT(
            'Busqueda->ResultadoDeBusqueda(columna): ',
            CAST(NEW.BusquedaID AS CHAR),'->(',
            CAST(NEW.BusquedaID AS CHAR),',',
            CAST(NEW.BuscableID AS CHAR),')(Visitado): ',
            CAST(OLD.Relevancia AS CHAR),' ahora es ',
            CAST(NEW.Relevancia AS CHAR)
        ) INTO Parametros;
    
        SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
    END IF;
END $$

USE `Spuria`$$


CREATE TRIGGER t_ResultadoDeBusquedaModificarAntes BEFORE UPDATE ON ResultadoDeBusqueda
FOR EACH ROW
BEGIN
    IF NEW.BusquedaID != OLD.BusquedaID THEN
        SET NEW.BusquedaID = OLD.BusquedaID;
    END IF;
    IF NEW.BuscableID != OLD.BuscableID THEN
        SET NEW.BuscableID = OLD.BuscableID;
    END IF;
END $$


DELIMITER ;

DELIMITER $$
USE `Spuria`$$


CREATE TRIGGER t_EstadisticasTemporalesCrear AFTER INSERT ON EstadisticasTemporales
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE Rastreable_P, bobo INT;
    
    SELECT CONCAT(
        'Estadisticas->EstadisticasTemporales: ',
        CAST(NEW.EstadisticasID AS CHAR),'->',
        CAST(NEW.FechaInicio AS CHAR),': ',
        CAST(NEW.Contador AS CHAR),',',
        CAST(NEW.Ranking AS CHAR),',',
        CAST(NEW.Indice AS CHAR)
    ) INTO Parametros;
    
    SELECT Estadisticas.Rastreable_P FROM Estadisticas
    WHERE EstadisticasID = NEW.EstadisticasID
    INTO Rastreable_P;
    
    SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
END $$

USE `Spuria`$$


CREATE TRIGGER t_EstadisticasTemporalesModificarAntes BEFORE UPDATE ON EstadisticasTemporales
FOR EACH ROW
BEGIN
    IF NEW.EstadisticasID != OLD.EstadisticasID THEN
        SET NEW.EstadisticasID = OLD.EstadisticasID;
    END IF;
    IF NEW.FechaInicio != OLD.FechaInicio THEN
        SET NEW.FechaInicio = OLD.FechaInicio;
    END IF;
END $$

USE `Spuria`$$


CREATE TRIGGER t_EstadisticasTemporalesModificarDespues AFTER UPDATE ON EstadisticasTemporales
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE Rastreable_P, bobo INT;
    
    SELECT Estadisticas.Rastreable_P FROM Estadisticas
    WHERE EstadisticasID = NEW.EstadisticasID
    INTO Rastreable_P;
            
    IF NEW.FechaFin != OLD.FechaFin THEN
        SELECT CONCAT(
            'Estadisticas->EstadisticasTemporales(columna): ',
            CAST(NEW.EstadisticasID AS CHAR),'->',
            CAST(NEW.FechaInicio AS CHAR),'(FechaFin): ',
            CAST(OLD.FechaFin AS CHAR),' ahora es ',
            CAST(NEW.FechaFin AS CHAR)
        ) INTO Parametros;
        
        SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
    END IF;
    
    IF NEW.Contador != OLD.Contador THEN
        SELECT CONCAT(
            'Estadisticas->EstadisticasTemporales(columna): ',
            CAST(NEW.EstadisticasID AS CHAR),'->',
            CAST(NEW.FechaInicio AS CHAR),'(Contador): ',
            CAST(OLD.Contador AS CHAR),' ahora es ',
            CAST(NEW.Contador AS CHAR)
        ) INTO Parametros;
    
        SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
    END IF;
    
    IF NEW.Ranking != OLD.Ranking THEN
        SELECT CONCAT(
            'Estadisticas->EstadisticasTemporales(columna): ',
            CAST(NEW.EstadisticasID AS CHAR),'->',
            CAST(NEW.FechaInicio AS CHAR),'(Ranking): ',
            CAST(OLD.Ranking AS CHAR),' ahora es ',
            CAST(NEW.Ranking AS CHAR)
        ) INTO Parametros;

        SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
    END IF;
    
    IF NEW.Indice != OLD.Indice THEN
        SELECT CONCAT(
            'Estadisticas->EstadisticasTemporales(columna): ',
            CAST(NEW.EstadisticasID AS CHAR),'->',
            CAST(NEW.FechaInicio AS CHAR),'(Indice): ',
            CAST(OLD.Indice AS CHAR),' ahora es ',
            CAST(NEW.Indice AS CHAR)
        ) INTO Parametros;

        SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
    END IF;
END $$


DELIMITER ;

DELIMITER $$
USE `Spuria`$$


CREATE TRIGGER t_PrecioCantidadCrear AFTER INSERT ON PrecioCantidad
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE Rastreable_P, bobo INT;
    
    SELECT CONCAT(
        'Inventario->PrecioCantidad: (',
        CAST(NEW.TiendaID AS CHAR),',',
        CAST(NEW.ProductoID AS CHAR),')->',
        CAST(NEW.FechaInicio AS CHAR),': ',
        CAST(NEW.Precio AS CHAR),
        CAST(NEW.Cantidad AS CHAR)
    ) INTO Parametros;
    
    SELECT Inventario.Rastreable_P FROM Inventario
    WHERE TiendaID = NEW.TiendaID AND ProductoID = NEW.ProductoID
    INTO Rastreable_P;
    
    SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
END $$

USE `Spuria`$$


CREATE TRIGGER t_PrecioCantidadModificarAntes BEFORE UPDATE ON PrecioCantidad
FOR EACH ROW
BEGIN
    IF NEW.TiendaID != OLD.TiendaID THEN
        SET NEW.TiendaID = OLD.TiendaID;
    END IF;
    IF NEW.ProductoID != OLD.ProductoID THEN
        SET NEW.ProductoID = OLD.ProductoID;
    END IF;
    IF NEW.FechaInicio != OLD.FechaInicio THEN
        SET NEW.FechaInicio = OLD.FechaInicio;
    END IF;
END $$

USE `Spuria`$$


CREATE TRIGGER t_PrecioCantidadModificarDespues AFTER UPDATE ON PrecioCantidad
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE Rastreable_P, bobo INT;
    
    SELECT Inventario.Rastreable_P FROM Inventario
    WHERE TiendaID = NEW.TiendaID AND ProductoID = NEW.ProductoID
    INTO Rastreable_P;
        
    IF NEW.FechaFin != OLD.FechaFin THEN
        SELECT CONCAT(
            'Inventario->PrecioCantidad(columna): (',
            CAST(NEW.TiendaID AS CHAR),',',
            CAST(NEW.ProductoID AS CHAR),')->',
            CAST(NEW.FechaInicio AS CHAR),'(FechaFin): ',
            CAST(OLD.FechaFin AS CHAR),' ahora es ',
            CAST(NEW.FechaFin AS CHAR)
        ) INTO Parametros;
        
        SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
    END IF;
    
    IF NEW.Precio != OLD.Precio THEN
        SELECT CONCAT(
            'Inventario->PrecioCantidad(columna): (',
            CAST(NEW.TiendaID AS CHAR),',',
            CAST(NEW.ProductoID AS CHAR),')->',
            CAST(NEW.FechaInicio AS CHAR),'(Precio): ',
            CAST(OLD.Precio AS CHAR),' ahora es ',
            CAST(NEW.Precio AS CHAR)
        ) INTO Parametros;
        
        SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
    END IF;
    
    IF NEW.Cantidad != OLD.Cantidad THEN
        SELECT CONCAT(
            'Inventario->PrecioCantidad(columna): (',
            CAST(NEW.TiendaID AS CHAR),',',
            CAST(NEW.ProductoID AS CHAR),')->',
            CAST(NEW.FechaInicio AS CHAR),'(Cantidad): ',
            CAST(OLD.Cantidad AS CHAR),' ahora es ',
            CAST(NEW.Cantidad AS CHAR)
        ) INTO Parametros;
        
        SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
    END IF;
END $$


DELIMITER ;

DELIMITER $$
USE `Spuria`$$


CREATE TRIGGER t_TiendasConsumidoresCrear AFTER INSERT ON TiendasConsumidores
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE Rastreable_P, bobo INT;
    
    SELECT CONCAT(
        'RegionGeografica->TiendasConsumidores: ',
        CAST(NEW.RegionGeograficaID AS CHAR),'->',
        CAST(NEW.FechaInicio AS CHAR),': ',
        CAST(NEW.NumeroDeTiendas AS CHAR),',',
        CAST(NEW.NumeroDeConsumidores AS CHAR)
    ) INTO Parametros;
    
    SELECT RegionGeografica.Rastreable_P FROM RegionGeografica
    WHERE RegionGeograficaID = NEW.RegionGeograficaID
    INTO Rastreable_P;
    
    SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
END $$

USE `Spuria`$$


CREATE TRIGGER t_TiendasConsumidoresModificarAntes BEFORE UPDATE ON TiendasConsumidores
FOR EACH ROW
BEGIN
    IF NEW.RegionGeograficaID != OLD.RegionGeograficaID THEN
        SET NEW.RegionGeograficaID = OLD.RegionGeograficaID;
    END IF;
    IF NEW.FechaInicio != OLD.FechaInicio THEN
        SET NEW.FechaInicio = OLD.FechaInicio;
    END IF;
END $$

USE `Spuria`$$


CREATE TRIGGER t_TiendasConsumidoresModificarDespues AFTER UPDATE ON TiendasConsumidores
FOR EACH ROW
BEGIN
    DECLARE Parametros TEXT;
    DECLARE Rastreable_P, bobo INT;
    
    SELECT RegionGeografica.Rastreable_P FROM RegionGeografica
    WHERE RegionGeograficaID = NEW.RegionGeograficaID
    INTO Rastreable_P;
        
    IF NEW.FechaFin != OLD.FechaFin THEN
        SELECT CONCAT(
            'RegionGeografica->TiendasConsumidores(columna): ',
            CAST(NEW.RegionGeograficaID AS CHAR),'->',
            CAST(NEW.FechaInicio AS CHAR),'(FechaFin): ',
            CAST(OLD.FechaFin AS CHAR),' ahora es ',
            CAST(NEW.FechaFin AS CHAR)
        ) INTO Parametros;
        
        SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
    END IF;
    
    IF NEW.NumeroDeTiendas != OLD.NumeroDeTiendas THEN
        SELECT CONCAT(
            'RegionGeografica->NumeroDeTiendas(columna): ',
            CAST(NEW.RegionGeograficaID AS CHAR),'->',
            CAST(NEW.FechaInicio AS CHAR),'(NumeroDeTiendas): ',
            CAST(OLD.NumeroDeTiendas AS CHAR),' ahora es ',
            CAST(NEW.NumeroDeTiendas AS CHAR)
        ) INTO Parametros;
    
        SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
    END IF;
    
    IF NEW.NumeroDeConsumidores != OLD.NumeroDeConsumidores THEN
        SELECT CONCAT(
            'RegionGeografica->NumeroDeTiendas(columna): ',
            CAST(NEW.RegionGeograficaID AS CHAR),'->',
            CAST(NEW.FechaInicio AS CHAR),'(NumeroDeConsumidores): ',
            CAST(OLD.NumeroDeConsumidores AS CHAR),' ahora es ',
            CAST(NEW.NumeroDeConsumidores AS CHAR)
        ) INTO Parametros;
    
        SELECT RegistrarModificacion(Rastreable_P, Parametros) INTO bobo;
    END IF;
END $$


DELIMITER ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
