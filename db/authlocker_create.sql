SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `op826_authlocker` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `op826_authlocker` ;

-- -----------------------------------------------------
-- Table `op826_authlocker`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `op826_authlocker`.`user` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `email_hash` VARCHAR(128) NOT NULL,
  `email` VARCHAR(256) NOT NULL,
  `auth_hash` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_hash_UNIQUE` (`email_hash` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `op826_authlocker`.`session`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `op826_authlocker`.`session` (
  `id` VARBINARY(256) NOT NULL,
  `user_id` INT UNSIGNED NULL,
  `expire` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_session_user_idx` (`user_id` ASC),
  CONSTRAINT `fk_session_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `op826_authlocker`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `op826_authlocker`.`datastore`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `op826_authlocker`.`datastore` (
  `user_id` INT UNSIGNED NOT NULL,
  `key_hash` VARCHAR(45) NULL,
  `key` VARCHAR(256) NULL,
  `data` BINARY NULL,
  `version` INT UNSIGNED NULL,
  UNIQUE INDEX `ix_user_key` (`user_id` ASC, `key_hash` ASC),
  CONSTRAINT `fk_datastore_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `op826_authlocker`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
