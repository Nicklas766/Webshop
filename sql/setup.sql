-- ------------------------------------------------------------------------
--
-- For lecture in oophp-v3 kmom03
--
-- CREATE DATABASE oophp;
-- GRANT ALL ON oophp.* TO user@localhost IDENTIFIED BY "pass";

USE nien16;
SET NAMES utf8;
SET GLOBAL log_bin_trust_function_creators = 1;
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

-- -------------------------------------------------------------------------
-- -------------------------------------------------------------------------
-- -------------------------------------------------------------------------
-- -------------------------------------------------------------------------
--
-- TRIGGERS
--

-- Trigger for creating product, insert into inventory
DROP TRIGGER IF EXISTS createdProduct;

CREATE TRIGGER createdProduct
AFTER INSERT ON Shop_Product FOR EACH ROW
	INSERT INTO Shop_Inventory (`prod_id`, `amount`, `shelf_id`) VALUES (NEW.id, 0, "NONE");

-- Trigger for creating product, insert into inventory
DROP TRIGGER IF EXISTS createdOrderRow;

CREATE TRIGGER createdOrderRow
AFTER INSERT ON Shop_OrderRow FOR EACH ROW
    CALL decreaseInventory(NEW.Product, NEW.amount);


-- Trigger for checking if product is lower than 0 on update
DROP TRIGGER IF EXISTS checkInventory;
DELIMITER //
CREATE TRIGGER checkInventory
AFTER UPDATE ON Shop_Inventory FOR EACH ROW
	IF (NEW.amount < 5) THEN
    	INSERT INTO Shop_LowStock (`prod_id`, `amount`) VALUES (OLD.prod_id, NEW.amount);
    END IF;
//
DELIMITER ;
-- ------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------

-- ------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------
--
--              PROCEDURE
--

-- PROCEDURE for updating product, first product then category and p2c
DROP PROCEDURE IF EXISTS removeCategory;
DELIMITER //


-- remove all categories in product
CREATE PROCEDURE removeCategory(
    P_id INT
)
BEGIN
    DELETE FROM Shop_Prod2Cat WHERE prod_id = P_id;
END
//
DELIMITER ;


-- PROCEDURE for updating product, first product then category and p2c

DROP PROCEDURE IF EXISTS addCategory;
DELIMITER //

-- adds category
CREATE PROCEDURE addCategory(
    P_id INT,
    C_id INT
)
BEGIN
    INSERT INTO `Shop_Prod2Cat` (`prod_id`, `cat_id`) VALUES (P_id, C_id);
END
//
DELIMITER ;

DROP PROCEDURE IF EXISTS createProduct;
DELIMITER //

-- creates product
CREATE PROCEDURE createProduct(
    prodName VARCHAR(20),
    des VARCHAR(120),
    imgLink VARCHAR(40),
    price INT,
    C_id INT
)
BEGIN
	DECLARE latestId INT;
    INSERT INTO `Shop_Product` (`prodName`, `description`, `imgLink`, `price`) VALUES
	(prodName, des, imgLink, price);

    -- Get the id of product.
    SET latestId = (SELECT MAX(id) FROM Shop_Product);

    call addCategory(latestId, C_id);

END
//
DELIMITER ;

-- PROCEDURE for removing product

DROP PROCEDURE IF EXISTS removeProduct;
DELIMITER //

-- adds category
CREATE PROCEDURE removeProduct(
     P_id INT
)
BEGIN
	SET FOREIGN_KEY_CHECKS=0; -- to disable them
	DELETE FROM Shop_LowStock WHERE prod_id = P_id;
	DELETE FROM Shop_Prod2Cat WHERE prod_id = P_id;
    DELETE FROM Shop_Product WHERE id = P_id;
    SET FOREIGN_KEY_CHECKS=1; -- to re-enable them
END
//
DELIMITER ;

-- updates inventory
DROP PROCEDURE IF EXISTS updateInventory;
DELIMITER //

