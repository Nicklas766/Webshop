<?php
// Store all variables above
$db = $app->connect; // database class
$session = $app->session; // session class
$user = $session->get("name");

// EDIT.php
// Check if form posted and get incoming
if (isset($_POST['save'])) {
    // Store posted form in parameter array
    $info = htmlentities($_POST['info']);
    $email = htmlentities($_POST['email']);

    $params = [$info, $email];
    // send params to database class
    $db->edit($params, $user);
}


$profileInfo = $db->getInfo($user); // Get current info from database class
?>

<div class='content-div'>
<div style="width:50%; margin-left:auto; margin-right:auto; margin-top:100px;">
    <form action="<?= $app->url->create('user/edit') ?>" method="POST">

        <legend><h3>Edit Profile</h3></legend>

        <label for="email">email</label>
        <input type="text" name="email" value="<?= $profileInfo[1] ?>">

            <label for="info">info</label>
            <textarea rows="4" cols="50" name="info"><?= $profileInfo[0] ?></textarea>

            <input type="submit" name="save" value="Update">

    </form>
    <a href="<?= $app->url->create('profile') ?>">Go back to profile</a>
</div></div>
