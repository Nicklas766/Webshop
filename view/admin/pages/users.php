<div class="content-div">
<h3> Users </h3>
<p>Items per page:
    <a href="<?= mergeQueryString(["hits" => 2]) ?>">2</a> |
    <a href="<?= mergeQueryString(["hits" => 4]) ?>">4</a> |
    <a href="<?= mergeQueryString(["hits" => 8]) ?>">8</a>
</p>
<?php
$admin = $app->admin;
$hits; // How many rows to display per page.
$page; // Current page, use to calculate offset value
$max;  // Max pages available: SELECT COUNT(id) AS rows FROM movie


// Get number of hits per page
$hits = getGet("hits", 4);
if (!(is_numeric($hits) && $hits > 0 && $hits <= 8)) {
    die("Not valid for hits.");
}

$max = $admin->getMax($hits);


// Get current page
$page = getGet("page", 1);
if (!(is_numeric($hits) && $page > 0 && $page <= $max)) {
    die("Not valid for page.");
}
$offset = $hits * ($page - 1);


// ---------------------------------------------------

// Only these values are valid
$columns = ["id", "name", "user", "email", "info", "authority"];
$orders = ["asc", "desc"];

// Get settings from GET or use defaults
$orderBy = getGet("orderby") ?: "id";
$order = getGet("order") ?: "asc";

// Incoming matches valid value sets
if (!(in_array($orderBy, $columns) && in_array($order, $orders))) {
    die("Not valid input for sorting.");
}

$admin->setAllTables($hits, $offset, $orderBy, $order);
$link1 = mergeQueryString(["hits" => 2]);
?>

<?php for ($i = 1; $i <= $max; $i++) : ?>
    <a href="<?= mergeQueryString(["page" => $i]) ?>"><?= $i ?></a>
<?php endfor; ?>

</div></div></div>