CREATE PROCEDURE updateInventory(
     P_id INT,
     newShelf CHAR(6),
     newAmount INT
)
BEGIN
	DECLARE amountInStock INT;
    START TRANSACTION;

    SET amountInStock = (SELECT amount FROM Shop_Inventory WHERE prod_id = P_id);

    IF (amountInStock + (newAmount)) < 0 THEN
        ROLLBACK;
        SELECT "You cant decrease below zero!";
    ELSE
        UPDATE Shop_Inventory SET shelf_id = newShelf, amount = amount + (newAmount), prod_id = P_id WHERE prod_id = P_id;
        INSERT INTO LatestProduct (`prod_id`) VALUES (P_id);
        COMMIT;
        END IF;
END
//
DELIMITER ;


-- updates inventory
DROP PROCEDURE IF EXISTS decreaseInventory;
DELIMITER //

CREATE PROCEDURE decreaseInventory(
     P_id INT,
     decrease INT
)
BEGIN
	UPDATE Shop_Inventory SET amount = amount - decrease WHERE prod_id = P_id;
END
//
DELIMITER ;

-- updates inventory
DROP PROCEDURE IF EXISTS increaseInventory;
DELIMITER //

CREATE PROCEDURE increaseInventory(
     P_id INT,
     increase INT
)
BEGIN
    UPDATE Shop_Inventory SET amount = amount + increase WHERE prod_id = P_id;
END
//
DELIMITER ;

-- PROCEDURE for updating product, first product then category and p2c

DROP PROCEDURE IF EXISTS removeCart;
DELIMITER //

-- adds category
CREATE PROCEDURE removeCart(
     customerId INT,
     prodId int
)
BEGIN
    DELETE FROM `Shop_ShoppingCart` WHERE customer_id = customerId AND prod_id = prodId limit 1;
END
//
DELIMITER ;


-- Cancels order

DROP PROCEDURE IF EXISTS cancelOrder;
DELIMITER //

-- Cancels the order
CREATE PROCEDURE cancelOrder(
     orderId INT
)
BEGIN
	DECLARE numOfOrders INT;
    DECLARE theProd INT;
    DECLARE theAmount INT;
    DECLARE p1 INT;
    SET p1 = 0;
	-- No delete, set status as canceled instead
    UPDATE Shop_Cst_Order SET status = "canceled" WHERE id = orderId;

    -- Get product id and amount
    set numOfOrders = (SELECT COUNT(`order`) FROM Shop_OrderRow WHERE `order` = orderId);

	-- Return the goods to the warehouse
	label1: WHILE p1 < numOfOrders + 1 DO
		set theProd = (SELECT product FROM Shop_OrderRow WHERE `order` = orderId LIMIT 1 OFFSET p1);
		set theAmount = (SELECT amount FROM Shop_OrderRow WHERE `order` = orderId LIMIT 1 OFFSET p1);
		CALL increaseInventory(theProd, theAmount);
		SET p1 = p1 + 1;
   END WHILE label1;
END
//
DELIMITER ;



-- ------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------
--
--          Function
--

-- -----------------------------------------------------------------------------
-- STOCKSTATUS FUNCTION
--

DELIMITER //

DROP FUNCTION IF EXISTS StockStatus //
CREATE FUNCTION StockStatus(
    Amount INTEGER
)
RETURNS CHAR(30)
BEGIN
    IF Amount > 0 THEN
        RETURN CONCAT("Ja(", Amount, ")");
    ELSEIF Amount = 0 THEN
        RETURN "Nej";
    END IF;
END
//

DELIMITER ;

-- -----------------------------------------------------------------------------
-- REMOVE INVENTORY
--

DELIMITER //

DROP FUNCTION IF EXISTS removeInventory //
CREATE FUNCTION removeInventory(
    I_id INTEGER
)
RETURNS CHAR(20)
BEGIN
	DECLARE P_id INT;
    -- Get products id
    set P_id = (SELECT prod_id FROM Shop_Inventory WHERE id = I_id);

    -- If product exists do a rollback.
    IF EXISTS (SELECT * FROM Shop_Product WHERE id = P_id) THEN
        RETURN "FALSE";
    ELSE
        DELETE FROM Shop_Inventory WHERE id = I_id;
        RETURN "TRUE";
	END IF;
END
//

DELIMITER ;

-- -----------------------------------------------------------------------------
-- ADD TO CART FUNCTION
--
DELIMITER //

