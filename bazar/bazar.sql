-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema bazar
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema bazar
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bazar` DEFAULT CHARACTER SET utf8 ;
USE `bazar` ;

-- -----------------------------------------------------
-- Table `bazar`.`rol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bazar`.`rol` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bazar`.`empleados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bazar`.`empleados` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `rolId` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `dni` INT NOT NULL,
  `sueldo` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `FK_empleados_rol_idx` (`rolId` ASC) VISIBLE,
  CONSTRAINT `FK_empleados_rol`
    FOREIGN KEY (`rolId`)
    REFERENCES `bazar`.`rol` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bazar`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bazar`.`categoria` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bazar`.`articulos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bazar`.`articulos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `precio` INT NOT NULL,
  `descripcion` VARCHAR(100) NOT NULL,
  `stock` INT NOT NULL,
  `profesional` TINYTEXT NOT NULL,
  `categoriaId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `FK_articulos_area_idx` (`categoriaId` ASC) VISIBLE,
  CONSTRAINT `FK_articulos_categoria`
    FOREIGN KEY (`categoriaId`)
    REFERENCES `bazar`.`categoria` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bazar`.`ventas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bazar`.`ventas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fecha_compra` DATE NOT NULL,
  `empleadoId` INT NOT NULL,
  `articuloId` INT NOT NULL,
  `medio_de_pago` VARCHAR(45) NOT NULL,
  `total` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `FK_ventas_empleados_idx` (`empleadoId` ASC) VISIBLE,
  INDEX `FK_ventas_articulos_idx` (`articuloId` ASC) VISIBLE,
  CONSTRAINT `FK_ventas_empleados`
    FOREIGN KEY (`empleadoId`)
    REFERENCES `bazar`.`empleados` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_ventas_articulos`
    FOREIGN KEY (`articuloId`)
    REFERENCES `bazar`.`articulos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
