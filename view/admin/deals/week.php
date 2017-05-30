<?php

// Check if form posted and get incoming
if (hasKeyPost('doSave')) {
    // get all product info
    $params = getPost([
        "prod_id",
        "week",
        "newPrice"
    ]);
    $app->admin->weekDeal($params);
}


$res = $app->connect->getAllRes("SELECT * FROM ProductView");
?>
<div class="content-div" style="background:#009be7; color:white;">
    <div style="border:solid 2px white; width:50%; margin-left:auto; margin-right:auto;">
    <span class="material-icons">info_outline</span>
    <h3> När du lägger till ett erbjudande på en produkt för veckan så kommer priset även ändras på produktsidan (när det är veckan du angett). </h3>
    <h3> Om du lägger till ett erbjudande på en produkt för veckan som redan existerar, så uppdateras den istället. </h3>
    <h3> När du väl skapat ett erbjudande för en produkt så gäller den förevigt för veckan du angett. Originalpriset gills inte, du kan däremot ändra den genom uppdatering.</h3>
    </div>
</div>

    <div class="content-div">
        <h1>Produkt Information</h1>

    <!-- Form -->

            <form method="post">

                <label> Produkten </label>
                <select type="text" name='prod_id'>
                <?php foreach ($res as $row) :?>
                    <option value="<?= $row['id'] ?>"> <?= $row['prodName'] ?> (<?= $row['price'] ?> SEK)</option>
                <?php endforeach; ?>
            </select>

                <label> Vecka </label>
                <input type="number" name='week'>

                <label> Nya priset </label>
                <input type="number" name='newPrice'>



                <button type="submit" name="doSave">Skapa Erbjudande</button>
            </form>

    </div>
