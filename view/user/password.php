<?php
// Store all variables above
$db = $app->connect; // database class
$session = $app->session; // session class
$user = $session->get("name");
$status = "Change password";

// Handle incoming POST variables
$old_pass = isset($_POST["old_pass"]) ? htmlentities($_POST["old_pass"]) : null;
$new_pass = isset($_POST["new_pass"]) ? htmlentities($_POST["new_pass"]) : null;
$re_pass = isset($_POST["re_pass"]) ? htmlentities($_POST["re_pass"]) : null;

// Check if all fields are filled
if ($old_pass != null && $new_pass != null && $re_pass != null) {
    // Check if old password is correct
    if (password_verify($old_pass, $db->getHash($user))) {
        // Check if new password matches
        if ($new_pass == $re_pass) {
                $crypt_pass = password_hash($new_pass, PASSWORD_DEFAULT);
                $db->changePassword($user, $crypt_pass);
                $status = "<p class='success'>Password changed.</p>";
        } else {
            $status = "<p class='warning'>The passwords do not match.</p>";
        }
    } else {
        $status = "<p class='warning'>Old password is incorrect.</p>";
    }
} else {
    $status = "All fields must be filled.";
}

?>
<div class="content-div">

    <form action="<?= $app->url->create('user/password') ?>" method="POST">

        <legend><h3><?=$status?></h3></legend>
            <label for="old_pass">Old Password</label>
            <input placeholder="Old Password" type="password" name="old_pass">

            <label for="new_pass">Password</label>
            <input placeholder="Password" type="password" name="new_pass">


            <label for="re_pass">Repeat password</label>
            <input  placeholder="Password"type="password" name="re_pass">


            <input type="submit" name="submitForm" value="Change password">

    </form>
    <p><a href='<?= $app->url->create('profile') ?>'>Back to profile</a></p>
</div>
