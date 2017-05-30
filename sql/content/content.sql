-- ------------------------------------------------------------------------
--
-- For lecture in oophp-v3 kmom03
--
-- CREATE DATABASE oophp;
-- GRANT ALL ON oophp.* TO user@localhost IDENTIFIED BY "pass";

USE userprofiles;

SET NAMES utf8;

--
-- Create table for Content
--
DROP TABLE IF EXISTS `Shop_Content`;
CREATE TABLE `Shop_Content`
(
  `id` INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
  `slug` CHAR(120) UNIQUE,

  `title` VARCHAR(120),
  `data` TEXT,
  `type` CHAR(20),
  `filter` VARCHAR(80) DEFAULT NULL,

  -- MySQL version 5.6 and higher
  -- `published` DATETIME DEFAULT CURRENT_TIMESTAMP,
  -- `created` DATETIME DEFAULT CURRENT_TIMESTAMP,
  -- `updated` DATETIME DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,

  -- MySQL version 5.5 and lower
  `published` DATETIME DEFAULT NULL,
  `created` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated` DATETIME DEFAULT NULL, --  ON UPDATE CURRENT_TIMESTAMP,
  `deleted` DATETIME DEFAULT NULL

) ENGINE INNODB CHARACTER SET utf8 COLLATE utf8_swedish_ci;


INSERT INTO `Shop_Content` (`slug`, `type`, `title`, `data`, `filter`) VALUES
    ("valkommen-till-min-blogg", "post", "Välkommen till min blogg!", "Detta är en bloggpost.\n\nNär det finns länkar till andra webbplatser så kommer de länkarna att bli klickbara.\n\nhttp://dbwebb.se är ett exempel på en länk som blir klickbar.", "link,nl2br"),
    ("nu-har-sommaren-kommit", "post", "Nu har sommaren kommit", "Detta är en bloggpost som berättar att sommaren har kommit, ett budskap som kräver en bloggpost.", "nl2br"),
    ("nu-har-hosten-kommit", "post", "Nu har hösten kommit", "Detta är en bloggpost som berättar att sommaren har kommit, ett budskap som kräver en bloggpost", "nl2br");
