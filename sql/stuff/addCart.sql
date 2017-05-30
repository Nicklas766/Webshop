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
    SET amountInStock = (SELECT amount FROM Inventory WHERE prod_id = prodId);
    SET currentBasket = (SELECT Amount FROM VShoppingCart WHERE Customer_ID = customerId AND prod_id = prodId UNION ALL SELECT 0 FROM dual WHERE NOT EXISTS (SELECT * FROM VShoppingCart WHERE Customer_ID = customerId AND prod_id = prodId));

    -- If product exists do a rollback.
    IF (amountInStock - currentBasket) <= 0 THEN
        RETURN "FALSE";
    ELSE
		INSERT INTO `ShoppingCart` (`customer_id`, `prod_id`) VALUES (customerId, prodId);
        RETURN "TRUE";
	END IF;
END
//

DELIMITER ;



-- PROCEDURE for updating product, first product then category and p2c

DROP PROCEDURE IF EXISTS addCart;
DELIMITER //

-- adds category
CREATE PROCEDURE addCart(
     customerId INT,
     prodId INT
)
BEGIN
    DECLARE amountInStock INT;
    DECLARE currentBasket INT;
    START TRANSACTION;

    SET amountInStock = (SELECT amount FROM Inventory WHERE prod_id = prodId);
    SET currentBasket = (SELECT Amount FROM VShoppingCart WHERE Customer_ID = 1 AND prod_id = 4 UNION ALL SELECT 0 FROM dual WHERE NOT EXISTS (SELECT * FROM VShoppingCart WHERE Customer_ID = 1 AND prod_id = 4));

    IF (amountInStock - currentBasket) <= 0 THEN
        ROLLBACK;
        SELECT "Sorry! Based on your current ShoppingCart, that order won't work with the Stock.";
    ELSE
        INSERT INTO `ShoppingCart` (`customer_id`, `prod_id`) VALUES (customerId, prodId);
        COMMIT;
        END IF;
END
//
DELIMITER ;
