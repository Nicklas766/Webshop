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
