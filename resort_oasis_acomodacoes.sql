-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: resort_oasis
-- ------------------------------------------------------
-- Server version	8.0.46

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
-- Table structure for table `acomodacoes`
--

DROP TABLE IF EXISTS `acomodacoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `acomodacoes` (
  `id_acomodacao` int NOT NULL AUTO_INCREMENT,
  `numero` varchar(10) NOT NULL,
  `tipo` varchar(40) NOT NULL,
  `capacidade` int NOT NULL,
  `diaria` decimal(10,2) NOT NULL,
  `status` enum('Disponivel','Manutencao','Bloqueada') NOT NULL DEFAULT 'Disponivel',
  PRIMARY KEY (`id_acomodacao`),
  UNIQUE KEY `numero` (`numero`),
  CONSTRAINT `chk_capacidade` CHECK ((`capacidade` > 0)),
  CONSTRAINT `chk_diaria` CHECK ((`diaria` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acomodacoes`
--

LOCK TABLES `acomodacoes` WRITE;
/*!40000 ALTER TABLE `acomodacoes` DISABLE KEYS */;
INSERT INTO `acomodacoes` VALUES (1,'101','Standard',2,350.00,'Disponivel'),(2,'102','Standard',2,350.00,'Disponivel'),(3,'201','Luxo',3,580.00,'Disponivel'),(4,'202','Luxo',4,650.00,'Disponivel'),(5,'301','Suíte Presidencial',5,1200.00,'Disponivel'),(6,'105','Família',5,780.00,'Manutencao');
/*!40000 ALTER TABLE `acomodacoes` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-27 22:27:09
