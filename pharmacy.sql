-- MySQL dump 10.13  Distrib 9.4.0, for macos15.4 (arm64)
--
-- Host: 127.0.0.1    Database: Pharmacy
-- ------------------------------------------------------
-- Server version	8.0.43

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
  CONSTRAINT `About_Review_ibfk_2` FOREIGN KEY (`ProductId`) REFERENCES `Product` (`ProductId`),
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Cart`
--

LOCK TABLES `Cart` WRITE;
/*!40000 ALTER TABLE `Cart` DISABLE KEYS */;
INSERT INTO `Cart` VALUES (3,'2025-11-14',6);
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
INSERT INTO `CartItem` VALUES (3,1);
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CartItem_detail`
--

LOCK TABLES `CartItem_detail` WRITE;
/*!40000 ALTER TABLE `CartItem_detail` DISABLE KEYS */;
INSERT INTO `CartItem_detail` VALUES (3,1,3,2);
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
  CONSTRAINT `Create_Promotion_ibfk_2` FOREIGN KEY (`ProductId`) REFERENCES `Product` (`ProductId`),
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
  `TotalAmount` decimal(10,2) NOT NULL COMMENT 'The total price for this line item (Quantity * Price at time of purchase)',
  PRIMARY KEY (`OrdDetail_id`,`OrderId`,`ProductId`),
  KEY `ProductId` (`ProductId`),
  CONSTRAINT `Order_are_Detail_ibfk_1` FOREIGN KEY (`OrdDetail_id`, `OrderId`) REFERENCES `OrderDetail` (`OrdDetail_id`, `OrderId`),
  CONSTRAINT `Order_are_Detail_ibfk_2` FOREIGN KEY (`ProductId`) REFERENCES `Product` (`ProductId`)
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_decrease_stock_after_order` AFTER INSERT ON `Order_are_Detail` FOR EACH ROW BEGIN
    UPDATE Product
    -- SET Stock = Stock - (
    --     SELECT IFNULL(SUM(OAD.Quantity), 0)
    --     FROM Order_are_Detail AS OAD
    --     WHERE OAD.OrdDetail_id = NEW.OrdDetail_id
    --       AND OAD.ProductId = Product.ProductId
    -- )
    SET Stock = Stock - NEW.Quantity
    -- WHERE Product.ProductId IN (
    --     SELECT ProductId
    --     FROM Order_are_Detail
    --     WHERE OrdDetail_id = NEW.OrdDetail_id
    -- );
    WHERE ProductId = NEW.ProductId;
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
  CONSTRAINT `Organize_in_category_ibfk_1` FOREIGN KEY (`ProductId`) REFERENCES `Product` (`ProductId`),
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
  `OrderId` int NOT NULL,
  PRIMARY KEY (`PaymentId`),
  KEY `fk_Payment_Order_idx` (`OrderId`),
  CONSTRAINT `fk_Payment_Order` FOREIGN KEY (`OrderId`) REFERENCES `Order` (`OrderId`)
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
-- Temporary view structure for view `vw_TopBuyers`
--

DROP TABLE IF EXISTS `vw_TopBuyers`;
/*!50001 DROP VIEW IF EXISTS `vw_TopBuyers`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_TopBuyers` AS SELECT 
 1 AS `UserId`,
 1 AS `TotalSpent`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_TopProducts`
--

DROP TABLE IF EXISTS `vw_TopProducts`;
/*!50001 DROP VIEW IF EXISTS `vw_TopProducts`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_TopProducts` AS SELECT 
 1 AS `ProductId`,
 1 AS `TotalSold`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_TopSellingProducts`
--

DROP TABLE IF EXISTS `vw_TopSellingProducts`;
/*!50001 DROP VIEW IF EXISTS `vw_TopSellingProducts`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_TopSellingProducts` AS SELECT 
 1 AS `ProductId`,
 1 AS `Name`,
 1 AS `TotalSold`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'Pharmacy'
--

