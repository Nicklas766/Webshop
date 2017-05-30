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
if (hasKeyPost("doClose")) {
    $app->errand->closeErrand($errandID, $cstId);
}
// -----------------------------------------------------------------------------

$res2 = $app->connect->getRes("SELECT * FROM CustomerErrand WHERE id = '$errandID'");

// if closed have h1 about it
if ($res2["status"] == "closed") {
    echo "<h1 style='background:red;'>Detta ärende är avslutad</h1>";
}

?>
<div class="flex-container">
<!-- close form -->
<div style="width:25%">
<form method="post" style="width:100%;">
    <button type="submit" name="doClose">Avsluta ärende</button>
</form>

<!-- cst information -->
    <table style="width:100%;">
        <th> Ärendeinformation </th>
        <tr><td> <a href="<?= $app->url->create('admin/edituser')?>?id=<?= $res2["cst_id"] ?>"> Kundsida</a> </td></tr>
        <tr><td> </h4><?= esc($res2["title"]) ?> </td></tr>
        <tr><td> <?= esc($res2["description"]) ?> </td></tr>
    </table>
</div>
