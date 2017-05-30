<?php
/**
 * Routes.
 */




// Make sure user is logged in
$app->router->always(function () use ($app) {
      $app->session->start();

      $currentRoute = $app->request->getRoute();

    if (!$app->session->has("name") && $currentRoute != "login" && $currentRoute != "validate" && $currentRoute != "create") {
        $app->redirect("login");
    }
});



$app->router->add("", function () use ($app) {
    $app->renderPage("content/home", "home");
});


//$app->router->add("admin/**", function () use ($app) {
//    admin->controlAdmin(session);
// });
$app->router->add("products", function () use ($app) {
    $app->renderPage("content/products", "products");
});

$app->router->add("product", function () use ($app) {
    $app->renderPage("content/product", "product");
});

$app->router->add("notfound", function () use ($app) {
    $app->renderPage("fail/notfound", "notfound");
});

$app->router->add("blog/**", function () use ($app) {
    $app->renderPage("content/blog", "Blog");
});

$app->router->add("about", function () use ($app) {
    $app->renderPage("content/about", "about");
});

$app->router->add("checkout", function () use ($app) {
    $app->renderPage("content/checkout", "Kundvagn");
});

$app->router->add("completed", function () use ($app) {
    $app->renderPage("content/completed", "Completed");
});


$app->router->add("status", function () use ($app) {
    $data = [
        "Server" => php_uname(),
        "PHP version" => phpversion(),
        "Included files" => count(get_included_files()),
        "Memory used" => memory_get_peak_usage(true),
        "Execution time" => microtime(true) - $_SERVER['REQUEST_TIME_FLOAT'],
    ];
    $app->response->sendJson($data);
});
$app->router->add("search/{string}", function ($string) use ($app) {
    $data = [
        "Searchstring was" => $string
    ];
    $app->response->sendJson($data);
});
/**
 * Check arguments that matches a specific type.
 */
$callback = function ($value) use ($app) {
    $data = [
        "route"     => $app->request->getRoute(),
        "matched"   => $app->router->getLastRoute(),
        "value"     => $value,
    ];
    $app->response->sendJson($data);
};
$app->router->add("validate/{value:digit}", $callback);
$app->router->add("validate/{value:hex}", $callback);
$app->router->add("validate/{value:alpha}", $callback);
$app->router->add("validate/{value:alphanum}", $callback);
