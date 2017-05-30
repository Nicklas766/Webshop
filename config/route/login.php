<?php
/**
 * login routes
 */

$app->router->add("login", function () use ($app) {
    $app->renderLogin("login/login", "login");
});

$app->router->add("logout", function () use ($app) {
    $app->renderLogin("login/logout", "logout");
});

$app->router->add("create", function () use ($app) {
    $app->renderLogin("login/create", "create");
});

$app->router->add("validate", function () use ($app) {
    $app->renderPage("login/validate", "validate");
});
