<?php
/**
 * Bootstrap the framework.
 */
// Were are all the files?
define("ANAX_INSTALL_PATH", realpath(__DIR__ . "/.."));
define("ANAX_APP_PATH", ANAX_INSTALL_PATH);
// Include essentials
require ANAX_INSTALL_PATH . "/config/error_reporting.php";
// Get the autoloader by using composers version.
require ANAX_INSTALL_PATH . "/vendor/autoload.php";
// Add all resources to $app
$app = new \nicklas\App\App();
$app->request  = new \Anax\Request\Request();
$app->response = new \Anax\Response\Response();
$app->url      = new \Anax\Url\Url();
$app->router   = new \Anax\Route\RouterInjectable();
$app->view     = new \Anax\View\ViewContainer();
$app->session  = new \nicklas\Session\Session();
$app->navbar = new \nicklas\Navbar\Navbar();

// Get admin, connect and content class
$app->connect = new \nicklas\Connect\Connect();
$app->admin = new \nicklas\Connect\Admin();
$app->errand = new \nicklas\Connect\Errand();
$app->content = new \nicklas\Connect\Content();
$app->page = new \nicklas\Connect\Page();
$app->blog = new \nicklas\Connect\Blog();

// Get webshop class
$app->webshop = new \nicklas\Connect\Webshop();
$app->customer = new \nicklas\Connect\Customer();
$app->product = new \nicklas\Connect\Product();
// Textfilterclass
$app->textfilter = new \nicklas\Textfilter\Textfilter();


// Inject $app into the view and navbar/admin classes/files.
$app->view->setApp($app);
$app->navbar->setApp($app);
$app->admin->setApp($app);
$app->content->setApp($app);
$app->page->setApp($app);
$app->blog->setApp($app);
$app->webshop->setApp($app);
$app->customer->setApp($app);
$app->product->setApp($app);
$app->errand->setApp($app);
// Update view configuration with values from config file.
$app->view->configure("view.php");
$app->navbar->configure("navbar.php");

// Init the object of the request class.
$app->request->init();
// Init the url-object with default values from the request object.
$app->url->setSiteUrl($app->request->getSiteUrl());
$app->url->setBaseUrl($app->request->getBaseUrl());
$app->url->setStaticSiteUrl($app->request->getSiteUrl());
$app->url->setStaticBaseUrl($app->request->getBaseUrl());
$app->url->setScriptName($app->request->getScriptName());
// Update url configuration with values from config file.
$app->url->configure("url.php");
$app->url->setDefaultsFromConfiguration();

// Load the routes
require ANAX_INSTALL_PATH . "/config/route.php";
// Leave to router to match incoming request to routes
$app->router->handle($app->request->getRoute(), $app->request->getMethod());
