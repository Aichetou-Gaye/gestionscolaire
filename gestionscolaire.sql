-- MySQL dump 10.13  Distrib 8.0.37, for Win64 (x86_64)
--
-- Host: localhost    Database: gestionscolaire
-- ------------------------------------------------------
-- Server version	8.0.37

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
-- Table structure for table `classes`
--

DROP TABLE IF EXISTS `classes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `classes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) NOT NULL,
  `departement` int NOT NULL,
  `niveau` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `ck_niveau` CHECK (((`niveau` = _cp850'primaire') or (`niveau` = _cp850'secondaire') or (`niveau` = _cp850'superieur')))
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classes`
--

LOCK TABLES `classes` WRITE;
/*!40000 ALTER TABLE `classes` DISABLE KEYS */;
INSERT INTO `classes` VALUES (1,'SRI2',2,'superieur'),(2,'Seconde',1,'secondaire'),(3,'CP',3,'primaire');
/*!40000 ALTER TABLE `classes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `etudiants`
--

DROP TABLE IF EXISTS `etudiants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etudiants` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) NOT NULL,
  `adresse` varchar(100) DEFAULT NULL,
  `num_tel` varchar(20) NOT NULL,
  `email` varchar(100) NOT NULL,
  `date_naiss` date NOT NULL,
  `genre` char(2) NOT NULL,
  `classes_id` int NOT NULL,
  `inscriptions_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `un_tel` (`num_tel`),
  UNIQUE KEY `un_mail` (`email`),
  KEY `fk_classe_e` (`classes_id`),
  KEY `fk_inscrip_e` (`inscriptions_id`),
  CONSTRAINT `fk_classe_e` FOREIGN KEY (`classes_id`) REFERENCES `classes` (`id`),
  CONSTRAINT `fk_inscrip_e` FOREIGN KEY (`inscriptions_id`) REFERENCES `inscriptions` (`id`),
  CONSTRAINT `ck_genre` CHECK (((`genre` = _cp850'F') or (`genre` = _cp850'H')))
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etudiants`
--

LOCK TABLES `etudiants` WRITE;
/*!40000 ALTER TABLE `etudiants` DISABLE KEYS */;
INSERT INTO `etudiants` VALUES (1,'Gaye Aichetou','Elmina zone thermique','44 34 24 14','aich@gmzil.com','2010-12-09','F',1,1),(2,'Sall Fatima','Elmina','44 64 24 14','fatim@gmzil.com','2000-11-09','F',2,3),(3,'Sem Thillo','Cité','45 34 94 10','thill@gmzil.com','2010-10-09','F',3,2);
/*!40000 ALTER TABLE `etudiants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inscriptions`
--

DROP TABLE IF EXISTS `inscriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inscriptions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date_inscrip` date NOT NULL,
  `frais` decimal(15,2) NOT NULL,
  `annee_scolaire` varchar(10) NOT NULL,
  `niveau` varchar(50) NOT NULL,
  `statut` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `ck_niveau_i` CHECK (((`niveau` = _cp850'primaire') or (`niveau` = _cp850'secondaire') or (`niveau` = _cp850'superieur'))),
  CONSTRAINT `ck_statut` CHECK (((`statut` = _cp850'actif') or (`statut` = _cp850'en attente')))
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inscriptions`
--

LOCK TABLES `inscriptions` WRITE;
/*!40000 ALTER TABLE `inscriptions` DISABLE KEYS */;
INSERT INTO `inscriptions` VALUES (1,'2023-10-10',1200.50,'2023-2024','secondaire','actif'),(2,'2023-10-08',1100.50,'2023-2024','primaire','actif'),(3,'2023-09-08',1500.00,'2023-2024','superieur','actif');
/*!40000 ALTER TABLE `inscriptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notes`
--

DROP TABLE IF EXISTS `notes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `matiere` varchar(50) NOT NULL,
  `professeur` varchar(50) NOT NULL,
  `type_evaluation` varchar(50) NOT NULL,
  `valeur` decimal(5,2) NOT NULL,
  `date_eval` date NOT NULL,
  `etudiants_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_notes` (`etudiants_id`),
  CONSTRAINT `fk_notes` FOREIGN KEY (`etudiants_id`) REFERENCES `etudiants` (`id`),
  CONSTRAINT `ck_type` CHECK (((`type_evaluation` = _cp850'devoir') or (`type_evaluation` = _cp850'examen')))
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notes`
--

LOCK TABLES `notes` WRITE;
/*!40000 ALTER TABLE `notes` DISABLE KEYS */;
INSERT INTO `notes` VALUES (1,'Physique','Mr Dia','devoir',13.00,'2024-04-01',1),(2,'Coloriage','Mme Fall','devoir',8.50,'2024-01-01',3),(3,'Reseau informatique','Mr Bouamatou','examen',17.25,'2023-12-01',2);
/*!40000 ALTER TABLE `notes` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-07-09  7:04:40
