USE userprofiles;
SET NAMES utf8;
--
-- Create table for Errands
--
DROP TABLE IF EXISTS `ErrandText`;
DROP TABLE IF EXISTS `CustomerErrand`;

CREATE TABLE `CustomerErrand`
(
  `id` INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
  `cst_id` INT,
  `title` VARCHAR(20),
  `description` TEXT,
  `created` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `status` VARCHAR(20) DEFAULT 'active',

  FOREIGN KEY (`cst_id`) REFERENCES `Shop_User` (`id`)

) ENGINE INNODB CHARACTER SET utf8 COLLATE utf8_swedish_ci;


CREATE TABLE `ErrandText`
(
  `id` INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
  `senders_id` INT,
  `errand_id` INT,
  `created` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `sent_text` TEXT,

  FOREIGN KEY (`errand_id`) REFERENCES `CustomerErrand` (`id`),
  FOREIGN KEY (`senders_id`) REFERENCES `Shop_User` (`id`)

) ENGINE INNODB CHARACTER SET utf8 COLLATE utf8_swedish_ci;







SELECT * FROM CustomerErrand;
SELECT * FROM ErrandText;

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
