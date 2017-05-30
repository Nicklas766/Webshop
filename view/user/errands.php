<?php
//                        ALL GETs AND POSTs
// -----------------------------------------------------------------------------
// GET ID FIRST
$cstName = $app->session->get('name');
$cstId = $app->connect->getRes("SELECT * FROM Shop_User WHERE name LIKE '$cstName'")["id"];

// Check if form posted and get incoming
if (hasKeyPost("doCreate")) {
    // get all posts
    $title = getPost("title");
    $desc = getPost("description");
    $app->errand->createErrand($cstId, $title, $desc);
}
// -----------------------------------------------------------------------------
?>

<?php
$res = $app->connect->getAllRes("SELECT * FROM CustomerErrand WHERE cst_id = '$cstId' ORDER BY created DESC");
?>

<h1> Skapa ett ärende </h1>
<form method="post">
        <h3> Titel om ärendet </h3>
        <input type="text" name="title">
        <h3> Beskriv ditt ärende </h3>
        <textarea name="description"></textarea>
        <button type="submit" name="doCreate">Skapa ärende</button>
</form>

<h1> Dina ärenden </h1>
<div class="flex-container">
    <?php foreach ($res as $row) :?>
        <a class="widget" href="<?= $app->url->create('user/errand')?>?id=<?= $row["id"] ?>">
            <h3> <?= esc($row["title"]) ?> </h3>
            <p> <?= $row["created"] ?> </p>
        </a>
    <?php endforeach; ?>
</div>
