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

SELECT * FROM VFontCat;
