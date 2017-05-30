<?php
$resCat = $app->connect->getAllRes("SELECT * FROM Shop_ProdCategory");
$resImg = $app->connect->getAllRes("SELECT * FROM Shop_Image");
?>


<!-- Form -->

<div class="content-div">
    <div style="width:60%; border: solid 2px orange; border-radius:0.5em; font-size:16px; margin-left:auto; margin-right:auto;">
    <h1>Skapa Produkt</h1>
    <form method="post">

        <label>Namn</label>
        <input style="width:70%;" type='text' name='prodName'>

        <label>Description</label>
        <textarea name='description'></textarea>

        <label>Image</label>
        <select name="img">
            <?php foreach ($resImg as $k) :?>
                <option value="<?= $k["link"] ?>"><?= $k["link"] ?></option>
            <?php endforeach; ?>
        </select>

        <label>Price</label>
        <input style="width:70%;" type='number' name='price' value=''/>


        <p class='info'>Choose one, you will be able to edit more later.</p>

        <?php foreach ($resCat as $k) :?>
            <?= $k["category"] ?><input style="width:100px;" type="radio" name="catId" value="<?= $k["id"] ?>">
        <?php endforeach; ?>

            <button type="submit" name="create"></i> Create</button>
        </form>
</div>
</div>
