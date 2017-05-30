<?php
    $pageInfo = $app->page->getPageInfo(); // Get current info from class
    $text = $app->textfilter->doFilter($pageInfo["footer"], $pageInfo["footerFilter"]);
?>


</div>
<div class ="site-footer">
<i class='material-icons'>copyright</i><?= $text ?>
</div>
</body>
