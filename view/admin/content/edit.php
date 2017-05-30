<?php
// GET ID FIRST
$contentId = getPost("contentId") ?: getGet("id");
if (!is_numeric($contentId)) {
    die("Not valid for content id.");
}
if (hasKeyPost("doDelete")) {
    // Call function to delete
    $app->content->deleteContent($contentId);
    echo "<p class='warning'>You deleted this content</p>";
}
// Check if form posted and get incoming
if (hasKeyPost("doSave")) {
    // Store posted form in parameter array
    $params = getPost([
        "contentTitle",
        "contentSlug",
        "contentData",
        "contentType",
        "contentFilter",
        "contentPublish",
        "contentId"
    ]);
    if (!$params["contentSlug"]) {
        $params["contentSlug"] = slugify($params["contentTitle"]);
    }
    // if slug already exists with different id, dont submit
    if ($app->content->slugExists($params["contentSlug"], $params["contentId"])) {
        echo "<p class='warning'>Slug already exists, please enter new slug or title</p>";
    } else {
        // control if filter acceptable
        if ($app->textfilter->controlInput($params["contentFilter"])) {
            // send params to content class to update current stats
            $app->content->editContent(array_values($params));
            echo "<p class='success'>You updated the details!</p>";
        } else {
            echo "<p class='warning'> The filters are not valid! Go to homepage for admin for more info.</p>";
        }
    }
}

$res = $app->connect->getRes("SELECT * FROM Shop_Content WHERE id = '$contentId'");
?>

<!-- SUBMIT/EDIT FORM -->
<div class="content-div">

        <h2>Text inställningar</h2>
            <form method="post">
                <input type='hidden' name='contentId' value="<?= $res['id'] ?>"/>
                <input type='hidden' name='contentType' value="post"/>

                <label>Title</label>
                <input type='text' name='contentTitle' value="<?= $res['title'] ?>"/>

                <label>Slug</label>
                <input type='text' name='contentSlug' value="<?= $res['slug'] ?>"/>

                <label>Filter</label>
                <input type='text' name='contentFilter' value='<?= $res['filter'] ?>'/>

                <label>Published</label>
                <input type='datetime' name='contentPublish' value='<?= $res['published'] ?>'/>


                <label>Text</label>
                <textarea name='contentData'><?= $res['data'] ?></textarea>


                <button type="submit" name="doSave">Spara</button>
                <button type="submit" name="doDelete">Radera</button>
            </form>
    </div>
</div>
