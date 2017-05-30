<div class="main-container" style="max-width:500px">
    <div class="content-div">
<?php
// Store all variables above
$db = $app->connect; // database class
$session = $app->session; // session class

// Check if someone is logged in
if ($session->has("name")) {
    $session->destroy();
} else {
    echo "<p>No active user.</p>";
    echo "<p><a href=''>Login again.</a></p></div>";
    die();
}

// Check if session is active
$has_session = session_status() == PHP_SESSION_ACTIVE;

if (!$has_session) {
    echo "<p>The session no longer exists. You have successfully logged out!</p>";
}

echo "<p>Destroyed session.</p>";

echo "<a href=''>Login again.</a></div></div></div>";
