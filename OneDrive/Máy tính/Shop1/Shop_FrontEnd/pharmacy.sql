-- MySQL dump 10.13  Distrib 9.4.0, for macos15.4 (arm64)
--
-- Host: localhost    Database: Pharmacy
-- ------------------------------------------------------
-- Server version	9.4.0

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
-- Table structure for table `About_Review`
--

DROP TABLE IF EXISTS `About_Review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `About_Review` (
  `UserId` int NOT NULL,
  `ReviewId` int NOT NULL,
  `ProductId` int DEFAULT NULL,
  PRIMARY KEY (`UserId`,`ReviewId`),
  KEY `ReviewId` (`ReviewId`),
  KEY `ProductId` (`ProductId`),
  CONSTRAINT `About_Review_ibfk_1` FOREIGN KEY (`ReviewId`) REFERENCES `Reviews` (`ReviewId`),
  CONSTRAINT `About_Review_ibfk_2` FOREIGN KEY (`ProductId`) REFERENCES `Product` (`ProductId`)
  ON DELETE CASCADE,
  CONSTRAINT `About_Review_ibfk_3` FOREIGN KEY (`UserId`) REFERENCES `Buyer` (`UserId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `About_Review`
--

LOCK TABLES `About_Review` WRITE;
/*!40000 ALTER TABLE `About_Review` DISABLE KEYS */;
/*!40000 ALTER TABLE `About_Review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Admin`
--

DROP TABLE IF EXISTS `Admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Admin` (
  `UserId` int NOT NULL,
  PRIMARY KEY (`UserId`),
  CONSTRAINT `Admin_ibfk_1` FOREIGN KEY (`UserId`) REFERENCES `User` (`UserId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Admin`
--

LOCK TABLES `Admin` WRITE;
/*!40000 ALTER TABLE `Admin` DISABLE KEYS */;
INSERT INTO `Admin` VALUES (1);
/*!40000 ALTER TABLE `Admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Bank_Card`
--

DROP TABLE IF EXISTS `Bank_Card`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Bank_Card` (
  `PaymentId` int NOT NULL,
  `CardNumber` varchar(30) DEFAULT NULL,
  `FromCompany` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`PaymentId`),
  CONSTRAINT `Bank_Card_ibfk_1` FOREIGN KEY (`PaymentId`) REFERENCES `Payment` (`PaymentId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Bank_Card`
--

LOCK TABLES `Bank_Card` WRITE;
/*!40000 ALTER TABLE `Bank_Card` DISABLE KEYS */;
/*!40000 ALTER TABLE `Bank_Card` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Buyer`
--

DROP TABLE IF EXISTS `Buyer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Buyer` (
  `UserId` int NOT NULL,
  `LoyaltyPoint` int DEFAULT '0',
  PRIMARY KEY (`UserId`),
  CONSTRAINT `Buyer_ibfk_1` FOREIGN KEY (`UserId`) REFERENCES `User` (`UserId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Buyer`
--

LOCK TABLES `Buyer` WRITE;
/*!40000 ALTER TABLE `Buyer` DISABLE KEYS */;
INSERT INTO `Buyer` VALUES (6,0),(8,0),(9,0);
/*!40000 ALTER TABLE `Buyer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Cart`
--

DROP TABLE IF EXISTS `Cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Cart` (
  `CartId` int NOT NULL AUTO_INCREMENT,
  `CreationDate` date DEFAULT NULL,
  `UserId` int NOT NULL,
  PRIMARY KEY (`CartId`),
  KEY `UserId` (`UserId`),
  CONSTRAINT `Cart_ibfk_1` FOREIGN KEY (`UserId`) REFERENCES `User` (`UserId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Cart`
--

LOCK TABLES `Cart` WRITE;
/*!40000 ALTER TABLE `Cart` DISABLE KEYS */;
/*!40000 ALTER TABLE `Cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CartItem`
--

DROP TABLE IF EXISTS `CartItem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CartItem` (
  `CartId` int NOT NULL,
  `CartItemId` int NOT NULL,
  PRIMARY KEY (`CartId`,`CartItemId`),
  CONSTRAINT `CartItem_ibfk_1` FOREIGN KEY (`CartId`) REFERENCES `Cart` (`CartId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CartItem`
--

LOCK TABLES `CartItem` WRITE;
/*!40000 ALTER TABLE `CartItem` DISABLE KEYS */;
/*!40000 ALTER TABLE `CartItem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CartItem_detail`
--

DROP TABLE IF EXISTS `CartItem_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CartItem_detail` (
  `CartId` int NOT NULL,
  `CartItemId` int NOT NULL,
  `ProductId` int NOT NULL,
  `Amount` int DEFAULT NULL,
  PRIMARY KEY (`CartId`,`CartItemId`),
  KEY `ProductId` (`ProductId`),
  CONSTRAINT `CartItem_detail_ibfk_1` FOREIGN KEY (`CartId`, `CartItemId`) REFERENCES `CartItem` (`CartId`, `CartItemId`),
  CONSTRAINT `CartItem_detail_ibfk_2` FOREIGN KEY (`ProductId`) REFERENCES `Product` (`ProductId`)
  ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CartItem_detail`
--

LOCK TABLES `CartItem_detail` WRITE;
/*!40000 ALTER TABLE `CartItem_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `CartItem_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Cash_on_Delivery`
--

DROP TABLE IF EXISTS `Cash_on_Delivery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Cash_on_Delivery` (
  `PaymentId` int NOT NULL,
  PRIMARY KEY (`PaymentId`),
  CONSTRAINT `Cash_on_Delivery_ibfk_1` FOREIGN KEY (`PaymentId`) REFERENCES `Payment` (`PaymentId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Cash_on_Delivery`
--

LOCK TABLES `Cash_on_Delivery` WRITE;
/*!40000 ALTER TABLE `Cash_on_Delivery` DISABLE KEYS */;
/*!40000 ALTER TABLE `Cash_on_Delivery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Category`
--

DROP TABLE IF EXISTS `Category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Category` (
  `CategoryId` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) DEFAULT NULL,
  `Description` text,
  PRIMARY KEY (`CategoryId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Category`
--

LOCK TABLES `Category` WRITE;
/*!40000 ALTER TABLE `Category` DISABLE KEYS */;
INSERT INTO `Category` VALUES (1,'Pain Relief & Anti-inflammatory','For short-term disease'),(2,'Antibiotic & Allergy','For long-term disease');
/*!40000 ALTER TABLE `Category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Create_Promotion`
--

DROP TABLE IF EXISTS `Create_Promotion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Create_Promotion` (
  `UserId` int DEFAULT NULL,
  `PromoId` int NOT NULL,
  `ProductId` int NOT NULL,
  PRIMARY KEY (`PromoId`,`ProductId`),
  KEY `ProductId` (`ProductId`),
  KEY `UserId` (`UserId`),
  CONSTRAINT `Create_Promotion_ibfk_1` FOREIGN KEY (`PromoId`) REFERENCES `Promotion` (`PromoId`),
  CONSTRAINT `Create_Promotion_ibfk_2` FOREIGN KEY (`ProductId`) REFERENCES `Product` (`ProductId`)
  ON DELETE CASCADE,
  CONSTRAINT `Create_Promotion_ibfk_3` FOREIGN KEY (`UserId`) REFERENCES `Sales_Manager` (`UserId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Create_Promotion`
--

LOCK TABLES `Create_Promotion` WRITE;
/*!40000 ALTER TABLE `Create_Promotion` DISABLE KEYS */;
INSERT INTO `Create_Promotion` VALUES (10,1,3),(10,2,4),(10,3,3),(10,3,4),(10,3,5),(10,3,6);
/*!40000 ALTER TABLE `Create_Promotion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `EWallet`
--

DROP TABLE IF EXISTS `EWallet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `EWallet` (
  `PaymentId` int NOT NULL,
  `WalletNumber` varchar(30) DEFAULT NULL,
  `FromCompany` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`PaymentId`),
  CONSTRAINT `EWallet_ibfk_1` FOREIGN KEY (`PaymentId`) REFERENCES `Payment` (`PaymentId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EWallet`
--

LOCK TABLES `EWallet` WRITE;
/*!40000 ALTER TABLE `EWallet` DISABLE KEYS */;
/*!40000 ALTER TABLE `EWallet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Order`
--

DROP TABLE IF EXISTS `Order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Order` (
  `OrderId` int NOT NULL AUTO_INCREMENT,
  `Status` varchar(50) DEFAULT NULL,
  `OrderDate` date DEFAULT NULL,
  `UserId` int NOT NULL,
  PRIMARY KEY (`OrderId`),
  KEY `UserId` (`UserId`),
  CONSTRAINT `Order_ibfk_1` FOREIGN KEY (`UserId`) REFERENCES `User` (`UserId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Order`
--

LOCK TABLES `Order` WRITE;
/*!40000 ALTER TABLE `Order` DISABLE KEYS */;
/*!40000 ALTER TABLE `Order` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_increase_stock_on_cancel` AFTER UPDATE ON `Order` FOR EACH ROW BEGIN
    IF OLD.Status <> 'Cancelled' AND NEW.Status = 'Cancelled' THEN
        UPDATE Product
        SET Stock = Stock + (
            SELECT IFNULL(SUM(OAD.Quantity), 0)
            FROM Order_are_Detail AS OAD
            JOIN OrderDetail AS OD ON OD.OrdDetail_id = OAD.OrdDetail_id
            WHERE OD.OrderId = NEW.OrderId
              AND OAD.ProductId = Product.ProductId
        )
        WHERE Product.ProductId IN (
            SELECT OAD.ProductId
            FROM Order_are_Detail AS OAD
            JOIN OrderDetail AS OD ON OD.OrdDetail_id = OAD.OrdDetail_id
            WHERE OD.OrderId = NEW.OrderId
        );
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `OrderDetail`
--

DROP TABLE IF EXISTS `OrderDetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `OrderDetail` (
  `OrdDetail_id` int NOT NULL,
  `OrderId` int NOT NULL,
  PRIMARY KEY (`OrdDetail_id`,`OrderId`),
  KEY `OrderId` (`OrderId`),
  CONSTRAINT `OrderDetail_ibfk_1` FOREIGN KEY (`OrderId`) REFERENCES `Order` (`OrderId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OrderDetail`
--

LOCK TABLES `OrderDetail` WRITE;
/*!40000 ALTER TABLE `OrderDetail` DISABLE KEYS */;
/*!40000 ALTER TABLE `OrderDetail` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_decrease_stock_after_order` AFTER INSERT ON `OrderDetail` FOR EACH ROW BEGIN
    UPDATE Product
    SET Stock = Stock - (
        SELECT IFNULL(SUM(OAD.Quantity), 0)
        FROM Order_are_Detail AS OAD
        WHERE OAD.OrdDetail_id = NEW.OrdDetail_id
          AND OAD.ProductId = Product.ProductId
    )
    WHERE Product.ProductId IN (
        SELECT ProductId
        FROM Order_are_Detail
        WHERE OrdDetail_id = NEW.OrdDetail_id
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Order_are_Detail`
--

DROP TABLE IF EXISTS `Order_are_Detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Order_are_Detail` (
  `OrdDetail_id` int NOT NULL,
  `OrderId` int NOT NULL,
  `ProductId` int NOT NULL,
  `Quantity` int DEFAULT NULL,
  PRIMARY KEY (`OrdDetail_id`,`OrderId`,`ProductId`),
  KEY `ProductId` (`ProductId`),
  CONSTRAINT `Order_are_Detail_ibfk_1` FOREIGN KEY (`OrdDetail_id`, `OrderId`) REFERENCES `OrderDetail` (`OrdDetail_id`, `OrderId`),
  CONSTRAINT `Order_are_Detail_ibfk_2` FOREIGN KEY (`ProductId`) REFERENCES `Product` (`ProductId`)
  ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Order_are_Detail`
--

LOCK TABLES `Order_are_Detail` WRITE;
/*!40000 ALTER TABLE `Order_are_Detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `Order_are_Detail` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_check_null_before_insert` BEFORE INSERT ON `Order_are_Detail` FOR EACH ROW BEGIN
    IF NEW.ProductId IS NULL OR NEW.Quantity IS NULL OR NEW.OrdDetail_id IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: Missing required value (ProductId, Quantity, or OrdDetail_id cannot be NULL)';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_check_stock_before_insert` BEFORE INSERT ON `Order_are_Detail` FOR EACH ROW BEGIN
    DECLARE current_stock INT;

    SELECT Stock INTO current_stock
    FROM Product
    WHERE ProductId = NEW.ProductId;

    IF current_stock IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: Product does not exist.';
    ELSEIF NEW.Quantity > current_stock THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: Ordered quantity exceeds available stock.';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_update_total_after_order_change` AFTER INSERT ON `Order_are_Detail` FOR EACH ROW BEGIN
    UPDATE `Order`
    SET TotalAmount = (
        SELECT SUM(OAD.Quantity * P.Price)
        FROM Order_are_Detail AS OAD
        JOIN Product AS P ON OAD.ProductId = P.ProductId
        JOIN OrderDetail AS OD ON OAD.OrdDetail_id = OD.OrdDetail_id
        WHERE OD.OrderId = (
            SELECT OrderId FROM OrderDetail WHERE OrdDetail_id = NEW.OrdDetail_id LIMIT 1
        )
    )
    WHERE OrderId = (
        SELECT OrderId FROM OrderDetail WHERE OrdDetail_id = NEW.OrdDetail_id LIMIT 1
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Order_with_Shipment`
--

DROP TABLE IF EXISTS `Order_with_Shipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Order_with_Shipment` (
  `ShipmentId` int NOT NULL,
  `OrderId` int NOT NULL,
  PRIMARY KEY (`ShipmentId`),
  KEY `OrderId` (`OrderId`),
  CONSTRAINT `Order_with_Shipment_ibfk_1` FOREIGN KEY (`ShipmentId`) REFERENCES `Shipment` (`ShipmentId`),
  CONSTRAINT `Order_with_Shipment_ibfk_2` FOREIGN KEY (`OrderId`) REFERENCES `Order` (`OrderId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Order_with_Shipment`
--

LOCK TABLES `Order_with_Shipment` WRITE;
/*!40000 ALTER TABLE `Order_with_Shipment` DISABLE KEYS */;
/*!40000 ALTER TABLE `Order_with_Shipment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Organize_in_category`
--

DROP TABLE IF EXISTS `Organize_in_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Organize_in_category` (
  `ProductId` int NOT NULL,
  `CategoryId` int NOT NULL,
  PRIMARY KEY (`ProductId`),
  KEY `CategoryId` (`CategoryId`),
  CONSTRAINT `Organize_in_category_ibfk_1` FOREIGN KEY (`ProductId`) REFERENCES `Product` (`ProductId`)
  ON DELETE CASCADE,
  CONSTRAINT `Organize_in_category_ibfk_2` FOREIGN KEY (`CategoryId`) REFERENCES `Category` (`CategoryId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Organize_in_category`
--

LOCK TABLES `Organize_in_category` WRITE;
/*!40000 ALTER TABLE `Organize_in_category` DISABLE KEYS */;
INSERT INTO `Organize_in_category` VALUES (3,1),(4,1),(5,2),(6,2);
/*!40000 ALTER TABLE `Organize_in_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Payment`
--

DROP TABLE IF EXISTS `Payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Payment` (
  `PaymentId` int NOT NULL AUTO_INCREMENT,
  `PayDate` date DEFAULT NULL,
  `Amount` decimal(10,2) DEFAULT NULL,
  `Status` varchar(50) DEFAULT NULL,
  `Creation_Date` date DEFAULT NULL,
  PRIMARY KEY (`PaymentId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Payment`
--

LOCK TABLES `Payment` WRITE;
/*!40000 ALTER TABLE `Payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `Payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Product`
--

DROP TABLE IF EXISTS `Product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Product` (
  `ProductId` int NOT NULL AUTO_INCREMENT,
  `Price` decimal(10,2) DEFAULT NULL,
  `Name` varchar(50) DEFAULT NULL,
  `Stock` int DEFAULT NULL,
  `Description` text,
  PRIMARY KEY (`ProductId`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Product`
--

LOCK TABLES `Product` WRITE;
/*!40000 ALTER TABLE `Product` DISABLE KEYS */;
INSERT INTO `Product` VALUES (3,20000.00,'Paracetamol',500,'A common pain reliever and fever reducer. Used to treat headaches, muscle aches, arthritis, backache, and fever caused by infections.'),(4,30000.00,'Amoxicillin',231,'A broad-spectrum antibiotic used to treat bacterial infections such as pneumonia, ear infections, urinary tract infections, and throat infections.'),(5,123000.00,'Ibuprofen',321,'A nonsteroidal anti-inflammatory drug (NSAID) that helps reduce fever, pain, and inflammation. Commonly used for menstrual cramps, headaches, and arthritis.'),(6,50000.00,'Loratadine',200,'An antihistamine used to relieve allergy symptoms such as runny nose, sneezing, and itchy or watery eyes. It does not usually cause drowsiness.');
/*!40000 ALTER TABLE `Product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Promotion`
--

DROP TABLE IF EXISTS `Promotion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Promotion` (
  `PromoId` int NOT NULL AUTO_INCREMENT,
  `Type` varchar(50) DEFAULT NULL,
  `StartPeriod` date DEFAULT NULL,
  `EndPeriod` date DEFAULT NULL,
  `Value` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`PromoId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Promotion`
--

LOCK TABLES `Promotion` WRITE;
/*!40000 ALTER TABLE `Promotion` DISABLE KEYS */;
INSERT INTO `Promotion` VALUES (1,'Discount','2025-10-12','2026-10-12',40000.00),(2,'Discount','2025-09-14','2015-12-02',60000.00),(3,'FirstUser','2025-08-12','2025-12-31',80000.00);
/*!40000 ALTER TABLE `Promotion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Refer_Id`
--

DROP TABLE IF EXISTS `Refer_Id`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Refer_Id` (
  `Referee_Id` int NOT NULL,
  `Referrer_Id` int NOT NULL,
  `ReferDate` date DEFAULT NULL,
  `ReferredId` int DEFAULT NULL,
  PRIMARY KEY (`Referee_Id`),
  KEY `Referrer_Id` (`Referrer_Id`),
  CONSTRAINT `Refer_Id_ibfk_1` FOREIGN KEY (`Referee_Id`) REFERENCES `Buyer` (`UserId`),
  CONSTRAINT `Refer_Id_ibfk_2` FOREIGN KEY (`Referrer_Id`) REFERENCES `Buyer` (`UserId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Refer_Id`
--

LOCK TABLES `Refer_Id` WRITE;
/*!40000 ALTER TABLE `Refer_Id` DISABLE KEYS */;
/*!40000 ALTER TABLE `Refer_Id` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Report`
--

DROP TABLE IF EXISTS `Report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Report` (
  `ReportId` int NOT NULL AUTO_INCREMENT,
  `Content` text,
  `ReportType` varchar(50) DEFAULT NULL,
  `CreationDate` date NOT NULL,
  `UserId` int NOT NULL,
  PRIMARY KEY (`ReportId`),
  KEY `UserId` (`UserId`),
  CONSTRAINT `Report_ibfk_1` FOREIGN KEY (`UserId`) REFERENCES `Admin` (`UserId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Report`
--

LOCK TABLES `Report` WRITE;
/*!40000 ALTER TABLE `Report` DISABLE KEYS */;
/*!40000 ALTER TABLE `Report` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Reviews`
--

DROP TABLE IF EXISTS `Reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Reviews` (
  `ReviewId` int NOT NULL AUTO_INCREMENT,
  `Rating` int DEFAULT NULL,
  `Content` text,
  PRIMARY KEY (`ReviewId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Reviews`
--

LOCK TABLES `Reviews` WRITE;
/*!40000 ALTER TABLE `Reviews` DISABLE KEYS */;
/*!40000 ALTER TABLE `Reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Sales_Manager`
--

DROP TABLE IF EXISTS `Sales_Manager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Sales_Manager` (
  `UserId` int NOT NULL,
  PRIMARY KEY (`UserId`),
  CONSTRAINT `Sales_Manager_ibfk_1` FOREIGN KEY (`UserId`) REFERENCES `User` (`UserId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Sales_Manager`
--

LOCK TABLES `Sales_Manager` WRITE;
/*!40000 ALTER TABLE `Sales_Manager` DISABLE KEYS */;
INSERT INTO `Sales_Manager` VALUES (10);
/*!40000 ALTER TABLE `Sales_Manager` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Shipment`
--

DROP TABLE IF EXISTS `Shipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Shipment` (
  `ShipmentId` int NOT NULL AUTO_INCREMENT,
  `ShippingDate` date DEFAULT NULL,
  `Status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ShipmentId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Shipment`
--

LOCK TABLES `Shipment` WRITE;
/*!40000 ALTER TABLE `Shipment` DISABLE KEYS */;
/*!40000 ALTER TABLE `Shipment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Shipment_Third_Party`
--

DROP TABLE IF EXISTS `Shipment_Third_Party`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Shipment_Third_Party` (
  `ShipmentId` int NOT NULL,
  `ThirdPartyId` int NOT NULL,
  `ShipperId` int DEFAULT NULL,
  PRIMARY KEY (`ShipmentId`),
  KEY `ThirdPartyId` (`ThirdPartyId`),
  CONSTRAINT `Shipment_Third_Party_ibfk_1` FOREIGN KEY (`ShipmentId`) REFERENCES `Shipment` (`ShipmentId`),
  CONSTRAINT `Shipment_Third_Party_ibfk_2` FOREIGN KEY (`ThirdPartyId`) REFERENCES `ThirdParty` (`ThirdPartyId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Shipment_Third_Party`
--

LOCK TABLES `Shipment_Third_Party` WRITE;
/*!40000 ALTER TABLE `Shipment_Third_Party` DISABLE KEYS */;
/*!40000 ALTER TABLE `Shipment_Third_Party` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ThirdParty`
--

DROP TABLE IF EXISTS `ThirdParty`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ThirdParty` (
  `ThirdPartyId` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) DEFAULT NULL,
  `Website` varchar(255) DEFAULT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `ContactInfo` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ThirdPartyId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ThirdParty`
--

LOCK TABLES `ThirdParty` WRITE;
/*!40000 ALTER TABLE `ThirdParty` DISABLE KEYS */;
INSERT INTO `ThirdParty` VALUES (1,'giaohangtietkiem','giaohangtietkiem.com','so 3 ton that tung','Phone number'),(2,'viettel fast','viettel.com.vn','district 1','Phone number');
/*!40000 ALTER TABLE `ThirdParty` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ThirdParty_Hotline`
--

DROP TABLE IF EXISTS `ThirdParty_Hotline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ThirdParty_Hotline` (
  `ThirdPartyId` int NOT NULL,
  `AHotline` varchar(20) NOT NULL,
  PRIMARY KEY (`ThirdPartyId`,`AHotline`),
  CONSTRAINT `ThirdParty_Hotline_ibfk_1` FOREIGN KEY (`ThirdPartyId`) REFERENCES `ThirdParty` (`ThirdPartyId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ThirdParty_Hotline`
--

LOCK TABLES `ThirdParty_Hotline` WRITE;
/*!40000 ALTER TABLE `ThirdParty_Hotline` DISABLE KEYS */;
INSERT INTO `ThirdParty_Hotline` VALUES (1,'02223334445'),(1,'09998887763'),(2,'04448882229');
/*!40000 ALTER TABLE `ThirdParty_Hotline` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `User` (
  `UserId` int NOT NULL AUTO_INCREMENT,
  `Dob` date DEFAULT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `Fname` varchar(50) DEFAULT NULL,
  `Lname` varchar(50) DEFAULT NULL,
  `Email` varchar(50) DEFAULT NULL,
  `Username` varchar(50) NOT NULL,
  `HashedPassword` varchar(255) NOT NULL,
  PRIMARY KEY (`UserId`),
  UNIQUE KEY `Username` (`Username`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User`
--

LOCK TABLES `User` WRITE;
/*!40000 ALTER TABLE `User` DISABLE KEYS */;
INSERT INTO `User` VALUES (1,'2004-10-12','District 1','Pham Van','A','PhamVanA@gmail.com','phamvanA','pbkdf2:sha256:1000000$PCnqJwz8TftaVpDt$8b8943e9e60886f53162b458dab7f01abd5f811970d3fc3665c67af68742fef6'),(6,'2003-02-04','District 2','Nguyen Van ','B','nguyenvanB@gmail.com','nguyenvanB','scrypt:32768:8:1$s6SD91HR3zYVEDMf$bb42f866734b039949a56d5a54ae22d0c6bb575b86b1eb321cb45b666c552d8483bb1998dd9b8d1fd0548906a3e19cabac38a24d70817ca514dd920e2d746839'),(8,'1998-11-12','District 5','Tao Khai ','E','taokhaiE@gmail.com','taokhaiE','scrypt:32768:8:1$fLwcIoiS20DDSZgV$b1da6a460167a6dc67b817c2b0edf145b57a96f21d347b4676a57f034077b21c332f095dd1932d6f47994349b425b11cf31ed9458f4fd8805a2ac33fa20f60de'),(9,'2005-01-12','District 7','Pham Quang','Minh','chien@gmail.com','phamMinh123','pbkdf2:sha256:1000000$mx7x6k1p724LGqKt$621466d4d83d42c37887c5fa66fc7c6d74291cc597f3c7ffcd024e5a15ba2c5f'),(10,'2007-10-15','Binh Tan District','Nguyễn Anh','Thư','minh.phamquang1201@hcmut.edu.vn','jasmineNg','pbkdf2:sha256:1000000$dPFObiFisR2UV8Lu$164ecaef7adca8b4bfa1293a7e4e586954638361b2f642b92ef92d79ee622e20');
/*!40000 ALTER TABLE `User` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `check_duplicate_username` BEFORE INSERT ON `User` FOR EACH ROW begin 
	if exists (select 1 from User where Username = New.Username) then
	SIGNAL SQLSTATE '45000'
	set MESSAGE_TEXT = "Tên đăng nhập đã có, chọn tên ";
	end if;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `check_age_before_add_to_user` BEFORE INSERT ON `User` FOR EACH ROW BEGIN
    DECLARE age INT;

    -- Tính tuổi
    SET age = TIMESTAMPDIFF(YEAR, NEW.Dob, CURDATE());

    -- Kiểm tra nếu < 18 tuổi thì báo lỗi
    IF age < 18 or age > 94 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Tuổi không hợp lệ.';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `UserPhone`
--

DROP TABLE IF EXISTS `UserPhone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UserPhone` (
  `UserId` int NOT NULL,
  `APhoneNumber` varchar(20) NOT NULL,
  PRIMARY KEY (`UserId`,`APhoneNumber`),
  CONSTRAINT `UserPhone_ibfk_1` FOREIGN KEY (`UserId`) REFERENCES `User` (`UserId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UserPhone`
--

LOCK TABLES `UserPhone` WRITE;
/*!40000 ALTER TABLE `UserPhone` DISABLE KEYS */;
INSERT INTO `UserPhone` VALUES (1,'0901234567'),(6,'0912345678'),(8,'0934567890'),(10,'0999999999');
/*!40000 ALTER TABLE `UserPhone` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_check_phone_before_insert` BEFORE INSERT ON `UserPhone` FOR EACH ROW BEGIN
    -- Kiểm tra độ dài khác 10
    IF CHAR_LENGTH(NEW.APhoneNumber) <> 10 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Phone number must have exactly 10 digits.';
    END IF;

    -- Kiểm tra ký tự đầu tiên có phải là '0'
    IF LEFT(NEW.APhoneNumber, 1) <> '0' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Phone number must start with 0.';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping events for database 'Pharmacy'
--

--
-- Dumping routines for database 'Pharmacy'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-08 10:25:50