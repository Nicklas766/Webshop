<?php
/**
 * Content
 */
namespace nicklas\Connect;

use \PDO;

class Customer extends Connect implements \Anax\Common\AppInjectableInterface, \Anax\Common\ConfigureInterface
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
    }

    public function addToCart($cstId, $prodId)
    {
        // add to cart with procedure
        // $this->execute("CALL addCart($cstId, $prodId)");
        // echo "<p class='success'> Du har lagt till produkten i din kundvagn </p>";

        $success = $this->getRes("SELECT addCart($cstId, $prodId) AS success")["success"];

        //remove inventory
        if ($success == "TRUE") {
            $this->app->redirect(mergeQueryString(["msg" => "success"]));
        } else {
            $this->app->redirect(mergeQueryString(["msg" => "fail"]));
        }
    }

    public function removeProduct($params, $cstId)
    {
        $prodId = $params["prodId"];
        $start = $params["oldAmount"];
        $stop = $params["newAmount"];

        for ($i = $start; $i > $stop; $i--) {
            $this->execute("CALL removeCart($cstId, $prodId)");
        }

        echo "<p class='success'> Du har tagit bort, ". ($start - $stop) ." st </p>";
    }
    public function createOrder($cstId)
    {
        // $this->execute("CALL createOrder($cstId)");

        $success = $this->getRes("SELECT createOrder($cstId) AS success")["success"];
        // redirect or warning
        if ($success == "TRUE") {
            $this->app->redirect("completed");
        } else {
            echo "<p class='warning'> Något i din order finns inte i lager, vänligen kontrollera din kundvagn </p>";
        }
    }
}
