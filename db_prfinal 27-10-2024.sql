CREATE DATABASE  IF NOT EXISTS `db_prfinal` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `db_prfinal`;
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: db_prfinal
-- ------------------------------------------------------
-- Server version	8.0.37

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
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `id_cliente` int NOT NULL AUTO_INCREMENT,
  `nombres` varchar(60) DEFAULT NULL,
  `apellidos` varchar(60) DEFAULT NULL,
  `nit` varchar(12) DEFAULT NULL,
  `genero` bit(1) DEFAULT NULL,
  `telefono` varchar(25) DEFAULT NULL,
  `correo_electronico` varchar(100) DEFAULT NULL,
  `fecha_ingreso` datetime DEFAULT NULL,
  PRIMARY KEY (`id_cliente`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (1,'Alfredo','Molina','23564512',_binary '','1223564','alfredo@gmail.com','2000-01-01 00:00:00'),(2,'Guillermo','Florencio','785421326',_binary '','8754412','Guillermo@gmail.com','1999-10-15 00:00:00'),(4,'Servicios Pesados','Inmuebles','78451232',_binary '','8956451','ServiPesa2dos23@gmail.com','2024-10-12 01:33:06');
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compras`
--

DROP TABLE IF EXISTS `compras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `compras` (
  `id_compra` int NOT NULL AUTO_INCREMENT,
  `no_orden_compra` int DEFAULT NULL,
  `id_proveedores` int DEFAULT NULL,
  `fecha_orden` date DEFAULT NULL,
  `fecha_ingreso` datetime DEFAULT NULL,
  `estado` int NOT NULL,
  PRIMARY KEY (`id_compra`),
  CONSTRAINT `idProveedores_compras_idProveedores_proveedores` FOREIGN KEY (`id_compra`) REFERENCES `proveedores` (`id_proveedores`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compras`
--

LOCK TABLES `compras` WRITE;
/*!40000 ALTER TABLE `compras` DISABLE KEYS */;
INSERT INTO `compras` VALUES (1,50,2,'2024-10-23',NULL,1),(2,2,1,'2024-10-24','2024-10-24 23:44:23',1);
/*!40000 ALTER TABLE `compras` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compras_detalle`
--

DROP TABLE IF EXISTS `compras_detalle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `compras_detalle` (
  `id_compra_detalle` bigint NOT NULL AUTO_INCREMENT,
  `id_compra` int DEFAULT NULL,
  `id_producto` int DEFAULT NULL,
  `cantidad` int DEFAULT NULL,
  `precio_costo_unitario` decimal(8,2) DEFAULT NULL,
  PRIMARY KEY (`id_compra_detalle`),
  KEY `idCompra_compras_detalle_idCompras_compras_idx` (`id_compra`),
  KEY `idProducto_compras_detalle_idProducto_productos_idx` (`id_producto`),
  CONSTRAINT `idCompra_compras_detalle_idCompras_compras` FOREIGN KEY (`id_compra`) REFERENCES `compras` (`id_compra`) ON UPDATE CASCADE,
  CONSTRAINT `idProducto_compras_detalle_idProducto_productos` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compras_detalle`
--

LOCK TABLES `compras_detalle` WRITE;
/*!40000 ALTER TABLE `compras_detalle` DISABLE KEYS */;
INSERT INTO `compras_detalle` VALUES (1,1,3,1,100.00),(2,2,1,1,1.00);
/*!40000 ALTER TABLE `compras_detalle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empleados`
--

DROP TABLE IF EXISTS `empleados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empleados` (
  `id_empleados` int NOT NULL AUTO_INCREMENT,
  `nombres` varchar(60) DEFAULT NULL,
  `apellidos` varchar(60) DEFAULT NULL,
  `direccion` varchar(80) DEFAULT NULL,
  `telefono` varchar(25) DEFAULT NULL,
  `dpi` varchar(15) DEFAULT NULL,
  `estado` int NOT NULL,
  `genero` bit(1) DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `id_puesto` smallint DEFAULT NULL,
  `fecha_inicio_labores` date DEFAULT NULL,
  `fecha_ingreso` datetime DEFAULT NULL,
  PRIMARY KEY (`id_empleados`),
  KEY `idPuesto_empleados_idPuesto_puestos_idx` (`id_puesto`),
  CONSTRAINT `idPuesto_empleados_idPuesto_puestos` FOREIGN KEY (`id_puesto`) REFERENCES `puestos` (`id_puesto`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleados`
--

LOCK TABLES `empleados` WRITE;
/*!40000 ALTER TABLE `empleados` DISABLE KEYS */;
INSERT INTO `empleados` VALUES (1,'carlos','ramirez','ciudad','98745632','304799250116',0,_binary '','1995-01-01',1,'2020-01-15','2020-01-15 00:00:00'),(2,'Manuel ','Figueroa','peten','12345678','209078950015',0,_binary '','1994-01-10',2,'2020-05-01','2020-05-15 00:00:00'),(5,'Julia','Morales','Mixco','96857412','209078990114',1,_binary '\0','1994-01-10',1,'2020-05-01','2020-05-15 00:00:00'),(6,'Karen','Herrera','Guatemala','78451223','785412236545',1,_binary '\0','1994-01-10',14,'2021-12-10','2021-12-10 00:00:00'),(8,'Keren','Suarez','Mexico','23564512','9865322154',1,_binary '\0','1999-09-07',1,'2023-06-13','2023-06-13 00:00:00'),(10,'Sofia','Gonzales','Argentina','89562312','8745122365',1,_binary '\0','1999-11-18',9,'2024-10-12','2024-10-12 00:00:00'),(11,'Juan Carlos','Figeroa','Guatemala','54562312','1122335566',1,_binary '','2002-06-12',14,'2023-07-10','2023-07-10 00:00:00'),(12,'Maria','Sofrano','Mexico','9856231','32565421457',1,_binary '\0','2002-02-12',23,'2023-08-23','2023-08-23 00:00:00'),(13,'Sobran','Guiller','Mexico','23451231','32565421457',1,_binary '\0','2024-10-11',1,'2024-10-11','2024-10-11 00:00:00'),(14,'Juan','Perez','Guatemala','12345678','1234567890123',1,_binary '','2024-10-11',2,'2024-10-11','2024-10-11 00:00:00'),(15,'Pedro','Lopez','Mexico','23456789','2345678901234',0,_binary '','2024-10-11',3,'2024-10-11','2024-10-11 00:00:00'),(16,'Maria','Gomez','El Salvador','34567890','3456789012345',1,_binary '\0','2024-10-11',5,'2024-10-11','2024-10-11 00:00:00'),(17,'Ana','Martinez','Honduras','45678901','4567890123456',1,_binary '\0','2024-10-11',6,'2024-10-11','2024-10-11 00:00:00'),(18,'Luis','Rodriguez','Nicaragua','56789012','5678901234567',1,_binary '','2024-10-11',7,'2024-10-11','2024-10-11 00:00:00'),(19,'Carmen','Hernandez','Costa Rica','67890123','6789012345678',1,_binary '\0','2024-10-11',9,'2024-10-11','2024-10-11 00:00:00'),(20,'Carlos','Fernandez','Panama','78901234','7890123456789',1,_binary '','2024-10-11',8,'2024-10-11','2024-10-11 00:00:00'),(21,'Sofia','Garcia','Colombia','89012345','8901234567890',1,_binary '\0','2024-10-11',10,'2024-10-11','2024-10-11 00:00:00'),(22,'Miguel','Diaz','Peru','90123456','9012345678901',1,_binary '','2024-10-11',12,'2024-10-11','2024-10-11 00:00:00'),(23,'Lucia','Morales','Chile','11223344','1122334455667',1,_binary '\0','2024-10-11',13,'2024-10-11','2024-10-11 00:00:00'),(24,'Jorge','Vargas','Argentina','22334455','2233445566778',1,_binary '','2024-10-11',15,'2024-10-11','2024-10-11 00:00:00'),(25,'Laura','Torres','Uruguay','33445566','3344556677889',1,_binary '\0','2024-10-11',14,'2024-10-11','2024-10-11 00:00:00'),(26,'Fernando','Gutierrez','Paraguay','44556677','4455667788990',1,_binary '','2024-10-11',11,'2024-10-11','2024-10-11 00:00:00'),(27,'Paula','Ramos','Brasil','55667788','5566778899001',1,_binary '\0','2024-10-11',3,'2024-10-11','2024-10-11 00:00:00'),(28,'Andres','Mendez','Venezuela','66778899','6677889900112',1,_binary '','2024-10-11',2,'2024-10-11','2024-10-11 00:00:00'),(29,'Isabel','Romero','Bolivia','77889900','7788990011223',1,_binary '\0','2024-10-11',1,'2024-10-11','2024-10-11 00:00:00'),(30,'Diego','Sanchez','Ecuador','88990011','8899001122334',1,_binary '','2024-10-11',5,'2024-10-11','2024-10-11 00:00:00'),(31,'Sara','Castro','Cuba','99001122','9900112233445',1,_binary '\0','2024-10-11',6,'2024-10-11','2024-10-11 00:00:00'),(32,'Ricardo','Ortiz','Republica Dominicana','10111213','1011121314156',1,_binary '','2024-10-11',7,'2024-10-11','2024-10-11 00:00:00'),(33,'Victoria','Ramirez','Puerto Rico','12131415','1213141516177',1,_binary '\0','2024-10-11',7,'2024-10-11','2024-10-11 00:00:00'),(34,'Alberto','Vega','Espana','13141516','1314151617188',1,_binary '','2024-10-11',8,'2024-10-11','2024-10-11 00:00:00'),(35,'Claudia','Reyes','Portugal','14151617','1415161718199',1,_binary '\0','2024-10-11',9,'2024-10-11','2024-10-11 00:00:00'),(36,'Francisco','Flores','Italia','15161718','1516171819200',1,_binary '','2024-10-11',9,'2024-10-11','2024-10-11 00:00:00'),(37,'Elena','Navarro','Francia','16171819','1617181920211',1,_binary '\0','2024-10-11',12,'2024-10-11','2024-10-11 00:00:00'),(38,'Pablo','Cruz','Alemania','17181920','1718192021222',1,_binary '','2024-10-11',12,'2024-10-11','2024-10-11 00:00:00'),(39,'Marta','Molina','Inglaterra','18192021','1819202122233',1,_binary '\0','2024-10-11',12,'2024-10-11','2024-10-11 00:00:00'),(40,'Guillermo','Delgado','Belgica','19202122','1920212223244',1,_binary '','2024-10-11',13,'2024-10-11','2024-10-11 00:00:00'),(41,'Beatriz','Figueroa','Holanda','20212223','2021222324255',1,_binary '\0','2024-10-11',2,'2024-10-11','2024-10-11 00:00:00'),(42,'Adrian','Escobar','Suiza','21222324','2122232425266',1,_binary '','2024-10-11',1,'2024-10-11','2024-10-11 00:00:00'),(43,'Natalia','Paredes','Suecia','22232425','2223242526277',1,_binary '\0','2024-10-11',1,'2024-10-11','2024-10-11 00:00:00'),(44,'Daniel','Campos','Noruega','23242526','2324252627288',1,_binary '','2024-10-11',4,'2024-10-11','2024-10-11 00:00:00'),(45,'Patricia','Rojas','Finlandia','24252627','2425262728299',1,_binary '\0','2024-10-11',5,'2024-10-11','2024-10-11 00:00:00'),(46,'Oscar','Jimenez','Dinamarca','25262728','2526272830300',1,_binary '','2024-10-11',6,'2024-10-11','2024-10-11 00:00:00'),(47,'Monica','Rivas','Irlanda','26272829','2627282931311',1,_binary '\0','2024-10-11',7,'2024-10-11','2024-10-11 00:00:00'),(48,'Eduardo','Valdez','Escocia','27282930','2728293032322',1,_binary '','2024-10-08',8,'2024-10-08','2024-10-08 00:00:00'),(49,'Valeria','Soto','Grecia','28293031','2829303133333',1,_binary '\0','2024-10-11',9,'2024-10-12','2024-10-12 00:00:00'),(50,'Javier','Zamora','Turquia','29303132','2930313234344',1,_binary '','2024-10-25',10,'2024-10-25','2024-10-25 00:00:00'),(51,'Carolina','Salazar','Rusia','30313233','3031323335355',1,_binary '\0','2024-10-18',11,'2024-10-18','2024-10-18 00:00:00'),(52,'Sergio','Herrera','Guatemala','31323334','7845122334567',1,_binary '','2024-10-11',12,'2024-10-11','2024-10-11 00:00:00'),(53,'Angela','Avila','Mexico','32333435','3233343536376',1,_binary '\0','2024-10-24',13,'2024-10-24','2024-10-24 00:00:00'),(54,'Roberto','Cortes','El Salvador','33343536','3334353637387',1,_binary '','2024-10-11',14,'2024-10-11','2024-10-11 00:00:00'),(55,'Clara','Ibanez','Honduras','34353637','3435363738398',1,_binary '\0','2024-10-11',1,'2024-10-11','2024-10-11 00:00:00'),(56,'Manuel','Silva','Nicaragua','35363738','3536373839409',1,_binary '','2024-10-11',2,'2024-10-11','2024-10-11 00:00:00'),(57,'Raquel','Pacheco','Costa Rica','36373839','3637383940410',1,_binary '\0','2024-10-11',6,'2024-10-11','2024-10-11 00:00:00'),(58,'Alfonso','Aguirre','Panama','37383940','3738394041421',1,_binary '','2024-10-17',3,'2024-10-17','2024-10-17 00:00:00'),(59,'Alicia','Mejia','Colombia','38394041','3839404142432',1,_binary '\0','2024-10-18',4,'2024-10-18','2024-10-18 00:00:00'),(60,'Ivan','Ruiz','Peru','39404142','3940414243443',1,_binary '','2024-10-11',5,'2024-10-11','2024-10-11 00:00:00'),(61,'Cristina','Serrano','Chile','40414243','4041424344454',1,_binary '\0','2024-10-11',6,'2024-10-11','2024-10-11 00:00:00'),(62,'Karen','Herrera','Guatemala','78451223','7854123456789',1,_binary '\0','2024-10-11',7,'2021-12-10','2021-12-10 00:00:00'),(63,'Carlos','Osorio','Guatemala','89564512','2345562312',1,_binary '','1993-07-15',6,'2024-10-25','2024-10-25 18:19:16'),(64,'Maritza','Solis','Mexico','23564512','65231245',1,_binary '\0','1994-12-26',23,'2024-10-25','2024-10-25 18:34:08');
/*!40000 ALTER TABLE `empleados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genero`
--

DROP TABLE IF EXISTS `genero`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `genero` (
  `id_genero` int NOT NULL,
  `genero` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_genero`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genero`
--

LOCK TABLES `genero` WRITE;
/*!40000 ALTER TABLE `genero` DISABLE KEYS */;
INSERT INTO `genero` VALUES (0,'Femenino'),(1,'Masculino');
/*!40000 ALTER TABLE `genero` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `marcas`
--

DROP TABLE IF EXISTS `marcas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `marcas` (
  `id_marca` smallint NOT NULL AUTO_INCREMENT,
  `marca` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_marca`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `marcas`
--

LOCK TABLES `marcas` WRITE;
/*!40000 ALTER TABLE `marcas` DISABLE KEYS */;
INSERT INTO `marcas` VALUES (1,'Toyota'),(2,'Mazda'),(3,'Honda'),(4,'Subaru'),(5,'Lexus'),(7,'BMW');
/*!40000 ALTER TABLE `marcas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `id_padre` int DEFAULT NULL,
  `nivel` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_padre` (`id_padre`),
  CONSTRAINT `menu_ibfk_1` FOREIGN KEY (`id_padre`) REFERENCES `menu` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `new_table`
--

DROP TABLE IF EXISTS `new_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `new_table` (
  `idnew_table` varchar(60) NOT NULL,
  `new_tablecol` varchar(45) DEFAULT NULL,
  `new_tablecol1` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idnew_table`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `new_table`
--

LOCK TABLES `new_table` WRITE;
/*!40000 ALTER TABLE `new_table` DISABLE KEYS */;
/*!40000 ALTER TABLE `new_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productos`
--

DROP TABLE IF EXISTS `productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productos` (
  `id_producto` int NOT NULL AUTO_INCREMENT,
  `producto` varchar(50) DEFAULT NULL,
  `id_marca` smallint DEFAULT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  `imagen` varchar(3000) DEFAULT NULL,
  `precio_costo` decimal(8,2) DEFAULT NULL,
  `precio_venta` decimal(8,2) DEFAULT NULL,
  `existencia` int DEFAULT NULL,
  `fecha_ingreso` datetime DEFAULT NULL,
  PRIMARY KEY (`id_producto`),
  KEY `idMarca_productos_idMarca_marcas_idx` (`id_marca`),
  CONSTRAINT `idMarca_productos_idMarca_marcas` FOREIGN KEY (`id_marca`) REFERENCES `marcas` (`id_marca`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos`
--

LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` VALUES (1,'Toyota',1,'Toyota','uploads/Toyota rav 4 2016.jpg',150000.00,155000.00,1,'2024-10-12 16:18:48'),(2,'SUV',5,'Lexus','uploads/lexus- UX SUV.jpg',120000.00,123000.00,2,'2024-10-12 16:18:58'),(3,'Honda 2023',3,'Honda sedan 2023','uploads/Honda.jpg',80000.00,85000.00,4,'2024-10-12 21:37:41'),(4,'BMW M3 2021',7,'BMW M3 2021','uploads/Bmw.jpg',190000.00,200000.00,2,'2024-10-12 21:38:50');
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proveedores`
--

DROP TABLE IF EXISTS `proveedores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proveedores` (
  `id_proveedores` int NOT NULL AUTO_INCREMENT,
  `proveedor` varchar(60) DEFAULT NULL,
  `nit` varchar(12) DEFAULT NULL,
  `direccion` varchar(80) DEFAULT NULL,
  `telefono` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id_proveedores`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proveedores`
--

LOCK TABLES `proveedores` WRITE;
/*!40000 ALTER TABLE `proveedores` DISABLE KEYS */;
INSERT INTO `proveedores` VALUES (1,'Toyota','23654512','Bolivia','78542145'),(2,'Mazda','89564512','Guatemala','23564521'),(3,'Mitsubishi','78541232','Mexico','87541223'),(4,'Subaru','87451254','Guatemala','89451223'),(5,'Honda','98651232','Mexico','32654124'),(6,'Lexus','54562312','Japon','78456531');
/*!40000 ALTER TABLE `proveedores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `puestos`
--

DROP TABLE IF EXISTS `puestos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `puestos` (
  `id_puesto` smallint NOT NULL AUTO_INCREMENT,
  `puesto` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`id_puesto`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `puestos`
--

LOCK TABLES `puestos` WRITE;
/*!40000 ALTER TABLE `puestos` DISABLE KEYS */;
INSERT INTO `puestos` VALUES (1,'programador'),(2,'soporte tecnico'),(3,'Analista de Implementaciones'),(4,'Analista de Implementaciones II'),(5,'QA'),(6,'QA Jr'),(7,'Auxiliar Contable'),(8,'Asistente RRHH'),(9,'Gerente de RRHH'),(10,'Gerente de Finanzas'),(11,'Finanzas'),(12,'Dibujante'),(13,'Gestor de Proyectos'),(14,'Encargado de Proyectos'),(15,'Albanil'),(16,'Ayudante'),(17,'Maestro de Obra'),(22,'Cuantificador de presupuesto'),(23,'Conserje');
/*!40000 ALTER TABLE `puestos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id_rol` int NOT NULL AUTO_INCREMENT,
  `roles` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_rol`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Admin'),(2,'Bodega'),(3,'Ventas'),(4,'Encargado de bodega'),(5,'Asistente Administrativo');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id_usuarios` int NOT NULL AUTO_INCREMENT,
  `usuario` varchar(45) DEFAULT NULL,
  `nombres` varchar(45) DEFAULT NULL,
  `apellidos` varchar(45) DEFAULT NULL,
  `correo_electronico` varchar(45) DEFAULT NULL,
  `contrasena` varchar(45) DEFAULT NULL,
  `id_rol` int DEFAULT NULL,
  PRIMARY KEY (`id_usuarios`),
  KEY `usuarios y roles_idx` (`id_rol`),
  CONSTRAINT `usuarios y roles` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id_rol`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'balvarez','Bryann','Alvarez','balvarez@miumg.edu.gt','soporte25',1);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ventas`
--

DROP TABLE IF EXISTS `ventas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ventas` (
  `id_venta` int NOT NULL AUTO_INCREMENT,
  `no_factura` int NOT NULL,
  `serie` char(1) NOT NULL,
  `fecha_factura` date NOT NULL,
  `estado` varchar(1) DEFAULT NULL,
  `id_cliente` int DEFAULT NULL,
  `id_empleado` int DEFAULT NULL,
  `fecha_ingreso` datetime DEFAULT NULL,
  PRIMARY KEY (`id_venta`),
  KEY `idCliente_ventas_idCliente_clientes_idx` (`id_cliente`),
  KEY `idEmpleado_ventas_idEmpleado_Empleados_idx` (`id_empleado`),
  CONSTRAINT `idCliente_ventas_idCliente_clientes` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`) ON UPDATE CASCADE,
  CONSTRAINT `idEmpleado_ventas_idEmpleado_Empleados` FOREIGN KEY (`id_empleado`) REFERENCES `empleados` (`id_empleados`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ventas`
--

LOCK TABLES `ventas` WRITE;
/*!40000 ALTER TABLE `ventas` DISABLE KEYS */;
INSERT INTO `ventas` VALUES (1,562312457,'1','2024-10-12','0',1,1,'2020-01-15 15:10:33'),(2,565212314,'2','2024-10-12','1',2,10,'2024-10-12 21:20:37'),(3,556212348,'2','2024-10-12','1',4,10,'2024-10-12 21:27:22'),(4,55653122,'3','2024-10-13','0',2,12,'2024-10-12 21:29:54'),(5,2623131,'4','2024-10-25','1',1,54,'2024-10-25 00:40:02'),(6,2123554,'5','2024-10-25','1',2,56,'2024-10-25 16:20:16'),(7,15156,'9','2024-10-26','1',1,44,'2024-10-26 23:44:53');
/*!40000 ALTER TABLE `ventas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ventas_detalle`
--

DROP TABLE IF EXISTS `ventas_detalle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ventas_detalle` (
  `id_venta_detalle` bigint NOT NULL AUTO_INCREMENT,
  `id_venta` int DEFAULT NULL,
  `id_producto` int DEFAULT NULL,
  `cantidad` int DEFAULT NULL,
  `precio_unitario` decimal(8,2) DEFAULT NULL,
  PRIMARY KEY (`id_venta_detalle`),
  KEY `idVenta_ventasDetalle_idVenta_ventas_idx` (`id_venta`),
  KEY `idProducto_productos_idProducto_productos_idx` (`id_producto`),
  CONSTRAINT `idProducto_productos_idProducto_productos` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`) ON UPDATE CASCADE,
  CONSTRAINT `idVenta_ventasDetalle_idVenta_ventas` FOREIGN KEY (`id_venta`) REFERENCES `ventas` (`id_venta`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='	';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ventas_detalle`
--

LOCK TABLES `ventas_detalle` WRITE;
/*!40000 ALTER TABLE `ventas_detalle` DISABLE KEYS */;
INSERT INTO `ventas_detalle` VALUES (1,1,2,1,123000.00),(3,3,1,1,155000.00),(4,4,2,1,130000.00),(5,5,1,1,200.00),(6,6,3,2,1000.00),(7,2,2,3,100.00),(8,7,1,2,1.00);
/*!40000 ALTER TABLE `ventas_detalle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'db_prfinal'
--

--
-- Dumping routines for database 'db_prfinal'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-27  9:30:57
