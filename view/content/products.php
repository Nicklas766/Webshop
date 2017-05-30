<?php
// Check if form posted and get incoming
if (hasKeyPost('add')) {
    // get user details and the id of product, then add it
    $prod_id = htmlentities($_POST['add']);
    $cstName = $app->session->get('name');
    $cst_id = $app->connect->getRes("SELECT * FROM Shop_User WHERE name LIKE '$cstName'")["id"];
    $app->customer->addToCart(intval($cst_id), intval($prod_id));
}

// SUCCESS MESSAGE VIA GET
$msg = getPost("msg") ?: getGet("msg");
if ($msg == "success") {
    echo "<p class='success'> Du la till produkten i din kundvagn!</p>";
}
if ($msg == "fail") {
    echo "<p class='warning'>Varan finns inte i lager. (Vi räknar även om du skulle ha några i din kundvagn)</p>";
}

// Get $res and sort it with current GET, or use default
$res = $app->product->sortProduct();
$max = $res[1];
$res = $res[0];

?>


<div class="content-div shopHeader">
    <h1>Våra produkter</h1>

<!-- Sid delen för produkterna -->
    <div class="flex-container">
        <div class="shop-widget" style="width:35%;">
            <!-- Kategori delen-->
            <ul>
                <?= categoryController($app); ?>
            </ul>
        </div>

    <div class="shop-widget" style="width:20%;">
            <p>Antal per sida:
                <a href="<?= mergeQueryString(["hits" => 2, "msg" => "none"]) ?>">2</a> |
                <a href="<?= mergeQueryString(["hits" => 4, "msg" => "none"]) ?>">4</a> |
                <a href="<?= mergeQueryString(["hits" => 8, "msg" => "none"]) ?>">8</a>
            </p>


    <?php
    // If search POST:ed, get new $res and ignore making clickable pages
    if (isset($_POST['search'])) {
        $search = htmlspecialchars($_POST['search']);
        $res = $app->connect->getAllRes("SELECT * FROM ProductView WHERE prodName LIKE '%$search%' OR description LIKE '%$search%'");
    } else {
        echo "<p> Bläddra: ";
        for ($i = 1; $i <= $max; $i++) {
            echo '<a href="'. mergeQueryString(["page" => $i, "msg" => "none"]) .'">'. $i .'</a> ';
        }
        echo "</p>";
    }


    ?>
        </div>

        <div class="shop-widget" style="width:10%;">
            <p style="float:left;"> Pris <?= orderby("price", $app) ?></p>
            <p style="margin-left:5px; float:left;"> Namn <?= orderby("prodName", $app) ?></p>
        </div>
        <div class="shop-widget" style="width:25%;">
                    <form action="<?= $app->url->create('products') ?>" method="POST">
                        <input style="width:50%;" name="search" value="" placeholder="Sök produkt">
                        <input style="width:30%;" type="submit" value="Sök">
                    </form>
        </div>

        </div>
        </div>


<?php

// IF we have no RES, that means the filtering doesnt exists, then kill and wrong message
if (!$res) {
    echo "<h1> Din sökning existerar inte </h1>";
    die();
}

?>
    <div class="flex-container">

        <?php foreach ($res as $row) :?>
            <a class="widget" href="<?= $app->url->create('product')?>?id=<?= $row["id"] ?>">
                <div class="img-container2">
                    <h2> <?= $row["prodName"] ?> </h2>

                        <img src="<?= $row["image"] ?>" alt="notfound">
                    </div>
                    <h4> <?= $row["price"] ?> SEK </h4>
                    <p> <?= $row["category"] ?> </p>
                    <i> Lager: <?= $row["InStock"] ?> </i>

                    <form action="<?= mergeQueryString(["id" =>  $row["id"]]) ?>" method="POST">
                        <input type="hidden" name="add" value="<?= $row['id'] ?>">
                        <button type="submit" style="font-size:16px">Lägg till i kundvagen <i class="material-icons">add_shopping_cart</i></button>
                    </form>
            </a>

        <?php endforeach; ?>

    </div>
