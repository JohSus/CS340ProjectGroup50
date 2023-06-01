-- MariaDB dump 10.19  Distrib 10.6.12-MariaDB, for Linux (x86_64)
--
-- Host: classmysql.engr.oregonstate.edu    Database: cs340_wubr
-- ------------------------------------------------------
-- Server version	10.6.12-MariaDB-log

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
-- Table structure for table `Customers`
--

DROP TABLE IF EXISTS `Customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Customers` (
  `customer_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_name` varchar(50) NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Customers`
--

LOCK TABLES `Customers` WRITE;
/*!40000 ALTER TABLE `Customers` DISABLE KEYS */;
INSERT INTO `Customers` VALUES (1,'John Mayer','(212) 555-1234'),(2,'Ethan Wright','(312) 555-5678'),(4,'Alexander Patel','(305) 555-6789'),(5,'Olivia Kim','(206) 555-6789'),(7,'Hannah ','123123123'),(9,'asdf','12313'),(10,'asdf','asdf'),(11,'test','(123) 123-1234'),(12,'asdf','asdfs');
/*!40000 ALTER TABLE `Customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Customers_has_Dietary_Restrictions`
--

DROP TABLE IF EXISTS `Customers_has_Dietary_Restrictions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Customers_has_Dietary_Restrictions` (
  `customer_id` int(11) NOT NULL,
  `restriction_id` int(11) NOT NULL,
  PRIMARY KEY (`customer_id`,`restriction_id`),
  KEY `restriction_id` (`restriction_id`),
  CONSTRAINT `Customers_has_Dietary_Restrictions_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `Customers` (`customer_id`) ON DELETE CASCADE,
  CONSTRAINT `Customers_has_Dietary_Restrictions_ibfk_2` FOREIGN KEY (`restriction_id`) REFERENCES `Dietary_Restrictions` (`restriction_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Customers_has_Dietary_Restrictions`
--

LOCK TABLES `Customers_has_Dietary_Restrictions` WRITE;
/*!40000 ALTER TABLE `Customers_has_Dietary_Restrictions` DISABLE KEYS */;
INSERT INTO `Customers_has_Dietary_Restrictions` VALUES (1,2),(1,3),(2,3);
/*!40000 ALTER TABLE `Customers_has_Dietary_Restrictions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Dietary_Restrictions`
--

DROP TABLE IF EXISTS `Dietary_Restrictions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Dietary_Restrictions` (
  `restriction_id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`restriction_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Dietary_Restrictions`
--

LOCK TABLES `Dietary_Restrictions` WRITE;
/*!40000 ALTER TABLE `Dietary_Restrictions` DISABLE KEYS */;
INSERT INTO `Dietary_Restrictions` VALUES (1,'Vegetarian'),(2,'Gluten-free'),(3,'Dairy-free');
/*!40000 ALTER TABLE `Dietary_Restrictions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Dishes`
--

DROP TABLE IF EXISTS `Dishes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Dishes` (
  `dish_id` int(11) NOT NULL AUTO_INCREMENT,
  `dish_name` varchar(45) NOT NULL,
  `price` decimal(4,2) NOT NULL,
  PRIMARY KEY (`dish_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Dishes`
--

LOCK TABLES `Dishes` WRITE;
/*!40000 ALTER TABLE `Dishes` DISABLE KEYS */;
INSERT INTO `Dishes` VALUES (1,'Hamburger',3.50),(2,'Cheeseburger',3.70),(3,'Fries',2.00),(4,'Tater Tots',2.50);
/*!40000 ALTER TABLE `Dishes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Orders`
--

DROP TABLE IF EXISTS `Orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Orders` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT,
  `time` datetime NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `dish_quantity` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`order_id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `Orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `Customers` (`customer_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Orders`
--

LOCK TABLES `Orders` WRITE;
/*!40000 ALTER TABLE `Orders` DISABLE KEYS */;
INSERT INTO `Orders` VALUES (1,'2023-05-02 10:15:30',1,1),(2,'2023-05-01 10:20:45',NULL,1),(3,'2023-04-30 09:00:00',NULL,1),(4,'2023-04-29 13:59:59',4,1);
/*!40000 ALTER TABLE `Orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Orders_has_Dishes`
--

DROP TABLE IF EXISTS `Orders_has_Dishes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Orders_has_Dishes` (
  `order_id` int(11) NOT NULL,
  `dish_id` int(11) NOT NULL,
  PRIMARY KEY (`order_id`,`dish_id`),
  KEY `dish_id` (`dish_id`),
  CONSTRAINT `Orders_has_Dishes_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `Orders` (`order_id`) ON DELETE CASCADE,
  CONSTRAINT `Orders_has_Dishes_ibfk_2` FOREIGN KEY (`dish_id`) REFERENCES `Dishes` (`dish_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Orders_has_Dishes`
--

LOCK TABLES `Orders_has_Dishes` WRITE;
/*!40000 ALTER TABLE `Orders_has_Dishes` DISABLE KEYS */;
INSERT INTO `Orders_has_Dishes` VALUES (1,1),(2,2),(3,1),(3,3),(4,2);
/*!40000 ALTER TABLE `Orders_has_Dishes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Ratings`
--

DROP TABLE IF EXISTS `Ratings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Ratings` (
  `rating_id` int(11) NOT NULL AUTO_INCREMENT,
  `rating` tinyint(5) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `dish_id` int(11) NOT NULL,
  PRIMARY KEY (`rating_id`),
  KEY `customer_id` (`customer_id`),
  KEY `dish_id` (`dish_id`),
  CONSTRAINT `Ratings_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `Customers` (`customer_id`) ON DELETE SET NULL,
  CONSTRAINT `Ratings_ibfk_2` FOREIGN KEY (`dish_id`) REFERENCES `Dishes` (`dish_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Ratings`
--

LOCK TABLES `Ratings` WRITE;
/*!40000 ALTER TABLE `Ratings` DISABLE KEYS */;
/*!40000 ALTER TABLE `Ratings` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-06-01 13:55:24
