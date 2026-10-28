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
-- Table structure for table `consumo_servicos`
--

DROP TABLE IF EXISTS `consumo_servicos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `consumo_servicos` (
  `id_consumo` int NOT NULL AUTO_INCREMENT,
  `id_reserva` int NOT NULL,
  `id_servico` int NOT NULL,
  `data_consumo` date NOT NULL,
  `quantidade` int NOT NULL DEFAULT '1',
  `valor_unitario` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id_consumo`),
  KEY `fk_consumo_reserva` (`id_reserva`),
  KEY `fk_consumo_servico` (`id_servico`),
  CONSTRAINT `fk_consumo_reserva` FOREIGN KEY (`id_reserva`) REFERENCES `reservas` (`id_reserva`),
  CONSTRAINT `fk_consumo_servico` FOREIGN KEY (`id_servico`) REFERENCES `servicos` (`id_servico`),
  CONSTRAINT `chk_quantidade_consumo` CHECK ((`quantidade` > 0)),
  CONSTRAINT `chk_valor_unitario` CHECK ((`valor_unitario` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consumo_servicos`
--

LOCK TABLES `consumo_servicos` WRITE;
/*!40000 ALTER TABLE `consumo_servicos` DISABLE KEYS */;
INSERT INTO `consumo_servicos` VALUES (1,1,1,'2026-06-02',1,180.00),(2,1,2,'2026-06-02',2,95.00),(3,2,3,'2026-06-11',2,150.00),(4,3,2,'2026-07-06',2,95.00),(5,4,4,'2026-07-13',1,260.00),(6,4,5,'2026-07-12',1,120.00),(7,6,1,'2026-08-11',2,180.00),(8,6,2,'2026-08-11',3,95.00),(9,5,3,'2026-08-02',1,150.00),(10,2,5,'2026-06-10',1,120.00);
/*!40000 ALTER TABLE `consumo_servicos` ENABLE KEYS */;
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
