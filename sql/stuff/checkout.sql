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
