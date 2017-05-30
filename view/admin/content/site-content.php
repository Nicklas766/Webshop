<?php
// Check if form posted and get incoming
if (hasKeyPost('doSave')) {
    $params = getPost([
        "about",
        "aboutFilter",
        "footer",
        "footerFilter"
    ]);

    if ($app->textfilter->controlInput($params["footerFilter"]) && $app->textfilter->controlInput($params["aboutFilter"])) {
        // send params to admin class to update current stats
        $app->page->editPages(array_values($params));
        echo "<p class='success'>You updated the details!</p>";
    } else {
        echo "<p class='warning'> The filters are not valid! Go to homepage for admin for more info.</p>";
    }
}

$pageInfo = $app->page->getPageInfo(); // Get current info from class

?>

<div class='content-div'>

        <form action="" method="POST">
            <h3>Om</h3>
            <textarea rows="4" cols="50" name="about"><?= $pageInfo['about'] ?></textarea>
            <label>Filter</label><input type='text' name='aboutFilter' value="<?= $pageInfo['aboutFilter'] ?>"/>

            <h3>Footer</h3>
            <textarea rows="4" cols="50" name="footer"><?= $pageInfo['footer'] ?></textarea>
            <label>Filter</label><input type='text' name='footerFilter' value="<?= $pageInfo['footerFilter'] ?>"/>

            <input style="height:100%; font-size:3em; color:darkorange;" type="submit" name="doSave" value="Spara">
        </form>

</div>
