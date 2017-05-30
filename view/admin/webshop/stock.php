<div class="content-div">



<?php $res = $app->connect->getAllRes("SELECT * FROM VInventory");
$resLow = $app->connect->getAllRes("SELECT * FROM Shop_LowStock"); ?>
<section>
<table>
    <tr class="first">
        <th> Edit </th>
        <th> Shelf </th>
        <th> PROD_ID </th>
        <th> Location </th>
        <th> Amount </th>
    </tr>
<?php foreach ($res as $row) :?>
        <tr>
        <td> <a href="<?= $app->url->create('admin/webshop/editstock')?>?id=<?= $row["prod_id"] ?>"> Edit </a></td>
        <td> <?= $row["shelf"] ?> </td>
        <td> <?= $row["prod_id"] ?> </td>
        <td> <?= $row["location"] ?> </td>
        <td> <?= $row["amount"] ?></td>
        </tr>

<?php endforeach; ?>

</table>
</section>
