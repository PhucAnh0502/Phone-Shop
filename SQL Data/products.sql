-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: localhost    Database: java_t8
-- ------------------------------------------------------
-- Server version	8.0.32

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `supplier_id` int DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` text,
  `price` int DEFAULT NULL,
  `compare_at_price` int DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `supplier_id` (`supplier_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`id`),
  CONSTRAINT `products_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,1,1,'Tango Juliett Zulu Oscar','Occlusion of Gastric Vein, Open Approach',10000,12000,1),(2,2,2,'Bravo','Excision of Left Maxilla, Percutaneous Approach',20000,24000,2),(3,3,3,'Romeo Uniform Oscar November Golf Victor India Alfa','Destruction of Left Toe Phalangeal Joint, Open Approach',30000,36000,3),(4,4,4,'Alfa Victor Whiskey Juliett','Restriction of Pulmonary Trunk with Extraluminal Device, Percutaneous Endoscopic Approach',40000,48000,4),(5,1,1,'Golf Mike Oscar Kilo India Lima Delta Hotel','Restriction of Left Foot Vein with Extraluminal Device, Open Approach',50000,60000,5),(6,2,2,'Papa Tango Echo Quebec Delta Foxtrot','Insertion of Infusion Pump into Left Upper Arm Subcutaneous Tissue and Fascia, Percutaneous Approach',60000,72000,6),(7,2,4,'Whiskey Uniform Charlie Delta','Low Dose Rate (LDR) Brachytherapy of Adrenal Glands using Iodine 125 (I-125)',70000,84000,7),(8,3,4,'Uniform Alfa Oscar Golf Lima Juliett Charlie','Muscle Performance Assessment of Neurological System - Head and Neck',80000,96000,8),(9,1,4,'Mike Sierra Quebec Zulu Bravo Oscar','Occlusion of Azygos Vein, Open Approach',90000,108000,9),(10,1,1,'Juliett Uniform Bravo Victor Kilo Yankee','Supplement Upper Artery with Autologous Tissue Substitute, Open Approach',100000,120000,10),(11,1,1,'Yankee Whiskey','Excision of Right Ankle Tendon, Percutaneous Approach, Diagnostic',110000,132000,11),(12,1,1,'Uniform Echo Alfa Mike Foxtrot','Drainage of Hypoglossal Nerve, Open Approach',120000,144000,12),(13,1,1,'X-ray India Mike Victor Whiskey Bravo','Reposition Right Ethmoid Bone, Percutaneous Approach',130000,156000,13),(14,1,1,'November Delta','Dilation of Lower Artery, Bifurcation, with Three Drug-eluting Intraluminal Devices, Open Approach',140000,168000,14),(15,1,1,'Oscar Foxtrot','Division of Left Elbow Bursa and Ligament, Percutaneous Endoscopic Approach',150000,180000,15),(16,1,1,'Papa Echo','Drainage of Nasal Turbinate, Open Approach, Diagnostic',160000,192000,16),(17,1,1,'Golf Tango Romeo Quebec Juliett Yankee Delta Whiskey Zulu','Release Vagina, Open Approach',170000,204000,17),(18,1,1,'Oscar Whiskey Mike Victor Uniform Echo Romeo','Drainage of Right Frontal Sinus with Drainage Device, Percutaneous Approach',180000,216000,18),(19,1,1,'Alfa Charlie Sierra Yankee Echo Tango Juliett','Revision of Drainage Device in Diaphragm, Open Approach',190000,228000,19),(20,2,2,'Delta Zulu Yankee','Dilation of Right Thyroid Artery with Two Intraluminal Devices, Percutaneous Endoscopic Approach',200000,240000,20);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-02-22 22:44:52
