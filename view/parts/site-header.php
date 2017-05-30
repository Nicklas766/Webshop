<body>

    <div class ="site-header">
        <div class ="flex-container">

            <div class="header-widget" style="line-height:20px;">
                <?php
                echo $app->navbar->getHTML(0);
                $cstName = $app->session->get('name');
                $cstId = $app->connect->getRes("SELECT * FROM Shop_User WHERE name LIKE '$cstName'")["id"];
                $allAmount = $app->connect->getAllRes("SELECT * FROM VShoppingCart WHERE Customer_ID LIKE '$cstId'");
                $amount = 0;
                foreach ($allAmount as $row) {
                    $amount += $row["Amount"];
                }
                ?>
                <p style="font-size:16px;"> Du har <?= $amount ?> produkt(er) i varukorgen </p>
                <a href="<?= $app->url->create('checkout')?>" style="font-size:16px; color:orange;"> Gå till kassan!</a>
            </div>

            <div class="header-widget" style="line-height:10px;">
                <h1><a style="text-decoration:none; color:white; font-size:1em;" href="<?= $app->url->create('')?>">WebShop</a></h1>
            </div>

            <div class="header-widget">
                <?php
                $user = $app->session->get("name");

                echo $app->navbar->getHTML(2);

                // Control if admin, and show admin tools
                if ($app->admin->adminControl($user)) {
                    echo $app->navbar->getHTML(1);
                }


                ?>
            </div>


        </div></div>


        <div class="main-container">
