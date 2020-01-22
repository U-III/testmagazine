-- --------------------------------------------------------
-- Хост:                         85.25.72.79
-- Версия сервера:               10.4.11-MariaDB-1:10.4.11+maria~bionic-log - mariadb.org binary distribution
-- Операционная система:         debian-linux-gnu
-- HeidiSQL Версия:              10.3.0.5771
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Дамп структуры базы данных test
CREATE DATABASE IF NOT EXISTS `test` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `test`;

-- Дамп структуры для таблица test.category
CREATE TABLE IF NOT EXISTS `category` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `enable` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `name` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы test.category: 3 rows
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` (`id`, `enable`, `name`, `description`) VALUES
	(1, 1, 'Категория 1', 'Тестовая категория 1');
INSERT INTO `category` (`id`, `enable`, `name`, `description`) VALUES
	(2, 1, 'Категория 2', 'Тестовая категория 2');
INSERT INTO `category` (`id`, `enable`, `name`, `description`) VALUES
	(3, 1, 'Категория 3', 'Тестовая категория 3');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;

-- Дамп структуры для таблица test.pictures
CREATE TABLE IF NOT EXISTS `pictures` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `id_product` bigint(20) unsigned NOT NULL,
  `enable` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `id_product` (`id_product`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы test.pictures: 10 rows
/*!40000 ALTER TABLE `pictures` DISABLE KEYS */;
INSERT INTO `pictures` (`id`, `id_product`, `enable`) VALUES
	(1, 1, 1);
INSERT INTO `pictures` (`id`, `id_product`, `enable`) VALUES
	(2, 1, 1);
INSERT INTO `pictures` (`id`, `id_product`, `enable`) VALUES
	(3, 1, 1);
INSERT INTO `pictures` (`id`, `id_product`, `enable`) VALUES
	(4, 2, 1);
INSERT INTO `pictures` (`id`, `id_product`, `enable`) VALUES
	(5, 3, 1);
INSERT INTO `pictures` (`id`, `id_product`, `enable`) VALUES
	(6, 4, 1);
INSERT INTO `pictures` (`id`, `id_product`, `enable`) VALUES
	(7, 4, 1);
INSERT INTO `pictures` (`id`, `id_product`, `enable`) VALUES
	(8, 5, 1);
INSERT INTO `pictures` (`id`, `id_product`, `enable`) VALUES
	(9, 5, 1);
INSERT INTO `pictures` (`id`, `id_product`, `enable`) VALUES
	(10, 5, 1);
/*!40000 ALTER TABLE `pictures` ENABLE KEYS */;

-- Дамп структуры для таблица test.popularity_log
CREATE TABLE IF NOT EXISTS `popularity_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `id_product` bigint(20) unsigned NOT NULL,
  `popularity` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_product` (`id_product`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

-- Дамп данных таблицы test.popularity_log: 9 rows
/*!40000 ALTER TABLE `popularity_log` DISABLE KEYS */;
INSERT INTO `popularity_log` (`id`, `date`, `id_product`, `popularity`) VALUES
	(1, '2020-01-22 19:16:45', 5, 9);
INSERT INTO `popularity_log` (`id`, `date`, `id_product`, `popularity`) VALUES
	(2, '2020-01-22 19:18:59', 5, 11);
INSERT INTO `popularity_log` (`id`, `date`, `id_product`, `popularity`) VALUES
	(3, '2020-01-22 19:22:43', 4, 11);
INSERT INTO `popularity_log` (`id`, `date`, `id_product`, `popularity`) VALUES
	(4, '2020-01-22 19:23:24', 4, 10);
INSERT INTO `popularity_log` (`id`, `date`, `id_product`, `popularity`) VALUES
	(5, '2020-01-22 19:23:29', 4, 12);
INSERT INTO `popularity_log` (`id`, `date`, `id_product`, `popularity`) VALUES
	(6, '2020-01-22 19:23:41', 6, 2);
INSERT INTO `popularity_log` (`id`, `date`, `id_product`, `popularity`) VALUES
	(7, '2020-01-22 19:25:01', 4, 12);
INSERT INTO `popularity_log` (`id`, `date`, `id_product`, `popularity`) VALUES
	(8, '2020-01-22 19:27:37', 1, 10);
INSERT INTO `popularity_log` (`id`, `date`, `id_product`, `popularity`) VALUES
	(9, '2020-01-22 19:27:42', 1, 12);
/*!40000 ALTER TABLE `popularity_log` ENABLE KEYS */;

-- Дамп структуры для таблица test.product
CREATE TABLE IF NOT EXISTS `product` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `id_category` bigint(20) unsigned NOT NULL,
  `enable` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `name` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `popularity` bigint(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `id_category` (`id_category`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы test.product: 6 rows
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` (`id`, `id_category`, `enable`, `name`, `description`, `price`, `popularity`) VALUES
	(1, 1, 1, 'Товар 1', 'Тестовый товар 1', 1.00, 12);
INSERT INTO `product` (`id`, `id_category`, `enable`, `name`, `description`, `price`, `popularity`) VALUES
	(2, 1, 1, 'Товар 2', 'Тестовый товар 2', 2.00, 2);
