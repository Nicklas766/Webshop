-- ------------------------------------------------------------------------
--
-- For lecture in oophp-v3 kmom03
--
-- CREATE DATABASE oophp;
-- GRANT ALL ON oophp.* TO user@localhost IDENTIFIED BY "pass";

USE nien16;
SET NAMES utf8;
-- ------------------------------------------------------------------------
--
-- Setup tables
--

DROP TABLE IF EXISTS `ErrandText`;
DROP TABLE IF EXISTS `CustomerErrand`;
DROP TABLE IF EXISTS Pages;
DROP TABLE IF EXISTS `Shop_Content`;
DROP TABLE IF EXISTS `LatestProduct`;
DROP TABLE IF EXISTS `RecommendedProduct`;
DROP TABLE IF EXISTS `WeekDeal`;
DROP TABLE IF EXISTS `Shop_Prod2Cat`;
DROP TABLE IF EXISTS `Shop_Image`;
DROP TABLE IF EXISTS `Shop_ProdCategory`;
DROP TABLE IF EXISTS `Shop_Inventory`;
DROP TABLE IF EXISTS `Shop_LowStock`;
DROP TABLE IF EXISTS `Shop_InvenShelf`;
DROP TABLE IF EXISTS `Shop_OrderRow`;
DROP TABLE IF EXISTS `Shop_Cst_Order`;
DROP TABLE IF EXISTS `Shop_ShoppingCart`;
DROP TABLE IF EXISTS `Shop_Product`;
DROP TABLE IF EXISTS `Shop_User`;



-- ------------------------------------------------------------------------
--
-- Product
--

CREATE TABLE `Shop_Image` (
	`id` INT AUTO_INCREMENT,
	`link` VARCHAR(40),

	PRIMARY KEY (`id`)
);

CREATE TABLE `Shop_ProdCategory` (
	`id` INT AUTO_INCREMENT,
	`category` CHAR(10),

	PRIMARY KEY (`id`)
);

CREATE TABLE `Shop_Product` (
	`id` INT AUTO_INCREMENT,
    `prodName` VARCHAR(20),
    `description` VARCHAR(120),
    `imgLink` VARCHAR(40),
    `price` INT,
    `soldAmount` INT DEFAULT 0,
	PRIMARY KEY (`id`)
);

CREATE TABLE `Shop_Prod2Cat` (
	`id` INT AUTO_INCREMENT,
	`prod_id` INT,
	`cat_id` INT,

	PRIMARY KEY (`id`),
	FOREIGN KEY (`prod_id`) REFERENCES `Shop_Product` (`id`),
    FOREIGN KEY (`cat_id`) REFERENCES `Shop_ProdCategory` (`id`)
);


-- ------------------------------------------------------------------------
--
-- Inventory, shelf and report
--

CREATE TABLE `Shop_LowStock` (
    `id` INT AUTO_INCREMENT,
    `prod_id` INT,
    `amount` INT,
    `occured` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

	PRIMARY KEY (`id`),
	FOREIGN KEY (`prod_id`) REFERENCES `Shop_Product` (`id`)
);

CREATE TABLE `Shop_InvenShelf` (
    `shelf` CHAR(6),
    `description` VARCHAR(40),

	PRIMARY KEY (`shelf`)
);
CREATE TABLE `Shop_Inventory` (
	`id` INT AUTO_INCREMENT,
    `prod_id` INT,
    `shelf_id` CHAR(6),
    `amount` INT,

	PRIMARY KEY (`id`),
	FOREIGN KEY (`prod_id`) REFERENCES `Shop_Product` (`id`),
    FOREIGN KEY (`shelf_id`) REFERENCES `Shop_InvenShelf` (`shelf`)
);


-- ------------------------------------------------------------------------
--
-- User
--
CREATE TABLE `Shop_User` (
	`id` INT AUTO_INCREMENT,
    `firstName` VARCHAR(20),
    `lastName` VARCHAR(20),
	`name` VARCHAR(100) NOT NULL,
	`pass` VARCHAR(100),
	`info` VARCHAR(100) NOT NULL,
	`email` VARCHAR(100) NOT NULL,
    `authority` VARCHAR(20),

	PRIMARY KEY (`id`)
);


-- ------------------------------------------------------------------------
--
-- Shopping Cart
--

