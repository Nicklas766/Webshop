<?php
$content = $app->content;

if (hasKeyPost("doCreate")) {
    $title = getPost("contentTitle");
    $content->createContent($title);
    $id = $content->lastInsertId();
    header("Location: {$app->url->create('admin/content/edit')}?id=$id");
    exit;
}
?>
<div class='content-div'>
    <h1> Skapa nytt inlägg </h1>
    <form method="post">
            <label>Title:<br>
            <input type="text" name="contentTitle" default="A Title"/>

            <button type="submit" name="doCreate">Skapa</button>
    </form>
</div>
