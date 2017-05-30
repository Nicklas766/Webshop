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
