<?php
//                        ALL GETs AND POSTs
// -----------------------------------------------------------------------------
// GET ID FIRST
$cstName = $app->session->get('name');
$cstId = $app->connect->getRes("SELECT * FROM Shop_User WHERE name LIKE '$cstName'")["id"];

$errandID = getGet("id");
if (!is_numeric($errandID)) {
    die("Not valid for content id.");
}
// Check if form posted and get incoming
if (hasKeyPost("doSend")) {
    // get all posts
    $text = getPost("sent_text");
    $app->errand->sendText($cstId, $errandID, $text);
}
// -----------------------------------------------------------------------------

$res = $app->connect->getAllRes("SELECT * FROM ErrandView WHERE errand_id = '$errandID'");


?>

<h1> Meddelanden </h1>

    <?php foreach ($res as $row) :?>
        <div style="border: solid 1px;">
            <h2> <?= esc($row["user_name"]) ?> </h2>
            <p> <?= esc($row["sent_text"]) ?> </p>
            <i> <?= esc($row["created"]) ?> </i>
        </div>

    <?php endforeach; ?>

<form method="post">
        <textarea name="sent_text"></textarea>
        <button type="submit" name="doSend">Skicka meddelande</button>
</form>

</div>
