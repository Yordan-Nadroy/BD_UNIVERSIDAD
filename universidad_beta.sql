-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: localhost    Database: universidad_beta
-- ------------------------------------------------------
-- Server version	9.4.0

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
-- Table structure for table `anio_clase`
--

DROP TABLE IF EXISTS `anio_clase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `anio_clase` (
  `id_anio_clase` smallint NOT NULL,
  `año` smallint NOT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_anio_clase`),
  UNIQUE KEY `año` (`año`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `anio_clase`
--

LOCK TABLES `anio_clase` WRITE;
/*!40000 ALTER TABLE `anio_clase` DISABLE KEYS */;
/*!40000 ALTER TABLE `anio_clase` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `anio_fiscal`
--

DROP TABLE IF EXISTS `anio_fiscal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `anio_fiscal` (
  `id_anio_fiscal` smallint NOT NULL,
  `etiqueta` varchar(16) NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL,
  PRIMARY KEY (`id_anio_fiscal`),
  UNIQUE KEY `etiqueta` (`etiqueta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `anio_fiscal`
--

LOCK TABLES `anio_fiscal` WRITE;
/*!40000 ALTER TABLE `anio_fiscal` DISABLE KEYS */;
/*!40000 ALTER TABLE `anio_fiscal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `campaña`
--

DROP TABLE IF EXISTS `campaña`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `campaña` (
  `id_campaña` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `tipo` varchar(32) DEFAULT NULL,
  `id_anio_fiscal` smallint NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_campaña`),
  KEY `id_anio_fiscal` (`id_anio_fiscal`),
  CONSTRAINT `campaña_ibfk_1` FOREIGN KEY (`id_anio_fiscal`) REFERENCES `anio_fiscal` (`id_anio_fiscal`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campaña`
--

LOCK TABLES `campaña` WRITE;
/*!40000 ALTER TABLE `campaña` DISABLE KEYS */;
/*!40000 ALTER TABLE `campaña` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `circulo_donante`
--

DROP TABLE IF EXISTS `circulo_donante`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `circulo_donante` (
  `id_circulo` tinyint NOT NULL AUTO_INCREMENT,
  `nombre` varchar(80) NOT NULL,
  `monto_minimo` decimal(12,2) NOT NULL,
  `monto_maximo` decimal(12,2) DEFAULT NULL,
  PRIMARY KEY (`id_circulo`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `circulo_donante`
--

LOCK TABLES `circulo_donante` WRITE;
/*!40000 ALTER TABLE `circulo_donante` DISABLE KEYS */;
/*!40000 ALTER TABLE `circulo_donante` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compromiso`
--

DROP TABLE IF EXISTS `compromiso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `compromiso` (
  `id_compromiso` bigint NOT NULL AUTO_INCREMENT,
  `id_donante` bigint NOT NULL,
  `id_campaña` int NOT NULL,
  `fecha` date DEFAULT NULL,
  `monto` decimal(12,2) DEFAULT NULL,
  `id_metodo` tinyint DEFAULT NULL,
  `es_unico` tinyint(1) DEFAULT '1',
  `cuotas` int DEFAULT NULL,
  `estado` enum('pendiente','activo','cumplido','cancelado') DEFAULT 'pendiente',
  `fecha_agradecimiento` date DEFAULT NULL,
  `fuente` varchar(32) DEFAULT NULL,
  `id_evento` bigint DEFAULT NULL,
  `id_compromiso_matching` bigint DEFAULT NULL,
  `notas` text,
  PRIMARY KEY (`id_compromiso`),
  KEY `id_donante` (`id_donante`),
  KEY `id_campaña` (`id_campaña`),
  KEY `id_metodo` (`id_metodo`),
  KEY `id_evento` (`id_evento`),
  KEY `id_compromiso_matching` (`id_compromiso_matching`),
  CONSTRAINT `compromiso_ibfk_1` FOREIGN KEY (`id_donante`) REFERENCES `donante` (`id_donante`),
  CONSTRAINT `compromiso_ibfk_2` FOREIGN KEY (`id_campaña`) REFERENCES `campaña` (`id_campaña`),
  CONSTRAINT `compromiso_ibfk_3` FOREIGN KEY (`id_metodo`) REFERENCES `metodo_pago` (`id_metodo`),
  CONSTRAINT `compromiso_ibfk_4` FOREIGN KEY (`id_evento`) REFERENCES `evento` (`id_evento`),
  CONSTRAINT `compromiso_ibfk_5` FOREIGN KEY (`id_compromiso_matching`) REFERENCES `compromiso` (`id_compromiso`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compromiso`
--

LOCK TABLES `compromiso` WRITE;
/*!40000 ALTER TABLE `compromiso` DISABLE KEYS */;
/*!40000 ALTER TABLE `compromiso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comunicacion`
--

DROP TABLE IF EXISTS `comunicacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comunicacion` (
  `id_comunicacion` bigint NOT NULL AUTO_INCREMENT,
  `id_donante` bigint NOT NULL,
  `id_tipo_comunicacion` tinyint NOT NULL,
  `canal` varchar(32) DEFAULT NULL,
  `asunto` varchar(150) DEFAULT NULL,
  `contenido` text,
  `fecha_envio` datetime DEFAULT NULL,
  `id_compromiso` bigint DEFAULT NULL,
  `id_evento` bigint DEFAULT NULL,
  `remitente` varchar(120) DEFAULT NULL,
  PRIMARY KEY (`id_comunicacion`),
  KEY `id_donante` (`id_donante`),
  KEY `id_tipo_comunicacion` (`id_tipo_comunicacion`),
  KEY `id_compromiso` (`id_compromiso`),
  KEY `id_evento` (`id_evento`),
  CONSTRAINT `comunicacion_ibfk_1` FOREIGN KEY (`id_donante`) REFERENCES `donante` (`id_donante`),
  CONSTRAINT `comunicacion_ibfk_2` FOREIGN KEY (`id_tipo_comunicacion`) REFERENCES `tipo_comunicacion` (`id_tipo_comunicacion`),
  CONSTRAINT `comunicacion_ibfk_3` FOREIGN KEY (`id_compromiso`) REFERENCES `compromiso` (`id_compromiso`),
  CONSTRAINT `comunicacion_ibfk_4` FOREIGN KEY (`id_evento`) REFERENCES `evento` (`id_evento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comunicacion`
--

LOCK TABLES `comunicacion` WRITE;
/*!40000 ALTER TABLE `comunicacion` DISABLE KEYS */;
/*!40000 ALTER TABLE `comunicacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coordinador_clase`
--

DROP TABLE IF EXISTS `coordinador_clase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coordinador_clase` (
  `id_coordinador_clase` bigint NOT NULL AUTO_INCREMENT,
  `id_anio_clase` smallint NOT NULL,
  `id_persona` bigint NOT NULL,
  `fecha_inicio` date DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  `activo` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id_coordinador_clase`),
  KEY `id_anio_clase` (`id_anio_clase`),
  KEY `id_persona` (`id_persona`),
  CONSTRAINT `coordinador_clase_ibfk_1` FOREIGN KEY (`id_anio_clase`) REFERENCES `anio_clase` (`id_anio_clase`),
  CONSTRAINT `coordinador_clase_ibfk_2` FOREIGN KEY (`id_persona`) REFERENCES `persona` (`id_donante`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coordinador_clase`
--

LOCK TABLES `coordinador_clase` WRITE;
/*!40000 ALTER TABLE `coordinador_clase` DISABLE KEYS */;
/*!40000 ALTER TABLE `coordinador_clase` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `direccion`
--

DROP TABLE IF EXISTS `direccion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `direccion` (
  `id_direccion` bigint NOT NULL AUTO_INCREMENT,
  `id_donante` bigint NOT NULL,
  `tipo` enum('envio','facturacion','otro') DEFAULT NULL,
  `linea1` varchar(120) DEFAULT NULL,
  `linea2` varchar(120) DEFAULT NULL,
  `ciudad` varchar(80) DEFAULT NULL,
  `region` varchar(80) DEFAULT NULL,
  `codigo_postal` varchar(20) DEFAULT NULL,
  `pais` varchar(80) DEFAULT NULL,
  `es_principal` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id_direccion`),
  KEY `id_donante` (`id_donante`),
  CONSTRAINT `direccion_ibfk_1` FOREIGN KEY (`id_donante`) REFERENCES `donante` (`id_donante`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `direccion`
--

LOCK TABLES `direccion` WRITE;
/*!40000 ALTER TABLE `direccion` DISABLE KEYS */;
/*!40000 ALTER TABLE `direccion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `donante`
--

DROP TABLE IF EXISTS `donante`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `donante` (
  `id_donante` bigint NOT NULL AUTO_INCREMENT,
  `tipo_donante` enum('persona','organizacion') NOT NULL,
  `id_grupo_primario` tinyint DEFAULT NULL,
  `estado` enum('potencial','activo','inactivo') DEFAULT 'potencial',
  `fecha_creacion` datetime DEFAULT CURRENT_TIMESTAMP,
  `notas` text,
  PRIMARY KEY (`id_donante`),
  KEY `id_grupo_primario` (`id_grupo_primario`),
  CONSTRAINT `donante_ibfk_1` FOREIGN KEY (`id_grupo_primario`) REFERENCES `grupo_donante` (`id_grupo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `donante`
--

LOCK TABLES `donante` WRITE;
/*!40000 ALTER TABLE `donante` DISABLE KEYS */;
/*!40000 ALTER TABLE `donante` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `evento`
--

DROP TABLE IF EXISTS `evento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `evento` (
  `id_evento` bigint NOT NULL AUTO_INCREMENT,
  `id_campaña` int NOT NULL,
  `id_tipo_evento` tinyint NOT NULL,
  `nombre` varchar(120) NOT NULL,
  `fecha_inicio` date DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  `lugar` varchar(120) DEFAULT NULL,
  PRIMARY KEY (`id_evento`),
  KEY `id_campaña` (`id_campaña`),
  KEY `id_tipo_evento` (`id_tipo_evento`),
  CONSTRAINT `evento_ibfk_1` FOREIGN KEY (`id_campaña`) REFERENCES `campaña` (`id_campaña`),
  CONSTRAINT `evento_ibfk_2` FOREIGN KEY (`id_tipo_evento`) REFERENCES `tipo_evento` (`id_tipo_evento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evento`
--

LOCK TABLES `evento` WRITE;
/*!40000 ALTER TABLE `evento` DISABLE KEYS */;
/*!40000 ALTER TABLE `evento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grupo_donante`
--

DROP TABLE IF EXISTS `grupo_donante`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `grupo_donante` (
  `id_grupo` tinyint NOT NULL AUTO_INCREMENT,
  `codigo` varchar(32) NOT NULL,
  `nombre` varchar(64) NOT NULL,
  PRIMARY KEY (`id_grupo`),
  UNIQUE KEY `codigo` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grupo_donante`
--

LOCK TABLES `grupo_donante` WRITE;
/*!40000 ALTER TABLE `grupo_donante` DISABLE KEYS */;
/*!40000 ALTER TABLE `grupo_donante` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `llamada`
--

DROP TABLE IF EXISTS `llamada`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `llamada` (
  `id_llamada` bigint NOT NULL AUTO_INCREMENT,
  `id_evento` bigint DEFAULT NULL,
  `nombre_llamador` varchar(120) DEFAULT NULL,
  `id_donante_destino` bigint NOT NULL,
  `fecha_hora` datetime DEFAULT NULL,
  `id_resultado` tinyint DEFAULT NULL,
  `id_compromiso` bigint DEFAULT NULL,
  `notas` text,
  PRIMARY KEY (`id_llamada`),
  KEY `id_evento` (`id_evento`),
  KEY `id_donante_destino` (`id_donante_destino`),
  KEY `id_resultado` (`id_resultado`),
  KEY `id_compromiso` (`id_compromiso`),
  CONSTRAINT `llamada_ibfk_1` FOREIGN KEY (`id_evento`) REFERENCES `evento` (`id_evento`),
  CONSTRAINT `llamada_ibfk_2` FOREIGN KEY (`id_donante_destino`) REFERENCES `donante` (`id_donante`),
  CONSTRAINT `llamada_ibfk_3` FOREIGN KEY (`id_resultado`) REFERENCES `resultado_llamada` (`id_resultado`),
  CONSTRAINT `llamada_ibfk_4` FOREIGN KEY (`id_compromiso`) REFERENCES `compromiso` (`id_compromiso`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `llamada`
--

LOCK TABLES `llamada` WRITE;
/*!40000 ALTER TABLE `llamada` DISABLE KEYS */;
/*!40000 ALTER TABLE `llamada` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `membresia_grupo_donante`
--

DROP TABLE IF EXISTS `membresia_grupo_donante`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `membresia_grupo_donante` (
  `id_donante` bigint NOT NULL,
  `id_grupo` tinyint NOT NULL,
  `es_primario` tinyint(1) DEFAULT '0',
  `detalle` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_donante`,`id_grupo`),
  KEY `id_grupo` (`id_grupo`),
  CONSTRAINT `membresia_grupo_donante_ibfk_1` FOREIGN KEY (`id_donante`) REFERENCES `donante` (`id_donante`),
  CONSTRAINT `membresia_grupo_donante_ibfk_2` FOREIGN KEY (`id_grupo`) REFERENCES `grupo_donante` (`id_grupo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `membresia_grupo_donante`
--

LOCK TABLES `membresia_grupo_donante` WRITE;
/*!40000 ALTER TABLE `membresia_grupo_donante` DISABLE KEYS */;
/*!40000 ALTER TABLE `membresia_grupo_donante` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `metodo_pago`
--

DROP TABLE IF EXISTS `metodo_pago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `metodo_pago` (
  `id_metodo` tinyint NOT NULL AUTO_INCREMENT,
  `codigo` varchar(32) NOT NULL,
  `nombre` varchar(64) NOT NULL,
  PRIMARY KEY (`id_metodo`),
  UNIQUE KEY `codigo` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metodo_pago`
--

LOCK TABLES `metodo_pago` WRITE;
/*!40000 ALTER TABLE `metodo_pago` DISABLE KEYS */;
/*!40000 ALTER TABLE `metodo_pago` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organizacion`
--

DROP TABLE IF EXISTS `organizacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `organizacion` (
  `id_donante` bigint NOT NULL,
  `razon_social` varchar(150) NOT NULL,
  `contacto` varchar(120) DEFAULT NULL,
  `correo` varchar(120) DEFAULT NULL,
  `telefono` varchar(30) DEFAULT NULL,
  `sitio_web` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id_donante`),
  CONSTRAINT `organizacion_ibfk_1` FOREIGN KEY (`id_donante`) REFERENCES `donante` (`id_donante`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organizacion`
--

LOCK TABLES `organizacion` WRITE;
/*!40000 ALTER TABLE `organizacion` DISABLE KEYS */;
/*!40000 ALTER TABLE `organizacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pago`
--

DROP TABLE IF EXISTS `pago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pago` (
  `id_pago` bigint NOT NULL AUTO_INCREMENT,
  `id_compromiso` bigint NOT NULL,
  `fecha` date DEFAULT NULL,
  `monto` decimal(12,2) DEFAULT NULL,
  `id_metodo` tinyint DEFAULT NULL,
  `referencia` varchar(100) DEFAULT NULL,
  `recibido_por` varchar(120) DEFAULT NULL,
  PRIMARY KEY (`id_pago`),
  KEY `id_compromiso` (`id_compromiso`),
  KEY `id_metodo` (`id_metodo`),
  CONSTRAINT `pago_ibfk_1` FOREIGN KEY (`id_compromiso`) REFERENCES `compromiso` (`id_compromiso`),
  CONSTRAINT `pago_ibfk_2` FOREIGN KEY (`id_metodo`) REFERENCES `metodo_pago` (`id_metodo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pago`
--

LOCK TABLES `pago` WRITE;
/*!40000 ALTER TABLE `pago` DISABLE KEYS */;
/*!40000 ALTER TABLE `pago` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `persona`
--

DROP TABLE IF EXISTS `persona`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `persona` (
  `id_donante` bigint NOT NULL,
  `nombre` varchar(60) NOT NULL,
  `apellido` varchar(60) NOT NULL,
  `correo` varchar(120) DEFAULT NULL,
  `telefono` varchar(30) DEFAULT NULL,
  `id_anio_clase` smallint DEFAULT NULL,
  `id_empleador` bigint DEFAULT NULL,
  `nombre_conyuge` varchar(120) DEFAULT NULL,
  `id_empleador_conyuge` bigint DEFAULT NULL,
  PRIMARY KEY (`id_donante`),
  KEY `id_anio_clase` (`id_anio_clase`),
  KEY `id_empleador` (`id_empleador`),
  KEY `id_empleador_conyuge` (`id_empleador_conyuge`),
  CONSTRAINT `persona_ibfk_1` FOREIGN KEY (`id_donante`) REFERENCES `donante` (`id_donante`),
  CONSTRAINT `persona_ibfk_2` FOREIGN KEY (`id_anio_clase`) REFERENCES `anio_clase` (`id_anio_clase`),
  CONSTRAINT `persona_ibfk_3` FOREIGN KEY (`id_empleador`) REFERENCES `organizacion` (`id_donante`),
  CONSTRAINT `persona_ibfk_4` FOREIGN KEY (`id_empleador_conyuge`) REFERENCES `organizacion` (`id_donante`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `persona`
--

LOCK TABLES `persona` WRITE;
/*!40000 ALTER TABLE `persona` DISABLE KEYS */;
/*!40000 ALTER TABLE `persona` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `programa_matching`
--

DROP TABLE IF EXISTS `programa_matching`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `programa_matching` (
  `id_programa` bigint NOT NULL AUTO_INCREMENT,
  `id_org` bigint NOT NULL,
  `proporcion` decimal(6,2) DEFAULT NULL,
  `monto_max` decimal(12,2) DEFAULT NULL,
  `monto_min` decimal(12,2) DEFAULT NULL,
  `notas` text,
  PRIMARY KEY (`id_programa`),
  KEY `id_org` (`id_org`),
  CONSTRAINT `programa_matching_ibfk_1` FOREIGN KEY (`id_org`) REFERENCES `organizacion` (`id_donante`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `programa_matching`
--

LOCK TABLES `programa_matching` WRITE;
/*!40000 ALTER TABLE `programa_matching` DISABLE KEYS */;
/*!40000 ALTER TABLE `programa_matching` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resultado_llamada`
--

DROP TABLE IF EXISTS `resultado_llamada`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `resultado_llamada` (
  `id_resultado` tinyint NOT NULL AUTO_INCREMENT,
  `codigo` varchar(32) NOT NULL,
  `nombre` varchar(64) NOT NULL,
  PRIMARY KEY (`id_resultado`),
  UNIQUE KEY `codigo` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resultado_llamada`
--

LOCK TABLES `resultado_llamada` WRITE;
/*!40000 ALTER TABLE `resultado_llamada` DISABLE KEYS */;
/*!40000 ALTER TABLE `resultado_llamada` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_comunicacion`
--

DROP TABLE IF EXISTS `tipo_comunicacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_comunicacion` (
  `id_tipo_comunicacion` tinyint NOT NULL AUTO_INCREMENT,
  `codigo` varchar(32) NOT NULL,
  `nombre` varchar(64) NOT NULL,
  PRIMARY KEY (`id_tipo_comunicacion`),
  UNIQUE KEY `codigo` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_comunicacion`
--

LOCK TABLES `tipo_comunicacion` WRITE;
/*!40000 ALTER TABLE `tipo_comunicacion` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipo_comunicacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_evento`
--

DROP TABLE IF EXISTS `tipo_evento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_evento` (
  `id_tipo_evento` tinyint NOT NULL AUTO_INCREMENT,
  `codigo` varchar(32) NOT NULL,
  `nombre` varchar(64) NOT NULL,
  PRIMARY KEY (`id_tipo_evento`),
  UNIQUE KEY `codigo` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_evento`
--

LOCK TABLES `tipo_evento` WRITE;
/*!40000 ALTER TABLE `tipo_evento` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipo_evento` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-08-21 15:28:02
