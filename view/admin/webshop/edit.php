<?php
// Get current page
$id = getGet("id");
if (!(is_numeric($id))) {
        die("Not valid for id.");
}
    $resCat = $app->connect->getAllRes("SELECT * FROM Shop_ProdCategory");

    // Check if form posted and get incoming
if (hasKeyPost('doDelete')) {
    $app->webshop->deleteProduct($id);
}
// Check if form posted and get incoming
if (hasKeyPost('doSave')) {
// get all categories posts
    $categories = [];
    foreach ($resCat as $k) {
        if (hasKeyPost($k["category"])) {
            array_push($categories, $k["id"]);
        }
    }
        // get all product info
        $params = getPost([
            "id",
            "name",
            "description",
            "img",
            "price"
        ]);

        // if slug already exists with different id, stop submit
        if (!$categories) {
            echo "<p class='warning'>You need to add a category</p>";
        } else {
            // send params to webshop class and update
            $app->webshop->updateProduct($params, $categories);
            echo "<p class='success'>You updated the details!</p>";
        }
}

    $res = $app->connect->getRes("SELECT * FROM AdminProductView WHERE id = $id");
    $resCat = $app->connect->getAllRes("SELECT * FROM Shop_ProdCategory");
    $resImg = $app->connect->getAllRes("SELECT * FROM Shop_Image");
    ?>

<div class="content-div">

    <!-- Information -->
    <div class="flex-container">

        <div style="height:300px; margin-left:auto; width:30%; border:2px solid silver; margin-left:20%;">
            <img src="../../<?= $res["image"] ?>" alt="notfound" height="100%" width="100%">
        </div>

        <div style="height:300px; margin-right:auto; width:40%; border:2px solid silver; margin-bottom:24px;">
            <table>
                <th> Produkt information </th>
                <tr><td> Namn: <?= $res["prodName"] ?> </td></tr>

                <tr><td> Kategori(er):<?= $res["category"] ?> </td></tr>
                <tr><td> Pris: <?= $res["price"] ?> SEK </td></tr>
                <tr><td> Lager status: <?= $res["InStock"] ?> </td></tr>
                <tr><td> Beskrivning: <?= $res["description"] ?> </td></tr>
            </table>
        </div>


    <!-- Form -->
        <div style="width:10%;">
            <form method="post">
                <input type='hidden' name='id' value='<?= $id?>'/>

                    <h2 style="border-bottom:1px solid black;">Kategori(er)</h2>
                        <?php foreach ($resCat as $k) :?>
                            <label><?= $k["category"] ?> </label><input type="checkbox" name="<?= $k["category"] ?>">
                        <?php endforeach; ?>
        </div>

        <div style="width:90%;">
                <label>Pris</label>
                <input type='number' style="width:75%;" name='price' value='<?= $res["price"] ?>'/>

                <label>Image</label>
                <select style="width:75%;" name="img">
                    <?php foreach ($resImg as $k) :?>
                        <option value="<?= $k["link"] ?>"><?= $k["link"] ?></option>
                    <?php endforeach; ?>
                </select>

                <label>Namn</label>
                <input style="width:75%;" type="text" name='name' value="<?= $res["prodName"] ?>">
                <label>Beskrivning</label>
                <textarea name='description'><?= $res["description"] ?></textarea>

                <button type="submit" name="doSave"></i> Save</button>
                <button type="submit" name="doDelete"></i> Delete</button>
            </form>
        </div>
    </div>
</div>
