<?php
    $pageInfo = $app->page->getPageInfo(); // Get current info from class
    $text = $app->textfilter->doFilter($pageInfo["about"], $pageInfo["aboutFilter"]);
?>
<div class="content-div">
<?= $text ?>
</div>
