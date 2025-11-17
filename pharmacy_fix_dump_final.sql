CREATE DATABASE  IF NOT EXISTS `pharmacy` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `pharmacy`;
-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: localhost    Database: pharmacy
-- ------------------------------------------------------
-- Server version	8.0.43

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
-- Table structure for table `about_review`
--

DROP TABLE IF EXISTS `about_review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `about_review` (
  `UserId` int NOT NULL,
  `ReviewId` int NOT NULL,
  `ProductId` int DEFAULT NULL,
  PRIMARY KEY (`UserId`,`ReviewId`),
  KEY `ReviewId` (`ReviewId`),
  KEY `ProductId` (`ProductId`) /*!80000 INVISIBLE */,
  CONSTRAINT `About_Review_ibfk_1` FOREIGN KEY (`ReviewId`) REFERENCES `reviews` (`ReviewId`),
  CONSTRAINT `About_Review_ibfk_2` FOREIGN KEY (`ProductId`) REFERENCES `product` (`ProductId`) ON DELETE SET NULL,
  CONSTRAINT `About_Review_ibfk_3` FOREIGN KEY (`UserId`) REFERENCES `buyer` (`UserId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `about_review`
--

LOCK TABLES `about_review` WRITE;
/*!40000 ALTER TABLE `about_review` DISABLE KEYS */;
/*!40000 ALTER TABLE `about_review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin` (
  `UserId` int NOT NULL,
  PRIMARY KEY (`UserId`),
  CONSTRAINT `Admin_ibfk_1` FOREIGN KEY (`UserId`) REFERENCES `user` (`UserId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES (1);
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bank_card`
--

DROP TABLE IF EXISTS `bank_card`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bank_card` (
  `PaymentId` int NOT NULL,
  `CardNumber` varchar(30) DEFAULT NULL,
  `FromCompany` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`PaymentId`),
  CONSTRAINT `Bank_Card_ibfk_1` FOREIGN KEY (`PaymentId`) REFERENCES `payment` (`PaymentId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bank_card`
--

LOCK TABLES `bank_card` WRITE;
/*!40000 ALTER TABLE `bank_card` DISABLE KEYS */;
INSERT INTO `bank_card` VALUES (2,'fff','ffff'),(3,'123123123','VCB'),(5,'fdsfsdfsdf','dfsdfsdfds');
/*!40000 ALTER TABLE `bank_card` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `buyer`
--

DROP TABLE IF EXISTS `buyer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `buyer` (
  `UserId` int NOT NULL,
  `LoyaltyPoint` int DEFAULT '0',
  PRIMARY KEY (`UserId`),
  CONSTRAINT `Buyer_ibfk_1` FOREIGN KEY (`UserId`) REFERENCES `user` (`UserId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `buyer`
--

LOCK TABLES `buyer` WRITE;
/*!40000 ALTER TABLE `buyer` DISABLE KEYS */;
INSERT INTO `buyer` VALUES (6,0),(8,0),(9,0),(13,0),(15,0),(16,0);
/*!40000 ALTER TABLE `buyer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `CartId` int NOT NULL AUTO_INCREMENT,
  `CreationDate` date DEFAULT NULL,
  `UserId` int NOT NULL,
  PRIMARY KEY (`CartId`),
  KEY `UserId` (`UserId`),
  CONSTRAINT `Cart_ibfk_1` FOREIGN KEY (`UserId`) REFERENCES `user` (`UserId`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (3,'2025-11-14',6),(4,'2025-11-17',9),(5,'2025-11-17',13),(6,'2025-11-17',15),(7,'2025-11-17',1),(8,'2025-11-17',16);
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cartitem`
--

DROP TABLE IF EXISTS `cartitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cartitem` (
  `CartId` int NOT NULL,
  `CartItemId` int NOT NULL,
  PRIMARY KEY (`CartId`,`CartItemId`),
  CONSTRAINT `CartItem_ibfk_1` FOREIGN KEY (`CartId`) REFERENCES `cart` (`CartId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cartitem`
--

LOCK TABLES `cartitem` WRITE;
/*!40000 ALTER TABLE `cartitem` DISABLE KEYS */;
INSERT INTO `cartitem` VALUES (6,1),(6,2),(6,3),(6,4),(7,1),(7,2),(8,1),(8,2);
/*!40000 ALTER TABLE `cartitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cartitem_detail`
--

DROP TABLE IF EXISTS `cartitem_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cartitem_detail` (
  `CartId` int NOT NULL,
  `CartItemId` int NOT NULL,
  `ProductId` int NOT NULL,
  `Amount` int DEFAULT NULL,
  PRIMARY KEY (`CartId`,`CartItemId`),
  KEY `ProductId` (`ProductId`),
  CONSTRAINT `CartItem_detail_ibfk_1` FOREIGN KEY (`CartId`, `CartItemId`) REFERENCES `cartitem` (`CartId`, `CartItemId`),
  CONSTRAINT `CartItem_detail_ibfk_2` FOREIGN KEY (`ProductId`) REFERENCES `product` (`ProductId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cartitem_detail`
--

LOCK TABLES `cartitem_detail` WRITE;
/*!40000 ALTER TABLE `cartitem_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `cartitem_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cash_on_delivery`
--

DROP TABLE IF EXISTS `cash_on_delivery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cash_on_delivery` (
  `PaymentId` int NOT NULL,
  PRIMARY KEY (`PaymentId`),
  CONSTRAINT `Cash_on_Delivery_ibfk_1` FOREIGN KEY (`PaymentId`) REFERENCES `payment` (`PaymentId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cash_on_delivery`
--

LOCK TABLES `cash_on_delivery` WRITE;
/*!40000 ALTER TABLE `cash_on_delivery` DISABLE KEYS */;
INSERT INTO `cash_on_delivery` VALUES (1),(6),(8),(10);
/*!40000 ALTER TABLE `cash_on_delivery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `CategoryId` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) DEFAULT NULL,
  `Description` text,
  PRIMARY KEY (`CategoryId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Pain Relief & Anti-inflammatory','For short-term disease'),(2,'Antibiotic & Allergy','For long-term disease');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `create_promotion`
--

DROP TABLE IF EXISTS `create_promotion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `create_promotion` (
  `UserId` int DEFAULT NULL,
  `PromoId` int NOT NULL,
  `ProductId` int NOT NULL,
  PRIMARY KEY (`PromoId`,`ProductId`),
  KEY `ProductId` (`ProductId`),
  KEY `UserId` (`UserId`),
  CONSTRAINT `Create_Promotion_ibfk_1` FOREIGN KEY (`PromoId`) REFERENCES `promotion` (`PromoId`),
  CONSTRAINT `Create_Promotion_ibfk_2` FOREIGN KEY (`ProductId`) REFERENCES `product` (`ProductId`) ON DELETE CASCADE,
  CONSTRAINT `Create_Promotion_ibfk_3` FOREIGN KEY (`UserId`) REFERENCES `sales_manager` (`UserId`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `create_promotion`
--

LOCK TABLES `create_promotion` WRITE;
/*!40000 ALTER TABLE `create_promotion` DISABLE KEYS */;
INSERT INTO `create_promotion` VALUES (10,1,3),(10,2,4),(10,3,3),(10,3,4),(10,3,5),(10,3,6);
/*!40000 ALTER TABLE `create_promotion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ewallet`
--

DROP TABLE IF EXISTS `ewallet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ewallet` (
  `PaymentId` int NOT NULL,
  `WalletNumber` varchar(30) DEFAULT NULL,
  `FromCompany` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`PaymentId`),
  CONSTRAINT `EWallet_ibfk_1` FOREIGN KEY (`PaymentId`) REFERENCES `payment` (`PaymentId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ewallet`
--

LOCK TABLES `ewallet` WRITE;
/*!40000 ALTER TABLE `ewallet` DISABLE KEYS */;
INSERT INTO `ewallet` VALUES (4,'0999999999','Momo'),(7,'0999999999','Momo'),(9,'0888888888','Zalo');
/*!40000 ALTER TABLE `ewallet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order` (
  `OrderId` int NOT NULL AUTO_INCREMENT,
  `Status` varchar(50) DEFAULT NULL,
  `OrderDate` date DEFAULT NULL,
  `UserId` int NOT NULL,
  PRIMARY KEY (`OrderId`),
  KEY `UserId` (`UserId`),
  CONSTRAINT `Order_ibfk_1` FOREIGN KEY (`UserId`) REFERENCES `user` (`UserId`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` VALUES (1,'Completed','2025-11-17',9),(2,'Pending','2025-11-17',9),(3,'Pending','2025-11-17',9),(4,'Pending','2025-11-17',9),(5,'Completed','2025-11-17',9),(6,'Completed','2025-11-17',9),(7,'Pending','2025-11-17',9),(8,'Completed','2025-11-17',9),(9,'Pending','2025-11-17',9),(10,'Completed','2025-11-17',13),(11,'Pending','2025-11-17',15);
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_increase_stock_on_cancel` AFTER UPDATE ON `order` FOR EACH ROW BEGIN
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
-- Table structure for table `order_are_detail`
--

DROP TABLE IF EXISTS `order_are_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_are_detail` (
  `OrdDetail_id` int NOT NULL,
  `OrderId` int NOT NULL,
  `ProductId` int NOT NULL,
  `Quantity` int DEFAULT NULL,
  `TotalAmount` decimal(10,2) NOT NULL COMMENT 'The total price for this line item (Quantity * Price at time of purchase)',
  PRIMARY KEY (`OrdDetail_id`,`OrderId`,`ProductId`),
  KEY `ProductId` (`ProductId`),
  CONSTRAINT `Order_are_Detail_ibfk_1` FOREIGN KEY (`OrdDetail_id`, `OrderId`) REFERENCES `orderdetail` (`OrdDetail_id`, `OrderId`),
  CONSTRAINT `Order_are_Detail_ibfk_2` FOREIGN KEY (`ProductId`) REFERENCES `product` (`ProductId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_are_detail`
--

LOCK TABLES `order_are_detail` WRITE;
/*!40000 ALTER TABLE `order_are_detail` DISABLE KEYS */;
INSERT INTO `order_are_detail` VALUES (1,3,3,1,20000.00),(1,4,3,1,20000.00),(1,5,3,5,100000.00),(1,6,4,1,30000.00),(1,7,3,1,20000.00),(1,8,3,1,20000.00),(1,10,4,4,280000.00),(1,11,5,1,123000.00),(2,1,5,2,246000.00),(2,3,5,1,123000.00),(2,4,6,1,50000.00),(2,8,6,1,50000.00),(2,9,5,5,615000.00),(2,10,6,3,150000.00),(3,1,3,25,500000.00),(4,2,3,6,120000.00),(5,2,4,1,30000.00);
/*!40000 ALTER TABLE `order_are_detail` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_check_null_before_insert` BEFORE INSERT ON `order_are_detail` FOR EACH ROW BEGIN
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_check_stock_before_insert` BEFORE INSERT ON `order_are_detail` FOR EACH ROW BEGIN
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_calc_totalamount_before_insert` BEFORE INSERT ON `order_are_detail` FOR EACH ROW BEGIN
    -- Phòng trường hợp Quantity null
    IF NEW.Quantity IS NULL THEN
        SET NEW.Quantity = 0;
    END IF;

    -- Tính tổng tiền: số lượng * giá cuối cùng (đã áp dụng khuyến mãi)
    SET NEW.TotalAmount = NEW.Quantity * fn_GetFinalProductPrice(NEW.ProductId);
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_decrease_stock_after_order` AFTER INSERT ON `order_are_detail` FOR EACH ROW BEGIN
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
-- Table structure for table `order_with_shipment`
--

DROP TABLE IF EXISTS `order_with_shipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_with_shipment` (
  `ShipmentId` int NOT NULL,
  `OrderId` int NOT NULL,
  PRIMARY KEY (`ShipmentId`),
  KEY `OrderId` (`OrderId`),
  CONSTRAINT `Order_with_Shipment_ibfk_1` FOREIGN KEY (`ShipmentId`) REFERENCES `shipment` (`ShipmentId`),
  CONSTRAINT `Order_with_Shipment_ibfk_2` FOREIGN KEY (`OrderId`) REFERENCES `order` (`OrderId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_with_shipment`
--

LOCK TABLES `order_with_shipment` WRITE;
/*!40000 ALTER TABLE `order_with_shipment` DISABLE KEYS */;
INSERT INTO `order_with_shipment` VALUES (1,5),(2,6),(3,6),(4,7),(5,8),(6,9),(7,10),(8,11);
/*!40000 ALTER TABLE `order_with_shipment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderdetail`
--

DROP TABLE IF EXISTS `orderdetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orderdetail` (
  `OrdDetail_id` int NOT NULL,
  `OrderId` int NOT NULL,
  PRIMARY KEY (`OrdDetail_id`,`OrderId`),
  KEY `OrderId` (`OrderId`),
  CONSTRAINT `OrderDetail_ibfk_1` FOREIGN KEY (`OrderId`) REFERENCES `order` (`OrderId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderdetail`
--

LOCK TABLES `orderdetail` WRITE;
/*!40000 ALTER TABLE `orderdetail` DISABLE KEYS */;
INSERT INTO `orderdetail` VALUES (2,1),(3,1),(4,2),(5,2),(1,3),(2,3),(1,4),(2,4),(1,5),(1,6),(1,7),(1,8),(2,8),(1,9),(2,9),(1,10),(2,10),(1,11);
/*!40000 ALTER TABLE `orderdetail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organize_in_category`
--

DROP TABLE IF EXISTS `organize_in_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `organize_in_category` (
  `ProductId` int NOT NULL,
  `CategoryId` int NOT NULL,
  PRIMARY KEY (`ProductId`),
  KEY `CategoryId` (`CategoryId`),
  CONSTRAINT `Organize_in_category_ibfk_1` FOREIGN KEY (`ProductId`) REFERENCES `product` (`ProductId`) ON DELETE CASCADE,
  CONSTRAINT `Organize_in_category_ibfk_2` FOREIGN KEY (`CategoryId`) REFERENCES `category` (`CategoryId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organize_in_category`
--

LOCK TABLES `organize_in_category` WRITE;
/*!40000 ALTER TABLE `organize_in_category` DISABLE KEYS */;
INSERT INTO `organize_in_category` VALUES (3,1),(4,1),(5,2),(6,2);
/*!40000 ALTER TABLE `organize_in_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment` (
  `PaymentId` int NOT NULL AUTO_INCREMENT,
  `PayDate` date DEFAULT NULL,
  `Amount` decimal(10,2) DEFAULT NULL,
  `Status` varchar(50) DEFAULT NULL,
  `Creation_Date` date DEFAULT NULL,
  `OrderId` int NOT NULL,
  PRIMARY KEY (`PaymentId`),
  KEY `fk_Payment_Order_idx` (`OrderId`),
  CONSTRAINT `fk_Payment_Order` FOREIGN KEY (`OrderId`) REFERENCES `order` (`OrderId`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
INSERT INTO `payment` VALUES (1,'2025-11-17',746000.00,'Pending',NULL,1),(2,'2025-11-17',746000.00,'Completed',NULL,1),(3,'2025-11-17',100000.00,'Completed',NULL,5),(4,'2025-11-17',30000.00,'Completed',NULL,6),(5,'2025-11-17',30000.00,'Completed',NULL,6),(6,'2025-11-17',20000.00,'Pending',NULL,7),(7,'2025-11-17',70000.00,'Completed',NULL,8),(8,'2025-11-17',675000.00,'Pending',NULL,9),(9,'2025-11-17',430000.00,'Completed',NULL,10),(10,'2025-11-17',123000.00,'Pending',NULL,11);
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `ProductId` int NOT NULL AUTO_INCREMENT,
  `Price` decimal(10,2) DEFAULT NULL,
  `Name` varchar(50) DEFAULT NULL,
  `Stock` int DEFAULT NULL,
  `Description` text,
  PRIMARY KEY (`ProductId`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (3,100000.00,'Paracetamol',460,'A common pain reliever and fever reducer. Used to treat headaches, muscle aches, arthritis, backache, and fever caused by infections.'),(4,70000.00,'Amoxicillin',231,'A broad-spectrum antibiotic used to treat bacterial infections such as pneumonia, ear infections, urinary tract infections, and throat infections.'),(5,123000.00,'Ibuprofen',312,'A nonsteroidal anti-inflammatory drug (NSAID) that helps reduce fever, pain, and inflammation. Commonly used for menstrual cramps, headaches, and arthritis.'),(6,50000.00,'Loratadine',195,'An antihistamine used to relieve allergy symptoms such as runny nose, sneezing, and itchy or watery eyes. It does not usually cause drowsiness.');
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `promotion`
--

DROP TABLE IF EXISTS `promotion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `promotion` (
  `PromoId` int NOT NULL AUTO_INCREMENT,
  `Type` varchar(50) DEFAULT NULL,
  `StartPeriod` date DEFAULT NULL,
  `EndPeriod` date DEFAULT NULL,
  `Value` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`PromoId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promotion`
--

LOCK TABLES `promotion` WRITE;
/*!40000 ALTER TABLE `promotion` DISABLE KEYS */;
INSERT INTO `promotion` VALUES (1,'Discount','2025-10-12','2026-10-12',40000.00),(2,'Discount','2025-09-14','2015-12-02',60000.00),(3,'FirstUser','2025-08-12','2025-12-31',80000.00);
/*!40000 ALTER TABLE `promotion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `refer_id`
--

DROP TABLE IF EXISTS `refer_id`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `refer_id` (
  `Referee_Id` int NOT NULL,
  `Referrer_Id` int NOT NULL,
  `ReferDate` date DEFAULT NULL,
  `ReferredId` int DEFAULT NULL,
  PRIMARY KEY (`Referee_Id`),
  KEY `Referrer_Id` (`Referrer_Id`),
  CONSTRAINT `Refer_Id_ibfk_1` FOREIGN KEY (`Referee_Id`) REFERENCES `buyer` (`UserId`),
  CONSTRAINT `Refer_Id_ibfk_2` FOREIGN KEY (`Referrer_Id`) REFERENCES `buyer` (`UserId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `refer_id`
--

LOCK TABLES `refer_id` WRITE;
/*!40000 ALTER TABLE `refer_id` DISABLE KEYS */;
/*!40000 ALTER TABLE `refer_id` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_prevent_self_referral` BEFORE INSERT ON `refer_id` FOR EACH ROW BEGIN
    -- Không cho Referee (người được giới thiệu) trùng với Referrer (người giới thiệu)
    IF NEW.Referee_Id = NEW.Referrer_Id THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: A user cannot refer themselves.';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `report`
--

DROP TABLE IF EXISTS `report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `report` (
  `ReportId` int NOT NULL AUTO_INCREMENT,
  `Content` text,
  `ReportType` varchar(50) DEFAULT NULL,
  `CreationDate` date NOT NULL,
  `UserId` int NOT NULL,
  PRIMARY KEY (`ReportId`),
  KEY `UserId` (`UserId`),
  CONSTRAINT `Report_ibfk_1` FOREIGN KEY (`UserId`) REFERENCES `admin` (`UserId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `report`
--

LOCK TABLES `report` WRITE;
/*!40000 ALTER TABLE `report` DISABLE KEYS */;
/*!40000 ALTER TABLE `report` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `ReviewId` int NOT NULL AUTO_INCREMENT,
  `Rating` int DEFAULT NULL,
  `Content` text,
  PRIMARY KEY (`ReviewId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales_manager`
--

DROP TABLE IF EXISTS `sales_manager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sales_manager` (
  `UserId` int NOT NULL,
  PRIMARY KEY (`UserId`),
  CONSTRAINT `Sales_Manager_ibfk_1` FOREIGN KEY (`UserId`) REFERENCES `user` (`UserId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales_manager`
--

LOCK TABLES `sales_manager` WRITE;
/*!40000 ALTER TABLE `sales_manager` DISABLE KEYS */;
INSERT INTO `sales_manager` VALUES (1),(10);
/*!40000 ALTER TABLE `sales_manager` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shipment`
--

DROP TABLE IF EXISTS `shipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shipment` (
  `ShipmentId` int NOT NULL AUTO_INCREMENT,
  `ShippingDate` date DEFAULT NULL,
  `Status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ShipmentId`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shipment`
--

LOCK TABLES `shipment` WRITE;
/*!40000 ALTER TABLE `shipment` DISABLE KEYS */;
INSERT INTO `shipment` VALUES (1,'2025-11-17','Preparing'),(2,'2025-11-17','Preparing'),(3,'2025-11-17','Preparing'),(4,'2025-11-17','Preparing'),(5,'2025-11-17','Preparing'),(6,'2025-11-17','Preparing'),(7,'2025-11-17','Preparing'),(8,'2025-11-17','Preparing');
/*!40000 ALTER TABLE `shipment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shipment_third_party`
--

DROP TABLE IF EXISTS `shipment_third_party`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shipment_third_party` (
  `ShipmentId` int NOT NULL,
  `ThirdPartyId` int NOT NULL,
  `ShipperId` int DEFAULT NULL,
  PRIMARY KEY (`ShipmentId`),
  KEY `ThirdPartyId` (`ThirdPartyId`),
  CONSTRAINT `Shipment_Third_Party_ibfk_1` FOREIGN KEY (`ShipmentId`) REFERENCES `shipment` (`ShipmentId`),
  CONSTRAINT `Shipment_Third_Party_ibfk_2` FOREIGN KEY (`ThirdPartyId`) REFERENCES `thirdparty` (`ThirdPartyId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shipment_third_party`
--

LOCK TABLES `shipment_third_party` WRITE;
/*!40000 ALTER TABLE `shipment_third_party` DISABLE KEYS */;
INSERT INTO `shipment_third_party` VALUES (1,1,1),(2,1,1),(3,1,1),(4,1,1),(5,1,1),(6,1,1),(7,1,1),(8,1,1);
/*!40000 ALTER TABLE `shipment_third_party` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `thirdparty`
--

DROP TABLE IF EXISTS `thirdparty`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `thirdparty` (
  `ThirdPartyId` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) DEFAULT NULL,
  `Website` varchar(255) DEFAULT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `ContactInfo` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ThirdPartyId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thirdparty`
--

LOCK TABLES `thirdparty` WRITE;
/*!40000 ALTER TABLE `thirdparty` DISABLE KEYS */;
INSERT INTO `thirdparty` VALUES (1,'giaohangtietkiem','giaohangtietkiem.com','so 3 ton that tung','Phone number'),(2,'viettel fast','viettel.com.vn','district 1','Phone number');
/*!40000 ALTER TABLE `thirdparty` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `thirdparty_hotline`
--

DROP TABLE IF EXISTS `thirdparty_hotline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `thirdparty_hotline` (
  `ThirdPartyId` int NOT NULL,
  `AHotline` varchar(20) NOT NULL,
  PRIMARY KEY (`ThirdPartyId`,`AHotline`),
  CONSTRAINT `ThirdParty_Hotline_ibfk_1` FOREIGN KEY (`ThirdPartyId`) REFERENCES `thirdparty` (`ThirdPartyId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thirdparty_hotline`
--

LOCK TABLES `thirdparty_hotline` WRITE;
/*!40000 ALTER TABLE `thirdparty_hotline` DISABLE KEYS */;
INSERT INTO `thirdparty_hotline` VALUES (1,'02223334445'),(1,'09998887763'),(2,'04448882229');
/*!40000 ALTER TABLE `thirdparty_hotline` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
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
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'2004-10-12','District 1','Pham Van','A','PhamVanA@gmail.com','phamvanA','pbkdf2:sha256:1000000$PCnqJwz8TftaVpDt$8b8943e9e60886f53162b458dab7f01abd5f811970d3fc3665c67af68742fef6'),(6,'2003-02-04','District 2','Nguyen Van ','B','nguyenvanB@gmail.com','nguyenvanB','scrypt:32768:8:1$s6SD91HR3zYVEDMf$bb42f866734b039949a56d5a54ae22d0c6bb575b86b1eb321cb45b666c552d8483bb1998dd9b8d1fd0548906a3e19cabac38a24d70817ca514dd920e2d746839'),(8,'1998-11-12','District 5','Tao Khai ','E','taokhaiE@gmail.com','taokhaiE','scrypt:32768:8:1$fLwcIoiS20DDSZgV$b1da6a460167a6dc67b817c2b0edf145b57a96f21d347b4676a57f034077b21c332f095dd1932d6f47994349b425b11cf31ed9458f4fd8805a2ac33fa20f60de'),(9,'2005-01-12','District 7','Pham Quang','Minh','chien@gmail.com','phamMinh123','pbkdf2:sha256:1000000$mx7x6k1p724LGqKt$621466d4d83d42c37887c5fa66fc7c6d74291cc597f3c7ffcd024e5a15ba2c5f'),(10,'2007-10-15','Binh Tan District','Nguyễn Anh','Thư','minh.phamquang1201@hcmut.edu.vn','jasmineNg','pbkdf2:sha256:1000000$dPFObiFisR2UV8Lu$164ecaef7adca8b4bfa1293a7e4e586954638361b2f642b92ef92d79ee622e20'),(13,'1992-11-12','Không có','thái','hoà','thaihoa@gmail.com','thaihoa','scrypt:32768:8:1$V9qe1OP3Cz88XsJq$7a1024490872098797e25fae19b1d2fbb65306e4bca8d450dd5c16ab15553202aa6bffdaa3058f2caa6ee04196df6b6cbf4b3c0bfa38f59d593e6856cf770641'),(15,'2000-02-22','a','D','A','xnt777x@gmail.com','xnt777x','scrypt:32768:8:1$P27ldQvaOPzsxOjZ$db8c0ff8471ee8f7b29bdf0795f28f8884a38c0238619727101ff9e79fcf4f05a7ca87f2ba8378aea6198ededf8dd254b1ef38f8b9abf8572df52a569c927a98'),(16,'2000-11-11','a','t','e','test@gmail.com','test','scrypt:32768:8:1$SBgb8KcGbtyR40CT$a148276d177afa4fd4f670a2ece6a6d5fce93167f9705dd9c7a35b4c7370c3cf0fc5fc4c4f2d2ac8dab69f0b5911a2363aaeff17636ad42f6697aac88961e604');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `check_duplicate_username` BEFORE INSERT ON `user` FOR EACH ROW begin 
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `check_age_before_add_to_user` BEFORE INSERT ON `user` FOR EACH ROW BEGIN
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
-- Table structure for table `userphone`
--

DROP TABLE IF EXISTS `userphone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userphone` (
  `UserId` int NOT NULL,
  `APhoneNumber` varchar(20) NOT NULL,
  PRIMARY KEY (`UserId`,`APhoneNumber`),
  CONSTRAINT `UserPhone_ibfk_1` FOREIGN KEY (`UserId`) REFERENCES `user` (`UserId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userphone`
--

LOCK TABLES `userphone` WRITE;
/*!40000 ALTER TABLE `userphone` DISABLE KEYS */;
INSERT INTO `userphone` VALUES (1,'0901234567'),(6,'0912345678'),(8,'0934567890'),(10,'0999999999');
/*!40000 ALTER TABLE `userphone` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_check_phone_before_insert` BEFORE INSERT ON `userphone` FOR EACH ROW BEGIN
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
-- Temporary view structure for view `vw_topbuyers`
--

DROP TABLE IF EXISTS `vw_topbuyers`;
/*!50001 DROP VIEW IF EXISTS `vw_topbuyers`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_topbuyers` AS SELECT 
 1 AS `UserId`,
 1 AS `TotalSpent`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_topproducts`
--

DROP TABLE IF EXISTS `vw_topproducts`;
/*!50001 DROP VIEW IF EXISTS `vw_topproducts`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_topproducts` AS SELECT 
 1 AS `ProductId`,
 1 AS `TotalSold`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_topsellingproducts`
--

DROP TABLE IF EXISTS `vw_topsellingproducts`;
/*!50001 DROP VIEW IF EXISTS `vw_topsellingproducts`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_topsellingproducts` AS SELECT 
 1 AS `ProductId`,
 1 AS `Name`,
 1 AS `TotalSold`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'pharmacy'
--

--
-- Dumping routines for database 'pharmacy'
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
/*!50003 DROP PROCEDURE IF EXISTS `sp_AddBuyerAccount` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_AddBuyerAccount`(
    IN p_fname VARCHAR(50),
    IN p_lname VARCHAR(50),
    IN p_email VARCHAR(50),
    IN p_username VARCHAR(50),
    IN p_hashed VARCHAR(255),
    IN p_dob DATE,
    IN p_address VARCHAR(255)
)
BEGIN
    DECLARE new_user_id INT;

    START TRANSACTION;

    INSERT INTO User (Fname, Lname, Email, Username, HashedPassword, Dob, Address)
    VALUES (p_fname, p_lname, p_email, p_username, p_hashed, p_dob, p_address);

    SET new_user_id = LAST_INSERT_ID();

    INSERT INTO Buyer (UserId, LoyaltyPoint)
    VALUES (new_user_id, 0);

    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
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
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
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
/*!50003 DROP PROCEDURE IF EXISTS `sp_AddProductToCart` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_AddProductToCart`(
    IN p_BuyerId INT,
    IN p_ProductId INT,
    IN p_Quantity INT
)
BEGIN
    DECLARE v_CartId INT;
    DECLARE v_CartItemId INT;

    -- 1. Find the active cart for the buyer (Same as before)
    SELECT CartId INTO v_CartId
    FROM Cart
    WHERE UserId = p_BuyerId
    LIMIT 1;

    -- 2. If no cart exists, create one (Same as before)
    IF v_CartId IS NULL THEN
        INSERT INTO Cart (UserId, CreationDate)
        VALUES (p_BuyerId, NOW());
        SET v_CartId = LAST_INSERT_ID();
    END IF;

    -- 3. MODIFIED: Logic for 2-table (CartItem, CartItem_detail)
    -- Check if this product already exists in the cart
    SELECT cid.CartItemId INTO v_CartItemId
    FROM `CartItem_detail` cid
    WHERE cid.CartId = v_CartId AND cid.ProductId = p_ProductId
    LIMIT 1;

    IF v_CartItemId IS NOT NULL THEN
        -- Product exists: Just update the quantity
        UPDATE `CartItem_detail`
        SET Amount = Amount + p_Quantity
        WHERE CartId = v_CartId AND CartItemId = v_CartItemId;
    ELSE
        -- Product does not exist: Must insert into both tables
        START TRANSACTION;
        
        -- Generate a new CartItemId (e.g., MAX + 1 for this cart)
        SELECT IFNULL(MAX(CartItemId), 0) + 1 INTO v_CartItemId 
        FROM `CartItem` 
        WHERE CartId = v_CartId;

        -- Insert into parent table
        INSERT INTO `CartItem` (CartId, CartItemId)
        VALUES (v_CartId, v_CartItemId);
        
        -- Insert into child detail table
        INSERT INTO `CartItem_detail` (CartId, CartItemId, ProductId, Amount)
        VALUES (v_CartId, v_CartItemId, p_ProductId, p_Quantity);
        
        COMMIT;
    END IF;
        
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
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
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
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
        ROLLBACK;
        RESIGNAL;
    END;

    -- 1. Tìm cart của buyer
    SELECT CartId INTO v_CartId
    FROM Cart
    WHERE UserId = p_BuyerId
    LIMIT 1;

    -- 2. Nếu có cart và có item
    IF v_CartId IS NOT NULL AND EXISTS (SELECT 1 FROM CartItem WHERE CartId = v_CartId) THEN
        
        START TRANSACTION;

        -- 3. Tạo Order
        INSERT INTO `Order` (UserId, OrderDate, Status)
        VALUES (p_BuyerId, NOW(), 'Pending');
        
        SET v_OrderId = LAST_INSERT_ID();

        -- 4. Copy parent: CartItem -> OrderDetail
        INSERT INTO OrderDetail (OrdDetail_id, OrderId)
        SELECT ci.CartItemId, v_OrderId
        FROM CartItem ci
        WHERE ci.CartId = v_CartId;
        
        -- 5. Copy detail: CartItem_detail -> Order_are_Detail
        --    KHÔNG truyền TotalAmount, để trigger tự tính
        INSERT INTO Order_are_Detail (OrdDetail_id, OrderId, ProductId, Quantity)
        SELECT
            cid.CartItemId,
            v_OrderId,
            cid.ProductId,
            cid.Amount
        FROM CartItem_detail cid
        WHERE cid.CartId = v_CartId;

        -- 6. Xoá cart
        DELETE FROM CartItem_detail WHERE CartId = v_CartId;
        DELETE FROM CartItem WHERE CartId = v_CartId;

        COMMIT;
        
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
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
/*!50003 DROP PROCEDURE IF EXISTS `sp_GetAllProducts` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_GetAllProducts`()
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
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
/*!50003 DROP PROCEDURE IF EXISTS `sp_GetProductsByCategory` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_GetProductsByCategory`(IN p_CategoryId INT)
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_GetTopBuyersReport` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_GetTopBuyersReport`(
    IN p_MinAmount DECIMAL(10,2)
)
BEGIN
    -- (Validation of input parameters)
    IF p_MinAmount < 0 THEN
        SET p_MinAmount = 0;
    END IF;

    SELECT
        b.UserId,
        -- (Aggregate Function)
        IFNULL(SUM(oad.TotalAmount), 0) AS TotalSpent
    -- (Query from two or more tables)
    FROM `Buyer` b
    LEFT JOIN `Order` o ON b.UserId = o.UserId
    LEFT JOIN `OrderDetail` od ON o.OrderId = od.OrderId
    LEFT JOIN `Order_are_Detail` oad ON od.OrdDetail_id = oad.OrdDetail_id AND od.OrderId = oad.OrderId
    
    -- (GROUP BY)
    GROUP BY b.UserId
    
    -- (HAVING clause with input parameter)
    HAVING TotalSpent > p_MinAmount
    
    -- (ORDER BY clause)
    ORDER BY TotalSpent DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
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
/*!50003 DROP PROCEDURE IF EXISTS `sp_UpdateProduct` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_UpdateProduct`(
    IN p_ProductId    INT,
    IN p_Name         VARCHAR(50),
    IN p_Price        DECIMAL(10,2),
    IN p_Stock        INT,
    IN p_Description  TEXT,
    IN p_CategoryId   INT
)
BEGIN
    DECLARE v_exists INT;

    -- Handler lỗi: rollback nếu có SQLEXCEPTION
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    -- 1. Check product tồn tại
    SELECT COUNT(*) INTO v_exists
    FROM Product
    WHERE ProductId = p_ProductId;

    IF v_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Product not found';
    END IF;

    -- 2. Check category tồn tại
    SELECT COUNT(*) INTO v_exists
    FROM Category
    WHERE CategoryId = p_CategoryId;

    IF v_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Category not found';
    END IF;

    -- 3. Update bảng Product
    UPDATE Product
    SET
        Name        = p_Name,
        Price       = p_Price,
        Stock       = p_Stock,
        Description = p_Description
    WHERE ProductId = p_ProductId;

    -- 4. Update mapping Product–Category
    IF EXISTS (
        SELECT 1
        FROM Organize_in_category
        WHERE ProductId = p_ProductId
    ) THEN
        UPDATE Organize_in_category
        SET CategoryId = p_CategoryId
        WHERE ProductId = p_ProductId;
    ELSE
        INSERT INTO Organize_in_category(ProductId, CategoryId)
        VALUES (p_ProductId, p_CategoryId);
    END IF;

    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `vw_topbuyers`
--

/*!50001 DROP VIEW IF EXISTS `vw_topbuyers`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_topbuyers` AS select `b`.`UserId` AS `UserId`,ifnull(sum(`oad`.`TotalAmount`),0) AS `TotalSpent` from (((`buyer` `b` left join `order` `o` on((`b`.`UserId` = `o`.`UserId`))) left join `orderdetail` `od` on((`o`.`OrderId` = `od`.`OrderId`))) left join `order_are_detail` `oad` on(((`od`.`OrdDetail_id` = `oad`.`OrdDetail_id`) and (`od`.`OrderId` = `oad`.`OrderId`)))) group by `b`.`UserId` order by `TotalSpent` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_topproducts`
--

/*!50001 DROP VIEW IF EXISTS `vw_topproducts`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_topproducts` AS select `p`.`ProductId` AS `ProductId`,sum(`oad`.`Quantity`) AS `TotalSold` from (`order_are_detail` `oad` join `product` `p` on((`oad`.`ProductId` = `p`.`ProductId`))) group by `p`.`ProductId` order by `TotalSold` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_topsellingproducts`
--

/*!50001 DROP VIEW IF EXISTS `vw_topsellingproducts`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_topsellingproducts` AS select `p`.`ProductId` AS `ProductId`,`p`.`Name` AS `Name`,sum(`oad`.`Quantity`) AS `TotalSold` from (`order_are_detail` `oad` join `product` `p` on((`oad`.`ProductId` = `p`.`ProductId`))) group by `p`.`ProductId`,`p`.`Name` order by `TotalSold` desc */;
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

-- Dump completed on 2025-11-17 20:34:35
