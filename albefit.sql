-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema AlbeFit
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `AlbeFit` ;

-- -----------------------------------------------------
-- Schema AlbeFit
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `AlbeFit` DEFAULT CHARACTER SET utf8 ;
USE `AlbeFit` ;

-- -----------------------------------------------------
-- Table `AlbeFit`.`Usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AlbeFit`.`Usuario` ;

CREATE TABLE IF NOT EXISTS `AlbeFit`.`Usuario` (
  `idusuario` INT NOT NULL AUTO_INCREMENT,
  `nombreusuario` VARCHAR(45) NOT NULL,
  `correo` VARCHAR(45) NOT NULL,
  `contraseña` VARCHAR(64) NOT NULL,
  `fechacreacion` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idusuario`),
  UNIQUE INDEX `nombreusuario_UNIQUE` (`nombreusuario` ASC) VISIBLE,
  UNIQUE INDEX `correo_UNIQUE` (`correo` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AlbeFit`.`Receta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AlbeFit`.`Receta` ;

CREATE TABLE IF NOT EXISTS `AlbeFit`.`Receta` (
  `idreceta` INT NOT NULL AUTO_INCREMENT,
  `usuario` INT NOT NULL,
  `titulo` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(120) NOT NULL,
  `tiempo` INT NOT NULL,
  `porciones` INT NOT NULL,
  `dificultad` ENUM('fácil', 'media', 'difícil') NOT NULL,
  `fechacreacion` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `valoracion_media` INT NULL,
  PRIMARY KEY (`idreceta`),
  INDEX `fk_Receta_Usuario_idx` (`usuario` ASC) VISIBLE,
  CONSTRAINT `fk_Receta_Usuario`
    FOREIGN KEY (`usuario`)
    REFERENCES `AlbeFit`.`Usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AlbeFit`.`Ingrediente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AlbeFit`.`Ingrediente` ;

CREATE TABLE IF NOT EXISTS `AlbeFit`.`Ingrediente` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `receta` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `cantidad` VARCHAR(45) NOT NULL,
  `valorEnergetico` INT NULL,
  `grasasTotales` INT NULL,
  `grasasSaturadas` INT NULL,
  `hidratos` INT NULL,
  `azucares` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Ingrediente_Receta1_idx` (`receta` ASC) VISIBLE,
  CONSTRAINT `fk_Ingrediente_Receta1`
    FOREIGN KEY (`receta`)
    REFERENCES `AlbeFit`.`Receta` (`idreceta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AlbeFit`.`Macros`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AlbeFit`.`Macros` ;

CREATE TABLE IF NOT EXISTS `AlbeFit`.`Macros` (
  `idmacros` INT NOT NULL,
  `receta` INT NOT NULL,
  `valorEnergeticoTotal` INT NOT NULL,
  `grasasTotales` INT NULL,
  `grasasSaturadas` INT NULL,
  `hidratos` INT NULL,
  `azucares` VARCHAR(45) NULL,
  PRIMARY KEY (`idmacros`),
  INDEX `fk_Macros_Receta1_idx` (`receta` ASC) VISIBLE,
  CONSTRAINT `fk_Macros_Receta1`
    FOREIGN KEY (`receta`)
    REFERENCES `AlbeFit`.`Receta` (`idreceta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AlbeFit`.`Favorita`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AlbeFit`.`Favorita` ;

CREATE TABLE IF NOT EXISTS `AlbeFit`.`Favorita` (
  `idusuario` INT NOT NULL,
  `idreceta` INT NOT NULL,
  PRIMARY KEY (`idusuario`, `idreceta`),
  INDEX `fk_Usuario_has_Receta_Receta1_idx` (`idreceta` ASC) VISIBLE,
  INDEX `fk_Usuario_has_Receta_Usuario1_idx` (`idusuario` ASC) VISIBLE,
  CONSTRAINT `fk_Usuario_has_Receta_Usuario1`
    FOREIGN KEY (`idusuario`)
    REFERENCES `AlbeFit`.`Usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuario_has_Receta_Receta1`
    FOREIGN KEY (`idreceta`)
    REFERENCES `AlbeFit`.`Receta` (`idreceta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
