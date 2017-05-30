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
