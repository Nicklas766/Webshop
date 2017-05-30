
<?php
// Get current page
$id = getGet("id");
if (!(is_numeric($id))) {
    die("Not valid for id.");
}

// Check if form posted and get incoming
if (hasKeyPost('doDelete')) {
    $app->webshop->deleteInventory($id);
}
// Check if form posted and get incoming
if (isset($_POST['doSave'])) {
    // get all product info
    $params = getPost([
        "id",
        "shelf",
        "Amount"
    ]);
    // send params to webshop class and update
    $app->webshop->updateInventory($params);
    echo "<p class='success'>You updated the details!</p>";
}

$res = $app->connect->getRes("SELECT * FROM VInventory WHERE prod_id = $id");
$resShelf = $app->connect->getAllRes("SELECT * FROM Shop_InvenShelf");
?>

<div class="content-div">
    <h1>Edit</h1>


<!-- Information -->
<table>
    <tr class="first">
        <th> Shelf </th>
        <th> Prod_ID </th>
        <th> Amount </th>
    </tr>
    <tr>
        <td> <?= $res["shelf"] ?> </td>
        <td> <?= $res["prod_id"] ?> </td>
        <td> <?= $res["amount"] ?> </td>
    </tr>
</table>


<!-- Form -->
    <form method="post">
        <input type='hidden' name='id' value='<?= $id?>'/>

        <h3>Shelf</h3>
        <select name="shelf" style="width:50%;">
            <?php foreach ($resShelf as $k) :?>
                <option value="<?= $k["shelf"] ?>"><?= $k["shelf"] ?></option>
            <?php endforeach; ?>
        </select>

        <h3>Add or Decrease</h3>
        <input style="width:50%;" type='number' name='Amount' value=''/>

        <button type="submit" name="doSave"></i> Save</button>
        <button type="submit" name="doDelete"></i> Delete</button>
    </form>
</div>