INSERT INTO `product` (`id`, `id_category`, `enable`, `name`, `description`, `price`, `popularity`) VALUES
	(3, 1, 1, 'Товар 3', 'Тестовый товар 3', 3.00, -1);
INSERT INTO `product` (`id`, `id_category`, `enable`, `name`, `description`, `price`, `popularity`) VALUES
	(4, 2, 1, 'Товар 4', 'Тестовый товар 4', 4.00, 12);
INSERT INTO `product` (`id`, `id_category`, `enable`, `name`, `description`, `price`, `popularity`) VALUES
	(5, 2, 1, 'Товар 5', 'Тестовый товар 5', 5.00, 11);
INSERT INTO `product` (`id`, `id_category`, `enable`, `name`, `description`, `price`, `popularity`) VALUES
	(6, 3, 1, 'Товар 6', 'Тестовый товар 6', 6.00, 2);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;

-- Дамп структуры для процедура test.update_popularity
DELIMITER //
CREATE PROCEDURE `update_popularity`(
	IN `f_id_product` BIGINT
)
BEGIN
SELECT SUM(view_log.view), COUNT(*) INTO @V, @Vw FROM `view_log` where view_log.id_product=f_id_product AND DATE>=DATE_SUB(CURRENT_DATE, INTERVAL 180 DAY);
SET @U = @Vw - @V;
SELECT COUNT(*) INTO @Pc FROM pictures WHERE pictures.id_product = f_id_product;
SET @P = 0;
IF @Pc > 1 THEN SET @P = 1; END IF;
SET @POP = @V + 10*@P - @U;
UPDATE product SET popularity = @POP WHERE id = f_id_product;
INSERT INTO popularity_log (`id_product`, `popularity`) VALUES (f_id_product, @POP);
END//
DELIMITER ;

-- Дамп структуры для таблица test.view_log
CREATE TABLE IF NOT EXISTS `view_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `session` varchar(32) CHARACTER SET latin1 DEFAULT NULL,
  `id_product` bigint(20) unsigned DEFAULT NULL,
  `view` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`,`date`),
  UNIQUE KEY `session_id_product` (`session`,`id_product`),
  KEY `date_id_product` (`date`,`id_product`)
) ENGINE=MyISAM AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы test.view_log: 10 rows
/*!40000 ALTER TABLE `view_log` DISABLE KEYS */;
INSERT INTO `view_log` (`id`, `date`, `session`, `id_product`, `view`) VALUES
	(1, '2020-01-22 18:13:08', 'd59df33965e992f546f260dbc95d8ea7', 6, 1);
INSERT INTO `view_log` (`id`, `date`, `session`, `id_product`, `view`) VALUES
	(3, '2020-01-22 18:14:43', 'd9d3678b22dc3761056b9093b4d33114', 6, 1);
INSERT INTO `view_log` (`id`, `date`, `session`, `id_product`, `view`) VALUES
	(13, '2020-01-22 18:50:40', 'd59df33965e992f546f260dbc95d8ea7', 5, 1);
INSERT INTO `view_log` (`id`, `date`, `session`, `id_product`, `view`) VALUES
	(14, '2020-01-22 18:50:43', 'd59df33965e992f546f260dbc95d8ea7', 4, 1);
INSERT INTO `view_log` (`id`, `date`, `session`, `id_product`, `view`) VALUES
	(15, '2020-01-22 18:50:45', 'd59df33965e992f546f260dbc95d8ea7', 1, 1);
INSERT INTO `view_log` (`id`, `date`, `session`, `id_product`, `view`) VALUES
	(16, '2020-01-22 18:50:46', 'd59df33965e992f546f260dbc95d8ea7', 2, 1);
INSERT INTO `view_log` (`id`, `date`, `session`, `id_product`, `view`) VALUES
	(17, '2020-01-22 18:50:47', 'd59df33965e992f546f260dbc95d8ea7', 3, 0);
INSERT INTO `view_log` (`id`, `date`, `session`, `id_product`, `view`) VALUES
	(21, '2020-01-22 19:09:31', 'd9d3678b22dc3761056b9093b4d33114', 2, 1);
INSERT INTO `view_log` (`id`, `date`, `session`, `id_product`, `view`) VALUES
	(24, '2020-01-22 19:23:24', 'd9d3678b22dc3761056b9093b4d33114', 4, 1);
INSERT INTO `view_log` (`id`, `date`, `session`, `id_product`, `view`) VALUES
	(29, '2020-01-22 19:27:37', 'd9d3678b22dc3761056b9093b4d33114', 1, 1);
/*!40000 ALTER TABLE `view_log` ENABLE KEYS */;

-- Дамп структуры для триггер test.view_log_after_insert
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `view_log_after_insert` AFTER INSERT ON `view_log` FOR EACH ROW BEGIN
CALL `update_popularity`(NEW.id_product);
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Дамп структуры для триггер test.view_log_after_update
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `view_log_after_update` AFTER UPDATE ON `view_log` FOR EACH ROW BEGIN
IF NEW.view != OLD.view THEN 
CALL `update_popularity`(NEW.id_product);
END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
