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
-- Table structure for table `reservas`
--

DROP TABLE IF EXISTS `reservas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservas` (
  `id_reserva` int NOT NULL AUTO_INCREMENT,
  `id_hospede` int NOT NULL,
  `id_acomodacao` int NOT NULL,
  `data_checkin` date NOT NULL,
  `data_checkout` date NOT NULL,
  `quantidade_hospedes` int NOT NULL,
  `status` enum('Pendente','Confirmada','Hospedado','Concluida','Cancelada') NOT NULL DEFAULT 'Pendente',
  PRIMARY KEY (`id_reserva`),
  KEY `fk_reserva_hospede` (`id_hospede`),
  KEY `fk_reserva_acomodacao` (`id_acomodacao`),
  CONSTRAINT `fk_reserva_acomodacao` FOREIGN KEY (`id_acomodacao`) REFERENCES `acomodacoes` (`id_acomodacao`),
  CONSTRAINT `fk_reserva_hospede` FOREIGN KEY (`id_hospede`) REFERENCES `hospedes` (`id_hospede`),
  CONSTRAINT `chk_datas_reserva` CHECK ((`data_checkout` > `data_checkin`)),
  CONSTRAINT `chk_qtd_hospedes` CHECK ((`quantidade_hospedes` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservas`
--

LOCK TABLES `reservas` WRITE;
/*!40000 ALTER TABLE `reservas` DISABLE KEYS */;
INSERT INTO `reservas` VALUES (1,1,1,'2026-06-01','2026-06-04',2,'Concluida'),(2,2,3,'2026-06-10','2026-06-12',2,'Concluida'),(3,1,2,'2026-07-05','2026-07-08',1,'Confirmada'),(4,3,4,'2026-07-12','2026-07-16',3,'Confirmada'),(5,4,5,'2026-08-01','2026-08-03',2,'Pendente'),(6,5,3,'2026-08-10','2026-08-13',2,'Confirmada'),(7,6,6,'2026-09-02','2026-09-05',4,'Cancelada');
/*!40000 ALTER TABLE `reservas` ENABLE KEYS */;
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
