<div class="main-container" style="max-width:500px">
    <div class="content-div">
<?php
$db = $app->connect;
$session = $app->session;

$user_loggedin = "";

if (isset($_POST['submitCreateForm'])) {
    // Handle incoming POST variables
    $user_name = isset($_POST["new_name"]) ? htmlentities($_POST["new_name"]) : null;
    $user_pass = isset($_POST["new_pass"]) ? htmlentities($_POST["new_pass"]) : null;
    $re_user_pass = isset($_POST["re_pass"]) ? htmlentities($_POST["re_pass"]) : null;
    $authority = isset($_POST["authority"]) ? htmlentities($_POST["authority"]) : null;
    $firstName = isset($_POST["firstName"]) ? htmlentities($_POST["firstName"]) : null;
    $lastName = isset($_POST["lastName"]) ? htmlentities($_POST["lastName"]) : null;

    // Check if username exists
    if (!$db->exists($user_name)) {
        // Check passwords match
        if ($user_pass != $re_user_pass) {
            echo "<p class='warning'>Passwords do not match!</p>";
        } else {
            if (strpos($user_name, '%') !== false) {
                echo "<p class='warning'>% is not an acceptable character.</p>";
            } else {
                // Make a hash of the password
                $crypt_pass = password_hash($user_pass, PASSWORD_DEFAULT);

                // Add user to database
                if (!valueController([$firstName, $lastName, $user_name, $crypt_pass, $authority])) {
                    echo "<p class='success'>Du la till " . $user_name . "!</p>";
                    $params = [$firstName, $lastName];
                    $db->addUser($user_name, $crypt_pass, $authority, $params);
                } else {
                    echo "<p class='warning'>Alla fält måste fyllas</p>";
                }
            }
        }
    } else {
        echo "<p class='warning'>Användaren existerar redan! Välj ett annat namn.</p>";
    }
}
?>

    <form action="" method="POST">

            <legend><h3>Create user</h3></legend>
                <label for="new_name">Användarnamn</label>
                <input placeholder="Username" type="text" name="new_name">

                <label for="firstName">Förnamn</label>
                <input placeholder="Firstname" type="text" name="firstName">

                <label for="lastName">Efternamn</label>
                <input placeholder="lastName" type="text" name="lastName">

                <label for="new_pass">Password</label>
                <input placeholder="Password" type="password" name="new_pass">


                <label for="re_pass">Repeat password</label>
                <input  placeholder="Password"type="password" name="re_pass">

                <input type="hidden" name="authority" value="Customer">


                <input type="submit" name="submitCreateForm" value="Create">

    </form>
    <p><a href="<?= $app->url->create('login')?>">Back to login</a></p>

</div>
</div>