DROP FUNCTION IF EXISTS addCart //
CREATE FUNCTION addCart(
    customerId INT,
    prodId INT
)
RETURNS CHAR(20)
BEGIN
    DECLARE amountInStock INT;
    DECLARE currentBasket INT;

    -- Control if based on cst's ShoppingCart and Inventory, the order will be possible.
    SET amountInStock = (SELECT amount FROM Shop_Inventory WHERE prod_id = prodId);
    SET currentBasket = (SELECT Amount FROM VShoppingCart WHERE Customer_ID = customerId AND prod_id = prodId UNION ALL SELECT 0 FROM dual WHERE NOT EXISTS (SELECT * FROM VShoppingCart WHERE Customer_ID = customerId AND prod_id = prodId));

    -- If product exists do a rollback.
    IF (amountInStock - currentBasket) <= 0 THEN
        RETURN "FALSE";
    ELSE
		INSERT INTO `Shop_ShoppingCart` (`customer_id`, `prod_id`) VALUES (customerId, prodId);
        RETURN "TRUE";
	END IF;
END
//

DELIMITER ;


-- -----------------------------------------------------------------------------
-- ADD WEEKDEAL
--
-- function for adding weekdeal
--
DELIMITER //

DROP FUNCTION IF EXISTS addWeekDeal //
CREATE FUNCTION addWeekDeal(
    prodId INT,
    newWeek INT,
    newPrice INT
)
RETURNS CHAR(20)
BEGIN
    DECLARE max INT;

    SET max = (SELECT COUNT(id) FROM WeekDeal WHERE `week` = newWeek AND `prod_id` = prodId);

    -- If product deal doesn't exist, then create new one and update price for PRODUCT
    -- If product deal exists, update it and update price for PRODUCT
    IF max = 0 THEN
        INSERT INTO WeekDeal (`prod_id`, `week`, `newPrice`) VALUES (prodId, newWeek, newPrice);
        RETURN "NEW";
    ELSE
		UPDATE WeekDeal SET week = newWeek, newPrice = newPrice WHERE `prod_id` = prodId AND week = newWeek LIMIT 1;
        RETURN "UPDATED";
	END IF;
END
//

DELIMITER ;




-- -----------------------------------------------------------------------------
-- CONTROLDEAL
--
--
-- function for checking if product has deal
--
DELIMITER //

DROP FUNCTION IF EXISTS controlDeal //
CREATE FUNCTION controlDeal(
    prodId INT,
    currentDate DATETIME
)
RETURNS INT
BEGIN
    DECLARE getId INT;

    -- Save id if current week exists in WeekDeals
    SET getId = (SELECT COUNT(id) FROM WeekDeal WHERE `week` = (select WEEK(currentDate, 1)) AND `prod_id` = prodId);

    -- If it doesn't exist, then return products original price.
    -- else return the deals
    IF getId > 0 THEN
        RETURN (SELECT newPrice FROM WeekDeal WHERE `week` = (select WEEK(CurrentDate, 1)) AND `prod_id` = prodId);
    ELSE
        RETURN (SELECT price FROM Shop_Product WHERE `id` = prodId);
	END IF;
END
//

DELIMITER ;




-- ------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------
-- ceateOrder function

DELIMITER //

DROP FUNCTION IF EXISTS createOrder //