CREATE TABLE `Shop_ShoppingCart` (
	`id` INT AUTO_INCREMENT,
    `customer_id` INT,
    `prod_id` INT,

	PRIMARY KEY (`id`),
 	FOREIGN KEY (`prod_id`) REFERENCES `Shop_Product` (`id`),
    FOREIGN KEY (`customer_id`) REFERENCES `Shop_User` (`id`)
);


-- ------------------------------------------------------------------------
--
-- Order
--
CREATE TABLE `Shop_Cst_Order` (
	`id` INT AUTO_INCREMENT,
    `customer_id` INT,
	`created` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `status` VARCHAR(20),
	`delivery` DATETIME DEFAULT NULL,

	PRIMARY KEY (`id`),
    FOREIGN KEY (`customer_id`) REFERENCES `Shop_User` (`id`)
);

CREATE TABLE `Shop_OrderRow` (
	`id` INT AUTO_INCREMENT,
    `order` INT,
    `product` INT,
	`amount` INT,

	PRIMARY KEY (`id`),
    FOREIGN KEY (`order`) REFERENCES `Shop_Cst_Order` (`id`)
);

-- ------------------------------------------------------------------------
--
-- Content tables
--
CREATE TABLE `Shop_Content`
(
  `id` INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
  `slug` CHAR(120) UNIQUE,

  `title` VARCHAR(120),
  `data` TEXT,
  `type` CHAR(20),
  `filter` VARCHAR(80) DEFAULT NULL,

  -- MySQL version 5.6 and higher
  -- `published` DATETIME DEFAULT CURRENT_TIMESTAMP,
  -- `created` DATETIME DEFAULT CURRENT_TIMESTAMP,
  -- `updated` DATETIME DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,

  -- MySQL version 5.5 and lower
  `published` DATETIME DEFAULT NULL,
  `created` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated` DATETIME DEFAULT NULL, --  ON UPDATE CURRENT_TIMESTAMP,
  `deleted` DATETIME DEFAULT NULL

) ENGINE INNODB CHARACTER SET utf8 COLLATE utf8_swedish_ci;


CREATE TABLE Pages
(
  `id` INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
  `about` TEXT,
  `aboutFilter` VARCHAR(80) DEFAULT NULL,
  `footer` TEXT,
  `footerFilter` VARCHAR(80) DEFAULT NULL

) ENGINE INNODB CHARACTER SET utf8 COLLATE utf8_swedish_ci;
-- ------------------------------------------------------------------------
--
-- KRAV 4
--


-- Create table for LatestProduct
CREATE TABLE `LatestProduct`
(
  `id` INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
  `prod_id` INT,

  FOREIGN KEY (`prod_id`) REFERENCES `Shop_Product` (`id`)

) ENGINE INNODB CHARACTER SET utf8 COLLATE utf8_swedish_ci;


-- Create table for RecommendedProduct
CREATE TABLE `RecommendedProduct`
(
  `id` INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
  `prod_id` INT,

  FOREIGN KEY (`prod_id`) REFERENCES `Shop_Product` (`id`)

) ENGINE INNODB CHARACTER SET utf8 COLLATE utf8_swedish_ci;


--
-- Create table for WeekDeal
--
CREATE TABLE `WeekDeal`
(
  `id` INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
  `prod_id` INT,
  `week` INT,
  `newPrice` INT,

  FOREIGN KEY (`prod_id`) REFERENCES `Shop_Product` (`id`)

) ENGINE INNODB CHARACTER SET utf8 COLLATE utf8_swedish_ci;


-- ----------------------------------------------------------------------------
-- Create table for Errands
--

CREATE TABLE `CustomerErrand`
(
  `id` INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
  `cst_id` INT,
  `title` VARCHAR(20),
  `description` TEXT,
  `created` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `status` VARCHAR(20) DEFAULT 'active',

  FOREIGN KEY (`cst_id`) REFERENCES `Shop_User` (`id`)

) ENGINE INNODB CHARACTER SET utf8 COLLATE utf8_swedish_ci;


CREATE TABLE `ErrandText`
(
  `id` INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
  `senders_id` INT,
  `errand_id` INT,
  `created` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `sent_text` TEXT,

  FOREIGN KEY (`errand_id`) REFERENCES `CustomerErrand` (`id`),
  FOREIGN KEY (`senders_id`) REFERENCES `Shop_User` (`id`)

) ENGINE INNODB CHARACTER SET utf8 COLLATE utf8_swedish_ci;


-- -------------------------------------------------------------------------
-- -------------------------------------------------------------------------
-- -------------------------------------------------------------------------
-- -------------------------------------------------------------------------
