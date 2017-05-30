<?php
/**
 * Content
 */
namespace nicklas\Connect;

use \PDO;

class Content extends Connect implements \Anax\Common\AppInjectableInterface, \Anax\Common\ConfigureInterface
{
    use \Anax\Common\ConfigureTrait,
        \Anax\Common\AppInjectableTrait;


    public function __construct()
    {
        parent::__construct();
    }

    /**
     * Adds title to the database, in order to make it editable
     * @param $title contains the title
     * @return void
     */

    public function slugExists($slug, $id)
    {
         $stmt = $this->db->prepare("SELECT * FROM Shop_Content WHERE slug='$slug' AND id<>'$id'");
         $stmt->execute();
         $row = $stmt->fetch(PDO::FETCH_ASSOC);
         return !$row ? false : true;
    }
     /**
      * Return last insert id from an INSERT.
      *
      * @return void
      */
    public function lastInsertId()
    {
         return $this->db->lastInsertId();
    }

    public function setApp($app)
    {
        $this->app = $app;
        $this->currentUrl = $app->request->getRoute();
    }
    public function createContent($title)
    {
        $stmt = $this->db->prepare("INSERT into Shop_Content (title) VALUES ('$title')");
        $stmt->execute();
    }

    /**
     * Adds content to the database based on ID
     * @param $id contains the id
     * @return void
     */
    public function editContent($params)
    {
        // Prepare SQL statement to UPDATE a row in the table
        $stmt = $this->db->prepare("UPDATE Shop_Content SET title = ?, slug = ?, data = ?, type = ?, filter = ?, published = ?, updated=NOW() WHERE id = ?");
        // Execute the SQL to Update
        $stmt->execute($params);
    }

    // Echo edit form. Uses ID
    public function deleteContent($id)
    {
        $stmt = $this->db->prepare("UPDATE Shop_Content SET deleted=NOW() WHERE id = '$id';");
        $stmt->execute();
    }
}
