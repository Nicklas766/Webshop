<?php
// Check if form posted and get incoming
if (hasKeyPost('create')) {
    // get all product info
    $params = getPost([
        "prodName",
        "description",
        "img",
        "price",
        "catId"
    ]);


    if (valueController($params)) {
        echo "<p class='warning'>Fail! Please enter ALL fields.</p>";
    } else {
        // send params to webshop and create
        $app->webshop->createProduct($params);
        echo "<p class='success'>You created a product!</p>";
    }
}
