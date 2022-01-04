-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema bdAlerta
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema bdAlerta
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bdAlerta` DEFAULT CHARACTER SET utf8 ;
USE `bdAlerta` ;

-- -----------------------------------------------------
-- Table `bdAlerta`.`Victima`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdAlerta`.`Victima` (
  `idVictima` INT NOT NULL AUTO_INCREMENT,
  `dni` CHAR(8) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido_paterno` VARCHAR(45) NOT NULL,
  `apellido_materno` VARCHAR(45) NOT NULL,
  `fecha_nacimiento` DATE NOT NULL,
  `telefono` VARCHAR(11) NOT NULL,
  PRIMARY KEY (`idVictima`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdAlerta`.`Ubicacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdAlerta`.`Ubicacion` (
  `idUbicacion` INT NOT NULL AUTO_INCREMENT,
  `direccion` VARCHAR(100) NOT NULL,
  `latitud` DECIMAL(10,8) NOT NULL,
  `longitud` DECIMAL(11,8) NOT NULL,
  PRIMARY KEY (`idUbicacion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdAlerta`.`Alerta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdAlerta`.`Alerta` (
  `idAlerta` INT NOT NULL AUTO_INCREMENT,
  `estado` ENUM('ENVIADO', 'PROCESO', 'ATENDIDO') NOT NULL,
  `fecha_envio` DATETIME NOT NULL,
  `fecha_atencion` DATETIME NOT NULL,
  `idVictima` INT NOT NULL,
  `idUbicacion` INT NOT NULL,
  PRIMARY KEY (`idAlerta`),
  INDEX `fk_Alerta_Victima_idx` (`idVictima` ASC),
  INDEX `fk_Alerta_Ubicacion1_idx` (`idUbicacion` ASC),
  CONSTRAINT `fk_Alerta_Victima`
    FOREIGN KEY (`idVictima`)
    REFERENCES `bdAlerta`.`Victima` (`idVictima`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Alerta_Ubicacion1`
    FOREIGN KEY (`idUbicacion`)
    REFERENCES `bdAlerta`.`Ubicacion` (`idUbicacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdAlerta`.`Institucion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdAlerta`.`Institucion` (
  `idInstitucion` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `dirección` VARCHAR(100) NOT NULL,
  `ciudad` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`idInstitucion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdAlerta`.`Monitoreo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdAlerta`.`Monitoreo` (
  `idMonitoreo` INT NOT NULL AUTO_INCREMENT,
  `usuario` VARCHAR(45) NOT NULL,
  `contrasena` VARCHAR(45) NOT NULL,
  `idInstitucion` INT NOT NULL,
  PRIMARY KEY (`idMonitoreo`),
  INDEX `fk_Monitoreo_Institucion1_idx` (`idInstitucion` ASC),
  CONSTRAINT `fk_Monitoreo_Institucion1`
    FOREIGN KEY (`idInstitucion`)
    REFERENCES `bdAlerta`.`Institucion` (`idInstitucion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdAlerta`.`Institucion_Alerta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdAlerta`.`Institucion_Alerta` (
  `idAlerta` INT NOT NULL,
  `idInstitucion` INT NOT NULL,
  INDEX `fk_Monitoreo_Alerta_Alerta1_idx` (`idAlerta` ASC),
  INDEX `fk_Monitoreo_Alerta_Institucion1_idx` (`idInstitucion` ASC),
  CONSTRAINT `fk_Monitoreo_Alerta_Alerta1`
    FOREIGN KEY (`idAlerta`)
    REFERENCES `bdAlerta`.`Alerta` (`idAlerta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Monitoreo_Alerta_Institucion1`
    FOREIGN KEY (`idInstitucion`)
    REFERENCES `bdAlerta`.`Institucion` (`idInstitucion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