-- Cancels the order
CREATE FUNCTION createOrder(
    customerId INT
)
RETURNS VARCHAR(20)
BEGIN
    DECLARE amountInStock INT;
    DECLARE currentBasket INT;
    DECLARE theProd INT;
    DECLARE numOfProducts INT;
    DECLARE p1 INT;
    DECLARE TrueOrNot INT;
    DECLARE latestId INT;
    SET p1 = 0;
    SET TrueOrNot = 0;

    -- Get product id and amount
    set numOfProducts = (SELECT COUNT(prod_id) FROM VShoppingCart WHERE `Customer_ID` = customerId);

	-- Return the goods to the warehouse
	label1: WHILE p1 < numOfProducts + 1 DO
        SET theProd = (SELECT prod_id FROM VShoppingCart WHERE `Customer_ID` = customerId LIMIT 1 OFFSET p1);
		SET amountInStock = (SELECT amount FROM Shop_Inventory WHERE prod_id = theProd);
		SET currentBasket = (SELECT Amount FROM VShoppingCart WHERE `Customer_ID` = customerId LIMIT 1 OFFSET p1);


        IF (amountInStock - currentBasket) < 0 THEN
			SET p1 = p1 + 1000000000;
            SET TrueOrNot = 1;
        ELSE
		   SET p1 = p1 + 1;
           END IF;
   END WHILE label1;
   IF TrueOrNot != 1 THEN
           -- Start with creating order
        INSERT INTO Shop_Cst_Order (`customer_id`, `status`) VALUES (customerId, 'active');

        -- Get the id of order.
        SET latestId = (SELECT MAX(id) FROM Shop_Cst_Order);

        -- Create orderrows for the order
        INSERT INTO Shop_OrderRow (`order`, `product`, `amount`)
        SELECT latestId, prod_id, Amount FROM `VShoppingCart` WHERE Customer_ID = customerId;

        -- Denna ligger i createOrder proceduren
        -- Increase soldAmount in product Table with join with VShoppingCart
        UPDATE Shop_Product p, VShoppingCart SC
           SET p.soldAmount = p.soldAmount + SC.Amount
         WHERE p.id = SC.prod_id
           AND SC.customer_id = customerId;

        -- Delete the ShoppingCart after ordermade
        DELETE FROM `Shop_ShoppingCart` WHERE Customer_ID = customerId;
        RETURN "TRUE";
    ELSE
        RETURN "FALSE";
        END IF;
END
//
DELIMITER ;


-- ------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------
-- CREATE ALL STUFF
--

-- Create Categories
INSERT INTO `Shop_ProdCategory` (`category`) VALUES
("Jumper"), ("Accessoar"), ("Skor"), ("Vinter"), ("Sommar");

-- Create shelfs
INSERT INTO `Shop_InvenShelf` (`shelf`, `description`) VALUES
("NONE", "Currently not in stock"),
("A101", "House A, shelf 101"),
("A102", "House A, shelf 102");

-- Create images
INSERT INTO `Shop_Image` (`link`) VALUES
("img/webshop/black-shoes.jpg"), ("img/webshop/leather-shoes.jpg"), ("img/webshop/darkblue-jeans.jpg"),
("img/webshop/blue-shirt.jpg"), ("img/webshop/tshirt.png"), ("img/webshop/silver-clock.jpg"),
("img/webshop/sunhat.png"), ("img/webshop/leather-clock.jpg"), ("img/webshop/green-jumper.png"),
("img/webshop/darkred-jumper.png"), ("img/webshop/darkblue-jumper.png");

-- Create Products
INSERT INTO `Shop_Product` (`prodName`, `description`, `imgLink`, `price`) VALUES
("Green Jumper", "En grymt snygg grön tröja/jumper", "img/webshop/green-jumper.png", 200),
("Red Jumper", "En grymt snygg mörkröd tröja/jumper", "img/webshop/darkred-jumper.png", 200),
("Svarta skor", "Sjukt snygga svarta skor", "img/webshop/black-shoes.jpg", 150),
("Walkers", "Skorna är riktiga läderskor, precis som produktens namn, så är det grymma för walking!", "img/webshop/leather-shoes.jpg", 500),
("Silvrig klocka", "En klocka med riktigt silver. Ett mästervärk.", "img/webshop/silver-clock.jpg", 2000),
("Läderklocka", "En klocka som har äkta läder, grymt snygg under sommaren.", "img/webshop/leather-clock.jpg", 1500),
("Solhatt", "Denna hatten är för dig som vill se coolast och snyggast ut på stranden och vid poolen!", "img/webshop/sunhat.png", 300),
("Mörkblå Jumper", "En härlig långärmad tröja, skön att ha när det är lite kyligt ute.", "img/webshop/darkblue-jumper.png", 350);

-- Combinde categories with products
INSERT INTO `Shop_Prod2Cat` (`prod_id`, `cat_id`) VALUES
(1, 1), (1, 4),
(2, 1), (2, 4),
(3, 3),
(4, 3), (4, 4),
(5, 2),
(6, 2), (6, 5),
(7, 2), (7, 5),
(8, 1), (8, 4);

