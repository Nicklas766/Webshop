


<div class="main-container" style="max-width:500px">
    <div class="content-div">
        <h1> Logga in för att gå till hemsidan </h1>
<?php

$session = $app->session;
// Starta sessionen
$user_loggedin = "";
// Make sure no one is logged in
if ($session->has("name")) {
    echo "<h2>You are already logged in as " . $session->get('name') . "</h2>";
    echo "<p>Go to profile <a href='{$app->url->create('profile')}'>here.</a></p>";
    $user_loggedin = "disabled";
}
?>
</div>

<div class="content-div">

    <form action="<?= $app->url->create('validate')?>" method="POST">
        <label for="name">Enter name:</label>
        <input placeholder="Username" type="text" name="name" <?=$user_loggedin?>>

        <label for="new_pass">Password</label>
        <input placeholder="Password" type="password" name="pass" <?=$user_loggedin?>>

        <td><input type="submit" name="submitForm" value="Login" <?=$user_loggedin?>></td>

    </form>


 <a href="<?= $app->url->create('create')?>">Skapa konto</a>
</div>
</div>
