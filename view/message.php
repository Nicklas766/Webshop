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

$res = $app->connect->getAllRes("SELECT * FROM ErrandView WHERE errand_id = '$errandID' ORDER BY created ASC");

?>

<!-- messages -->
<div class="msg-container">

<div class="msg-div">
    <?php foreach ($res as $row) :?>

        <!-- use flex order with $app->errand->set function -->
        <div class="flex-container" style="width:100%;">

            <div class="msg-widget" style="width:60%; order: 2;">
                <p> <?= $app->textfilter->dofilter(esc($row["sent_text"]), "") ?> </p>
            </div>

            <div style="width:5%;">
            </div>

            <div class="msg-widget" style="width:25%; order: <?= $app->errand->set($row, $cstName); ?>">
                <i> <?= esc($row["created"]) ?> </i>
                <h2> <?= esc($row["user_name"]) ?> </h2>
            </div>
        </div>
    <?php endforeach; ?>
</div>

<form method="post">
        <textarea name="sent_text"></textarea>
        <button type="submit" name="doSend">Skicka meddelande</button>
</form>
</div>
</div>