-- Create users
INSERT INTO `Shop_User` (`firstName`, `lastName`, `name`, `pass`, `info`, `email`, `authority`) VALUES
("Nicklas", "Envall", "Nicklas766", "$2y$10$8Fhmz0Nzo4jmmFXOtTHJYO.S92k8XYcny7udxptF8jF9PcBXxMMSG", "info", "nicklas766@live.se", "Admin"),
("doe", "doe", "doe", "$2y$10$8Fhmz0Nzo4jmmFXOtTHJYO.S92k8XYcny7udxptF8jF9PcBXxMMSG", "info", "nicklas766@live.se", "Admin"),
("Sven", "Svensson", "yes", "$2y$10$8Fhmz0Nzo4jmmFXOtTHJYO.S92k8XYcny7udxptF8jF9PcBXxMMSG", "info", "nicklas766@live.se", "Customer"),
("Sven2", "Svensson2", "yes2", "$2y$10$8Fhmz0Nzo4jmmFXOtTHJYO.S92k8XYcny7udxptF8jF9PcBXxMMSG", "info", "nicklas766@live.se", "Customer");

-- Create blogposts
INSERT INTO `Shop_Content` (`slug`, `type`, `title`, `data`, `filter`, `published`) VALUES
    ("forsta-inlagg", "post", "Vårt första inlägg!", "Hej, välkommen till vår hemsida! Detta är en e-butik som säljer kläder av hög kvalité. Vi önskar dig en riktigt fin dag!", "link,nl2br", "2017-05-20"),
    ("vart-utbud", "post", "Vårt utbud", "Vi erbjuder många olika typer av kläder. Just nu fokuserar vi på skor, tröjor/jumpers ochaccessoarer", "nl2br", "2017-05-21"),
    ("ny-kundsida", "post", "Ny kundsida", "Nu har vi uppdaterat alla kunders profilsidor. Vi har gjort så att alla kan se sin orderhistorik, hur coolt är inte det?!", "nl2br", "2017-05-24"),
    ("ny-funktion-for-kundsida", "post", "Ny funktion för kundsidan!", "Vi har tjatat på vår webbprogrammerare att skapa en funktion för våra kunder så att de kan skapa ärenden. Nu är han äntligen klar! Om du av någon anledning behöver kontakta oss, så kan du skapa ett ärende på din profilsida! Se till att resfresha din sida så du inte missar ett meddelande! :)", "markdown", "2017-05-25"),
    ("nya-varor-pa-lagret", "post", "Nya varor på lagret", "Vi har nyligen handlat in massor av nya kläder till lagret. Vi har bunkrat upp rejält. Titta gärna på produktsidan om det finns något du vill ha.", "nl2br", "2017-05-26"),
    ("erbjudanden", "post", "Erbjudanden", "Nu är det snart sommar och det är vecka 22. Det firar vi med erbjudanden för veckan! Gå till första-sidan för att se alla erbjudanden för veckan.", "nl2br", "2017-05-29"),
    ("nojda-kunder", "post", "Nöjda kunder", "Vi har haft många kunder som kontaktar oss via vår ärende-funktion på sidan, bara för att berätta hur nöjda de är. Vi blir otroligt glada över detta och vill tacka ALLA våra kunder. För de är verkligen bäst. Nästa vecka så kommer ni se riktigt bra erbjudanden för veckan.. håll utkik för det! Hej svejs! :)", "markdown", "2017-05-30");

-- Create pages
INSERT INTO `Pages` (`about`, `aboutFilter`, `footer`, `footerFilter`) VALUES
    ("Detta är om-sidan", "markdown", "Nicklas Footer", "markdown");

-- Recommend two products
INSERT INTO `RecommendedProduct` (`prod_id`) VALUES
    (1),
    (3);

-- Create two deals for the week
INSERT INTO `WeekDeal` (`prod_id`, `week`, `newPrice`) VALUES
    (1, (select WEEK(CURDATE())), 100),
    (3, (select WEEK(CURDATE())), 50);

