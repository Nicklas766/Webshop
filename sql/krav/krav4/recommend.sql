USE userprofiles;
SET NAMES utf8;
--
-- Create table for RecommendedProduct
--
DROP TABLE IF EXISTS `RecommendedProduct`;
CREATE TABLE `RecommendedProduct`
(
  `id` INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
  `prod_id` INT,

  FOREIGN KEY (`prod_id`) REFERENCES `Product` (`id`)

) ENGINE INNODB CHARACTER SET utf8 COLLATE utf8_swedish_ci;


INSERT INTO `RecommendedProduct` (`prod_id`) VALUES
    (1),
    (3);


    --
    -- Create view for the RecommendedProduct
    --
    DROP VIEW IF EXISTS VRecommendedProduct;
    CREATE VIEW VRecommendedProduct AS
    SELECT
    P.id AS prodId, P.prodName AS Item, P.imgLink AS img,
    controlDeal(P.id, CURDATE()) AS price

    FROM RecommendedProduct AS RD
    INNER JOIN Product AS P ON P.id = RD.prod_id
    ORDER BY RD.id;

    SELECT * FROM VRecommendedProduct;
