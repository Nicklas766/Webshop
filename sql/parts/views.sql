
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
