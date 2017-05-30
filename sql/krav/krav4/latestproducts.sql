USE userprofiles;
SET NAMES utf8;
--
-- Create table for RecommendedProduct
--
DROP TABLE IF EXISTS `LatestProduct`;
CREATE TABLE `LatestProduct`
(
  `id` INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
  `prod_id` INT,

  FOREIGN KEY (`prod_id`) REFERENCES `Product` (`id`)

) ENGINE INNODB CHARACTER SET utf8 COLLATE utf8_swedish_ci;




    --
    -- Create view for the LatestProduct
    --
    DROP VIEW IF EXISTS VLatestProduct;
    CREATE VIEW VLatestProduct AS
    SELECT
    P.id AS prodId, P.prodName AS Item, P.imgLink AS img,
    controlDeal(P.id, CURDATE()) AS price

    FROM LatestProduct AS LD
    INNER JOIN Product AS P ON P.id = LD.prod_id
    ORDER BY LD.id;

    SELECT * FROM VLatestProduct;
