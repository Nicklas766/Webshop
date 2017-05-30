<?php
// GET ID FIRST
$prodID = getPost("contentId") ?: getGet("id");
if (!is_numeric($prodID)) {
    die("Not valid for content id.");
}

$res = $app->connect->getRes("SELECT * FROM ProductView WHERE id = '$prodID'");
// CONTROL SUCCESS
$msg = getPost("msg") ?: getGet("msg");
if ($msg == "success") {
    echo "<p class='success'>Du la till ". $res["prodName"]." i din kundvagn</p>";
}
if ($msg == "fail") {
    echo "<p class='warning'>Varan finns inte i lager. (Vi räknar även om du skulle ha några i din kundvagn)</p>";
}
// Check if form posted and get incoming
if (hasKeyPost('add')) {
    // get user details and the id of product, then add it
    $prod_id = htmlentities($_POST['add']);
    $cstName = $app->session->get('name');
    $cst_id = $app->connect->getRes("SELECT * FROM Shop_User WHERE name LIKE '$cstName'")["id"];
    $app->customer->addToCart(intval($cst_id), intval($prod_id));
}

?>

<!-- SUBMIT/EDIT FORM -->

<div class="content-div">
    <p> <img src="<?= $res["image"] ?>" alt="notfound" height="150" width="150"> </p>
    <h1> <?= $res["prodName"] ?> </h1>
    <h1> <?= $res["description"] ?> </h1>
    <h1> <?= $res["price"] ?> SEK </h1>
    <h1> Finns i lager: <?= $res["InStock"] ?> </h1>

    <form action="<?= $app->url->create('product') ?>?id=<?= $res['id'] ?>" method="POST">
        <input type="hidden" name="add" value="<?= $res['id'] ?>">
        <button type="submit" style="font-size:16px">Lägg till i kundvagen <i class="material-icons">add_shopping_cart</i></button>
    </form>

</div>
