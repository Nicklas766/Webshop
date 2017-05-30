<?php
$res = $app->connect->getAllRes("SELECT * FROM Shop_Content");
?>

<div class="content-div">
    <h2> Alla inlägg </h2>

    <table>
        <tr>
            <th>Edit</th>
            <th>ID</th>
            <th>Title</th>
            <th>Published</th>
            <th>Created</th>
            <th>Updated</th>
            <th>Deleted</th>
            <th>Slug</th>
        </tr>

        <?php  foreach ($res as $row) :?>
            <tr>
                <td><a href="<?= $this->app->url->create('admin/content/edit') ?>?id=<?= $row["id"] ?>">Edit</a></td>
                <td><?= $row["id"] ?></td>
                <td><?= $row["title"] ?></td>
                <td><?= $row["published"] ?></td>
                <td><?= $row["created"] ?></td>
                <td><?= $row["updated"] ?></td>
                <td><?= $row["deleted"] ?></td>
                <td><?= $row["slug"] ?></td>
            </tr>
        <?php endforeach; ?>

    </table>
</div>
