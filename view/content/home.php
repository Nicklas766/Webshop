<div class="content-div">
  <h1> Hem </h1>
  <p> Här är lite text Här är lite text Här är lite text Här är lite text </p>
</div>



<h1> tre senaste inläggen </h1>
<!-- Three latest blogposts -->
<div class="flex-container">
    <?php
    $app->blog->showBlog(3);
        ?>
</div>



<h1> Veckans Erbjudande </h1>
<!-- WeekDeal -->
<?php
$res = $app->connect->getAllRes("SELECT * FROM VWeekDeal WHERE week = (select WEEK(CURDATE(), 1))");
?>
<div class="flex-container">
    <?php foreach ($res as $row) :?>
        <a class="widget" href="<?= $app->url->create('product')?>?id=<?= $row["prodId"] ?>">
            <p><?= $row["Item"]?> </p>
            <p> <img src="<?= $row["img"] ?>" alt="notfound" height="75px" width="100%"> </p>
            <p>Förut: <strike><?= $row["oldPrice"]?> SEK </strike></p>
            <p>Nu : <?= $row["newPrice"]?> SEK </p>
        </a>
    <?php endforeach; ?>
</div>



<h1> Rekommenderade </h1>
<!-- Recommended -->
<?php
$res = $app->connect->getAllRes("SELECT * FROM VRecommendedProduct  GROUP BY prodId");
?>
<div class="flex-container">
    <?php foreach ($res as $row) :?>
        <a class="widget" href="<?= $app->url->create('product')?>?id=<?= $row["prodId"] ?>">
            <h3><?= $row["Item"]?> </h3>
            <p> <img src="<?= $row["img"] ?>" alt="notfound" height="75px" width="100%"> </p>
            <p> <?= $row["price"]?> SEK </p>
        </a>
    <?php endforeach; ?>
</div>



 <h1> Senaste inkomna produkter (3st) </h1>
<!-- Latest three products -->

<?php
$res = $app->connect->getAllRes("SELECT * FROM VLatestProduct ORDER BY prodId DESC LIMIT 3");
?>
<div class="flex-container">
    <?php foreach ($res as $row) :?>
        <a class="widget" href="<?= $app->url->create('product')?>?id=<?= $row["prodId"] ?>">
            <h3><?= $row["Item"]?> </h3>
            <p> <img src="<?= $row["img"] ?>" alt="notfound" height="75px" width="100%"> </p>
            <p> <?= $row["price"]?> SEK </p>
        </a>
    <?php endforeach; ?>
</div>

<h1> Top 3 mest sålda (3st) </h1>
<!-- Top three most sold  -->
<?php
$res = $app->connect->getAllRes("SELECT * FROM Shop_Product ORDER BY soldAmount DESC LIMIT 3");
?>
<div class="flex-container">
    <?php foreach ($res as $row) :?>
        <a class="widget" href="<?= $app->url->create('product')?>?id=<?= $row["id"] ?>">
           <h3><?= $row["prodName"]?> </h3>
           <p> <img src="<?= $row["imgLink"] ?>" alt="notfound" height="75px" width="100%"> </p>
           <p> Antal sålda <?= $row["soldAmount"]?> </p>
       </a>
    <?php endforeach; ?>
</div>



<h1> Fonter för kategorier </h1>
<!-- Font sizes for categories based on amount of products connected to it -->

    <?php
    $res = $app->connect->getAllRes("SELECT * FROM VFontCat");
    ?>
    <div class="content-div">
    <?php foreach ($res as $row) :?>
           <a href="<?= $app->url->create('products')?>?cat=<?= $row["category"] ?>" style="display: block; font-size:<?= $row["Amount"] + 10?>px;"> <?= $row["category"]?> (<?= $row["Amount"]?>) </a>
    <?php endforeach; ?>
</div>
