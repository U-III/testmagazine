<?php
header('Content-Type: text/html; charset=UTF-8');
$cache = new Memcached();
$cache -> addServer('127.0.0.1', 11211);
require_once('./lib/config.php');
$sort = 0;
if (isset($_GET['sort']) || intval($_GET['sort'])>0 || intval($_GET['sort'])<3) {
    $sort = intval($_GET['sort']);
}

switch ($sort) {
    default:
    case 0:
        $sortstring = "category.name, product.name";
        $nextsort = "?sort=1";
        $symbolsort="&emsp;";
        break;
    case 1:
        $sortstring = "product.popularity DESC";
        $nextsort = "?sort=2";
        $symbolsort="▲";
        break;
    case 2:
        $sortstring = "product.popularity";
        $nextsort = "";
        $symbolsort="▼";
        break;
}

$html = <<<HTML
<!DOCTYPE html>
<html>
<head>
    <title>Каталог товаров - онлайн магазин</title>
    <link rel="stylesheet" type="text/css" href="./styles.css">
</head>
<body>
    <header>
        <div class="container">
            <a href="/" style="text-decoration: none"><h1>Онлайн-магазин</h1></a>
            <h2>Каталог товаров</h2>
        </div>
    </header>
    <main>
        <div class="container">
            <table cellspad>
                <thead>
                    <tr>
                        <td colspan="2"><center>Название</center></td>
                        <td><center>Категория</center></td>
                        <td><center>Описание</center></td>
                        <td><center>Цена</center></td>
                        <td><center><a href="/{$nextsort}">Популярность</a>{$symbolsort}</center></td>
                    </tr>
                </thead>

HTML;

$products=$cache->get('TESTMAGAZINEPRODUCTS_' . $sort);
if ($products === false || !USE_CACHE) {
    $products = $db->super_query("SELECT product.id, product.name, product.description, product.price, product.popularity, category.name as catname, category.description as catdesc FROM `product` LEFT JOIN category ON product.id_category = category.id where product.enable = 1 and category.enable = 1 order by {$sortstring};", true);
}

foreach ($products as &$product) {
    if (!isset($product['image'])) {
        $image = $db->super_query("SELECT id FROM `pictures` where id_product = {$product['id']} and enable = 1 order by id LIMIT 1;");
        $product['image'] = intval($image['id']);
    }

    $img = "/img/no_photo.png";
    if ($product['image']>0) {
        $img = "/img/pictureid_{$product['image']}.png";
    }

    $html .= <<<HTML
    <tr class="product" title = "{$product['name']}" onclick="location='/product.php?id={$product['id']}';">
        <td width="66"><img src="{$img}" title="{$product['name']}" width="64" height="64" style="border-radius: 50%; border: 5px solid #A9A9A9;"></td>
        <td width="250"><p class="title">{$product['name']}</p></td>
        <td title = "{$product['catdesc']}"><center>{$product['catname']}</center></td>
        <td><p class="desc">{$product['description']}</p></td>
        <td><center>{$product['price']} руб.</center></td>
        <td><center>{$product['popularity']}</center></td>
    </tr>
    HTML;
}

if (USE_CACHE) {
    $cache->set('TESTMAGAZINEPRODUCTS_' . $sort, $products , TIMEPRODUCTS);
}

$html .= <<<HTML
            </table>
        </div>
    </main>
    <footer>
        <br>
        <center> 2020 TEST </center>        
        <br>
    </footer>
</body>
</html>
HTML;
echo $html;
die();
?>