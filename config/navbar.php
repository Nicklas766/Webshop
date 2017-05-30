<?php

// Multidimensional Array that contain navbar class, and option information for href.
return [
    [
    "config" => [
        "navbar-class" => "site-navbar"
    ],
    "items" => [
        "products" => [
            "text" => "<span class='material-icons'>shopping_cart</span> <span>Produkter</span>",
            "route" => "products",
        ],
        "blog" => [
            "text" => "<span class='material-icons'>library_books</span> <span>Nyheter</span>",
            "route" => "blog",
        ],
        "about" => [
            "text" => "<span class='material-icons'>info_outline</span> <span>Om</span>",
            "route" => "about",
        ],
    ]
    ],
    [
    "config" => [
      "navbar-class" => "site-navbar right"
    ],
    "items" => [
      "Admin" => [
          "text" => "<span class='material-icons'>build</span> <span>Admin Tools</span>",
          "route" => "admin",
      ]
    ]
    ],
    [
    "config" => [
      "navbar-class" => "site-navbar right"
    ],
    "items" => [
      "profile" => [
          "text" => "<span class='material-icons'>person</span> <span>Profil</span>",
          "route" => "profile",
      ],
      "logout" => [
          "text" => "<span class='material-icons'>exit_to_app</span> <span>Logga ut</span>",
          "route" => "logout",
      ]
    ]
    ],
    [
    "config" => [
      "navbar-class" => "admin-navbar"
    ],
    "items" => [
      "users" => [
          "text" => "<i class='material-icons'>people</i>Användare",
          "route" => "admin/users",
      ],
      "admin/webshop" => [
          "text" => "<i class='material-icons'>shopping_cart</i>Produkter",
          "route" => "admin/webshop",
      ],
      "admin/webshop/stock" => [
          "text" => "<i class='material-icons'>local_shipping</i>Lagret",
          "route" => "admin/webshop/stock",
      ],
      "admin/content" => [
          "text" => "<i class='material-icons'>mode_edit</i>Innehåll",
          "route" => "admin/content",
      ],
      "admin/deals/week" => [
          "text" => "<i class='material-icons'>mode_edit</i>Erbjudande",
          "route" => "admin/deals/week",
      ],
      "admin/errands" => [
          "text" => "<i class='material-icons'>mode_edit</i>Ärenden",
          "route" => "admin/errands",
      ]
    ]
    ],

    [
    "config" => [
      "navbar-class" => "admin-navbar"
    ],
    "items" => [
      "admin/content/create" => [
          "text" => "Nytt inlägg",
          "route" => "admin/content/create",
      ],
      "admin/content/overview" => [
          "text" => "Inlägg",
          "route" => "admin/content/overview",
      ],
      "admin/content/pages" => [
          "text" => "Sidor",
          "route" => "admin/content/pages",
      ]
    ]
    ],
    [
    "config" => [
      "navbar-class" => "admin-navbar"
    ],
    "items" => [
      "admin/deals/week" => [
          "text" => "Veckans pris",
          "route" => "admin/deals/week",
      ],
      "admin/deals/recommend" => [
          "text" => "Rekommendera",
          "route" => "admin/deals/recommend",
      ]
    ]
    ]
];
