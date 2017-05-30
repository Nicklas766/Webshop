<?php
/**
 * Admin
 */
namespace nicklas\Connect;

use \PDO;

class Errand extends Connect implements \Anax\Common\AppInjectableInterface, \Anax\Common\ConfigureInterface
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

    public function set($row, $cstName)
    {
        if (strtolower($row["user_name"]) == strtolower($cstName)) {
            return "3";
        }
        return "1";
    }

    public function createErrand($cstId, $title, $desc)
    {
        $stmt = $this->db->prepare("INSERT INTO CustomerErrand (cst_id, title, description) VALUES ($cstId, '$title', '$desc')");
        $stmt->execute();
    }

    public function sendText($cstId, $errandID, $text)
    {
        $status = $this->getRes("SELECT * FROM CustomerErrand WHERE id = $errandID")["status"];
        if ($status == "active") {
            $stmt = $this->db->prepare("INSERT INTO ErrandText (senders_id, errand_id, sent_text) VALUES ($cstId, $errandID, '$text')");
            $stmt->execute();
        }
    }

    public function closeErrand($errandID, $cstId)
    {

        $status = $this->getRes("SELECT * FROM CustomerErrand WHERE id = $errandID")["status"];
        if ($status == "active") {
            // Prepare SQL statement to UPDATE a row in the table
            $stmt = $this->db->prepare("UPDATE CustomerErrand SET status = 'closed' WHERE id='$errandID'");
            $stmt->execute();

            $stmt = $this->db->prepare("INSERT INTO ErrandText (senders_id, errand_id, sent_text) VALUES ($cstId, $errandID, '# Ditt ärende har stängts')");
            $stmt->execute();
        }
    }
}
