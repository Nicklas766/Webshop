<?php
/**
 * Content
 */
namespace nicklas\Connect;

use \PDO;

class Product extends Connect implements \Anax\Common\AppInjectableInterface, \Anax\Common\ConfigureInterface
{
    use \Anax\Common\ConfigureTrait,
        \Anax\Common\AppInjectableTrait;


    public function __construct()
    {
        parent::__construct();
    }


    public function setApp($app)
    {
        $this->app = $app;
        $this->currentUrl = $app->request->getRoute();
    }

    public function getMax($hits, $cat)
    {

        $max = $this->db->query("SELECT COUNT(id) FROM ProductView WHERE category LIKE $cat")->fetchColumn();
        $max = ceil($max / $hits);
        return $max;
    }

    // Echo edit form. Uses ID
    public function sortProduct()
    {
        $hits; // How many rows to display per page.
        $page; // Current page, use to calculate offset value
        $max;  // Max pages available: SELECT COUNT(id) AS rows FROM movie


        // Get number of hits per page
        $hits = getGet("hits", 8);
        if (!(is_numeric($hits) && $hits > 0 && $hits <= 8)) {
            return false;
        }

        // Get possible categories
        $cat = getGet("cat", "");

        // Prepare SQL statement for multiple categories
        $cat = sqlString($cat, " AND Category LIKE ");
        // echo $cat;

        $max = $this->getMax($hits, $cat);


        // Get current page
        $page = getGet("page", 1);
        if (!(is_numeric($hits) && $page > 0 && $page <= $max)) {
            return false;
        }
        $offset = $hits * ($page - 1);


        // ---------------------------------------------------

        // Only these values are valid
        $columns = ["prodName", "price", "id"];
        $orders = ["asc", "desc"];

        // Get settings from GET or use defaults
        $orderBy = getGet("orderby") ?: "id";
        $order = getGet("order") ?: "asc";

        // Incoming matches valid value sets
        if (!(in_array($orderBy, $columns) && in_array($order, $orders))) {
            die("Not valid input for sorting.");
        }

        return [$this->app->connect->getAllRes("SELECT * FROM ProductView WHERE category LIKE $cat ORDER BY $orderBy $order LIMIT $hits OFFSET $offset"), $max];
    }
}
