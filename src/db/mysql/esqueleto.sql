SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `spuria` DEFAULT CHARACTER SET latin1 COLLATE latin1_spanish_ci ;
USE `spuria` ;

-- -----------------------------------------------------
-- Table `spuria`.`interlocutor`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spuria`.`interlocutor` (
  `interlocutor_id` INT NOT NULL AUTO_INCREMENT ,
  PRIMARY KEY (`interlocutor_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spuria`.`calificable_seguible`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spuria`.`calificable_seguible` (
  `calificable_seguible_id` INT NOT NULL AUTO_INCREMENT ,
  `calificacion_general` INT NULL ,
  PRIMARY KEY (`calificable_seguible_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spuria`.`etiquetable`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spuria`.`etiquetable` (
  `etiquetable_id` INT NOT NULL AUTO_INCREMENT ,
  PRIMARY KEY (`etiquetable_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spuria`.`categoria`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spuria`.`categoria` (
  `etiquetable_p` INT NOT NULL ,
  `categoria_id` CHAR(16) NOT NULL ,
  `nombre` CHAR(30) NOT NULL ,
  `hijo_de_categoria` CHAR(16) NOT NULL ,
  `nivel` INT NULL ,
  PRIMARY KEY (`categoria_id`) ,
  INDEX `fk_Categoria_Etiquetable` (`etiquetable_p` ASC) ,
  INDEX `fk_Categoria_Categoria` (`hijo_de_categoria` ASC) ,
  UNIQUE INDEX `Etiquetable_P_UNIQUE` (`etiquetable_p` ASC) ,
  CONSTRAINT `fk_Categoria_Etiquetable`
    FOREIGN KEY (`etiquetable_p` )
    REFERENCES `spuria`.`etiquetable` (`etiquetable_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Categoria_Categoria`
    FOREIGN KEY (`hijo_de_categoria` )
    REFERENCES `spuria`.`categoria` (`categoria_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spuria`.`describible`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spuria`.`describible` (
  `describible_id` INT NOT NULL AUTO_INCREMENT ,
  PRIMARY KEY (`describible_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spuria`.`estatus`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spuria`.`estatus` (
  `valor` CHAR(9) NOT NULL ,
  PRIMARY KEY (`valor`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spuria`.`rastreable`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spuria`.`rastreable` (
  `rastreable_id` INT NOT NULL AUTO_INCREMENT ,
  `fecha_de_creacion` DECIMAL(17,3) NOT NULL ,
  `creado_por` INT NOT NULL ,
  `fecha_de_modificacion` DECIMAL(17,3) NOT NULL ,
  `modificado_por` INT NOT NULL ,
  `fecha_de_eliminacion` DECIMAL(17,3) NULL ,
  `eliminado_por` INT NULL ,
  `fecha_de_acceso` DECIMAL(17,3) NOT NULL ,
  `accesado_por` INT NOT NULL ,
  PRIMARY KEY (`rastreable_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spuria`.`dibujable`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spuria`.`dibujable` (
  `dibujable_id` INT NOT NULL AUTO_INCREMENT ,
  PRIMARY KEY (`dibujable_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spuria`.`idioma`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spuria`.`idioma` (
  `valor` CHAR(10) NOT NULL ,
  PRIMARY KEY (`valor`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spuria`.`territorio`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spuria`.`territorio` (
  `rastreable_p` INT NOT NULL ,
  `dibujable_p` INT NOT NULL ,
  `territorio_id` CHAR(16) NOT NULL ,
  `nombre` VARCHAR(45) NOT NULL ,
  `poblacion` INT UNSIGNED NOT NULL ,
  `idioma` CHAR(10) NULL ,
  `nivel` INT NULL ,
  `territorio_padre` CHAR(16) NOT NULL ,
  `consumidores_poblacion` FLOAT NOT NULL ,
  `tiendas_poblacion` FLOAT NOT NULL ,
  `tiendas_consumidores` FLOAT NULL ,
  `codigo_postal` CHAR(10) NULL ,
  `pib` DECIMAL(15,0) NULL ,
  PRIMARY KEY (`territorio_id`) ,
  INDEX `fk_Territorio_Dibujable` (`dibujable_p` ASC) ,
  INDEX `fk_Territorio_Rastreable` (`rastreable_p` ASC) ,
  UNIQUE INDEX `Dibujable_P_UNIQUE` (`dibujable_p` ASC) ,
  UNIQUE INDEX `Rastreable_P_UNIQUE` (`rastreable_p` ASC) ,
  INDEX `fk_Territorio_Territorio` (`territorio_padre` ASC) ,
  INDEX `fk_Territorio_Idioma` (`idioma` ASC) ,
  CONSTRAINT `fk_Territorio_Dibujable`
    FOREIGN KEY (`dibujable_p` )
    REFERENCES `spuria`.`dibujable` (`dibujable_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Territorio_Rastreable`
    FOREIGN KEY (`rastreable_p` )
    REFERENCES `spuria`.`rastreable` (`rastreable_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Territorio_Territorio`
    FOREIGN KEY (`territorio_padre` )
    REFERENCES `spuria`.`territorio` (`territorio_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Territorio_Idioma`
    FOREIGN KEY (`idioma` )
    REFERENCES `spuria`.`idioma` (`valor` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spuria`.`usuario`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spuria`.`usuario` (
  `rastreable_p` INT NOT NULL ,
  `describible_p` INT NOT NULL ,
  `usuario_id` INT NOT NULL AUTO_INCREMENT ,
  `nombre` VARCHAR(45) NOT NULL ,
  `apellido` VARCHAR(45) NOT NULL ,
  `estatus` CHAR(9) NOT NULL ,
  `ubicacion` CHAR(16) NULL ,
  PRIMARY KEY (`usuario_id`) ,
  INDEX `fk_Usuario_Rastreable` (`rastreable_p` ASC) ,
  UNIQUE INDEX `Rastreable_P_UNIQUE` (`rastreable_p` ASC) ,
  INDEX `fk_Usuario_Territorio` (`ubicacion` ASC) ,
  INDEX `fk_Usuario_Estatus` (`estatus` ASC) ,
  INDEX `fk_Usuario_Describible` (`describible_p` ASC) ,
  CONSTRAINT `fk_Usuario_Rastreable`
    FOREIGN KEY (`rastreable_p` )
    REFERENCES `spuria`.`rastreable` (`rastreable_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuario_Territorio`
    FOREIGN KEY (`ubicacion` )
    REFERENCES `spuria`.`territorio` (`territorio_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuario_Estatus`
    FOREIGN KEY (`estatus` )
    REFERENCES `spuria`.`estatus` (`valor` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuario_Describible`
    FOREIGN KEY (`describible_p` )
    REFERENCES `spuria`.`describible` (`describible_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spuria`.`cliente`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spuria`.`cliente` (
  `rastreable_p` INT NOT NULL ,
  `describible_p` INT NOT NULL ,
  `rif` CHAR(10) NOT NULL ,
  `propietario` INT NOT NULL ,
  `categoria` CHAR(16) NOT NULL ,
  `estatus` CHAR(9) NOT NULL ,
  `nombre_legal` VARCHAR(45) NOT NULL ,
  `nombre_comun` VARCHAR(45) NULL ,
  `telefono` CHAR(12) NOT NULL ,
  `edificio_cc` CHAR(20) NULL ,
  `piso` CHAR(12) NULL ,
  `apartamento` CHAR(12) NULL ,
  `local_no` CHAR(12) NULL ,
  `casa` CHAR(20) NULL ,
  `calle` CHAR(12) NOT NULL ,
  `sector_urb_barrio` CHAR(20) NOT NULL ,
  `pagina_web` CHAR(40) NULL ,
  `facebook` CHAR(80) NULL ,
  `twitter` CHAR(80) NULL ,
  `correo_electronico` VARCHAR(45) NULL ,
  `ubicacion` CHAR(16) NULL ,
  INDEX `fk_Cliente_Categoria` (`categoria` ASC) ,
  INDEX `fk_Cliente_Describible` (`describible_p` ASC) ,
  INDEX `fk_Cliente_Estatus` (`estatus` ASC) ,
  UNIQUE INDEX `Telefono_UNIQUE` (`telefono` ASC) ,
  UNIQUE INDEX `Describible_P_UNIQUE` (`describible_p` ASC) ,
  UNIQUE INDEX `NombreLegal_UNIQUE` (`nombre_legal` ASC) ,
  PRIMARY KEY (`rif`) ,
  INDEX `fk_Cliente_Usuario` (`propietario` ASC) ,
  INDEX `fk_Cliente_Rastreable` (`rastreable_p` ASC) ,
  UNIQUE INDEX `Rastreable_P_UNIQUE` (`rastreable_p` ASC) ,
  INDEX `fk_Cliente_Territorio` (`ubicacion` ASC) ,
  CONSTRAINT `fk_Cliente_Categoria`
    FOREIGN KEY (`categoria` )
    REFERENCES `spuria`.`categoria` (`categoria_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cliente_Describible`
    FOREIGN KEY (`describible_p` )
    REFERENCES `spuria`.`describible` (`describible_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cliente_Estatus`
    FOREIGN KEY (`estatus` )
    REFERENCES `spuria`.`estatus` (`valor` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cliente_Usuario`
    FOREIGN KEY (`propietario` )
    REFERENCES `spuria`.`usuario` (`usuario_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cliente_Rastreable`
    FOREIGN KEY (`rastreable_p` )
    REFERENCES `spuria`.`rastreable` (`rastreable_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cliente_Territorio`
    FOREIGN KEY (`ubicacion` )
    REFERENCES `spuria`.`territorio` (`territorio_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spuria`.`buscable`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spuria`.`buscable` (
  `buscable_id` INT NOT NULL AUTO_INCREMENT ,
  PRIMARY KEY (`buscable_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spuria`.`tienda`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spuria`.`tienda` (
  `buscable_p` INT NOT NULL ,
  `cliente_p` CHAR(10) NOT NULL ,
  `calificable_seguible_p` INT NOT NULL ,
  `interlocutor_p` INT NOT NULL ,
  `dibujable_p` INT NOT NULL ,
  `tienda_id` INT NOT NULL AUTO_INCREMENT ,
  `abierto` TINYINT(1) NOT NULL ,
  PRIMARY KEY (`tienda_id`) ,
  INDEX `fk_Tienda_Interlocutor` (`interlocutor_p` ASC) ,
  INDEX `fk_Tienda_CalificableSeguible` (`calificable_seguible_p` ASC) ,
  INDEX `fk_Tienda_Cliente` (`cliente_p` ASC) ,
  INDEX `fk_Tienda_Dibujable` (`dibujable_p` ASC) ,
  INDEX `fk_Tienda_Buscable` (`buscable_p` ASC) ,
  UNIQUE INDEX `Buscable_P_UNIQUE` (`buscable_p` ASC) ,
  UNIQUE INDEX `Cliente_P_UNIQUE` (`cliente_p` ASC) ,
  UNIQUE INDEX `CalificableSeguible_P_UNIQUE` (`calificable_seguible_p` ASC) ,
  UNIQUE INDEX `Interlocutor_P_UNIQUE` (`interlocutor_p` ASC) ,
  UNIQUE INDEX `Dibujable_P_UNIQUE` (`dibujable_p` ASC) ,
  CONSTRAINT `fk_Tienda_Interlocutor`
    FOREIGN KEY (`interlocutor_p` )
    REFERENCES `spuria`.`interlocutor` (`interlocutor_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Tienda_CalificableSeguible`
    FOREIGN KEY (`calificable_seguible_p` )
    REFERENCES `spuria`.`calificable_seguible` (`calificable_seguible_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Tienda_Cliente`
    FOREIGN KEY (`cliente_p` )
    REFERENCES `spuria`.`cliente` (`rif` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Tienda_Dibujable`
    FOREIGN KEY (`dibujable_p` )
    REFERENCES `spuria`.`dibujable` (`dibujable_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Tienda_Buscable`
    FOREIGN KEY (`buscable_p` )
    REFERENCES `spuria`.`buscable` (`buscable_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spuria`.`tipo_de_codigo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spuria`.`tipo_de_codigo` (
  `valor` CHAR(7) NOT NULL ,
  PRIMARY KEY (`valor`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spuria`.`producto`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spuria`.`producto` (
  `rastreable_p` INT NOT NULL ,
  `describible_p` INT NOT NULL ,
  `buscable_p` INT NOT NULL ,
  `calificable_seguible_p` INT NOT NULL ,
  `producto_id` INT NOT NULL AUTO_INCREMENT ,
  `tipo_de_codigo` CHAR(7) NOT NULL ,
  `codigo` CHAR(15) NOT NULL ,
  `estatus` CHAR(9) NOT NULL ,
  `fabricante` VARCHAR(45) NOT NULL ,
  `modelo` VARCHAR(45) NULL ,
  `nombre` VARCHAR(45) NOT NULL ,
  `categoria` CHAR(16) NOT NULL ,
  `debut_en_el_mercado` DATE NULL ,
  `largo` FLOAT NULL ,
  `ancho` FLOAT NULL ,
  `alto` FLOAT NULL ,
  `peso` FLOAT NULL ,
  `pais_de_origen` CHAR(16) NULL ,
  PRIMARY KEY (`producto_id`) ,
  INDEX `fk_Producto_Categoria` (`categoria` ASC) ,
  INDEX `fk_Producto_Estatus` (`estatus` ASC) ,
  INDEX `fk_Producto_CalificableSeguible` (`calificable_seguible_p` ASC) ,
  INDEX `fk_Producto_Describible` (`describible_p` ASC) ,
  INDEX `fk_Producto_Rastreable` (`rastreable_p` ASC) ,
  INDEX `fk_Producto_Buscable` (`buscable_p` ASC) ,
  UNIQUE INDEX `CodigoUniversal_UNIQUE` (`codigo` ASC) ,
  UNIQUE INDEX `Rastreable_P_UNIQUE` (`rastreable_p` ASC) ,
  UNIQUE INDEX `Describible_P_UNIQUE` (`describible_p` ASC) ,
  UNIQUE INDEX `Buscable_P_UNIQUE` (`buscable_p` ASC) ,
  UNIQUE INDEX `CalificableSeguible_P_UNIQUE` (`calificable_seguible_p` ASC) ,
  INDEX `fk_Producto_TipoDeCodigo` (`tipo_de_codigo` ASC) ,
  INDEX `fk_Producto_Territorio` (`pais_de_origen` ASC) ,
  CONSTRAINT `fk_Producto_Categoria`
    FOREIGN KEY (`categoria` )
    REFERENCES `spuria`.`categoria` (`categoria_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Producto_Estatus`
    FOREIGN KEY (`estatus` )
    REFERENCES `spuria`.`estatus` (`valor` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Producto_CalificableSeguible`
    FOREIGN KEY (`calificable_seguible_p` )
    REFERENCES `spuria`.`calificable_seguible` (`calificable_seguible_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Producto_Describible`
    FOREIGN KEY (`describible_p` )
    REFERENCES `spuria`.`describible` (`describible_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Producto_Rastreable`
    FOREIGN KEY (`rastreable_p` )
    REFERENCES `spuria`.`rastreable` (`rastreable_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Producto_Buscable`
    FOREIGN KEY (`buscable_p` )
    REFERENCES `spuria`.`buscable` (`buscable_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Producto_TipoDeCodigo`
    FOREIGN KEY (`tipo_de_codigo` )
    REFERENCES `spuria`.`tipo_de_codigo` (`valor` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Producto_Territorio`
    FOREIGN KEY (`pais_de_origen` )
    REFERENCES `spuria`.`territorio` (`territorio_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spuria`.`visibilidad`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spuria`.`visibilidad` (
  `valor` CHAR(16) NOT NULL ,
  PRIMARY KEY (`valor`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spuria`.`cobrable`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spuria`.`cobrable` (
  `cobrable_id` INT NOT NULL AUTO_INCREMENT ,
  PRIMARY KEY (`cobrable_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spuria`.`inventario`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spuria`.`inventario` (
  `rastreable_p` INT NOT NULL ,
  `cobrable_p` INT NOT NULL ,
  `tienda_id` INT NOT NULL ,
  `codigo` CHAR(15) NOT NULL ,
  `descripcion` VARCHAR(45) NULL ,
  `visibilidad` CHAR(16) NOT NULL ,
  `producto_id` INT NULL ,
  PRIMARY KEY (`tienda_id`, `codigo`) ,
  INDEX `fk_Inventario_Tienda` (`tienda_id` ASC) ,
  INDEX `fk_Inventario_Visibilidad` (`visibilidad` ASC) ,
  INDEX `fk_Inventario_Rastreable` (`rastreable_p` ASC) ,
  UNIQUE INDEX `Rastreable_P_UNIQUE` (`rastreable_p` ASC) ,
  INDEX `fk_Inventario_Cobrable` (`cobrable_p` ASC) ,
  UNIQUE INDEX `Cobrable_P_UNIQUE` (`cobrable_p` ASC) ,
  INDEX `fk_Inventario_Producto` (`producto_id` ASC) ,
  CONSTRAINT `fk_Inventario_Tienda`
    FOREIGN KEY (`tienda_id` )
    REFERENCES `spuria`.`tienda` (`tienda_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Inventario_Visibilidad`
    FOREIGN KEY (`visibilidad` )
    REFERENCES `spuria`.`visibilidad` (`valor` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Inventario_Rastreable`
    FOREIGN KEY (`rastreable_p` )
    REFERENCES `spuria`.`rastreable` (`rastreable_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Inventario_Cobrable`
    FOREIGN KEY (`cobrable_p` )
    REFERENCES `spuria`.`cobrable` (`cobrable_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Inventario_Producto`
    FOREIGN KEY (`producto_id` )
    REFERENCES `spuria`.`producto` (`producto_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spuria`.`mensaje`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spuria`.`mensaje` (
  `rastreable_p` INT NOT NULL ,
  `etiquetable_p` INT NOT NULL ,
  `mensaje_id` INT NOT NULL AUTO_INCREMENT ,
  `remitente` INT NOT NULL ,
  `destinatario` INT NOT NULL ,
  `contenido` TEXT NOT NULL ,
  PRIMARY KEY (`mensaje_id`) ,
  INDEX `fk_Mensaje_Etiquetable` (`etiquetable_p` ASC) ,
  INDEX `fk_Mensaje_Remitente` (`remitente` ASC) ,
  INDEX `fk_Mensaje_Destinatario` (`destinatario` ASC) ,
  INDEX `fk_Mensaje_Rastreable` (`rastreable_p` ASC) ,
  UNIQUE INDEX `Etiquetable_P_UNIQUE` (`etiquetable_p` ASC) ,
  UNIQUE INDEX `Rastreable_P_UNIQUE` (`rastreable_p` ASC) ,
  CONSTRAINT `fk_Mensaje_Etiquetable`
    FOREIGN KEY (`etiquetable_p` )
    REFERENCES `spuria`.`etiquetable` (`etiquetable_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Mensaje_Remitente`
    FOREIGN KEY (`remitente` )
    REFERENCES `spuria`.`interlocutor` (`interlocutor_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Mensaje_Destinatario`
    FOREIGN KEY (`destinatario` )
    REFERENCES `spuria`.`interlocutor` (`interlocutor_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Mensaje_Rastreable`
    FOREIGN KEY (`rastreable_p` )
    REFERENCES `spuria`.`rastreable` (`rastreable_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spuria`.`sexo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spuria`.`sexo` (
  `valor` CHAR(6) NOT NULL ,
  PRIMARY KEY (`valor`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spuria`.`grado_de_instruccion`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spuria`.`grado_de_instruccion` (
  `valor` CHAR(16) NOT NULL ,
  `orden` INT NOT NULL ,
  PRIMARY KEY (`valor`) ,
  UNIQUE INDEX `orden_UNIQUE` (`orden` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spuria`.`grupo_de_edad`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spuria`.`grupo_de_edad` (
  `valor` CHAR(15) NOT NULL ,
  PRIMARY KEY (`valor`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spuria`.`consumidor`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spuria`.`consumidor` (
  `interlocutor_p` INT NOT NULL ,
  `usuario_p` INT NOT NULL ,
  `consumidor_id` INT NOT NULL AUTO_INCREMENT ,
  `sexo` CHAR(6) NOT NULL ,
  `fecha_de_nacimiento` DATE NOT NULL ,
  `grupo_de_edad` CHAR(15) NOT NULL ,
  `grado_de_instruccion` CHAR(16) NOT NULL ,
  PRIMARY KEY (`consumidor_id`) ,
  INDEX `fk_Consumidor_Interlocutor` (`interlocutor_p` ASC) ,
  INDEX `fk_Consumidor_Sexo` (`sexo` ASC) ,
  INDEX `fk_Consumidor_GradoDeInstruccion` (`grado_de_instruccion` ASC) ,
  INDEX `fk_Consumidor_GrupoDeEdad` (`grupo_de_edad` ASC) ,
  UNIQUE INDEX `Interlocutor_P_UNIQUE` (`interlocutor_p` ASC) ,
  INDEX `fk_Consumidor_Usuario` (`usuario_p` ASC) ,
  UNIQUE INDEX `Usuario_P_UNIQUE` (`usuario_p` ASC) ,
  CONSTRAINT `fk_Consumidor_Interlocutor`
    FOREIGN KEY (`interlocutor_p` )
    REFERENCES `spuria`.`interlocutor` (`interlocutor_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Consumidor_Sexo`
    FOREIGN KEY (`sexo` )
    REFERENCES `spuria`.`sexo` (`valor` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Consumidor_GradoDeInstruccion`
    FOREIGN KEY (`grado_de_instruccion` )
    REFERENCES `spuria`.`grado_de_instruccion` (`valor` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Consumidor_GrupoDeEdad`
    FOREIGN KEY (`grupo_de_edad` )
    REFERENCES `spuria`.`grupo_de_edad` (`valor` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Consumidor_Usuario`
    FOREIGN KEY (`usuario_p` )
    REFERENCES `spuria`.`usuario` (`usuario_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spuria`.`acceso`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spuria`.`acceso` (
  `acceso_id` INT NOT NULL ,
  `conectado` TINYINT(1) NOT NULL ,
  `correo_electronico` VARCHAR(45) NOT NULL ,
  `contrasena` VARBINARY(60) NOT NULL ,
  `fecha_de_registro` DECIMAL(17,3) NOT NULL ,
  `fecha_de_ultimo_acceso` DECIMAL(17,3) NULL ,
  `duracion_de_ultimo_acceso` TIME NOT NULL ,
  `numero_total_de_accesos` INT NOT NULL ,
  `tiempo_total_de_accesos` TIME NOT NULL ,
  `tiempo_promedio_por_acceso` TIME NOT NULL ,
  PRIMARY KEY (`acceso_id`) ,
  INDEX `fk_Acceso_Usuario` (`acceso_id` ASC) ,
  UNIQUE INDEX `CorreoElectronico_UNIQUE` (`correo_electronico` ASC) ,
  CONSTRAINT `fk_Acceso_Usuario`
    FOREIGN KEY (`acceso_id` )
    REFERENCES `spuria`.`usuario` (`usuario_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spuria`.`busqueda`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spuria`.`busqueda` (
  `rastreable_p` INT NOT NULL ,
  `etiquetable_p` INT NOT NULL ,
  `busqueda_id` INT NOT NULL AUTO_INCREMENT ,
  `usuario` INT NOT NULL ,
  `fecha_hora` DECIMAL(17,3) NOT NULL ,
  `contenido` TEXT NOT NULL ,
  PRIMARY KEY (`busqueda_id`) ,
  INDEX `fk_Busqueda_Usuario` (`usuario` ASC) ,
  INDEX `fk_Busqueda_Etiquetable` (`etiquetable_p` ASC) ,
  INDEX `fk_Busqueda_Rastreable` (`rastreable_p` ASC) ,
  UNIQUE INDEX `Etiquetable_P_UNIQUE` (`etiquetable_p` ASC) ,
  UNIQUE INDEX `Rastreable_P_UNIQUE` (`rastreable_p` ASC) ,
  CONSTRAINT `fk_Busqueda_Usuario`
    FOREIGN KEY (`usuario` )
    REFERENCES `spuria`.`usuario` (`usuario_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Busqueda_Etiquetable`
    FOREIGN KEY (`etiquetable_p` )
    REFERENCES `spuria`.`etiquetable` (`etiquetable_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Busqueda_Rastreable`
    FOREIGN KEY (`rastreable_p` )
    REFERENCES `spuria`.`rastreable` (`rastreable_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spuria`.`palabra`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spuria`.`palabra` (
  `palabra_id` INT NOT NULL AUTO_INCREMENT ,
  `palabra_frase` CHAR(15) NOT NULL ,
  PRIMARY KEY (`palabra_id`) ,
  UNIQUE INDEX `Palabra_Frase_UNIQUE` (`palabra_frase` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spuria`.`relacion_de_palabras`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spuria`.`relacion_de_palabras` (
  `palabra1_id` INT NOT NULL ,
  `palabra2_id` INT NOT NULL ,
  PRIMARY KEY (`palabra1_id`, `palabra2_id`) ,
  INDEX `fk_RelacionDePalabras_Palabra2` (`palabra2_id` ASC) ,
  INDEX `fk_RelacionDePalabras_Palabra1` (`palabra1_id` ASC) ,
  CONSTRAINT `fk_RelacionDePalabras_Palabra1`
    FOREIGN KEY (`palabra1_id` )
    REFERENCES `spuria`.`palabra` (`palabra_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RelacionDePalabras_Palabra2`
    FOREIGN KEY (`palabra2_id` )
    REFERENCES `spuria`.`palabra` (`palabra_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spuria`.`estadisticas`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spuria`.`estadisticas` (
  `rastreable_p` INT NOT NULL ,
  `estadisticas_id` INT NOT NULL AUTO_INCREMENT ,
  `territorio` CHAR(16) NOT NULL ,
  PRIMARY KEY (`estadisticas_id`) ,
  INDEX `fk_Estadisticas_Territorio` (`territorio` ASC) ,
  INDEX `fk_Estadisticas_Rastreable` (`rastreable_p` ASC) ,
  UNIQUE INDEX `Rastreable_P_UNIQUE` (`rastreable_p` ASC) ,
  CONSTRAINT `fk_Estadisticas_Territorio`
    FOREIGN KEY (`territorio` )
    REFERENCES `spuria`.`territorio` (`territorio_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Estadisticas_Rastreable`
    FOREIGN KEY (`rastreable_p` )
    REFERENCES `spuria`.`rastreable` (`rastreable_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spuria`.`estadisticas_de_influencia`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spuria`.`estadisticas_de_influencia` (
  `estadisticas_p` INT NOT NULL ,
  `estadisticas_de_influencia_id` INT NOT NULL AUTO_INCREMENT ,
  `palabra` INT NOT NULL ,
  `numero_de_descripciones` INT NOT NULL ,
  `numero_de_mensajes` INT NOT NULL ,
  `numero_de_categorias` INT NOT NULL ,
  `numero_de_resenas` INT NOT NULL ,
  `numero_de_publicidades` INT NOT NULL ,
  PRIMARY KEY (`estadisticas_de_influencia_id`) ,
  INDEX `fk_EstadisticasDeInfluencia_Palabra` (`palabra` ASC) ,
  INDEX `fk_EstadisticasDeInfluencia_Estadisticas` (`estadisticas_p` ASC) ,
  UNIQUE INDEX `Estadisticas_P_UNIQUE` (`estadisticas_p` ASC) ,
  CONSTRAINT `fk_EstadisticasDeInfluencia_Palabra`
    FOREIGN KEY (`palabra` )
    REFERENCES `spuria`.`palabra` (`palabra_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_EstadisticasDeInfluencia_Estadisticas`
    FOREIGN KEY (`estadisticas_p` )
    REFERENCES `spuria`.`estadisticas` (`estadisticas_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spuria`.`foto`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spuria`.`foto` (
  `foto_id` INT NOT NULL AUTO_INCREMENT ,
  `ruta_de_foto` CHAR(80) NOT NULL ,
  `describible` INT NOT NULL ,
  PRIMARY KEY (`foto_id`) ,
  INDEX `fk_Foto_Describible` (`describible` ASC) ,
  CONSTRAINT `fk_Foto_Describible`
    FOREIGN KEY (`describible` )
    REFERENCES `spuria`.`describible` (`describible_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spuria`.`calificacion`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spuria`.`calificacion` (
  `Valor` CHAR(4) NOT NULL ,
  PRIMARY KEY (`Valor`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spuria`.`calificacion_resena`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spuria`.`calificacion_resena` (
  `rastreable_p` INT NOT NULL ,
  `etiquetable_p` INT NOT NULL ,
  `calificacion_resena_id` INT NOT NULL ,
  `consumidor_id` INT NOT NULL ,
  `calificacion` CHAR(4) NOT NULL ,
  `resena` TEXT NULL ,
  INDEX `fk_CalificacionResena_Consumidor` (`consumidor_id` ASC) ,
  INDEX `fk_CalificacionResena_CalificableSeguible` (`calificacion_resena_id` ASC) ,
  INDEX `fk_CalificacionResena_Etiquetable` (`etiquetable_p` ASC) ,
  INDEX `fk_CalificacionResena_Rastreable` (`rastreable_p` ASC) ,
  PRIMARY KEY (`calificacion_resena_id`, `consumidor_id`) ,
  INDEX `fk_CalificacionResena_Calificacion` (`calificacion` ASC) ,
  UNIQUE INDEX `Etiquetable_P_UNIQUE` (`etiquetable_p` ASC) ,
  UNIQUE INDEX `Rastreable_P_UNIQUE` (`rastreable_p` ASC) ,
  CONSTRAINT `fk_CalificacionResena_Consumidor`
    FOREIGN KEY (`consumidor_id` )
    REFERENCES `spuria`.`consumidor` (`consumidor_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CalificacionResena_CalificableSeguible`
    FOREIGN KEY (`calificacion_resena_id` )
    REFERENCES `spuria`.`calificable_seguible` (`calificable_seguible_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CalificacionResena_Etiquetable`
    FOREIGN KEY (`etiquetable_p` )
    REFERENCES `spuria`.`etiquetable` (`etiquetable_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CalificacionResena_Rastreable`
    FOREIGN KEY (`rastreable_p` )
    REFERENCES `spuria`.`rastreable` (`rastreable_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CalificacionResena_Calificacion`
    FOREIGN KEY (`calificacion` )
    REFERENCES `spuria`.`calificacion` (`Valor` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spuria`.`seguidor`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spuria`.`seguidor` (
  `rastreable_p` INT NOT NULL ,
  `consumidor_id` INT NOT NULL ,
  `calificable_seguible_id` INT NOT NULL ,
  `avisar_si` CHAR(40) NOT NULL ,
  PRIMARY KEY (`consumidor_id`, `calificable_seguible_id`) ,
  INDEX `fk_Seguidor_CalificableSeguible` (`calificable_seguible_id` ASC) ,
  INDEX `fk_Seguidor_Consumidor` (`consumidor_id` ASC) ,
  INDEX `fk_Seguidor_Rastreable` (`rastreable_p` ASC) ,
  UNIQUE INDEX `Rastreable_P_UNIQUE` (`rastreable_p` ASC) ,
  CONSTRAINT `fk_Seguidor_Consumidor`
    FOREIGN KEY (`consumidor_id` )
    REFERENCES `spuria`.`consumidor` (`consumidor_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Seguidor_CalificableSeguible`
    FOREIGN KEY (`calificable_seguible_id` )
    REFERENCES `spuria`.`calificable_seguible` (`calificable_seguible_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Seguidor_Rastreable`
    FOREIGN KEY (`rastreable_p` )
    REFERENCES `spuria`.`rastreable` (`rastreable_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spuria`.`estadisticas_de_popularidad`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spuria`.`estadisticas_de_popularidad` (
  `estadisticas_p` INT NOT NULL ,
  `estadisticas_de_popularidad_id` INT NOT NULL AUTO_INCREMENT ,
  `calificable_seguible` INT NOT NULL ,
  `numero_de_calificaciones` INT NOT NULL ,
  `numero_de_resenas` INT NOT NULL ,
  `numero_de_seguidores` INT NOT NULL ,
  `numero_de_menciones` INT NOT NULL ,
  `numero_de_vendedores` INT NULL ,
  `numero_de_mensajes` INT NULL ,
  INDEX `fk_EstadisticasDePopularidad_CalificableSeguible` (`calificable_seguible` ASC) ,
  INDEX `fk_EstadisticasDePopularidad_Estadisticas` (`estadisticas_p` ASC) ,
  PRIMARY KEY (`estadisticas_de_popularidad_id`) ,
  UNIQUE INDEX `Estadisticas_P_UNIQUE` (`estadisticas_p` ASC) ,
  CONSTRAINT `fk_EstadisticasDePopularidad_CalificableSeguible`
    FOREIGN KEY (`calificable_seguible` )
    REFERENCES `spuria`.`calificable_seguible` (`calificable_seguible_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_EstadisticasDePopularidad_Estadisticas`
    FOREIGN KEY (`estadisticas_p` )
    REFERENCES `spuria`.`estadisticas` (`estadisticas_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spuria`.`etiqueta`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spuria`.`etiqueta` (
  `etiquetable_id` INT NOT NULL ,
  `palabra_id` INT NOT NULL ,
  PRIMARY KEY (`etiquetable_id`, `palabra_id`) ,
  INDEX `fk_Etiqueta_Palabra` (`palabra_id` ASC) ,
  INDEX `fk_Etiqueta_Etiquetable` (`etiquetable_id` ASC) ,
  CONSTRAINT `fk_Etiqueta_Etiquetable`
    FOREIGN KEY (`etiquetable_id` )
    REFERENCES `spuria`.`etiquetable` (`etiquetable_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Etiqueta_Palabra`
    FOREIGN KEY (`palabra_id` )
    REFERENCES `spuria`.`palabra` (`palabra_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spuria`.`descripcion`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spuria`.`descripcion` (
  `rastreable_p` INT NOT NULL ,
  `etiquetable_p` INT NOT NULL ,
  `descripcion_id` INT NOT NULL AUTO_INCREMENT ,
  `describible` INT NOT NULL ,
  `contenido` TEXT NOT NULL ,
  PRIMARY KEY (`descripcion_id`) ,
  INDEX `fk_Descripcion_Etiquetable` (`etiquetable_p` ASC) ,
  INDEX `fk_Descripcion_Describible` (`describible` ASC) ,
  INDEX `fk_Descripcion_Rastreable` (`rastreable_p` ASC) ,
  UNIQUE INDEX `Rastreable_P_UNIQUE` (`rastreable_p` ASC) ,
  UNIQUE INDEX `Etiquetable_P_UNIQUE` (`etiquetable_p` ASC) ,
  CONSTRAINT `fk_Descripcion_Etiquetable`
    FOREIGN KEY (`etiquetable_p` )
    REFERENCES `spuria`.`etiquetable` (`etiquetable_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Descripcion_Describible`
    FOREIGN KEY (`describible` )
    REFERENCES `spuria`.`describible` (`describible_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Descripcion_Rastreable`
    FOREIGN KEY (`rastreable_p` )
    REFERENCES `spuria`.`rastreable` (`rastreable_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spuria`.`patrocinante`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spuria`.`patrocinante` (
  `cliente_p` CHAR(10) NOT NULL ,
  `patrocinante_id` INT NOT NULL AUTO_INCREMENT ,
  PRIMARY KEY (`patrocinante_id`) ,
  INDEX `fk_Patrocinante_Cliente` (`cliente_p` ASC) ,
  UNIQUE INDEX `Cliente_P_UNIQUE` (`cliente_p` ASC) ,
  CONSTRAINT `fk_Patrocinante_Cliente`
    FOREIGN KEY (`cliente_p` )
    REFERENCES `spuria`.`cliente` (`rif` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spuria`.`publicidad`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spuria`.`publicidad` (
  `buscable_p` INT NOT NULL ,
  `describible_p` INT NOT NULL ,
  `rastreable_p` INT NOT NULL ,
  `etiquetable_p` INT NOT NULL ,
  `cobrable_p` INT NOT NULL ,
  `publicidad_id` INT NOT NULL AUTO_INCREMENT ,
  `patrocinante` INT NOT NULL ,
  `nombre` VARCHAR(45) NOT NULL ,
  `tamano_de_poblacion_objetivo` INT NULL ,
  PRIMARY KEY (`publicidad_id`) ,
  INDEX `fk_Publicidad_Etiquetable` (`etiquetable_p` ASC) ,
  INDEX `fk_Publicidad_Describible` (`describible_p` ASC) ,
  INDEX `fk_Publicidad_Patrocinante` (`patrocinante` ASC) ,
  INDEX `fk_Publicidad_Buscable` (`buscable_p` ASC) ,
  INDEX `fk_Publicidad_Cobrable` (`cobrable_p` ASC) ,
  INDEX `fk_Publicidad_Rastreable` (`rastreable_p` ASC) ,
  UNIQUE INDEX `Buscable_P_UNIQUE` (`buscable_p` ASC) ,
  UNIQUE INDEX `Describible_P_UNIQUE` (`describible_p` ASC) ,
  UNIQUE INDEX `Rastreable_P_UNIQUE` (`rastreable_p` ASC) ,
  UNIQUE INDEX `Etiquetable_P_UNIQUE` (`etiquetable_p` ASC) ,
  UNIQUE INDEX `Cobrable_P_UNIQUE` (`cobrable_p` ASC) ,
  CONSTRAINT `fk_Publicidad_Etiquetable`
    FOREIGN KEY (`etiquetable_p` )
    REFERENCES `spuria`.`etiquetable` (`etiquetable_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Publicidad_Describible`
    FOREIGN KEY (`describible_p` )
    REFERENCES `spuria`.`describible` (`describible_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Publicidad_Patrocinante`
    FOREIGN KEY (`patrocinante` )
    REFERENCES `spuria`.`patrocinante` (`patrocinante_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Publicidad_Buscable`
    FOREIGN KEY (`buscable_p` )
    REFERENCES `spuria`.`buscable` (`buscable_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Publicidad_Cobrable`
    FOREIGN KEY (`cobrable_p` )
    REFERENCES `spuria`.`cobrable` (`cobrable_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Publicidad_Rastreable`
    FOREIGN KEY (`rastreable_p` )
    REFERENCES `spuria`.`rastreable` (`rastreable_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spuria`.`accion`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spuria`.`accion` (
  `valor` CHAR(13) NOT NULL ,
  PRIMARY KEY (`valor`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spuria`.`registro`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spuria`.`registro` (
  `registro_id` INT NOT NULL AUTO_INCREMENT ,
  `fecha_hora` DECIMAL(17,3) NULL ,
  `actor_activo` INT NOT NULL ,
  `accion` CHAR(13) NOT NULL ,
  `actor_pasivo` INT NULL ,
  `columna` TEXT NULL ,
  `valor` TEXT NULL ,
  PRIMARY KEY (`registro_id`) ,
  INDEX `fk_Registro_Accion` (`accion` ASC) ,
  INDEX `ix_ActorActivo` (`actor_activo` ASC) ,
  INDEX `ix_ActorPasivo` (`actor_pasivo` ASC) ,
  CONSTRAINT `fk_Registro_Accion`
    FOREIGN KEY (`accion` )
    REFERENCES `spuria`.`accion` (`valor` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spuria`.`estadisticas_de_visitas`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spuria`.`estadisticas_de_visitas` (
  `estadisticas_p` INT NOT NULL ,
  `estadisticas_de_visitas_id` INT NOT NULL AUTO_INCREMENT ,
  `buscable` INT NOT NULL ,
  PRIMARY KEY (`estadisticas_de_visitas_id`) ,
  INDEX `fk_EstadisticasDeVisitas_Buscable` (`buscable` ASC) ,
  INDEX `fk_EstadisticasDeVisitas_Estadisticas` (`estadisticas_p` ASC) ,
  UNIQUE INDEX `Estadisticas_P_UNIQUE` (`estadisticas_p` ASC) ,
  CONSTRAINT `fk_EstadisticasDeVisitas_Buscable`
    FOREIGN KEY (`buscable` )
    REFERENCES `spuria`.`buscable` (`buscable_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_EstadisticasDeVisitas_Estadisticas`
    FOREIGN KEY (`estadisticas_p` )
    REFERENCES `spuria`.`estadisticas` (`estadisticas_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spuria`.`contador_de_exhibiciones`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spuria`.`contador_de_exhibiciones` (
  `estadisticas_de_visitas_id` INT NOT NULL ,
  `fecha_inicio` DECIMAL(17,3) NOT NULL ,
  `fecha_fin` DECIMAL(17,3) NULL ,
  `valor` INT NOT NULL ,
  PRIMARY KEY (`estadisticas_de_visitas_id`, `fecha_inicio`) ,
  INDEX `fk_ContadorDeExhibiciones_EstadisticasDeVisitas` (`estadisticas_de_visitas_id` ASC) ,
  UNIQUE INDEX `FechaFin_UNIQUE` (`fecha_fin` ASC) ,
  CONSTRAINT `fk_ContadorDeExhibiciones_EstadisticasDeVisitas`
    FOREIGN KEY (`estadisticas_de_visitas_id` )
    REFERENCES `spuria`.`estadisticas_de_visitas` (`estadisticas_de_visitas_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spuria`.`tamano`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spuria`.`tamano` (
  `tienda_id` INT NOT NULL ,
  `fecha_inicio` DECIMAL(17,3) NOT NULL ,
  `fecha_fin` DECIMAL(17,3) NULL ,
  `numero_total_de_productos` INT NOT NULL ,
  `cantidad_total_de_productos` INT NULL ,
  `valor` INT NULL ,
  PRIMARY KEY (`tienda_id`, `fecha_inicio`) ,
  INDEX `fk_Tamano_Tienda` (`tienda_id` ASC) ,
  CONSTRAINT `fk_Tamano_Tienda`
    FOREIGN KEY (`tienda_id` )
    REFERENCES `spuria`.`tienda` (`tienda_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spuria`.`dia`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spuria`.`dia` (
  `valor` CHAR(9) NOT NULL ,
  `orden` INT NOT NULL ,
  PRIMARY KEY (`valor`) ,
  UNIQUE INDEX `orden_UNIQUE` (`orden` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spuria`.`horario_de_trabajo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spuria`.`horario_de_trabajo` (
  `tienda_id` INT NOT NULL ,
  `dia` CHAR(9) NOT NULL ,
  `laborable` TINYINT(1) NOT NULL ,
  PRIMARY KEY (`tienda_id`, `dia`) ,
  INDEX `fk_HorarioDeTrabajo_Dia` (`dia` ASC) ,
  INDEX `fk_HorarioDeTrabajo_Tienda` (`tienda_id` ASC) ,
  CONSTRAINT `fk_HorarioDeTrabajo_Tienda`
    FOREIGN KEY (`tienda_id` )
    REFERENCES `spuria`.`tienda` (`tienda_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_HorarioDeTrabajo_Dia`
    FOREIGN KEY (`dia` )
    REFERENCES `spuria`.`dia` (`valor` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spuria`.`turno`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spuria`.`turno` (
  `tienda_id` INT NOT NULL ,
  `dia` CHAR(9) NOT NULL ,
  `hora_de_apertura` TIME NOT NULL ,
  `hora_de_cierre` TIME NOT NULL ,
  INDEX `fk_Turno_HorarioDeTrabajo` (`tienda_id` ASC, `dia` ASC) ,
  PRIMARY KEY (`tienda_id`, `dia`, `hora_de_apertura`) ,
  CONSTRAINT `fk_Turno_HorarioDeTrabajo`
    FOREIGN KEY (`tienda_id` , `dia` )
    REFERENCES `spuria`.`horario_de_trabajo` (`tienda_id` , `dia` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spuria`.`grado_de_instruccion_objetivo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spuria`.`grado_de_instruccion_objetivo` (
  `publicidad_id` INT NOT NULL ,
  `grado_de_instruccion` CHAR(16) NOT NULL ,
  PRIMARY KEY (`publicidad_id`, `grado_de_instruccion`) ,
  INDEX `fk_GradoDeInstruccionObjetivo_GradoDeInstruccion` (`grado_de_instruccion` ASC) ,
  INDEX `fk_GradoDeInstruccionObjetivo_Publicidad` (`publicidad_id` ASC) ,
  CONSTRAINT `fk_GradoDeInstruccionObjetivo_Publicidad`
    FOREIGN KEY (`publicidad_id` )
    REFERENCES `spuria`.`publicidad` (`publicidad_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_GradoDeInstruccionObjetivo_GradoDeInstruccion`
    FOREIGN KEY (`grado_de_instruccion` )
    REFERENCES `spuria`.`grado_de_instruccion` (`valor` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spuria`.`sexo_objetivo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spuria`.`sexo_objetivo` (
  `publicidad_id` INT NOT NULL ,
  `sexo` CHAR(6) NOT NULL ,
  PRIMARY KEY (`publicidad_id`, `sexo`) ,
  INDEX `fk_SexoObjetivo_Sexo` (`sexo` ASC) ,
  INDEX `fk_SexoObjetivo_Publicidad` (`publicidad_id` ASC) ,
  CONSTRAINT `fk_SexoObjetivo_Publicidad`
    FOREIGN KEY (`publicidad_id` )
    REFERENCES `spuria`.`publicidad` (`publicidad_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SexoObjetivo_Sexo`
    FOREIGN KEY (`sexo` )
    REFERENCES `spuria`.`sexo` (`valor` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spuria`.`grupo_de_edad_objetivo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spuria`.`grupo_de_edad_objetivo` (
  `publicidad_id` INT NOT NULL ,
  `grupo_de_edad` CHAR(15) NOT NULL ,
  PRIMARY KEY (`publicidad_id`, `grupo_de_edad`) ,
  INDEX `fk_GrupoDeEdadObjetivo_GrupoDeEdad` (`grupo_de_edad` ASC) ,
  INDEX `fk_GrupoDeEdadObjetivo_Publicidad` (`publicidad_id` ASC) ,
  CONSTRAINT `fk_GrupoDeEdadObjetivo_Publicidad`
    FOREIGN KEY (`publicidad_id` )
    REFERENCES `spuria`.`publicidad` (`publicidad_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_GrupoDeEdadObjetivo_GrupoDeEdad`
    FOREIGN KEY (`grupo_de_edad` )
    REFERENCES `spuria`.`grupo_de_edad` (`valor` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spuria`.`territorio_objetivo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spuria`.`territorio_objetivo` (
  `publicidad_id` INT NOT NULL ,
  `territorio_id` CHAR(16) NOT NULL ,
  PRIMARY KEY (`publicidad_id`, `territorio_id`) ,
  INDEX `fk_TerritorioObjetivo_RegionGeografica` (`territorio_id` ASC) ,
  INDEX `fk_TerritorioObjetivo_Publicidad` (`publicidad_id` ASC) ,
  CONSTRAINT `fk_TerritorioObjetivo_Publicidad`
    FOREIGN KEY (`publicidad_id` )
    REFERENCES `spuria`.`publicidad` (`publicidad_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TerritorioObjetivo_RegionGeografica`
    FOREIGN KEY (`territorio_id` )
    REFERENCES `spuria`.`territorio` (`territorio_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spuria`.`consumidor_objetivo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spuria`.`consumidor_objetivo` (
  `publicidad_id` INT NOT NULL ,
  `consumidor_id` INT NOT NULL ,
  PRIMARY KEY (`publicidad_id`, `consumidor_id`) ,
  INDEX `fk_ConsumidorObjetivo_Consumidor` (`consumidor_id` ASC) ,
  INDEX `fk_ConsumidorObjetivo_Publicidad` (`publicidad_id` ASC) ,
  CONSTRAINT `fk_ConsumidorObjetivo_Publicidad`
    FOREIGN KEY (`publicidad_id` )
    REFERENCES `spuria`.`publicidad` (`publicidad_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ConsumidorObjetivo_Consumidor`
    FOREIGN KEY (`consumidor_id` )
    REFERENCES `spuria`.`consumidor` (`consumidor_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spuria`.`croquis`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spuria`.`croquis` (
  `rastreable_p` INT NOT NULL ,
  `croquis_id` INT NOT NULL AUTO_INCREMENT ,
  `dibujable` INT NOT NULL ,
  `area` FLOAT NULL ,
  `perimetro` FLOAT NULL ,
  INDEX `fk_Croquis_Dibujable` (`dibujable` ASC) ,
  INDEX `fk_Croquis_Rastreable` (`rastreable_p` ASC) ,
  UNIQUE INDEX `Rastreable_P_UNIQUE` (`rastreable_p` ASC) ,
  PRIMARY KEY (`croquis_id`) ,
  CONSTRAINT `fk_Croquis_Dibujable`
    FOREIGN KEY (`dibujable` )
    REFERENCES `spuria`.`dibujable` (`dibujable_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Croquis_Rastreable`
    FOREIGN KEY (`rastreable_p` )
    REFERENCES `spuria`.`rastreable` (`rastreable_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spuria`.`punto`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spuria`.`punto` (
  `punto_id` INT NOT NULL AUTO_INCREMENT ,
  `latitud` DECIMAL(9,6) NOT NULL ,
  `longitud` DECIMAL(9,6) NOT NULL ,
  PRIMARY KEY (`punto_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spuria`.`punto_de_croquis`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spuria`.`punto_de_croquis` (
  `croquis_id` INT NOT NULL ,
  `punto_id` INT NOT NULL ,
  PRIMARY KEY (`croquis_id`, `punto_id`) ,
  INDEX `fk_PuntoDeCroquis_Punto` (`punto_id` ASC) ,
  INDEX `fk_PuntoDeCroquis_Croquis` (`croquis_id` ASC) ,
  CONSTRAINT `fk_PuntoDeCroquis_Punto`
    FOREIGN KEY (`punto_id` )
    REFERENCES `spuria`.`punto` (`punto_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PuntoDeCroquis_Croquis`
    FOREIGN KEY (`croquis_id` )
    REFERENCES `spuria`.`croquis` (`croquis_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spuria`.`factura`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spuria`.`factura` (
  `rastreable_p` INT NOT NULL ,
  `factura_id` INT NOT NULL AUTO_INCREMENT ,
  `cliente` CHAR(10) NOT NULL ,
  `inicio_de_medicion` DECIMAL(17,3) NOT NULL ,
  `fin_de_medicion` DECIMAL(17,3) NOT NULL ,
  `subtotal` DECIMAL NOT NULL ,
  `impuestos` DECIMAL NOT NULL ,
  `total` DECIMAL NOT NULL ,
  PRIMARY KEY (`factura_id`) ,
  INDEX `fk_Factura_Cliente` (`cliente` ASC) ,
  INDEX `fk_Factura_Rastreable` (`rastreable_p` ASC) ,
  UNIQUE INDEX `Rastreable_P_UNIQUE` (`rastreable_p` ASC) ,
  CONSTRAINT `fk_Factura_Cliente`
    FOREIGN KEY (`cliente` )
    REFERENCES `spuria`.`cliente` (`rif` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Factura_Rastreable`
    FOREIGN KEY (`rastreable_p` )
    REFERENCES `spuria`.`rastreable` (`rastreable_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spuria`.`servicio_vendido`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spuria`.`servicio_vendido` (
  `factura_id` INT NOT NULL ,
  `cobrable_id` INT NOT NULL ,
  `acumulado` DECIMAL NOT NULL ,
  PRIMARY KEY (`factura_id`, `cobrable_id`) ,
  INDEX `fk_ServicioVendido_Cobrable` (`cobrable_id` ASC) ,
  INDEX `fk_ServicioVendido_Factura` (`factura_id` ASC) ,
  CONSTRAINT `fk_ServicioVendido_Cobrable`
    FOREIGN KEY (`cobrable_id` )
    REFERENCES `spuria`.`cobrable` (`cobrable_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ServicioVendido_Factura`
    FOREIGN KEY (`factura_id` )
    REFERENCES `spuria`.`factura` (`factura_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spuria`.`codigo_de_error`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spuria`.`codigo_de_error` (
  `Valor` CHAR(40) NOT NULL ,
  PRIMARY KEY (`Valor`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spuria`.`privilegios`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spuria`.`privilegios` (
  `valor` CHAR(7) NOT NULL ,
  PRIMARY KEY (`valor`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spuria`.`administrador`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spuria`.`administrador` (
  `usuario_p` INT NOT NULL ,
  `administrador_id` INT NOT NULL AUTO_INCREMENT ,
  `privilegios` CHAR(7) NOT NULL ,
  INDEX `fk_Administrador_Privilegios` (`privilegios` ASC) ,
  INDEX `fk_Administrador_Usuario` (`usuario_p` ASC) ,
  PRIMARY KEY (`administrador_id`) ,
  UNIQUE INDEX `Usuario_P_UNIQUE` (`usuario_p` ASC) ,
  CONSTRAINT `fk_Administrador_Privilegios`
    FOREIGN KEY (`privilegios` )
    REFERENCES `spuria`.`privilegios` (`valor` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Administrador_Usuario`
    FOREIGN KEY (`usuario_p` )
    REFERENCES `spuria`.`usuario` (`usuario_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spuria`.`resultado_de_busqueda`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spuria`.`resultado_de_busqueda` (
  `busqueda_id` INT NOT NULL ,
  `buscable_id` INT NOT NULL ,
  `visitado` TINYINT(1) NOT NULL ,
  `relevancia` FLOAT NOT NULL ,
  PRIMARY KEY (`busqueda_id`, `buscable_id`) ,
  INDEX `fk_ResultadoDeBusqueda_Busqueda` (`busqueda_id` ASC) ,
  INDEX `fk_ResultadoDeBusqueda_Buscable` (`buscable_id` ASC) ,
  CONSTRAINT `fk_ResultadoDeBusqueda_Buscable`
    FOREIGN KEY (`buscable_id` )
    REFERENCES `spuria`.`buscable` (`buscable_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ResultadoDeBusqueda_Busqueda`
    FOREIGN KEY (`busqueda_id` )
    REFERENCES `spuria`.`busqueda` (`busqueda_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spuria`.`estadisticas_temporales`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spuria`.`estadisticas_temporales` (
  `estadisticas_id` INT NOT NULL ,
  `fecha_inicio` DECIMAL(17,3) NOT NULL ,
  `fecha_fin` DECIMAL(17,3) NULL ,
  `contador` INT NOT NULL ,
  `ranking` INT NOT NULL ,
  `indice` INT NOT NULL ,
  INDEX `fk_EstadisticasTemporales_Estadisticas` (`estadisticas_id` ASC) ,
  PRIMARY KEY (`estadisticas_id`, `fecha_inicio`) ,
  CONSTRAINT `fk_EstadisticasTemporales_Estadisticas`
    FOREIGN KEY (`estadisticas_id` )
    REFERENCES `spuria`.`estadisticas` (`estadisticas_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spuria`.`precio_cantidad`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spuria`.`precio_cantidad` (
  `tienda_id` INT NOT NULL COMMENT '	' ,
  `codigo` CHAR(15) NOT NULL ,
  `fecha_inicio` DECIMAL(17,3) NOT NULL ,
  `fecha_fin` DECIMAL(17,3) NULL ,
  `precio` DECIMAL(10,2) NOT NULL ,
  `cantidad` DECIMAL(9,3) NOT NULL ,
  PRIMARY KEY (`tienda_id`, `codigo`, `fecha_inicio`) ,
  INDEX `fk_PrecioCantidad_Inventario` (`tienda_id` ASC, `codigo` ASC) ,
  CONSTRAINT `fk_PrecioCantidad_Inventario`
    FOREIGN KEY (`tienda_id` , `codigo` )
    REFERENCES `spuria`.`inventario` (`tienda_id` , `codigo` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spuria`.`tiendas_consumidores`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spuria`.`tiendas_consumidores` (
  `territorio_id` CHAR(16) NOT NULL ,
  `fecha_inicio` DECIMAL(17,3) NOT NULL ,
  `fecha_fin` DECIMAL(17,3) NULL ,
  `numero_de_consumidores` INT UNSIGNED NOT NULL ,
  `numero_de_tiendas` INT UNSIGNED NOT NULL ,
  PRIMARY KEY (`territorio_id`, `fecha_inicio`) ,
  INDEX `fk_TiendasConsumidores_Territorio` (`territorio_id` ASC) ,
  CONSTRAINT `fk_TiendasConsumidores_Territorio`
    FOREIGN KEY (`territorio_id` )
    REFERENCES `spuria`.`territorio` (`territorio_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spuria`.`region`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spuria`.`region` (
  `region_id` INT NOT NULL ,
  `nombre` VARCHAR(45) NOT NULL ,
  `nivel` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`region_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spuria`.`region_territorio`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spuria`.`region_territorio` (
  `region_id` INT NOT NULL ,
  `territorio_id` CHAR(16) NOT NULL ,
  PRIMARY KEY (`region_id`, `territorio_id`) ,
  INDEX `fk_Region_Territorio_Territorio` (`territorio_id` ASC) ,
  INDEX `fk_Region_Territorio_Region` (`region_id` ASC) ,
  CONSTRAINT `fk_Region_Territorio_Region`
    FOREIGN KEY (`region_id` )
    REFERENCES `spuria`.`region` (`region_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Region_Territorio_Territorio`
    FOREIGN KEY (`territorio_id` )
    REFERENCES `spuria`.`territorio` (`territorio_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Placeholder table for view `spuria`.`inventario_tienda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spuria`.`inventario_tienda` (`tienda_id` INT, `codigo` INT, `descripcion` INT, `precio` INT, `cantidad` INT);

-- -----------------------------------------------------
-- Placeholder table for view `spuria`.`inventario_reciente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spuria`.`inventario_reciente` (`tienda_id` INT, `producto_id` INT, `codigo` INT, `descripcion` INT, `precio` INT, `cantidad` INT);

-- -----------------------------------------------------
-- Placeholder table for view `spuria`.`tamano_reciente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spuria`.`tamano_reciente` (`tienda_id` INT, `fecha_inicio` INT, `numero_total_de_productos` INT, `cantidad_total_de_productos` INT, `valor` INT);

-- -----------------------------------------------------
-- View `spuria`.`inventario_tienda`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `spuria`.`inventario_tienda`;
USE `spuria`;
/*
Version original:

CREATE  OR REPLACE VIEW `Spuria`.`InventarioTienda` AS
SELECT Inventario.TiendaID TiendaID, Inventario.ProductoID ProductoID, SKU, Precio, Cantidad, Visibilidad 
FROM Inventario LEFT JOIN PrecioCantidad USING (TiendaID, ProductoID) WHERE FechaFin IS NULL
*/

/*
No se pueden hacer subqueries cuando se crea un VIEW en MySQL:

CREATE VIEW `Spuria`.`InventarioTienda` AS
SELECT TiendaID, Producto.CodigoUniversal CodigoProducto, SKU, Precio, Cantidad, Visibilidad 
FROM (SELECT Inventario.TiendaID TiendaID, Inventario.ProductoID ProductoID, SKU, Precio, Cantidad, Visibilidad 
FROM Inventario LEFT JOIN PrecioCantidad USING (TiendaID, ProductoID) WHERE FechaFin IS NULL) LEFT JOIN Producto
USING (ProductoID)
*/

/*
CREATE VIEW `Spuria`.`InventarioTienda` AS
SELECT Inventario.TiendaID TiendaID, Producto.CodigoUniversal CodigoDeBarras, Producto.Nombre Descripcion, SKU CodigoInterno, Precio, Cantidad, Visibilidad 
FROM Inventario, PrecioCantidad, Producto
WHERE Inventario.ProductoID = PrecioCantidad.ProductoID AND Inventario.TiendaID = PrecioCantidad.TiendaID 
AND PrecioCantidad.FechaFin IS NULL AND Inventario.ProductoID = Producto.ProductoID
*/

CREATE VIEW `spuria`.`inventario_tienda` AS
SELECT inventario.tienda_id tienda_id, inventario.codigo codigo, descripcion, precio, cantidad
FROM inventario LEFT JOIN precio_cantidad USING (tienda_id, codigo) WHERE fecha_fin IS NULL
;

-- -----------------------------------------------------
-- View `spuria`.`inventario_reciente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `spuria`.`inventario_reciente`;
USE `spuria`;
CREATE  OR REPLACE VIEW `spuria`.`inventario_reciente` AS
SELECT inventario.tienda_id tienda_id, inventario.producto_id producto_id, inventario.codigo codigo, descripcion, precio, cantidad
FROM inventario LEFT JOIN precio_cantidad USING (tienda_id, codigo) WHERE fecha_fin IS NULL;

-- -----------------------------------------------------
-- View `spuria`.`tamano_reciente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `spuria`.`tamano_reciente`;
USE `spuria`;
CREATE  OR REPLACE VIEW `spuria`.`tamano_reciente` AS
SELECT tienda_id, fecha_inicio, numero_total_de_productos, cantidad_total_de_productos, valor 
FROM tamano WHERE fecha_fin IS NULL;
USE `spuria`;

DELIMITER $$
USE `spuria`$$


CREATE TRIGGER antes_de_actualizar_tienda BEFORE UPDATE ON tienda
FOR EACH ROW
BEGIN
    IF NEW.buscable_p != OLD.buscable_p THEN
        SET NEW.buscable_p = OLD.buscable_p;
    END IF;
    IF NEW.cliente_p != OLD.cliente_p THEN
        SET NEW.cliente_p = OLD.cliente_p;
    END IF;
    IF NEW.calificable_seguible_p != OLD.calificable_seguible_p THEN
        SET NEW.calificable_seguible_p = OLD.calificable_seguible_p;
    END IF;
    IF NEW.interlocutor_p != OLD.interlocutor_p THEN
        SET NEW.interlocutor_p = OLD.interlocutor_p;
    END IF;
    IF NEW.dibujable_p != OLD.dibujable_p THEN
        SET NEW.dibujable_p = OLD.buscable_p;
    END IF;
    IF NEW.tienda_id != OLD.tienda_id THEN
        SET NEW.tienda_id = OLD.tienda_id;
    END IF;
END $$

USE `spuria`$$


CREATE TRIGGER antes_de_eliminar_tienda BEFORE DELETE ON tienda
FOR EACH ROW
BEGIN
    DELETE FROM interlocutor WHERE interlocutor_id = OLD.interlocutor_p;
    DELETE FROM calificable_seguible WHERE calificable_seguible_id = OLD.calificable_seguible_p;
    DELETE FROM dibujable WHERE dibujable_id = OLD.dibujable_p;
    DELETE FROM buscable WHERE buscable_id = OLD.buscable_p;
    DELETE FROM tamano WHERE tienda_id = OLD.tienda_id;
    DELETE FROM horario_de_trabajo WHERE tienda_id = OLD.tienda_id;
    DELETE FROM inventario WHERE tienda_id = OLD.tienda_id;
    DELETE FROM cliente WHERE rif = OLD.cliente_p;
END $$

USE `spuria`$$


CREATE TRIGGER despues_de_insertar_tienda AFTER INSERT ON tienda
FOR EACH ROW
BEGIN
    DECLARE columnas, valores TEXT;
    DECLARE rastreable_p, bobo INT;

    SELECT c.rastreable_p
    FROM cliente AS c
    WHERE c.rif = NEW.cliente_p
    INTO rastreable_p;
    
    SELECT 'buscable_p,cliente_p,calificable_seguible_p,interlocutor_p,dibujable_p,tienda_id,abierto' INTO columnas;
    SELECT CONCAT(
        CAST(NEW.buscable_p AS CHAR),',',
        CAST(NEW.cliente_p AS CHAR),',',
        CAST(NEW.calificable_seguible_p AS CHAR),',',
        CAST(NEW.interlocutor_p AS CHAR),',',
        CAST(NEW.dibujable_p AS CHAR),',',
        CAST(NEW.tienda_id AS CHAR),',',
        CAST(NEW.abierto AS CHAR)
    ) INTO valores;

    SELECT RegistrarActualizacion(rastreable_p, columnas, valores) INTO bobo;
END $$

USE `spuria`$$


CREATE TRIGGER despues_de_actualizar_tienda AFTER UPDATE ON tienda
FOR EACH ROW
BEGIN
    DECLARE rastreable_p, bobo INT;

    SELECT c.rastreable_p
    FROM cliente AS c
    WHERE c.rif = NEW.cliente_p
    INTO rastreable_p;
    
    SELECT 
    IF(NEW.abierto != OLD.abierto, RegistrarActualizacion(rastreable_p, 'abierto', NEW.abierto), 0)
    INTO bobo;
END $$


DELIMITER ;

DELIMITER $$
USE `spuria`$$


CREATE TRIGGER antes_de_actualizar_producto BEFORE UPDATE ON producto
FOR EACH ROW
BEGIN
    IF NEW.rastreable_p != OLD.rastreable_p THEN
        SET NEW.rastreable_p = OLD.rastreable_p;
    END IF;
    IF NEW.describible_p != OLD.describible_p THEN
        SET NEW.describible_p = OLD.describible_p;
    END IF;
    IF NEW.buscable_p != OLD.buscable_p THEN
        SET NEW.buscable_p = OLD.buscable_p;
    END IF;    
    IF NEW.calificable_seguible_p != OLD.calificable_seguible_p THEN
        SET NEW.calificable_seguible_p = OLD.calificable_seguible_p;
    END IF;
    IF NEW.producto_id != OLD.producto_id THEN
        SET NEW.producto_id = OLD.producto_id;
    END IF;
    IF NEW.tipo_de_codigo != OLD.tipo_de_codigo THEN
        SET NEW.tipo_de_codigo = OLD.tipo_de_codigo;
    END IF;
    IF NEW.codigo != OLD.codigo THEN
        SET NEW.codigo = OLD.codigo;
    END IF;
    IF NEW.fabricante != OLD.fabricante THEN
        SET NEW.fabricante = OLD.fabricante;
    END IF;
    IF NEW.nombre != OLD.nombre THEN
        SET NEW.nombre = OLD.nombre;
    END IF;
END $$

USE `spuria`$$


CREATE TRIGGER despues_de_insertar_producto AFTER INSERT ON producto
FOR EACH ROW
BEGIN
    DECLARE valores, columnas TEXT;
    DECLARE bobo INT;
        
    SELECT CONCAT(
        'rastreable_p,describible_p,buscable_p,',
        'calificable_seguible_p,producto_id,tipo_de_codigo,',
        'codigo,estatus,fabricante,nombre,categoria'
    ) INTO columnas;

    SELECT CONCAT(
        CAST(NEW.rastreable_p AS CHAR),',',
        CAST(NEW.describible_p AS CHAR),',',
        CAST(NEW.buscable_p AS CHAR),',',
        CAST(NEW.calificable_seguible_p AS CHAR),',',
        CAST(NEW.producto_id AS CHAR),',',
        NEW.tipo_de_codigo,',',
        NEW.codigo,',',
        NEW.estatus,',',
        NEW.fabricante,',',
        NEW.nombre,',',
        NEW.categoria
    ) INTO valores;
    
    SELECT RegistrarInsercion(NEW.rastreable_p, columnas, valores) INTO bobo;
END $$

USE `spuria`$$


CREATE TRIGGER antes_de_eliminar_producto BEFORE DELETE ON producto
FOR EACH ROW
BEGIN
    DECLARE bobo INT;

    SELECT RegistrarEliminacion(OLD.rastreable_p) INTO bobo;

    DELETE FROM inventario WHERE producto_id = OLD.producto_id;
    DELETE FROM describible WHERE describible_id = OLD.describible_p;
    DELETE FROM buscable WHERE buscable_id = OLD.buscable_p;
    DELETE FROM calificable_seguible WHERE calificable_seguible_id = OLD.calificable_seguible_p;
    /* OJO: Rastreable tiene que ser obligatoriamente el ultimo en eliminarse... sino va a haber problemas con el registro */
    DELETE FROM rastreable WHERE rastreable_id = OLD.rastreable_p;
END $$

USE `spuria`$$


CREATE TRIGGER despues_de_actualizar_producto AFTER UPDATE ON producto
FOR EACH ROW
BEGIN
    DECLARE bobo INT;
    
    SELECT
    IF(NEW.estatus != OLD.estatus, RegistrarActualizacion(NEW.rastreable_p, 'estatus', NEW.estatus), 0) +
    IF(NEW.modelo != OLD.modelo, RegistrarActualizacion(NEW.rastreable_p, 'modelo', NEW.modelo), 0) +
    IF(NEW.categoria != OLD.categoria, RegistrarActualizacion(NEW.rastreable_p, 'categoria', NEW.categoria), 0) +
    IF(NEW.debut_en_el_mercado != OLD.debut_en_el_mercado, RegistrarActualizacion(NEW.rastreable_p, 'debut_en_el_mercado', NEW.debut_en_el_mercado), 0) +
    IF(NEW.largo != OLD.largo, RegistrarActualizacion(NEW.rastreable_p, 'largo', NEW.largo), 0) +
    IF(NEW.ancho != OLD.ancho, RegistrarActualizacion(NEW.rastreable_p, 'ancho', NEW.ancho), 0) +
    IF(NEW.alto != OLD.alto, RegistrarActualizacion(NEW.rastreable_p, 'alto', NEW.alto), 0) +
    IF(NEW.peso != OLD.peso, RegistrarActualizacion(NEW.rastreable_p, 'peso', NEW.peso), 0) +
    IF(NEW.pais_de_origen != OLD.pais_de_origen, RegistrarActualizacion(NEW.rastreable_p, 'pais_de_origen', NEW.pais_de_origen), 0)
    INTO bobo;
END $$


DELIMITER ;

DELIMITER $$
USE `spuria`$$


CREATE TRIGGER antes_de_actualizar_categoria BEFORE UPDATE ON categoria
FOR EACH ROW
BEGIN
    IF NEW.etiquetable_p != OLD.etiquetable_p THEN
        SET NEW.etiquetable_p = OLD.etiquetable_p;
    END IF;
    IF NEW.categoria_id != OLD.categoria_id THEN
        SET NEW.categoria_id = OLD.categoria_id;
    END IF;
    IF NEW.nombre != OLD.nombre THEN
        SET NEW.nombre = OLD.nombre;
    END IF;
    IF NEW.hijo_de_categoria != OLD.hijo_de_categoria THEN
        SET NEW.hijo_de_categoria = OLD.hijo_de_categoria;
    END IF;
    IF NEW.nivel != OLD.nivel THEN
        SET NEW.nivel = OLD.nivel;
    END IF;
END $$

USE `spuria`$$


CREATE TRIGGER antes_de_eliminar_categoria BEFORE DELETE ON categoria
FOR EACH ROW
BEGIN
    DELETE FROM etiquetable WHERE etiquetable_id = OLD.etiquetable_p;
    /* Esta siguiente instruccion no la puede ejecutar el MYSQL por ser recursiva */
    /* DELETE FROM categoria WHERE hijo_de_categoria = OLD.categoria_id; */
END $$


DELIMITER ;

DELIMITER $$
USE `spuria`$$


CREATE TRIGGER antes_de_actualizar_etiquetable BEFORE UPDATE ON etiquetable
FOR EACH ROW
BEGIN
    IF NEW.etiquetable_id != OLD.etiquetable_id THEN
        SET NEW.etiquetable_id = OLD.etiquetable_id;
    END IF;
END $$

USE `spuria`$$


CREATE TRIGGER antes_de_eliminar_etiquetable BEFORE DELETE ON etiquetable
FOR EACH ROW
BEGIN
    DELETE FROM etiqueta WHERE etiquetable_id = OLD.etiquetable_id;
END $$


DELIMITER ;

DELIMITER $$
USE `spuria`$$


CREATE TRIGGER antes_de_actualizar_cliente BEFORE UPDATE ON cliente
FOR EACH ROW
BEGIN
    IF NEW.rastreable_p != OLD.rastreable_p THEN
        SET NEW.rastreable_p = OLD.rastreable_p;
    END IF;
    IF NEW.describible_p != OLD.describible_p THEN
        SET NEW.describible_p = OLD.describible_p;
    END IF;
    IF NEW.propietario != OLD.propietario THEN
        SET NEW.propietario = OLD.propietario;
    END IF;
    IF NEW.rif != OLD.rif THEN
        SET NEW.rif = OLD.rif;
    END IF;
    IF NEW.nombre_legal != OLD.nombre_legal THEN
        SET NEW.nombre_legal = OLD.nombre_legal;
    END IF;
END $$

USE `spuria`$$


CREATE TRIGGER despues_de_insertar_cliente AFTER INSERT ON cliente
FOR EACH ROW
BEGIN
    DECLARE columnas, valores TEXT;
    DECLARE bobo INT;

    SELECT CONCAT(
        'describible_p,propietario,rif,categoria,',
        'estatus,nombre_legal,nombre_comun,telefono,',
        'calle,sector_urb_barrio,ubicacion'
    ) INTO columnas;
        
    SELECT CONCAT(
        CAST(NEW.describible_p AS CHAR),',',
        CAST(NEW.propietario AS CHAR),',',
        NEW.rif,',',
        NEW.categoria,',',
        NEW.estatus,',',
        NEW.nombre_legal,',',
        NEW.nombre_comun,',',
        NEW.telefono,',',
        NEW.calle,',',
        NEW.sector_urb_barrio,',',
        NEW.ubicacion
    ) INTO valores;
    
    SELECT RegistrarInsercion(NEW.rastreable_p, columnas, valores) INTO bobo;
END $$

USE `spuria`$$


CREATE TRIGGER antes_de_eliminar_cliente BEFORE DELETE ON cliente
FOR EACH ROW
BEGIN
    DECLARE bobo INT;

    SELECT RegistrarEliminacion(OLD.rastreable_p) INTO bobo;
    
    DELETE FROM describible WHERE describible_id = OLD.describible_p;
    /*
    DELETE FROM tienda WHERE cliente_p = OLD.rif;
    DELETE FROM patrocinante WHERE cliente_p = OLD.rif;
    */
    DELETE FROM factura WHERE cliente = OLD.rif;
    /*DELETE FROM usuario WHERE usuario_id = OLD.usuario_p;*/
END $$

USE `spuria`$$


CREATE TRIGGER despues_de_actualizar_cliente AFTER UPDATE ON cliente
FOR EACH ROW
BEGIN
    DECLARE bobo INT;

    SELECT
    IF(NEW.categoria != OLD.categoria, RegistrarActualizacion(NEW.rastreable_p, 'categoria', NEW.categoria), 0)
    + IF(NEW.estatus != OLD.estatus, RegistrarActualizacion(NEW.rastreable_p, 'estatus', NEW.estatus), 0)
    + IF(NEW.nombre_comun != OLD.nombre_comun, RegistrarActualizacion(NEW.rastreable_p, 'nombre_comun', NEW.nombre_comun), 0)
    + IF(NEW.telefono != OLD.telefono, RegistrarActualizacion(NEW.rastreable_p, 'telefono', NEW.telefono), 0)
    + IF(NEW.edificio_cc != OLD.edificio_cc, RegistrarActualizacion(NEW.rastreable_p, 'edificio_cc', NEW.edificio_cc), 0)
    + IF(NEW.piso != OLD.piso, RegistrarActualizacion(NEW.rastreable_p, 'piso', NEW.piso), 0)
    + IF(NEW.apartamento != OLD.apartamento, RegistrarActualizacion(NEW.rastreable_p, 'apartamento', NEW.apartamento), 0)
    + IF(NEW.local_no != OLD.local_no, RegistrarActualizacion(NEW.rastreable_p, 'local_no', NEW.local_no), 0)
    + IF(NEW.casa != OLD.casa, RegistrarActualizacion(NEW.rastreable_p, 'casa', NEW.casa), 0)
    + IF(NEW.calle != OLD.calle, RegistrarActualizacion(NEW.rastreable_p, 'calle', NEW.calle), 0)
    + IF(NEW.sector_urb_barrio != OLD.sector_urb_barrio, RegistrarActualizacion(NEW.rastreable_p, 'sector_urb_barrio', NEW.sector_urb_barrio), 0)
    + IF(NEW.pagina_web != OLD.pagina_web, RegistrarActualizacion(NEW.rastreable_p, 'pagina_web', NEW.pagina_web), 0)
    + IF(NEW.facebook != OLD.facebook, RegistrarActualizacion(NEW.rastreable_p, 'facebook', NEW.facebook), 0)
    + IF(NEW.twitter != OLD.twitter, RegistrarActualizacion(NEW.rastreable_p, 'twitter', NEW.twitter), 0)
    + IF(NEW.correo_electronico != OLD.correo_electronico, RegistrarActualizacion(NEW.rastreable_p, 'correo_electronico', NEW.correo_electronico), 0)
    + IF(NEW.ubicacion != OLD.ubicacion, RegistrarActualizacion(NEW.rastreable_p, 'ubicacion', NEW.ubicacion), 0)
    INTO bobo;
END $$


DELIMITER ;

DELIMITER $$
USE `spuria`$$


CREATE TRIGGER despues_de_insertar_inventario AFTER INSERT ON inventario
FOR EACH ROW
BEGIN
    DECLARE columnas, valores TEXT;
    DECLARE bobo INT;
    
    SELECT 'rastreable_p,cobrable_p,tienda_id,codigo,visibilidad' INTO columnas;

    SELECT CONCAT(
        CAST(NEW.rastreable_p AS CHAR),',',
        CAST(NEW.cobrable_p AS CHAR),',',
        CAST(NEW.tienda_id AS CHAR),',',
        NEW.codigo,',',
        NEW.visibilidad
    ) INTO valores;
        
    SELECT RegistrarInsercion (NEW.rastreable_p, columnas, valores) INTO bobo;
END $$

USE `spuria`$$


CREATE TRIGGER antes_de_actualizar_inventario BEFORE UPDATE ON inventario
FOR EACH ROW
BEGIN
    IF NEW.rastreable_p != OLD.rastreable_p THEN
        SET NEW.rastreable_p = OLD.rastreable_p;
    END IF;
    IF NEW.cobrable_p != OLD.cobrable_p THEN
        SET NEW.cobrable_p = OLD.cobrable_p;
    END IF;
    IF NEW.tienda_id != OLD.tienda_id THEN
        SET NEW.tienda_id = OLD.tienda_id;
    END IF;
    IF NEW.codigo != OLD.codigo THEN
        SET NEW.codigo = OLD.codigo;
    END IF;
END $$

USE `spuria`$$


CREATE TRIGGER antes_de_eliminar_inventario BEFORE DELETE ON inventario
FOR EACH ROW
BEGIN
    DECLARE bobo INT;
       
    SELECT RegistrarEliminacion(OLD.rastreable_p) INTO bobo;

    DELETE FROM precio_cantidad WHERE tienda_id = OLD.tienda_id AND codigo = OLD.codigo;
/*
    DELETE FROM cantidad WHERE tienda_id = OLD.tienda_id AND codigo = OLD.codigo;
    DELETE FROM precio WHERE tienda_id = OLD.tienda_id AND codigo = OLD.codigo;
*/
    DELETE FROM cobrable WHERE cobrable_id = OLD.cobrable_p;
    /* OJO: Rastreable tiene que ser obligatoriamente el ultimo en eliminarse... sino va a haber problemas con el registro */
    DELETE FROM rastreable WHERE rastreable_id = OLD.rastreable_p;
END $$

USE `spuria`$$


CREATE TRIGGER despues_de_actualizar_inventario AFTER UPDATE ON inventario
FOR EACH ROW
BEGIN
    DECLARE bobo INT;
    
    SELECT
    IF(NEW.descripcion != OLD.descripcion, RegistrarActualizacion(NEW.rastreable_p, 'descripcion', NEW.descripcion), 0)
    + IF(NEW.visibilidad != OLD.visibilidad, RegistrarActualizacion(NEW.rastreable_p, 'visibilidad', NEW.visibilidad), 0)
    + IF(NEW.producto_id != OLD.producto_id, RegistrarActualizacion(NEW.rastreable_p, 'producto_id', NEW.producto_id), 0)
    INTO bobo;
END $$


DELIMITER ;

DELIMITER $$
USE `spuria`$$


CREATE TRIGGER antes_de_actualizar_mensaje BEFORE UPDATE ON mensaje
FOR EACH ROW
BEGIN
    IF NEW.rastreable_p != OLD.rastreable_p THEN
        SET NEW.rastreable_p = OLD.rastreable_p;
    END IF;
    IF NEW.etiquetable_p != OLD.etiquetable_p THEN
        SET NEW.etiquetable_p = OLD.etiquetable_p;
    END IF;
    IF NEW.mensaje_id != OLD.mensaje_id THEN
        SET NEW.mensaje_id = OLD.mensaje_id;
    END IF;
    IF NEW.remitente != OLD.remitente THEN
        SET NEW.remitente = OLD.remitente;
    END IF;
    IF NEW.destinatario != OLD.destinatario THEN
        SET NEW.destinatario = OLD.destinatario;
    END IF;
    IF NEW.contenido != OLD.contenido THEN
        SET NEW.destinatario = OLD.contenido;
    END IF;
END $$

USE `spuria`$$


CREATE TRIGGER antes_de_eliminar_mensaje BEFORE DELETE ON mensaje
FOR EACH ROW
BEGIN
    DECLARE bobo INT;

    SELECT RegistrarEliminacion (OLD.rastreable_p) INTO bobo;

    DELETE FROM etiquetable WHERE etiquetable_id = OLD.etiquetable_p;
    DELETE FROM rastreable WHERE rastreable_id = OLD.rastreable_p;    
END $$

USE `spuria`$$


CREATE TRIGGER despues_de_insertar_mensaje AFTER INSERT ON mensaje
FOR EACH ROW
BEGIN
    DECLARE columnas, valores TEXT;
    DECLARE bobo INT;
    
    SELECT 'rastreable_p,etiquetable_p,mensaje_id,rastreable_p,remitente,destinatario,contenido' INTO columnas;
    SELECT CONCAT(
        CAST(NEW.rastreable_p AS CHAR), ',',
        CAST(NEW.etiquetable_p AS CHAR), ',',
        CAST(NEW.mensaje_id AS CHAR), ',',
        CAST(NEW.rastreable_p AS CHAR), ',',
        CAST(NEW.remitente AS CHAR), ',',
        CAST(NEW.destinatario AS CHAR), ',',
        NEW.contenido
    ) INTO valores;

    SELECT RegistrarInsercion(NEW.rastreable_p, columnas, valores) INTO bobo;
END $$


DELIMITER ;

DELIMITER $$
USE `spuria`$$


CREATE TRIGGER antes_de_eliminar_interlocutor BEFORE DELETE ON interlocutor
FOR EACH ROW
BEGIN
    DELETE FROM mensaje WHERE remitente = OLD.interlocutor_id OR destinatario = OLD.interlocutor_id;
END $$

USE `spuria`$$


CREATE TRIGGER antes_de_actualizar_interlocutor BEFORE UPDATE ON interlocutor
FOR EACH ROW
BEGIN
    IF NEW.interlocutor_id != OLD.interlocutor_id THEN
        SET NEW.interlocutor_id = OLD.interlocutor_id;
    END IF;
END $$


DELIMITER ;

DELIMITER $$
USE `spuria`$$


CREATE TRIGGER antes_de_actualizar_consumidor BEFORE UPDATE ON consumidor
FOR EACH ROW
BEGIN
    IF NEW.interlocutor_p != OLD.interlocutor_p THEN
        SET NEW.interlocutor_p = OLD.interlocutor_p;
    END IF;
    IF NEW.usuario_p != OLD.usuario_p THEN
        SET NEW.usuario_p = OLD.usuario_p;
    END IF;
    IF NEW.consumidor_id != OLD.consumidor_id THEN
        SET NEW.consumidor_id = OLD.consumidor_id;
    END IF;
    IF NEW.fecha_de_nacimiento != OLD.fecha_de_nacimiento THEN
        SET NEW.fecha_de_nacimiento = OLD.fecha_de_nacimiento;
    END IF;
END $$

USE `spuria`$$


CREATE TRIGGER despues_de_insertar_consumidor AFTER INSERT ON consumidor
FOR EACH ROW
BEGIN
    DECLARE columnas, valores TEXT;
    DECLARE bobo, rastreable_p INT;

    SELECT usuario.rastreable_p FROM usuario 
    WHERE usuario_id = NEW.usuario_p
    INTO rastreable_p;
        
    SELECT CONCAT(
        'interlocutor_p,usuario_p,consumidor_id,',
        'sexo,fecha_de_nacimiento,grupo_de_edad,grado_de_instruccion'
    ) INTO columnas;

    SELECT CONCAT(
        CAST(NEW.interlocutor_p AS CHAR),',',
        CAST(NEW.usuario_p AS CHAR),',',
        CAST(NEW.consumidor_id AS CHAR),',',
        NEW.sexo,',',
        CAST(NEW.fecha_de_nacimiento AS CHAR),',',
        NEW.grupo_de_edad,',',
        NEW.grado_de_instruccion
    ) INTO valores;
    
    SELECT RegistrarActualizacion(rastreable_p, columnas, valores) INTO bobo;
END $$

USE `spuria`$$


CREATE TRIGGER antes_de_eliminar_consumidor BEFORE DELETE ON consumidor
FOR EACH ROW
BEGIN
/*
    DECLARE bobo, rastreable_p INT;

    SELECT usuario.rastreable_p FROM usuario 
    WHERE usuario_id = OLD.usuario_p
    INTO rastreable_p;
    
    SELECT RegistrarEliminacion(rastreable_p, CONCAT('consumidor: ', OLD.nombre, ' ', OLD.apellido)) INTO bobo;
*/    
    DELETE FROM interlocutor WHERE interlocutor_id = OLD.interlocutor_p;
    DELETE FROM seguidor WHERE consumidor_id = OLD.consumidor_id;
    DELETE FROM calificacion_resena WHERE consumidor_id = OLD.consumidor_id;
    DELETE FROM consumidor_objetivo WHERE consumidor_id = OLD.consumidor_id;
    DELETE FROM usuario WHERE usuario_id = OLD.usuario_p;
END $$

USE `spuria`$$


CREATE TRIGGER despues_de_actualizar_consumidor AFTER UPDATE ON consumidor
FOR EACH ROW
BEGIN
    DECLARE bobo, rastreable_p INT;
    
    SELECT usuario.rastreable_p FROM usuario 
    WHERE usuario_id = NEW.usuario_p
    INTO rastreable_p;

    SELECT
    IF(NEW.sexo != OLD.sexo, RegistrarActualizacion(rastreable_p, 'sexo', NEW.sexo), 0)
    + IF(NEW.grado_de_instruccion != OLD.grado_de_instruccion, RegistrarActualizacion(rastreable_p, 'grado_de_instruccion', NEW.grado_de_instruccion), 0)
    + IF(NEW.grupo_de_edad != OLD.grupo_de_edad, RegistrarActualizacion(rastreable_p, 'grupo_de_edad', NEW.grupo_de_edad), 0)
    INTO bobo;
END $$


DELIMITER ;

DELIMITER $$
USE `spuria`$$


CREATE TRIGGER despues_de_insertar_usuario AFTER INSERT ON usuario
FOR EACH ROW
BEGIN
    DECLARE columnas, valores TEXT;
    DECLARE bobo INT;

    SELECT 'describible_p,usuario_id,nombre,apellido,estatus' INTO columnas;
    SELECT CONCAT(
        CAST(NEW.describible_p AS CHAR),',',
        CAST(NEW.usuario_id AS CHAR),',',
        NEW.nombre,',',
        NEW.apellido,',',
        NEW.estatus
    ) INTO valores;
    
    SELECT RegistrarInsercion(NEW.rastreable_p, columnas, valores) INTO bobo;
END $$

USE `spuria`$$


CREATE TRIGGER antes_de_actualizar_rusuario BEFORE UPDATE ON usuario
FOR EACH ROW
BEGIN
    IF NEW.usuario_id != OLD.usuario_id THEN
        SET NEW.usuario_id = OLD.usuario_id;
    END IF;
    IF NEW.rastreable_p != OLD.rastreable_p THEN
        SET NEW.rastreable_p = OLD.rastreable_p;
    END IF;
    IF NEW.describible_p != OLD.describible_p THEN
        SET NEW.describible_p = OLD.describible_p;
    END IF;
END $$

USE `spuria`$$


CREATE TRIGGER despues_de_actualizar_usuario AFTER UPDATE ON usuario
FOR EACH ROW
BEGIN
    DECLARE bobo INT;

    SELECT
    IF(NEW.nombre != OLD.nombre, RegistrarActualizacion(NEW.rastreable_p, 'nombre', NEW.nombre), 0)
    + IF(NEW.apellido != OLD.apellido, RegistrarActualizacion(NEW.rastreable_p, 'apellido', NEW.apellido), 0)
    + IF(NEW.ubicacion != OLD.ubicacion, RegistrarActualizacion(NEW.rastreable_p, 'ubicacion', NEW.ubicacion), 0)
    + IF(NEW.estatus != OLD.estatus, RegistrarActualizacion(NEW.rastreable_p, 'estatus', NEW.estatus), 0)
    INTO bobo;
END $$

USE `spuria`$$


CREATE TRIGGER antes_de_eliminar_usuario BEFORE DELETE ON usuario
FOR EACH ROW
BEGIN
    DECLARE bobo INT;

    SELECT RegistrarEliminacion(OLD.rastreable_p) INTO bobo;
    
    DELETE FROM acceso WHERE acceso_id = OLD.usuario_id;
    DELETE FROM busqueda WHERE busqueda_id = OLD.usuario_id;
    /* OJO: Rastreable tiene que ser obligatoriamente el ultimo en eliminarse... sino va a haber problemas con el registro */
    DELETE FROM rastreable WHERE rastreable_id = OLD.rastreable_p;
    DELETE FROM describible WHERE describible_id = OLD.describible_p;
END $$


DELIMITER ;

DELIMITER $$
USE `spuria`$$


CREATE TRIGGER antes_de_actualizar_busqueda BEFORE UPDATE ON busqueda
FOR EACH ROW
BEGIN
    IF NEW.rastreable_p != OLD.rastreable_p THEN
        SET NEW.rastreable_p = OLD.rastreable_p;
    END IF;
    IF NEW.etiquetable_p != OLD.etiquetable_p THEN
        SET NEW.etiquetable_p = OLD.etiquetable_p;
    END IF;
    IF NEW.busqueda_id != OLD.busqueda_id THEN
        SET NEW.busqueda_id = OLD.busqueda_id;
    END IF;
    IF NEW.usuario != OLD.usuario THEN
        SET NEW.usuario = OLD.usuario;
    END IF;
    IF NEW.fecha_hora != OLD.fecha_hora THEN
        SET NEW.fecha_hora = OLD.fecha_hora;
    END IF;
    IF NEW.contenido != OLD.contenido THEN
        SET NEW.contenido = OLD.contenido;
    END IF;
END $$

USE `spuria`$$


CREATE TRIGGER antes_de_eliminar_busqueda BEFORE DELETE ON busqueda
FOR EACH ROW
BEGIN
    DECLARE bobo INT;
    
    SELECT RegistrarEliminacion(OLD.rastreable_p) INTO bobo;
    
    DELETE FROM etiquetable WHERE etiquetable_id = OLD.etiquetable_p;
    DELETE FROM resultado_de_busqueda WHERE busqueda_id = OLD.busqueda_id;
    /* OJO: Rastreable tiene que ser obligatoriamente el ultimo en eliminarse... sino va a haber problemas con el registro */
    DELETE FROM rastreable WHERE rastreable_id = OLD.rastreable_p;
END $$

USE `spuria`$$


CREATE TRIGGER despues_de_insertar_busqueda AFTER INSERT ON busqueda
FOR EACH ROW
BEGIN
    DECLARE columnas, valores TEXT;
    DECLARE bobo INT;
    
    SELECT 'rastreable_p,etiquetable_p,busqueda_id,usuario,fecha_hora,contenido' INTO columnas;
    SELECT CONCAT(
        CAST(NEW.rastreable_p AS CHAR),',',
        CAST(NEW.etiquetable_p AS CHAR),',',
        CAST(NEW.busqueda_id AS CHAR),',',
        CAST(NEW.usuario AS CHAR),',',
        CAST(NEW.fecha_hora AS CHAR),',',
        NEW.contenido
    ) INTO valores;
    
    SELECT RegistrarInsercion(NEW.rastreable_p, columnas, valores) INTO bobo;
END $$


DELIMITER ;

DELIMITER $$
USE `spuria`$$


CREATE TRIGGER antes_de_actualizar_palabra BEFORE UPDATE ON palabra
FOR EACH ROW
BEGIN
    IF NEW.palabra_id != OLD.palabra_id THEN
        SET NEW.palabra_id = OLD.palabra_id;
    END IF;
    IF NEW.palabra_frase != OLD.palabra_frase THEN
        SET NEW.palabra_frase = OLD.palabra_frase;
    END IF;
END $$

USE `spuria`$$


CREATE TRIGGER antes_de_eliminar_palabra BEFORE DELETE ON palabra
FOR EACH ROW
BEGIN
    DELETE FROM relacion_de_palabras WHERE palabra1_id = OLD.palabra_id OR palabra2_id = OLD.palabra_id;
    DELETE FROM estadisticas_de_influencia WHERE palabra = OLD.palabra_id;
    DELETE FROM etiqueta WHERE palabra_id = OLD.palabra_id;
END $$


DELIMITER ;

DELIMITER $$
USE `spuria`$$


CREATE TRIGGER antes_de_actualizar_relacion_de_palabras BEFORE UPDATE ON relacion_de_palabras
FOR EACH ROW
BEGIN
/*
    IF NEW.palabra1_id != OLD.palabra1_id THEN
        SET NEW.palabra1_id = OLD.palabra1_id;
    END IF;
    IF NEW.palabra2_id != OLD.palabra2_id THEN
        SET NEW.palabra2_id = OLD.palabra2_id;
    END IF;
*/
END $$


DELIMITER ;

DELIMITER $$
USE `spuria`$$


CREATE TRIGGER t_estadisticas_de_influenciaModificarAntes BEFORE UPDATE ON estadisticas_de_influencia
FOR EACH ROW
BEGIN
    IF NEW.estadisticas_p != OLD.estadisticas_p THEN
        SET NEW.estadisticas_p = OLD.estadisticas_p;
    END IF;
    IF NEW.estadisticas_de_influencia_id != OLD.estadisticas_de_influencia_id THEN
        SET NEW.estadisticas_de_influencia_id = OLD.estadisticas_de_influencia_id;
    END IF;
    IF NEW.palabra != OLD.palabra THEN
        SET NEW.palabra = OLD.palabra;
    END IF;
END $$

USE `spuria`$$


CREATE TRIGGER antes_de_eliminar_estadisticas_de_influencia BEFORE DELETE ON estadisticas_de_influencia
FOR EACH ROW
BEGIN
    DELETE FROM estadisticas WHERE estadisticas_id = OLD.estadisticas_p;
END $$

USE `spuria`$$


CREATE TRIGGER despues_de_insertar_estadisticas_de_influencia AFTER INSERT ON estadisticas_de_influencia
FOR EACH ROW
BEGIN
    DECLARE columnas, valores TEXT;
    DECLARE rastreable_p, bobo INT;
    
    SELECT CONCAT(
        'estadisticas_p,estadisticas_de_influencia_id,palabra,',
        'numero_de_descripciones,numero_de_mensajes,numero_de_categorias,',
        'numero_de_resenas,numero_de_publicidades'
    ) INTO columnas;

    SELECT CONCAT(
        CAST(NEW.estadisticas_p AS CHAR),',',
        CAST(NEW.estadisticas_de_influencia_id AS CHAR),',',
        CAST(NEW.palabra AS CHAR),',',
        CAST(NEW.numero_de_descripciones AS CHAR),',',
        CAST(NEW.numero_de_mensajes AS CHAR),',',
        CAST(NEW.numero_de_categorias AS CHAR),',',
        CAST(NEW.numero_de_resenas AS CHAR),',',
        CAST(NEW.numero_de_publicidades AS CHAR)
    ) INTO valores;
    
    SELECT estadisticas.rastreable_p FROM estadisticas
    WHERE estadisticas_id = NEW.estadisticas_p
    INTO rastreable_p;
    
    SELECT RegistrarActualizacion(rastreable_p, columnas, valores) INTO bobo;
END $$

USE `spuria`$$


CREATE TRIGGER despues_de_actualizar_estadisticas_de_influencia AFTER UPDATE ON estadisticas_de_influencia
FOR EACH ROW
BEGIN
    DECLARE rastreable_p, bobo INT;
    
    SELECT estadisticas.rastreable_p FROM estadisticas
    WHERE estadisticas_id = NEW.estadisticas_p
    INTO rastreable_p;
     
    SELECT
    IF(NEW.numero_de_descripciones != OLD.numero_de_descripciones, RegistrarActualizacion(rastreable_p, 'numero_de_descripciones', NEW.numero_de_descripciones), 0)
    + IF(NEW.numero_de_mensajes != OLD.numero_de_mensajes, RegistrarActualizacion(rastreable_p, 'numero_de_mensajes', NEW.numero_de_mensajes), 0)
    + IF(NEW.numero_de_categorias != OLD.numero_de_categorias, RegistrarActualizacion(rastreable_p, 'numero_de_categorias', NEW.numero_de_categorias), 0)
    + IF(NEW.numero_de_resenas != OLD.numero_de_resenas, RegistrarActualizacion(rastreable_p, 'numero_de_resenas', NEW.numero_de_resenas), 0)
    + IF(NEW.numero_de_publicidades != OLD.numero_de_publicidades, RegistrarActualizacion(rastreable_p, 'numero_de_publicidades', NEW.numero_de_publicidades), 0)
    INTO bobo;
END $$


DELIMITER ;

DELIMITER $$
USE `spuria`$$


CREATE TRIGGER antes_de_actualizar_calificacion_resena BEFORE UPDATE ON calificacion_resena
FOR EACH ROW
BEGIN
    IF NEW.rastreable_p != OLD.rastreable_p THEN
        SET NEW.rastreable_p = OLD.rastreable_p;
    END IF;
    IF NEW.etiquetable_p != OLD.etiquetable_p THEN
        SET NEW.etiquetable_p = OLD.etiquetable_p;
    END IF;
    IF NEW.calificacion_resena_id != OLD.calificacion_resena_id THEN
        SET NEW.calificacion_resena_id = OLD.calificacion_resena_id;
    END IF;
    IF NEW.consumidor_id != OLD.consumidor_id THEN
        SET NEW.consumidor_id = OLD.consumidor_id;
    END IF;
END $$

USE `spuria`$$


CREATE TRIGGER despues_de_insertar_calificacion_resena AFTER INSERT ON calificacion_resena
FOR EACH ROW
BEGIN
    DECLARE columnas, valores TEXT;
    DECLARE bobo INT;
    
    SELECT 'rastreable_p,etiquetable_p,calificacion_resena_id,consumidor_id,calificacion,resena' INTO columnas;
    SELECT CONCAT(
        CAST(NEW.rastreable_p AS CHAR),',',
        CAST(NEW.etiquetable_p AS CHAR),',',
        CAST(NEW.calificacion_resena_id AS CHAR),',',
        CAST(NEW.consumidor_id AS CHAR),',',
        NEW.calificacion,',',
        NEW.resena
    ) INTO valores;
    
    SELECT RegistrarInsercion(NEW.rastreable_p, columnas, valores) INTO bobo;
END $$

USE `spuria`$$


CREATE TRIGGER despues_de_actualizar_calificacion_resena AFTER UPDATE ON calificacion_resena
FOR EACH ROW
BEGIN
    DECLARE bobo INT;
    
    SELECT
    IF(NEW.calificacion != OLD.calificacion, RegistrarActualizacion(NEW.rastreable_p, 'calificacion', NEW.calificacion), 0)
    + IF(NEW.resena != OLD.resena, RegistrarActualizacion(NEW.rastreable_p, 'resena', NEW.resena), 0)
    INTO bobo;
END $$

USE `spuria`$$


CREATE TRIGGER antes_de_eliminar_calificacion_resena BEFORE DELETE ON calificacion_resena
FOR EACH ROW
BEGIN
    DECLARE bobo INT;
    
    SELECT RegistrarEliminacion(OLD.rastreable_p) INTO bobo;
    
    DELETE FROM etiquetable WHERE etiquetable_id = OLD.etiquetable_p;
    /* OJO: Rastreable tiene que ser obligatoriamente el ultimo en eliminarse... sino va a haber problemas con el registro */
    DELETE FROM rastreable WHERE rastreable_id = OLD.rastreable_p;
END $$


DELIMITER ;

DELIMITER $$
USE `spuria`$$


CREATE TRIGGER antes_de_actualizar_calificable_seguible BEFORE UPDATE ON calificable_seguible
FOR EACH ROW
BEGIN
    IF NEW.calificable_seguible_id != OLD.calificable_seguible_id THEN
        SET NEW.calificable_seguible_id = OLD.calificable_seguible_id;
    END IF;
END $$

USE `spuria`$$


CREATE TRIGGER antes_de_eliminar_calificable_seguible BEFORE DELETE ON calificable_seguible
FOR EACH ROW
BEGIN
    DELETE FROM calificacion_resena WHERE calificable_seguible_id = OLD.calificable_seguible_id;
    DELETE FROM seguidor WHERE calificable_seguible_id = OLD.calificable_seguible_id;
    DELETE FROM estadisticas_de_popularidad WHERE calificable_seguible = OLD.calificable_seguible_id;
END $$


DELIMITER ;

DELIMITER $$
USE `spuria`$$


CREATE TRIGGER antes_de_actualizar_seguidor BEFORE UPDATE ON seguidor
FOR EACH ROW
BEGIN
    IF NEW.rastreable_p != OLD.rastreable_p THEN
        SET NEW.rastreable_p = OLD.rastreable_p;
    END IF;
    IF NEW.consumidor_id != OLD.consumidor_id THEN
        SET NEW.consumidor_id = OLD.consumidor_id;
    END IF;
    IF NEW.calificable_seguible_id != OLD.calificable_seguible_id THEN
        SET NEW.calificable_seguible_id = OLD.calificable_seguible_id;
    END IF;
END $$

USE `spuria`$$


CREATE TRIGGER despues_de_insertar_seguidor AFTER INSERT ON seguidor
FOR EACH ROW
BEGIN
    DECLARE columnas, valores TEXT;
    DECLARE bobo INT;
        
    SELECT 'rastreable_p,consumidor_id,calificable_seguible_id,avisar_si' INTO columnas;
    SELECT CONCAT(
        CAST(NEW.rastreable_p AS CHAR),',',
        CAST(NEW.consumidor_id AS CHAR),',',
        CAST(NEW.calificable_seguible_id AS CHAR),',',
        NEW.avisar_si
    ) INTO valores;
    
    SELECT RegistrarInsercion(NEW.rastreable_p, columnas, valores) INTO bobo;
END $$

USE `spuria`$$


CREATE TRIGGER antes_de_eliminar_seguidor BEFORE DELETE ON seguidor
FOR EACH ROW
BEGIN
    DECLARE bobo INT;

    SELECT RegistrarEliminacion(OLD.rastreable_p) INTO bobo;

    DELETE FROM rastreable WHERE rastreable_id = OLD.rastreable_p;
END $$

USE `spuria`$$


CREATE TRIGGER despues_de_actualizar_seguidor AFTER UPDATE ON seguidor
FOR EACH ROW
BEGIN
    DECLARE bobo INT;
    
    SELECT
    IF(
        NEW.avisar_si != OLD.avisar_si, 
        RegistrarActualizacion(NEW.rastreable_p, 'avisar_si', NEW.avisar_si),
        0
    ) INTO bobo;
END $$


DELIMITER ;

DELIMITER $$
USE `spuria`$$


CREATE TRIGGER antes_de_actualizar_estadisticas_de_popularidad BEFORE UPDATE ON estadisticas_de_popularidad
FOR EACH ROW
BEGIN
    IF NEW.estadisticas_p != OLD.estadisticas_p THEN
        SET NEW.estadisticas_p = OLD.estadisticas_p;
    END IF;
    IF NEW.estadisticas_de_popularidad_id != OLD.estadisticas_de_popularidad_id THEN
        SET NEW.estadisticas_de_popularidad_id = OLD.estadisticas_de_popularidad_id;
    END IF;
    IF NEW.calificable_seguible != OLD.calificable_seguible THEN
        SET NEW.calificable_seguible = OLD.calificable_seguible;
    END IF;
END $$

USE `spuria`$$


CREATE TRIGGER antes_de_eliminar_estadisticas_de_popularidad BEFORE DELETE ON estadisticas_de_popularidad
FOR EACH ROW
BEGIN
    DELETE FROM estadisticas WHERE estadisticasID = OLD.estadisticas_p;
END $$

USE `spuria`$$


CREATE TRIGGER despues_de_insertar_estadisticas_de_popularidad AFTER INSERT ON estadisticas_de_popularidad
FOR EACH ROW
BEGIN
    DECLARE columnas, valores TEXT;
    DECLARE rastreable_p, bobo INT;

    SELECT CONCAT(
        'estadisticas_p,estadisticas_de_popularidad_id,',
        'calificable_seguible,numero_de_calificaciones,',
        'numero_de_resenas,numero_de_seguidores,numero_de_menciones'
    ) INTO columnas;

    SELECT CONCAT(
        CAST(NEW.estadisticas_p AS CHAR),'->',
        CAST(NEW.estadisticas_de_popularidad_id AS CHAR),',',
        CAST(NEW.calificable_seguible AS CHAR),',',
        CAST(NEW.numero_de_calificaciones AS CHAR),',',
        CAST(NEW.numero_de_resenas AS CHAR),',',
        CAST(NEW.numero_de_seguidores AS CHAR),',',
        CAST(NEW.numero_de_menciones AS CHAR)
    ) INTO valores;
    
    SELECT estadisticas.rastreable_p FROM estadisticas
    WHERE estadisticas_id = NEW.estadisticas_p
    INTO rastreable_p;
    
    SELECT RegistrarActualizacion(rastreable_p, columnas, valores) INTO bobo;
END $$

USE `spuria`$$


CREATE TRIGGER despues_de_actualizar_estadisticas_de_popularidad AFTER UPDATE ON estadisticas_de_popularidad
FOR EACH ROW
BEGIN
    DECLARE rastreable_p, bobo INT;
    
    SELECT estadisticas.rastreable_p FROM estadisticas
    WHERE estadisticasID = NEW.estadisticas_p
    INTO rastreable_p;
            
    SELECT
    IF(NEW.numero_de_calificaciones != OLD.numero_de_calificaciones, RegistrarActualizacion(rastreable_p, 'numero_de_calificaciones', NEW.numero_de_calificaciones), 0)
    + IF(NEW.numero_de_resenas != OLD.numero_de_resenas, RegistrarActualizacion(rastreable_p, 'numero_de_resenas', NEW.numero_de_resenas), 0)
    + IF(NEW.numero_de_seguidores != OLD.numero_de_seguidores, RegistrarActualizacion(rastreable_p, 'numero_de_seguidores', NEW.numero_de_seguidores), 0)
    + IF(NEW.numero_de_menciones != OLD.numero_de_menciones, RegistrarActualizacion(rastreable_p, 'numero_de_menciones', NEW.numero_de_menciones), 0)
    + IF(NEW.numero_de_vendedores != OLD.numero_de_vendedores, RegistrarActualizacion(rastreable_p, 'numero_de_vendedores', NEW.numero_de_vendedores), 0)
    + IF(NEW.numero_de_mensajes != OLD.numero_de_mensajes, RegistrarActualizacion(rastreable_p, 'numero_de_mensajes', NEW.numero_de_mensajes), 0)
    INTO bobo;
END $$


DELIMITER ;

DELIMITER $$
USE `spuria`$$


CREATE TRIGGER antes_de_actualizar_etiqueta BEFORE UPDATE ON etiqueta
FOR EACH ROW
BEGIN
    IF NEW.etiquetable_id != OLD.etiquetable_id THEN
        SET NEW.etiquetable_id = OLD.etiquetable_id;
    END IF;
    IF NEW.palabra_id != OLD.palabra_id THEN
        SET NEW.palabra_id = OLD.palabra_id;
    END IF;
END $$


DELIMITER ;

DELIMITER $$
USE `spuria`$$


CREATE TRIGGER antes_de_actualizar_descripcion BEFORE UPDATE ON descripcion
FOR EACH ROW
BEGIN
    IF NEW.rastreable_p != OLD.rastreable_p THEN
        SET NEW.rastreable_p = OLD.rastreable_p;
    END IF;
    IF NEW.etiquetable_p != OLD.etiquetable_p THEN
        SET NEW.etiquetable_p = OLD.etiquetable_p;
    END IF;
    IF NEW.descripcion_id != OLD.descripcion_id THEN
        SET NEW.descripcion_id = OLD.descripcion_id;
    END IF;
    IF NEW.describible != OLD.describible THEN
        SET NEW.describible = OLD.describible;
    END IF;
END $$

USE `spuria`$$


CREATE TRIGGER despues_de_insertar_descripcion AFTER INSERT ON descripcion
FOR EACH ROW
BEGIN
    DECLARE columnas, valores TEXT;
    DECLARE bobo INT;
    
    SELECT 'rastreable_p,etiquetable_p,descripcion_id,describible,contenido' INTO columnas;
    SELECT CONCAT(
        CAST(NEW.rastreable_p AS CHAR),',',
        CAST(NEW.etiquetable_p AS CHAR),',',
        CAST(NEW.descripcion_id AS CHAR),',',
        CAST(NEW.describible AS CHAR),',',
        NEW.contenido
    ) INTO valores;
    
    SELECT RegistrarInsercion(NEW.rastreable_p, columnas, valores) INTO bobo;
END $$

USE `spuria`$$


CREATE TRIGGER antes_de_eliminar_descripcion BEFORE DELETE ON descripcion
FOR EACH ROW
BEGIN
    DECLARE bobo INT;

    SELECT RegistrarEliminacion(OLD.rastreable_p) INTO bobo;

    DELETE FROM etiquetable WHERE etiquetable_id = OLD.etiquetable_p;
    /* OJO: Rastreable tiene que ser obligatoriamente el ultimo en eliminarse... sino va a haber problemas con el registro */
    DELETE FROM rastreable WHERE rastreable_id = OLD.rastreable_p;
END $$

USE `spuria`$$


CREATE TRIGGER despues_de_actualizar_descripcion AFTER UPDATE ON descripcion
FOR EACH ROW
BEGIN
    DECLARE bobo INT;

    SELECT 
    IF(NEW.contenido != OLD.contenido, RegistrarActualizacion(NEW.rastreable_p, 'contenido', NEW.contenido), 0) 
    INTO bobo;
END $$


DELIMITER ;

DELIMITER $$
USE `spuria`$$


CREATE TRIGGER antes_de_actualizar_publicidad BEFORE UPDATE ON publicidad
FOR EACH ROW
BEGIN
    IF NEW.buscable_p != OLD.buscable_p THEN
        SET NEW.buscable_p = OLD.buscable_p;
    END IF;
    IF NEW.describible_p != OLD.describible_p THEN
        SET NEW.describible_p = OLD.describible_p;
    END IF;
    IF NEW.rastreable_p != OLD.rastreable_p THEN
        SET NEW.rastreable_p = OLD.rastreable_p;
    END IF;
    IF NEW.etiquetable_p != OLD.etiquetable_p THEN
        SET NEW.etiquetable_p = OLD.etiquetable_p;
    END IF;
    IF NEW.cobrable_p != OLD.cobrable_p THEN
        SET NEW.cobrable_p = OLD.cobrable_p;
    END IF;
    IF NEW.publicidad_id != OLD.publicidad_id THEN
        SET NEW.publicidad_id = OLD.publicidad_id;
    END IF;
    IF NEW.patrocinante != OLD.patrocinante THEN
        SET NEW.patrocinante = OLD.patrocinante;
    END IF;
END $$

USE `spuria`$$


CREATE TRIGGER antes_de_eliminar_publicidad BEFORE DELETE ON publicidad
FOR EACH ROW
BEGIN
    DECLARE bobo INT;

    SELECT RegistrarEliminacion(OLD.rastreable_p) INTO bobo;

    DELETE FROM etiquetable WHERE etiquetable_id = OLD.etiquetable_p;
    DELETE FROM describible WHERE describible_id = OLD.describible_p;
    DELETE FROM buscable WHERE buscable_id = OLD.buscable_p;
    DELETE FROM cobrable WHERE cobrable_id = OLD.cobrable_p;
    DELETE FROM consumidor_objetivo WHERE publicidad_id = OLD.publicidad_id;
    DELETE FROM grupo_de_edad_objetivo WHERE publicidad_id = OLD.publicidad_id;
    DELETE FROM grado_de_instruccion_objetivo WHERE publicidad_id = OLD.publicidad_id;
    DELETE FROM territorio_objetivo WHERE publicidad_id = OLD.publicidad_id;
    DELETE FROM sexo_objetivo WHERE publicidad_id = OLD.publicidad_id;
    /* OJO: Rastreable tiene que ser obligatoriamente el ultimo en eliminarse... sino va a haber problemas con el registro */
    DELETE FROM rastreable WHERE rastreable_id = OLD.rastreable_p;
END $$

USE `spuria`$$


CREATE TRIGGER despues_de_insertar_publicidad AFTER INSERT ON publicidad
FOR EACH ROW
BEGIN
    DECLARE columnas, valores TEXT;
    DECLARE bobo INT;
    
    SELECT 'buscable_p,describible_p,rastreable_p,etiquetable_p,cobrable_p,publicidad_id,patrocinante' INTO columnas;
    SELECT CONCAT(
        CAST(NEW.buscable_p AS CHAR),',',
        CAST(NEW.describible_p AS CHAR),',',
        CAST(NEW.rastreable_p AS CHAR),',',
        CAST(NEW.etiquetable_p AS CHAR),',',
        CAST(NEW.cobrable_p AS CHAR),',',
        CAST(NEW.publicidad_id AS CHAR),',',
        CAST(NEW.patrocinante AS CHAR),',',
        NEW.nombre
    ) INTO valores;
    
    SELECT RegistrarInsercion(NEW.rastreable_p, columnas, valores) INTO bobo;
END $$

USE `spuria`$$


CREATE TRIGGER despues_de_actualizar_publicidad AFTER UPDATE ON publicidad  
FOR EACH ROW
BEGIN
    DECLARE bobo INT;
    
    SELECT 
    IF(NEW.nombre != OLD.nombre, RegistrarActualizacion(NEW.rastreable_p, 'nombre', NEW.nombre), 0) 
    + IF(
        NEW.tamano_de_poblacion_objetivo != OLD.tamano_de_poblacion_objetivo, 
        RegistrarActualizacion(NEW.rastreable_p, 'tamano_de_poblacion_objetivo', NEW.tamano_de_poblacion_objetivo), 
        0
    ) INTO bobo;
END $$


DELIMITER ;

DELIMITER $$
USE `spuria`$$


CREATE TRIGGER antes_de_actualizar_describible BEFORE UPDATE ON describible
FOR EACH ROW
BEGIN
    IF NEW.describible_id != OLD.describible_id THEN
        SET NEW.describible_id = OLD.describible_id;
    END IF;
END $$

USE `spuria`$$


CREATE TRIGGER antes_de_eliminar_describible BEFORE DELETE ON describible
FOR EACH ROW
BEGIN
    DELETE FROM descripcion WHERE describible = OLD.describible_id;
    /* Este tal vez no sea necesario borrarlo... */
    DELETE FROM foto WHERE describible = OLD.describible_id;
END $$


DELIMITER ;

DELIMITER $$
USE `spuria`$$


CREATE TRIGGER antes_de_actualizar_registro BEFORE UPDATE ON registro
FOR EACH ROW
BEGIN
    IF NEW.registro_id != OLD.registro_id THEN
        SET NEW.registro_id = OLD.registro_id;
    END IF;
    IF NEW.fecha_hora != OLD.fecha_hora THEN
        SET NEW.fecha_hora = OLD.fecha_hora;
    END IF;
    IF NEW.actor_activo != OLD.actor_activo THEN
        SET NEW.actor_activo = OLD.actor_activo;
    END IF;
    IF NEW.accion != OLD.accion THEN
        SET NEW.accion = OLD.accion;
    END IF;
    IF NEW.actor_pasivo != OLD.actor_pasivo THEN
        SET NEW.actor_pasivo = OLD.actor_pasivo;
    END IF;
    IF NEW.columna != OLD.columna THEN
        SET NEW.columna = OLD.columna;
    END IF;
    IF NEW.valor != OLD.valor THEN
        SET NEW.valor = OLD.valor;
    END IF;
END $$


DELIMITER ;

DELIMITER $$
USE `spuria`$$


CREATE TRIGGER antes_de_actualizar_rastreable BEFORE UPDATE ON rastreable
FOR EACH ROW
BEGIN
    IF NEW.rastreable_id != OLD.rastreable_id THEN
        SET NEW.rastreable_id = OLD.rastreable_id;
    END IF;
    IF NEW.fecha_de_creacion != OLD.fecha_de_creacion THEN
        SET NEW.fecha_de_creacion = OLD.fecha_de_creacion;
    END IF;
    IF NEW.creado_por != OLD.creado_por THEN
        SET NEW.creado_por = OLD.creado_por;
    END IF;
END $$


DELIMITER ;

DELIMITER $$
USE `spuria`$$


CREATE TRIGGER antes_de_actualizar_buscable BEFORE UPDATE ON buscable
FOR EACH ROW
BEGIN
    IF NEW.buscable_id != OLD.buscable_id THEN
        SET NEW.buscable_id = OLD.buscable_id;
    END IF;
END $$

USE `spuria`$$


CREATE TRIGGER antes_de_eliminar_buscable BEFORE DELETE ON buscable
FOR EACH ROW
BEGIN
    DELETE FROM estadisticas_de_visitas WHERE buscable = OLD.buscable_id;
    DELETE FROM resultado_de_busqueda WHERE buscable_id = OLD.buscable_id;
END $$


DELIMITER ;

DELIMITER $$
USE `spuria`$$


CREATE TRIGGER antes_de_actualizar_estadisticas_de_visitas BEFORE UPDATE ON estadisticas_de_visitas
FOR EACH ROW
BEGIN
    IF NEW.estadisticas_p != OLD.estadisticas_p THEN
        SET NEW.estadisticas_p = OLD.estadisticas_p;
    END IF;
    IF NEW.estadisticas_de_visitas_id != OLD.estadisticas_de_visitas_id THEN
        SET NEW.estadisticas_de_visitas_id = OLD.estadisticas_de_visitas_id;
    END IF;
    IF NEW.buscable != OLD.buscable THEN
        SET NEW.buscable = OLD.buscable;
    END IF;
END $$

USE `spuria`$$


CREATE TRIGGER antes_de_eliminar_estadisticas_de_visitas BEFORE DELETE ON estadisticas_de_visitas
FOR EACH ROW
BEGIN
    DELETE FROM contador_de_exhibiciones WHERE estadisticas_de_visitas_id = OLD.estadisticas_de_visitas_id;
    DELETE FROM estadisticas WHERE estadisticas_id = OLD.estadisticas_p;
END $$

USE `spuria`$$


CREATE TRIGGER despues_de_insertar_estadisticas_de_visitas AFTER INSERT ON estadisticas_de_visitas
FOR EACH ROW
BEGIN
    DECLARE columnas, valores TEXT;
    DECLARE rastreable_p, bobo INT;
    
    SELECT 'estadisticas_p,estadisticas_de_visitas_id,buscable' INTO columnas;
    SELECT CONCAT(
        CAST(NEW.estadisticas_p AS CHAR),',',
        CAST(NEW.estadisticas_de_visitas_id AS CHAR),',',
        CAST(NEW.buscable AS CHAR)
    ) INTO valores;
    
    SELECT estadisticas.rastreable_p FROM estadisticas
    WHERE estadisticas_id = NEW.estadisticas_p
    INTO rastreable_p;
    
    SELECT RegistrarActualizacion(rastreable_p, columnas, valores) INTO bobo;
END $$


DELIMITER ;

DELIMITER $$
USE `spuria`$$


CREATE TRIGGER antes_de_actualizar_estadisticas BEFORE UPDATE ON estadisticas
FOR EACH ROW
BEGIN
    IF NEW.rastreable_p != OLD.rastreable_p THEN
        SET NEW.rastreable_p = OLD.rastreable_p;
    END IF;
    IF NEW.estadisticas_id != OLD.estadisticas_id THEN
        SET NEW.estadisticas_id = OLD.estadisticas_id;
    END IF;
    IF NEW.territorio != OLD.territorio THEN
        SET NEW.territorio = OLD.territorio;
    END IF;
END $$

USE `spuria`$$


CREATE TRIGGER antes_de_eliminar_estadisticas BEFORE DELETE ON estadisticas
FOR EACH ROW
BEGIN
    DECLARE bobo INT;
    
    SELECT RegistrarEliminacion(OLD.rastreable_p) INTO bobo;
    DELETE FROM estadisticas_temporales WHERE estadisticas_id = OLD.estadisticas_id;
    /*
    DELETE FROM contador WHERE estadisticas_id = OLD.estadisticas_id;
    DELETE FROM ranking WHERE estadisticas_id = OLD.estadisticas_id;
    DELETE FROM indice WHERE estadisticas_id = OLD.estadisticas_id;
    */
END $$

USE `spuria`$$


CREATE TRIGGER despues_de_insertar_estadisticas AFTER INSERT ON estadisticas
FOR EACH ROW
BEGIN
    DECLARE columnas, valores TEXT;
    DECLARE bobo INT;

    SELECT 'rastreable_p,estadisticas_id,territorio' INTO columnas;
    SELECT CONCAT(
        CAST(NEW.rastreable_p AS CHAR), ',',
        CAST(NEW.estadisticas_id AS CHAR), ',',
        NEW.territorio
    ) INTO valores;

    SELECT RegistrarInsercion(NEW.rastreable_p, columnas, valores) INTO bobo;
END $$


DELIMITER ;

DELIMITER $$
USE `spuria`$$


CREATE TRIGGER antes_de_actualizar_contador_de_exhibiciones BEFORE UPDATE ON contador_de_exhibiciones
FOR EACH ROW
BEGIN
    IF NEW.estadisticas_de_visitas_id != OLD.estadisticas_de_visitas_id THEN
        SET NEW.estadisticas_de_visitas_id = OLD.estadisticas_de_visitas_id;
    END IF;
    IF NEW.fecha_inicio != OLD.fecha_inicio THEN
        SET NEW.fecha_inicio = OLD.fecha_inicio;
    END IF;
END $$

USE `spuria`$$


CREATE TRIGGER despues_de_insertar_contador_de_exhibiciones AFTER INSERT ON contador_de_exhibiciones
FOR EACH ROW
BEGIN
    DECLARE columnas, valores TEXT;
    DECLARE rastreable_p, bobo INT;
    
    SELECT e.rastreable_p 
    FROM estadisticas AS e
    LEFT JOIN estadisticas_de_visitas AS ev ON e.estadisticas_id = ev.estadisticas_p
    WHERE ev.estadisticas_de_visitas_id = NEW.estadisticas_de_visitas_id
    INTO rastreable_p;
    
    SELECT 'fecha_inicio,valor(contador_de_exhibiciones)' INTO columnas;
    SELECT CONCAT(
        CAST(NEW.fecha_inicio AS CHAR),',',
        CAST(NEW.valor AS CHAR)
    ) INTO valores;
    
    SELECT RegistrarActualizacion(rastreable_p, columnas, valores) INTO bobo;
END $$

USE `spuria`$$


CREATE TRIGGER despues_de_actualizar_contador_de_exhibiciones AFTER UPDATE ON contador_de_exhibiciones
FOR EACH ROW
BEGIN
    DECLARE rastreable_p, bobo INT;
    
    SELECT e.rastreable_p 
    FROM estadisticas AS e
    LEFT JOIN estadisticas_de_visitas AS ev ON e.estadisticas_id = ev.estadisticas_p
    WHERE ev.estadisticas_de_visitas_id = NEW.estadisticas_de_visitas_id
    INTO rastreable_p;
    
    SELECT
    IF(NEW.fecha_fin != OLD.fecha_fin, RegistrarActualizacion(rastreable_p, 'fecha_fin', NEW.fecha_fin), 0)
    + IF(NEW.valor != OLD.valor, RegistrarActualizacion(rastreable_p, 'valor(contador_de_exhibiciones)', NEW.valor), 0)
    INTO bobo;
END $$


DELIMITER ;

DELIMITER $$
USE `spuria`$$


CREATE TRIGGER antes_de_actualizar_territorio BEFORE UPDATE ON territorio
FOR EACH ROW
BEGIN
    IF NEW.rastreable_p != OLD.rastreable_p THEN
        SET NEW.rastreable_p = OLD.rastreable_p;
    END IF;
    IF NEW.dibujable_p != OLD.dibujable_p THEN
        SET NEW.dibujable_p = OLD.dibujable_p;
    END IF;
    IF NEW.territorio_id != OLD.territorio_id THEN
        SET NEW.territorio_id = OLD.territorio_id;
    END IF;
END $$

USE `spuria`$$


CREATE TRIGGER despues_de_insertar_territorio AFTER INSERT ON territorio
FOR EACH ROW
BEGIN
    DECLARE columnas, valores TEXT;
    DECLARE bobo INT;
    
    SELECT CONCAT(
        'rastreable_p,dibujable_p,territorio_id,',
        'nombre,poblacion,consumidores_poblacion,',
        'tiendas_poblacion'
    ) INTO columnas;

    SELECT CONCAT(
        CAST(NEW.rastreable_p AS CHAR),',',
        CAST(NEW.dibujable_p AS CHAR),',' ,
        NEW.territorio_id,',' ,
        NEW.nombre,',',
        CAST(NEW.poblacion AS CHAR),',',
        CAST(NEW.consumidores_poblacion AS CHAR),',',
        CAST(NEW.tiendas_poblacion AS CHAR)
    ) INTO valores;
    
    SELECT RegistrarInsercion(NEW.rastreable_p, columnas, valores) INTO bobo;
END $$

USE `spuria`$$


CREATE TRIGGER despues_de_actualizar_territorio AFTER UPDATE ON territorio
FOR EACH ROW
BEGIN
    DECLARE bobo INT;
    
    SELECT
    IF(NEW.nombre != OLD.nombre, RegistrarActualizacion(NEW.rastreable_p, 'nombre', NEW.nombre), 0)
    + IF(NEW.poblacion != OLD.poblacion, RegistrarActualizacion(NEW.rastreable_p, 'poblacion', NEW.poblacion), 0)
    + IF(NEW.nivel != OLD.nivel, RegistrarActualizacion(NEW.rastreable_p, 'nivel', NEW.nivel), 0)
    + IF(NEW.territorio_padre != OLD.territorio_padre, RegistrarActualizacion(NEW.rastreable_p, 'territorio_padre', NEW.territorio_padre), 0)
    + IF(NEW.consumidores_poblacion != OLD.consumidores_poblacion, RegistrarActualizacion(NEW.rastreable_p, 'consumidores_poblacion', NEW.consumidores_poblacion), 0)
    + IF(NEW.tiendas_poblacion != OLD.tiendas_poblacion, RegistrarActualizacion(NEW.rastreable_p, 'tiendas_poblacion', NEW.tiendas_poblacion), 0)
    + IF(NEW.tiendas_consumidores != OLD.tiendas_consumidores, RegistrarActualizacion(NEW.rastreable_p, 'tiendas_consumidores', NEW.tiendas_consumidores), 0)
    + IF(NEW.codigo_postal != OLD.codigo_postal, RegistrarActualizacion(NEW.rastreable_p, 'codigo_postal', NEW.codigo_postal), 0)
    + IF(NEW.pib != OLD.pib, RegistrarActualizacion(NEW.rastreable_p, 'pib', NEW.pib), 0)
    INTO bobo;
END $$

USE `spuria`$$


CREATE TRIGGER antes_de_eliminar_territorio BEFORE DELETE ON territorio
FOR EACH ROW
BEGIN
    DECLARE bobo INT;

    SELECT RegistrarEliminacion(OLD.rastreable_p) INTO bobo;

    DELETE FROM tiendas_consumidores WHERE territorio_id = OLD.territorio_id;
    DELETE FROM territorio_objetivo WHERE territorio_id = OLD.territorio_id;
    DELETE FROM estadisticas WHERE territorio = OLD.territorio_id;
    DELETE FROM dibujable WHERE dibujable_id = OLD.dibujable_p;
    DELETE FROM region_territorio WHERE territorio_id = OLD.territorio_id;
    /* OJO: Rastreable tiene que ser obligatoriamente el ultimo en eliminarse... sino va a haber problemas con el registro */
    DELETE FROM rastreable WHERE rastreable_id = OLD.rastreable_p;
END $$


DELIMITER ;

DELIMITER $$
USE `spuria`$$


CREATE TRIGGER antes_de_actualizar_tamano BEFORE UPDATE ON tamano
FOR EACH ROW
BEGIN
    IF NEW.tienda_id != OLD.tienda_id THEN
        SET NEW.tienda_id = OLD.tienda_id;
    END IF;
    IF NEW.fecha_inicio != OLD.fecha_inicio THEN
        SET NEW.fecha_inicio = OLD.fecha_inicio;
    END IF;
END $$

USE `spuria`$$


CREATE TRIGGER despues_de_insertar_tamano AFTER INSERT ON tamano
FOR EACH ROW
BEGIN
    DECLARE columnas, valores TEXT;
    DECLARE rastreable_p, bobo INT;
    
    SELECT c.rastreable_p
    FROM cliente AS c
    LEFT JOIN tienda AS t ON c.rif = t.cliente_p
    WHERE t.tienda_id = NEW.tienda_id
    INTO rastreable_p;

    SELECT 'fecha_inicio,numero_total_de_productos' INTO columnas;
    SELECT CONCAT(
        CAST(NEW.fecha_inicio AS CHAR),',',
        CAST(NEW.numero_total_de_productos AS CHAR)
    ) INTO valores;
    
    SELECT RegistrarActualizacion(rastreable_p, columnas, valores) INTO bobo;
END $$

USE `spuria`$$


CREATE TRIGGER despues_de_actualizar_tamano AFTER UPDATE ON tamano
FOR EACH ROW
BEGIN
    DECLARE rastreable_p, bobo INT;
    
    SELECT c.rastreable_p
    FROM cliente AS c
    LEFT JOIN tienda AS t ON c.rif = t.cliente_p
    WHERE t.tienda_id = NEW.tienda_id
    INTO rastreable_p;
        
    SELECT
    IF(NEW.fecha_fin != OLD.fecha_fin, RegistrarActualizacion(rastreable_p, 'fecha_fin', NEW.fecha_fin), 0)
    + IF(NEW.numero_total_de_productos != OLD.numero_total_de_productos, RegistrarActualizacion(rastreable_p, 'numero_total_de_productos', NEW.numero_total_de_productos), 0)
    + IF(NEW.cantidad_total_de_productos != OLD.cantidad_total_de_productos, RegistrarActualizacion(rastreable_p, 'cantidad_total_de_productos', NEW.cantidad_total_de_productos), 0)
    + IF(NEW.valor != OLD.valor, RegistrarActualizacion(rastreable_p, 'valor(tamano)', NEW.valor), 0)
    INTO bobo;
END $$


DELIMITER ;

DELIMITER $$
USE `spuria`$$


CREATE TRIGGER antes_de_actualizar_turno BEFORE UPDATE ON turno
FOR EACH ROW
BEGIN
    IF NEW.tienda_id != OLD.tienda_id THEN
        SET NEW.tienda_id = OLD.tienda_id;
    END IF;
    IF NEW.dia != OLD.dia THEN
        SET NEW.dia = OLD.dia;
    END IF;
END $$

USE `spuria`$$


CREATE TRIGGER despues_de_insertar_turno AFTER INSERT ON turno
FOR EACH ROW
BEGIN
    DECLARE columnas, valores TEXT;
    DECLARE rastreable_p, bobo INT;
    
    SELECT c.rastreable_p
    FROM cliente AS c
    LEFT JOIN tienda AS t ON c.rif = t.cliente_p
    WHERE t.tienda_id = NEW.tienda_id
    INTO rastreable_p;

    SELECT 'dia,hora_de_apertura,hora_de_cierre' INTO columnas;
    SELECT CONCAT(
        NEW.dia,',',
        CAST(NEW.hora_de_apertura AS CHAR),',',
        CAST(NEW.hora_de_cierre AS CHAR)
    ) INTO valores;
    
    SELECT RegistrarActualizacion(rastreable_p, columnas, valores) INTO bobo;
END $$

USE `spuria`$$


CREATE TRIGGER despues_de_actualizar_turno AFTER UPDATE ON turno
FOR EACH ROW
BEGIN
    DECLARE rastreable_p, bobo INT;
    
    SELECT c.rastreable_p
    FROM cliente AS c
    LEFT JOIN tienda AS t ON c.rif = t.cliente_p
    WHERE t.tienda_id = NEW.tienda_id
    INTO rastreable_p;
            
    SELECT
    IF(NEW.hora_de_apertura != OLD.hora_de_apertura, RegistrarActualizacion(rastreable_p, 'hora_de_apertura', NEW.hora_de_apertura), 0)
    + IF(NEW.hora_de_cierre != OLD.hora_de_cierre, RegistrarActualizacion(rastreable_p, 'hora_de_cierre', NEW.hora_de_cierre), 0) 
    INTO bobo;
END $$


DELIMITER ;

DELIMITER $$
USE `spuria`$$


CREATE TRIGGER antes_de_actualizar_horario_de_trabajo BEFORE UPDATE ON horario_de_trabajo
FOR EACH ROW
BEGIN
    IF NEW.tienda_id != OLD.tienda_id THEN
        SET NEW.tienda_id = OLD.tienda_id;
    END IF;
    IF NEW.dia != OLD.dia THEN
        SET NEW.dia = OLD.dia;
    END IF;
END $$

USE `spuria`$$


CREATE TRIGGER despues_de_insertar_horario_de_trabajo AFTER INSERT ON horario_de_trabajo
FOR EACH ROW
BEGIN
    DECLARE columnas, valores TEXT;
    DECLARE rastreable_p, bobo INT;
    
    SELECT c.rastreable_p
    FROM cliente AS c
    LEFT JOIN tienda AS t ON c.rif = t.cliente_p
    WHERE t.tienda_id = NEW.tienda_id
    INTO rastreable_p;

    SELECT 'dia,laborable' INTO columnas;
    SELECT CONCAT(NEW.dia,',',CAST(NEW.laborable AS CHAR)) INTO valores;
    
    SELECT RegistrarActualizacion(rastreable_p, columnas, valores) INTO bobo;
END $$

USE `spuria`$$


CREATE TRIGGER antes_de_eliminar_horario_de_trabajo BEFORE DELETE ON horario_de_trabajo
FOR EACH ROW
BEGIN
    DELETE FROM turno WHERE tienda_id = OLD.tienda_id;
END $$

USE `spuria`$$


CREATE TRIGGER despues_de_actualizar_horario_de_trabajo AFTER UPDATE ON horario_de_trabajo
FOR EACH ROW
BEGIN
    DECLARE rastreable_p, bobo INT;
    
    SELECT c.rastreable_p
    FROM cliente AS c
    LEFT JOIN tienda AS t ON c.rif = t.cliente_p
    WHERE t.tienda_id = NEW.tienda_id
    INTO rastreable_p;

    SELECT
    IF(NEW.laborable != OLD.laborable, RegistrarActualizacion(rastreable_p, 'laborable', NEW.laborable), 0)
    INTO bobo;
END $$


DELIMITER ;

DELIMITER $$
USE `spuria`$$


CREATE TRIGGER antes_de_actualizar_patrocinante BEFORE UPDATE ON patrocinante
FOR EACH ROW
BEGIN
    IF NEW.cliente_p != OLD.cliente_p THEN
        SET NEW.cliente_p = OLD.cliente_p;
    END IF;
    IF NEW.patrocinante_id != OLD.patrocinante_id THEN
        SET NEW.patrocinante_id = OLD.patrocinante_id;
    END IF;
END $$

USE `spuria`$$


CREATE TRIGGER antes_de_eliminar_patrocinante BEFORE DELETE ON patrocinante
FOR EACH ROW
BEGIN
    DELETE FROM publicidad WHERE patrocinante = OLD.patrocinante_id;
    DELETE FROM cliente WHERE rif = OLD.cliente_p;
END $$

USE `spuria`$$


CREATE TRIGGER despues_de_insertar_patrocinante AFTER INSERT ON patrocinante
FOR EACH ROW
BEGIN
    DECLARE columnas, valores TEXT;
    DECLARE rastreable_p, bobo INT;
    
    SELECT c.rastreable_p
    FROM cliente AS c
    WHERE c.rif = NEW.cliente_p
    INTO rastreable_p;
    
    SELECT 'cliente_p,patrocinante_id' INTO columnas;
    SELECT CONCAT(
        CAST(NEW.cliente_p AS CHAR),',',
        CAST(NEW.patrocinante_id AS CHAR)
    ) INTO valores;
    
    SELECT RegistrarActualizacion(rastreable_p, columnas, valores) INTO bobo;
END $$


DELIMITER ;

DELIMITER $$
USE `spuria`$$


CREATE TRIGGER despues_de_insertar_grado_de_instruccion_objetivo AFTER INSERT ON grado_de_instruccion_objetivo
FOR EACH ROW
BEGIN
    DECLARE rastreable_p, bobo INT;
        
    SELECT publicidad.rastreable_p FROM publicidad
    WHERE publicidad_id = NEW.publicidad_id
    INTO rastreable_p;

    SELECT RegistrarActualizacion(rastreable_p, 'grado_de_instruccion', NEW.grado_de_instruccion) INTO bobo;
END $$

USE `spuria`$$


CREATE TRIGGER antes_de_actualizar_grado_de_instruccion_objetivo BEFORE UPDATE ON grado_de_instruccion_objetivo
FOR EACH ROW
BEGIN
    IF NEW.publicidad_id != OLD.publicidad_id THEN
        SET NEW.publicidad_id = OLD.publicidad_id;
    END IF;
END $$

USE `spuria`$$


CREATE TRIGGER despues_de_actualizar_grado_de_instruccion_objetivo AFTER UPDATE ON grado_de_instruccion_objetivo
FOR EACH ROW
BEGIN
    DECLARE rastreable_p, bobo INT;
    
    SELECT publicidad.rastreable_p FROM publicidad
    WHERE publicidad_id = NEW.publicidad_id
    INTO rastreable_p;
        
    SELECT 
    IF(
        NEW.grado_de_instruccion != OLD.grado_de_instruccion, 
        RegistrarActualizacion(rastreable_p, 'grado_de_instruccion', NEW.grado_de_instruccion), 
        0
    ) INTO bobo;
END $$


DELIMITER ;

DELIMITER $$
USE `spuria`$$


CREATE TRIGGER despues_de_insertar_sexo_objetivo AFTER INSERT ON sexo_objetivo
FOR EACH ROW
BEGIN
    DECLARE rastreable_p, bobo INT;
        
    SELECT publicidad.rastreable_p FROM publicidad
    WHERE publicidad_id = NEW.publicidad_id
    INTO rastreable_p;

    SELECT RegistrarActualizacion(rastreable_p, 'sexo', NEW.sexo) INTO bobo;
END $$

USE `spuria`$$


CREATE TRIGGER antes_de_actualizar_sexo_objetivo BEFORE UPDATE ON sexo_objetivo
FOR EACH ROW
BEGIN
    IF NEW.publicidad_id != OLD.publicidad_id THEN
        SET NEW.publicidad_id = OLD.publicidad_id;
    END IF;
END $$

USE `spuria`$$


CREATE TRIGGER despues_de_actualizar_sexo_objetivo AFTER UPDATE ON sexo_objetivo
FOR EACH ROW
BEGIN
    DECLARE rastreable_p, bobo INT;
    
    SELECT publicidad.rastreable_p FROM publicidad
    WHERE publicidad_id = NEW.publicidad_id
    INTO rastreable_p;
        
    SELECT 
    IF(
        NEW.sexo != OLD.sexo, 
        RegistrarActualizacion(rastreable_p, 'sexo', NEW.sexo), 
        0
    ) INTO bobo;
END $$


DELIMITER ;

DELIMITER $$
USE `spuria`$$


CREATE TRIGGER despues_de_insertar_grupo_de_edad_objetivo AFTER INSERT ON grupo_de_edad_objetivo
FOR EACH ROW
BEGIN
    DECLARE rastreable_p, bobo INT;
        
    SELECT publicidad.rastreable_p FROM publicidad
    WHERE publicidad_id = NEW.publicidad_id
    INTO rastreable_p;
    
    SELECT RegistrarActualizacion(rastreable_p, 'grupo_de_edad', NEW.grupo_de_edad) INTO bobo;
END $$

USE `spuria`$$


CREATE TRIGGER antes_de_actualizar_grupo_de_edad_objetivo BEFORE UPDATE ON grupo_de_edad_objetivo
FOR EACH ROW
BEGIN
    IF NEW.publicidad_id != OLD.publicidad_id THEN
        SET NEW.publicidad_id = OLD.publicidad_id;
    END IF;
END $$

USE `spuria`$$


CREATE TRIGGER despues_de_actualizar_grupo_de_edad_objetivo AFTER UPDATE ON grupo_de_edad_objetivo
FOR EACH ROW
BEGIN
    DECLARE rastreable_p, bobo INT;
    
    SELECT publicidad.rastreable_p FROM publicidad
    WHERE publicidad_id = NEW.publicidad_id
    INTO rastreable_p;
    
    SELECT 
    IF(
        NEW.grupo_de_edad != OLD.grupo_de_edad, 
        RegistrarActualizacion(rastreable_p, 'grupo_de_edad', NEW.grupo_de_edad), 
        0
    ) INTO bobo;
END $$


DELIMITER ;

DELIMITER $$
USE `spuria`$$


CREATE TRIGGER antes_de_actualizar_territorio_objetivo BEFORE UPDATE ON territorio_objetivo
FOR EACH ROW
BEGIN
    IF NEW.publicidad_id != OLD.publicidad_id THEN
        SET NEW.publicidad_id = OLD.publicidad_id;
    END IF;
END $$

USE `spuria`$$


CREATE TRIGGER despues_de_insertar_territorio_objetivo AFTER INSERT ON territorio_objetivo
FOR EACH ROW
BEGIN
    DECLARE rastreable_p, bobo INT;

    SELECT publicidad.rastreable_p FROM publicidad
    WHERE publicidad_id = NEW.publicidad_id
    INTO rastreable_p;

    SELECT RegistrarActualizacion(rastreable_p, 'territorio_id', NEW.territorio_id) INTO bobo;
END $$

USE `spuria`$$


CREATE TRIGGER despues_de_actualizar_territorio_objetivo AFTER UPDATE ON territorio_objetivo
FOR EACH ROW
BEGIN
    DECLARE rastreable_p, bobo INT;
    
    SELECT publicidad.rastreable_p FROM publicidad
    WHERE publicidad_id = NEW.publicidad_id
    INTO rastreable_p;
        
    SELECT 
    IF(
        NEW.territorio_id != OLD.territorio_id, 
        RegistrarActualizacion(rastreable_p, 'territorio_id', NEW.territorio_id), 
        0
    ) INTO bobo;
END $$


DELIMITER ;

DELIMITER $$
USE `spuria`$$


CREATE TRIGGER antes_de_actualizar_consumidor_objetivo BEFORE UPDATE ON consumidor_objetivo
FOR EACH ROW
BEGIN
    IF NEW.publicidad_id != OLD.publicidad_id THEN
        SET NEW.publicidad_id = OLD.publicidad_id;
    END IF;
END $$

USE `spuria`$$


CREATE TRIGGER despues_de_insertar_consumidor_objetivo AFTER INSERT ON consumidor_objetivo
FOR EACH ROW
BEGIN
    DECLARE rastreable_p, bobo INT;

    SELECT publicidad.rastreable_p FROM publicidad
    WHERE publicidad_id = NEW.publicidad_id
    INTO rastreable_p;
    
    SELECT RegistrarActualizacion(rastreable_p, 'consumidor_id', NEW.consumidor_id) INTO bobo;
END $$

USE `spuria`$$


CREATE TRIGGER despues_de_actualizar_consumidor_objetivo AFTER UPDATE ON consumidor_objetivo
FOR EACH ROW
BEGIN
    DECLARE rastreable_p, bobo INT;
    
    SELECT publicidad.rastreable_p FROM publicidad
    WHERE publicidad_id = NEW.publicidad_id
    INTO rastreable_p;
        
    SELECT 
    IF(
        NEW.consumidor_id != OLD.consumidor_id, 
        RegistrarActualizacion(rastreable_p, 'consumidor_id', NEW.consumidor_id), 
        0
    ) INTO bobo;
END $$


DELIMITER ;

DELIMITER $$
USE `spuria`$$


CREATE TRIGGER antes_de_actualizar_croquis BEFORE UPDATE ON croquis
FOR EACH ROW
BEGIN
    IF NEW.rastreable_p != OLD.rastreable_p THEN
        SET NEW.rastreable_p = OLD.rastreable_p;
    END IF;
    IF NEW.croquis_id != OLD.croquis_id THEN
        SET NEW.croquis_id = OLD.croquis_id;
    END IF;
    IF NEW.dibujable != OLD.dibujable THEN
        SET NEW.dibujable = OLD.dibujable;
    END IF;
END $$

USE `spuria`$$


CREATE TRIGGER antes_de_eliminar BEFORE DELETE ON croquis
FOR EACH ROW
BEGIN
    DECLARE bobo INT;

    SELECT RegistrarEliminacion(OLD.rastreable_p) INTO bobo;

    DELETE FROM punto_de_croquis WHERE croquis_id = OLD.croquis_id;
    /* OJO: Rastreable tiene que ser obligatoriamente el ultimo en eliminarse... sino va a haber problemas con el registro */
    DELETE FROM rastreable WHERE rastreable_id = OLD.rastreable_p;
END$$

USE `spuria`$$


CREATE TRIGGER despues_de_actualizar_croquis AFTER UPDATE ON croquis
FOR EACH ROW
BEGIN
    DECLARE bobo INT;
    
    SELECT
    IF(NEW.area != OLD.area, RegistrarActualizacion(NEW.rastreable_p, 'area', NEW.area), 0)
    + IF(NEW.perimetro != OLD.perimetro, RegistrarActualizacion(NEW.rastreable_p, 'perimetro', NEW.perimetro), 0)
    INTO bobo;
END $$

USE `spuria`$$


CREATE TRIGGER despues_de_insertar_croquis AFTER INSERT ON croquis
FOR EACH ROW
BEGIN
    DECLARE columnas, valores TEXT;
    DECLARE bobo INT;
    
    SELECT 'rastreable_p,croquis_id,dibujable' INTO columnas;
    SELECT CONCAT(
        CAST(NEW.rastreable_p AS CHAR),',',
        CAST(NEW.croquis_id AS CHAR),',',
        CAST(NEW.dibujable AS CHAR)
    ) INTO valores;
    
    SELECT RegistrarInsercion(NEW.rastreable_p, columnas, valores) INTO bobo;
END $$


DELIMITER ;

DELIMITER $$
USE `spuria`$$


CREATE TRIGGER antes_de_actualizar_punto BEFORE UPDATE ON punto
FOR EACH ROW
BEGIN
    IF NEW.punto_id != OLD.punto_id THEN
        SET NEW.punto_id = OLD.punto_id;
    END IF;
    IF NEW.latitud != OLD.latitud THEN
        SET NEW.latitud = OLD.latitud;
    END IF;
    IF NEW.longitud!= OLD.longitud THEN
        SET NEW.longitud = OLD.longitud;
    END IF;
END $$

USE `spuria`$$


CREATE TRIGGER antes_de_eliminar_punto BEFORE DELETE ON punto
FOR EACH ROW
BEGIN
    DELETE FROM punto_de_croquis WHERE punto_id = OLD.punto_id;
END$$


DELIMITER ;

DELIMITER $$
USE `spuria`$$


CREATE TRIGGER antes_de_actualizar_punto_de_croquis BEFORE UPDATE ON punto_de_croquis
FOR EACH ROW
BEGIN
    IF NEW.croquis_id != OLD.croquis_id THEN
        SET NEW.croquis_id = OLD.croquis_id;
    END IF;
    IF NEW.punto_id != OLD.punto_id THEN
        SET NEW.punto_id = OLD.punto_id;
    END IF;
END $$

USE `spuria`$$


CREATE TRIGGER despues_de_insertar_punto_de_croquis AFTER INSERT ON punto_de_croquis
FOR EACH ROW
BEGIN
    DECLARE rastreable_p, bobo INT;

    SELECT croquis.rastreable_p FROM croquis
    WHERE croquis_id = NEW.croquis_id
    INTO rastreable_p;
        
    SELECT RegistrarActualizacion(rastreable_p, 'punto_id', NEW.punto_id) INTO bobo;
END $$


DELIMITER ;

DELIMITER $$
USE `spuria`$$


CREATE TRIGGER antes_de_actualizar_dibujable BEFORE UPDATE ON dibujable
FOR EACH ROW
BEGIN
    IF NEW.dibujable_id != OLD.dibujable_id THEN
        SET NEW.dibujable_id = OLD.dibujable_id;
    END IF;
END $$

USE `spuria`$$


CREATE TRIGGER antes_de_eliminar_dibujable BEFORE DELETE ON dibujable
FOR EACH ROW
BEGIN
    DELETE FROM croquis WHERE croquis_id = OLD.dibujable_id;
END $$


DELIMITER ;

DELIMITER $$
USE `spuria`$$


CREATE TRIGGER antes_de_actualizar_factura BEFORE UPDATE ON factura
FOR EACH ROW
BEGIN
    IF NEW.rastreable_p != OLD.rastreable_p THEN
        SET NEW.rastreable_p = OLD.rastreable_p;
    END IF;
    IF NEW.factura_id != OLD.factura_id THEN
        SET NEW.factura_id = OLD.factura_id;
    END IF;
    IF NEW.cliente != OLD.cliente THEN
        SET NEW.cliente = OLD.cliente;
    END IF;
    IF NEW.inicio_de_medicion != OLD.inicio_de_medicion THEN
        SET NEW.inicio_de_medicion = OLD.inicio_de_medicion;
    END IF;
    IF NEW.fin_de_medicion != OLD.fin_de_medicion THEN
        SET NEW.fin_de_medicion = OLD.fin_de_medicion;
    END IF;
END $$

USE `spuria`$$


CREATE TRIGGER antes_de_eliminar_factura BEFORE DELETE ON factura
FOR EACH ROW
BEGIN
    DECLARE bobo INT;
    
    SELECT RegistrarEliminacion(OLD.rastreable_p) INTO bobo;

    DELETE FROM servicio_vendido WHERE factura_id = OLD.factura_id;
    /* OJO: Rastreable tiene que ser obligatoriamente el ultimo en eliminarse... sino va a haber problemas con el registro */
    DELETE FROM rastreable WHERE rastreable_id = OLD.rastreable_p;
END $$

USE `spuria`$$


CREATE TRIGGER despues_de_insertar_factura AFTER INSERT ON factura
FOR EACH ROW
BEGIN
    DECLARE columnas, valores TEXT;
    DECLARE bobo INT;

    SELECT 'rastreable_p,factura_id,cliente,inicio_de_medicion,fin_de_medicion,subtotal,impuestos,total' INTO columnas;
    SELECT CONCAT(
        CAST(NEW.rastreable_p AS CHAR),',',
        CAST(NEW.factura_id AS CHAR),',',
        NEW.cliente,',',
        CAST(NEW.inicio_de_medicion AS CHAR),',',
        CAST(NEW.fin_de_medicion AS CHAR),',',
        CAST(NEW.subtotal AS CHAR),',',
        CAST(NEW.impuestos AS CHAR),',',
        CAST(NEW.total AS CHAR)
    ) INTO valores;
    
    SELECT RegistrarInsercion(NEW.rastreable_p, columnas, valores) INTO bobo;
END $$

USE `spuria`$$


CREATE TRIGGER despues_de_actualizar_factura AFTER UPDATE ON factura
FOR EACH ROW
BEGIN
    DECLARE bobo INT;
    
    SELECT
    IF(NEW.subtotal != OLD.subtotal, RegistrarActualizacion(NEW.rastreable_p, 'subtotal', NEW.subtotal), 0)
    + IF(NEW.impuestos != OLD.impuestos, RegistrarActualizacion(NEW.rastreable_p, 'impuestos', NEW.impuestos), 0)
    + IF(NEW.total != OLD.total, RegistrarActualizacion(NEW.rastreable_p, 'total', NEW.total), 0)
    INTO bobo;
END $$


DELIMITER ;

DELIMITER $$
USE `spuria`$$


CREATE TRIGGER antes_de_actualizar_servicio_vendido BEFORE UPDATE ON servicio_vendido
FOR EACH ROW
BEGIN
    IF NEW.factura_id != OLD.factura_id THEN
        SET NEW.factura_id = OLD.factura_id;
    END IF;
    IF NEW.cobrable_id != OLD.cobrable_id THEN
        SET NEW.cobrable_id = OLD.cobrable_id;
    END IF;
END $$

USE `spuria`$$


CREATE TRIGGER antes_de_insertar_servicio_vendido AFTER INSERT ON servicio_vendido
FOR EACH ROW
BEGIN
    DECLARE columnas, valores TEXT;
    DECLARE rastreable_p, bobo INT;
    
    SELECT 'cobrable_id,acumulado' INTO columnas;
    SELECT CONCAT(
        CAST(NEW.cobrable_id AS CHAR),',',
        CAST(NEW.acumulado AS CHAR)
    ) INTO valores;
    
    SELECT factura.rastreable_p FROM factura
    WHERE factura_id = NEW.factura_id
    INTO rastreable_p;
    
    SELECT RegistrarActualizacion(rastreable_p, columnas, valores) INTO bobo;
END $$

USE `spuria`$$


CREATE TRIGGER despues_de_actualizar_servicio_vendido AFTER UPDATE ON servicio_vendido
FOR EACH ROW
BEGIN
    DECLARE rastreable_p, bobo INT;

    SELECT factura.rastreable_p FROM factura
    WHERE factura_id = NEW.factura_id
    INTO rastreable_p;
    
    SELECT
    IF(
        NEW.acumulado != OLD.acumulado,
        RegistrarActualizacion(rastreable_p, 'acumulado', NEW.acumulado),
        0
    ) INTO bobo;
END $$


DELIMITER ;

DELIMITER $$
USE `spuria`$$


CREATE TRIGGER antes_de_actualizar_cobrable BEFORE UPDATE ON cobrable
FOR EACH ROW
BEGIN
    IF NEW.cobrable_id != OLD.cobrable_id THEN
        SET NEW.cobrable_id = OLD.cobrable_id;
    END IF;
END $$

USE `spuria`$$


CREATE TRIGGER antes_de_eliminar_cobrable BEFORE DELETE ON cobrable
FOR EACH ROW
BEGIN
    DELETE FROM servicio_vendido WHERE cobrable_id = OLD.cobrable_id;
END $$


DELIMITER ;

DELIMITER $$
USE `spuria`$$


CREATE TRIGGER despues_de_insertar_administrador AFTER INSERT ON administrador
FOR EACH ROW
BEGIN
    DECLARE columnas, valores TEXT;
    DECLARE bobo, rastreable_p INT;

    SELECT usuario.rastreable_p FROM usuario
    WHERE usuario_id = NEW.usuario_p
    INTO rastreable_p;
    
    SELECT 'usuario_p,administrador_id,privilegios' INTO columnas;
    SELECT CONCAT(
        CAST(NEW.usuario_p AS CHAR),',',
        CAST(NEW.administrador_id AS CHAR),',',
        NEW.privilegios
    ) INTO valores;
    
    SELECT RegistrarActualizacion(rastreable_p, columnas, valores) INTO bobo;
END $$

USE `spuria`$$


CREATE TRIGGER antes_de_actualizar_administrador BEFORE UPDATE ON administrador
FOR EACH ROW
BEGIN
    IF NEW.usuario_p != OLD.usuario_p THEN
        SET NEW.usuario_p = OLD.usuario_p;
    END IF;
    IF NEW.administrador_id != OLD.administrador_id THEN
        SET NEW.administrador_id = OLD.administrador_id;
    END IF;
END $$

USE `spuria`$$


CREATE TRIGGER antes_de_eliminar_administrador BEFORE DELETE ON administrador
FOR EACH ROW
BEGIN
/*
    DECLARE bobo, rastreable_p INT;

    SELECT usuario.rastreable_p FROM usuario 
    WHERE usuario_id = OLD.usuario_p
    INTO rastreable_p;
    
    SELECT RegistrarEliminacion(rastreable_p, CONCAT('administrador: ', OLD.nombre, ' ', OLD.apellido)) INTO bobo;
*/       
    DELETE FROM usuario WHERE usuario_id = OLD.usuario_p;
END $$

USE `spuria`$$


CREATE TRIGGER despues_de_actualizar_administrador AFTER UPDATE ON administrador
FOR EACH ROW
BEGIN
    DECLARE bobo, rastreable_p INT;

    SELECT usuario.rastreable_p FROM usuario 
    WHERE usuario_id = NEW.usuario_p
    INTO rastreable_p;

    SELECT
    IF(
        NEW.privilegios != OLD.privilegios,
        RegistrarActualizacion(rastreable_p, 'privilegios', NEW.privilegios),
        0
    ) INTO bobo;
END $$


DELIMITER ;

DELIMITER $$
USE `spuria`$$


CREATE TRIGGER antes_de_actualizar_resultado_de_busqueda BEFORE UPDATE ON resultado_de_busqueda
FOR EACH ROW
BEGIN
    IF NEW.busqueda_id != OLD.busqueda_id THEN
        SET NEW.busqueda_id = OLD.busqueda_id;
    END IF;
    IF NEW.buscable_id != OLD.buscable_id THEN
        SET NEW.buscable_id = OLD.buscable_id;
    END IF;
END $$

USE `spuria`$$


CREATE TRIGGER despues_de_insertar_resultado_de_busqueda AFTER INSERT ON resultado_de_busqueda
FOR EACH ROW
BEGIN
    DECLARE columnas, valores TEXT;
    DECLARE rastreable_p, bobo INT;
    
    SELECT 'busqueda_id,buscable_id,visitado,relevancia' INTO columnas;
    SELECT CONCAT(
        CAST(NEW.busqueda_id AS CHAR),',',
        CAST(NEW.buscable_id AS CHAR),',',
        CAST(NEW.visitado AS CHAR),',',
        CAST(NEW.relevancia AS CHAR)
    ) INTO valores;
    
    SELECT busqueda.rastreable_p FROM busqueda
    WHERE busqueda_id = NEW.busqueda_id
    INTO rastreable_p;
    
    SELECT RegistrarActualizacion(rastreable_p, columnas, valores) INTO bobo;
END $$

USE `spuria`$$


CREATE TRIGGER despues_de_actualizar_resultado_de_busqueda AFTER UPDATE ON resultado_de_busqueda
FOR EACH ROW
BEGIN
    DECLARE rastreable_p, bobo INT;
    
    SELECT busqueda.rastreable_p FROM busqueda
    WHERE busqueda_id = NEW.busqueda_id
    INTO rastreable_p;
    
    SELECT
    IF(NEW.visitado != OLD.visitado, RegistrarActualizacion(rastreable_p, 'visitado', NEW.visitado), 0)
    + IF(NEW.relevancia != OLD.relevancia, RegistrarActualizacion(rastreable_p, 'relevancia', NEW.relevancia), 0)
    INTO bobo;
END $$


DELIMITER ;

DELIMITER $$
USE `spuria`$$


CREATE TRIGGER antes_de_actualizar_estadisticas_temporales BEFORE UPDATE ON estadisticas_temporales
FOR EACH ROW
BEGIN
    IF NEW.estadisticas_id != OLD.estadisticas_id THEN
        SET NEW.estadisticas_id = OLD.estadisticas_id;
    END IF;
    IF NEW.fecha_inicio != OLD.fecha_inicio THEN
        SET NEW.fecha_inicio = OLD.fecha_inicio;
    END IF;
END $$

USE `spuria`$$


CREATE TRIGGER despues_de_insertar_estadisticas_temporales AFTER INSERT ON estadisticas_temporales
FOR EACH ROW
BEGIN
    DECLARE columnas, valores TEXT;
    DECLARE rastreable_p, bobo INT;
    
    SELECT 'fecha_inicio,contador,ranking,indice' INTO columnas;
    SELECT CONCAT(
        CAST(NEW.fecha_inicio AS CHAR),',',
        CAST(NEW.contador AS CHAR),',',
        CAST(NEW.ranking AS CHAR),',',
        CAST(NEW.indice AS CHAR)
    ) INTO valores;
    
    SELECT estadisticas.rastreable_p FROM estadisticas
    WHERE estadisticas_id = NEW.estadisticas_id
    INTO rastreable_p;
    
    SELECT RegistrarActualizacion(rastreable_p, columnas, valores) INTO bobo;
END $$

USE `spuria`$$


CREATE TRIGGER despues_de_actualizar_estadisticas_temporales AFTER UPDATE ON estadisticas_temporales
FOR EACH ROW
BEGIN
    DECLARE rastreable_p, bobo INT;
    
    SELECT estadisticas.rastreable_p FROM estadisticas
    WHERE estadisticas_id = NEW.estadisticas_id
    INTO rastreable_p;
     
    SELECT
    IF(NEW.fecha_fin != OLD.fecha_fin, RegistrarActualizacion(rastreable_p, 'fecha_fin', NEW.fecha_fin), 0)
    + IF(NEW.contador != OLD.contador, RegistrarActualizacion(rastreable_p, 'contador', NEW.contador), 0)
    + IF(NEW.ranking != OLD.ranking, RegistrarActualizacion(rastreable_p, 'ranking', NEW.ranking), 0)
    + IF(NEW.indice != OLD.indice, RegistrarActualizacion(rastreable_p, 'indice', NEW.indice), 0)
    INTO bobo;
END $$


DELIMITER ;

DELIMITER $$
USE `spuria`$$


CREATE TRIGGER antes_de_actualizar_precio_cantidad BEFORE UPDATE ON precio_cantidad
FOR EACH ROW
BEGIN
    IF NEW.tienda_id != OLD.tienda_id THEN
        SET NEW.tienda_id = OLD.tienda_id;
    END IF;
    IF NEW.codigo != OLD.codigo THEN
        SET NEW.codigo = OLD.codigo;
    END IF;
    IF NEW.fecha_inicio != OLD.fecha_inicio THEN
        SET NEW.fecha_inicio = OLD.fecha_inicio;
    END IF;
END $$

USE `spuria`$$


CREATE TRIGGER despues_de_insertar_precio_cantidad AFTER INSERT ON precio_cantidad
FOR EACH ROW
BEGIN
    DECLARE columnas, valores TEXT;
    DECLARE rastreable_p, bobo INT;
    
    SELECT 'fecha_inicio,precio,cantidad' INTO columnas;
    SELECT CONCAT(
        CAST(NEW.fecha_inicio AS CHAR),',',
        CAST(NEW.precio AS CHAR),',',
        CAST(NEW.cantidad AS CHAR)
    ) INTO valores;
    
    SELECT inventario.rastreable_p FROM inventario
    WHERE tienda_id = NEW.tienda_id AND codigo = NEW.codigo
    INTO rastreable_p;
    
    SELECT RegistrarActualizacion(rastreable_p, columnas, valores) INTO bobo;
END $$

USE `spuria`$$


CREATE TRIGGER despues_de_actualizar_precio_cantidad AFTER UPDATE ON precio_cantidad
FOR EACH ROW
BEGIN
    DECLARE rastreable_p, bobo INT;
    
    SELECT inventario.rastreable_p FROM inventario
    WHERE tienda_id = NEW.tienda_id AND codigo = NEW.codigo
    INTO rastreable_p;
        
    SELECT 
    IF(NEW.fecha_fin != OLD.fecha_fin, RegistrarActualizacion(rastreable_p, 'fecha_fin', NEW.fecha_fin), 0)
    + IF(NEW.precio != OLD.precio, RegistrarActualizacion(rastreable_p, 'precio', NEW.precio), 0)
    + IF(NEW.cantidad != OLD.cantidad, RegistrarActualizacion(rastreable_p, 'cantidad', NEW.cantidad), 0)
    INTO bobo;    
END $$


DELIMITER ;

DELIMITER $$
USE `spuria`$$


CREATE TRIGGER antes_de_actualizar_tiendas_consumidores BEFORE UPDATE ON tiendas_consumidores
FOR EACH ROW
BEGIN
    IF NEW.territorio_id != OLD.territorio_id THEN
        SET NEW.territorio_id = OLD.territorio_id;
    END IF;
    IF NEW.fecha_inicio != OLD.fecha_inicio THEN
        SET NEW.fecha_inicio = OLD.fecha_inicio;
    END IF;
END $$

USE `spuria`$$


CREATE TRIGGER despues_de_insertar_tiendas_consumidores AFTER INSERT ON tiendas_consumidores
FOR EACH ROW
BEGIN
    DECLARE columnas, valores TEXT;
    DECLARE rastreable_p, bobo INT;
    
    SELECT 'fecha_inicio,numero_de_tiendas,numero_de_consumidores' INTO columnas;
    SELECT CONCAT(
        CAST(NEW.fecha_inicio AS CHAR),',',
        CAST(NEW.numero_de_tiendas AS CHAR),',',
        CAST(NEW.numero_de_consumidores AS CHAR)
    ) INTO valores;
    
    SELECT territorio.rastreable_p FROM territorio
    WHERE territorio_id = NEW.territorio_id
    INTO rastreable_p;
    
    SELECT RegistrarActualizacion(rastreable_p, columnas, valores) INTO bobo;
END $$

USE `spuria`$$


CREATE TRIGGER despues_de_actualizar_tiendas_consumidores AFTER UPDATE ON tiendas_consumidores
FOR EACH ROW
BEGIN
    DECLARE rastreable_p, bobo INT;
    
    SELECT territorio.rastreable_p FROM territorio
    WHERE territorio_id = NEW.territorio_id
    INTO rastreable_p;
        
    SELECT
    IF(NEW.fecha_fin != OLD.fecha_fin, RegistrarActualizacion(rastreable_p, 'fecha_fin', NEW.fecha_fin), 0)
    + IF(NEW.numero_de_tiendas != OLD.numero_de_tiendas, RegistrarActualizacion(rastreable_p, 'numero_de_tiendas', NEW.numero_de_tiendas), 0)
    + IF(NEW.numero_de_consumidores != OLD.numero_de_consumidores, RegistrarActualizacion(rastreable_p, 'numero_de_consumidores', NEW.numero_de_consumidores), 0)
    INTO bobo;
END $$


DELIMITER ;

DELIMITER $$
USE `spuria`$$


CREATE TRIGGER antes_de_actualizar_region BEFORE UPDATE ON region
FOR EACH ROW
BEGIN
    IF NEW.region_id != OLD.region_id THEN
        SET NEW.region_id = OLD.region_id;
    END IF;
END $$

USE `spuria`$$


CREATE TRIGGER antes_de_eliminar_region BEFORE DELETE ON region
FOR EACH ROW
BEGIN
    DELETE FROM region_territorio WHERE region_id = OLD.region_id;
END $$


DELIMITER ;

DELIMITER $$
USE `spuria`$$


CREATE TRIGGER antes_de_insertar_region_territorio AFTER INSERT ON region_territorio
FOR EACH ROW
BEGIN
    DECLARE rastreable_p, bobo INT;
    
    SELECT territorio.rastreable_p FROM territorio
    WHERE territorio_id = NEW.territorio_id
    INTO rastreable_p;
    
    SELECT RegistrarActualizacion(rastreable_p, 'region', NEW.region_id) INTO bobo;
END $$

USE `spuria`$$


CREATE TRIGGER antes_de_actualizar_region_territorio BEFORE UPDATE ON region_territorio
FOR EACH ROW
BEGIN
    IF NEW.territorio_id != OLD.territorio_id THEN
        SET NEW.territorio_id = OLD.territorio_id;
    END IF;
    IF NEW.region_id != OLD.region_id THEN
        SET NEW.region_id = OLD.region_id;
    END IF;
END $$


DELIMITER ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
