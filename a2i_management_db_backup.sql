-- MySQL dump 10.13  Distrib 8.0.39, for Win64 (x86_64)
--
-- Host: localhost    Database: a2i_management_db
-- ------------------------------------------------------
-- Server version	8.0.39

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add task',7,'add_task'),(26,'Can change task',7,'change_task'),(27,'Can delete task',7,'delete_task'),(28,'Can view task',7,'view_task'),(29,'Can add task attachment',8,'add_taskattachment'),(30,'Can change task attachment',8,'change_taskattachment'),(31,'Can delete task attachment',8,'delete_taskattachment'),(32,'Can view task attachment',8,'view_taskattachment'),(33,'Can add user',9,'add_user'),(34,'Can change user',9,'change_user'),(35,'Can delete user',9,'delete_user'),(36,'Can view user',9,'view_user'),(37,'Can add user profile',10,'add_userprofile'),(38,'Can change user profile',10,'change_userprofile'),(39,'Can delete user profile',10,'delete_userprofile'),(40,'Can view user profile',10,'view_userprofile'),(41,'Can add incident',11,'add_incident'),(42,'Can change incident',11,'change_incident'),(43,'Can delete incident',11,'delete_incident'),(44,'Can view incident',11,'view_incident'),(45,'Can add source',12,'add_source'),(46,'Can change source',12,'change_source'),(47,'Can delete source',12,'delete_source'),(48,'Can view source',12,'view_source'),(49,'Can add support category',13,'add_supportcategory'),(50,'Can change support category',13,'change_supportcategory'),(51,'Can delete support category',13,'delete_supportcategory'),(52,'Can view support category',13,'view_supportcategory'),(53,'Can add incident',14,'add_incident'),(54,'Can change incident',14,'change_incident'),(55,'Can delete incident',14,'delete_incident'),(56,'Can view incident',14,'view_incident'),(57,'Can add source',15,'add_source'),(58,'Can change source',15,'change_source'),(59,'Can delete source',15,'delete_source'),(60,'Can view source',15,'view_source'),(61,'Can add support category',16,'add_supportcategory'),(62,'Can change support category',16,'change_supportcategory'),(63,'Can delete support category',16,'delete_supportcategory'),(64,'Can view support category',16,'view_supportcategory'),(65,'Can add attendance',17,'add_attendance'),(66,'Can change attendance',17,'change_attendance'),(67,'Can delete attendance',17,'delete_attendance'),(68,'Can view attendance',17,'view_attendance');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$600000$XN2ZcUCzzGLZCwylVmKh9r$nsbe7Du077IPWznmwaTi8o0GwLQSAvuBqQMltf1teeU=','2024-10-09 07:55:00.723130',1,'Rashik','','','mail5dipto@gmail.com',1,1,'2024-09-15 02:44:31.683285'),(6,'pbkdf2_sha256$600000$OmAZYasw1GGR8tlMkqfYdG$2+aXmtZsKqRDIxY8ifJw+kK7gVaIC0PBsDAEIFHVMIw=','2024-09-17 00:43:16.339706',0,'rahim123@gmail.com','','','rahim123@gmail.com',0,1,'2024-09-17 00:03:08.081314'),(15,'pbkdf2_sha256$600000$ygxCZAEVYAKe1h2a505H67$dqm4U5d3vgFFdQASWwY6z5PM6rWPQcLmLvKVdOvza5E=','2024-09-17 19:34:06.270804',0,'Rahim','','','rahim@gmail.com',1,1,'2024-09-17 17:37:33.739239'),(16,'pbkdf2_sha256$600000$VKIHOZVCtG2tY5wYZpQMIe$eU1H+Y4itX5swKmrUaP8E5jxvfR6muNXq/vD46uL++w=','2024-09-29 04:49:48.216984',0,'Karm','','','karm@gmail.com',0,1,'2024-09-17 18:02:51.856424'),(22,'pbkdf2_sha256$600000$eSv3ZwG1mshX20iLLrr6Dw$uZ5Y1rV14cxAvXWpE2RYtskzpbOnfzuihBoaHL5K1bI=','2024-09-18 09:10:06.547639',0,'Siam','','','siam@gmail.com',0,1,'2024-09-18 09:09:45.047856'),(23,'pbkdf2_sha256$600000$GJx0SaMVSp96Y0jTMfWRnE$tjXFOCljVC9keXCm9O795QxT0dM6U5CPXJXjvhdbsiU=',NULL,0,'Dave','','','Davi@gmail.com',0,1,'2024-09-22 05:15:26.235111'),(25,'pbkdf2_sha256$600000$Rhn8Zfi7YMv8tR028PEfMJ$GEJ9ikUtl4CfQfiUyS3IHx6C7rmn1xpyZWl6cKJuQi0=',NULL,0,'Niko','','','Niko@gmail.com',0,1,'2024-09-22 05:16:28.545773'),(27,'pbkdf2_sha256$600000$ZPSUIUAZ63nL6qcjt2jlq0$yA0myPNEY6WGaKEWJAncIXt1DrvVFA27QQdntIff/V8=',NULL,0,'Kenny','','','kenny@gmail.com',0,1,'2024-09-22 05:19:12.722981'),(31,'pbkdf2_sha256$600000$7X7Pt3eov9GsCZZBBIdO4p$QScaYQj0nepETvPXozZNway9Y5pCKJ5cPBja12NnOdA=','2024-09-24 14:59:52.499251',0,'Araf','','','araf@gmail.com',0,1,'2024-09-24 14:59:34.532394'),(32,'pbkdf2_sha256$600000$qBe8zyUpkb4xK9zqBDzPP9$be9i2qsFixy6nec5geWd3C1+9WPnTDg1g7LjKLETeXI=',NULL,0,'Test','','','test@gmail.com',1,1,'2024-09-25 07:14:36.831494'),(33,'pbkdf2_sha256$600000$6cALYka99RCWl9hh6F7O7k$75VBxEwSmK6H7h7NALeeL7k2YEG6o68ukVkP4mjF56g=','2024-09-29 04:49:00.355059',0,'Tesst','','','tesst@gmail.com',0,1,'2024-09-25 07:16:02.275612'),(35,'pbkdf2_sha256$600000$SfZPZXfOil5Ze5YwwEalAv$0rrNyxEMXDDbbOLiX/kqncegziXMQJhZLHykDOynxHA=',NULL,0,'Newuser','','','newuser@gmail.com',0,1,'2024-09-29 04:44:52.715541');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2024-09-15 08:30:21.843641','3','Sakib112',1,'[{\"added\": {}}]',4,1),(2,'2024-09-15 08:31:14.810830','1','Sakib112',1,'[{\"added\": {}}]',10,1),(3,'2024-09-15 08:53:11.072652','4','Karim21',1,'[{\"added\": {}}]',4,1),(4,'2024-09-15 08:53:36.487265','2','Karim21',1,'[{\"added\": {}}]',10,1),(5,'2024-09-15 08:59:44.478039','5','Rahim',1,'[{\"added\": {}}]',4,1),(6,'2024-09-15 09:00:20.128364','3','Rahim',1,'[{\"added\": {}}]',10,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(14,'management','incident'),(15,'management','source'),(16,'management','supportcategory'),(6,'sessions','session'),(17,'tasks','attendance'),(11,'tasks','incident'),(12,'tasks','source'),(13,'tasks','supportcategory'),(7,'tasks','task'),(8,'tasks','taskattachment'),(9,'tasks','user'),(10,'tasks','userprofile');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2024-09-14 19:29:22.026243'),(2,'auth','0001_initial','2024-09-14 19:29:22.528955'),(3,'admin','0001_initial','2024-09-14 19:29:22.652512'),(4,'admin','0002_logentry_remove_auto_add','2024-09-14 19:29:22.658712'),(5,'admin','0003_logentry_add_action_flag_choices','2024-09-14 19:29:22.664685'),(6,'contenttypes','0002_remove_content_type_name','2024-09-14 19:29:22.740414'),(7,'auth','0002_alter_permission_name_max_length','2024-09-14 19:29:22.797159'),(8,'auth','0003_alter_user_email_max_length','2024-09-14 19:29:22.817533'),(9,'auth','0004_alter_user_username_opts','2024-09-14 19:29:22.824638'),(10,'auth','0005_alter_user_last_login_null','2024-09-14 19:29:22.880222'),(11,'auth','0006_require_contenttypes_0002','2024-09-14 19:29:22.884130'),(12,'auth','0007_alter_validators_add_error_messages','2024-09-14 19:29:22.904715'),(13,'auth','0008_alter_user_username_max_length','2024-09-14 19:29:22.969709'),(14,'auth','0009_alter_user_last_name_max_length','2024-09-14 19:29:23.029361'),(15,'auth','0010_alter_group_name_max_length','2024-09-14 19:29:23.048243'),(16,'auth','0011_update_proxy_permissions','2024-09-14 19:29:23.056264'),(17,'auth','0012_alter_user_first_name_max_length','2024-09-14 19:29:23.117202'),(18,'sessions','0001_initial','2024-09-14 19:29:23.147007'),(19,'tasks','0001_initial','2024-09-14 19:29:23.163226'),(20,'tasks','0002_task_attachment_task_incident_task_office_name_and_more','2024-09-14 21:26:26.144601'),(21,'tasks','0003_remove_task_attachment_alter_task_source_and_more','2024-09-14 22:33:36.176675'),(22,'tasks','0004_alter_taskattachment_task','2024-09-14 23:27:45.130739'),(23,'tasks','0005_alter_task_support_category','2024-09-15 00:01:35.863752'),(24,'tasks','0006_user','2024-09-15 01:20:44.368657'),(25,'tasks','0007_userprofile_delete_user','2024-09-15 03:48:43.789993'),(26,'tasks','0008_task_created_by','2024-09-16 23:51:18.909483'),(27,'tasks','0009_alter_userprofile_nid_alter_userprofile_phone_no','2024-09-17 08:49:16.968852'),(28,'tasks','0010_task_task_date_alter_userprofile_blood_group','2024-09-18 04:53:59.142286'),(29,'tasks','0011_alter_userprofile_blood_group','2024-09-18 04:53:59.147118'),(30,'tasks','0012_remove_task_title_alter_task_source','2024-09-21 19:43:58.309492'),(31,'tasks','0013_alter_task_task_date','2024-09-22 04:27:55.546787'),(33,'management','0001_initial','2024-09-23 20:01:16.985689'),(36,'tasks','0014_incident_source_supportcategory_and_more','2024-09-24 06:46:49.408681'),(38,'tasks','0015_delete_incident_delete_source_delete_supportcategory_and_more','2024-09-24 07:05:22.471260'),(39,'tasks','0016_delete_incident_delete_source_delete_supportcategory_and_more','2024-09-24 07:06:58.680620'),(40,'tasks','0017_alter_userprofile_user_type','2024-09-28 20:38:52.819164'),(41,'tasks','0018_attendance','2024-10-09 08:00:29.012572');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('b1edwymn82l65rlzizc08zetu0k72z8o','.eJxVjMsOwiAQRf-FtSHlLS7d-w1kGAapGkhKuzL-uzTpQrf3nHveLMC2lrB1WsKc2IUJdvrdIuCT6g7SA-q9cWx1XebId4UftPNbS_S6Hu5foEAv401KZtQ-RWs1Ch2NtmSymwi0GQQNOGFGLiurZETIXk3ghRFWOnv2mn2-8_Q30A:1syRXA:04P0q1PycM2e3XpZg1Yw3aZopZMSxNhnUYebPhbSVo0','2024-10-23 07:55:00.726551'),('dh5to496abj5sd35fsh905y5z918cgjy','e30:1sqe8M:FBiPIcHrNljdrXysmrcTIgLbQisrXyE1qiHea8BPdKE','2024-10-01 19:45:10.725759'),('q1o0rbt9b4nbg3hz1vcmudl5mnz40kw4','e30:1sqe8k:F4fMm4C5ZlI6EoedDoQ8qreQpr6bSrn-2AAVK34R3Tc','2024-10-01 19:45:34.246434'),('vpaa027or1in1hgivi4xer5grhbmki20','e30:1sqMAv:qzOIzMuLrTi003t-c5tA-9IrYtSdG_bi88nSQ5utVdk','2024-10-01 00:34:37.221338'),('zy4q5z0ligasaagv0fmdxoqvxh49ev0q','e30:1spfM2:CzgHeiM-2sc3bHUyIEEDylr9uHZMhcPTdHpKWKbhdUE','2024-09-29 02:51:14.302966');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tasks_attendance`
--

DROP TABLE IF EXISTS `tasks_attendance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tasks_attendance` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `time_in` time(6) DEFAULT NULL,
  `time_out` time(6) DEFAULT NULL,
  `is_present` tinyint(1) NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tasks_attendance_user_id_9a5df166_fk_auth_user_id` (`user_id`),
  CONSTRAINT `tasks_attendance_user_id_9a5df166_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tasks_attendance`
--

LOCK TABLES `tasks_attendance` WRITE;
/*!40000 ALTER TABLE `tasks_attendance` DISABLE KEYS */;
INSERT INTO `tasks_attendance` VALUES (1,'2024-10-09','14:03:13.628567',NULL,1,1);
/*!40000 ALTER TABLE `tasks_attendance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tasks_task`
--

DROP TABLE IF EXISTS `tasks_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tasks_task` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `description` longtext NOT NULL,
  `status` varchar(50) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `office_name` varchar(255) NOT NULL,
  `created_by_id` int NOT NULL,
  `task_date` date DEFAULT NULL,
  `source_id` bigint DEFAULT NULL,
  `incident_id` bigint DEFAULT NULL,
  `support_category_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tasks_task_created_by_id_1345568a_fk_auth_user_id` (`created_by_id`),
  KEY `fk_task_source` (`source_id`),
  KEY `fk_task_incident` (`incident_id`),
  KEY `fk_task_support_category` (`support_category_id`),
  CONSTRAINT `fk_task_incident` FOREIGN KEY (`incident_id`) REFERENCES `management_db`.`management_incident` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_task_source` FOREIGN KEY (`source_id`) REFERENCES `management_db`.`management_source` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_task_support_category` FOREIGN KEY (`support_category_id`) REFERENCES `management_db`.`management_supportcategory` (`id`) ON DELETE SET NULL,
  CONSTRAINT `tasks_task_created_by_id_1345568a_fk_auth_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tasks_task`
--

LOCK TABLES `tasks_task` WRITE;
/*!40000 ALTER TABLE `tasks_task` DISABLE KEYS */;
INSERT INTO `tasks_task` VALUES (35,'new task checker','Done','2024-09-24 10:20:15.805114','cs office',1,'2024-09-05',46,44,58),(36,'new task 2','Done','2024-09-24 10:21:17.692502','Noneofffice',1,'2024-09-02',45,40,54),(37,'New task for me','Done','2024-09-24 22:19:16.194438','new office',16,'2024-09-12',37,50,44),(38,'coordinator','Dependency','2024-09-28 09:57:38.767608','cs office 2',33,'2024-09-04',45,48,54),(39,'New task test','Pending','2024-09-28 12:16:46.223813','None office',1,'2024-09-04',44,51,54),(40,'test for karm','Done','2024-09-28 21:07:55.675163','Noneofffice2',16,'2024-09-26',46,48,53);
/*!40000 ALTER TABLE `tasks_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tasks_taskattachment`
--

DROP TABLE IF EXISTS `tasks_taskattachment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tasks_taskattachment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `attachment` varchar(100) NOT NULL,
  `task_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tasks_taskattachment_task_id_6d63b288_uniq` (`task_id`),
  CONSTRAINT `tasks_taskattachment_task_id_6d63b288_fk_tasks_task_id` FOREIGN KEY (`task_id`) REFERENCES `tasks_task` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tasks_taskattachment`
--

LOCK TABLES `tasks_taskattachment` WRITE;
/*!40000 ALTER TABLE `tasks_taskattachment` DISABLE KEYS */;
/*!40000 ALTER TABLE `tasks_taskattachment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tasks_userprofile`
--

DROP TABLE IF EXISTS `tasks_userprofile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tasks_userprofile` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `full_name` varchar(255) NOT NULL,
  `nid` varchar(50) DEFAULT NULL,
  `phone_no` varchar(20) DEFAULT NULL,
  `blood_group` varchar(10) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `user_type` varchar(20) NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  UNIQUE KEY `nid` (`nid`),
  CONSTRAINT `tasks_userprofile_user_id_8154a798_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tasks_userprofile`
--

LOCK TABLES `tasks_userprofile` WRITE;
/*!40000 ALTER TABLE `tasks_userprofile` DISABLE KEYS */;
INSERT INTO `tasks_userprofile` VALUES (6,'Rashik Ahsan','5555555','01832896692','O+',NULL,'admin',1),(14,'Rahim Seikh',NULL,'21213141','o+ve','1999-05-11','general',15),(15,'karm Dave','222333333','444444444','A-',NULL,'general',16),(21,'Siam Islam','1234445333','0222222323232','B+','1995-06-06','general',22),(24,'Araf Rahman','141212121','212121414','A-','2024-09-03','team_coordinator',31),(25,'Test Nam','414141','2141414','A+','2024-09-06','admin',32),(26,'Tesst Naam','1414141','143131313','A-','2024-09-05','team_coordinator',33),(28,'New User','41415151','1214141','B+','2024-07-29','general',35);
/*!40000 ALTER TABLE `tasks_userprofile` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-09 14:25:59
