-- MySQL dump 10.13  Distrib 8.0.39, for Win64 (x86_64)
--
-- Host: localhost    Database: management_db
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
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2024-09-23 21:11:35.496371'),(2,'auth','0001_initial','2024-09-23 21:11:35.508633'),(3,'admin','0001_initial','2024-09-23 21:11:35.518498'),(4,'admin','0002_logentry_remove_auto_add','2024-09-23 21:11:35.526812'),(5,'admin','0003_logentry_add_action_flag_choices','2024-09-23 21:11:35.533792'),(6,'contenttypes','0002_remove_content_type_name','2024-09-23 21:11:35.543318'),(7,'auth','0002_alter_permission_name_max_length','2024-09-23 21:11:35.550317'),(8,'auth','0003_alter_user_email_max_length','2024-09-23 21:11:35.558316'),(9,'auth','0004_alter_user_username_opts','2024-09-23 21:11:35.577459'),(10,'auth','0005_alter_user_last_login_null','2024-09-23 21:11:35.585569'),(11,'auth','0006_require_contenttypes_0002','2024-09-23 21:11:35.589448'),(12,'auth','0007_alter_validators_add_error_messages','2024-09-23 21:11:35.597449'),(13,'auth','0008_alter_user_username_max_length','2024-09-23 21:11:35.604455'),(14,'auth','0009_alter_user_last_name_max_length','2024-09-23 21:11:35.610448'),(15,'auth','0010_alter_group_name_max_length','2024-09-23 21:11:35.617062'),(16,'auth','0011_update_proxy_permissions','2024-09-23 21:11:35.621987'),(17,'auth','0012_alter_user_first_name_max_length','2024-09-23 21:11:35.630288'),(18,'management','0001_initial','2024-09-23 21:11:35.681851'),(19,'sessions','0001_initial','2024-09-23 21:11:35.686338'),(20,'tasks','0001_initial','2024-09-23 21:11:35.690338'),(21,'tasks','0002_task_attachment_task_incident_task_office_name_and_more','2024-09-23 21:11:35.699553'),(22,'tasks','0003_remove_task_attachment_alter_task_source_and_more','2024-09-23 21:11:35.710533'),(23,'tasks','0004_alter_taskattachment_task','2024-09-23 21:11:35.714550'),(24,'tasks','0005_alter_task_support_category','2024-09-23 21:11:35.720127'),(25,'tasks','0006_user','2024-09-23 21:11:35.725132'),(26,'tasks','0007_userprofile_delete_user','2024-09-23 21:11:35.734139'),(27,'tasks','0008_task_created_by','2024-09-23 21:11:35.743132'),(28,'tasks','0009_alter_userprofile_nid_alter_userprofile_phone_no','2024-09-23 21:11:35.754153'),(29,'tasks','0010_task_task_date_alter_userprofile_blood_group','2024-09-23 21:11:35.768134'),(30,'tasks','0011_alter_userprofile_blood_group','2024-09-23 21:11:35.778134'),(31,'tasks','0012_remove_task_title_alter_task_source','2024-09-23 21:11:35.791132'),(32,'tasks','0013_alter_task_task_date','2024-09-23 21:11:35.801159'),(33,'tasks','0014_incident_source_supportcategory_and_more','2024-09-23 21:11:35.809141'),(34,'tasks','0015_delete_incident_delete_source_delete_supportcategory_and_more','2024-09-23 22:37:53.134364');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `management_incident`
--

DROP TABLE IF EXISTS `management_incident`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `management_incident` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `management_incident`
--

LOCK TABLES `management_incident` WRITE;
/*!40000 ALTER TABLE `management_incident` DISABLE KEYS */;
INSERT INTO `management_incident` VALUES (37,'Potrojari'),(38,'Slowness'),(39,'Note Pending'),(40,'Synchronize'),(41,'Template'),(42,'Password'),(43,'User Information'),(44,'OTP'),(45,'PDF Generation Error'),(46,'Dak Upload'),(47,'Office/Branch Information Correction'),(48,'Dak Forward'),(49,'Nothi Permission'),(50,'Nothi Information Correction'),(51,'Archive'),(52,'Nothi Forward'),(53,'Dashboard'),(54,'Heading Correction'),(55,'Substitute'),(56,'Signature'),(57,'Doptor'),(58,'Designation Align'),(59,'User Assign'),(60,'User Release'),(61,'Dak Not Found'),(62,'Nothi Not Found'),(63,'PDF Blank'),(64,'Others');
/*!40000 ALTER TABLE `management_incident` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `management_source`
--

DROP TABLE IF EXISTS `management_source`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `management_source` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `management_source`
--

LOCK TABLES `management_source` WRITE;
/*!40000 ALTER TABLE `management_source` DISABLE KEYS */;
INSERT INTO `management_source` VALUES (34,'Phone Call'),(35,'Personal Email'),(36,'OTRS'),(37,'SMS'),(38,'One 2 One'),(39,'Training'),(40,'i-Top'),(41,'AnyDesk'),(42,'WhatsApp'),(43,'Social Platforms'),(44,'Productivity / Creativity'),(45,'Team Work'),(46,'Personal'),(47,'Meeting'),(48,'Nothi System'),(49,'Self Initiative'),(50,'Super Admin'),(51,'Others'),(65,'New Source');
/*!40000 ALTER TABLE `management_source` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `management_supportcategory`
--

DROP TABLE IF EXISTS `management_supportcategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `management_supportcategory` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `management_supportcategory`
--

LOCK TABLES `management_supportcategory` WRITE;
/*!40000 ALTER TABLE `management_supportcategory` DISABLE KEYS */;
INSERT INTO `management_supportcategory` VALUES (41,'User Management'),(42,'Organogram Management'),(43,'Training Management'),(44,'Incident Management'),(45,'Knowledge Sharing'),(46,'System Management'),(47,'Doc/Exl/Sheet Management'),(48,'Productivity / Creativity'),(49,'Nothi / Note / File Management'),(50,'Team Management'),(51,'Tech / Vendor Management'),(52,'Migration Management'),(53,'myGov Management'),(54,'Mobile Application'),(55,'Implementation'),(56,'Query Management'),(57,'Reporting'),(58,'System Testing'),(59,'Capacity Development'),(60,'Tutorial Management'),(61,'Others');
/*!40000 ALTER TABLE `management_supportcategory` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-06 13:00:39