-- Uppdate inventory, this will also trigger LatestProduct Table with three products
CALL updateInventory(1, "A101", 1000);
CALL updateInventory(3, "A101", 300);
CALL updateInventory(2, "A101", 3);


-- Errands and messages in the errands
-- first errand, closed
INSERT INTO `CustomerErrand` (`cst_id`, `title`, `description`) VALUES
(3, "Har inte fått min vara", "Hej! Jag har fortfarande inte fått min vara vad ska jag göra?");

INSERT INTO `ErrandText` (`senders_id`, `errand_id`, `sent_text`) VALUES
(1, 1, "Hej! Tråkigt att höra, kan jag få ordernumret? Så ska jag hjälpa dig."),
(3, 1, "Ingen fara, vill bara att det ska lösa sig!
    Jag ser nu att jag inte ens har gjort en beställning. Jag gör om beställningen"),
(1, 1, "Okej toppen att det löste sig!"),
(1, 1, "# Ditt ärende har stängts");

UPDATE CustomerErrand SET status = 'closed' WHERE id=1;

-- Second errand, not closed
INSERT INTO `CustomerErrand` (`cst_id`, `title`, `description`) VALUES
(4, "Trasig vara", "Min vara är trasig! Vad ska jag göra?");

INSERT INTO `ErrandText` (`senders_id`, `errand_id`, `sent_text`) VALUES
(1, 2, "Hej! Under leveransen av just din order så skedde det ett fel vid transporten som skadade varorna."),
(4, 2, "Jag förstår. Kommer ni skicka en ny produkt?");

---------------

-- ------------------------------------------------------------------------

-- ------------------------------------------------------------------------

-- ------------------------------------------------------------------------
--
-- Create view for product
--
DROP VIEW IF EXISTS ProductView;
CREATE VIEW ProductView
AS
SELECT P.id as id,
P.prodName AS prodName,
GROUP_CONCAT(PC.category) AS category,
P.description as description,
StockStatus(INV.amount) AS InStock,
P.imgLink as image,
controlDeal(P.id, CURDATE()) as price

FROM (((Shop_Prod2Cat AS P2C
INNER JOIN Shop_Product AS P ON P2C.prod_id = P.id)
INNER JOIN Shop_ProdCategory AS PC ON P2C.cat_id = PC.id)
INNER JOIN Shop_Inventory AS INV ON INV.prod_id = P.id)
GROUP BY P.id;


--
-- Create view for product
--
DROP VIEW IF EXISTS AdminProductView;
CREATE VIEW AdminProductView
AS
SELECT P.id as id,
P.prodName AS prodName,
GROUP_CONCAT(PC.category) AS category,
P.description as description,
StockStatus(INV.amount) AS InStock,
P.imgLink as image,
P.price as price,
controlDeal(P.id, CURDATE()) as WeekDeal

FROM (((Shop_Prod2Cat AS P2C
INNER JOIN Shop_Product AS P ON P2C.prod_id = P.id)
INNER JOIN Shop_ProdCategory AS PC ON P2C.cat_id = PC.id)
INNER JOIN Shop_Inventory AS INV ON INV.prod_id = P.id)
GROUP BY P.id;


--
-- View connecting products with their place in the inventory
-- and offering reports for inventory and sales personal.
--
DROP VIEW IF EXISTS VInventory;
CREATE VIEW VInventory AS
SELECT
S.shelf, I.prod_id,
S.description AS location,
I.amount

FROM Shop_Inventory AS I
INNER JOIN Shop_InvenShelf AS S ON I.shelf_id = S.shelf
ORDER BY S.shelf;



--
-- Create view for the ShoppingCart
--
DROP VIEW IF EXISTS VShoppingCart;
CREATE VIEW VShoppingCart AS
SELECT
P.id AS prod_id, C.id AS Customer_ID,
P.prodName as Item,
SUM(controlDeal(P.id, CURDATE())) as Price, COUNT(*) as Amount

FROM Shop_ShoppingCart AS SC
INNER JOIN Shop_User AS C ON SC.customer_id = C.id
INNER JOIN Shop_Product AS P ON P.id = SC.prod_id
GROUP BY C.id, P.id
ORDER BY P.id;



--
-- Create view for the VORDER_INFO
--
DROP VIEW IF EXISTS VOrder_Info;
CREATE VIEW VOrder_Info AS
SELECT
P.prodName AS Item, CO.id AS id, O.amount as Amount,
SUM(controlDeal(P.id, CO.created) * O.amount) as Price

FROM Shop_Cst_Order AS CO
INNER JOIN Shop_OrderRow AS O ON CO.id = O.order
INNER JOIN Shop_Product AS P ON P.id = O.Product
GROUP BY CO.id, P.id
ORDER BY CO.id;

SELECT * FROM VOrder_Info WHERE id = 1;
--
-- Create view for the VCST_ORDER
--
DROP VIEW IF EXISTS VCst_Order;
CREATE VIEW VCst_Order AS
SELECT
CO.id AS OrderNumber, C.id AS CostumerNumber,
CO.created as OrderDate,
SUM(controlDeal(P.id, CO.created) * O.amount) as Price, C.firstName, C.lastName,
CO.status as Status

FROM Shop_Cst_Order AS CO
INNER JOIN Shop_OrderRow AS O ON CO.id = O.order
INNER JOIN Shop_User AS C ON CO.customer_id = C.id
INNER JOIN Shop_Product AS P ON P.id = O.Product
GROUP BY CO.id
ORDER BY CO.id DESC;

--
-- Create view for the RECOMMENDEDPRODUCT
--
DROP VIEW IF EXISTS VRecommendedProduct;
CREATE VIEW VRecommendedProduct AS
SELECT
P.id AS prodId, P.prodName AS Item, P.imgLink AS img,
controlDeal(P.id, CURDATE()) AS price

FROM RecommendedProduct AS RD
INNER JOIN Shop_Product AS P ON P.id = RD.prod_id
ORDER BY RD.id;

SELECT * FROM VRecommendedProduct;


--
-- Create view for the WEEKDEAL
--

DROP VIEW IF EXISTS VWeekDeal;
CREATE VIEW VWeekDeal AS
SELECT
P.id AS prodId, P.prodName AS Item, P.imgLink AS img,
P.price AS oldPrice, WD.newPrice AS newPrice, WD.week AS week

FROM WeekDeal AS WD
INNER JOIN Shop_Product AS P ON P.id = WD.prod_id
ORDER BY WD.id;

--
-- Create view for the LATESTPRODUCT
--
DROP VIEW IF EXISTS VLatestProduct;
CREATE VIEW VLatestProduct AS
SELECT
P.id AS prodId, P.prodName AS Item, P.imgLink AS img,
controlDeal(P.id, CURDATE()) AS price

FROM LatestProduct AS LD
INNER JOIN Shop_Product AS P ON P.id = LD.prod_id
ORDER BY LD.id;

SELECT * FROM VLatestProduct;


--
-- Create view for the amount of products connected to product
--
DROP VIEW IF EXISTS VFontCat;
CREATE VIEW VFontCat AS
SELECT
COUNT(P2C.cat_id) AS Amount,
C.category AS category

FROM Shop_Prod2Cat AS P2C
INNER JOIN Shop_ProdCategory AS C ON C.id = P2C.cat_id
GROUP BY C.id
ORDER BY COUNT(P2C.cat_id) DESC;



DROP VIEW IF EXISTS ErrandView;
CREATE VIEW ErrandView
AS
SELECT ET.sent_text AS sent_text,
ET.senders_id AS user, ET.errand_id as errand_id,
User.name AS user_name, ET.created AS created

FROM ((CustomerErrand AS CE
INNER JOIN ErrandText AS ET ON ET.errand_id = CE.id)
INNER JOIN Shop_User AS User ON User.id = ET.senders_id);

SELECT * FROM ErrandView;

-- CALL createOrder(2);

-- SELECT * FROM VShoppingCart;

-- SELECT * FROM VShoppingCart;
-- CALL createOrder(2);

-- SELECT * FROM VShoppingCart;
CREATE UNIQUE INDEX name_unique ON Shop_User (name);
CREATE INDEX index_price ON Shop_Product(price);
CREATE INDEX index_status ON Shop_Cst_Order(status);
