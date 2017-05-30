USE userprofiles;
SET NAMES utf8;
--
-- Create table for Content
--
DROP TABLE IF EXISTS `WeekDeal`;
CREATE TABLE `WeekDeal`
(
  `id` INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
  `prod_id` INT,
  `week` INT,
  `newPrice` INT,

  FOREIGN KEY (`prod_id`) REFERENCES `Product` (`id`)

) ENGINE INNODB CHARACTER SET utf8 COLLATE utf8_swedish_ci;


INSERT INTO `WeekDeal` (`prod_id`, `week`, `newPrice`) VALUES
    (1, (select WEEK(CURDATE())), 100),
    (3, (select WEEK(CURDATE())), 50);


    DROP VIEW IF EXISTS VWeekDeal;
    CREATE VIEW VWeekDeal AS
    SELECT
    P.id AS prodId, P.prodName AS Item, P.imgLink AS img,
    P.price AS oldPrice, WD.newPrice AS newPrice, WD.week AS week

    FROM WeekDeal AS WD
    INNER JOIN Product AS P ON P.id = WD.prod_id
    ORDER BY WD.id;



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

SELECT addweekDeal(1, 23, 21);
SELECT * FROM WeekDeal;





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
        RETURN (SELECT price FROM Product WHERE `id` = prodId);
	END IF;
END
//

DELIMITER ;
