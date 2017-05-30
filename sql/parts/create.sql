-- ------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------
-- CREATE ALL STUFF
--

-- Create Categories
INSERT INTO `Shop_ProdCategory` (`category`) VALUES
("Jumper"), ("Accessoar"), ("Skor"), ("Vinter"), ("Sommar");

-- Create shelfs
INSERT INTO `Shop_InvenShelf` (`shelf`, `description`) VALUES
("NONE", "Currently not in stock"),
("A101", "House A, shelf 101"),
("A102", "House A, shelf 102");

-- Create images
INSERT INTO `Shop_Image` (`link`) VALUES
("img/webshop/black-shoes.jpg"), ("img/webshop/leather-shoes.jpg"), ("img/webshop/darkblue-jeans.jpg"),
("img/webshop/blue-shirt.jpg"), ("img/webshop/tshirt.png"), ("img/webshop/silver-clock.jpg"),
("img/webshop/sunhat.png"), ("img/webshop/leather-clock.jpg"), ("img/webshop/green-jumper.png"),
("img/webshop/darkred-jumper.png"), ("img/webshop/darkblue-jumper.png");

-- Create Products
INSERT INTO `Shop_Product` (`prodName`, `description`, `imgLink`, `price`) VALUES
("Green Jumper", "En grymt snygg grön tröja/jumper", "img/webshop/green-jumper.png", 200),
("Red Jumper", "En grymt snygg mörkröd tröja/jumper", "img/webshop/darkred-jumper.png", 200),
("Svarta skor", "Sjukt snygga svarta skor", "img/webshop/black-shoes.jpg", 150),
("Walkers", "Skorna är riktiga läderskor, precis som produktens namn, så är det grymma för walking!", "img/webshop/leather-shoes.jpg", 500),
("Silvrig klocka", "En klocka med riktigt silver. Ett mästervärk.", "img/webshop/silver-clock.jpg", 2000),
("Läderklocka", "En klocka som har äkta läder, grymt snygg under sommaren.", "img/webshop/leather-clock.jpg", 1500),
("Solhatt", "Denna hatten är för dig som vill se coolast och snyggast ut på stranden och vid poolen!", "img/webshop/sunhat.png", 300),
("Mörkblå Jumper", "En härlig långärmad tröja, skön att ha när det är lite kyligt ute.", "img/webshop/darkblue-jumper.png", 350);

-- Combinde categories with products
INSERT INTO `Shop_Prod2Cat` (`prod_id`, `cat_id`) VALUES
(1, 1), (1, 4),
(2, 1), (2, 4),
(3, 3),
(4, 3), (4, 4),
(5, 2),
(6, 2), (6, 5),
(7, 2), (7, 5),
(8, 1), (8, 4);

-- Create users
INSERT INTO `Shop_User` (`firstName`, `lastName`, `name`, `pass`, `info`, `email`, `authority`) VALUES
("Nicklas", "Envall", "Nicklas766", "$2y$10$8Fhmz0Nzo4jmmFXOtTHJYO.S92k8XYcny7udxptF8jF9PcBXxMMSG", "info", "nicklas766@live.se", "Admin"),
("doe", "doe", "doe", "$2y$10$8Fhmz0Nzo4jmmFXOtTHJYO.S92k8XYcny7udxptF8jF9PcBXxMMSG", "info", "nicklas766@live.se", "Admin"),
("Sven", "Svensson", "yes", "$2y$10$8Fhmz0Nzo4jmmFXOtTHJYO.S92k8XYcny7udxptF8jF9PcBXxMMSG", "info", "nicklas766@live.se", "Customer");

