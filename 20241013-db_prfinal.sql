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
  `idCompra` int NOT NULL AUTO_INCREMENT,
  `noOrdenCompra` int DEFAULT NULL,
  `idProveedores` int DEFAULT NULL,
  `fechaOrden` date DEFAULT NULL,
  `fechaIngreso` datetime DEFAULT NULL,
  PRIMARY KEY (`idCompra`),
  CONSTRAINT `idProveedores_compras_idProveedores_proveedores` FOREIGN KEY (`idCompra`) REFERENCES `proveedores` (`id_proveedores`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compras`
--

LOCK TABLES `compras` WRITE;
/*!40000 ALTER TABLE `compras` DISABLE KEYS */;
/*!40000 ALTER TABLE `compras` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compras_detalle`
--

DROP TABLE IF EXISTS `compras_detalle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `compras_detalle` (
  `idCompraDetalle` bigint NOT NULL AUTO_INCREMENT,
  `idCompra` int DEFAULT NULL,
  `idProducto` int DEFAULT NULL,
  `cantidad` int DEFAULT NULL,
  `precioCostoUnitario` decimal(8,2) DEFAULT NULL,
  PRIMARY KEY (`idCompraDetalle`),
  KEY `idCompra_compras_detalle_idCompras_compras_idx` (`idCompra`),
  KEY `idProducto_compras_detalle_idProducto_productos_idx` (`idProducto`),
  CONSTRAINT `idCompra_compras_detalle_idCompras_compras` FOREIGN KEY (`idCompra`) REFERENCES `compras` (`idCompra`) ON UPDATE CASCADE,
  CONSTRAINT `idProducto_compras_detalle_idProducto_productos` FOREIGN KEY (`idProducto`) REFERENCES `productos` (`id_producto`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compras_detalle`
--

LOCK TABLES `compras_detalle` WRITE;
/*!40000 ALTER TABLE `compras_detalle` DISABLE KEYS */;
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
  `genero` bit(1) DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `id_puesto` smallint DEFAULT NULL,
  `fecha_inicio_labores` date DEFAULT NULL,
  `fecha_ingreso` datetime DEFAULT NULL,
  PRIMARY KEY (`id_empleados`),
  KEY `idPuesto_empleados_idPuesto_puestos_idx` (`id_puesto`),
  CONSTRAINT `idPuesto_empleados_idPuesto_puestos` FOREIGN KEY (`id_puesto`) REFERENCES `puestos` (`id_puesto`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleados`
--

LOCK TABLES `empleados` WRITE;
/*!40000 ALTER TABLE `empleados` DISABLE KEYS */;
INSERT INTO `empleados` VALUES (1,'carlos','ramirez','ciudad','98745632','304799250116',_binary '','1995-01-01',1,'2020-01-15','2020-01-15 00:00:00'),(2,'Manuel ','Figueroa','peten','12345678','209078950015',_binary '','1994-01-10',2,'2020-05-01','2020-05-15 00:00:00'),(3,'Julia','Morales','Mixco','96857412','209078990114',_binary '\0','1994-01-10',1,'2020-05-01','2020-05-15 00:00:00'),(4,'Karen','Herrera','Guatemala','78451223','785412236545',_binary '\0','1994-01-10',14,'2021-12-10','2021-12-10 00:00:00'),(5,'Keren','Suarez','Mexico','23564512','9865322154',_binary '\0','1999-09-07',1,'2023-06-13','2023-06-13 00:00:00'),(6,'Sofia','Gonzales','Argentina','89562312','8745122365',_binary '\0','1999-11-18',9,'2024-10-12','2024-10-12 00:00:00'),(7,'Juan Carlos','Figeroa','Guatemala','54562312','1122335566',_binary '','2002-06-12',14,'2023-07-10','2023-07-10 00:00:00'),(8,'Maria','Sofrano','Mexico','9856231','32565421457',_binary '\0','2002-02-12',23,'2023-08-23','2023-08-23 00:00:00'),(9,'Karen','Herrera','Guatemala','78451223','785412236545',_binary '\0','1994-01-10',14,'2021-12-10','2021-12-10 00:00:00'),(10,'Bryan ','Garcia','villa canales','74125896','7412589634567',_binary '','1999-01-01',3,'2022-01-01','2022-01-01 00:00:00'),(11,'Elias','Garcia','san miguel petapa','74125896','7412589634568',_binary '','1999-01-01',3,'2022-01-01','2022-01-01 00:00:00'),(12,'Joel','Cotzajay','san miguel petapa','74125746','7412587634568',_binary '','1989-01-01',5,'2022-01-01','2022-01-01 00:00:00');
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
INSERT INTO `productos` VALUES (1,'Toyota',1,'Toyota','uploads/Toyota rav 4 2016.jpg',150000.00,155000.00,3,'2024-10-12 16:18:48'),(2,'SUV',5,'Lexus','uploads/lexus- UX SUV.jpg',120000.00,123000.00,2,'2024-10-12 16:18:58'),(3,'Honda 2023',3,'Honda sedan 2023','uploads/Honda.jpg',80000.00,85000.00,4,'2024-10-12 21:37:41'),(4,'BMW M3 2021',7,'BMW M3 2021','uploads/Bmw.jpg',190000.00,200000.00,2,'2024-10-12 21:38:50');
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
  `id_cliente` int DEFAULT NULL,
  `id_empleado` int DEFAULT NULL,
  `fecha_ingreso` datetime DEFAULT NULL,
  PRIMARY KEY (`id_venta`),
  KEY `idCliente_ventas_idCliente_clientes_idx` (`id_cliente`),
  KEY `idEmpleado_ventas_idEmpleado_Empleados_idx` (`id_empleado`),
  CONSTRAINT `idCliente_ventas_idCliente_clientes` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`) ON UPDATE CASCADE,
  CONSTRAINT `idEmpleado_ventas_idEmpleado_Empleados` FOREIGN KEY (`id_empleado`) REFERENCES `empleados` (`id_empleados`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ventas`
--

LOCK TABLES `ventas` WRITE;
/*!40000 ALTER TABLE `ventas` DISABLE KEYS */;
INSERT INTO `ventas` VALUES (1,562312457,'1','2024-10-12',1,1,'2020-01-15 15:10:33'),(2,565212314,'2','2024-10-12',2,6,'2024-10-12 21:20:37'),(3,556212348,'2','2024-10-12',4,6,'2024-10-12 21:27:22'),(4,55653122,'3','2024-10-13',2,8,'2024-10-12 21:29:54');
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='	';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ventas_detalle`
--

LOCK TABLES `ventas_detalle` WRITE;
/*!40000 ALTER TABLE `ventas_detalle` DISABLE KEYS */;
INSERT INTO `ventas_detalle` VALUES (1,1,2,1,123000.00),(3,3,1,1,155000.00),(4,4,2,1,130000.00);
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

-- Dump completed on 2024-10-13 20:43:23
