<?php
// Store all variables above
$db = $app->connect; // database class
$session = $app->session; // session class
$admin = $app->admin; // admin class
$user = $session->get("name");
$profileInfo = $db->getInfo($user);
?>

<div class="content-div">
    <div class="flex-container" style="border:1px solid silver;">

    <div style="width:100%;">
        <h1>Välkommen <strong style="color:#009be7;"><?= $session->get('name') ?></strong>!</h1>
        <h3> Detta är din profilsida, du kan redigera, ändra lösenord eller titta på din historik.</h3>
        </div>
    <div style="width:50%; border:1px solid silver;">

        <h3> Personlig text </h3>
        <div style="border:1px solid silver; width:50%; margin:auto;">
            <p><?= $profileInfo[0] ?> </p>
        </div>

        <h3> Mejladress </h3>
        <div style="border:1px solid silver; width:50%; margin:auto;">
            <p><?= $profileInfo[1] ?> </p>
        </div>

        <h3> Behörighet </h3>
        <div style="border:1px solid silver; width:50%; margin:auto;">
                <p><?= $profileInfo[2] ?> </p>
            </div>
    </div>


        <div style="width:49.65%; border:1px solid silver;">
<?php

// Links for profile. Show admin tools if admin logged in.

echo "<p><a href='{$app->url->create('user/history')}'>Min historik</a></p>";
echo "<p><a  href='{$app->url->create('user/errands')}'>Mina ärenden</a></p>";

echo "<p><a  href='{$app->url->create('user/password')}'>Ändra Lösenord</a></p>";

echo "<p><a  href='{$app->url->create('user/edit')}'>Edit Profile</a></p>";
echo "<p><a href='{$app->url->create('logout')}'>Logga ut</a></p>";
echo "</div>";
echo "</div>";
echo "</div>";
