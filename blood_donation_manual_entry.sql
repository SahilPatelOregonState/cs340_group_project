--Replace cs340_patelsah with your username
-- -----------------------------------------------------
-- Table `cs340_patelsah`.`Blood_Types`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cs340_patelsah`.`Blood_Types` (
  `blood_type_id` INT NOT NULL AUTO_INCREMENT,
  `blood_antigen` VARCHAR(2) NOT NULL,
  `rh_factor` TINYINT(1) NOT NULL,
  PRIMARY KEY (`blood_type_id`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `cs340_patelsah`.`Donor_Logins`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cs340_patelsah`.`Donor_Logins` (
  `username_id` VARCHAR(50) NOT NULL,
  `password` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`username_id`),
  UNIQUE INDEX `password_UNIQUE` (`password` ASC) ,
  UNIQUE INDEX `username_id_UNIQUE` (`username_id` ASC) )
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `cs340_patelsah`.`Storage_Locations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cs340_patelsah`.`Storage_Locations` (
  `storage_location_id` INT NOT NULL AUTO_INCREMENT,
  `storage_state` VARCHAR(50) NULL,
  `storage_city` VARCHAR(50) NULL,
  `storage_address` VARCHAR(255) NULL,
  PRIMARY KEY (`storage_location_id`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `cs340_patelsah`.`Donation_Locations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cs340_patelsah`.`Donation_Locations` (
  `donation_location_id` INT NOT NULL AUTO_INCREMENT,
  `donation_state` VARCHAR(50) NULL,
  `donation_city` VARCHAR(50) NULL,
  `donation_address` VARCHAR(255) NULL,
  PRIMARY KEY (`donation_location_id`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `cs340_patelsah`.`Blood_Donors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cs340_patelsah`.`Blood_Donors` (
  `donor_id` INT NOT NULL AUTO_INCREMENT,
  `donor_name` VARCHAR(50) NULL,
  `donor_eligibility` TINYINT(1) NULL,
  `amt_of_donations` INT NULL,
  `date_of_last_donation` DATE NULL,
  `date_of_next_donation` DATE NULL,
  `email` VARCHAR(255) NULL UNIQUE,
  `phone` INT NULL,
  `donor_address` VARCHAR(255) NULL,
  `username_FK` VARCHAR(50) NOT NULL,
  `blood_type_FK` INT NOT NULL,
  PRIMARY KEY (`donor_id`),
 -- UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
-- UNIQUE INDEX `donor_id_UNIQUE` (`donor_id` ASC) VISIBLE,
-- UNIQUE INDEX `blood_type_id_UNIQUE` () INVISIBLE,
  -- INDEX `blood_type_id_idx` (`blood_type_FK` ASC) VISIBLE,
  CONSTRAINT `username_FK`
    FOREIGN KEY (`username_FK`) REFERENCES `cs340_patelsah`.`Donor_Logins` (`username_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `blood_type_FK`
    FOREIGN KEY (`blood_type_FK`) REFERENCES `cs340_patelsah`.`Blood_Types` (`blood_type_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cs340_patelsah`.`Donation_Stocks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cs340_patelsah`.`Donation_Stocks` (
  `tracking_id` INT NOT NULL AUTO_INCREMENT,
  `donation_viability` TINYINT(1) NULL,
  `volume_of_blood` DECIMAL(5,2) NULL,
  `date_of_donation` DATE NULL,
  `shelf_life` INT NULL,
  `blood_type_id_FK` INT NOT NULL,
  PRIMARY KEY (`tracking_id`),
 -- UNIQUE INDEX `blood_type_id_UNIQUE` (`blood_type_FK` ASC) VISIBLE,
  CONSTRAINT `blood_type_id_FK`
    FOREIGN KEY (`blood_type_id_FK`)
    REFERENCES `cs340_patelsah`.`Blood_Types` (`blood_type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `cs340_patelsah`.`Donation_Events`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cs340_patelsah`.`Donation_Events` (
  `event_id` INT NOT NULL AUTO_INCREMENT,
  `donor_id_FK` INT NULL,
  `stock_id_FK` INT NULL,
  `location_id_FK` INT NULL,
  `storage_id_FK` INT NULL,
  `date_of_event` DATE NULL,
  PRIMARY KEY (`event_id`),
  INDEX `stock_id_idx` (`stock_id_FK` ASC) VISIBLE,
  INDEX `location_id_idx` (`location_id_FK` ASC) VISIBLE,
  INDEX `storage_id_FK_idx` (`storage_id_FK` ASC) VISIBLE,
  CONSTRAINT `donor_id_FK`
    FOREIGN KEY (`donor_id_FK`)
    REFERENCES `cs340_patelsah`.`Blood_Donors` (`donor_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `stock_id_FK`
    FOREIGN KEY (`stock_id_FK`)
    REFERENCES `cs340_patelsah`.`Donation_Stocks` (`tracking_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `location_id_FK`
    FOREIGN KEY (`location_id_FK`)
    REFERENCES `cs340_patelsah`.`Donation_Locations` (`donation_location_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `storage_id_FK`
    FOREIGN KEY (`storage_id_FK`)
    REFERENCES `cs340_patelsah`.`Storage_Locations` (`storage_location_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Insert `cs340_patelsah`.`Blood Types`
-- -----------------------------------------------------
INSERT INTO `Blood_Types` ( `blood_antigen`, `rh_factor`) VALUES ( 'O', '0'), ( 'O', '1'),( 'A', '0'), ( 'A', '1'),( 'B', '0'),( 'B', '1'),( 'AB', '0'),( 'AB', '1');
-- -----------------------------------------------------
-- Insert `cs340_patelsah`.`Donor Logins`
-- -----------------------------------------------------

INSERT INTO `cs340_patelsah`.`Donor_Logins` (`username_id`, `password`) VALUES ('spatel', 'pass123');
INSERT INTO `cs340_patelsah`.`Donor_Logins` (`username_id`, `password`) VALUES ('kpossible', 'kim');
INSERT INTO `cs340_patelsah`.`Donor_Logins` (`username_id`, `password`) VALUES ('rbabe', 'babe');
INSERT INTO `cs340_patelsah`.`Donor_Logins` (`username_id`, `password`) VALUES ('jpage', 'page');

-- -----------------------------------------------------
-- Insert `cs340_patelsah`.`Blood Donors`
-- -----------------------------------------------------

INSERT INTO `Blood_Donors` (`donor_name`, `donor_eligibility`, `amt_of_donations`, `date_of_last_donation`, `date_of_next_donation`, `email`, `phone`, `donor_address`, `username_FK`, `blood_type_FK`) VALUES ( 'Sahil', '1', '10', '2022-01-03', '2022-03-04', 'spatel@gmail.com', '1234567890', '7266 Oakwood Dr.
Waterbury, CT 06705', 
(SELECT username_id from Donor_Logins where username_id = 'spatel'), 
(SELECT blood_type_id from Blood_Types where blood_antigen = 'O' and rh_factor = 1));

INSERT INTO `Blood_Donors` (`donor_name`, `donor_eligibility`, `amt_of_donations`, `date_of_last_donation`, `date_of_next_donation`, `email`, `phone`, `donor_address`, `username_FK`, `blood_type_FK`) VALUES ( 'Ruth', '1', '15', '2021-12-05', '2022-02-07', 'rbabe@yahoo.com', '87532198', '9385 Stonybrook Lane. Schaumburg, IL 60193', 
(SELECT username_id from Donor_Logins where username_id = 'rbabe'), 
(SELECT blood_type_id from Blood_Types where blood_antigen = 'O' and rh_factor = 0));

INSERT INTO `Blood_Donors` (`donor_name`, `donor_eligibility`, `amt_of_donations`, `date_of_last_donation`, `date_of_next_donation`, `email`, `phone`, `donor_address`, `username_FK`, `blood_type_FK`) 
VALUES ( 'Kim', '1', '20', '2022-03-01', '2022-05-02', 'kpossible@msn.com', '98745623', '28 SE. High Noon Ave. Morton Grove, IL 60053', 
(SELECT username_id from Donor_Logins where username_id = 'kpossible'), 
(SELECT blood_type_id from Blood_Types where blood_antigen = 'A' and rh_factor = 0));

INSERT INTO `Blood_Donors` (`donor_name`, `donor_eligibility`, `amt_of_donations`, `date_of_last_donation`, `date_of_next_donation`, `email`, `phone`, `donor_address`, `username_FK`, `blood_type_FK`) 
VALUES ( 'Jimmy', '1', '8', '2022-02-01', '2022-04-02', 'jpage@gmail.com', '42013524', '58 Van Dyke St.Cumming, GA 30040', 
(SELECT username_id from Donor_Logins where username_id = 'jpage'), 
(SELECT blood_type_id from Blood_Types where blood_antigen = 'AB' and rh_factor = 0));

-- -----------------------------------------------------
-- Insert `cs340_patelsah`.`Donation Stock`
-- -----------------------------------------------------
INSERT INTO `Donation_Stocks` ( `donation_viability`, `volume_of_blood`, `date_of_donation`, `shelf_life`, `blood_type_id_FK`) 
VALUES ( 1, 500.00, '2021-12-05', 42, (SELECT blood_type_id from Blood_Types where blood_antigen = 'AB' and rh_factor = 0));

INSERT INTO `Donation_Stocks` ( `donation_viability`, `volume_of_blood`, `date_of_donation`, `shelf_life`, `blood_type_id_FK`) 
VALUES ( 0, 100.00, '2022-01-03', 0, (SELECT blood_type_id from Blood_Types where blood_antigen = 'O' and rh_factor = 0));

INSERT INTO `Donation_Stocks` ( `donation_viability`, `volume_of_blood`, `date_of_donation`, `shelf_life`, `blood_type_id_FK`) 
VALUES ( 1, 500.00, '2022-03-01', 42, (SELECT blood_type_id from Blood_Types where blood_antigen = 'AB' and rh_factor = 1));

INSERT INTO `Donation_Stocks` ( `donation_viability`, `volume_of_blood`, `date_of_donation`, `shelf_life`, `blood_type_id_FK`) 
VALUES ( 1, 500.00, '2022-02-01', 42, (SELECT blood_type_id from Blood_Types where blood_antigen = 'A' and rh_factor = 1));


-- -----------------------------------------------------
-- INSERT `cs340_patelsah`.`Donation_Locations`
-- -----------------------------------------------------


INSERT INTO `Donation_Locations` ( `donation_state`, `donation_city`, `donation_address`) VALUES ( 'CT', 'Farmington', '209 Farmington Ave, Farmington, CT 06032');

INSERT INTO `Donation_Locations` ( `donation_state`, `donation_city`, `donation_address`) VALUES ( 'IL', 'Chicago', '2200 W Harrison St, Chicago, IL 60612');

INSERT INTO `Donation_Locations` ( `donation_state`, `donation_city`, `donation_address`) VALUES ( 'GA', 'Savannah', '25 Tibet Ave, Savannah, GA 31406');

-- -----------------------------------------------------
-- INSERT `cs340_patelsah`.`Donation_Stocks`
-- -----------------------------------------------------
INSERT INTO `Storage_Locations` (`storage_state`, `storage_city`, `storage_address`) VALUES ('GA','Savannah','11705 Mercy Boulevard, Savannah, GA 31419' );

INSERT INTO `Storage_Locations` (`storage_state`, `storage_city`, `storage_address`) VALUES ('IL','Chicago','1740 W Taylor St, Chicago, IL 60612' );

INSERT INTO `Storage_Locations` (`storage_state`, `storage_city`, `storage_address`) VALUES ('GA','Douglasville','9851 Commerce Way, Douglasville, GA 30135' );

INSERT INTO `Storage_Locations` (`storage_state`, `storage_city`, `storage_address`) VALUES ('CT','Farmington','100 Hospital Dr, Farmington, CT 06030' );

-- -----------------------------------------------------
-- Insert `cs340_patelsah`.`Donation_Events`
-- -----------------------------------------------------

 INSERT INTO `Donation_Events` ( `donor_id_FK`, `stock_id_FK`, `location_id_FK`, `storage_id_FK`, `date_of_event`) VALUES 
((SELECT donor_id from Blood_Donors where donor_name = 'Sahil'), 
 (SELECT tracking_id from Donation_Stocks where tracking_id = 3 and date_of_donation = '2022-01-03'), 
 (SELECT donation_location_id from Donation_Locations where donation_address = '209 Farmington Ave, Farmington, CT 06032' ), 
 (SELECT storage_location_id from Storage_Locations where storage_address = '100 Hospital Dr, Farmington, CT 06030'), 
 ('2022-01-03') 
 );
 
 INSERT INTO `Donation_Events` ( `donor_id_FK`, `stock_id_FK`, `location_id_FK`, `storage_id_FK`, `date_of_event`) VALUES 
((SELECT donor_id from Blood_Donors where donor_name = 'Ruth'), 
 (SELECT tracking_id from Donation_Stocks where tracking_id = 2 and date_of_donation = '2021-12-05'), 
 (SELECT donation_location_id from Donation_Locations where donation_address = '2200 W Harrison St, Chicago, IL 60612' ), 
 (SELECT storage_location_id from Storage_Locations where storage_address = '1740 W Taylor St, Chicago, IL 60612'), 
 ('2021-12-05') 
 );
 
 INSERT INTO `Donation_Events` ( `donor_id_FK`, `stock_id_FK`, `location_id_FK`, `storage_id_FK`, `date_of_event`) VALUES 
((SELECT donor_id from Blood_Donors where donor_name = 'Kim'), 
 (SELECT tracking_id from Donation_Stocks where tracking_id = 4 and date_of_donation = '2022-03-01'), 
 (SELECT donation_location_id from Donation_Locations where donation_address = '2200 W Harrison St, Chicago, IL 60612' ), 
 (SELECT storage_location_id from Storage_Locations where storage_address = '1740 W Taylor St, Chicago, IL 60612'), 
 ('2022-03-01') 
 );
 
 
 INSERT INTO `Donation_Events` ( `donor_id_FK`, `stock_id_FK`, `location_id_FK`, `storage_id_FK`, `date_of_event`) VALUES 
((SELECT donor_id from Blood_Donors where donor_name = 'Jimmy'), 
 (SELECT tracking_id from Donation_Stocks where tracking_id = 5 and date_of_donation = '2022-02-01'), 
 (SELECT donation_location_id from Donation_Locations where donation_address = '25 Tibet Ave, Savannah, GA 31406' ), 
 (SELECT storage_location_id from Storage_Locations where storage_address = '11705 Mercy Boulevard, Savannah, GA 31419'), 
 ('2022-02-01') 
 );