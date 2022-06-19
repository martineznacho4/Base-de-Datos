-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`sucursales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`sucursales` (
  `id` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`clientes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `num_pasaporte` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`vuelos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`vuelos` (
  `id` INT NOT NULL,
  `numero_vuelo` INT NULL,
  `fecha_partida` DATETIME NULL,
  `fecha_estimada_llegada` DATETIME NULL,
  `plaza_turista` INT NULL,
  `plaza_primera` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tipo_hospedaje`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tipo_hospedaje` (
  `id` INT NOT NULL,
  `descripcion` VARCHAR(50) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`hoteles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`hoteles` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `cant_habitaciones` VARCHAR(45) NULL,
  `tipo_hospedaje_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_hoteles_tipo_hospedaje1_idx` (`tipo_hospedaje_id` ASC) VISIBLE,
  CONSTRAINT `fk_hoteles_tipo_hospedaje1`
    FOREIGN KEY (`tipo_hospedaje_id`)
    REFERENCES `mydb`.`tipo_hospedaje` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`metodo_pago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`metodo_pago` (
  `id` INT NOT NULL,
  `metodo_pagocol` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`direccion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`direccion` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `direccion` VARCHAR(45) NOT NULL,
  `pais` VARCHAR(45) NOT NULL,
  `ciudad` VARCHAR(45) NOT NULL,
  `sucursales_id` INT NOT NULL,
  `clientes_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_direccion_sucursales1_idx` (`sucursales_id` ASC) VISIBLE,
  INDEX `fk_direccion_clientes1_idx` (`clientes_id` ASC) VISIBLE,
  CONSTRAINT `fk_direccion_sucursales1`
    FOREIGN KEY (`sucursales_id`)
    REFERENCES `mydb`.`sucursales` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_direccion_clientes1`
    FOREIGN KEY (`clientes_id`)
    REFERENCES `mydb`.`clientes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`telefono`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`telefono` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `numero` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  `sucursales_id` INT NOT NULL,
  `clientes_id` INT NOT NULL,
  `hoteles_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_telefono_sucursales1_idx` (`sucursales_id` ASC) VISIBLE,
  INDEX `fk_telefono_clientes1_idx` (`clientes_id` ASC) VISIBLE,
  INDEX `fk_telefono_hoteles1_idx` (`hoteles_id` ASC) VISIBLE,
  CONSTRAINT `fk_telefono_sucursales1`
    FOREIGN KEY (`sucursales_id`)
    REFERENCES `mydb`.`sucursales` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_telefono_clientes1`
    FOREIGN KEY (`clientes_id`)
    REFERENCES `mydb`.`clientes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_telefono_hoteles1`
    FOREIGN KEY (`hoteles_id`)
    REFERENCES `mydb`.`hoteles` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`reservas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`reservas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cod_reserva` VARCHAR(50) NOT NULL,
  `fecha_hora` DATETIME NOT NULL,
  `sucursales_id` INT NOT NULL,
  `clientes_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_reservas_sucursales1_idx` (`sucursales_id` ASC) VISIBLE,
  INDEX `fk_reservas_clientes1_idx` (`clientes_id` ASC) VISIBLE,
  CONSTRAINT `fk_reservas_sucursales1`
    FOREIGN KEY (`sucursales_id`)
    REFERENCES `mydb`.`sucursales` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reservas_clientes1`
    FOREIGN KEY (`clientes_id`)
    REFERENCES `mydb`.`clientes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`reservas_por_vuelos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`reservas_por_vuelos` (
  `reservas_id` INT NOT NULL,
  `vuelos_id` INT NOT NULL,
  `asiento` CHAR(3) NOT NULL,
  `categoria_vuelo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`reservas_id`, `vuelos_id`),
  INDEX `fk_reservas_has_vuelos_vuelos1_idx` (`vuelos_id` ASC) VISIBLE,
  INDEX `fk_reservas_has_vuelos_reservas1_idx` (`reservas_id` ASC) VISIBLE,
  CONSTRAINT `fk_reservas_has_vuelos_reservas1`
    FOREIGN KEY (`reservas_id`)
    REFERENCES `mydb`.`reservas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reservas_has_vuelos_vuelos1`
    FOREIGN KEY (`vuelos_id`)
    REFERENCES `mydb`.`vuelos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`destinos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`destinos` (
  `id` INT NOT NULL,
  `origen` VARCHAR(45) NULL,
  `destino` VARCHAR(45) NULL,
  `vuelos_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_destinos_vuelos1_idx` (`vuelos_id` ASC) VISIBLE,
  CONSTRAINT `fk_destinos_vuelos1`
    FOREIGN KEY (`vuelos_id`)
    REFERENCES `mydb`.`vuelos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`reservas_por_hoteles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`reservas_por_hoteles` (
  `reservas_id` INT NOT NULL,
  `hoteles_id` INT NOT NULL,
  `nro_habitacion` INT NOT NULL,
  `check_in` DATETIME NOT NULL,
  `check_out` DATETIME NOT NULL,
  PRIMARY KEY (`reservas_id`, `hoteles_id`),
  INDEX `fk_reservas_has_hoteles_hoteles1_idx` (`hoteles_id` ASC) VISIBLE,
  INDEX `fk_reservas_has_hoteles_reservas1_idx` (`reservas_id` ASC) VISIBLE,
  CONSTRAINT `fk_reservas_has_hoteles_reservas1`
    FOREIGN KEY (`reservas_id`)
    REFERENCES `mydb`.`reservas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reservas_has_hoteles_hoteles1`
    FOREIGN KEY (`hoteles_id`)
    REFERENCES `mydb`.`hoteles` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`facturacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`facturacion` (
  `id` INT NOT NULL,
  `tipo` VARCHAR(50) NULL,
  `metodo_pago_id` INT NOT NULL,
  `reservas_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_facturacion_metodo_pago1_idx` (`metodo_pago_id` ASC) VISIBLE,
  INDEX `fk_facturacion_reservas1_idx` (`reservas_id` ASC) VISIBLE,
  CONSTRAINT `fk_facturacion_metodo_pago1`
    FOREIGN KEY (`metodo_pago_id`)
    REFERENCES `mydb`.`metodo_pago` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_facturacion_reservas1`
    FOREIGN KEY (`reservas_id`)
    REFERENCES `mydb`.`reservas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
