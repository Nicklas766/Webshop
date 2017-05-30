
<?php

$blog = $app->blog;
// control if its slug, then get the post
if (substr($app->request->getRoute(), 0, 5) === "blog/") {
    $slug = substr($app->request->getRoute(), 5);
    $resultset = $blog->getBlogPost($slug);
    if (!$resultset) {
         header("Location: {$app->url->create('notfound')}");
         break;
    }
    $blog->showPost($resultset);
// ELSE show entire blog
} else {
    $blog->showBlog();
}
