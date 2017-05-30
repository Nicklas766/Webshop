<?php
// Store all variables above
$db = $app->connect; // database class
$session = $app->session; // session class
$session->start("");

// Handle incoming POST variables
$user_name = isset($_POST["name"]) ? htmlentities($_POST["name"]) : null;
$user_pass = isset($_POST["pass"]) ? htmlentities($_POST["pass"]) : null;


// Correspond according to input
// Check if both fields are filled
if ($user_name != null && $user_pass != null) {
    // Check if username exists
    if ($db->exists($user_name)) {
        $get_hash = $db->getHash($user_name);
        // Verify user password
        if (password_verify($user_pass, $get_hash)) {
            // Control if blocked
            if ($db->controlBlock($user_name)) {
                $session->set("name", $user_name);
                header("Location: {$app->url->create('profile')}");
            }
            echo "<p class='warning'> Ditt konto är blockerat från denna sida!</p>";
        } else {
            // Redirect to login.php
            echo "<h1>User name or password is incorrect. <a href='{$app->url->create('login')}'>Try again.</a></h1>";
        }
    } else {
        // Redirect to login.php
        echo "<h1>No such user. <a href='{$app->url->create('login')}'>Try again.</a></h1>";
    }
}
