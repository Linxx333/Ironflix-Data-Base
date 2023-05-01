-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema ironflix
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ironflix
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ironflix` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `ironflix` ;

-- -----------------------------------------------------
-- Table `ironflix`.`actor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ironflix`.`actor` (
  `actor_id` INT NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `last_update` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`actor_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `ironflix`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ironflix`.`category` (
  `category_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `last_update` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`category_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `ironflix`.`film`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ironflix`.`film` (
  `film_id` INT NOT NULL,
  `title` VARCHAR(100) NOT NULL,
  `description` VARCHAR(300) NULL DEFAULT NULL,
  `release_year` YEAR NULL DEFAULT NULL,
  `rental_duration` TINYINT NOT NULL,
  `price` FLOAT NOT NULL,
  `length` INT NULL DEFAULT NULL,
  `replacement_cost` FLOAT NOT NULL,
  `rating` VARCHAR(15) NOT NULL,
  `special_features` VARCHAR(100) NULL DEFAULT NULL,
  `last_update` DATETIME NULL DEFAULT NULL,
  `category_id` INT NULL,
  PRIMARY KEY (`film_id`),
  UNIQUE INDEX `title_UNIQUE` (`title` ASC) VISIBLE,
  UNIQUE INDEX `description_UNIQUE` (`description` ASC) VISIBLE,
  INDEX `fk_film_category1_idx` (`category_id` ASC) VISIBLE,
  CONSTRAINT `fk_film_category1`
    FOREIGN KEY (`category_id`)
    REFERENCES `ironflix`.`category` (`category_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `ironflix`.`actor_has_film`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ironflix`.`actor_has_film` (
  `actor_id` INT NOT NULL,
  `film_id` INT NOT NULL,
  PRIMARY KEY (`actor_id`, `film_id`),
  INDEX `fk_actor_has_film_film1_idx` (`film_id` ASC) VISIBLE,
  INDEX `fk_actor_has_film_actor1_idx` (`actor_id` ASC) VISIBLE,
  CONSTRAINT `fk_actor_has_film_actor1`
    FOREIGN KEY (`actor_id`)
    REFERENCES `ironflix`.`actor` (`actor_id`),
  CONSTRAINT `fk_actor_has_film_film1`
    FOREIGN KEY (`film_id`)
    REFERENCES `ironflix`.`film` (`film_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `ironflix`.`clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ironflix`.`clients` (
  `customer_id` INT NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `DNI` VARCHAR(9) NOT NULL,
  `address` VARCHAR(150) NULL DEFAULT NULL,
  `last_update` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE INDEX `DNI_UNIQUE` (`DNI` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `ironflix`.`language`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ironflix`.`language` (
  `language_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `last_update` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`language_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `ironflix`.`stores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ironflix`.`stores` (
  `store_id` INT NOT NULL,
  `address` VARCHAR(150) NOT NULL,
  `mall` VARCHAR(100) NULL DEFAULT NULL,
  `city` VARCHAR(45) NULL,
  `last_update` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`store_id`),
  UNIQUE INDEX `dirección_UNIQUE` (`address` ASC) VISIBLE,
  UNIQUE INDEX `mall_UNIQUE` (`mall` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `ironflix`.`inventory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ironflix`.`inventory` (
  `inventory_id` INT NOT NULL,
  `film_id` INT NOT NULL,
  `store_id` INT NOT NULL,
  `language_id` INT NOT NULL,
  `last_update` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`inventory_id`, `film_id`, `store_id`, `language_id`),
  INDEX `fk_inventory_stores1_idx` (`store_id` ASC) VISIBLE,
  INDEX `fk_inventory_film1_idx` (`film_id` ASC) VISIBLE,
  INDEX `fk_inventory_language1_idx` (`language_id` ASC) VISIBLE,
  CONSTRAINT `fk_inventory_film1`
    FOREIGN KEY (`film_id`)
    REFERENCES `ironflix`.`film` (`film_id`),
  CONSTRAINT `fk_inventory_language1`
    FOREIGN KEY (`language_id`)
    REFERENCES `ironflix`.`language` (`language_id`),
  CONSTRAINT `fk_inventory_stores1`
    FOREIGN KEY (`store_id`)
    REFERENCES `ironflix`.`stores` (`store_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `ironflix`.`staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ironflix`.`staff` (
  `staff_id` INT NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `DNI` VARCHAR(9) NOT NULL,
  `job_position` VARCHAR(45) NOT NULL,
  `last_update` DATETIME NULL DEFAULT NULL,
  `stores_idstores` INT NOT NULL,
  PRIMARY KEY (`staff_id`, `stores_idstores`),
  UNIQUE INDEX `DNI_UNIQUE` (`DNI` ASC) VISIBLE,
  INDEX `fk_staff_stores1_idx` (`stores_idstores` ASC) VISIBLE,
  CONSTRAINT `fk_staff_stores1`
    FOREIGN KEY (`stores_idstores`)
    REFERENCES `ironflix`.`stores` (`store_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `ironflix`.`rental`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ironflix`.`rental` (
  `rental_id` INT NOT NULL,
  `rental_date` DATETIME NOT NULL,
  `return_date` DATETIME NOT NULL,
  `last_update` DATETIME NULL DEFAULT NULL,
  `customer_id` INT NOT NULL,
  `staff_id` INT NOT NULL,
  `inventory_id` INT NOT NULL,
  `film_id` INT NOT NULL,
  `store_id` INT NOT NULL,
  `language_id` INT NOT NULL,
  PRIMARY KEY (`rental_id`, `customer_id`, `staff_id`, `inventory_id`, `film_id`, `store_id`, `language_id`),
  INDEX `fk_rental_clients1_idx` (`customer_id` ASC) VISIBLE,
  INDEX `fk_rental_staff1_idx` (`staff_id` ASC) VISIBLE,
  INDEX `fk_rental_inventory1_idx` (`inventory_id` ASC, `film_id` ASC, `store_id` ASC, `language_id` ASC) VISIBLE,
  CONSTRAINT `fk_rental_clients1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `ironflix`.`clients` (`customer_id`),
  CONSTRAINT `fk_rental_inventory1`
    FOREIGN KEY (`inventory_id` , `film_id` , `store_id` , `language_id`)
    REFERENCES `ironflix`.`inventory` (`inventory_id` , `film_id` , `store_id` , `language_id`),
  CONSTRAINT `fk_rental_staff1`
    FOREIGN KEY (`staff_id`)
    REFERENCES `ironflix`.`staff` (`staff_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
