-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema M06C01
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema M06C01
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `M06C01` DEFAULT CHARACTER SET utf8 ;
USE `M06C01` ;

-- -----------------------------------------------------
-- Table `M06C01`.`categorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `M06C01`.`categorias` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `M06C01`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `M06C01`.`usuarios` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `category_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `FK_usuarios_categorias_idx` (`category_id` ASC) VISIBLE,
  CONSTRAINT `FK_usuarios_categorias`
    FOREIGN KEY (`category_id`)
    REFERENCES `M06C01`.`categorias` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `M06C01`.`cursos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `M06C01`.`cursos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(45) NOT NULL,
  `descripcion` TEXT NOT NULL,
  `imagen` VARCHAR(45) NOT NULL,
  `fecha_inicio` DATE NOT NULL,
  `fecha_finalizacion` DATE NOT NULL,
  `cupo` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `M06C01`.`unidades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `M06C01`.`unidades` (
  `id` INT NOT NULL,
  `titulo` VARCHAR(45) NOT NULL,
  `descripcion` TEXT NOT NULL,
  `fecha_inicio` VARCHAR(45) NULL,
  `cursoId` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `FK_unidades_cursos_idx` (`cursoId` ASC) VISIBLE,
  CONSTRAINT `FK_unidades_cursos`
    FOREIGN KEY (`cursoId`)
    REFERENCES `M06C01`.`cursos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `M06C01`.`inscripciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `M06C01`.`inscripciones` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `usuarioId` INT NOT NULL,
  `cursoId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `FK_cursos_usuarios_idx` (`cursoId` ASC) VISIBLE,
  INDEX `FK_usuarios_cursos_idx` (`usuarioId` ASC) VISIBLE,
  CONSTRAINT `FK_usuarios_cursos`
    FOREIGN KEY (`usuarioId`)
    REFERENCES `M06C01`.`usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_cursos_usuarios`
    FOREIGN KEY (`cursoId`)
    REFERENCES `M06C01`.`cursos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `M06C01`.`clases`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `M06C01`.`clases` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(45) NOT NULL,
  `descripcion` TEXT NOT NULL,
  `fecha_inicio` DATE NOT NULL,
  `visible` TINYTEXT NOT NULL,
  `unidadId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `FK_clases_unidades_idx` (`unidadId` ASC) VISIBLE,
  CONSTRAINT `FK_clases_unidades`
    FOREIGN KEY (`unidadId`)
    REFERENCES `M06C01`.`unidades` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `M06C01`.`tipos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `M06C01`.`tipos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `M06C01`.`bloques`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `M06C01`.`bloques` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(45) NOT NULL,
  `visible` TINYTEXT NOT NULL,
  `tipoId` INT NOT NULL,
  `claseId` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `FK_bloques_clases_idx` (`claseId` ASC) VISIBLE,
  INDEX `FK_bloques_tipos_idx` (`tipoId` ASC) VISIBLE,
  CONSTRAINT `FK_bloques_clases`
    FOREIGN KEY (`claseId`)
    REFERENCES `M06C01`.`clases` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_bloques_tipos`
    FOREIGN KEY (`tipoId`)
    REFERENCES `M06C01`.`tipos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
