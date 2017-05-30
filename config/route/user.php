<?php
/**
 * User routes and login.
 */




$app->router->add("profile", function () use ($app) {
    $app->renderPage("user/profile", "Profile");
});

$app->router->add("user/edit", function () use ($app) {
    $app->renderPage("user/edit", "User | Edit");
});

$app->router->add("user/password", function () use ($app) {
    $app->renderPage("user/password", "User | Password");
});

$app->router->add("user/history", function () use ($app) {
    $app->renderPage("user/history", "User | History");
});

$app->router->add("user/errands", function () use ($app) {
    $app->renderPage("user/errands", "User | Errands");
});



// Redirect if not cst's errand
$app->router->add("user/errand/**", function () use ($app) {
    // GET ID FIRST
    $cstName = $app->session->get('name');
    $cstId = $app->connect->getRes("SELECT * FROM Shop_User WHERE name LIKE '$cstName'")["id"];

    $errandID = getGet("id");
    if (!is_numeric($errandID)) {
        die("Not valid for content id.");
    }

    $correctId = $app->connect->getRes("SELECT * FROM CustomerErrand WHERE id = $errandID")["cst_id"];
    if ($cstId != $correctId) {
        $app->redirect("user/errands");
    }
});

$app->router->add("user/errand", function () use ($app) {
    $app->renderPage("message", "User | Errand");
});
