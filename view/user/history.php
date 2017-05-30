<?php

$cstName = $app->session->get("name");
$cst = $app->connect->getRes("SELECT * FROM Shop_User WHERE name LIKE '$cstName'");
$cstId = $cst["id"];
$res = $app->connect->getAllRes("SELECT * FROM VCst_Order WHERE CostumerNumber = '$cstId'");

?>


<div class="content-div">
<h1>Din orderhistorik</h1>
</div>

<?php foreach ($res as $row) :?>

        <div class="widget">
        <h2> Order Information </h2>
        <p> Skapad: <?= $row["OrderDate"] ?> </p>
        <p> Ordernummer: <?= $row["OrderNumber"] ?> </p>

        <h2> Kund information </h2>
        <p> Namn: <?= $row["firstName"] ?> <?= $row["lastName"] ?></p>
        <p> Kund ID: <?= $row["CostumerNumber"] ?></p>

        <h2> Leverans </h2>
        <?php
            $order = $row["OrderNumber"];
            $order = $app->connect->getAllRes("SELECT * FROM VOrder_Info WHERE id = $order;");
        ?>
        <table style="width:50%;">
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
            <th> Totala </th>
            <td> <?= $row["Price"] ?> SEK </td>


    </div>

<?php endforeach; ?>
