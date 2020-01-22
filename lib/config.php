<?PHP
define ("TESTMAGAZINE", true); 
define("USE_CACHE", true); // использовать ли кеш.
define ("TIMEPRODUCTS", 60); //время кеширования списка продуктов
define ("TIMEPRODUCT", 300); //время кеширование информации о продукте
require_once('mysql.php');
define ("DBHOST", "localhost"); 
define ("DBNAME", "test");
define ("DBUSER", "test");
define ("DBPASS", "test_2350"); 
define ("COLLATE", "utf8"); 
$db = new db;
session_start();
if (!isset($_SESSION['SECKEY'])) {
    $_SESSION['SECKEY'] = MD5(time().$_SERVER['REMOTE_ADDR']);
}
?>