<?php
    $cstName = $app->session->get('name');
    $cst = $app->connect->getRes("SELECT * FROM Shop_User WHERE name LIKE '$cstName'");
    $cstId = $cst["id"];

// Check if form posted and get incoming
if (hasKeyPost('doSave')) {
        // get all product info
        $params = getPost([
            "prodId",
            "oldAmount",
            "newAmount"
        ]);
        print_r($params);
        $app->customer->removeProduct($params, $cstId);
}

if (hasKeyPost('doPurchase')) {
    $app->customer->createOrder($cstId);
}

    $cart = $app->connect->getAllRes("SELECT * FROM VShoppingCart WHERE Customer_ID LIKE '$cstId'");
?>
<div class="content-div">
    <h1> Hej <?= $cst["name"] ?>!</h1>
    <h2> Här är din kundvagn, kontrollera så allt är rätt innan du gör beställningen.</h2>
</div>
<div class="content-div" style="width:50%;">
<table>
    <tr class="first">
    <th> Produkt </th>
    <th> Pris </th>
    <th> Antal </th>
    <th> Spara </th>
</tr>

<?php foreach ($cart as $row) :?>

        <tr>
        <td> <?= $row["Item"] ?> </td>
        <td> <?= $row["Price"] ?> SEK </td>
        <form method="post">
        <input type="hidden" name="prodId" value="<?= $row["prod_id"] ?>">
        <input type="hidden" name="oldAmount" value="<?= $row["Amount"] ?>">
        <td><select name="newAmount">
         <option value="<?= $row["Amount"] ?>"><?= $row["Amount"] ?></option>
            <?php
            for ($i = $row["Amount"] - 1; $i > -1; $i--) {
                echo '<option value="'. $i .'">'. $i .'</option>';
            }
                ?>
     </select></td>

        <td><button type="submit" name="doSave" ><span class='material-icons'>save</span></button> </td>
    </form>

    </tr>

<?php endforeach; ?>
</table>
</div>
<form method="post">
    <button type="submit" style="margin-top: 20px;" name="doPurchase" >Slutför köp</button>
</form>
