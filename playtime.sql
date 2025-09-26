-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: playtime
-- ------------------------------------------------------
-- Server version	8.0.42

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `active_events`
--

DROP TABLE IF EXISTS `active_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `active_events` (
  `id_event` int NOT NULL,
  `id_user` int NOT NULL,
  KEY `id_events_fk_idx` (`id_event`),
  KEY `id_user_fk_idx` (`id_user`),
  CONSTRAINT `id_events_fk` FOREIGN KEY (`id_event`) REFERENCES `event` (`id_event`),
  CONSTRAINT `id_user_fk` FOREIGN KEY (`id_user`) REFERENCES `users` (`iduser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `active_events`
--

LOCK TABLES `active_events` WRITE;
/*!40000 ALTER TABLE `active_events` DISABLE KEYS */;
/*!40000 ALTER TABLE `active_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event`
--

DROP TABLE IF EXISTS `event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `event` (
  `id_event` int NOT NULL AUTO_INCREMENT,
  `id_user` int NOT NULL COMMENT 'айди организатора',
  `id_game` int NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'наименование события',
  `date` datetime NOT NULL COMMENT 'дата и время',
  `location` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'место проведения',
  `duration` int NOT NULL COMMENT 'продолжительность (в минутах)',
  `max_player` int NOT NULL COMMENT 'макс. кол-во игроков',
  `description` text COLLATE utf8mb4_unicode_ci COMMENT 'краткое описание',
  `status` enum('Запланировано','Окончено','Отменено') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Запланировано',
  PRIMARY KEY (`id_event`),
  KEY `idx_organizer` (`id_user`),
  KEY `idx_event_date` (`date`),
  KEY `idx_event_location` (`location`(100)),
  KEY `id_game_fk_idx` (`id_game`),
  CONSTRAINT `event_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`iduser`) ON DELETE CASCADE,
  CONSTRAINT `id_game_fk` FOREIGN KEY (`id_game`) REFERENCES `game` (`id_game`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event`
--

LOCK TABLES `event` WRITE;
/*!40000 ALTER TABLE `event` DISABLE KEYS */;
/*!40000 ALTER TABLE `event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game`
--

DROP TABLE IF EXISTS `game`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `game` (
  `id_game` int NOT NULL,
  `id_genres` int NOT NULL,
  `name_game` varchar(300) NOT NULL,
  `min_count_player` int NOT NULL,
  `time_party` int NOT NULL,
  `min_age_game` int NOT NULL,
  `description_game` varchar(500) NOT NULL,
  PRIMARY KEY (`id_game`),
  KEY `id_genres_fk_idx` (`id_genres`),
  CONSTRAINT `id_genres_fk` FOREIGN KEY (`id_genres`) REFERENCES `genres` (`id_genres`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game`
--

LOCK TABLES `game` WRITE;
/*!40000 ALTER TABLE `game` DISABLE KEYS */;
/*!40000 ALTER TABLE `game` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genres`
--

DROP TABLE IF EXISTS `genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `genres` (
  `id_genres` int NOT NULL,
  `name_genres` varchar(300) NOT NULL,
  PRIMARY KEY (`id_genres`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genres`
--

LOCK TABLES `genres` WRITE;
/*!40000 ALTER TABLE `genres` DISABLE KEYS */;
/*!40000 ALTER TABLE `genres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `id_reviews` int NOT NULL,
  `id_event` int NOT NULL,
  `id_user_send` int NOT NULL COMMENT 'Идентификатор пользователя который ОТПРАВИЛ отзыв',
  `id_user_accept` int NOT NULL COMMENT 'Идентификатор пользователя НА которого написан отзыв',
  `rating` int NOT NULL,
  `comment` text,
  PRIMARY KEY (`id_reviews`),
  KEY `id_event_fk_idx` (`id_event`),
  KEY `id_user_send_fk_idx` (`id_user_send`),
  KEY `id_user_accept_idx` (`id_user_accept`),
  CONSTRAINT `id_event_fk` FOREIGN KEY (`id_event`) REFERENCES `event` (`id_event`),
  CONSTRAINT `id_user_accept` FOREIGN KEY (`id_user_accept`) REFERENCES `users` (`iduser`),
  CONSTRAINT `id_user_send_fk` FOREIGN KEY (`id_user_send`) REFERENCES `users` (`iduser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `type_city`
--

DROP TABLE IF EXISTS `type_city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `type_city` (
  `idcity` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'наименование города',
  PRIMARY KEY (`idcity`),
  UNIQUE KEY `unique_city_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `type_city`
--

LOCK TABLES `type_city` WRITE;
/*!40000 ALTER TABLE `type_city` DISABLE KEYS */;
INSERT INTO `type_city` VALUES (4,'Екатеринбург'),(5,'Казань'),(1,'Москва'),(3,'Новосибирск'),(2,'Санкт-Петербург');
/*!40000 ALTER TABLE `type_city` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `iduser` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `surname` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `patronymic` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'почта',
  `password_hash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'пароль (хэш)',
  `type_city` int NOT NULL COMMENT 'город',
  `age` int DEFAULT NULL COMMENT 'возраст',
  `sex` enum('Мужской','Женский') COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'пол (M - мужской, F - женский, O - другой)',
  `rating` decimal(3,2) DEFAULT '0.00' COMMENT 'рейтинг пользователя',
  `description` text COLLATE utf8mb4_unicode_ci COMMENT 'краткое описание',
  `discord_link` varchar(300) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telegram_link` varchar(300) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role` enum('Пользователь','Администратор') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`iduser`),
  UNIQUE KEY `email` (`email`),
  KEY `idx_email` (`email`),
  KEY `idx_city` (`type_city`),
  KEY `idx_rating` (`rating`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`type_city`) REFERENCES `type_city` (`idcity`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-09-26 14:24:34