--
-- Dumping routines for database 'Pharmacy'
--
--
-- WARNING: can't read the INFORMATION_SCHEMA.libraries table. It's most probably an old server 8.0.43.
--
--
-- WARNING: can't read the INFORMATION_SCHEMA.libraries table. It's most probably an old server 8.0.43.
--
/*!50003 DROP FUNCTION IF EXISTS `fn_CountProductByCategory` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `fn_CountProductByCategory`(catId INT) RETURNS int
    READS SQL DATA
BEGIN
    DECLARE cnt INT;
    
    -- MODIFIED: Join with 'Organize_in_category'
    -- The 'Product' table no longer has a 'CategoryId' column.
    SELECT COUNT(*) INTO cnt 
    FROM `Product` p
    JOIN `Organize_in_category` oic ON p.ProductId = oic.ProductId
    WHERE oic.CategoryId = catId;
    
    RETURN cnt;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
--
-- WARNING: can't read the INFORMATION_SCHEMA.libraries table. It's most probably an old server 8.0.43.
--
/*!50003 DROP FUNCTION IF EXISTS `fn_GetFinalProductPrice` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `fn_GetFinalProductPrice`(
    p_ProductId INT
) RETURNS decimal(10,2)
    READS SQL DATA
BEGIN
    DECLARE v_BasePrice DECIMAL(10,2);
    DECLARE v_PromoType VARCHAR(50);
    DECLARE v_PromoValue DECIMAL(10,2);
    DECLARE v_FinalPrice DECIMAL(10,2);

    -- 1. Get the base price
    SELECT Price INTO v_BasePrice FROM Product WHERE ProductId = p_ProductId;
    SET v_FinalPrice = v_BasePrice; -- Default to base price

    -- 2. Find an active promotion for this product
    SELECT 
        p.Type, p.Value
    INTO v_PromoType, v_PromoValue
    FROM `Promotion` p
    JOIN `Create_Promotion` cp ON p.PromoId = cp.PromoId
    WHERE 
        cp.ProductId = p_ProductId
        AND NOW() BETWEEN p.StartPeriod AND p.EndPeriod -- Check if promo is active
    LIMIT 1; -- Get the first active promo (nếu có nhiều)

    -- 3. Calculate final price if a promo was found
    IF v_PromoType IS NOT NULL THEN
        IF v_PromoType = 'PERCENT' THEN
            -- Giảm theo % (Vd: Value = 10.00 nghĩa là giảm 10%)
            SET v_FinalPrice = v_BasePrice * (1 - (v_PromoValue / 100.0));
        ELSEIF v_PromoType = 'FIXED_AMOUNT' THEN
            -- Giảm tiền cố định (Vd: Value = 10000 nghĩa là giảm 10.000đ)
            SET v_FinalPrice = v_BasePrice - v_PromoValue;
        END IF;
        
        -- Ensure price doesn't go below zero
        IF v_FinalPrice < 0 THEN
            SET v_FinalPrice = 0;
        END IF;
    END IF;

    RETURN v_FinalPrice;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
--
-- WARNING: can't read the INFORMATION_SCHEMA.libraries table. It's most probably an old server 8.0.43.
--
/*!50003 DROP FUNCTION IF EXISTS `fn_LoyaltyLevel` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `fn_LoyaltyLevel`(buyerId INT) RETURNS varchar(20) CHARSET utf8mb4
    READS SQL DATA
BEGIN
    DECLARE points INT;
    DECLARE level VARCHAR(20);
    SELECT LoyaltyPoint INTO points FROM Buyer WHERE UserId = buyerId;

    IF points >= 100 THEN
        SET level = 'Gold';
    ELSEIF points >= 50 THEN
        SET level = 'Silver';
    ELSE
        SET level = 'Bronze';
    END IF;

    RETURN level;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
--
-- WARNING: can't read the INFORMATION_SCHEMA.libraries table. It's most probably an old server 8.0.43.
--
/*!50003 DROP FUNCTION IF EXISTS `fn_TotalSpentByBuyer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `fn_TotalSpentByBuyer`(buyerId INT) RETURNS decimal(12,2)
    READS SQL DATA
BEGIN
    DECLARE total DECIMAL(12,2);
    
    -- MODIFIED: Must join the multi-table 'Order' structure
    SELECT IFNULL(SUM(oad.TotalAmount), 0)
    INTO total
    FROM `Order_are_Detail` oad
    JOIN `OrderDetail` od ON oad.OrdDetail_id = od.OrdDetail_id AND oad.OrderId = od.OrderId
    JOIN `Order` o ON od.OrderId = o.OrderId
    WHERE o.UserId = buyerId; -- UserId is on the 'Order' table
    
    RETURN total;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
--
-- WARNING: can't read the INFORMATION_SCHEMA.libraries table. It's most probably an old server 8.0.43.
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_AddBankPayment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_AddBankPayment`(
    IN p_OrderId INT,
    IN p_Amount DECIMAL(10,2),
    IN p_CardNumber VARCHAR(30),
    IN p_FromCompany VARCHAR(100)
)
BEGIN
    DECLARE v_PaymentId INT;
    START TRANSACTION;
    
    -- Insert into parent table
    INSERT INTO Payment (OrderId, Amount, PayDate, Status)
    VALUES (p_OrderId, p_Amount, NOW(), 'Completed');
    
    SET v_PaymentId = LAST_INSERT_ID();
    
    -- Insert into child table
    INSERT INTO Bank_Card (PaymentId, CardNumber, FromCompany)
    VALUES (v_PaymentId, p_CardNumber, p_FromCompany);
    
    -- Update order status --
    UPDATE `Order`
        SET `Status` = 'Completed'
        WHERE `OrderId` = p_OrderId;
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
--
-- WARNING: can't read the INFORMATION_SCHEMA.libraries table. It's most probably an old server 8.0.43.
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_AddCashPayment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_AddCashPayment`(
    IN p_OrderId INT,
    IN p_Amount DECIMAL(10,2)
)
BEGIN
    DECLARE v_PaymentId INT;
    START TRANSACTION;
    
    INSERT INTO Payment (OrderId, Amount, PayDate, Status)
    VALUES (p_OrderId, p_Amount, NOW(), 'Pending'); -- Status là 'Pending' cho COD
    
    SET v_PaymentId = LAST_INSERT_ID();
    
    INSERT INTO Cash_on_Delivery (PaymentId)
    VALUES (v_PaymentId);
    
    COMMIT;
END ;;
DELIMITER ;
DELIMITER //

-- 1. Tạo sp_GetAllProducts
-- Lấy tất cả sản phẩm, liên kết qua bảng trung gian Organize_in_category
CREATE PROCEDURE sp_GetAllProducts()
BEGIN
    SELECT 
        P.ProductId, 
        P.Name, 
        P.Price, 
        P.Stock, 
        P.Description, 
        OIC.CategoryId
    FROM 
        Product P
    JOIN 
        Organize_in_category OIC ON P.ProductId = OIC.ProductId;
END//

-- 2. Tạo sp_GetProductsByCategory
-- Lấy sản phẩm theo CategoryId
CREATE PROCEDURE sp_GetProductsByCategory(IN p_CategoryId INT)
BEGIN
    SELECT 
        P.ProductId, 
        P.Name, 
        P.Price, 
        P.Stock, 
        P.Description, 
        OIC.CategoryId 
    FROM 
        Product P
    JOIN 
        Organize_in_category OIC ON P.ProductId = OIC.ProductId
    WHERE 
        OIC.CategoryId = p_CategoryId;
END//

-- Khôi phục DELIMITER về mặc định
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
--
-- WARNING: can't read the INFORMATION_SCHEMA.libraries table. It's most probably an old server 8.0.43.
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_AddEWalletPayment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_AddEWalletPayment`(
    IN p_OrderId INT,
    IN p_Amount DECIMAL(10,2),
    IN p_WalletNumber VARCHAR(30),
    IN p_FromCompany VARCHAR(100)
)
BEGIN
    DECLARE v_PaymentId INT;
    START TRANSACTION;
    
    INSERT INTO Payment (OrderId, Amount, PayDate, Status)
    VALUES (p_OrderId, p_Amount, NOW(), 'Completed');
    
    SET v_PaymentId = LAST_INSERT_ID();
    
    INSERT INTO EWallet (PaymentId, WalletNumber, FromCompany)
    VALUES (v_PaymentId, p_WalletNumber, p_FromCompany);
    
    -- Update order status --
    UPDATE `Order`
        SET `Status` = 'Completed'
        WHERE `OrderId` = p_OrderId;
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
--
-- WARNING: can't read the INFORMATION_SCHEMA.libraries table. It's most probably an old server 8.0.43.
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_AddProduct` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_AddProduct`(
    IN p_Name VARCHAR(50),
    IN p_Price DECIMAL(10,2),
    IN p_Stock INT,
    IN p_Desc TEXT,
    IN p_CategoryId INT
)
BEGIN
    DECLARE v_ProductId INT;
    
    -- MODIFIED: Use a transaction to insert into two tables.
    START TRANSACTION;
    
    -- 1. Insert into 'Product' table (which no longer has CategoryId)
    INSERT INTO Product (Name, Price, Stock, Description)
    VALUES (p_Name, p_Price, p_Stock, p_Desc);
    
    -- 2. Get the new ProductId
    SET v_ProductId = LAST_INSERT_ID();
    
    -- 3. Insert the relationship into 'Organize_in_category'
    INSERT INTO Organize_in_category (ProductId, CategoryId)
    VALUES (v_ProductId, p_CategoryId);
    
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
--
-- WARNING: can't read the INFORMATION_SCHEMA.libraries table. It's most probably an old server 8.0.43.
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_AddProductToCart` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER //

-- SP đơn giản, KHÔNG dùng CartItem_detail
CREATE OR REPLACE PROCEDURE sp_AddProductToCart(
    IN p_user_id INT,
    IN p_product_id INT,
    IN p_quantity INT
)
BEGIN
    DECLARE v_cart_id INT;

    -- 1. Lấy CartId hoặc tạo mới
    SELECT CartId INTO v_cart_id FROM Cart WHERE UserId = p_user_id LIMIT 1;

    IF v_cart_id IS NULL THEN
        INSERT INTO Cart (UserId, CreationDate) VALUES (p_user_id, NOW());
        SET v_cart_id = LAST_INSERT_ID();
    END IF;

    -- 2. Kiểm tra nếu sản phẩm đã tồn tại trong CartItem
    SELECT 
        COUNT(*) INTO @v_item_exists 
    FROM 
        CartItem 
    WHERE 
        CartId = v_cart_id AND ProductId = p_product_id;

    IF @v_item_exists > 0 THEN
        -- Cập nhật số lượng (tăng thêm)
        UPDATE CartItem 
        SET Quantity = Quantity + p_quantity
        WHERE CartId = v_cart_id AND ProductId = p_product_id;
    ELSE
        -- Thêm mới sản phẩm vào CartItem (Giả định CartItem chỉ có khóa chính tự tăng hoặc không cần CartItemId tự định nghĩa)
        INSERT INTO CartItem (CartId, ProductId, Quantity, AddedDate)
        VALUES (v_cart_id, p_product_id, p_quantity, NOW());
    END IF;
END//

DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
--
-- WARNING: can't read the INFORMATION_SCHEMA.libraries table. It's most probably an old server 8.0.43.
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_AddReview` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_AddReview`(
    IN p_UserId INT,
    IN p_ProductId INT,
    IN p_Rating INT,
    IN p_Content TEXT
)
BEGIN
    DECLARE v_ReviewId INT;
    
    -- MODIFIED: Must insert into two tables
    START TRANSACTION;
    
    -- 1. Insert into the parent 'Reviews' table
    INSERT INTO Reviews (Rating, Content)
    VALUES (p_Rating, p_Content);
    
    -- 2. Get the new ReviewId
    SET v_ReviewId = LAST_INSERT_ID();
    
    -- 3. Insert into the child 'About_Review' linking table
    INSERT INTO About_Review (UserId, ReviewId, ProductId)
    VALUES (p_UserId, v_ReviewId, p_ProductId);
    
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
--
-- WARNING: can't read the INFORMATION_SCHEMA.libraries table. It's most probably an old server 8.0.43.
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_AddShipment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_AddShipment`(
    IN p_OrderId INT,
    IN p_Status VARCHAR(50),
    IN p_ThirdPartyId INT,
    IN p_ShipperId INT
)
BEGIN
    DECLARE v_ShipmentId INT;

    -- MODIFIED: Must insert into three tables
    START TRANSACTION;
    
    -- 1. Create the parent 'Shipment' record
    -- (The 'Shipment' table does NOT have OrderId)
    INSERT INTO Shipment (ShippingDate, Status)
    VALUES (NOW(), p_Status);
    
    -- 2. Get the new ShipmentId
    SET v_ShipmentId = LAST_INSERT_ID();
    
    -- 3. Create the specialization record
    INSERT INTO Shipment_Third_Party (ShipmentId, ThirdPartyId, ShipperId)
    VALUES (v_ShipmentId, p_ThirdPartyId, p_ShipperId);
    
    -- 4. Create the link back to the Order
    INSERT INTO Order_with_Shipment (ShipmentId, OrderId)
    VALUES (v_ShipmentId, p_OrderId);
    
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
--
-- WARNING: can't read the INFORMATION_SCHEMA.libraries table. It's most probably an old server 8.0.43.
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_AddThirdParty` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_AddThirdParty`(
    IN p_Name VARCHAR(100),
    IN p_Website VARCHAR(255),
    IN p_Address VARCHAR(255),
    IN p_ContactInfo VARCHAR(255)
)
BEGIN
    INSERT INTO ThirdParty (Name, Website, Address, ContactInfo)
    VALUES (p_Name, p_Website, p_Address, p_ContactInfo);
END ;;
DELIMITER ;
DELIMITER //

CREATE PROCEDURE sp_AddBuyerAccount(
    IN p_fname VARCHAR(255),
    IN p_lname VARCHAR(255),
    IN p_email VARCHAR(255),
    IN p_username VARCHAR(30),
    IN p_hashed_password VARCHAR(255),
    IN p_dob DATE,
    IN p_address VARCHAR(255)
)
BEGIN
    -- Thêm người dùng mới vào bảng User
    INSERT INTO User (
        Username, 
        Email, 
        HashedPassword, 
        Fname, 
        Lname, 
        Address, 
        Dob
    )
    VALUES (
        p_username, 
        p_email, 
        p_hashed_password, 
        p_fname, 
        p_lname, 
        p_address, 
        p_dob
    );
    
    -- (Có thể thêm logic tạo BuyerRole hoặc kích hoạt tài khoản nếu cần)
    -- Ví dụ, nếu bạn có bảng Buyer, bạn có thể thêm:
    -- INSERT INTO Buyer (UserId) VALUES (LAST_INSERT_ID());

END//

DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
--
-- WARNING: can't read the INFORMATION_SCHEMA.libraries table. It's most probably an old server 8.0.43.
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_AddThirdPartyHotline` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_AddThirdPartyHotline`(
    IN p_ThirdPartyId INT,
    IN p_Hotline VARCHAR(20)
)
BEGIN
    INSERT INTO ThirdParty_Hotline (ThirdPartyId, AHotline)
    VALUES (p_ThirdPartyId, p_Hotline);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
--
-- WARNING: can't read the INFORMATION_SCHEMA.libraries table. It's most probably an old server 8.0.43.
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_AddUserPhone` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_AddUserPhone`(
    IN p_UserId INT,
    IN p_PhoneNumber VARCHAR(20)
)
BEGIN
    INSERT INTO UserPhone (UserId, APhoneNumber)
    VALUES (p_UserId, p_PhoneNumber);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
--
-- WARNING: can't read the INFORMATION_SCHEMA.libraries table. It's most probably an old server 8.0.43.
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_ApplyPromotionToProduct` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_ApplyPromotionToProduct`(
    IN p_SalesManagerId INT,
    IN p_PromoId INT,
    IN p_ProductId INT
)
BEGIN
    -- Check if the user is a Sales Manager
    IF EXISTS (SELECT 1 FROM Sales_Manager WHERE UserId = p_SalesManagerId) THEN
        INSERT INTO Create_Promotion (UserId, PromoId, ProductId)
        VALUES (p_SalesManagerId, p_PromoId, p_ProductId);
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'User is not a Sales Manager';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
--
-- WARNING: can't read the INFORMATION_SCHEMA.libraries table. It's most probably an old server 8.0.43.
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_CreateOrder` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_CreateOrder`(IN p_BuyerId INT)
BEGIN
    DECLARE v_CartId INT;
    DECLARE v_OrderId INT;

    -- Error handling
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK; -- Rollback all changes if any error occurs
        RESIGNAL;
    END;

    -- 1. Find the buyer's cart
    SELECT CartId INTO v_CartId
    FROM Cart
    WHERE UserId = p_BuyerId
    LIMIT 1;

    -- 2. Start the transaction if cart exists and has items
    -- MODIFIED: Check the CartItem table
    IF v_CartId IS NOT NULL AND EXISTS (SELECT 1 FROM CartItem WHERE CartId = v_CartId) THEN
        
        START TRANSACTION;

        -- 3. Create the main Order record
        INSERT INTO `Order` (UserId, OrderDate, Status)
        VALUES (p_BuyerId, NOW(), 'Pending');
        
        SET v_OrderId = LAST_INSERT_ID();

        -- 4. MODIFIED: Copy items from Cart (multi-table) to Order (multi-table)
        
        -- 4a. Insert into OrderDetail (the parent linking table)
        -- We use the CartItemId as the new OrdDetail_id
        INSERT INTO OrderDetail (OrdDetail_id, OrderId)
        SELECT 
            ci.CartItemId, 
            v_OrderId
        FROM CartItem ci
        WHERE ci.CartId = v_CartId;
        
        -- 4b. Insert into Order_are_Detail (the detail table)
        -- We join Product to get the price and "freeze" it in TotalAmount
        INSERT INTO Order_are_Detail (OrdDetail_id, OrderId, ProductId, Quantity, TotalAmount)
        SELECT
            cid.CartItemId,
            v_OrderId,
            cid.ProductId,
            cid.Amount,
            -- TÍNH TOÁN QUAN TRỌNG:
            -- Lấy giá cuối cùng (đã giảm) nhân với số lượng
            -- và "đóng băng" nó vào cột TotalAmount
            (cid.Amount * fn_GetFinalProductPrice(cid.ProductId)) AS CalculatedTotal
        FROM CartItem_detail cid
        -- JOIN Product p ON cid.ProductId = p.ProductId -- No need
        WHERE cid.CartId = v_CartId;

        -- 5. MODIFIED: Clear the cart (child tables first)
        DELETE FROM CartItem_detail WHERE CartId = v_CartId;
        DELETE FROM CartItem WHERE CartId = v_CartId;

        -- 6. Commit the transaction
        COMMIT;
        
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
--
-- WARNING: can't read the INFORMATION_SCHEMA.libraries table. It's most probably an old server 8.0.43.
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_CreatePromotion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_CreatePromotion`(
    IN p_SalesManagerId INT,
    IN p_Type VARCHAR(50),
    IN p_Value DECIMAL(10,2),
    IN p_StartPeriod DATE,
    IN p_EndPeriod DATE
)
BEGIN
    -- Check if the user is actually a Sales Manager
    IF EXISTS (SELECT 1 FROM Sales_Manager WHERE UserId = p_SalesManagerId) THEN
        INSERT INTO Promotion (Type, Value, StartPeriod, EndPeriod)
        VALUES (p_Type, p_Value, p_StartPeriod, p_EndPeriod);
    ELSE
        -- Raise an error if user is not authorized
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'User is not a Sales Manager';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
--
-- WARNING: can't read the INFORMATION_SCHEMA.libraries table. It's most probably an old server 8.0.43.
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_CreateReport` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_CreateReport`(
    IN p_AdminId INT,
    IN p_ReportType VARCHAR(50),
    IN p_Content TEXT
)
BEGIN
    -- Check if the user is an Admin
    IF EXISTS (SELECT 1 FROM Admin WHERE UserId = p_AdminId) THEN
        INSERT INTO Report (Content, ReportType, CreationDate, UserId)
        VALUES (p_Content, p_ReportType, NOW(), p_AdminId);
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'User is not an Admin';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
--
-- WARNING: can't read the INFORMATION_SCHEMA.libraries table. It's most probably an old server 8.0.43.
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_GetCartDetails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_GetCartDetails`(
    IN p_UserId INT
)
BEGIN
    -- MODIFIED: Must join all 4 tables AND use the new Function
    SELECT 
        p.ProductId,
        p.Name,
        p.Price AS OriginalPrice, -- Giá gốc
        fn_GetFinalProductPrice(p.ProductId) AS FinalPrice, -- Giá đã giảm
        cid.Amount,
        (fn_GetFinalProductPrice(p.ProductId) * cid.Amount) AS LineTotal -- Tổng tiền đã giảm
    FROM `Cart` c
    JOIN `CartItem` ci ON c.CartId = ci.CartId
    JOIN `CartItem_detail` cid ON ci.CartId = cid.CartId AND ci.CartItemId = cid.CartItemId
    JOIN `Product` p ON cid.ProductId = p.ProductId
    WHERE c.UserId = p_UserId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
--
-- WARNING: can't read the INFORMATION_SCHEMA.libraries table. It's most probably an old server 8.0.43.
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_GetOrderDetails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_GetOrderDetails`(
    IN p_OrderId INT
)
BEGIN
    -- MODIFIED: Must join the multi-table structure
    -- (Order -> OrderDetail -> Order_are_Detail -> Product)
    SELECT 
        p.ProductId,
        p.Name,
        p.Price AS CurrentProductPrice, -- Giá hiện tại của SP
        oad.Quantity,
        oad.TotalAmount AS LineTotal     -- Giá đã lưu lúc mua hàng
    FROM `OrderDetail` od
    JOIN `Order_are_Detail` oad ON od.OrdDetail_id = oad.OrdDetail_id AND od.OrderId = oad.OrderId
    JOIN `Product` p ON oad.ProductId = p.ProductId
    WHERE od.OrderId = p_OrderId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
--
-- WARNING: can't read the INFORMATION_SCHEMA.libraries table. It's most probably an old server 8.0.43.
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_ProcessReferral` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_ProcessReferral`(
    IN p_RefereeId INT, -- The new user (who was referred)
    IN p_ReferrerId INT -- The existing user (who did the referring)
)
BEGIN
    INSERT INTO Refer_Id (Referee_Id, Referrer_Id, ReferDate)
    VALUES (p_RefereeId, p_ReferrerId, NOW());
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
--
-- WARNING: can't read the INFORMATION_SCHEMA.libraries table. It's most probably an old server 8.0.43.
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_RemoveProductFromCart` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_RemoveProductFromCart`(
    IN p_CartId INT,
    IN p_ProductId INT
)
BEGIN
    DECLARE v_CartItemId INT;
    
    -- MODIFIED: Find CartItemId using ProductId
    SELECT CartItemId INTO v_CartItemId
    FROM `CartItem_detail`
    WHERE `CartId` = p_CartId AND `ProductId` = p_ProductId;

    IF v_CartItemId IS NOT NULL THEN
        -- MODIFIED: Must delete from both tables (child first)
        DELETE FROM `CartItem_detail` WHERE `CartId` = p_CartId AND `CartItemId` = v_CartItemId;
        DELETE FROM `CartItem` WHERE `CartId` = p_CartId AND `CartItemId` = v_CartItemId;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
--
-- WARNING: can't read the INFORMATION_SCHEMA.libraries table. It's most probably an old server 8.0.43.
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_UpdateCartItemQuantity` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_UpdateCartItemQuantity`(
    IN p_CartId INT,
    IN p_ProductId INT,
    IN p_NewQuantity INT
)
BEGIN
    DECLARE v_CartItemId INT;
    
    -- MODIFIED: Find CartItemId using ProductId
    SELECT CartItemId INTO v_CartItemId
    FROM `CartItem_detail`
    WHERE `CartId` = p_CartId AND `ProductId` = p_ProductId;

    IF v_CartItemId IS NOT NULL THEN
        IF p_NewQuantity > 0 THEN
            -- Update quantity if new quantity is positive
            UPDATE `CartItem_detail`
            SET `Amount` = p_NewQuantity
            WHERE `CartId` = p_CartId AND `CartItemId` = v_CartItemId;
        ELSE
            -- Remove item if new quantity is 0 or less
            -- MODIFIED: Must delete from both tables (child first)
            DELETE FROM `CartItem_detail` WHERE `CartId` = p_CartId AND `CartItemId` = v_CartItemId;
            DELETE FROM `CartItem` WHERE `CartId` = p_CartId AND `CartItemId` = v_CartItemId;
        END IF;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
--
-- WARNING: can't read the INFORMATION_SCHEMA.libraries table. It's most probably an old server 8.0.43.
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_UpdateOrderStatus` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_UpdateOrderStatus`(
    IN p_OrderId INT,
    IN p_NewStatus VARCHAR(50)
)
BEGIN
    UPDATE `Order`
    SET `Status` = p_NewStatus
    WHERE `OrderId` = p_OrderId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `vw_TopBuyers`
--

/*!50001 DROP VIEW IF EXISTS `vw_TopBuyers`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_TopBuyers` AS select `b`.`UserId` AS `UserId`,ifnull(sum(`oad`.`TotalAmount`),0) AS `TotalSpent` from (((`Buyer` `b` left join `Order` `o` on((`b`.`UserId` = `o`.`UserId`))) left join `OrderDetail` `od` on((`o`.`OrderId` = `od`.`OrderId`))) left join `Order_are_Detail` `oad` on(((`od`.`OrdDetail_id` = `oad`.`OrdDetail_id`) and (`od`.`OrderId` = `oad`.`OrderId`)))) group by `b`.`UserId` order by `TotalSpent` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_TopProducts`
--

/*!50001 DROP VIEW IF EXISTS `vw_TopProducts`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_TopProducts` AS select `p`.`ProductId` AS `ProductId`,sum(`oad`.`Quantity`) AS `TotalSold` from (`Order_are_Detail` `oad` join `Product` `p` on((`oad`.`ProductId` = `p`.`ProductId`))) group by `p`.`ProductId` order by `TotalSold` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_TopSellingProducts`
--

/*!50001 DROP VIEW IF EXISTS `vw_TopSellingProducts`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_TopSellingProducts` AS select `p`.`ProductId` AS `ProductId`,`p`.`Name` AS `Name`,sum(`oad`.`Quantity`) AS `TotalSold` from (`Order_are_Detail` `oad` join `Product` `p` on((`oad`.`ProductId` = `p`.`ProductId`))) group by `p`.`ProductId`,`p`.`Name` order by `TotalSold` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-14  7:52:05
