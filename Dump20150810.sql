CREATE DATABASE  IF NOT EXISTS `resume_pro` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `resume_pro`;
-- MySQL dump 10.13  Distrib 5.6.17, for Win32 (x86)
--
-- Host: localhost    Database: resume_pro
-- ------------------------------------------------------
-- Server version	5.6.19

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `banned_user`
--

DROP TABLE IF EXISTS `banned_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `banned_user` (
  `company_id` int(11) DEFAULT NULL,
  `jobseeker_id` int(11) DEFAULT NULL,
  KEY `fk_banned_user_1_idx` (`jobseeker_id`),
  CONSTRAINT `fk_banned_user_1` FOREIGN KEY (`jobseeker_id`) REFERENCES `jobseeker` (`jobseeker_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `banned_user`
--

LOCK TABLES `banned_user` WRITE;
/*!40000 ALTER TABLE `banned_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `banned_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `campaigns`
--

DROP TABLE IF EXISTS `campaigns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `campaigns` (
  `auto_campaign_id` int(11) NOT NULL AUTO_INCREMENT,
  `campaign_id` varchar(11) NOT NULL,
  `campaign_name` varchar(200) NOT NULL,
  `date_of_register` datetime NOT NULL,
  `company_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`campaign_id`),
  UNIQUE KEY `campaign_name` (`campaign_name`,`company_id`),
  KEY `auto_campaign_id` (`auto_campaign_id`),
  KEY `company_id` (`company_id`),
  CONSTRAINT `campaigns_ibfk_1` FOREIGN KEY (`company_id`) REFERENCES `company` (`company_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campaigns`
--

LOCK TABLES `campaigns` WRITE;
/*!40000 ALTER TABLE `campaigns` DISABLE KEYS */;
/*!40000 ALTER TABLE `campaigns` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `company`
--

DROP TABLE IF EXISTS `company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `company` (
  `company_id` int(11) NOT NULL AUTO_INCREMENT,
  `company_name` varchar(200) NOT NULL,
  `date_of_register` datetime DEFAULT NULL,
  `user_name` varchar(200) DEFAULT NULL,
  `dob` datetime DEFAULT NULL,
  `email_id` varbinary(255) DEFAULT NULL,
  `lat` double DEFAULT NULL,
  `lng` double DEFAULT NULL,
  `pin` varchar(11) DEFAULT NULL,
  `post_code` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`company_id`),
  UNIQUE KEY `company_name` (`company_name`),
  UNIQUE KEY `pin` (`pin`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company`
--

LOCK TABLES `company` WRITE;
/*!40000 ALTER TABLE `company` DISABLE KEYS */;
/*!40000 ALTER TABLE `company` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `company_order`
--

DROP TABLE IF EXISTS `company_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `company_order` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) DEFAULT NULL,
  `order_date` bigint(20) DEFAULT NULL,
  `order_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` enum('1','2','3') NOT NULL DEFAULT '1',
  PRIMARY KEY (`order_id`),
  KEY `fk_client_order_1` (`company_id`),
  CONSTRAINT `fk_client_order_1` FOREIGN KEY (`company_id`) REFERENCES `company` (`company_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company_order`
--

LOCK TABLES `company_order` WRITE;
/*!40000 ALTER TABLE `company_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `company_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_status`
--

DROP TABLE IF EXISTS `job_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `job_status` (
  `jobseeker_id` int(11) NOT NULL,
  `company_id` int(11) NOT NULL,
  `date_of_joining` datetime NOT NULL,
  `type` enum('temporary','permanent') NOT NULL DEFAULT 'permanent',
  `campaign_id` varchar(11) DEFAULT NULL,
  UNIQUE KEY `jobseeker_id` (`jobseeker_id`),
  KEY `company_id` (`company_id`),
  KEY `campaign_id` (`campaign_id`),
  CONSTRAINT `job_status_ibfk_1` FOREIGN KEY (`jobseeker_id`) REFERENCES `jobseeker` (`jobseeker_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `job_status_ibfk_2` FOREIGN KEY (`company_id`) REFERENCES `company` (`company_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `job_status_ibfk_3` FOREIGN KEY (`campaign_id`) REFERENCES `campaigns` (`campaign_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_status`
--

LOCK TABLES `job_status` WRITE;
/*!40000 ALTER TABLE `job_status` DISABLE KEYS */;
/*!40000 ALTER TABLE `job_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobseeker`
--

DROP TABLE IF EXISTS `jobseeker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jobseeker` (
  `jobseeker_id` int(10) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(200) DEFAULT NULL,
  `last_name` varchar(200) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `email_id` varchar(255) DEFAULT NULL,
  `nationality` varchar(60) DEFAULT NULL,
  `password` varchar(60) DEFAULT NULL,
  `contact_no` varchar(30) DEFAULT NULL,
  `postal_code` varchar(9) DEFAULT NULL,
  `resume_url` varchar(2083) DEFAULT NULL,
  `employement_status` tinyint(1) DEFAULT NULL,
  `when_to_start_work` tinyint(1) DEFAULT NULL,
  `worked_before` tinyint(1) DEFAULT '1',
  `english_level` tinyint(1) NOT NULL DEFAULT '1',
  `lat` double DEFAULT '0',
  `lng` double DEFAULT '0',
  `pic_url` varchar(2083) DEFAULT NULL,
  `total_score` int(11) DEFAULT NULL,
  `date_of_register` datetime NOT NULL,
  PRIMARY KEY (`jobseeker_id`),
  UNIQUE KEY `contact_no` (`contact_no`),
  UNIQUE KEY `email_id` (`email_id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobseeker`
--

LOCK TABLES `jobseeker` WRITE;
/*!40000 ALTER TABLE `jobseeker` DISABLE KEYS */;
INSERT INTO `jobseeker` VALUES (1,'patryk','ties',32,'patrykties@gmail.com',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1,0,0,NULL,NULL,'2020-07-20 15:00:00'),(2,'sfsdf','sfsf',44,'asffsd@ffsd.com',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1,0,0,NULL,NULL,'2021-07-20 15:00:00'),(3,NULL,NULL,19,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1,0,0,NULL,NULL,'2021-07-20 15:00:00'),(4,'rwrwer','rwrwr',NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,1,2,2,0,0,NULL,NULL,'2021-07-20 15:00:00'),(5,'fsfs','fsfsf',21,NULL,NULL,NULL,NULL,NULL,NULL,1,1,2,1,0,0,NULL,NULL,'2021-07-20 15:00:00'),(7,'tomasz','gruza',35,'tomaszgruza@gmail.com',NULL,NULL,'0893635533','sl21tp',NULL,1,1,2,1,0,0,NULL,NULL,'2021-07-20 15:00:00'),(8,'tadeusz','ties',54,'tadek67@gmail.com','polish',NULL,'7363636363','sl2 1tp',NULL,1,1,2,2,0,0,NULL,NULL,'2021-07-20 15:00:00'),(9,'asddad',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,1,1,2,0,0,NULL,NULL,'2015-07-24 11:51:14'),(10,'[object Object]',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1,0,0,NULL,NULL,'2015-07-24 17:40:43'),(11,'asdasd','',20,'','',NULL,'','','',4,1,1,1,0,0,NULL,NULL,'2015-07-24 18:13:52'),(12,'sdfsfs','dsfsfsdf',22,'fsfdf@sdfsfs.com','polish',NULL,'5235345345','ub5ty6',NULL,3,1,1,1,0,0,NULL,NULL,'2015-07-24 19:12:33'),(13,'fsfsd','fsdfsd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1,0,0,NULL,NULL,'2015-07-26 00:16:20'),(14,'adam','zareba',26,'adamz@gmail.com','polish',NULL,'4234235345646','ub68uh',NULL,1,1,2,2,0,0,NULL,NULL,'2015-07-26 00:21:49'),(15,'sdfd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL,NULL,'2015-07-26 01:29:11'),(16,'sfdfdsf',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL,NULL,'2015-07-26 01:38:33'),(17,'sdffs',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL,NULL,'2015-07-26 01:44:31'),(18,'df',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL,NULL,'2015-07-26 01:48:53'),(19,'sdad',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,3,0,0,NULL,NULL,'2015-07-26 02:07:36'),(20,'asdd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,0,0,NULL,NULL,'2015-07-26 11:49:27'),(21,'asdad',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,3,0,0,NULL,NULL,'2015-07-26 12:02:31'),(22,'dasd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,0,0,NULL,NULL,'2015-07-26 12:04:26'),(23,'asdada',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,0,0,NULL,NULL,'2015-07-26 12:06:33'),(24,'asdsd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL,NULL,'2015-07-26 14:11:08'),(25,'asdsd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,0,0,NULL,NULL,'2015-07-26 14:12:35'),(26,'adsd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,0,0,NULL,NULL,'2015-07-26 18:05:03'),(27,'gdgdgd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'[object Object]',3,1,1,2,0,0,NULL,NULL,'2015-07-27 20:58:45'),(28,'fsfsfsfsfsfsfsf',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'[object Object]',1,1,1,1,0,0,NULL,NULL,'2015-07-27 20:59:26'),(29,'filepath',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'./uploads/Mr wayne rodney CV - Copy.doc',NULL,NULL,NULL,1,0,0,NULL,NULL,'2015-07-27 21:01:38'),(30,'asdad',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL,NULL,'2015-07-30 21:16:57'),(31,'asdda',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,0,0,NULL,NULL,'2015-07-30 21:18:29'),(32,'asdasd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL,NULL,'2015-07-30 21:20:16'),(33,'asdad',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,0,0,NULL,NULL,'2015-07-30 21:20:46'),(34,'asdfsf',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'uploads\\CV.Przzemo.doc',NULL,NULL,NULL,2,0,0,NULL,NULL,'2015-07-30 21:24:16'),(35,'sffdf',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'uploads\\Mr Nick Apostolou CV.rtf',2,1,1,2,0,0,NULL,NULL,'2015-07-31 14:14:45'),(36,'fsf',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,NULL,2,0,0,NULL,NULL,'2015-07-31 16:11:16'),(37,'fsf',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,NULL,2,0,0,NULL,NULL,'2015-07-31 16:13:31'),(38,'dasd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,NULL,1,0,0,NULL,NULL,'2015-07-31 16:18:47'),(39,'TTTTTTT',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,NULL,2,0,0,NULL,NULL,'2015-07-31 16:21:05'),(40,'TTTTTTT',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,NULL,2,0,0,NULL,NULL,'2015-07-31 16:22:58'),(41,'dad',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,NULL,1,0,0,NULL,30,'2015-07-31 16:58:00'),(42,'patryk','ties',33,'johny@gmail.com','polish',NULL,'07689148363','UB68UH','uploads\\Junior Boakye CV.docx',1,1,2,1,0,0,NULL,100,'2015-07-31 17:06:42');
/*!40000 ALTER TABLE `jobseeker` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobseeker_status`
--

DROP TABLE IF EXISTS `jobseeker_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jobseeker_status` (
  `jobseeker_id` int(11) NOT NULL,
  `company_id` int(11) NOT NULL,
  `campaign_id` varchar(7) DEFAULT NULL,
  `job_status` enum('selected','ex_employee','applied','shortlisted','banned') DEFAULT NULL,
  `active_status` tinyint(1) DEFAULT '1',
  `position_id` int(11) DEFAULT NULL,
  KEY `jobseeker_id` (`jobseeker_id`),
  KEY `company_id` (`company_id`),
  KEY `campaign_id` (`campaign_id`),
  CONSTRAINT `jobseeker_status_ibfk_1` FOREIGN KEY (`jobseeker_id`) REFERENCES `jobseeker` (`jobseeker_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `jobseeker_status_ibfk_2` FOREIGN KEY (`company_id`) REFERENCES `company` (`company_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `jobseeker_status_ibfk_3` FOREIGN KEY (`campaign_id`) REFERENCES `campaigns` (`campaign_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobseeker_status`
--

LOCK TABLES `jobseeker_status` WRITE;
/*!40000 ALTER TABLE `jobseeker_status` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobseeker_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobseeker_work_session`
--

DROP TABLE IF EXISTS `jobseeker_work_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jobseeker_work_session` (
  `session_id` int(11) NOT NULL AUTO_INCREMENT,
  `jobseeker_id` int(11) DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  `order_id` int(11) DEFAULT NULL,
  `start_time` bigint(20) DEFAULT NULL,
  `end_time` bigint(20) DEFAULT NULL,
  `status` tinyint(4) DEFAULT '0',
  `breaks` int(11) DEFAULT '360000',
  `rates_per_hour` float(4,2) DEFAULT '5.50',
  `created_on` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`session_id`),
  KEY `fk_jobseeker_work_session_1` (`jobseeker_id`),
  KEY `fk_jobseeker_work_session_2` (`company_id`),
  KEY `fk_jobseeker_work_session_3` (`order_id`),
  CONSTRAINT `fk_jobseeker_work_session_1` FOREIGN KEY (`jobseeker_id`) REFERENCES `jobseeker` (`jobseeker_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_jobseeker_work_session_2` FOREIGN KEY (`company_id`) REFERENCES `company` (`company_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_jobseeker_work_session_3` FOREIGN KEY (`order_id`) REFERENCES `company_order` (`order_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobseeker_work_session`
--

LOCK TABLES `jobseeker_work_session` WRITE;
/*!40000 ALTER TABLE `jobseeker_work_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobseeker_work_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_mapping_jobseeker`
--

DROP TABLE IF EXISTS `order_mapping_jobseeker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_mapping_jobseeker` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `jobseeker_id` int(11) DEFAULT NULL,
  `order_no` bigint(20) DEFAULT NULL,
  `order_id` int(11) DEFAULT NULL,
  `added_by` tinyint(4) DEFAULT '1',
  `jobseeker_status` tinyint(4) NOT NULL DEFAULT '0',
  `breaks` int(11) NOT NULL DEFAULT '360000',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fk_order_mapping_jobseeker_3` (`jobseeker_id`,`order_no`),
  KEY `fk_order_mapping_jobseeker_1` (`order_no`),
  KEY `fk_order_mapping_jobseeker_2` (`order_id`),
  CONSTRAINT `fk_order_mapping_jobseeker_1` FOREIGN KEY (`order_no`) REFERENCES `order_template` (`order_no`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_mapping_jobseeker_2` FOREIGN KEY (`order_id`) REFERENCES `company_order` (`order_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_mapping_jobseeker`
--

LOCK TABLES `order_mapping_jobseeker` WRITE;
/*!40000 ALTER TABLE `order_mapping_jobseeker` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_mapping_jobseeker` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_template`
--

DROP TABLE IF EXISTS `order_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_template` (
  `order_no` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `position_type` int(11) DEFAULT NULL,
  `status` enum('NOT_CONFIRMED','CONFIRMED') COLLATE utf8_bin DEFAULT 'NOT_CONFIRMED',
  `hiring_time` varchar(45) COLLATE utf8_bin DEFAULT '"00:00"',
  PRIMARY KEY (`order_no`),
  KEY `fk_order_template_1` (`order_id`),
  CONSTRAINT `fk_order_template_1` FOREIGN KEY (`order_id`) REFERENCES `company_order` (`order_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_template`
--

LOCK TABLES `order_template` WRITE;
/*!40000 ALTER TABLE `order_template` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `positions`
--

DROP TABLE IF EXISTS `positions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `positions` (
  `position_id` int(11) NOT NULL AUTO_INCREMENT,
  `position_name` varchar(105) DEFAULT NULL,
  `rate_per_hour` float(4,2) DEFAULT NULL,
  PRIMARY KEY (`position_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `positions`
--

LOCK TABLES `positions` WRITE;
/*!40000 ALTER TABLE `positions` DISABLE KEYS */;
/*!40000 ALTER TABLE `positions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `skills`
--

DROP TABLE IF EXISTS `skills`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `skills` (
  `skills_id` int(11) NOT NULL AUTO_INCREMENT,
  `jobseeker_id` int(11) NOT NULL,
  PRIMARY KEY (`skills_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `skills`
--

LOCK TABLES `skills` WRITE;
/*!40000 ALTER TABLE `skills` DISABLE KEYS */;
/*!40000 ALTER TABLE `skills` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `user_id` int(10) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(200) DEFAULT NULL,
  `last_name` varchar(200) DEFAULT NULL,
  `email_id` varchar(255) DEFAULT NULL,
  `nationality` varchar(60) DEFAULT NULL,
  `password` varchar(60) DEFAULT NULL,
  `contact_no` varchar(30) DEFAULT NULL,
  `postal_code` varchar(9) DEFAULT NULL,
  `resume_url` varchar(2083) DEFAULT NULL,
  `employement_status` varchar(500) DEFAULT NULL,
  `when_to_start_work` varchar(500) DEFAULT NULL,
  `worked_before` tinyint(1) DEFAULT '1',
  `english_level` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `contact_no` (`contact_no`),
  UNIQUE KEY `email_id` (`email_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-08-10 20:42:21
