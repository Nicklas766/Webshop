-- Ensure UTF8 as chacrter encoding within connection.

USE userprofiles;
SET NAMES utf8;
--
-- Create table for Content
--
DROP TABLE IF EXISTS Pages;
CREATE TABLE Pages
(
  `id` INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
  `about` TEXT,
  `aboutFilter` VARCHAR(80) DEFAULT NULL,
  `footer` TEXT,
  `footerFilter` VARCHAR(80) DEFAULT NULL

) ENGINE INNODB CHARACTER SET utf8 COLLATE utf8_swedish_ci;


INSERT INTO `Pages` (`about`, `aboutFilter`, `footer`, `footerFilter`) VALUES
    ("Detta är om-sidan", "markdown", "Nicklas Footer", "markdown");

SELECT `id`, `about`, `aboutFilter`, `footer`, `footerFilter`;
