<?php
$cstName = $app->session->get("name");
$cst = $app->connect->getRes("SELECT * FROM Shop_User WHERE name LIKE '$cstName'");
$cstId = $cst["id"];
$res = $app->connect->getAllRes("SELECT * FROM VCst_Order WHERE CostumerNumber = '$cstId'")[0];
?>


<div class="content-div">
<h1>Tack för din beställning <?= $cstName ?>!</h1>

<h2>Du hittar alltid din orderhistorik på din <a href="<?= $app->url->create('profile') ?>">profil-sida</a>. Men nedan ser du din senaste order,</h2>
</div>
        <div class="content-div" style="background:white; color:black; max-width:700px;">
        <div class="content-div" style="background:black; box-shadow:none;">
            <h2> ORDER </h2>
        </div>

        <div style="width:50%; margin-left:auto; margin-right:auto;">
            <h1> WebShop </h1>
            <table>
                    <tr><th>Skapad:</th>
                    <td><?= $res["OrderDate"] ?></td></tr>
                    <tr><th>Ordernummer:</th>
                    <td><?= $res["OrderNumber"] ?></td></tr>
            </table>


            <h2> Kund information </h2>

            <table>
                <tr><th>Namn:</th>
                <td><?= $res["firstName"] ?> <?= $res["lastName"] ?></td></tr>
                <tr><th>Kund ID:</th>
                <td><?= $res["CostumerNumber"] ?></td></tr>

            </table>
        </div>

        <h2> Leverans </h2>
        <?php
            $order = $res["OrderNumber"];
            $order = $app->connect->getAllRes("SELECT * FROM VOrder_Info WHERE id = $order;");
        ?>
        <table style="width:50%; margin-left:auto; margin-right:auto;">
            <tr class="first">
            <th> Produkt </th>
            <th> Antal </th>
            <th> Pris </th>
        </tr>
        <?php foreach ($order as $product) :?>
            <tr>
            <td> <?= $product["Item"] ?> </td>
            <td> <?= $product["Amount"] ?> </td>
            <td> <?= $product["Price"] ?> SEK </td>
            </tr>

            <?php endforeach; ?>
    </table>
    <table style="width:60%; margin-left:auto; margin-top:20px;">
            <tr><th>Totala beloppet:</th>
            <td> <?= $res["Price"] ?> SEK</td></tr>
    </table>


    </div>
