
-- Denna ligger i createOrder proceduren
-- Increase soldAmount in product Table with join with VShoppingCart
UPDATE Product p, VShoppingCart SC
   SET p.soldAmount = p.soldAmount + SC.Amount
 WHERE p.id = SC.prod_id
   AND SC.customer_id = customerId;
