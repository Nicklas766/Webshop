<?php
$resLow = $app->connect->getAllRes("SELECT * FROM Shop_LowStock");
?>

<section>
    <h3> Low Stock Log </h3>
    <table>
        <tr class="first">
            <th> PROD_ID </th>
            <th> Amount </th>
            <th> Occured </th>

        </tr>
    <?php foreach ($resLow as $row) :?>
            <tr>
            <td> <?= $row["prod_id"] ?> </td>
            <td> <?= $row["amount"] ?> </td>
            <td style="background:orange;"> <?= $row["occured"] ?> </td>
            </tr>

    <?php endforeach; ?>
    </table>
</section>

</div>
