<?php
header('Content-Type: text/html; charset=UTF-8');
$cache = new Memcached();
$cache -> addServer('127.0.0.1', 11211);
require_once('./lib/config.php');


function ErrorProduct() {
$error = <<<HTML
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
            <h2>Ошибка! Товар не найден.</h2>
        </div>
    </header>
    <main>
    </main>
    <footer>
        <br>
        <center> 2020 TEST </center>        
        <br>
    </footer>

HTML;
die($error);
}

$productid = 0;
if (isset($_GET['id'])) {
    $productid = intval($_GET['id']);
}

if ($productid == 0) ErrorProduct();

$product=$cache->get('TESTMAGAZINEPRODUCT_'.$productid);
if ($product === false || !USE_CACHE) {
    $product = $db->super_query("SELECT product.id, product.name, product.description, product.price, category.name as catname, category.description as catdesc FROM `product` LEFT JOIN category ON product.id_category = category.id where product.id = {$productid} and product.enable = 1 and category.enable = 1 LIMIT 1;");
}

if (!isset($product['id']) OR intval($product['id']) != $productid) ErrorProduct();

if (isset($_GET['view']) || intval($_GET['view']) == 1) {
$db->query("UPDATE `view_log` SET `view` = 1 where `session` = '{$_SESSION['SECKEY']}' AND `id_product` = {$product['id']} LIMIT 1;");
die();
}

$db->query("INSERT IGNORE INTO `view_log` (`session`, `id_product`) VALUES ('{$_SESSION['SECKEY']}', {$product['id']});");

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
            <h2>{$product['name']}</h2>
        </div>
    </header>
    <main>
        <div class="container">
            <table cellspad>
                <thead>
                    <tr>
                        <td><center>Фото</center></td>
                        <td><center>Категория</center></td>
                        <td><center>Описание</center></td>
                        <td><center>Цена</center></td>
                    </tr>
                </thead>

HTML;

    if (!isset($product['images'])) {
        $images = $db->super_query("SELECT id FROM `pictures` where id_product = {$product['id']} and enable = 1 order by id;", true);
        $product['images'] = $images;
    }

    $html .= <<<HTML
    <tr class="product" title = "{$product['name']}">
    <td>
    HTML;
    if (count($product['images'])>0) {
        foreach ($product['images'] as $image) {
            $img = "/img/pictureid_{$image['id']}.png";
            $html .= <<<HTML
                <img src="{$img}" title="{$product['name']}" width="64" height="64" style="border-radius: 50%; border: 5px solid #A9A9A9;">
            HTML;
        }
    } else {
        $img = "/img/no_photo.png";
        $html .= <<<HTML
            <img src="{$img}" title="{$product['name']}" width="64" height="64" style="border-radius: 50%; border: 5px solid #A9A9A9;">
        HTML;
    }
    $html .= <<<HTML
    </td>
        <td title = "{$product['catdesc']}"><center>{$product['catname']}</center></td>
        <td><p class="desc">{$product['description']}</p></td>
        <td><center>{$product['price']} руб.</center></td>
    </tr>
    HTML;

if (USE_CACHE) {
    $cache->set('TESTMAGAZINEPRODUCT_'.$productid, $product , TIMEPRODUCT);
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
<script>
    setTimeout(function(){
       fetch(location+"&view=1");
    },5000)
</script>

</html>
HTML;
echo $html;
die();
?>