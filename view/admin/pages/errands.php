<?php
$res = $app->connect->getAllRes("SELECT * FROM CustomerErrand WHERE status = 'active' ORDER BY created ASC");
$res2 = $app->connect->getAllRes("SELECT * FROM CustomerErrand WHERE status = 'closed' ORDER BY created DESC");
?>


<div class="flex-container">
    <h1 style="background:green; width:50%; color:white;"> Ärenden </h1>
    <h1  style="background:red; width:50%; color:white;"> Stängda </h1>
<div class="flex-container" style="width:50%;">
    <?php foreach ($res as $row) :?>
        <a class="errand-widget" href="<?= $app->url->create('admin/errand')?>?id=<?= $row["id"] ?>">
            <h3> <?= esc($row["title"]) ?> </h3>
            <p> <?= esc($row["created"]) ?> </p>
        </a>

    <?php endforeach; ?>
</div>



<div class="flex-container" style="width:50%;">
    <?php foreach ($res2 as $row) :?>
        <a class="errand-widget" href="<?= $app->url->create('admin/errand')?>?id=<?= $row["id"] ?>">
            <h3> <?= esc($row["title"]) ?> </h3>
            <p> <?= esc($row["created"]) ?> </p>
        </a>

    <?php endforeach; ?>
</div>
</div>
