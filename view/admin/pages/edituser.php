<div class="content-div">
<?php
$admin = $app->admin;


if (isset($_GET['id'])) {
    $id = $_GET['id'];
}

// Check if form posted and get incoming
if (isset($_POST['block'])) {
    // delete based on id
    if ($_POST['blockTyped'] == "block" || "Block") {
        $admin->blockUser($id);
        echo "<p class='warning'>Du har blockerat användaren från sidan!</p>";
    } else {
        echo "<p class='warning'>Please type 'delete' to delete profile</p>";
    }
}

// Check if form posted and get incoming
if (isset($_POST['save'])) {
    // Store posted form in parameter array
    $info = htmlentities($_POST['info']);
    $email = htmlentities($_POST['email']);
    $authority = htmlentities($_POST['authority']);

    $params = [$info, $email, $authority];
    // send params to admin class to update current stats
    $admin->editUser($params, $id);
    echo "<p class='success'>You updated the details!</p>";
}

// Check if form posted and get incoming
if (isset($_POST['changePass'])) {
    $new_pass = isset($_POST["new_pass"]) ? htmlentities($_POST["new_pass"]) : null;

    if (empty($new_pass)) {
        echo "<p class='warning'>$new_pass Fail! Input was either 0, empty, or not set at all</p>";
    } else {
        $crypt_pass = password_hash($new_pass, PASSWORD_DEFAULT);
        $admin->changePasswordId($id, $crypt_pass);
        echo "<p class='success'>Password changed to $new_pass</p>";
    }
}

// Set table and form for user
$admin->setUser($id);

?>
</div></div>
