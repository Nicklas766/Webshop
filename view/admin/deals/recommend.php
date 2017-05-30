<?php

// Check if form posted and get incoming
if (hasKeyPost('doSave')) {
    // get all product info
    $params = getPost([
        "prod_id"
    ]);
    $app->admin->addRecommend($params['prod_id']);
}


$res = $app->connect->getAllRes("SELECT * FROM ProductView");
?>
<div class="content-div" style="background:#009be7; color:white;">
    <div style="border:solid 2px white; width:50%; margin-left:auto; margin-right:auto;">
    <span class="material-icons">info_outline</span>
    </div>
</div>

    <div class="content-div">
        <h1>Produkt Information</h1>

    <!-- Form -->

            <form method="post">

                <label> Produkten </label>
                <select type="text" name='prod_id'>
                <?php foreach ($res as $row) :?>
                    <option value="<?= $row['id'] ?>"> <?= $row['prodName'] ?></option>
                <?php endforeach; ?>
            </select>

                <button type="submit" name="doSave">Rekommendera produkten</button>
            </form>

    </div>
