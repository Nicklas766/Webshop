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
