<div class="content-div">
<h1>Overview</h1>



<?php $res = $app->connect->getAllRes("SELECT * FROM AdminProductView"); ?>
<section>
<table>
<tr class="first">
<th> Edit </th>
<th> Prod_ID </th>
<th> I lager </th>
<th> Namn </th>
<th> Kategori(er) </th>
<th> Original pris </th>
<th> Veckans Pris </th>
<th> Bild </th>
</tr>
<?php foreach ($res as $row) :?>

        <tr>
        <td>    <a href="<?= $app->url->create('admin/webshop/edit')?>?id=<?= $row["id"] ?>"> Edit </a></td>
        <td> <?= $row["id"] ?> </td>
        <td><?= $row["InStock"] ?></td>
        <td> <?= $row["prodName"] ?> </td>
        <td> <?= $row["category"] ?> </td>
        <td> <?= $row["price"] ?> SEK </td>
        <td> <?= $row["WeekDeal"] ?> SEK </td>

        <td> <img src="../<?= $row["image"] ?>" alt="notfound" height="42" width="42"> </td>
        </tr>

<?php endforeach; ?>

</table>
</section>
</div>
