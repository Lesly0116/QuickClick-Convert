-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: localhost    Database: convertdocs
-- ------------------------------------------------------
-- Server version	8.0.45

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `documents`
--

DROP TABLE IF EXISTS `documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `documents` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `nom_fichier` varchar(255) NOT NULL,
  `type_avant` varchar(50) NOT NULL,
  `type_apres` varchar(50) NOT NULL,
  `date_conversion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `nom_fichier_converti` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `documents_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `utilisateur` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documents`
--

LOCK TABLES `documents` WRITE;
/*!40000 ALTER TABLE `documents` DISABLE KEYS */;
INSERT INTO `documents` VALUES (1,2,'dummy.pdf','pdf','docx','2026-02-13 04:42:24','1770957742029_dummy.docx'),(2,2,'dummy.pdf','pdf','docx','2026-02-13 10:27:19','1770978435901_dummy.docx'),(3,2,'dummy.pdf','pdf','docx','2026-02-13 11:06:37','1770980790270_dummy.docx'),(4,2,'dummy.pdf','pdf','docx','2026-02-13 11:17:52','1770981462822_dummy.docx'),(5,2,'SQL2_103244.pdf','pdf','docx','2026-02-13 11:26:19','1770981952447_SQL2_103244.docx'),(6,2,'ORACLE_SQL_INUKA_2024-2025.pdf','pdf','docx','2026-02-13 11:39:41','1770982747080_ORACLE_SQL_INUKA_2024-2025.docx'),(7,2,'SQL2_103244.pdf','pdf','docx','2026-02-13 16:43:01','1771000946768_SQL2_103244.docx'),(8,4,'dummy.pdf','pdf','docx','2026-02-22 19:19:08','1771769945072_dummy.docx'),(9,2,'dummy.pdf','pdf','docx','2026-02-22 19:11:13','1771787469772_dummy.docx'),(10,4,'dummy.pdf','pdf','docx','2026-02-22 19:12:17','1771787534567_dummy.docx'),(11,4,'SQL2_103244.pdf','pdf','docx','2026-02-22 19:24:50','1771788275345_SQL2_103244.docx'),(12,4,'SQL2_103244.pdf','pdf','docx','2026-02-28 06:59:22','1772261952039_SQL2_103244.docx'),(13,4,'dummy.pdf','pdf','docx','2026-02-28 07:45:02','1772264701269_dummy.docx');
/*!40000 ALTER TABLE `documents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `utilisateur`
--

DROP TABLE IF EXISTS `utilisateur`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `utilisateur` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `date_creation` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `role` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `utilisateur`
--

LOCK TABLES `utilisateur` WRITE;
/*!40000 ALTER TABLE `utilisateur` DISABLE KEYS */;
INSERT INTO `utilisateur` VALUES (1,'jeanleslyjocelyn@gmail.com','Connard12','2026-02-12 23:33:07','utilisateur'),(2,'noahjeanlouis@gmail.com','noahDude14','2026-02-12 23:40:03','utilisateur'),(3,'jacobjules@gmail.com','jacobjles01','2026-02-16 01:27:40','administrateur'),(4,'juniorjules@gmail.com','junior16','2026-02-21 11:07:49','USER');
/*!40000 ALTER TABLE `utilisateur` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-02  1:32:01