-- Create blogposts
INSERT INTO `Shop_Content` (`slug`, `type`, `title`, `data`, `filter`, `published`) VALUES
    ("forsta-inlagg", "post", "Vårt första inlägg!", "Hej, välkommen till vår hemsida! Detta är en e-butik som säljer kläder av hög kvalité. Vi önskar dig en riktigt fin dag!", "link,nl2br", "2017-05-20"),
    ("vart-utbud", "post", "Vårt utbud", "Vi erbjuder många olika typer av kläder. Just nu fokuserar vi på skor, tröjor/jumpers ochaccessoarer", "nl2br", "2017-05-21"),
    ("ny-kundsida", "post", "Ny kundsida", "Nu har vi uppdaterat alla kunders profilsidor. Vi har gjort så att alla kan se sin orderhistorik, hur coolt är inte det?!", "nl2br", "2017-05-24"),
    ("ny-funktion-for-kundsida", "post", "Ny funktion för kundsidan!", "Vi har tjatat på vår webbprogrammerare att skapa en funktion för våra kunder så att de kan skapa ärenden. Nu är han äntligen klar! Om du av någon anledning behöver kontakta oss, så kan du skapa ett ärende på din profilsida! Se till att resfresha din sida så du inte missar ett meddelande! :)", "markdown", "2017-05-25"),
    ("nya-varor-pa-lagret", "post", "Nya varor på lagret", "Vi har nyligen handlat in massor av nya kläder till lagret. Vi har bunkrat upp rejält. Titta gärna på produktsidan om det finns något du vill ha.", "nl2br", "2017-05-26"),
    ("erbjudanden", "post", "Erbjudanden", "Nu är det snart sommar och det är vecka 22. Det firar vi med erbjudanden för veckan! Gå till första-sidan för att se alla erbjudanden för veckan.", "nl2br", "2017-05-29"),
    ("nojda-kunder", "post", "Nöjda kunder", "Vi har haft många kunder som kontaktar oss via vår ärende-funktion på sidan, bara för att berätta hur nöjda de är. Vi blir otroligt glada över detta och vill tacka ALLA våra kunder. För de är verkligen bäst. Nästa vecka så kommer ni se riktigt bra erbjudanden för veckan.. håll utkik för det! Hej svejs! :)", "markdown", "2017-05-30");

-- Create pages
INSERT INTO `Pages` (`about`, `aboutFilter`, `footer`, `footerFilter`) VALUES
    ("Detta är om-sidan", "markdown", "Nicklas Footer", "markdown");

-- Recommend two products
INSERT INTO `RecommendedProduct` (`prod_id`) VALUES
    (1),
    (3);

-- Create two deals for the week
INSERT INTO `WeekDeal` (`prod_id`, `week`, `newPrice`) VALUES
    (1, (select WEEK(CURDATE())), 100),
    (3, (select WEEK(CURDATE())), 50);

-- Uppdate inventory, this will also trigger LatestProduct Table with three products
CALL updateInventory(1, "A101", 1000);
CALL updateInventory(3, "A101", 300);
CALL updateInventory(2, "A101", 3);


-- Errands and messages in the errands
-- first errand, closed
INSERT INTO `CustomerErrand` (`cst_id`, `title`, `description`) VALUES
(3, "Har inte fått min vara", "Hej! Jag har fortfarande inte fått min vara vad ska jag göra?");

INSERT INTO `ErrandText` (`senders_id`, `errand_id`, `sent_text`) VALUES
(1, 1, "Hej! Tråkigt att höra, kan jag få ordernumret? Så ska jag hjälpa dig."),
(3, 1, "Ingen fara, vill bara att det ska lösa sig!
    Jag ser nu att jag inte ens har gjort en beställning. Jag gör om beställningen"),
(1, 1, "Okej toppen att det löste sig!"),
(1, 1, "# Ditt ärende har stängts");

UPDATE CustomerErrand SET status = 'closed' WHERE id=1;

-- Second errand, not closed
INSERT INTO `CustomerErrand` (`cst_id`, `title`, `description`) VALUES
(4, "Trasig vara", "Min vara är trasig! Vad ska jag göra?");

INSERT INTO `ErrandText` (`senders_id`, `errand_id`, `sent_text`) VALUES
(1, 2, "Hej! Under leveransen av just din order så skedde det ett fel vid transporten som skadade varorna."),
(2, 2, "Jag förstår. Kommer ni skicka en ny produkt?");

---------------

-- ------------------------------------------------------------------------
