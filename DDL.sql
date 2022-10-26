-- MariaDB dump 10.19  Distrib 10.4.25-MariaDB, for Linux (x86_64)
--
-- Host: classmysql.engr.oregonstate.edu    Database: cs340_patelsah
-- ------------------------------------------------------
-- Server version	10.6.9-MariaDB-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Blood_Donors`
--
SET FOREIGN_KEY_CHECKS=0;
SET AUTOCOMMIT = 0;

DROP TABLE IF EXISTS `Blood_Donors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Blood_Donors` (
  `donor_id` int(11) NOT NULL AUTO_INCREMENT,
  `donor_name` varchar(50) DEFAULT NULL,
  `donor_eligibility` tinyint(1) DEFAULT NULL,
  `amt_of_donations` int(11) DEFAULT NULL,
  `date_of_last_donation` date DEFAULT NULL,
  `date_of_next_donation` date DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` int(11) DEFAULT NULL,
  `donor_address` varchar(255) DEFAULT NULL,
  `username_FK` varchar(50) NOT NULL,
  `blood_type_FK` int(11) NOT NULL,
  PRIMARY KEY (`donor_id`),
  UNIQUE KEY `email` (`email`),
  KEY `username_FK` (`username_FK`),
  KEY `blood_type_FK` (`blood_type_FK`),
  CONSTRAINT `blood_type_FK` FOREIGN KEY (`blood_type_FK`) REFERENCES `Blood_Types` (`blood_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `username_FK` FOREIGN KEY (`username_FK`) REFERENCES `Donor_Logins` (`username_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Blood_Donors`
--

LOCK TABLES `Blood_Donors` WRITE;
/*!40000 ALTER TABLE `Blood_Donors` DISABLE KEYS */;
INSERT INTO `Blood_Donors` VALUES (3,'Sahil',1,10,'2022-01-03','2022-03-04','spatel@gmail.com',1234567890,'7266 Oakwood Dr.Waterbury, CT 06705','spatel',22),(11,'Ruth',1,15,'2021-12-05','2022-02-07','rbabe@yahoo.com',87532198,'9385 Stonybrook Lane. Schaumburg, IL 60193','rbabe',21),(12,'Kim',1,20,'2022-03-01','2022-05-02','kpossible@msn.com',98745623,'28 SE. High Noon Ave. Morton Grove, IL 60053','kpossible',23),(13,'Jimmy',1,8,'2022-02-01','2022-04-02','jpage@gmail.com',42013524,'58 Van Dyke St.Cumming, GA 30040','jpage',27);
/*!40000 ALTER TABLE `Blood_Donors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Blood_Types`
--

DROP TABLE IF EXISTS `Blood_Types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Blood_Types` (
  `blood_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `blood_antigen` varchar(2) NOT NULL,
  `rh_factor` tinyint(1) NOT NULL,
  PRIMARY KEY (`blood_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Blood_Types`
--

LOCK TABLES `Blood_Types` WRITE;
/*!40000 ALTER TABLE `Blood_Types` DISABLE KEYS */;
INSERT INTO `Blood_Types` VALUES (21,'O',0),(22,'O',1),(23,'A',0),(24,'A',1),(25,'B',0),(26,'B',1),(27,'AB',0),(28,'AB',1);
/*!40000 ALTER TABLE `Blood_Types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Donation_Events`
--

DROP TABLE IF EXISTS `Donation_Events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Donation_Events` (
  `event_id` int(11) NOT NULL AUTO_INCREMENT,
  `donor_id_FK` int(11) DEFAULT NULL,
  `stock_id_FK` int(11) DEFAULT NULL,
  `location_id_FK` int(11) DEFAULT NULL,
  `storage_id_FK` int(11) DEFAULT NULL,
  `date_of_event` date DEFAULT NULL,
  PRIMARY KEY (`event_id`),
  KEY `stock_id_idx` (`stock_id_FK`),
  KEY `location_id_idx` (`location_id_FK`),
  KEY `storage_id_FK_idx` (`storage_id_FK`),
  KEY `donor_id_FK` (`donor_id_FK`),
  CONSTRAINT `donor_id_FK` FOREIGN KEY (`donor_id_FK`) REFERENCES `Blood_Donors` (`donor_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `location_id_FK` FOREIGN KEY (`location_id_FK`) REFERENCES `Donation_Locations` (`donation_location_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `stock_id_FK` FOREIGN KEY (`stock_id_FK`) REFERENCES `Donation_Stocks` (`tracking_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `storage_id_FK` FOREIGN KEY (`storage_id_FK`) REFERENCES `Storage_Locations` (`storage_location_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Donation_Events`
--

LOCK TABLES `Donation_Events` WRITE;
/*!40000 ALTER TABLE `Donation_Events` DISABLE KEYS */;
INSERT INTO `Donation_Events` VALUES (6,3,3,2,5,'2022-01-03'),(7,11,2,3,3,'2021-12-05'),(8,12,4,3,3,'2022-03-01'),(9,13,5,4,2,'2022-02-01');
/*!40000 ALTER TABLE `Donation_Events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Donation_Locations`
--

DROP TABLE IF EXISTS `Donation_Locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Donation_Locations` (
  `donation_location_id` int(11) NOT NULL AUTO_INCREMENT,
  `donation_state` varchar(50) DEFAULT NULL,
  `donation_city` varchar(50) DEFAULT NULL,
  `donation_address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`donation_location_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Donation_Locations`
--

LOCK TABLES `Donation_Locations` WRITE;
/*!40000 ALTER TABLE `Donation_Locations` DISABLE KEYS */;
INSERT INTO `Donation_Locations` VALUES (2,'CT','Farmington','209 Farmington Ave, Farmington, CT 06032'),(3,'IL','Chicago','2200 W Harrison St, Chicago, IL 60612'),(4,'GA','Savannah','25 Tibet Ave, Savannah, GA 31406');
/*!40000 ALTER TABLE `Donation_Locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Donation_Stocks`
--

DROP TABLE IF EXISTS `Donation_Stocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Donation_Stocks` (
  `tracking_id` int(11) NOT NULL AUTO_INCREMENT,
  `donation_viability` tinyint(1) DEFAULT NULL,
  `volume_of_blood` decimal(5,2) DEFAULT NULL,
  `date_of_donation` date DEFAULT NULL,
  `shelf_life` int(11) DEFAULT NULL,
  `blood_type_id_FK` int(11) NOT NULL,
  PRIMARY KEY (`tracking_id`),
  KEY `blood_type_id_FK` (`blood_type_id_FK`),
  CONSTRAINT `blood_type_id_FK` FOREIGN KEY (`blood_type_id_FK`) REFERENCES `Blood_Types` (`blood_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Donation_Stocks`
--

LOCK TABLES `Donation_Stocks` WRITE;
/*!40000 ALTER TABLE `Donation_Stocks` DISABLE KEYS */;
INSERT INTO `Donation_Stocks` VALUES (2,1,500.00,'2021-12-05',42,27),(3,0,100.00,'2022-01-03',0,21),(4,1,500.00,'2022-03-01',42,28),(5,1,500.00,'2022-02-01',42,24);
/*!40000 ALTER TABLE `Donation_Stocks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Donor_Logins`
--

DROP TABLE IF EXISTS `Donor_Logins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Donor_Logins` (
  `username_id` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  PRIMARY KEY (`username_id`),
  UNIQUE KEY `password_UNIQUE` (`password`),
  UNIQUE KEY `username_id_UNIQUE` (`username_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Donor_Logins`
--

LOCK TABLES `Donor_Logins` WRITE;
/*!40000 ALTER TABLE `Donor_Logins` DISABLE KEYS */;
INSERT INTO `Donor_Logins` VALUES ('rbabe','babe'),('kpossible','kim'),('jpage','page'),('spatel','pass123');
/*!40000 ALTER TABLE `Donor_Logins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Storage_Locations`
--

DROP TABLE IF EXISTS `Storage_Locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Storage_Locations` (
  `storage_location_id` int(11) NOT NULL AUTO_INCREMENT,
  `storage_state` varchar(50) DEFAULT NULL,
  `storage_city` varchar(50) DEFAULT NULL,
  `storage_address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`storage_location_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Storage_Locations`
--

LOCK TABLES `Storage_Locations` WRITE;
/*!40000 ALTER TABLE `Storage_Locations` DISABLE KEYS */;
INSERT INTO `Storage_Locations` VALUES (2,'GA','Savannah','11705 Mercy Boulevard, Savannah, GA 31419'),(3,'IL','Chicago','1740 W Taylor St, Chicago, IL 60612'),(4,'GA','Douglasville','9851 Commerce Way, Douglasville, GA 30135'),(5,'CT','Farmington','100 Hospital Dr, Farmington, CT 06030');
/*!40000 ALTER TABLE `Storage_Locations` ENABLE KEYS */;
UNLOCK TABLES;

SET FOREIGN_KEY_CHECKS=1;
COMMIT;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-10-20 15:12:11
