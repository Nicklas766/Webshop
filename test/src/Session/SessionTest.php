<?php

namespace nicklas\Session;

/**
 * Test cases for class Navbar
 */
class SessionTest extends \PHPUnit_Framework_TestCase
{
    /**
     * Test case to construct object and verify that the object
     * has the expected properties due various ways of constructing
     * it.
     */
    public function testCreateObject()
    {
        $session = new Session();
        $this->assertInstanceOf("nicklas\Session\Session", $session);
    }
}
