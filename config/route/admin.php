<?php
/**
 * Routes.
 */

$app->router->add("admin/**", function () use ($app) {
    $user = $app->session->get("name");
    if (!$app->admin->adminControl($user)) {
        $app->redirect("fail");
    }
});

$app->router->add("admin", function () use ($app) {
    $app->renderPage("admin/header,admin/home", "Admin");
});

$app->router->add("fail", function () use ($app) {
    $app->renderPage("admin/fail", "Admin | Fail");
});



/********************************************
 * USERS
 ********************************************/


$app->router->add("admin/users", function () use ($app) {
    $app->renderPage("admin/header,admin/pages/users", "Admin | Users");
});

$app->router->add("admin/edituser", function () use ($app) {
    $app->renderPage("admin/header,admin/pages/edituser", "Admin | Users");
});

$app->router->add("admin/errands", function () use ($app) {
    $app->renderPage("admin/header,admin/pages/errands", "Admin | Errands");
});

$app->router->add("admin/errand", function () use ($app) {
    $app->renderPage("admin/header,admin/pages/errand, message", "Admin | Errand");
});



/*******************************************
 * WEBSHOP
 ********************************************/

$app->router->add("admin/webshop", function () use ($app) {
    $app->renderPage("admin/header, admin/webshop/dashboard, admin/webshop/overview, admin/webshop/create", "webshop admin");
});

$app->router->add("admin/webshop/edit", function () use ($app) {
    $app->renderPage("admin/header, admin/webshop/edit", "webshop edit");
});

$app->router->add("admin/webshop/stock", function () use ($app) {
    $app->renderPage("admin/header, admin/webshop/stock, admin/webshop/lowstock", "webshop stock");
});

$app->router->add("admin/webshop/editstock", function () use ($app) {
    $app->renderPage("admin/header, admin/webshop/dashboard, admin/webshop/editstock", "webshop edit");
});

$app->router->add("admin/webshop/create", function () use ($app) {
    $app->renderPage("admin/webshop/create", "webshop create");
});


/*******************************************
 * CONTENT
 ********************************************/

$app->router->add("admin/content", function () use ($app) {
    $app->renderPage("admin/header,admin/content/main", "Admin | Content");
});

$app->router->add("admin/content/create", function () use ($app) {
    $app->renderPage("admin/header,admin/content/main,admin/content/create", "Admin | Create");
});

$app->router->add("admin/content/edit", function () use ($app) {
    $app->renderPage("admin/header,admin/content/main,admin/content/edit", "Admin | Edit");
});

$app->router->add("admin/content/overview", function () use ($app) {
    $app->renderPage("admin/header,admin/content/main,admin/content/overview", "Admin | Overview");
});

$app->router->add("admin/content/pages", function () use ($app) {
    $app->renderPage("admin/header,admin/content/main,admin/content/site-content", "Admin | Pages");
});


 /*******************************************
  * OFFERS
  ********************************************/

$app->router->add("admin/deals/week", function () use ($app) {
    $app->renderPage("admin/header,admin/deals/main,admin/deals/week", "Admin | WeekDeal");
});

$app->router->add("admin/deals/recommend", function () use ($app) {
    $app->renderPage("admin/header,admin/deals/main,admin/deals/recommend", "Admin | RecommendProduct");
});
