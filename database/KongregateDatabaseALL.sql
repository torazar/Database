-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Kongregate
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Kongregate
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Kongregate` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema new_schema1
-- -----------------------------------------------------
USE `Kongregate` ;

-- -----------------------------------------------------
-- Table `Kongregate`.`games`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Kongregate`.`games` (
  `games_id` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `Publication_date` DATE NOT NULL,
  PRIMARY KEY (`games_id`),
  UNIQUE INDEX `games_id_UNIQUE` (`games_id` ASC) VISIBLE,
  UNIQUE INDEX `Name_UNIQUE` (`Name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Kongregate`.`categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Kongregate`.`categories` (
  `categories_id` INT NOT NULL,
  `Tag` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`categories_id`),
  UNIQUE INDEX `categories_id_UNIQUE` (`categories_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Kongregate`.`Profiles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Kongregate`.`Profiles` (
  `profiles_id` INT NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`profiles_id`),
  UNIQUE INDEX `profiles_id_UNIQUE` (`profiles_id` ASC) VISIBLE,
  UNIQUE INDEX `Name_UNIQUE` (`Name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Kongregate`.`plays`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Kongregate`.`plays` (
  `plays_id` INT NOT NULL AUTO_INCREMENT,
  `plays_total` INT NOT NULL,
  `games_id` INT NOT NULL,
  `profiles_id` INT NOT NULL,
  PRIMARY KEY (`plays_id`),
  INDEX `fk_plays_games1_idx` (`games_id` ASC) VISIBLE,
  INDEX `fk_plays_Profiles1_idx` (`profiles_id` ASC) VISIBLE,
  CONSTRAINT `fk_plays_games1`
    FOREIGN KEY (`games_id`)
    REFERENCES `Kongregate`.`games` (`games_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_plays_Profiles1`
    FOREIGN KEY (`profiles_id`)
    REFERENCES `Kongregate`.`Profiles` (`profiles_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Kongregate`.`games_has_categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Kongregate`.`games_has_categories` (
  `games_id` INT NOT NULL,
  `categories_id` INT NOT NULL,
  PRIMARY KEY (`games_id`, `categories_id`),
  INDEX `fk_games_has_categories_categories1_idx` (`categories_id` ASC) VISIBLE,
  INDEX `fk_games_has_categories_games1_idx` (`games_id` ASC) VISIBLE,
  CONSTRAINT `fk_games_has_categories_games1`
    FOREIGN KEY (`games_id`)
    REFERENCES `Kongregate`.`games` (`games_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_games_has_categories_categories1`
    FOREIGN KEY (`categories_id`)
    REFERENCES `Kongregate`.`categories` (`categories_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Kongregate`.`Badges`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Kongregate`.`Badges` (
  `Badges_id` INT NOT NULL,
  `Badge_name` VARCHAR(45) NOT NULL,
  `games_id` INT NOT NULL,
  PRIMARY KEY (`Badges_id`),
  UNIQUE INDEX `Badges_id_UNIQUE` (`Badges_id` ASC) VISIBLE,
  INDEX `fk_Badges_games1_idx` (`games_id` ASC) VISIBLE,
  CONSTRAINT `fk_Badges_games1`
    FOREIGN KEY (`games_id`)
    REFERENCES `Kongregate`.`games` (`games_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Kongregate`.`Profiles_has_Badges`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Kongregate`.`Profiles_has_Badges` (
  `Badges_id` INT NOT NULL,
  `profiles_id` INT NOT NULL,
  PRIMARY KEY (`Badges_id`, `profiles_id`),
  INDEX `fk_Badges_has_profiles_profiles1_idx` (`profiles_id` ASC) VISIBLE,
  INDEX `fk_Badges_has_profiles_Badges1_idx` (`Badges_id` ASC) VISIBLE,
  CONSTRAINT `fk_Badges_has_profiles_Badges1`
    FOREIGN KEY (`Badges_id`)
    REFERENCES `Kongregate`.`Badges` (`Badges_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Badges_has_profiles_profiles1`
    FOREIGN KEY (`profiles_id`)
    REFERENCES `Kongregate`.`Profiles` (`profiles_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Kongregate`.`games_has_Rating`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Kongregate`.`games_has_Rating` (
  `games_id` INT NOT NULL,
  `Rating` INT NOT NULL,
  `profiles_id` INT NOT NULL,
  PRIMARY KEY (`games_id`, `profiles_id`),
  INDEX `fk_games_has_Rating_games1_idx` (`games_id` ASC) VISIBLE,
  INDEX `fk_games_has_Rating_Profiles1_idx` (`profiles_id` ASC) VISIBLE,
  CONSTRAINT `fk_games_has_Rating_games1`
    FOREIGN KEY (`games_id`)
    REFERENCES `Kongregate`.`games` (`games_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_games_has_Rating_Profiles1`
    FOREIGN KEY (`profiles_id`)
    REFERENCES `Kongregate`.`Profiles` (`profiles_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Kongregate`.`Playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Kongregate`.`Playlist` (
  `games_id` INT NOT NULL,
  `profiles_id` INT NOT NULL,
  PRIMARY KEY (`games_id`, `profiles_id`),
  INDEX `fk_games_has_Profiles_Profiles1_idx` (`profiles_id` ASC) VISIBLE,
  INDEX `fk_games_has_Profiles_games1_idx` (`games_id` ASC) VISIBLE,
  CONSTRAINT `fk_games_has_Profiles_games1`
    FOREIGN KEY (`games_id`)
    REFERENCES `Kongregate`.`games` (`games_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_games_has_Profiles_Profiles1`
    FOREIGN KEY (`profiles_id`)
    REFERENCES `Kongregate`.`Profiles` (`profiles_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Kongregate`.`Favorite`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Kongregate`.`Favorite` (
  `games_id` INT NOT NULL,
  `profiles_id` INT NOT NULL,
  PRIMARY KEY (`games_id`, `profiles_id`),
  INDEX `fk_games_has_Profiles_Profiles2_idx` (`profiles_id` ASC) VISIBLE,
  INDEX `fk_games_has_Profiles_games2_idx` (`games_id` ASC) VISIBLE,
  CONSTRAINT `fk_games_has_Profiles_games2`
    FOREIGN KEY (`games_id`)
    REFERENCES `Kongregate`.`games` (`games_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_games_has_Profiles_Profiles2`
    FOREIGN KEY (`profiles_id`)
    REFERENCES `Kongregate`.`Profiles` (`profiles_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Kongregate`.`comments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Kongregate`.`comments` (
  `games_id` INT NOT NULL,
  `profiles_id` INT NOT NULL,
  PRIMARY KEY (`games_id`, `profiles_id`),
  INDEX `fk_games_has_Profiles_Profiles3_idx` (`profiles_id` ASC) VISIBLE,
  INDEX `fk_games_has_Profiles_games3_idx` (`games_id` ASC) VISIBLE,
  CONSTRAINT `fk_games_has_Profiles_games3`
    FOREIGN KEY (`games_id`)
    REFERENCES `Kongregate`.`games` (`games_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_games_has_Profiles_Profiles3`
    FOREIGN KEY (`profiles_id`)
    REFERENCES `Kongregate`.`Profiles` (`profiles_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Kongregate`.`reactions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Kongregate`.`reactions` (
  `reactions_id` INT NOT NULL AUTO_INCREMENT,
  `reaction` TINYINT NOT NULL,
  `profiles_id` INT NOT NULL,
  `games_id` INT NOT NULL,
  PRIMARY KEY (`reactions_id`),
  UNIQUE INDEX `reactions_id_UNIQUE` (`reactions_id` ASC) VISIBLE,
  INDEX `fk_reactions_Profiles1_idx` (`profiles_id` ASC) VISIBLE,
  INDEX `fk_reactions_comments1_idx` (`games_id` ASC) VISIBLE,
  CONSTRAINT `fk_reactions_Profiles1`
    FOREIGN KEY (`profiles_id`)
    REFERENCES `Kongregate`.`Profiles` (`profiles_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reactions_comments1`
    FOREIGN KEY (`games_id`)
    REFERENCES `Kongregate`.`comments` (`games_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


use Kongregate;
insert into games values (1, "Demons Vs Fairyland", '2013-01-26');
insert into games values (2, "Tinysasters 2", '2014-03-21');
insert into games values (3, "Takeover", '2012-10-26');

insert into Profiles values(1, 'Torazar');
insert into Profiles values(2, 'Jamic');
insert into Profiles values(3, 'Troguna');

Insert into categories values(1, 'Tower Defense');
Insert into categories values(2, 'Strategy');
Insert into categories values(3, 'Fantasy');
Insert into categories values(4, 'Upgrades');
Insert into categories values(5, 'RTS');

Insert into Badges values(1, 'Strongheld', 3);
Insert into Badges values(2, 'Expansionism at Work', 3);
Insert into Badges values(3, 'Trophy Hunter', 1);

insert into games_has_categories values (1, 1),( 2, 2),(1, 2),(3,4),(3,5),(3,2),(2,3),(1,3),(1,4);

insert into Profiles_has_Badges values(1,1),(1,3),(3,2),(2,1);

select Name, Badge_name from Profiles p join Profiles_has_Badges pf on p.profiles_id = pf.profiles_id
join Badges b on pf.Badges_id = b.Badges_id;

insert into Favorite values (3,1),(2,1),(1,3);

insert into Playlist values (2,1), (3,2),(1,1);

insert into plays values(1, 1, 3, 1),(2, 2, 3, 1),(3, 1, 2, 1),(4, 1, 1, 3),(5, 2, 2, 1);

insert into comments
values (3, 1, "This Game is Amazing!");
insert into comments values (1, 8, "This game is too hard!"),(2, 3, "The art is very well done.");
insert into comments values (3, 7, "The Cult is where it's at!"),(1, 2, "There is mastery in the conflict!.");

select *from comments
where games_id = 3;

insert into reactions values (1, 1, 1, 3),(2,-1,4,2),(3,-1,5,2),(4,-1,6,2),(5,-1,8,2),(6, 1, 3, 1);



insert into Profiles values(4, 'happy'),(5, 'papa'),(6, 'lucky'), (7, 'George'),(8, 'Amaram');

select *from games;
create or replace view Selected_Games
as
select p.Name, g.Name as 'Favorite Games', pl.Name as "Playlisted Games" from Profiles p join Favorite f on p.profiles_id = f.profiles_id
join games g on  f.games_id = g.games_id
join Playlist z on p.profiles_id = z.profiles_id
join games pl on  z.games_id = pl.games_id;
select* from Selected_Games;

insert into games_has_Rating values(3, 5, 1),(1, 1, 8),(1, 1, 4),(1, 1, 5),(1, 1, 6),(3, 4, 3),(2, 3, 7);

select Name, avg(Rating) as "Average Rating" from games g
join games_has_Rating r on g.games_id = r.games_id
group by g.games_id;


