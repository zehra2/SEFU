-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: sfu
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `ambulance_call`
--

DROP TABLE IF EXISTS `ambulance_call`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ambulance_call` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) NOT NULL,
  `case_reference_id` int(11) DEFAULT NULL,
  `vehicle_id` int(11) DEFAULT NULL,
  `contact_no` varchar(20) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `vehicle_model` varchar(20) DEFAULT NULL,
  `driver` varchar(100) NOT NULL,
  `date` datetime DEFAULT NULL,
  `call_from` varchar(200) NOT NULL,
  `call_to` varchar(200) NOT NULL,
  `charge_category_id` int(11) DEFAULT NULL,
  `charge_id` int(11) DEFAULT NULL,
  `standard_charge` int(11) DEFAULT NULL,
  `discount_percentage` float(10,2) DEFAULT 0.00,
  `discount` float(10,2) DEFAULT 0.00,
  `tax_percentage` float(10,2) DEFAULT NULL,
  `amount` float(10,2) DEFAULT 0.00,
  `net_amount` float(10,2) DEFAULT NULL,
  `transaction_id` int(11) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `generated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `patient_id` (`patient_id`),
  KEY `vehicle_id` (`vehicle_id`),
  KEY `generated_by` (`generated_by`),
  KEY `case_reference_id` (`case_reference_id`),
  KEY `transaction_id` (`transaction_id`),
  KEY `charge_id` (`charge_id`),
  KEY `idx_contact_no` (`contact_no`),
  KEY `idx_vehicle_model` (`vehicle_model`),
  KEY `idx_driver` (`driver`),
  KEY `index_date` (`date`),
  KEY `index_call_from` (`call_from`),
  KEY `index_call_to` (`call_to`),
  KEY `index_charge_category_id` (`charge_category_id`),
  KEY `index_standard_charge` (`standard_charge`),
  KEY `index_discount_percentage` (`discount_percentage`),
  KEY `index_discount` (`discount`),
  KEY `index_tax_percentage` (`tax_percentage`),
  KEY `index_amount` (`amount`),
  KEY `index_net_amount` (`net_amount`),
  CONSTRAINT `ambulance_call_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ambulance_call_ibfk_2` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ambulance_call_ibfk_3` FOREIGN KEY (`generated_by`) REFERENCES `staff` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ambulance_call_ibfk_4` FOREIGN KEY (`case_reference_id`) REFERENCES `case_references` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ambulance_call_ibfk_5` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`) ON DELETE SET NULL,
  CONSTRAINT `ambulance_call_ibfk_6` FOREIGN KEY (`charge_id`) REFERENCES `charges` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ambulance_call`
--

LOCK TABLES `ambulance_call` WRITE;
/*!40000 ALTER TABLE `ambulance_call` DISABLE KEYS */;
/*!40000 ALTER TABLE `ambulance_call` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `annual_calendar`
--

DROP TABLE IF EXISTS `annual_calendar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `annual_calendar` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `holiday_type` int(11) NOT NULL COMMENT '1 for holiday , 2 for activity , 3 for vacation',
  `from_date` datetime DEFAULT NULL,
  `to_date` datetime DEFAULT NULL,
  `description` text NOT NULL COMMENT 'Holiday Description',
  `is_active` int(11) NOT NULL DEFAULT 1 COMMENT '1 for active 0 for inactive',
  `holiday_color` varchar(200) NOT NULL,
  `front_site` int(11) NOT NULL DEFAULT 0,
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_at` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_holiday_type` (`holiday_type`),
  KEY `idx_created_by` (`created_by`),
  KEY `index_from_date` (`from_date`) USING BTREE,
  KEY `index_to_date` (`to_date`) USING BTREE,
  CONSTRAINT `annual_calendar_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `staff` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `annual_calendar`
--

LOCK TABLES `annual_calendar` WRITE;
/*!40000 ALTER TABLE `annual_calendar` DISABLE KEYS */;
/*!40000 ALTER TABLE `annual_calendar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `antenatal_examine`
--

DROP TABLE IF EXISTS `antenatal_examine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `antenatal_examine` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `primary_examine_id` int(11) NOT NULL,
  `visit_details_id` int(11) DEFAULT NULL,
  `ipdid` int(11) DEFAULT NULL,
  `uter_size` varchar(250) DEFAULT NULL,
  `uterus_size` varchar(250) DEFAULT NULL,
  `presentation_position` varchar(250) DEFAULT NULL,
  `brim_presentation` varchar(250) DEFAULT NULL,
  `foeta_heart` varchar(250) DEFAULT NULL,
  `blood_pressure` varchar(250) DEFAULT NULL,
  `antenatal_oedema` varchar(250) DEFAULT NULL,
  `antenatal_weight` varchar(250) DEFAULT NULL,
  `urine_sugar` varchar(250) DEFAULT NULL,
  `urine` varchar(250) DEFAULT NULL,
  `remark` text DEFAULT NULL,
  `next_visit` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `visit_details_id` (`visit_details_id`),
  KEY `ipdid` (`ipdid`),
  KEY `index_uter_size` (`uter_size`),
  KEY `index_uterus_size` (`uterus_size`),
  KEY `index_presentation_position` (`presentation_position`),
  KEY `index_brim_presentation` (`brim_presentation`),
  KEY `index_foeta_heart` (`foeta_heart`),
  KEY `index_blood_pressure` (`blood_pressure`),
  KEY `index_antenatal_oedema` (`antenatal_oedema`),
  KEY `index_antenatal_weight` (`antenatal_weight`),
  KEY `index_urine_sugar` (`urine_sugar`),
  KEY `index_urine` (`urine`),
  KEY `primary_examine_id` (`primary_examine_id`),
  CONSTRAINT `antenatal_examine_ibfk_1` FOREIGN KEY (`visit_details_id`) REFERENCES `visit_details` (`id`) ON DELETE CASCADE,
  CONSTRAINT `antenatal_examine_ibfk_2` FOREIGN KEY (`ipdid`) REFERENCES `ipd_details` (`id`) ON DELETE CASCADE,
  CONSTRAINT `antenatal_examine_ibfk_3` FOREIGN KEY (`primary_examine_id`) REFERENCES `primary_examine` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `antenatal_examine`
--

LOCK TABLES `antenatal_examine` WRITE;
/*!40000 ALTER TABLE `antenatal_examine` DISABLE KEYS */;
/*!40000 ALTER TABLE `antenatal_examine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `appoint_priority`
--

DROP TABLE IF EXISTS `appoint_priority`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `appoint_priority` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `appoint_priority` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `index_appoint_priority` (`appoint_priority`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appoint_priority`
--

LOCK TABLES `appoint_priority` WRITE;
/*!40000 ALTER TABLE `appoint_priority` DISABLE KEYS */;
INSERT INTO `appoint_priority` VALUES (1,'Normal','0000-00-00 00:00:00'),(2,'Urgent','0000-00-00 00:00:00'),(3,'Very Urgent','0000-00-00 00:00:00'),(5,'Low','2021-09-24 13:28:40');
/*!40000 ALTER TABLE `appoint_priority` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `appointment`
--

DROP TABLE IF EXISTS `appointment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `appointment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) DEFAULT NULL,
  `case_reference_id` int(11) DEFAULT NULL,
  `visit_details_id` int(11) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `priority` varchar(100) NOT NULL,
  `specialist` varchar(100) NOT NULL,
  `doctor` int(11) DEFAULT NULL,
  `amount` varchar(200) NOT NULL,
  `message` text DEFAULT NULL,
  `appointment_status` varchar(11) DEFAULT NULL,
  `source` varchar(100) NOT NULL,
  `is_opd` varchar(10) NOT NULL,
  `is_ipd` varchar(10) NOT NULL,
  `doctor_shift_time_id` int(11) DEFAULT NULL,
  `doctor_global_shift_id` int(11) DEFAULT NULL,
  `is_queue` int(11) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `rejected_time` datetime DEFAULT NULL,
  `live_consult` varchar(50) DEFAULT NULL,
  `live_consult_link` int(11) NOT NULL DEFAULT 1 COMMENT '1 (link created) 0 (not created)',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `patient_id` (`patient_id`),
  KEY `doctor` (`doctor`),
  KEY `case_reference_id` (`case_reference_id`),
  KEY `visit_details_id` (`visit_details_id`),
  KEY `doctor_shift_time_id` (`doctor_shift_time_id`),
  CONSTRAINT `appointment_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE,
  CONSTRAINT `appointment_ibfk_2` FOREIGN KEY (`doctor`) REFERENCES `staff` (`id`) ON DELETE CASCADE,
  CONSTRAINT `appointment_ibfk_3` FOREIGN KEY (`case_reference_id`) REFERENCES `case_references` (`id`) ON DELETE CASCADE,
  CONSTRAINT `appointment_ibfk_4` FOREIGN KEY (`visit_details_id`) REFERENCES `visit_details` (`id`) ON DELETE CASCADE,
  CONSTRAINT `appointment_ibfk_5` FOREIGN KEY (`doctor_shift_time_id`) REFERENCES `doctor_shift_time` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointment`
--

LOCK TABLES `appointment` WRITE;
/*!40000 ALTER TABLE `appointment` DISABLE KEYS */;
/*!40000 ALTER TABLE `appointment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `appointment_payment`
--

DROP TABLE IF EXISTS `appointment_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `appointment_payment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `appointment_id` int(11) DEFAULT NULL,
  `charge_id` int(11) DEFAULT NULL,
  `standard_amount` float(10,2) NOT NULL DEFAULT 0.00,
  `tax` float(10,2) NOT NULL DEFAULT 0.00,
  `discount_percentage` float(10,2) NOT NULL DEFAULT 0.00,
  `paid_amount` float(10,2) NOT NULL,
  `payment_mode` varchar(50) DEFAULT NULL,
  `payment_type` varchar(100) NOT NULL,
  `transaction_id` varchar(255) DEFAULT NULL,
  `note` varchar(100) DEFAULT NULL,
  `date` datetime NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `charge_id` (`charge_id`),
  KEY `appointment_id` (`appointment_id`),
  KEY `index_standard_amount` (`standard_amount`),
  KEY `index_tax` (`tax`),
  KEY `index_discount_percentage` (`discount_percentage`),
  KEY `index_paid_amount` (`paid_amount`),
  KEY `index_payment_mode` (`payment_mode`),
  KEY `index_payment_type` (`payment_type`),
  CONSTRAINT `appointment_payment_ibfk_2` FOREIGN KEY (`charge_id`) REFERENCES `charges` (`id`) ON DELETE CASCADE,
  CONSTRAINT `appointment_payment_ibfk_3` FOREIGN KEY (`appointment_id`) REFERENCES `appointment` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointment_payment`
--

LOCK TABLES `appointment_payment` WRITE;
/*!40000 ALTER TABLE `appointment_payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `appointment_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `appointment_queue`
--

DROP TABLE IF EXISTS `appointment_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `appointment_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `appointment_id` int(11) DEFAULT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `position` int(11) DEFAULT NULL,
  `shift_id` int(11) DEFAULT NULL,
  `date` date NOT NULL DEFAULT '2021-01-11',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `appointment_id` (`appointment_id`),
  KEY `staff_id` (`staff_id`),
  KEY `global_shift_id` (`shift_id`),
  CONSTRAINT `appointment_queue_ibfk_1` FOREIGN KEY (`appointment_id`) REFERENCES `appointment` (`id`) ON DELETE CASCADE,
  CONSTRAINT `appointment_queue_ibfk_2` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`id`) ON DELETE CASCADE,
  CONSTRAINT `appointment_queue_ibfk_3` FOREIGN KEY (`shift_id`) REFERENCES `doctor_shift_time` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointment_queue`
--

LOCK TABLES `appointment_queue` WRITE;
/*!40000 ALTER TABLE `appointment_queue` DISABLE KEYS */;
/*!40000 ALTER TABLE `appointment_queue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bed`
--

DROP TABLE IF EXISTS `bed`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bed` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `bed_type_id` int(11) DEFAULT NULL,
  `bed_group_id` int(11) DEFAULT NULL,
  `is_active` varchar(10) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `bed_type_id` (`bed_type_id`),
  KEY `bed_group_id` (`bed_group_id`),
  KEY `index_name` (`name`),
  CONSTRAINT `bed_ibfk_1` FOREIGN KEY (`bed_type_id`) REFERENCES `bed_type` (`id`) ON DELETE CASCADE,
  CONSTRAINT `bed_ibfk_2` FOREIGN KEY (`bed_group_id`) REFERENCES `bed_group` (`id`) ON DELETE CASCADE,
  CONSTRAINT `bed_ibfk_3` FOREIGN KEY (`bed_group_id`) REFERENCES `bed_group` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bed`
--

LOCK TABLES `bed` WRITE;
/*!40000 ALTER TABLE `bed` DISABLE KEYS */;
/*!40000 ALTER TABLE `bed` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bed_group`
--

DROP TABLE IF EXISTS `bed_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bed_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `color` varchar(50) NOT NULL DEFAULT '#f4f4f4',
  `description` text NOT NULL,
  `floor` int(11) NOT NULL,
  `is_active` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `index_name` (`name`),
  KEY `index_color` (`color`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bed_group`
--

LOCK TABLES `bed_group` WRITE;
/*!40000 ALTER TABLE `bed_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `bed_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bed_type`
--

DROP TABLE IF EXISTS `bed_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bed_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `index_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bed_type`
--

LOCK TABLES `bed_type` WRITE;
/*!40000 ALTER TABLE `bed_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `bed_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bill`
--

DROP TABLE IF EXISTS `bill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bill` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `case_id` int(11) NOT NULL,
  `attachment` mediumtext DEFAULT NULL,
  `attachment_name` mediumtext DEFAULT NULL,
  `amount` float(10,2) DEFAULT NULL,
  `payment_mode` varchar(100) DEFAULT NULL,
  `cheque_no` varchar(100) DEFAULT NULL,
  `cheque_date` date DEFAULT NULL,
  `payment_date` datetime DEFAULT NULL,
  `note` mediumtext DEFAULT NULL,
  `received_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `case_id` (`case_id`),
  CONSTRAINT `bill_ibfk_1` FOREIGN KEY (`case_id`) REFERENCES `case_references` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bill`
--

LOCK TABLES `bill` WRITE;
/*!40000 ALTER TABLE `bill` DISABLE KEYS */;
/*!40000 ALTER TABLE `bill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `birth_report`
--

DROP TABLE IF EXISTS `birth_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `birth_report` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `child_name` varchar(200) NOT NULL,
  `child_pic` text NOT NULL,
  `gender` varchar(200) NOT NULL,
  `birth_date` datetime DEFAULT NULL,
  `weight` varchar(200) NOT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `case_reference_id` int(11) DEFAULT NULL,
  `contact` varchar(20) NOT NULL,
  `mother_pic` text NOT NULL,
  `father_name` varchar(200) NOT NULL,
  `father_pic` text NOT NULL,
  `birth_report` mediumtext DEFAULT NULL,
  `document` text NOT NULL,
  `address` text DEFAULT NULL,
  `is_active` varchar(10) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `case_reference_id` (`case_reference_id`),
  KEY `patient_id` (`patient_id`),
  KEY `index_child_name` (`child_name`),
  KEY `index_gender` (`gender`),
  KEY `index_weight` (`weight`),
  KEY `index_contact` (`contact`),
  CONSTRAINT `birth_report_ibfk_1` FOREIGN KEY (`case_reference_id`) REFERENCES `case_references` (`id`) ON DELETE CASCADE,
  CONSTRAINT `birth_report_ibfk_2` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `birth_report`
--

LOCK TABLES `birth_report` WRITE;
/*!40000 ALTER TABLE `birth_report` DISABLE KEYS */;
/*!40000 ALTER TABLE `birth_report` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blood_bank_products`
--

DROP TABLE IF EXISTS `blood_bank_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blood_bank_products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `is_blood_group` int(11) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `index_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blood_bank_products`
--

LOCK TABLES `blood_bank_products` WRITE;
/*!40000 ALTER TABLE `blood_bank_products` DISABLE KEYS */;
/*!40000 ALTER TABLE `blood_bank_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blood_donor`
--

DROP TABLE IF EXISTS `blood_donor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blood_donor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `donor_name` varchar(100) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `blood_bank_product_id` int(11) DEFAULT NULL,
  `gender` varchar(11) DEFAULT NULL,
  `father_name` varchar(100) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `contact_no` varchar(20) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `blood_bank_product_id` (`blood_bank_product_id`),
  KEY `index_donor_name` (`donor_name`),
  KEY `index_gender` (`gender`),
  KEY `index_father_name` (`father_name`),
  KEY `index_contact_no` (`contact_no`),
  CONSTRAINT `blood_donor_ibfk_1` FOREIGN KEY (`blood_bank_product_id`) REFERENCES `blood_bank_products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blood_donor`
--

LOCK TABLES `blood_donor` WRITE;
/*!40000 ALTER TABLE `blood_donor` DISABLE KEYS */;
/*!40000 ALTER TABLE `blood_donor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blood_donor_cycle`
--

DROP TABLE IF EXISTS `blood_donor_cycle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blood_donor_cycle` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `blood_donor_cycle_id` int(11) NOT NULL,
  `blood_bank_product_id` int(11) DEFAULT NULL,
  `blood_donor_id` int(11) DEFAULT NULL,
  `charge_id` int(11) DEFAULT NULL,
  `donate_date` date DEFAULT NULL,
  `bag_no` varchar(11) DEFAULT NULL,
  `lot` varchar(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `standard_charge` float(10,2) DEFAULT NULL,
  `apply_charge` float(10,2) DEFAULT NULL,
  `amount` float(10,2) DEFAULT NULL,
  `institution` text DEFAULT NULL,
  `note` text DEFAULT NULL,
  `discount_percentage` float(10,2) DEFAULT 0.00,
  `tax_percentage` float(10,2) DEFAULT 0.00,
  `volume` varchar(100) DEFAULT NULL,
  `unit` int(11) DEFAULT NULL,
  `available` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `blood_bank_product_id` (`blood_bank_product_id`),
  KEY `blood_donor_id` (`blood_donor_id`),
  KEY `charge_id` (`charge_id`),
  KEY `index_bag_no` (`bag_no`),
  KEY `index_lot` (`lot`),
  KEY `index_amount` (`amount`),
  KEY `index_unit` (`unit`),
  KEY `index_volume` (`volume`),
  KEY `index_quantity` (`quantity`),
  KEY `index_standard_charge` (`standard_charge`),
  KEY `index_apply_charge` (`apply_charge`),
  CONSTRAINT `blood_donor_cycle_ibfk_1` FOREIGN KEY (`blood_bank_product_id`) REFERENCES `blood_bank_products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `blood_donor_cycle_ibfk_2` FOREIGN KEY (`blood_donor_id`) REFERENCES `blood_donor` (`id`) ON DELETE CASCADE,
  CONSTRAINT `blood_donor_cycle_ibfk_3` FOREIGN KEY (`charge_id`) REFERENCES `charges` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blood_donor_cycle`
--

LOCK TABLES `blood_donor_cycle` WRITE;
/*!40000 ALTER TABLE `blood_donor_cycle` DISABLE KEYS */;
/*!40000 ALTER TABLE `blood_donor_cycle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blood_issue`
--

DROP TABLE IF EXISTS `blood_issue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blood_issue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) NOT NULL,
  `case_reference_id` int(11) DEFAULT NULL,
  `blood_donor_cycle_id` int(11) DEFAULT NULL,
  `date_of_issue` datetime DEFAULT NULL,
  `hospital_doctor` int(11) DEFAULT NULL,
  `reference` text DEFAULT NULL,
  `charge_id` int(11) DEFAULT NULL,
  `standard_charge` int(11) NOT NULL,
  `tax_percentage` float(10,2) NOT NULL,
  `discount_percentage` float(10,2) DEFAULT 0.00,
  `amount` float(10,2) DEFAULT NULL,
  `net_amount` float(10,2) NOT NULL,
  `institution` text DEFAULT NULL,
  `technician` text DEFAULT NULL,
  `remark` text DEFAULT NULL,
  `organisation_id` int(11) DEFAULT NULL,
  `insurance_validity` date DEFAULT NULL,
  `insurance_id` varchar(250) DEFAULT NULL,
  `generated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `case_reference_id` (`case_reference_id`),
  KEY `blood_donor_cycle_id` (`blood_donor_cycle_id`),
  KEY `patient_id` (`patient_id`),
  KEY `charge_id` (`charge_id`),
  KEY `generated_by` (`generated_by`),
  KEY `organisation_id` (`organisation_id`),
  KEY `index_standard_charge` (`standard_charge`),
  KEY `index_tax_percentage` (`tax_percentage`),
  KEY `index_discount_percentage` (`discount_percentage`),
  KEY `index_amount` (`amount`),
  KEY `index_net_amount` (`net_amount`),
  KEY `hospital_doctor` (`hospital_doctor`),
  CONSTRAINT `blood_issue_ibfk_1` FOREIGN KEY (`case_reference_id`) REFERENCES `case_references` (`id`) ON DELETE CASCADE,
  CONSTRAINT `blood_issue_ibfk_2` FOREIGN KEY (`blood_donor_cycle_id`) REFERENCES `blood_donor_cycle` (`id`) ON DELETE CASCADE,
  CONSTRAINT `blood_issue_ibfk_3` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE,
  CONSTRAINT `blood_issue_ibfk_4` FOREIGN KEY (`charge_id`) REFERENCES `charges` (`id`) ON DELETE CASCADE,
  CONSTRAINT `blood_issue_ibfk_5` FOREIGN KEY (`generated_by`) REFERENCES `staff` (`id`) ON DELETE CASCADE,
  CONSTRAINT `blood_issue_ibfk_6` FOREIGN KEY (`organisation_id`) REFERENCES `organisation` (`id`) ON DELETE CASCADE,
  CONSTRAINT `blood_issue_ibfk_7` FOREIGN KEY (`hospital_doctor`) REFERENCES `staff` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blood_issue`
--

LOCK TABLES `blood_issue` WRITE;
/*!40000 ALTER TABLE `blood_issue` DISABLE KEYS */;
/*!40000 ALTER TABLE `blood_issue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `captcha`
--

DROP TABLE IF EXISTS `captcha`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `captcha` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(250) NOT NULL,
  `status` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `captcha`
--

LOCK TABLES `captcha` WRITE;
/*!40000 ALTER TABLE `captcha` DISABLE KEYS */;
INSERT INTO `captcha` VALUES (1,'userlogin',0,'2021-10-22 05:21:32'),(2,'login',0,'2021-10-22 05:21:38'),(3,'appointment',0,'2021-10-22 05:21:40');
/*!40000 ALTER TABLE `captcha` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `case_references`
--

DROP TABLE IF EXISTS `case_references`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `case_references` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bill_id` int(11) DEFAULT NULL,
  `discount_percentage` float(10,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `case_references_ibfk_1` (`bill_id`),
  CONSTRAINT `case_references_ibfk_1` FOREIGN KEY (`bill_id`) REFERENCES `bill` (`id`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `case_references`
--

LOCK TABLES `case_references` WRITE;
/*!40000 ALTER TABLE `case_references` DISABLE KEYS */;
/*!40000 ALTER TABLE `case_references` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `certificates`
--

DROP TABLE IF EXISTS `certificates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `certificates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `certificate_name` varchar(100) NOT NULL,
  `certificate_text` text DEFAULT NULL,
  `left_header` varchar(100) NOT NULL,
  `center_header` varchar(100) NOT NULL,
  `right_header` varchar(100) NOT NULL,
  `left_footer` varchar(100) NOT NULL,
  `right_footer` varchar(100) NOT NULL,
  `center_footer` varchar(100) NOT NULL,
  `background_image` text NOT NULL,
  `created_for` tinyint(1) NOT NULL COMMENT '1 = staff, 2 = patients',
  `status` tinyint(1) NOT NULL,
  `header_height` int(11) NOT NULL,
  `content_height` int(11) NOT NULL,
  `footer_height` int(11) NOT NULL,
  `content_width` int(11) NOT NULL,
  `enable_patient_image` tinyint(1) NOT NULL COMMENT '0=no,1=yes',
  `enable_image_height` int(11) NOT NULL,
  `updated_at` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `certificates`
--

LOCK TABLES `certificates` WRITE;
/*!40000 ALTER TABLE `certificates` DISABLE KEYS */;
INSERT INTO `certificates` VALUES (12,'Sample Patient File Cover','<table class=\"table table-bordered\" width=\"100%\">\r\n <tr>\r\n  <td width=\"50%\">Patient Name  </td>\r\n  <td width=\"50%\">[name] ([patient_id]) </td>\r\n </tr>\r\n <tr>\r\n  <td>Date of birth</td>\r\n  <td valign=\"top\">[dob]</td>\r\n </tr>\r\n <tr>\r\n  <td>Age</td>\r\n  <td valign=\"top\">[age]</td>\r\n </tr>\r\n <tr>\r\n  <td>Gender</td>\r\n  <td valign=\"top\">[gender]</td>\r\n </tr>\r\n \r\n <tr>\r\n  <td>Phone</td>\r\n  <td valign=\"top\">[phone]</td>\r\n </tr>\r\n <tr>\r\n  <td>Guardian Name</td>\r\n  <td valign=\"top\">[guardian_name]</td>\r\n </tr>\r\n <tr>\r\n  <td>Address</td>\r\n  <td valign=\"top\">[address]</td>\r\n </tr>\r\n <tr>\r\n  <td>Email</td>\r\n  <td valign=\"top\">[email]</td>\r\n </tr>\r\n <tr>\r\n  <td>OPD/IPD NO</td>\r\n  <td valign=\"top\">[opd_ipd_no]</td>\r\n </tr>\r\n  <tr>\r\n  <td>OPD Checkup Id</td>\r\n  <td valign=\"top\">[opd_checkup_id]</td>\r\n </tr>\r\n <tr>\r\n  <td>Consultant Doctor</td>\r\n  <td valign=\"top\">[consultant_doctor]</td>\r\n </tr>\r\n</table>','<h2>Patient Detail</h2>','','','','','','certificate.jpg',2,1,140,300,700,600,1,200,NULL,'2021-10-28 22:58:45');
/*!40000 ALTER TABLE `certificates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `charge_categories`
--

DROP TABLE IF EXISTS `charge_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `charge_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `charge_type_id` int(11) DEFAULT NULL,
  `name` varchar(200) NOT NULL,
  `description` mediumtext DEFAULT NULL,
  `short_code` varchar(30) DEFAULT NULL,
  `is_default` varchar(10) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `charge_type_id` (`charge_type_id`),
  KEY `index_name` (`name`),
  CONSTRAINT `charge_categories_ibfk_1` FOREIGN KEY (`charge_type_id`) REFERENCES `charge_type_master` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `charge_categories`
--

LOCK TABLES `charge_categories` WRITE;
/*!40000 ALTER TABLE `charge_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `charge_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `charge_type_master`
--

DROP TABLE IF EXISTS `charge_type_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `charge_type_master` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `charge_type` varchar(200) NOT NULL,
  `is_default` varchar(10) NOT NULL,
  `is_active` varchar(10) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `index_charge_type` (`charge_type`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `charge_type_master`
--

LOCK TABLES `charge_type_master` WRITE;
/*!40000 ALTER TABLE `charge_type_master` DISABLE KEYS */;
INSERT INTO `charge_type_master` VALUES (1,'Appointment','yes','yes','2021-09-24 14:10:32'),(2,'OPD','yes','yes','2021-09-24 14:10:02'),(3,'IPD','yes','yes','2021-09-24 14:10:47'),(4,'Pathology','yes','yes','2021-10-22 21:40:03'),(5,'Radiology','yes','yes','2021-10-22 22:10:21'),(6,'Blood Bank','yes','yes','2021-10-22 22:10:33'),(7,'Ambulance','yes','yes','2021-10-22 22:10:44'),(8,'Procedures','yes','yes','2018-08-17 13:40:07'),(9,'Investigations','yes','yes','2018-08-17 13:40:07'),(10,'Supplier','yes','yes','2018-08-17 13:40:07'),(11,'Operations','yes','yes','2018-08-17 13:40:07'),(12,'Others','yes','yes','2018-08-17 13:40:07');
/*!40000 ALTER TABLE `charge_type_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `charge_type_module`
--

DROP TABLE IF EXISTS `charge_type_module`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `charge_type_module` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `charge_type_master_id` int(11) DEFAULT NULL,
  `module_shortcode` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `charge_type_master_id` (`charge_type_master_id`),
  CONSTRAINT `charge_type_module_ibfk_1` FOREIGN KEY (`charge_type_master_id`) REFERENCES `charge_type_master` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `charge_type_module`
--

LOCK TABLES `charge_type_module` WRITE;
/*!40000 ALTER TABLE `charge_type_module` DISABLE KEYS */;
INSERT INTO `charge_type_module` VALUES (2,1,'appointment','2021-10-23 03:52:42'),(4,2,'opd','2021-10-23 03:52:45'),(5,3,'ipd','2021-10-23 03:52:49'),(6,4,'pathology','2021-10-23 03:52:52'),(7,5,'radiology','2021-10-23 03:52:54'),(8,6,'blood_bank','2021-10-23 03:52:56'),(9,7,'ambulance','2021-10-23 03:52:59'),(10,8,'opd','2021-10-23 03:53:03'),(11,8,'ipd','2021-10-23 03:53:04'),(13,9,'pathology','2021-10-23 03:53:09'),(14,9,'radiology','2021-10-23 03:53:11'),(15,10,'opd','2021-10-23 03:53:14'),(16,10,'ipd','2021-10-23 03:53:16'),(17,11,'opd','2021-10-23 03:53:18'),(18,11,'ipd','2021-10-23 03:53:18'),(19,12,'appointment','2021-10-23 03:53:20'),(20,12,'opd','2021-10-23 03:53:21'),(21,12,'ipd','2021-10-23 03:53:21'),(24,12,'pathology','2021-10-23 03:53:25'),(25,12,'radiology','2021-10-23 03:53:27'),(26,12,'blood_bank','2021-10-23 03:53:30'),(27,12,'ambulance','2021-10-23 03:53:31');
/*!40000 ALTER TABLE `charge_type_module` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `charge_units`
--

DROP TABLE IF EXISTS `charge_units`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `charge_units` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unit` varchar(50) DEFAULT NULL,
  `is_active` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `index_unit` (`unit`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `charge_units`
--

LOCK TABLES `charge_units` WRITE;
/*!40000 ALTER TABLE `charge_units` DISABLE KEYS */;
/*!40000 ALTER TABLE `charge_units` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `charges`
--

DROP TABLE IF EXISTS `charges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `charges` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `charge_category_id` int(11) DEFAULT NULL,
  `tax_category_id` int(11) DEFAULT NULL,
  `charge_unit_id` int(11) DEFAULT NULL,
  `name` varchar(200) NOT NULL,
  `standard_charge` float(10,2) DEFAULT 0.00,
  `date` date DEFAULT NULL,
  `description` mediumtext DEFAULT NULL,
  `status` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `charge_category_id` (`charge_category_id`),
  KEY `tax_category_id` (`tax_category_id`),
  KEY `charge_unit_id` (`charge_unit_id`),
  KEY `index_name` (`name`),
  KEY `index_standard_charge` (`standard_charge`),
  KEY `index_date` (`date`),
  CONSTRAINT `charges_ibfk_1` FOREIGN KEY (`charge_category_id`) REFERENCES `charge_categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `charges_ibfk_2` FOREIGN KEY (`tax_category_id`) REFERENCES `tax_category` (`id`) ON DELETE CASCADE,
  CONSTRAINT `charges_ibfk_3` FOREIGN KEY (`charge_unit_id`) REFERENCES `charge_units` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `charges`
--

LOCK TABLES `charges` WRITE;
/*!40000 ALTER TABLE `charges` DISABLE KEYS */;
/*!40000 ALTER TABLE `charges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chat_connections`
--

DROP TABLE IF EXISTS `chat_connections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chat_connections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `chat_user_one` int(11) NOT NULL,
  `chat_user_two` int(11) NOT NULL,
  `ip` varchar(30) DEFAULT NULL,
  `time` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_at` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `chat_user_one` (`chat_user_one`),
  KEY `chat_user_two` (`chat_user_two`),
  CONSTRAINT `chat_connections_ibfk_1` FOREIGN KEY (`chat_user_one`) REFERENCES `chat_users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `chat_connections_ibfk_2` FOREIGN KEY (`chat_user_two`) REFERENCES `chat_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chat_connections`
--

LOCK TABLES `chat_connections` WRITE;
/*!40000 ALTER TABLE `chat_connections` DISABLE KEYS */;
/*!40000 ALTER TABLE `chat_connections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chat_messages`
--

DROP TABLE IF EXISTS `chat_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chat_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message` text DEFAULT NULL,
  `chat_user_id` int(11) NOT NULL,
  `ip` varchar(30) NOT NULL,
  `time` int(11) NOT NULL,
  `is_first` int(11) DEFAULT 0,
  `is_read` int(11) NOT NULL DEFAULT 0,
  `chat_connection_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `chat_user_id` (`chat_user_id`),
  KEY `chat_connection_id` (`chat_connection_id`),
  CONSTRAINT `chat_messages_ibfk_1` FOREIGN KEY (`chat_user_id`) REFERENCES `chat_users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `chat_messages_ibfk_2` FOREIGN KEY (`chat_connection_id`) REFERENCES `chat_connections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chat_messages`
--

LOCK TABLES `chat_messages` WRITE;
/*!40000 ALTER TABLE `chat_messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `chat_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chat_users`
--

DROP TABLE IF EXISTS `chat_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chat_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_type` varchar(20) DEFAULT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `create_staff_id` int(11) DEFAULT NULL,
  `create_patient_id` int(11) DEFAULT NULL,
  `is_active` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_at` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `staff_id` (`staff_id`),
  KEY `patient_id` (`patient_id`),
  KEY `create_staff_id` (`create_staff_id`),
  KEY `create_patient_id` (`create_patient_id`),
  CONSTRAINT `chat_users_ibfk_1` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`id`) ON DELETE CASCADE,
  CONSTRAINT `chat_users_ibfk_2` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE,
  CONSTRAINT `chat_users_ibfk_3` FOREIGN KEY (`create_staff_id`) REFERENCES `staff` (`id`) ON DELETE CASCADE,
  CONSTRAINT `chat_users_ibfk_4` FOREIGN KEY (`create_patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chat_users`
--

LOCK TABLES `chat_users` WRITE;
/*!40000 ALTER TABLE `chat_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `chat_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `complaint`
--

DROP TABLE IF EXISTS `complaint`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `complaint` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `complaint_type_id` int(11) DEFAULT NULL,
  `source` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `contact` varchar(20) NOT NULL,
  `email` varchar(200) NOT NULL,
  `date` date DEFAULT NULL,
  `description` text DEFAULT NULL,
  `action_taken` varchar(200) NOT NULL,
  `assigned` varchar(50) NOT NULL,
  `note` text DEFAULT NULL,
  `image` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `complaint_type_id` (`complaint_type_id`),
  CONSTRAINT `complaint_ibfk_1` FOREIGN KEY (`complaint_type_id`) REFERENCES `complaint_type` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `complaint`
--

LOCK TABLES `complaint` WRITE;
/*!40000 ALTER TABLE `complaint` DISABLE KEYS */;
/*!40000 ALTER TABLE `complaint` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `complaint_type`
--

DROP TABLE IF EXISTS `complaint_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `complaint_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `complaint_type` varchar(100) NOT NULL,
  `description` mediumtext DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `index_complaint_type` (`complaint_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `complaint_type`
--

LOCK TABLES `complaint_type` WRITE;
/*!40000 ALTER TABLE `complaint_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `complaint_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conference_staff`
--

DROP TABLE IF EXISTS `conference_staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `conference_staff` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `conference_id` int(11) DEFAULT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `conference_id` (`conference_id`),
  KEY `staff_id` (`staff_id`),
  CONSTRAINT `conference_staff_ibfk_1` FOREIGN KEY (`conference_id`) REFERENCES `conferences` (`id`) ON DELETE CASCADE,
  CONSTRAINT `conference_staff_ibfk_2` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conference_staff`
--

LOCK TABLES `conference_staff` WRITE;
/*!40000 ALTER TABLE `conference_staff` DISABLE KEYS */;
/*!40000 ALTER TABLE `conference_staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conferences`
--

DROP TABLE IF EXISTS `conferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `conferences` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `purpose` varchar(200) NOT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `visit_details_id` int(11) DEFAULT NULL,
  `ipd_id` int(11) DEFAULT NULL,
  `created_id` int(11) DEFAULT NULL,
  `title` text DEFAULT NULL,
  `date` datetime NOT NULL,
  `duration` int(11) NOT NULL,
  `password` varchar(100) NOT NULL,
  `host_video` int(11) NOT NULL,
  `client_video` int(11) NOT NULL,
  `description` mediumtext DEFAULT NULL,
  `timezone` text DEFAULT NULL,
  `return_response` text DEFAULT NULL,
  `api_type` varchar(50) NOT NULL,
  `status` int(11) NOT NULL,
  `live_consult_link` int(11) NOT NULL DEFAULT 1 COMMENT 'appointment zoom link for front user status',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `staff_id` (`staff_id`),
  KEY `patient_id` (`patient_id`),
  KEY `visit_details_id` (`visit_details_id`),
  KEY `ipd_id` (`ipd_id`),
  KEY `created_id` (`created_id`),
  CONSTRAINT `conferences_ibfk_1` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`id`) ON DELETE CASCADE,
  CONSTRAINT `conferences_ibfk_2` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE,
  CONSTRAINT `conferences_ibfk_3` FOREIGN KEY (`visit_details_id`) REFERENCES `visit_details` (`id`) ON DELETE CASCADE,
  CONSTRAINT `conferences_ibfk_4` FOREIGN KEY (`ipd_id`) REFERENCES `ipd_details` (`id`) ON DELETE CASCADE,
  CONSTRAINT `conferences_ibfk_5` FOREIGN KEY (`created_id`) REFERENCES `staff` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conferences`
--

LOCK TABLES `conferences` WRITE;
/*!40000 ALTER TABLE `conferences` DISABLE KEYS */;
/*!40000 ALTER TABLE `conferences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conferences_history`
--

DROP TABLE IF EXISTS `conferences_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `conferences_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `conference_id` int(11) DEFAULT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `total_hit` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `conference_id` (`conference_id`),
  KEY `staff_id` (`staff_id`),
  KEY `patient_id` (`patient_id`),
  CONSTRAINT `conferences_history_ibfk_1` FOREIGN KEY (`conference_id`) REFERENCES `conferences` (`id`) ON DELETE CASCADE,
  CONSTRAINT `conferences_history_ibfk_2` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`id`) ON DELETE CASCADE,
  CONSTRAINT `conferences_history_ibfk_3` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conferences_history`
--

LOCK TABLES `conferences_history` WRITE;
/*!40000 ALTER TABLE `conferences_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `conferences_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consult_charges`
--

DROP TABLE IF EXISTS `consult_charges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `consult_charges` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `doctor` int(11) DEFAULT NULL,
  `standard_charge` float(10,2) NOT NULL,
  `date` date NOT NULL,
  `status` varchar(10) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `doctor` (`doctor`),
  CONSTRAINT `consult_charges_ibfk_1` FOREIGN KEY (`doctor`) REFERENCES `staff` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consult_charges`
--

LOCK TABLES `consult_charges` WRITE;
/*!40000 ALTER TABLE `consult_charges` DISABLE KEYS */;
/*!40000 ALTER TABLE `consult_charges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consultant_register`
--

DROP TABLE IF EXISTS `consultant_register`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `consultant_register` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ipd_id` int(11) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `ins_date` date DEFAULT NULL,
  `instruction` text DEFAULT NULL,
  `cons_doctor` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `ipd_id` (`ipd_id`),
  KEY `cons_doctor` (`cons_doctor`),
  CONSTRAINT `consultant_register_ibfk_1` FOREIGN KEY (`ipd_id`) REFERENCES `ipd_details` (`id`) ON DELETE CASCADE,
  CONSTRAINT `consultant_register_ibfk_2` FOREIGN KEY (`cons_doctor`) REFERENCES `staff` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consultant_register`
--

LOCK TABLES `consultant_register` WRITE;
/*!40000 ALTER TABLE `consultant_register` DISABLE KEYS */;
/*!40000 ALTER TABLE `consultant_register` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `content_for`
--

DROP TABLE IF EXISTS `content_for`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `content_for` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role` varchar(50) DEFAULT NULL,
  `content_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `content_id` (`content_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `content_for_ibfk_1` FOREIGN KEY (`content_id`) REFERENCES `contents` (`id`) ON DELETE CASCADE,
  CONSTRAINT `content_for_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `content_for`
--

LOCK TABLES `content_for` WRITE;
/*!40000 ALTER TABLE `content_for` DISABLE KEYS */;
/*!40000 ALTER TABLE `content_for` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `content_types`
--

DROP TABLE IF EXISTS `content_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `content_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `is_active` int(11) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `index_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `content_types`
--

LOCK TABLES `content_types` WRITE;
/*!40000 ALTER TABLE `content_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `content_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contents`
--

DROP TABLE IF EXISTS `contents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `is_public` varchar(10) DEFAULT 'No',
  `file` text DEFAULT NULL,
  `note` text DEFAULT NULL,
  `date` date DEFAULT NULL,
  `is_active` varchar(10) DEFAULT 'no',
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `index_title` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contents`
--

LOCK TABLES `contents` WRITE;
/*!40000 ALTER TABLE `contents` DISABLE KEYS */;
/*!40000 ALTER TABLE `contents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `custom_field_values`
--

DROP TABLE IF EXISTS `custom_field_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `custom_field_values` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `belong_table_id` int(11) DEFAULT NULL,
  `custom_field_id` int(11) DEFAULT NULL,
  `field_value` varchar(500) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `custom_field_id` (`custom_field_id`),
  KEY `index_field_value` (`field_value`),
  KEY `index_belong_table_id` (`belong_table_id`),
  KEY `index_custom_field_id` (`custom_field_id`),
  CONSTRAINT `custom_field_values_ibfk_1` FOREIGN KEY (`custom_field_id`) REFERENCES `custom_fields` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `custom_field_values`
--

LOCK TABLES `custom_field_values` WRITE;
/*!40000 ALTER TABLE `custom_field_values` DISABLE KEYS */;
/*!40000 ALTER TABLE `custom_field_values` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `custom_fields`
--

DROP TABLE IF EXISTS `custom_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `custom_fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `belong_to` varchar(100) DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL,
  `bs_column` int(11) DEFAULT NULL,
  `validation` int(11) DEFAULT 0,
  `field_values` mediumtext DEFAULT NULL,
  `visible_on_print` int(11) DEFAULT NULL,
  `visible_on_report` int(11) DEFAULT NULL,
  `visible_on_table` int(11) DEFAULT NULL,
  `visible_on_patient_panel` int(11) DEFAULT NULL,
  `weight` int(11) DEFAULT NULL,
  `is_active` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `index_name` (`name`),
  KEY `index_belong_to` (`belong_to`),
  KEY `index_type` (`type`),
  KEY `index_visible_on_table` (`visible_on_table`),
  KEY `index_visible_on_print` (`visible_on_print`),
  KEY `index_visible_on_report` (`visible_on_report`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `custom_fields`
--

LOCK TABLES `custom_fields` WRITE;
/*!40000 ALTER TABLE `custom_fields` DISABLE KEYS */;
/*!40000 ALTER TABLE `custom_fields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `death_report`
--

DROP TABLE IF EXISTS `death_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `death_report` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) DEFAULT NULL,
  `case_reference_id` int(11) DEFAULT NULL,
  `attachment` text NOT NULL,
  `attachment_name` text DEFAULT NULL,
  `death_date` datetime NOT NULL,
  `guardian_name` varchar(200) NOT NULL,
  `death_report` text DEFAULT NULL,
  `is_active` varchar(10) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `case_reference_id` (`case_reference_id`),
  KEY `patient_id` (`patient_id`),
  CONSTRAINT `death_report_ibfk_1` FOREIGN KEY (`case_reference_id`) REFERENCES `case_references` (`id`) ON DELETE CASCADE,
  CONSTRAINT `death_report_ibfk_2` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `death_report`
--

LOCK TABLES `death_report` WRITE;
/*!40000 ALTER TABLE `death_report` DISABLE KEYS */;
/*!40000 ALTER TABLE `death_report` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `department` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `department_name` varchar(200) NOT NULL,
  `is_active` varchar(10) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `index_department_name` (`department_name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES (1,'Physiotherapy','yes','2026-11-07 23:09:40'),(2,'Pediatrics','yes','2026-11-08 11:32:32'),(3,'Gynaecology','yes','2026-11-08 12:08:35');
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discharge_card`
--

DROP TABLE IF EXISTS `discharge_card`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `discharge_card` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `case_reference_id` int(11) DEFAULT NULL,
  `opd_details_id` int(11) DEFAULT NULL,
  `ipd_details_id` int(11) DEFAULT NULL,
  `discharge_by` int(11) DEFAULT NULL,
  `discharge_date` datetime DEFAULT NULL,
  `discharge_status` int(11) NOT NULL,
  `death_date` datetime DEFAULT NULL,
  `refer_date` datetime DEFAULT NULL,
  `refer_to_hospital` varchar(255) DEFAULT NULL,
  `reason_for_referral` varchar(255) DEFAULT NULL,
  `operation` varchar(225) NOT NULL,
  `diagnosis` varchar(255) NOT NULL,
  `investigations` text DEFAULT NULL,
  `treatment_home` varchar(255) NOT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `case_reference_id` (`case_reference_id`),
  KEY `opd_details_id` (`opd_details_id`),
  KEY `ipd_details_id` (`ipd_details_id`),
  KEY `discharge_by` (`discharge_by`),
  CONSTRAINT `discharge_card_ibfk_1` FOREIGN KEY (`ipd_details_id`) REFERENCES `ipd_details` (`id`) ON DELETE CASCADE,
  CONSTRAINT `discharge_card_ibfk_2` FOREIGN KEY (`discharge_by`) REFERENCES `staff` (`id`) ON DELETE CASCADE,
  CONSTRAINT `discharge_card_ibfk_3` FOREIGN KEY (`case_reference_id`) REFERENCES `case_references` (`id`) ON DELETE CASCADE,
  CONSTRAINT `discharge_card_ibfk_4` FOREIGN KEY (`opd_details_id`) REFERENCES `opd_details` (`id`) ON DELETE CASCADE,
  CONSTRAINT `discharge_card_ibfk_5` FOREIGN KEY (`ipd_details_id`) REFERENCES `ipd_details` (`id`) ON DELETE CASCADE,
  CONSTRAINT `discharge_card_ibfk_6` FOREIGN KEY (`discharge_by`) REFERENCES `staff` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discharge_card`
--

LOCK TABLES `discharge_card` WRITE;
/*!40000 ALTER TABLE `discharge_card` DISABLE KEYS */;
/*!40000 ALTER TABLE `discharge_card` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dispatch_receive`
--

DROP TABLE IF EXISTS `dispatch_receive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dispatch_receive` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reference_no` varchar(50) NOT NULL,
  `to_title` varchar(100) NOT NULL,
  `address` text DEFAULT NULL,
  `note` text DEFAULT NULL,
  `from_title` varchar(200) NOT NULL,
  `date` date DEFAULT NULL,
  `image` varchar(100) NOT NULL,
  `type` varchar(10) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `index_reference_no` (`reference_no`),
  KEY `index_to_title` (`to_title`),
  KEY `index_from_title` (`from_title`),
  KEY `index_date` (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dispatch_receive`
--

LOCK TABLES `dispatch_receive` WRITE;
/*!40000 ALTER TABLE `dispatch_receive` DISABLE KEYS */;
/*!40000 ALTER TABLE `dispatch_receive` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor_absent`
--

DROP TABLE IF EXISTS `doctor_absent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `doctor_absent` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `staff_id` int(11) DEFAULT NULL,
  `date` date NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `staff_id` (`staff_id`),
  KEY `index_date` (`date`),
  CONSTRAINT `doctor_absent_ibfk_1` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor_absent`
--

LOCK TABLES `doctor_absent` WRITE;
/*!40000 ALTER TABLE `doctor_absent` DISABLE KEYS */;
/*!40000 ALTER TABLE `doctor_absent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor_global_shift`
--

DROP TABLE IF EXISTS `doctor_global_shift`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `doctor_global_shift` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `staff_id` int(11) DEFAULT NULL,
  `global_shift_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `global_shift_id` (`global_shift_id`),
  KEY `staff_id` (`staff_id`),
  CONSTRAINT `doctor_global_shift_ibfk_1` FOREIGN KEY (`global_shift_id`) REFERENCES `global_shift` (`id`) ON DELETE CASCADE,
  CONSTRAINT `doctor_global_shift_ibfk_2` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor_global_shift`
--

LOCK TABLES `doctor_global_shift` WRITE;
/*!40000 ALTER TABLE `doctor_global_shift` DISABLE KEYS */;
/*!40000 ALTER TABLE `doctor_global_shift` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor_shift_time`
--

DROP TABLE IF EXISTS `doctor_shift_time`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `doctor_shift_time` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `day` varchar(20) DEFAULT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `doctor_global_shift_id` int(11) DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `staff_id` (`staff_id`),
  KEY `doctor_global_shift_id` (`doctor_global_shift_id`),
  KEY `index_day` (`day`),
  CONSTRAINT `doctor_shift_time_ibfk_2` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`id`) ON DELETE CASCADE,
  CONSTRAINT `doctor_shift_time_ibfk_3` FOREIGN KEY (`doctor_global_shift_id`) REFERENCES `doctor_global_shift` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor_shift_time`
--

LOCK TABLES `doctor_shift_time` WRITE;
/*!40000 ALTER TABLE `doctor_shift_time` DISABLE KEYS */;
/*!40000 ALTER TABLE `doctor_shift_time` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dose_duration`
--

DROP TABLE IF EXISTS `dose_duration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dose_duration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `index_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dose_duration`
--

LOCK TABLES `dose_duration` WRITE;
/*!40000 ALTER TABLE `dose_duration` DISABLE KEYS */;
/*!40000 ALTER TABLE `dose_duration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dose_interval`
--

DROP TABLE IF EXISTS `dose_interval`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dose_interval` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `index_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dose_interval`
--

LOCK TABLES `dose_interval` WRITE;
/*!40000 ALTER TABLE `dose_interval` DISABLE KEYS */;
/*!40000 ALTER TABLE `dose_interval` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `duty_roster_assign`
--

DROP TABLE IF EXISTS `duty_roster_assign`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `duty_roster_assign` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` int(11) NOT NULL,
  `roster_duty_date` date DEFAULT NULL,
  `floor_id` int(11) DEFAULT NULL,
  `department_id` int(11) DEFAULT NULL,
  `staff_id` int(11) NOT NULL,
  `duty_roster_list_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `duty_roster_list_id` (`duty_roster_list_id`),
  KEY `department_id` (`department_id`),
  KEY `staff_id` (`staff_id`),
  KEY `floor_id` (`floor_id`),
  KEY `index_roster_duty_date` (`roster_duty_date`),
  CONSTRAINT `duty_roster_assign_ibfk_1` FOREIGN KEY (`duty_roster_list_id`) REFERENCES `duty_roster_list` (`id`) ON DELETE CASCADE,
  CONSTRAINT `duty_roster_assign_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `department` (`id`) ON DELETE CASCADE,
  CONSTRAINT `duty_roster_assign_ibfk_3` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`id`) ON DELETE CASCADE,
  CONSTRAINT `duty_roster_assign_ibfk_4` FOREIGN KEY (`floor_id`) REFERENCES `floor` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `duty_roster_assign`
--

LOCK TABLES `duty_roster_assign` WRITE;
/*!40000 ALTER TABLE `duty_roster_assign` DISABLE KEYS */;
/*!40000 ALTER TABLE `duty_roster_assign` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `duty_roster_list`
--

DROP TABLE IF EXISTS `duty_roster_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `duty_roster_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `duty_roster_shift_id` int(11) NOT NULL,
  `duty_roster_start_date` date NOT NULL,
  `duty_roster_end_date` date NOT NULL,
  `duty_roster_total_day` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `duty_roster_shift_id` (`duty_roster_shift_id`),
  KEY `index_duty_roster_start_date` (`duty_roster_start_date`),
  KEY `index_duty_roster_end_date` (`duty_roster_end_date`),
  CONSTRAINT `duty_roster_list_ibfk_1` FOREIGN KEY (`duty_roster_shift_id`) REFERENCES `duty_roster_shift` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `duty_roster_list`
--

LOCK TABLES `duty_roster_list` WRITE;
/*!40000 ALTER TABLE `duty_roster_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `duty_roster_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `duty_roster_shift`
--

DROP TABLE IF EXISTS `duty_roster_shift`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `duty_roster_shift` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `shift_name` varchar(255) NOT NULL,
  `shift_start` time NOT NULL,
  `shift_end` time NOT NULL,
  `shift_hour` time NOT NULL,
  `is_active` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `index_shift_name` (`shift_name`),
  KEY `index_shift_start` (`shift_start`),
  KEY `index_shift_end` (`shift_end`),
  KEY `index_shift_hour` (`shift_hour`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `duty_roster_shift`
--

LOCK TABLES `duty_roster_shift` WRITE;
/*!40000 ALTER TABLE `duty_roster_shift` DISABLE KEYS */;
/*!40000 ALTER TABLE `duty_roster_shift` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_config`
--

DROP TABLE IF EXISTS `email_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email_type` varchar(100) DEFAULT NULL,
  `smtp_server` varchar(100) DEFAULT NULL,
  `smtp_port` varchar(100) DEFAULT NULL,
  `smtp_username` varchar(100) DEFAULT NULL,
  `smtp_password` varchar(100) DEFAULT NULL,
  `ssl_tls` varchar(100) DEFAULT NULL,
  `smtp_auth` varchar(10) NOT NULL,
  `is_active` varchar(10) NOT NULL DEFAULT 'no',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_config`
--

LOCK TABLES `email_config` WRITE;
/*!40000 ALTER TABLE `email_config` DISABLE KEYS */;
INSERT INTO `email_config` VALUES (1,'sendmail','','','','','','true','yes','2021-09-24 12:44:21');
/*!40000 ALTER TABLE `email_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `events` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `event_title` varchar(200) NOT NULL,
  `event_description` text DEFAULT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `event_type` varchar(100) NOT NULL,
  `event_color` varchar(200) NOT NULL,
  `event_for` varchar(100) NOT NULL,
  `role_id` int(11) DEFAULT NULL,
  `is_active` varchar(10) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `start_date` (`start_date`),
  KEY `index_end_date` (`end_date`),
  KEY `index_event_type` (`event_type`) USING BTREE,
  KEY `index_event_color` (`event_color`) USING BTREE,
  KEY `index_event_title` (`event_title`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `events_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events`
--

LOCK TABLES `events` WRITE;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
/*!40000 ALTER TABLE `events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expense_head`
--

DROP TABLE IF EXISTS `expense_head`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `expense_head` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `exp_category` varchar(50) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `is_active` varchar(10) DEFAULT 'yes',
  `is_deleted` varchar(10) DEFAULT 'no',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `index_exp_category` (`exp_category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expense_head`
--

LOCK TABLES `expense_head` WRITE;
/*!40000 ALTER TABLE `expense_head` DISABLE KEYS */;
/*!40000 ALTER TABLE `expense_head` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expenses`
--

DROP TABLE IF EXISTS `expenses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `expenses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `exp_head_id` int(11) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `invoice_no` varchar(200) NOT NULL,
  `date` date DEFAULT NULL,
  `amount` float(10,2) DEFAULT NULL,
  `documents` text DEFAULT NULL,
  `note` text DEFAULT NULL,
  `is_active` varchar(10) DEFAULT 'yes',
  `is_deleted` varchar(10) DEFAULT 'no',
  `generated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `exp_head_id` (`exp_head_id`),
  KEY `generated_by` (`generated_by`),
  KEY `index_invoice_no` (`invoice_no`),
  KEY `index_name` (`name`),
  KEY `index_date` (`date`) USING BTREE,
  KEY `index_amount` (`amount`) USING BTREE,
  CONSTRAINT `expenses_ibfk_1` FOREIGN KEY (`exp_head_id`) REFERENCES `expense_head` (`id`) ON DELETE CASCADE,
  CONSTRAINT `expenses_ibfk_2` FOREIGN KEY (`generated_by`) REFERENCES `staff` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expenses`
--

LOCK TABLES `expenses` WRITE;
/*!40000 ALTER TABLE `expenses` DISABLE KEYS */;
/*!40000 ALTER TABLE `expenses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `filetypes`
--

DROP TABLE IF EXISTS `filetypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `filetypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `file_extension` text DEFAULT NULL,
  `file_mime` text DEFAULT NULL,
  `file_size` int(11) NOT NULL,
  `image_extension` text DEFAULT NULL,
  `image_mime` text DEFAULT NULL,
  `image_size` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `filetypes`
--

LOCK TABLES `filetypes` WRITE;
/*!40000 ALTER TABLE `filetypes` DISABLE KEYS */;
/*!40000 ALTER TABLE `filetypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `finding`
--

DROP TABLE IF EXISTS `finding`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `finding` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `description` text DEFAULT NULL,
  `finding_category_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `finding_category_id` (`finding_category_id`),
  KEY `index_name` (`name`),
  CONSTRAINT `finding_ibfk_1` FOREIGN KEY (`finding_category_id`) REFERENCES `finding_category` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `finding`
--

LOCK TABLES `finding` WRITE;
/*!40000 ALTER TABLE `finding` DISABLE KEYS */;
/*!40000 ALTER TABLE `finding` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `finding_category`
--

DROP TABLE IF EXISTS `finding_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `finding_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `index_category` (`category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `finding_category`
--

LOCK TABLES `finding_category` WRITE;
/*!40000 ALTER TABLE `finding_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `finding_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `floor`
--

DROP TABLE IF EXISTS `floor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `floor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `index_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `floor`
--

LOCK TABLES `floor` WRITE;
/*!40000 ALTER TABLE `floor` DISABLE KEYS */;
/*!40000 ALTER TABLE `floor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `front_cms_media_gallery`
--

DROP TABLE IF EXISTS `front_cms_media_gallery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `front_cms_media_gallery` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `image` varchar(300) DEFAULT NULL,
  `thumb_path` varchar(300) DEFAULT NULL,
  `dir_path` varchar(300) DEFAULT NULL,
  `img_name` varchar(300) DEFAULT NULL,
  `thumb_name` varchar(300) DEFAULT NULL,
  `file_type` varchar(100) NOT NULL,
  `file_size` varchar(100) NOT NULL,
  `vid_url` mediumtext DEFAULT NULL,
  `vid_title` varchar(250) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `front_cms_media_gallery`
--

LOCK TABLES `front_cms_media_gallery` WRITE;
/*!40000 ALTER TABLE `front_cms_media_gallery` DISABLE KEYS */;
/*!40000 ALTER TABLE `front_cms_media_gallery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `front_cms_menu_items`
--

DROP TABLE IF EXISTS `front_cms_menu_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `front_cms_menu_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `menu_id` int(11) DEFAULT NULL,
  `menu` varchar(100) DEFAULT NULL,
  `page_id` int(11) NOT NULL,
  `parent_id` int(11) NOT NULL,
  `ext_url` mediumtext DEFAULT NULL,
  `open_new_tab` int(11) DEFAULT 0,
  `ext_url_link` mediumtext DEFAULT NULL,
  `slug` varchar(200) DEFAULT NULL,
  `weight` int(11) DEFAULT NULL,
  `publish` int(11) NOT NULL DEFAULT 0,
  `description` mediumtext DEFAULT NULL,
  `is_active` varchar(10) DEFAULT 'no',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `front_cms_menu_items`
--

LOCK TABLES `front_cms_menu_items` WRITE;
/*!40000 ALTER TABLE `front_cms_menu_items` DISABLE KEYS */;
INSERT INTO `front_cms_menu_items` VALUES (1,2,'Home',1,0,NULL,NULL,NULL,'home-1',NULL,0,NULL,'no','2018-07-14 03:14:12'),(2,1,'Appointment',0,0,'1',NULL,'http://yourdomainname.com/form/appointment','appointment',2,0,NULL,'no','2021-09-27 12:04:57'),(3,1,'Home',1,0,NULL,NULL,NULL,'home',NULL,0,NULL,'no','2019-01-24 03:18:17'),(4,2,'Appointment',0,0,'1',NULL,'http://yourdomainname.com/form/appointment','appointment-1',NULL,0,NULL,'no','2019-11-02 10:54:41');
/*!40000 ALTER TABLE `front_cms_menu_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `front_cms_menus`
--

DROP TABLE IF EXISTS `front_cms_menus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `front_cms_menus` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `menu` varchar(100) DEFAULT NULL,
  `slug` varchar(200) DEFAULT NULL,
  `description` mediumtext DEFAULT NULL,
  `open_new_tab` int(11) NOT NULL DEFAULT 0,
  `ext_url` mediumtext DEFAULT NULL,
  `ext_url_link` mediumtext DEFAULT NULL,
  `publish` int(11) NOT NULL DEFAULT 0,
  `content_type` varchar(10) NOT NULL DEFAULT 'manual',
  `is_active` varchar(10) DEFAULT 'no',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `front_cms_menus`
--

LOCK TABLES `front_cms_menus` WRITE;
/*!40000 ALTER TABLE `front_cms_menus` DISABLE KEYS */;
INSERT INTO `front_cms_menus` VALUES (1,'Main Menu','main-menu','Main menu',0,'','',0,'default','no','2018-04-20 03:54:49'),(2,'Bottom Menu','bottom-menu','Bottom Menu',0,'','',0,'default','no','2018-04-20 03:54:55');
/*!40000 ALTER TABLE `front_cms_menus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `front_cms_page_contents`
--

DROP TABLE IF EXISTS `front_cms_page_contents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `front_cms_page_contents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `page_id` int(11) DEFAULT NULL,
  `content_type` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `page_id` (`page_id`),
  CONSTRAINT `front_cms_page_contents_ibfk_1` FOREIGN KEY (`page_id`) REFERENCES `front_cms_pages` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `front_cms_page_contents`
--

LOCK TABLES `front_cms_page_contents` WRITE;
/*!40000 ALTER TABLE `front_cms_page_contents` DISABLE KEYS */;
/*!40000 ALTER TABLE `front_cms_page_contents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `front_cms_pages`
--

DROP TABLE IF EXISTS `front_cms_pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `front_cms_pages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `page_type` varchar(10) NOT NULL DEFAULT 'manual',
  `is_homepage` int(11) DEFAULT 0,
  `title` varchar(250) DEFAULT NULL,
  `url` varchar(250) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `slug` varchar(200) DEFAULT NULL,
  `meta_title` mediumtext DEFAULT NULL,
  `meta_description` mediumtext DEFAULT NULL,
  `meta_keyword` mediumtext DEFAULT NULL,
  `feature_image` varchar(200) NOT NULL,
  `description` longtext DEFAULT NULL,
  `publish_date` date DEFAULT NULL,
  `publish` int(11) DEFAULT 0,
  `sidebar` int(11) DEFAULT 0,
  `is_active` varchar(10) DEFAULT 'no',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `front_cms_pages`
--

LOCK TABLES `front_cms_pages` WRITE;
/*!40000 ALTER TABLE `front_cms_pages` DISABLE KEYS */;
INSERT INTO `front_cms_pages` VALUES (1,'default',1,'Home page first new','page/home-page-first-new','page','home-page-first-new','','','','','<p>Home page first</p>','0000-00-00',1,1,'no','2021-09-28 15:49:10'),(2,'default',0,'Complain','page/complain','page','complain','Complain form','                                                                                                                                                                                    complain form                                                                                                                                                                                                                                ','complain form','','<div class=\"col-md-12 col-sm-12\">\r\n<h2 class=\"text-center\">&nbsp;</h2>\r\n\r\n<p class=\"text-center\">[form-builder:complain]</p>\r\n</div>','0000-00-00',1,1,'no','2019-01-24 03:00:12'),(3,'default',0,'404 page','page/404-page','page','404-page','','                                ','','','<title></title>\r\n<p>404 page found</p>','0000-00-00',0,NULL,'no','2021-09-24 11:35:15'),(4,'default',0,'Contact us','page/contact-us','page','contact-us','','','','','<p>[form-builder:contact_us]</p>','0000-00-00',0,NULL,'no','2021-09-24 06:27:54'),(5,'manual',0,'our-appointment','page/our-appointment','page','our-appointment','','','','','<form action=\"welcome/appointment\" method=\"get\">First name: <input name=\"fname\" type=\"text\" /><br />\r\nLast name: <input name=\"lname\" type=\"text\" /><br />\r\n<input type=\"submit\" value=\"Submit\" />&nbsp;</form>','0000-00-00',0,1,'no','2021-09-24 11:35:25');
/*!40000 ALTER TABLE `front_cms_pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `front_cms_program_photos`
--

DROP TABLE IF EXISTS `front_cms_program_photos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `front_cms_program_photos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `program_id` int(11) DEFAULT NULL,
  `media_gallery_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `program_id` (`program_id`),
  CONSTRAINT `front_cms_program_photos_ibfk_1` FOREIGN KEY (`program_id`) REFERENCES `front_cms_programs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `front_cms_program_photos`
--

LOCK TABLES `front_cms_program_photos` WRITE;
/*!40000 ALTER TABLE `front_cms_program_photos` DISABLE KEYS */;
/*!40000 ALTER TABLE `front_cms_program_photos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `front_cms_programs`
--

DROP TABLE IF EXISTS `front_cms_programs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `front_cms_programs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `url` mediumtext DEFAULT NULL,
  `title` varchar(200) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `event_start` date DEFAULT NULL,
  `event_end` date DEFAULT NULL,
  `event_venue` mediumtext DEFAULT NULL,
  `description` mediumtext DEFAULT NULL,
  `is_active` varchar(10) DEFAULT 'no',
  `meta_title` mediumtext DEFAULT NULL,
  `meta_description` mediumtext DEFAULT NULL,
  `meta_keyword` mediumtext DEFAULT NULL,
  `feature_image` text DEFAULT NULL,
  `publish_date` date DEFAULT NULL,
  `publish` varchar(10) NOT NULL DEFAULT '0',
  `sidebar` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `front_cms_programs`
--

LOCK TABLES `front_cms_programs` WRITE;
/*!40000 ALTER TABLE `front_cms_programs` DISABLE KEYS */;
/*!40000 ALTER TABLE `front_cms_programs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `front_cms_settings`
--

DROP TABLE IF EXISTS `front_cms_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `front_cms_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `theme` varchar(50) DEFAULT NULL,
  `is_active_rtl` int(11) DEFAULT 0,
  `is_active_front_cms` int(11) DEFAULT 0,
  `is_active_online_appointment` int(11) DEFAULT NULL,
  `is_active_sidebar` int(11) DEFAULT 0,
  `logo` text DEFAULT NULL,
  `contact_us_email` varchar(100) DEFAULT NULL,
  `complain_form_email` varchar(100) DEFAULT NULL,
  `sidebar_options` mediumtext DEFAULT NULL,
  `fb_url` varchar(200) NOT NULL,
  `twitter_url` varchar(200) NOT NULL,
  `youtube_url` varchar(200) NOT NULL,
  `google_plus` varchar(200) NOT NULL,
  `instagram_url` varchar(200) NOT NULL,
  `pinterest_url` varchar(200) NOT NULL,
  `linkedin_url` varchar(200) NOT NULL,
  `google_analytics` mediumtext DEFAULT NULL,
  `footer_text` varchar(500) DEFAULT NULL,
  `fav_icon` varchar(250) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `front_cms_settings`
--

LOCK TABLES `front_cms_settings` WRITE;
/*!40000 ALTER TABLE `front_cms_settings` DISABLE KEYS */;
INSERT INTO `front_cms_settings` VALUES (1,'sky_blue',1,1,1,1,'','','','[\"news\",\"complain\"]','','','','','','','','','','','2026-11-05 14:25:43');
/*!40000 ALTER TABLE `front_cms_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gateway_ins`
--

DROP TABLE IF EXISTS `gateway_ins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gateway_ins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `online_appointment_id` int(11) DEFAULT NULL,
  `type` varchar(30) NOT NULL COMMENT 'patient_bill,appointment	',
  `gateway_name` varchar(50) NOT NULL,
  `module_type` varchar(255) NOT NULL,
  `unique_id` varchar(255) NOT NULL,
  `parameter_details` mediumtext NOT NULL,
  `payment_status` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `index_type` (`type`),
  KEY `index_gateway_name` (`gateway_name`),
  KEY `index_module_type` (`module_type`),
  KEY `index_unique_id` (`unique_id`),
  KEY `online_appointment_id` (`online_appointment_id`),
  CONSTRAINT `gateway_ins_ibfk_1` FOREIGN KEY (`online_appointment_id`) REFERENCES `appointment` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gateway_ins`
--

LOCK TABLES `gateway_ins` WRITE;
/*!40000 ALTER TABLE `gateway_ins` DISABLE KEYS */;
/*!40000 ALTER TABLE `gateway_ins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gateway_ins_response`
--

DROP TABLE IF EXISTS `gateway_ins_response`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gateway_ins_response` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gateway_ins_id` int(11) DEFAULT NULL,
  `posted_data` text DEFAULT NULL,
  `response` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `gateway_ins_id` (`gateway_ins_id`),
  CONSTRAINT `gateway_ins_response_ibfk_1` FOREIGN KEY (`gateway_ins_id`) REFERENCES `gateway_ins` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gateway_ins_response`
--

LOCK TABLES `gateway_ins_response` WRITE;
/*!40000 ALTER TABLE `gateway_ins_response` DISABLE KEYS */;
/*!40000 ALTER TABLE `gateway_ins_response` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `general_calls`
--

DROP TABLE IF EXISTS `general_calls`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `general_calls` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `contact` varchar(12) NOT NULL,
  `date` date NOT NULL,
  `description` text DEFAULT NULL,
  `follow_up_date` date DEFAULT NULL,
  `call_duration` varchar(50) NOT NULL,
  `note` mediumtext DEFAULT NULL,
  `call_type` varchar(20) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `index_name` (`name`),
  KEY `index_contact` (`contact`),
  KEY `index_date` (`date`),
  KEY `index_call_duration` (`call_duration`),
  KEY `index_follow_up_date` (`follow_up_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `general_calls`
--

LOCK TABLES `general_calls` WRITE;
/*!40000 ALTER TABLE `general_calls` DISABLE KEYS */;
/*!40000 ALTER TABLE `general_calls` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `global_shift`
--

DROP TABLE IF EXISTS `global_shift`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `global_shift` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(250) NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `index_name` (`name`),
  KEY `index_start_time` (`start_time`),
  KEY `index_end_time` (`end_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `global_shift`
--

LOCK TABLES `global_shift` WRITE;
/*!40000 ALTER TABLE `global_shift` DISABLE KEYS */;
/*!40000 ALTER TABLE `global_shift` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gynaecology`
--

DROP TABLE IF EXISTS `gynaecology`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gynaecology` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `height` varchar(20) DEFAULT NULL,
  `weight` varchar(20) DEFAULT NULL,
  `bp` varchar(20) DEFAULT NULL,
  `symptoms` text DEFAULT NULL,
  `note` text DEFAULT NULL,
  `gynaecologist_id` int(11) NOT NULL,
  `consultation_date` datetime NOT NULL,
  `diagnosis` text DEFAULT NULL,
  `lmp` date DEFAULT NULL,
  `pregnancy_status` varchar(50) DEFAULT NULL,
  `pregnancy_history` text DEFAULT NULL,
  `clinical_notes` text DEFAULT NULL,
  `prescription_treatment` text DEFAULT NULL,
  `organisation_id` int(11) DEFAULT NULL,
  `charge_id` int(11) DEFAULT NULL,
  `standard_charge` float(10,2) DEFAULT 0.00,
  `apply_charge` float(10,2) DEFAULT 0.00,
  `generated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `patient_id` (`patient_id`),
  KEY `gynaecologist_id` (`gynaecologist_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gynaecology`
--

LOCK TABLES `gynaecology` WRITE;
/*!40000 ALTER TABLE `gynaecology` DISABLE KEYS */;
INSERT INTO `gynaecology` VALUES (1,'GYNB1',1,'165 cm','62 kg','115/75','Mild morning sickness, routine antenatal checkup','Follow up in 4 weeks for anomaly scan.',1,'2026-08-11 13:17:00','Intrauterine Single Pregnancy at 12 Weeks','1970-01-01','Pregnant','Gravida 2, Para 1, Living 1, Abortions 0 (G2P1L1A0). Previous spontaneous vaginal delivery.','Uterus 12 weeks size, fetal heart sounds heard on Doppler, no spotting or abdominal tenderness.','Folic acid 5mg daily, Prenatal multivitamins, routine 1st trimester ultrasound scheduled.',NULL,NULL,75.00,75.00,1,'2026-11-08 12:17:50');
/*!40000 ALTER TABLE `gynaecology` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gynaecology_instructions`
--

DROP TABLE IF EXISTS `gynaecology_instructions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gynaecology_instructions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gynaecology_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `doctor_id` int(11) NOT NULL,
  `instruction` text NOT NULL,
  `date` datetime NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `gynaecology_id` (`gynaecology_id`),
  KEY `patient_id` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gynaecology_instructions`
--

LOCK TABLES `gynaecology_instructions` WRITE;
/*!40000 ALTER TABLE `gynaecology_instructions` DISABLE KEYS */;
/*!40000 ALTER TABLE `gynaecology_instructions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `income`
--

DROP TABLE IF EXISTS `income`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `income` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `inc_head_id` int(11) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `invoice_no` varchar(200) NOT NULL,
  `date` date DEFAULT NULL,
  `amount` float(10,2) DEFAULT 0.00,
  `note` text DEFAULT NULL,
  `is_deleted` varchar(10) DEFAULT 'no',
  `documents` text DEFAULT NULL,
  `generated_by` int(11) DEFAULT NULL,
  `is_active` varchar(10) DEFAULT 'yes',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `inc_head_id` (`inc_head_id`),
  KEY `generated_by` (`generated_by`),
  KEY `index_name` (`name`),
  KEY `index_invoice_no` (`invoice_no`),
  KEY `index_date` (`date`),
  KEY `index_amount` (`amount`),
  CONSTRAINT `income_ibfk_1` FOREIGN KEY (`inc_head_id`) REFERENCES `income_head` (`id`) ON DELETE CASCADE,
  CONSTRAINT `income_ibfk_2` FOREIGN KEY (`generated_by`) REFERENCES `staff` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `income`
--

LOCK TABLES `income` WRITE;
/*!40000 ALTER TABLE `income` DISABLE KEYS */;
/*!40000 ALTER TABLE `income` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `income_head`
--

DROP TABLE IF EXISTS `income_head`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `income_head` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `income_category` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `is_active` varchar(10) NOT NULL DEFAULT 'yes',
  `is_deleted` varchar(10) NOT NULL DEFAULT 'no',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `index_income_category` (`income_category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `income_head`
--

LOCK TABLES `income_head` WRITE;
/*!40000 ALTER TABLE `income_head` DISABLE KEYS */;
/*!40000 ALTER TABLE `income_head` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ipd_details`
--

DROP TABLE IF EXISTS `ipd_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ipd_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) DEFAULT NULL,
  `case_reference_id` int(11) DEFAULT NULL,
  `height` varchar(5) DEFAULT NULL,
  `weight` varchar(5) DEFAULT NULL,
  `pulse` varchar(200) NOT NULL,
  `temperature` varchar(200) NOT NULL,
  `respiration` varchar(200) NOT NULL,
  `bp` varchar(20) DEFAULT NULL,
  `bed` int(11) DEFAULT NULL,
  `bed_group_id` int(11) DEFAULT NULL,
  `case_type` varchar(100) NOT NULL,
  `casualty` varchar(100) NOT NULL,
  `symptoms` longtext NOT NULL,
  `known_allergies` varchar(200) DEFAULT NULL,
  `patient_old` varchar(50) NOT NULL,
  `note` text DEFAULT NULL,
  `refference` varchar(200) NOT NULL,
  `cons_doctor` int(11) DEFAULT NULL,
  `organisation_id` int(11) DEFAULT NULL,
  `credit_limit` varchar(100) NOT NULL,
  `payment_mode` varchar(100) NOT NULL,
  `date` datetime DEFAULT NULL,
  `discharged` varchar(200) NOT NULL,
  `live_consult` varchar(50) DEFAULT NULL,
  `generated_by` int(11) DEFAULT NULL,
  `is_antenatal` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `patient_id` (`patient_id`),
  KEY `case_reference_id` (`case_reference_id`),
  KEY `cons_doctor` (`cons_doctor`),
  KEY `bed_group_id` (`bed_group_id`),
  KEY `bed` (`bed`),
  CONSTRAINT `ipd_details_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ipd_details_ibfk_2` FOREIGN KEY (`case_reference_id`) REFERENCES `case_references` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ipd_details_ibfk_3` FOREIGN KEY (`case_reference_id`) REFERENCES `case_references` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ipd_details_ibfk_4` FOREIGN KEY (`cons_doctor`) REFERENCES `staff` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ipd_details_ibfk_5` FOREIGN KEY (`bed_group_id`) REFERENCES `bed_group` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ipd_details_ibfk_6` FOREIGN KEY (`bed`) REFERENCES `bed` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ipd_details`
--

LOCK TABLES `ipd_details` WRITE;
/*!40000 ALTER TABLE `ipd_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `ipd_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ipd_doctors`
--

DROP TABLE IF EXISTS `ipd_doctors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ipd_doctors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ipd_id` int(11) NOT NULL,
  `consult_doctor` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `ipd_id` (`ipd_id`),
  KEY `consult_doctor` (`consult_doctor`),
  CONSTRAINT `ipd_doctors_ibfk_1` FOREIGN KEY (`ipd_id`) REFERENCES `ipd_details` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ipd_doctors_ibfk_2` FOREIGN KEY (`consult_doctor`) REFERENCES `staff` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ipd_doctors`
--

LOCK TABLES `ipd_doctors` WRITE;
/*!40000 ALTER TABLE `ipd_doctors` DISABLE KEYS */;
/*!40000 ALTER TABLE `ipd_doctors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ipd_prescription_basic`
--

DROP TABLE IF EXISTS `ipd_prescription_basic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ipd_prescription_basic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ipd_id` int(11) DEFAULT NULL,
  `visit_details_id` int(11) DEFAULT NULL,
  `attachment` text NOT NULL,
  `attachment_name` text NOT NULL,
  `header_note` text DEFAULT NULL,
  `footer_note` text DEFAULT NULL,
  `finding_description` text DEFAULT NULL,
  `is_finding_print` varchar(100) DEFAULT NULL,
  `date` date NOT NULL,
  `generated_by` int(11) DEFAULT NULL,
  `prescribe_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `ipd_id` (`ipd_id`),
  KEY `visit_details_id` (`visit_details_id`),
  KEY `generated_by` (`generated_by`),
  KEY `index_date` (`date`),
  KEY `prescribe_by` (`prescribe_by`),
  CONSTRAINT `ipd_prescription_basic_ibfk_1` FOREIGN KEY (`ipd_id`) REFERENCES `ipd_details` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ipd_prescription_basic_ibfk_2` FOREIGN KEY (`visit_details_id`) REFERENCES `visit_details` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ipd_prescription_basic_ibfk_3` FOREIGN KEY (`generated_by`) REFERENCES `staff` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ipd_prescription_basic_ibfk_4` FOREIGN KEY (`prescribe_by`) REFERENCES `staff` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ipd_prescription_basic`
--

LOCK TABLES `ipd_prescription_basic` WRITE;
/*!40000 ALTER TABLE `ipd_prescription_basic` DISABLE KEYS */;
/*!40000 ALTER TABLE `ipd_prescription_basic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ipd_prescription_details`
--

DROP TABLE IF EXISTS `ipd_prescription_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ipd_prescription_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `basic_id` int(11) DEFAULT NULL,
  `pharmacy_id` int(11) DEFAULT NULL,
  `dosage` int(11) DEFAULT NULL,
  `dose_interval_id` int(11) DEFAULT NULL,
  `dose_duration_id` int(11) DEFAULT NULL,
  `instruction` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `basic_id` (`basic_id`),
  KEY `pharmacy_id` (`pharmacy_id`),
  KEY `index_dosage` (`dosage`),
  KEY `index_dose_interval_id` (`dose_interval_id`),
  KEY `index_dose_duration_id` (`dose_duration_id`),
  CONSTRAINT `ipd_prescription_details_ibfk_1` FOREIGN KEY (`basic_id`) REFERENCES `ipd_prescription_basic` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ipd_prescription_details_ibfk_2` FOREIGN KEY (`pharmacy_id`) REFERENCES `pharmacy` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ipd_prescription_details_ibfk_3` FOREIGN KEY (`dose_interval_id`) REFERENCES `dose_interval` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ipd_prescription_details_ibfk_4` FOREIGN KEY (`dose_duration_id`) REFERENCES `dose_interval` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ipd_prescription_details`
--

LOCK TABLES `ipd_prescription_details` WRITE;
/*!40000 ALTER TABLE `ipd_prescription_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `ipd_prescription_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ipd_prescription_test`
--

DROP TABLE IF EXISTS `ipd_prescription_test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ipd_prescription_test` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ipd_prescription_basic_id` int(11) DEFAULT NULL,
  `pathology_id` int(11) DEFAULT NULL,
  `radiology_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `ipd_prescription_basic_id` (`ipd_prescription_basic_id`),
  KEY `pathology_id` (`pathology_id`),
  KEY `radiology_id` (`radiology_id`),
  CONSTRAINT `ipd_prescription_test_ibfk_1` FOREIGN KEY (`ipd_prescription_basic_id`) REFERENCES `ipd_prescription_basic` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ipd_prescription_test_ibfk_2` FOREIGN KEY (`pathology_id`) REFERENCES `pathology` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ipd_prescription_test_ibfk_3` FOREIGN KEY (`radiology_id`) REFERENCES `radio` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ipd_prescription_test`
--

LOCK TABLES `ipd_prescription_test` WRITE;
/*!40000 ALTER TABLE `ipd_prescription_test` DISABLE KEYS */;
/*!40000 ALTER TABLE `ipd_prescription_test` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item`
--

DROP TABLE IF EXISTS `item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_category_id` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `unit` varchar(200) NOT NULL,
  `item_photo` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `date` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `item_category_id` (`item_category_id`),
  KEY `index_name` (`name`),
  KEY `index_unit` (`unit`),
  KEY `index_quantity` (`quantity`),
  KEY `index_date` (`date`),
  CONSTRAINT `item_ibfk_1` FOREIGN KEY (`item_category_id`) REFERENCES `item_category` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item`
--

LOCK TABLES `item` WRITE;
/*!40000 ALTER TABLE `item` DISABLE KEYS */;
/*!40000 ALTER TABLE `item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_category`
--

DROP TABLE IF EXISTS `item_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_category` varchar(255) DEFAULT NULL,
  `is_active` varchar(10) NOT NULL DEFAULT 'yes',
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `index_item_category` (`item_category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_category`
--

LOCK TABLES `item_category` WRITE;
/*!40000 ALTER TABLE `item_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_issue`
--

DROP TABLE IF EXISTS `item_issue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_issue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `issue_type` int(11) DEFAULT NULL,
  `issue_to` int(11) DEFAULT NULL,
  `issue_by` varchar(100) DEFAULT NULL,
  `issue_date` date DEFAULT NULL,
  `return_date` date DEFAULT NULL,
  `item_category_id` int(11) DEFAULT NULL,
  `item_id` int(11) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `note` text DEFAULT NULL,
  `is_returned` int(11) NOT NULL DEFAULT 1,
  `is_active` varchar(10) DEFAULT 'no',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `item_id` (`item_id`),
  KEY `item_category_id` (`item_category_id`),
  KEY `issue_to` (`issue_to`),
  KEY `index_issue_date` (`issue_date`),
  KEY `index_return_date` (`return_date`),
  KEY `index_quantity` (`quantity`),
  KEY `index_is_returned` (`is_returned`),
  CONSTRAINT `item_issue_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`) ON DELETE CASCADE,
  CONSTRAINT `item_issue_ibfk_2` FOREIGN KEY (`item_category_id`) REFERENCES `item_category` (`id`) ON DELETE CASCADE,
  CONSTRAINT `item_issue_ibfk_3` FOREIGN KEY (`issue_to`) REFERENCES `staff` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_issue`
--

LOCK TABLES `item_issue` WRITE;
/*!40000 ALTER TABLE `item_issue` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_issue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_stock`
--

DROP TABLE IF EXISTS `item_stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_stock` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` int(11) DEFAULT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `symbol` varchar(10) NOT NULL DEFAULT '+',
  `store_id` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `purchase_price` float(10,2) DEFAULT 0.00,
  `date` date DEFAULT NULL,
  `attachment` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `is_active` varchar(10) DEFAULT 'yes',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `item_id` (`item_id`),
  KEY `supplier_id` (`supplier_id`),
  KEY `store_id` (`store_id`),
  KEY `index_quantity` (`quantity`),
  KEY `index_purchase_price` (`purchase_price`),
  KEY `index_date` (`date`),
  CONSTRAINT `item_stock_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`) ON DELETE CASCADE,
  CONSTRAINT `item_stock_ibfk_2` FOREIGN KEY (`supplier_id`) REFERENCES `item_supplier` (`id`) ON DELETE CASCADE,
  CONSTRAINT `item_stock_ibfk_3` FOREIGN KEY (`store_id`) REFERENCES `item_store` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_stock`
--

LOCK TABLES `item_stock` WRITE;
/*!40000 ALTER TABLE `item_stock` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_store`
--

DROP TABLE IF EXISTS `item_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_store` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_store` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `index_item_store` (`item_store`),
  KEY `index_code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_store`
--

LOCK TABLES `item_store` WRITE;
/*!40000 ALTER TABLE `item_store` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_store` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_supplier`
--

DROP TABLE IF EXISTS `item_supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_supplier` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_supplier` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `contact_person_name` varchar(255) NOT NULL,
  `contact_person_phone` varchar(255) NOT NULL,
  `contact_person_email` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `index_item_supplier` (`item_supplier`),
  KEY `index_phone` (`phone`),
  KEY `index_email` (`email`),
  KEY `index_address` (`address`),
  KEY `index_contact_person_name` (`contact_person_name`),
  KEY `index_contact_person_phone` (`contact_person_phone`),
  KEY `index_contact_person_email` (`contact_person_email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_supplier`
--

LOCK TABLES `item_supplier` WRITE;
/*!40000 ALTER TABLE `item_supplier` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_supplier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lab`
--

DROP TABLE IF EXISTS `lab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lab` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lab_name` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lab`
--

LOCK TABLES `lab` WRITE;
/*!40000 ALTER TABLE `lab` DISABLE KEYS */;
/*!40000 ALTER TABLE `lab` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `languages`
--

DROP TABLE IF EXISTS `languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `languages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language` varchar(50) DEFAULT NULL,
  `short_code` varchar(255) NOT NULL,
  `country_code` varchar(255) NOT NULL,
  `is_deleted` varchar(10) NOT NULL DEFAULT 'yes',
  `is_rtl` varchar(10) NOT NULL DEFAULT 'no',
  `is_active` varchar(255) DEFAULT 'no',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_at` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_language` (`language`),
  KEY `index_short_code` (`short_code`),
  KEY `index_country_code` (`country_code`),
  KEY `index_is_deleted` (`is_deleted`),
  KEY `index_is_rtl` (`is_rtl`)
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `languages`
--

LOCK TABLES `languages` WRITE;
/*!40000 ALTER TABLE `languages` DISABLE KEYS */;
INSERT INTO `languages` VALUES (1,'Azerbaijan','az','az','no','no','no','2021-09-28 09:51:22',NULL),(2,'Albanian','sq','al','no','no','no','2021-09-28 10:08:10',NULL),(3,'Amharic','am','am','no','no','no','2021-09-28 09:50:47',NULL),(4,'English','en','us','no','no','no','2021-09-16 05:20:47',NULL),(5,'Arabic','ar','sa','no','no','no','2021-09-28 09:50:48',NULL),(6,'Afrikaans','af','af','no','no','no','2021-09-28 10:51:19',NULL),(7,'Basque','eu','es','no','no','no','2021-09-24 06:58:21',NULL),(8,'Bengali','bn','in','no','no','no','2021-09-24 06:58:25',NULL),(9,'Bosnian','bs','bs','no','no','no','2021-09-24 06:58:28',NULL),(10,'Welsh','cy','cy','no','no','no','2021-09-24 06:58:31',NULL),(11,'Hungarian','hu','hu','no','no','no','2021-09-24 06:58:35',NULL),(12,'Vietnamese','vi','vi','no','no','no','2021-09-24 06:58:39',NULL),(13,'Haitian','ht','ht','no','no','no','2021-09-24 06:58:43',NULL),(14,'Galician','gl','gl','no','no','no','2021-09-24 06:58:47',NULL),(15,'Dutch','nl','nl','no','no','no','2021-09-24 06:58:51',NULL),(16,'Greek','el','gr','no','no','no','2021-09-24 06:58:53',NULL),(17,'Georgian','ka','ge','no','no','no','2021-09-24 06:58:56',NULL),(18,'Gujarati','gu','in','no','no','no','2021-09-24 06:58:59',NULL),(19,'Danish','da','dk','no','no','no','2021-09-24 06:59:01',NULL),(20,'Hebrew','he','il','no','no','no','2021-09-24 06:59:04',NULL),(21,'Yiddish','yi','il','no','no','no','2021-09-24 06:59:07',NULL),(22,'Indonesian','id','id','no','no','no','2021-09-24 06:59:10',NULL),(23,'Irish','ga','ga','no','no','no','2021-09-24 06:59:14',NULL),(24,'Italian','it','it','no','no','no','2021-09-24 06:59:17',NULL),(25,'Icelandic','is','is','no','no','no','2021-09-24 06:59:20',NULL),(26,'Spanish','es','es','no','no','no','2021-09-24 06:59:29',NULL),(27,'Kannada','kn','kn','no','no','no','2021-09-24 06:59:32',NULL),(28,'Catalan','ca','ca','no','no','no','2021-09-24 06:59:34',NULL),(29,'Chinese','zh','cn','no','no','no','2021-09-24 06:59:36',NULL),(30,'Korean','ko','kr','no','no','no','2021-09-24 06:59:39',NULL),(31,'Xhosa','xh','ls','no','no','no','2021-09-24 06:59:42',NULL),(32,'Latin','la','la','no','no','no','2021-09-24 06:59:45',NULL),(33,'Latvian','lv','lv','no','no','no','2021-09-24 06:59:47',NULL),(34,'Lithuanian','lt','lt','no','no','no','2021-09-24 06:59:50',NULL),(35,'Malagasy','mg','mg','no','no','no','2021-09-24 06:59:52',NULL),(36,'Malay','ms','ms','no','no','no','2021-09-24 07:00:01',NULL),(37,'Malayalam','ml','ml','no','no','no','2021-09-24 07:00:05',NULL),(38,'Maltese','mt','mt','no','no','no','2021-09-24 07:00:26',NULL),(39,'Macedonian','mk','mk','no','no','no','2021-09-24 07:00:41',NULL),(40,'Maori','mi','nz','no','no','no','2021-09-24 07:00:44',NULL),(41,'Marathi','mr','in','no','no','no','2021-09-24 07:00:51',NULL),(42,'Mongolian','mn','mn','no','no','no','2021-09-24 07:01:15',NULL),(43,'German','de','de','no','no','no','2021-09-24 07:01:18',NULL),(44,'Nepali','ne','ne','no','no','no','2021-09-24 07:01:21',NULL),(45,'Norwegian','no','no','no','no','no','2021-09-24 07:01:41',NULL),(46,'Punjabi','pa','in','no','no','no','2021-09-24 07:01:43',NULL),(47,'Persian','fa','ir','no','no','no','2021-09-24 07:01:49',NULL),(48,'Portuguese','pt','pt','no','no','no','2021-09-24 07:01:52',NULL),(49,'Romanian','ro','ro','no','no','no','2021-09-24 07:01:56',NULL),(50,'Russian','ru','ru','no','no','no','2021-09-24 07:01:59',NULL),(51,'Cebuano','ceb','ph','no','no','no','2021-09-24 07:02:02',NULL),(52,'Sinhala','si','si','no','no','no','2021-09-24 07:02:04',NULL),(53,'Slovakian','sk','sk','no','no','no','2021-09-24 07:02:07',NULL),(54,'Slovenian','sl','sl','no','no','no','2021-09-24 07:02:10',NULL),(55,'Swahili','sw','ke','no','no','no','2021-09-24 07:02:12',NULL),(56,'Sundanese','su','sd','no','no','no','2021-09-24 07:02:15',NULL),(57,'Thai','th','th','no','no','no','2021-09-24 07:02:18',NULL),(58,'Tagalog','tl','tl','no','no','no','2021-09-24 07:02:21',NULL),(59,'Tamil','ta','in','no','no','no','2021-09-24 07:02:23',NULL),(60,'Telugu','te','in','no','no','no','2021-09-24 07:02:26',NULL),(61,'Turkish','tr','tr','no','no','no','2021-09-24 07:02:29',NULL),(62,'Uzbek','uz','uz','no','no','no','2021-09-24 07:02:31',NULL),(63,'Urdu','ur','pk','no','no','no','2021-09-24 07:02:34',NULL),(64,'Finnish','fi','fi','no','no','no','2021-09-24 07:02:37',NULL),(65,'French','fr','fr','no','no','no','2021-09-24 07:02:39',NULL),(66,'Hindi','hi','in','no','no','no','2021-09-24 07:02:41',NULL),(67,'Czech','cs','cz','no','no','no','2021-09-24 07:02:44',NULL),(68,'Swedish','sv','sv','no','no','no','2021-09-24 07:02:46',NULL),(69,'Scottish','gd','gd','no','no','no','2021-09-24 07:02:49',NULL),(70,'Estonian','et','et','no','no','no','2021-09-24 07:02:52',NULL),(71,'Esperanto','eo','br','no','no','no','2021-09-24 07:02:55',NULL),(72,'Javanese','jv','id','no','no','no','2021-09-24 07:02:58',NULL),(73,'Japanese','ja','jp','no','no','no','2021-09-24 07:03:01',NULL),(74,'Polish','pl','pl','no','no','no','2021-09-28 06:39:06',NULL),(75,'Croatia','hr','hr','no','no','no','2021-10-25 07:56:41',NULL),(76,'Kurdish','ku','iq','no','no','no','2021-10-25 07:56:44',NULL),(77,'Lao','lo','la','no','no','no','2021-10-25 07:56:47',NULL);
/*!40000 ALTER TABLE `languages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `leave_types`
--

DROP TABLE IF EXISTS `leave_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `leave_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(200) NOT NULL,
  `is_active` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `leave_types`
--

LOCK TABLES `leave_types` WRITE;
/*!40000 ALTER TABLE `leave_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `leave_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logs`
--

DROP TABLE IF EXISTS `logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message` text DEFAULT NULL,
  `record_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `action` varchar(50) NOT NULL,
  `ip_address` varchar(50) NOT NULL,
  `platform` varchar(50) NOT NULL,
  `agent` varchar(50) NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_at` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logs`
--

LOCK TABLES `logs` WRITE;
/*!40000 ALTER TABLE `logs` DISABLE KEYS */;
INSERT INTO `logs` VALUES (1,'Record updated On Settings id 1',1,0,'Update','::1','Windows 10','Chrome 156.0.0.0','2026-11-05 09:24:19','2026-11-05'),(2,'Record updated On Front Cms Settings id 1',1,0,'Update','::1','Windows 10','Chrome 156.0.0.0','2026-11-05 09:25:43','2026-11-05'),(3,'New Record inserted On Patient id 1',1,0,'Insert','::1','Windows 10','Chrome 156.0.0.0','2026-11-05 10:40:09','2026-11-05'),(4,'Record updated On Patient id 1',1,0,'Update','::1','Windows 10','Chrome 156.0.0.0','2026-11-05 10:40:09','2026-11-05'),(5,'Record updated For Staff id 2',2,0,'Update','::1','Windows 10','Chrome 156.0.0.0','2026-11-05 10:41:50','2026-11-05'),(6,'New Record inserted On operation_category id 1',1,0,'Insert','::1','Windows 10','Chrome 156.0.0.0','2026-11-05 10:50:47','2026-11-05'),(7,'New Record inserted On Operation id 1',1,0,'Insert','::1','Windows 10','Chrome 156.0.0.0','2026-11-05 10:50:57','2026-11-05');
/*!40000 ALTER TABLE `logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medication_report`
--

DROP TABLE IF EXISTS `medication_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `medication_report` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `medicine_dosage_id` int(11) DEFAULT NULL,
  `pharmacy_id` int(11) DEFAULT NULL,
  `opd_details_id` int(11) DEFAULT NULL,
  `ipd_id` int(11) DEFAULT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL,
  `remark` text DEFAULT NULL,
  `generated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `generated_by` (`generated_by`),
  KEY `pharmacy_id` (`pharmacy_id`),
  KEY `ipd_id` (`ipd_id`),
  KEY `medicine_dosage_id` (`medicine_dosage_id`),
  KEY `opd_details_id` (`opd_details_id`),
  KEY `index_date` (`date`),
  KEY `index_time` (`time`),
  CONSTRAINT `medication_report_ibfk_1` FOREIGN KEY (`generated_by`) REFERENCES `staff` (`id`) ON DELETE CASCADE,
  CONSTRAINT `medication_report_ibfk_2` FOREIGN KEY (`pharmacy_id`) REFERENCES `pharmacy` (`id`) ON DELETE CASCADE,
  CONSTRAINT `medication_report_ibfk_3` FOREIGN KEY (`ipd_id`) REFERENCES `ipd_details` (`id`) ON DELETE CASCADE,
  CONSTRAINT `medication_report_ibfk_4` FOREIGN KEY (`medicine_dosage_id`) REFERENCES `medicine_dosage` (`id`) ON DELETE CASCADE,
  CONSTRAINT `medication_report_ibfk_5` FOREIGN KEY (`opd_details_id`) REFERENCES `opd_details` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medication_report`
--

LOCK TABLES `medication_report` WRITE;
/*!40000 ALTER TABLE `medication_report` DISABLE KEYS */;
/*!40000 ALTER TABLE `medication_report` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medicine_bad_stock`
--

DROP TABLE IF EXISTS `medicine_bad_stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `medicine_bad_stock` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `medicine_batch_details_id` int(11) DEFAULT NULL,
  `pharmacy_id` int(11) DEFAULT NULL,
  `outward_date` date NOT NULL,
  `expiry_date` date NOT NULL,
  `batch_no` varchar(100) NOT NULL,
  `quantity` varchar(20) NOT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `pharmacy_id` (`pharmacy_id`),
  KEY `medicine_batch_details_id` (`medicine_batch_details_id`),
  KEY `index_outward_date` (`outward_date`),
  KEY `index_expiry_date` (`expiry_date`),
  KEY `index_batch_no` (`batch_no`),
  KEY `index_quantity` (`quantity`),
  CONSTRAINT `medicine_bad_stock_ibfk_1` FOREIGN KEY (`pharmacy_id`) REFERENCES `pharmacy` (`id`) ON DELETE CASCADE,
  CONSTRAINT `medicine_bad_stock_ibfk_2` FOREIGN KEY (`medicine_batch_details_id`) REFERENCES `medicine_batch_details` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medicine_bad_stock`
--

LOCK TABLES `medicine_bad_stock` WRITE;
/*!40000 ALTER TABLE `medicine_bad_stock` DISABLE KEYS */;
/*!40000 ALTER TABLE `medicine_bad_stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medicine_batch_details`
--

DROP TABLE IF EXISTS `medicine_batch_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `medicine_batch_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `supplier_bill_basic_id` int(11) DEFAULT NULL,
  `pharmacy_id` int(11) DEFAULT NULL,
  `inward_date` datetime NOT NULL,
  `expiry` date NOT NULL,
  `batch_no` varchar(100) NOT NULL,
  `packing_qty` varchar(100) NOT NULL,
  `purchase_rate_packing` varchar(100) NOT NULL,
  `quantity` varchar(200) NOT NULL,
  `mrp` float(10,2) DEFAULT 0.00,
  `purchase_price` float(10,2) DEFAULT 0.00,
  `tax` float(10,2) DEFAULT 0.00,
  `sale_rate` float(10,2) DEFAULT 0.00,
  `batch_amount` float(10,2) DEFAULT 0.00,
  `amount` float(10,2) DEFAULT 0.00,
  `available_quantity` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `supplier_bill_basic_id` (`supplier_bill_basic_id`),
  KEY `pharmacy_id` (`pharmacy_id`),
  KEY `index_inward_date` (`inward_date`),
  KEY `index_expiry` (`expiry`),
  KEY `index_batch_no` (`batch_no`),
  KEY `index_packing_qty` (`packing_qty`),
  KEY `index_purchase_rate_packing` (`purchase_rate_packing`),
  KEY `index_quantity` (`quantity`),
  KEY `index_mrp` (`mrp`),
  KEY `index_purchase_price` (`purchase_price`),
  KEY `index_tax` (`tax`),
  KEY `index_sale_rate` (`sale_rate`),
  KEY `index_batch_amount` (`batch_amount`),
  KEY `index_amount` (`amount`),
  KEY `index_available_quantity` (`available_quantity`),
  CONSTRAINT `medicine_batch_details_ibfk_1` FOREIGN KEY (`supplier_bill_basic_id`) REFERENCES `supplier_bill_basic` (`id`) ON DELETE CASCADE,
  CONSTRAINT `medicine_batch_details_ibfk_2` FOREIGN KEY (`pharmacy_id`) REFERENCES `pharmacy` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medicine_batch_details`
--

LOCK TABLES `medicine_batch_details` WRITE;
/*!40000 ALTER TABLE `medicine_batch_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `medicine_batch_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medicine_category`
--

DROP TABLE IF EXISTS `medicine_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `medicine_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `medicine_category` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `index_medicine_category` (`medicine_category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medicine_category`
--

LOCK TABLES `medicine_category` WRITE;
/*!40000 ALTER TABLE `medicine_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `medicine_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medicine_dosage`
--

DROP TABLE IF EXISTS `medicine_dosage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `medicine_dosage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `medicine_category_id` int(11) DEFAULT NULL,
  `dosage` varchar(100) NOT NULL,
  `units_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `medicine_category_id` (`medicine_category_id`),
  KEY `charge_units_id` (`units_id`),
  KEY `index_dosage` (`dosage`),
  CONSTRAINT `medicine_dosage_ibfk_1` FOREIGN KEY (`medicine_category_id`) REFERENCES `medicine_category` (`id`) ON DELETE CASCADE,
  CONSTRAINT `medicine_dosage_ibfk_2` FOREIGN KEY (`units_id`) REFERENCES `unit` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medicine_dosage`
--

LOCK TABLES `medicine_dosage` WRITE;
/*!40000 ALTER TABLE `medicine_dosage` DISABLE KEYS */;
/*!40000 ALTER TABLE `medicine_dosage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medicine_group`
--

DROP TABLE IF EXISTS `medicine_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `medicine_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_name` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `index_group_name` (`group_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medicine_group`
--

LOCK TABLES `medicine_group` WRITE;
/*!40000 ALTER TABLE `medicine_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `medicine_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medicine_supplier`
--

DROP TABLE IF EXISTS `medicine_supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `medicine_supplier` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `supplier` varchar(200) NOT NULL,
  `contact` varchar(200) NOT NULL,
  `supplier_person` varchar(200) NOT NULL,
  `supplier_person_contact` varchar(200) NOT NULL,
  `supplier_drug_licence` varchar(200) NOT NULL,
  `address` varchar(200) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `index_supplier` (`supplier`),
  KEY `index_contact` (`contact`),
  KEY `index_supplier_person` (`supplier_person`),
  KEY `index_supplier_person_contact` (`supplier_person_contact`),
  KEY `index_supplier_drug_licence` (`supplier_drug_licence`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medicine_supplier`
--

LOCK TABLES `medicine_supplier` WRITE;
/*!40000 ALTER TABLE `medicine_supplier` DISABLE KEYS */;
/*!40000 ALTER TABLE `medicine_supplier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) DEFAULT NULL,
  `template_id` varchar(100) NOT NULL,
  `message` text DEFAULT NULL,
  `send_mail` varchar(10) DEFAULT '0',
  `send_sms` varchar(10) DEFAULT '0',
  `is_group` varchar(10) DEFAULT '0',
  `is_individual` varchar(10) DEFAULT '0',
  `file` varchar(200) NOT NULL,
  `group_list` text DEFAULT NULL,
  `user_list` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `index_title` (`title`),
  KEY `index_send_mail` (`send_mail`),
  KEY `index_send_sms` (`send_sms`),
  KEY `index_is_group` (`is_group`),
  KEY `index_is_individual` (`is_individual`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `version` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification_roles`
--

DROP TABLE IF EXISTS `notification_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notification_roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `send_notification_id` int(11) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  `is_active` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `send_notification_id` (`send_notification_id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `notification_roles_ibfk_1` FOREIGN KEY (`send_notification_id`) REFERENCES `send_notification` (`id`) ON DELETE CASCADE,
  CONSTRAINT `notification_roles_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification_roles`
--

LOCK TABLES `notification_roles` WRITE;
/*!40000 ALTER TABLE `notification_roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `notification_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification_setting`
--

DROP TABLE IF EXISTS `notification_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notification_setting` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(100) DEFAULT NULL,
  `is_mail` int(11) DEFAULT 0,
  `is_sms` int(11) DEFAULT 0,
  `is_mobileapp` int(11) NOT NULL,
  `is_notification` int(11) NOT NULL,
  `display_notification` int(11) NOT NULL,
  `display_sms` int(11) NOT NULL,
  `template` longtext DEFAULT NULL,
  `template_id` varchar(100) NOT NULL,
  `subject` text DEFAULT NULL,
  `variables` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `index_type` (`type`),
  KEY `index_is_mail` (`is_mail`),
  KEY `index_is_sms` (`is_sms`),
  KEY `index_is_mobileapp` (`is_mobileapp`),
  KEY `index_is_notification` (`is_notification`),
  KEY `index_display_notification` (`display_notification`),
  KEY `index_display_sms` (`display_sms`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification_setting`
--

LOCK TABLES `notification_setting` WRITE;
/*!40000 ALTER TABLE `notification_setting` DISABLE KEYS */;
INSERT INTO `notification_setting` VALUES (1,'opd_patient_registration',1,0,1,1,1,1,'Dear {{patient_name}} your OPD Registration at SEFU is successful on date {{appointment_date}} with Patient Id {{patient_id}} and OPD No {{opdno}}','','OPD Patient','{{patient_name}} {{appointment_date}} {{patient_id}} {{opdno}}','2026-11-09 10:49:41'),(2,'ipd_patient_registration',1,0,0,0,1,1,'Dear {{patient_name}} your IPD Registration at SEFU is successful  with Patient Id {{patient_id}} and IPD No {{ipd_no}}','','IPD Patient Registration','{{patient_name}} {{patient_id}} {{ipd_no}}','2026-11-09 10:49:41'),(3,'ipd_patient_discharged',1,0,0,0,1,1,'IPD Patient {{patient_name}} is now discharged from SEFU\nTotal bill amount is {{currency_symbol}}{{total_amount}}\nTotal paid amount is {{currency_symbol}}{{paid_amount}}\nTotal balance bill amount is {{currency_symbol}}{{balance_amount}}','','IPD Patient Discharge','{{patient_name}} {{currency_symbol}} {{total_amount}} {{paid_amount}} {balance_amount}}','2026-11-09 10:49:41'),(5,'login_credential',1,0,0,0,0,1,'Hello {{display_name}} your SEFU login details are Url: {{url}} Username: {{username}} Password: {{password}}','','SEFU Login Credential','{{display_name}} {{url}} {{username}} {{password}}','2026-11-09 10:49:41'),(6,'appointment_approved',1,0,0,0,1,1,'Dear {{patient_name}} your appointment with {{staff_name}} {{staff_surname}} is confirmed on {{date}} with appointment no: {{appointment_no}}','','Appointment Approved','{{patient_name}} {{staff_name}}\n{{staff_surname}}  {{date}} {{appointment_no}}','2021-10-22 23:56:24'),(7,'live_meeting',1,0,0,0,0,1,'Dear staff, your live meeting {{title}} has been scheduled on {{date}} for the duration of {{duration}} minute.','','Live Meeting','{{title}} {{date}} {{duration}}','2021-10-22 23:54:58'),(8,'live_consult',1,0,0,0,1,1,'Dear patient, your live consultation {{title}} has been scheduled on {{date}} for the duration of {{duration}} minute.','','Live Consultation','{{title}} {{date}} {{duration}}','2021-10-22 06:28:26'),(9,'opd_patient_discharged',1,0,0,0,1,1,'OPD No {{opd_no}}  {{patient_name}} is now discharged from SEFU.\r\n\r\nTotal bill amount was {{currency_symbol}}  {{total_amount}} \r\nTotal paid amount was {{currency_symbol}}{{paid_amount}}  \r\nTotal balance amount is {{currency_symbol}}{{balance_amount}}','','OPD Patient Discharged','{{patient_name}} {{mobileno}} {{email}} {{dob}} {{gender}} {{patient_unique_id}} {{opd_no}}{{currency_symbol}} {{billing_amount}}','2026-11-09 10:49:41'),(10,'forgot_password',1,0,0,0,0,0,'Dear  {{display_name}}, recently a request was submitted to reset password for your account with email: {{email}}. If you didn\'t make the request, just ignore this email, otherwise you can reset your password using this link <a href=\'{{resetpasslink}}\'>click here to reset your password</a>, if you\'re having trouble clicking the password reset link, copy and paste below URL  into your web browser. {{resetpasslink}} <br> Regards,  <br>\r\nSEFU','','Reset Password Request','{{display_name}}  {{email}}  {{resetpasslink}','2026-11-09 10:49:41');
/*!40000 ALTER TABLE `notification_setting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nurse_note`
--

DROP TABLE IF EXISTS `nurse_note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nurse_note` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL,
  `ipd_id` int(11) DEFAULT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `updated_at` datetime NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `ipd_id` (`ipd_id`),
  KEY `staff_id` (`staff_id`),
  KEY `index_date` (`date`),
  CONSTRAINT `nurse_note_ibfk_1` FOREIGN KEY (`ipd_id`) REFERENCES `ipd_details` (`id`) ON DELETE CASCADE,
  CONSTRAINT `nurse_note_ibfk_2` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nurse_note`
--

LOCK TABLES `nurse_note` WRITE;
/*!40000 ALTER TABLE `nurse_note` DISABLE KEYS */;
/*!40000 ALTER TABLE `nurse_note` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nurse_notes_comment`
--

DROP TABLE IF EXISTS `nurse_notes_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nurse_notes_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nurse_note_id` int(11) DEFAULT NULL,
  `comment_staffid` int(11) DEFAULT NULL,
  `comment_staff` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `nurse_note_id` (`nurse_note_id`),
  KEY `comment_staffid` (`comment_staffid`),
  CONSTRAINT `nurse_notes_comment_ibfk_1` FOREIGN KEY (`nurse_note_id`) REFERENCES `nurse_note` (`id`) ON DELETE CASCADE,
  CONSTRAINT `nurse_notes_comment_ibfk_2` FOREIGN KEY (`comment_staffid`) REFERENCES `staff` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nurse_notes_comment`
--

LOCK TABLES `nurse_notes_comment` WRITE;
/*!40000 ALTER TABLE `nurse_notes_comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `nurse_notes_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `obstetric_history`
--

DROP TABLE IF EXISTS `obstetric_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `obstetric_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) NOT NULL,
  `place_of_delivery` varchar(250) NOT NULL,
  `pregnancy_duration` varchar(250) NOT NULL,
  `pregnancy_complications` varchar(250) NOT NULL,
  `birth_weight` varchar(250) NOT NULL,
  `gender` varchar(100) NOT NULL,
  `infant_feeding` varchar(250) NOT NULL,
  `alive_dead` varchar(50) NOT NULL,
  `date` date DEFAULT NULL,
  `death_cause` varchar(250) NOT NULL,
  `previous_medical_history` text NOT NULL,
  `special_instruction` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `index_place_of_delivery` (`place_of_delivery`),
  KEY `index_pregnancy_duration` (`pregnancy_duration`),
  KEY `index_pregnancy_complications` (`pregnancy_complications`),
  KEY `index_birth_weight` (`birth_weight`),
  KEY `index_gender` (`gender`),
  KEY `index_infant_feeding` (`infant_feeding`),
  KEY `index_alive_dead` (`alive_dead`),
  KEY `index_date` (`date`),
  KEY `index_death_cause` (`death_cause`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `obstetric_history`
--

LOCK TABLES `obstetric_history` WRITE;
/*!40000 ALTER TABLE `obstetric_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `obstetric_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opd_details`
--

DROP TABLE IF EXISTS `opd_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opd_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `case_reference_id` int(11) DEFAULT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `generated_by` int(11) DEFAULT NULL,
  `is_ipd_moved` int(11) NOT NULL DEFAULT 0,
  `discharged` varchar(10) NOT NULL DEFAULT 'no',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `patient_id` (`patient_id`),
  KEY `case_reference_id` (`case_reference_id`),
  KEY `generated_by` (`generated_by`),
  CONSTRAINT `opd_details_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE,
  CONSTRAINT `opd_details_ibfk_2` FOREIGN KEY (`case_reference_id`) REFERENCES `case_references` (`id`) ON DELETE CASCADE,
  CONSTRAINT `opd_details_ibfk_3` FOREIGN KEY (`generated_by`) REFERENCES `staff` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opd_details`
--

LOCK TABLES `opd_details` WRITE;
/*!40000 ALTER TABLE `opd_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `opd_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `operation`
--

DROP TABLE IF EXISTS `operation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `operation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `operation` varchar(250) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `is_active` varchar(10) NOT NULL,
  `created_at` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`),
  KEY `index_operation` (`operation`),
  CONSTRAINT `operation_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `operation_category` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `operation`
--

LOCK TABLES `operation` WRITE;
/*!40000 ALTER TABLE `operation` DISABLE KEYS */;
INSERT INTO `operation` VALUES (1,'ICU',1,'yes','2026-11-05');
/*!40000 ALTER TABLE `operation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `operation_category`
--

DROP TABLE IF EXISTS `operation_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `operation_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(250) NOT NULL,
  `is_active` varchar(10) NOT NULL,
  `created_at` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_category` (`category`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `operation_category`
--

LOCK TABLES `operation_category` WRITE;
/*!40000 ALTER TABLE `operation_category` DISABLE KEYS */;
INSERT INTO `operation_category` VALUES (1,'ICU','yes','2026-11-05');
/*!40000 ALTER TABLE `operation_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `operation_theatre`
--

DROP TABLE IF EXISTS `operation_theatre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `operation_theatre` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `opd_details_id` int(11) DEFAULT NULL,
  `ipd_details_id` int(11) DEFAULT NULL,
  `customer_type` varchar(50) DEFAULT NULL,
  `operation_id` int(11) NOT NULL,
  `date` datetime DEFAULT NULL,
  `operation_type` varchar(100) DEFAULT NULL,
  `consultant_doctor` int(11) DEFAULT NULL,
  `ass_consultant_1` varchar(50) DEFAULT NULL,
  `ass_consultant_2` varchar(50) DEFAULT NULL,
  `anesthetist` varchar(50) DEFAULT NULL,
  `anaethesia_type` varchar(50) DEFAULT NULL,
  `ot_technician` varchar(100) DEFAULT NULL,
  `ot_assistant` varchar(100) DEFAULT NULL,
  `result` text DEFAULT NULL,
  `remark` text DEFAULT NULL,
  `generated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `opd_details_id` (`opd_details_id`),
  KEY `ipd_details_id` (`ipd_details_id`),
  KEY `consultant_doctor` (`consultant_doctor`),
  KEY `generated_by` (`generated_by`),
  KEY `operation_id` (`operation_id`),
  KEY `index_date` (`date`),
  CONSTRAINT `operation_theatre_ibfk_1` FOREIGN KEY (`opd_details_id`) REFERENCES `opd_details` (`id`) ON DELETE CASCADE,
  CONSTRAINT `operation_theatre_ibfk_2` FOREIGN KEY (`ipd_details_id`) REFERENCES `ipd_details` (`id`) ON DELETE CASCADE,
  CONSTRAINT `operation_theatre_ibfk_3` FOREIGN KEY (`consultant_doctor`) REFERENCES `staff` (`id`) ON DELETE CASCADE,
  CONSTRAINT `operation_theatre_ibfk_4` FOREIGN KEY (`generated_by`) REFERENCES `staff` (`id`) ON DELETE CASCADE,
  CONSTRAINT `operation_theatre_ibfk_5` FOREIGN KEY (`operation_id`) REFERENCES `operation` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `operation_theatre`
--

LOCK TABLES `operation_theatre` WRITE;
/*!40000 ALTER TABLE `operation_theatre` DISABLE KEYS */;
/*!40000 ALTER TABLE `operation_theatre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organisation`
--

DROP TABLE IF EXISTS `organisation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `organisation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `organisation_name` varchar(200) NOT NULL,
  `code` varchar(50) NOT NULL,
  `contact_no` varchar(20) NOT NULL,
  `address` varchar(300) NOT NULL,
  `contact_person_name` varchar(200) NOT NULL,
  `contact_person_phone` varchar(20) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `index_organisation_name` (`organisation_name`),
  KEY `index_code` (`code`),
  KEY `index_contact_no` (`contact_no`),
  KEY `index_address` (`address`),
  KEY `index_contact_person_name` (`contact_person_name`),
  KEY `index_contact_person_phone` (`contact_person_phone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organisation`
--

LOCK TABLES `organisation` WRITE;
/*!40000 ALTER TABLE `organisation` DISABLE KEYS */;
/*!40000 ALTER TABLE `organisation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organisations_charges`
--

DROP TABLE IF EXISTS `organisations_charges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `organisations_charges` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `org_id` int(11) DEFAULT NULL,
  `charge_id` int(11) DEFAULT NULL,
  `org_charge` float(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `org_id` (`org_id`),
  KEY `charge_id` (`charge_id`),
  CONSTRAINT `organisations_charges_ibfk_1` FOREIGN KEY (`org_id`) REFERENCES `organisation` (`id`) ON DELETE CASCADE,
  CONSTRAINT `organisations_charges_ibfk_2` FOREIGN KEY (`charge_id`) REFERENCES `charges` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organisations_charges`
--

LOCK TABLES `organisations_charges` WRITE;
/*!40000 ALTER TABLE `organisations_charges` DISABLE KEYS */;
/*!40000 ALTER TABLE `organisations_charges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pathology`
--

DROP TABLE IF EXISTS `pathology`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pathology` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `test_name` varchar(100) DEFAULT NULL,
  `short_name` varchar(100) DEFAULT NULL,
  `test_type` varchar(100) DEFAULT NULL,
  `pathology_category_id` int(11) DEFAULT NULL,
  `unit` varchar(50) NOT NULL,
  `sub_category` varchar(50) NOT NULL,
  `report_days` varchar(50) NOT NULL,
  `method` varchar(50) NOT NULL,
  `charge_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `pathology_category_id` (`pathology_category_id`),
  KEY `charge_id` (`charge_id`),
  KEY `index_test_name` (`test_name`),
  KEY `index_short_name` (`short_name`),
  KEY `index_test_type` (`test_type`),
  KEY `index_unit` (`unit`),
  KEY `index_sub_category` (`sub_category`),
  KEY `index_report_days` (`report_days`),
  KEY `index_method` (`method`),
  CONSTRAINT `pathology_ibfk_1` FOREIGN KEY (`pathology_category_id`) REFERENCES `pathology_category` (`id`) ON DELETE CASCADE,
  CONSTRAINT `pathology_ibfk_2` FOREIGN KEY (`charge_id`) REFERENCES `charges` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pathology`
--

LOCK TABLES `pathology` WRITE;
/*!40000 ALTER TABLE `pathology` DISABLE KEYS */;
/*!40000 ALTER TABLE `pathology` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pathology_billing`
--

DROP TABLE IF EXISTS `pathology_billing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pathology_billing` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `case_reference_id` int(11) DEFAULT NULL,
  `ipd_prescription_basic_id` int(11) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `doctor_id` int(11) DEFAULT NULL,
  `doctor_name` varchar(100) NOT NULL,
  `total` float(10,2) DEFAULT 0.00,
  `discount_percentage` float(10,2) DEFAULT 0.00,
  `discount` float(10,2) DEFAULT 0.00,
  `tax_percentage` float(10,2) DEFAULT 0.00,
  `tax` float(10,2) DEFAULT 0.00,
  `net_amount` float(10,2) DEFAULT 0.00,
  `transaction_id` int(11) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `organisation_id` int(11) DEFAULT NULL,
  `insurance_validity` date DEFAULT NULL,
  `generated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_at` datetime DEFAULT NULL,
  `insurance_id` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `patient_id` (`patient_id`),
  KEY `doctor_id` (`doctor_id`),
  KEY `case_reference_id` (`case_reference_id`),
  KEY `transaction_id` (`transaction_id`),
  KEY `generated_by` (`generated_by`),
  KEY `ipd_prescription_basic_id` (`ipd_prescription_basic_id`),
  KEY `index_date` (`date`),
  KEY `index_doctor_name` (`doctor_name`),
  KEY `index_total` (`total`),
  KEY `index_discount_percentage` (`discount_percentage`),
  KEY `index_discount` (`discount`),
  KEY `index_tax_percentage` (`tax_percentage`),
  KEY `index_tax` (`tax`),
  KEY `index_net_amount` (`net_amount`),
  KEY `organisation_id` (`organisation_id`),
  CONSTRAINT `pathology_billing_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE,
  CONSTRAINT `pathology_billing_ibfk_2` FOREIGN KEY (`doctor_id`) REFERENCES `staff` (`id`) ON DELETE CASCADE,
  CONSTRAINT `pathology_billing_ibfk_3` FOREIGN KEY (`case_reference_id`) REFERENCES `case_references` (`id`) ON DELETE CASCADE,
  CONSTRAINT `pathology_billing_ibfk_4` FOREIGN KEY (`generated_by`) REFERENCES `staff` (`id`) ON DELETE CASCADE,
  CONSTRAINT `pathology_billing_ibfk_5` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`) ON DELETE SET NULL,
  CONSTRAINT `pathology_billing_ibfk_6` FOREIGN KEY (`ipd_prescription_basic_id`) REFERENCES `ipd_prescription_basic` (`id`) ON DELETE CASCADE,
  CONSTRAINT `pathology_billing_ibfk_7` FOREIGN KEY (`organisation_id`) REFERENCES `organisation` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pathology_billing`
--

LOCK TABLES `pathology_billing` WRITE;
/*!40000 ALTER TABLE `pathology_billing` DISABLE KEYS */;
/*!40000 ALTER TABLE `pathology_billing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pathology_category`
--

DROP TABLE IF EXISTS `pathology_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pathology_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `index_category_name` (`category_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pathology_category`
--

LOCK TABLES `pathology_category` WRITE;
/*!40000 ALTER TABLE `pathology_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `pathology_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pathology_parameter`
--

DROP TABLE IF EXISTS `pathology_parameter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pathology_parameter` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parameter_name` varchar(100) NOT NULL,
  `test_value` varchar(100) NOT NULL,
  `reference_range` varchar(100) NOT NULL,
  `range_from` varchar(500) DEFAULT NULL,
  `range_to` varchar(500) DEFAULT NULL,
  `gender` varchar(100) NOT NULL,
  `unit` int(11) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `unit` (`unit`),
  KEY `index_parameter_name` (`parameter_name`),
  KEY `index_test_value` (`test_value`),
  KEY `index_reference_range` (`reference_range`),
  KEY `index_range_from` (`range_from`),
  KEY `index_range_to` (`range_to`),
  KEY `index_gender` (`gender`),
  KEY `index_unit` (`unit`),
  CONSTRAINT `pathology_parameter_ibfk_1` FOREIGN KEY (`unit`) REFERENCES `unit` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pathology_parameter`
--

LOCK TABLES `pathology_parameter` WRITE;
/*!40000 ALTER TABLE `pathology_parameter` DISABLE KEYS */;
/*!40000 ALTER TABLE `pathology_parameter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pathology_parameterdetails`
--

DROP TABLE IF EXISTS `pathology_parameterdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pathology_parameterdetails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pathology_id` int(11) DEFAULT NULL,
  `pathology_parameter_id` int(11) DEFAULT NULL,
  `created_id` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `pathology_id` (`pathology_id`),
  KEY `pathology_parameter_id` (`pathology_parameter_id`),
  CONSTRAINT `pathology_parameterdetails_ibfk_1` FOREIGN KEY (`pathology_id`) REFERENCES `pathology` (`id`) ON DELETE CASCADE,
  CONSTRAINT `pathology_parameterdetails_ibfk_2` FOREIGN KEY (`pathology_parameter_id`) REFERENCES `pathology_parameter` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pathology_parameterdetails`
--

LOCK TABLES `pathology_parameterdetails` WRITE;
/*!40000 ALTER TABLE `pathology_parameterdetails` DISABLE KEYS */;
/*!40000 ALTER TABLE `pathology_parameterdetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pathology_report`
--

DROP TABLE IF EXISTS `pathology_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pathology_report` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pathology_bill_id` int(11) DEFAULT NULL,
  `pathology_id` int(11) DEFAULT NULL,
  `customer_type` varchar(50) DEFAULT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `reporting_date` date DEFAULT NULL,
  `parameter_update` date DEFAULT NULL,
  `tax_percentage` float(10,2) NOT NULL DEFAULT 0.00,
  `apply_charge` float(10,2) NOT NULL,
  `collection_date` date DEFAULT NULL,
  `collection_specialist` int(11) DEFAULT NULL,
  `pathology_center` varchar(250) DEFAULT NULL,
  `approved_by` int(11) DEFAULT NULL,
  `patient_name` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `pathology_report` varchar(255) DEFAULT NULL,
  `report_name` text DEFAULT NULL,
  `pathology_result` text DEFAULT NULL COMMENT 'test result',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `patient_id` (`patient_id`),
  KEY `pathology_bill_id` (`pathology_bill_id`),
  KEY `pathology_id` (`pathology_id`),
  KEY `collection_specialist` (`collection_specialist`),
  KEY `approved_by` (`approved_by`),
  KEY `index_reporting_date` (`reporting_date`),
  KEY `index_parameter_update` (`parameter_update`),
  KEY `index_tax_percentage` (`tax_percentage`),
  KEY `index_apply_charge` (`apply_charge`),
  KEY `index_collection_date` (`collection_date`),
  CONSTRAINT `pathology_report_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE,
  CONSTRAINT `pathology_report_ibfk_2` FOREIGN KEY (`pathology_bill_id`) REFERENCES `pathology_billing` (`id`) ON DELETE CASCADE,
  CONSTRAINT `pathology_report_ibfk_3` FOREIGN KEY (`pathology_id`) REFERENCES `pathology` (`id`) ON DELETE CASCADE,
  CONSTRAINT `pathology_report_ibfk_4` FOREIGN KEY (`collection_specialist`) REFERENCES `staff` (`id`) ON DELETE CASCADE,
  CONSTRAINT `pathology_report_ibfk_5` FOREIGN KEY (`approved_by`) REFERENCES `staff` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pathology_report`
--

LOCK TABLES `pathology_report` WRITE;
/*!40000 ALTER TABLE `pathology_report` DISABLE KEYS */;
/*!40000 ALTER TABLE `pathology_report` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pathology_report_parameterdetails`
--

DROP TABLE IF EXISTS `pathology_report_parameterdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pathology_report_parameterdetails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pathology_report_id` int(11) DEFAULT NULL,
  `pathology_parameterdetail_id` int(11) DEFAULT NULL,
  `pathology_report_value` varchar(200) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `pathology_report_id` (`pathology_report_id`),
  KEY `pathology_parameterdetail_id` (`pathology_parameterdetail_id`),
  CONSTRAINT `pathology_report_parameterdetails_ibfk_1` FOREIGN KEY (`pathology_report_id`) REFERENCES `pathology_report` (`id`) ON DELETE CASCADE,
  CONSTRAINT `pathology_report_parameterdetails_ibfk_2` FOREIGN KEY (`pathology_parameterdetail_id`) REFERENCES `pathology_parameterdetails` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pathology_report_parameterdetails`
--

LOCK TABLES `pathology_report_parameterdetails` WRITE;
/*!40000 ALTER TABLE `pathology_report_parameterdetails` DISABLE KEYS */;
/*!40000 ALTER TABLE `pathology_report_parameterdetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient_bed_history`
--

DROP TABLE IF EXISTS `patient_bed_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient_bed_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `case_reference_id` int(11) DEFAULT NULL,
  `bed_group_id` int(11) DEFAULT NULL,
  `bed_id` int(11) DEFAULT NULL,
  `revert_reason` text DEFAULT NULL,
  `from_date` datetime DEFAULT NULL,
  `to_date` datetime DEFAULT NULL,
  `is_active` varchar(20) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `case_reference_id` (`case_reference_id`),
  KEY `bed_group_id` (`bed_group_id`),
  KEY `bed_id` (`bed_id`),
  KEY `index_from_date` (`from_date`),
  KEY `index_to_date` (`to_date`),
  CONSTRAINT `patient_bed_history_ibfk_1` FOREIGN KEY (`case_reference_id`) REFERENCES `case_references` (`id`) ON DELETE CASCADE,
  CONSTRAINT `patient_bed_history_ibfk_2` FOREIGN KEY (`bed_group_id`) REFERENCES `bed_group` (`id`) ON DELETE CASCADE,
  CONSTRAINT `patient_bed_history_ibfk_3` FOREIGN KEY (`bed_id`) REFERENCES `bed` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_bed_history`
--

LOCK TABLES `patient_bed_history` WRITE;
/*!40000 ALTER TABLE `patient_bed_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `patient_bed_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient_charges`
--

DROP TABLE IF EXISTS `patient_charges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient_charges` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `ipd_id` int(11) DEFAULT NULL,
  `opd_id` int(11) DEFAULT NULL,
  `qty` int(11) DEFAULT NULL,
  `charge_id` int(11) DEFAULT NULL,
  `standard_charge` float(10,2) DEFAULT 0.00,
  `tpa_charge` float(10,2) DEFAULT 0.00,
  `discount_percentage` float(10,2) DEFAULT 0.00,
  `tax` float(10,2) DEFAULT 0.00,
  `apply_charge` float(10,2) DEFAULT 0.00,
  `amount` float(10,2) DEFAULT 0.00,
  `note` text DEFAULT NULL,
  `organisation_id` int(11) DEFAULT NULL,
  `insurance_validity` date DEFAULT NULL,
  `insurance_id` varchar(250) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `opd_id` (`opd_id`),
  KEY `ipd_id` (`ipd_id`),
  KEY `charge_id` (`charge_id`),
  KEY `organisation_id` (`organisation_id`),
  KEY `index_qty` (`qty`),
  KEY `index_standard_charge` (`standard_charge`),
  KEY `index_tpa_charge` (`tpa_charge`),
  KEY `index_discount_percentage` (`discount_percentage`),
  KEY `index_tax` (`tax`),
  KEY `index_apply_charge` (`apply_charge`),
  KEY `index_amount` (`amount`),
  CONSTRAINT `patient_charges_ibfk_1` FOREIGN KEY (`opd_id`) REFERENCES `opd_details` (`id`) ON DELETE CASCADE,
  CONSTRAINT `patient_charges_ibfk_2` FOREIGN KEY (`ipd_id`) REFERENCES `ipd_details` (`id`) ON DELETE CASCADE,
  CONSTRAINT `patient_charges_ibfk_3` FOREIGN KEY (`charge_id`) REFERENCES `charges` (`id`) ON DELETE CASCADE,
  CONSTRAINT `patient_charges_ibfk_4` FOREIGN KEY (`organisation_id`) REFERENCES `organisation` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_charges`
--

LOCK TABLES `patient_charges` WRITE;
/*!40000 ALTER TABLE `patient_charges` DISABLE KEYS */;
/*!40000 ALTER TABLE `patient_charges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient_id_card`
--

DROP TABLE IF EXISTS `patient_id_card`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient_id_card` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `hospital_name` varchar(100) NOT NULL,
  `hospital_address` varchar(500) NOT NULL,
  `background` text NOT NULL,
  `logo` text NOT NULL,
  `sign_image` text NOT NULL,
  `header_color` varchar(100) NOT NULL,
  `enable_patient_name` tinyint(1) NOT NULL COMMENT '0=disable,1=enable',
  `enable_guardian_name` tinyint(1) NOT NULL COMMENT '0=disable,1=enable',
  `enable_patient_unique_id` tinyint(1) NOT NULL COMMENT '0=disable,1=enable',
  `enable_address` tinyint(1) NOT NULL COMMENT '0=disable,1=enable',
  `enable_phone` tinyint(1) NOT NULL COMMENT '0=disable,1=enable',
  `enable_dob` tinyint(1) NOT NULL COMMENT '0=disable,1=enable',
  `enable_blood_group` tinyint(1) NOT NULL COMMENT '0=disable,1=enable',
  `status` tinyint(1) NOT NULL COMMENT '0=disable,1=enable',
  `enable_barcode` tinyint(1) NOT NULL COMMENT '0=disable,1=enable',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `index_title` (`title`),
  KEY `index_hospital_name` (`hospital_name`),
  KEY `index_hospital_address` (`hospital_address`),
  KEY `index_header_color` (`header_color`),
  KEY `index_enable_patient_name` (`enable_patient_name`),
  KEY `index_enable_guardian_name` (`enable_guardian_name`),
  KEY `index_enable_patient_unique_id` (`enable_patient_unique_id`),
  KEY `index_enable_address` (`enable_address`),
  KEY `index_enable_phone` (`enable_phone`),
  KEY `index_enable_dob` (`enable_dob`),
  KEY `index_enable_blood_group` (`enable_blood_group`),
  KEY `index_status` (`status`),
  KEY `index_enable_barcode` (`enable_barcode`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_id_card`
--

LOCK TABLES `patient_id_card` WRITE;
/*!40000 ALTER TABLE `patient_id_card` DISABLE KEYS */;
INSERT INTO `patient_id_card` VALUES (1,'Sample Patient Id Card','Royal Hospital','Nr Loyala Ashram, A 69, Shahpura Rd, Manisha Market, Sector  Bhopal','background.jpg','logo.jpg','signature.png','#0796f5',1,1,1,1,1,1,1,1,0,'2021-10-19 07:06:02');
/*!40000 ALTER TABLE `patient_id_card` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient_timeline`
--

DROP TABLE IF EXISTS `patient_timeline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient_timeline` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) DEFAULT NULL,
  `title` varchar(200) NOT NULL,
  `timeline_date` datetime DEFAULT NULL,
  `description` text DEFAULT NULL,
  `document` varchar(255) NOT NULL,
  `status` varchar(100) NOT NULL,
  `date` datetime DEFAULT NULL,
  `generated_users_type` varchar(100) NOT NULL,
  `generated_users_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `patient_id` (`patient_id`),
  KEY `generated_users_id` (`generated_users_id`),
  KEY `index_title` (`title`),
  KEY `index_date` (`date`),
  KEY `index_timeline_date` (`timeline_date`),
  CONSTRAINT `patient_timeline_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE,
  CONSTRAINT `patient_timeline_ibfk_2` FOREIGN KEY (`generated_users_id`) REFERENCES `staff` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_timeline`
--

LOCK TABLES `patient_timeline` WRITE;
/*!40000 ALTER TABLE `patient_timeline` DISABLE KEYS */;
/*!40000 ALTER TABLE `patient_timeline` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patients`
--

DROP TABLE IF EXISTS `patients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patients` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lang_id` int(11) DEFAULT NULL,
  `patient_name` varchar(100) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `age` int(11) NOT NULL,
  `month` int(11) NOT NULL,
  `day` int(11) NOT NULL,
  `as_of_date` date DEFAULT NULL,
  `image` text DEFAULT NULL,
  `mobileno` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `gender` varchar(100) DEFAULT NULL,
  `marital_status` varchar(100) NOT NULL,
  `blood_group` varchar(200) NOT NULL,
  `blood_bank_product_id` int(11) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `guardian_name` varchar(100) DEFAULT NULL,
  `patient_type` varchar(200) NOT NULL,
  `identification_number` varchar(60) NOT NULL,
  `known_allergies` varchar(200) NOT NULL,
  `note` varchar(200) NOT NULL,
  `is_ipd` varchar(200) NOT NULL,
  `app_key` varchar(200) NOT NULL,
  `organisation_id` int(11) DEFAULT NULL,
  `insurance_id` varchar(250) DEFAULT NULL,
  `insurance_validity` date DEFAULT NULL,
  `is_dead` varchar(255) NOT NULL DEFAULT 'no',
  `is_antenatal` int(11) NOT NULL,
  `is_active` varchar(255) DEFAULT 'no',
  `disable_at` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `blood_bank_product_id` (`blood_bank_product_id`),
  KEY `idx_patient_name` (`patient_name`),
  KEY `idx_dob` (`dob`),
  KEY `idx_age` (`age`),
  KEY `idx_month` (`month`),
  KEY `idx_mobileno` (`mobileno`),
  KEY `idx_email` (`email`),
  KEY `idx_gender` (`gender`),
  KEY `idx_marital_status` (`marital_status`),
  KEY `idx_address` (`address`(500)),
  KEY `idx_guardian_name` (`guardian_name`),
  KEY `organisation_id` (`organisation_id`),
  CONSTRAINT `patients_ibfk_1` FOREIGN KEY (`blood_bank_product_id`) REFERENCES `blood_bank_products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `patients_ibfk_2` FOREIGN KEY (`organisation_id`) REFERENCES `organisation` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patients`
--

LOCK TABLES `patients` WRITE;
/*!40000 ALTER TABLE `patients` DISABLE KEYS */;
INSERT INTO `patients` VALUES (1,NULL,'testing','2026-11-04',1996,3,1,'2026-11-05','uploads/patient_images/no_image.png','62666','','Male','','',NULL,'fdvgdsfgfsbfds','fefe','','876868768','','fdbvdsb','','',NULL,'',NULL,'no',0,'yes',NULL,'2026-11-05 15:40:09');
/*!40000 ALTER TABLE `patients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patients_vitals`
--

DROP TABLE IF EXISTS `patients_vitals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patients_vitals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) NOT NULL,
  `vital_id` int(11) NOT NULL,
  `reference_range` varchar(100) NOT NULL,
  `messure_date` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `patient_id` (`patient_id`),
  KEY `index_reference_range` (`reference_range`),
  KEY `index_messure_date` (`messure_date`),
  KEY `vital_id` (`vital_id`),
  CONSTRAINT `patients_vitals_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE,
  CONSTRAINT `patients_vitals_ibfk_2` FOREIGN KEY (`vital_id`) REFERENCES `vitals` (`id`) ON DELETE CASCADE,
  CONSTRAINT `patients_vitals_ibfk_3` FOREIGN KEY (`vital_id`) REFERENCES `vitals` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patients_vitals`
--

LOCK TABLES `patients_vitals` WRITE;
/*!40000 ALTER TABLE `patients_vitals` DISABLE KEYS */;
/*!40000 ALTER TABLE `patients_vitals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_settings`
--

DROP TABLE IF EXISTS `payment_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `payment_type` varchar(200) NOT NULL,
  `api_username` varchar(200) DEFAULT NULL,
  `api_secret_key` varchar(200) NOT NULL,
  `salt` varchar(200) NOT NULL,
  `api_publishable_key` varchar(200) NOT NULL,
  `paytm_website` varchar(255) NOT NULL,
  `paytm_industrytype` varchar(255) NOT NULL,
  `api_password` varchar(200) DEFAULT NULL,
  `api_signature` varchar(200) DEFAULT NULL,
  `api_email` varchar(200) DEFAULT NULL,
  `paypal_demo` varchar(100) NOT NULL,
  `account_no` varchar(200) NOT NULL,
  `is_active` varchar(255) DEFAULT 'no',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `index_payment_type` (`payment_type`),
  KEY `index_api_username` (`api_username`),
  KEY `index_api_secret_key` (`api_secret_key`),
  KEY `index_salt` (`salt`),
  KEY `index_api_publishable_key` (`api_publishable_key`),
  KEY `index_paytm_website` (`paytm_website`),
  KEY `index_paytm_industrytype` (`paytm_industrytype`),
  KEY `index_api_password` (`api_password`),
  KEY `index_api_signature` (`api_signature`),
  KEY `index_api_email` (`api_email`),
  KEY `index_paypal_demo` (`paypal_demo`),
  KEY `index_account_no` (`account_no`),
  KEY `index_is_active` (`is_active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_settings`
--

LOCK TABLES `payment_settings` WRITE;
/*!40000 ALTER TABLE `payment_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payslip_allowance`
--

DROP TABLE IF EXISTS `payslip_allowance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payslip_allowance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `staff_payslip_id` int(11) DEFAULT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `allowance_type` varchar(200) NOT NULL,
  `amount` float NOT NULL,
  `cal_type` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `staff_id` (`staff_id`),
  KEY `staff_payslip_id` (`staff_payslip_id`),
  KEY `index_allowance_type` (`allowance_type`),
  KEY `index_amount` (`amount`),
  KEY `index_cal_type` (`cal_type`),
  CONSTRAINT `payslip_allowance_ibfk_1` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`id`) ON DELETE CASCADE,
  CONSTRAINT `payslip_allowance_ibfk_2` FOREIGN KEY (`staff_payslip_id`) REFERENCES `staff_payslip` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payslip_allowance`
--

LOCK TABLES `payslip_allowance` WRITE;
/*!40000 ALTER TABLE `payslip_allowance` DISABLE KEYS */;
/*!40000 ALTER TABLE `payslip_allowance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pediatric`
--

DROP TABLE IF EXISTS `pediatric`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pediatric` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `dob` date DEFAULT NULL,
  `age` varchar(50) DEFAULT NULL,
  `height` varchar(20) DEFAULT NULL,
  `weight` varchar(20) DEFAULT NULL,
  `temperature` varchar(20) DEFAULT NULL,
  `symptoms` text DEFAULT NULL,
  `note` text DEFAULT NULL,
  `pediatrician_id` int(11) NOT NULL,
  `consultation_date` datetime NOT NULL,
  `diagnosis` text DEFAULT NULL,
  `clinical_notes` text DEFAULT NULL,
  `prescription_treatment` text DEFAULT NULL,
  `growth_monitoring` text DEFAULT NULL,
  `immunization_details` text DEFAULT NULL,
  `organisation_id` int(11) DEFAULT NULL,
  `charge_id` int(11) DEFAULT NULL,
  `standard_charge` float(10,2) DEFAULT 0.00,
  `apply_charge` float(10,2) DEFAULT 0.00,
  `generated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `patient_id` (`patient_id`),
  KEY `pediatrician_id` (`pediatrician_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pediatric`
--

LOCK TABLES `pediatric` WRITE;
/*!40000 ALTER TABLE `pediatric` DISABLE KEYS */;
INSERT INTO `pediatric` VALUES (1,'PEDB1',1,'1970-01-01','3 Yrs','95 cm','14 kg','98.6 F','Mild fever and dry cough for 2 days','Review in 3 days if fever persists',1,'2026-08-11 12:43:00','Acute Upper Respiratory Tract Infection (URTI)','Chest clear, throat mildly congested, alert and active','Paracetamol syrup 5ml PRN, saline nasal drops','Height and weight on 50th percentile for age','Up to date. MMR booster given.',NULL,NULL,50.00,50.00,1,'2026-11-08 11:43:08');
/*!40000 ALTER TABLE `pediatric` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pediatric_instructions`
--

DROP TABLE IF EXISTS `pediatric_instructions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pediatric_instructions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pediatric_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `doctor_id` int(11) NOT NULL,
  `instruction` text NOT NULL,
  `date` datetime NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `pediatric_id` (`pediatric_id`),
  KEY `patient_id` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pediatric_instructions`
--

LOCK TABLES `pediatric_instructions` WRITE;
/*!40000 ALTER TABLE `pediatric_instructions` DISABLE KEYS */;
/*!40000 ALTER TABLE `pediatric_instructions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permission_category`
--

DROP TABLE IF EXISTS `permission_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permission_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `perm_group_id` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `short_code` varchar(100) DEFAULT NULL,
  `enable_view` int(11) DEFAULT 0,
  `enable_add` int(11) DEFAULT 0,
  `enable_edit` int(11) DEFAULT 0,
  `enable_delete` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `index_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=432 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permission_category`
--

LOCK TABLES `permission_category` WRITE;
/*!40000 ALTER TABLE `permission_category` DISABLE KEYS */;
INSERT INTO `permission_category` VALUES (9,3,'Income','income',1,1,1,1,'2018-06-21 23:23:21'),(10,3,'Income Head','income_head',1,1,1,1,'2018-06-21 23:22:44'),(12,4,'Expense','expense',1,1,1,1,'2018-06-21 23:24:06'),(13,4,'Expense Head','expense_head',1,1,1,1,'2018-06-21 23:23:47'),(27,8,'Content Type','content_type',1,1,1,1,'2024-08-21 09:29:55'),(31,10,'Issue Item','issue_item',1,1,0,1,'2018-12-16 22:55:14'),(32,10,'Item Stock','item_stock',1,1,1,1,'2018-06-21 23:35:17'),(33,10,'Item','item',1,1,1,1,'2018-06-21 23:35:40'),(34,10,'Store','store',1,1,1,1,'2018-06-21 23:36:02'),(35,10,'Supplier','supplier',1,1,1,1,'2018-06-21 23:36:25'),(43,13,'Notice Board','notice_board',1,1,1,1,'2018-06-21 23:41:17'),(44,13,'Email / SMS','email_sms',1,0,0,0,'2018-06-21 23:40:54'),(48,14,'OPD Report','opd_report',1,0,0,0,'2018-12-17 21:59:18'),(53,15,'Languages','languages',1,1,0,0,'2021-09-12 22:56:36'),(54,15,'General Setting','general_setting',1,0,1,0,'2018-07-04 22:08:35'),(56,15,'Notification Setting','notification_setting',1,0,1,0,'2018-07-04 22:08:41'),(57,15,'SMS Setting','sms_setting',1,0,1,0,'2018-07-04 22:08:47'),(58,15,'Email Setting','email_setting',1,0,1,0,'2018-07-04 22:08:51'),(59,15,'Front CMS Setting','front_cms_setting',1,0,1,0,'2018-07-04 22:08:55'),(60,15,'Payment Methods','payment_methods',1,0,1,0,'2018-07-04 22:08:59'),(61,16,'Menus','menus',1,1,0,1,'2018-07-08 16:50:06'),(62,16,'Media Manager','media_manager',1,1,0,1,'2018-07-08 16:50:26'),(63,16,'Banner Images','banner_images',1,1,0,1,'2018-06-21 23:46:02'),(64,16,'Pages','pages',1,1,1,1,'2018-06-21 23:46:21'),(65,16,'Gallery','gallery',1,1,1,1,'2018-06-21 23:47:02'),(66,16,'Event','event',1,1,1,1,'2018-06-21 23:47:20'),(67,16,'News','notice',1,1,1,1,'2018-07-02 21:39:34'),(80,17,'Visitor Book','visitor_book',1,1,1,1,'2018-06-21 23:48:58'),(81,17,'Phone Call Log','phone_call_log',1,1,1,1,'2018-06-21 23:50:57'),(82,17,'Postal Dispatch','postal_dispatch',1,1,1,1,'2018-06-21 23:50:21'),(83,17,'Postal Receive','postal_receive',1,1,1,1,'2018-06-21 23:50:04'),(84,17,'Complain','complain',1,1,1,1,'2018-12-18 22:11:37'),(85,17,'Setup Front Office','setup_front_office',1,1,1,1,'2018-11-14 13:49:58'),(86,18,'Staff','staff',1,1,1,1,'2018-06-21 23:53:31'),(87,18,'Disable Staff','disable_staff',1,0,0,0,'2018-06-21 23:53:12'),(88,18,'Staff Attendance','staff_attendance',1,1,1,0,'2018-06-21 23:53:10'),(89,14,'Staff Attendance Report','staff_attendance_report',1,0,0,0,'2021-09-13 02:12:50'),(90,18,'Staff Payroll','staff_payroll',1,1,1,1,'2024-08-21 09:29:55'),(91,14,'Payroll Report','payroll_report',1,0,0,0,'2021-09-13 02:13:00'),(102,21,'Calendar To Do List','calendar_to_do_list',1,1,1,1,'2018-06-21 23:54:41'),(104,10,'Item Category','item_category',1,1,1,1,'2018-06-21 23:34:33'),(108,18,' Approve Leave Request','approve_leave_request',1,1,1,1,'2018-07-01 23:17:41'),(109,18,'Apply Leave','apply_leave',1,1,0,1,'2020-08-24 14:48:58'),(110,18,'LeaveTypes','leave_types',1,1,1,1,'2021-10-26 11:54:30'),(111,18,'Department','department',1,1,1,1,'2018-06-25 16:57:07'),(112,18,'Designation','designation',1,1,1,1,'2018-06-25 16:57:07'),(118,22,'Staff Role Count Widget','staff_role_count_widget',1,0,0,0,'2018-07-02 20:13:35'),(126,15,'Users','users',1,0,0,0,'2021-09-21 19:43:59'),(127,18,'Can See Other Users Profile','can_see_other_users_profile',1,0,0,0,'2018-07-02 21:42:29'),(129,18,'Staff Timeline','staff_timeline',0,1,0,1,'2018-07-04 21:08:52'),(130,15,'Backup','backup',1,1,0,1,'2018-07-08 17:17:17'),(131,15,'Restore','restore',1,0,0,0,'2018-07-08 17:17:17'),(132,23,'OPD Patient','opd_patient',1,1,1,1,'2018-12-19 22:37:26'),(134,23,'Prescription','prescription',1,1,1,1,'2018-10-10 14:28:26'),(135,23,'Visit','visit',1,1,1,1,'2021-09-16 20:39:58'),(137,23,'OPD Timeline','opd_timeline',1,1,1,1,'2021-02-24 01:02:04'),(138,24,'IPD Patients','ipd_patient',1,1,1,1,'2018-10-10 20:14:55'),(139,24,'Discharged Patients','discharged_patients',1,1,1,1,'2021-02-24 01:27:17'),(140,24,'Consultant Register','consultant_register',1,1,1,1,'2021-02-24 01:37:07'),(142,24,'IPD Timeline','ipd_timeline',1,1,1,1,'2021-02-25 01:30:00'),(143,24,'Charges','charges',1,1,1,1,'2018-10-10 14:28:26'),(144,24,'Payment','payment',1,1,1,1,'2024-08-21 09:29:55'),(146,25,'Medicine','medicine',1,1,1,1,'2018-10-10 14:28:26'),(148,25,'Pharmacy Bill','pharmacy_bill',1,1,1,1,'2021-02-25 01:33:40'),(149,26,'Pathology Test','pathology_test',1,1,1,1,'2021-02-25 01:36:32'),(152,27,'Radiology Test','radiology_test',1,1,1,1,'2021-02-25 01:45:31'),(153,27,'Radiology  Bill','radiology_bill',1,1,1,1,'2021-09-16 18:16:48'),(155,22,'IPD Income Widget','ipd_income_widget',1,0,0,0,'2018-12-19 22:08:05'),(156,22,'OPD Income Widget','opd_income_widget',1,0,0,0,'2018-12-19 22:08:15'),(157,22,'Pharmacy Income Widget','pharmacy_income_widget',1,0,0,0,'2018-12-19 22:08:25'),(158,22,'Pathology Income Widget','pathology_income_widget',1,0,0,0,'2018-12-19 22:08:37'),(159,22,'Radiology Income Widget','radiology_income_widget',1,0,0,0,'2018-12-19 22:08:49'),(161,22,'Blood Bank Income Widget','blood_bank_income_widget',1,0,0,0,'2018-12-19 22:09:13'),(162,22,'Ambulance Income Widget','ambulance_income_widget',1,0,0,0,'2018-12-19 22:09:25'),(165,29,'Ambulance Call','ambulance_call',1,1,1,1,'2018-10-26 16:37:51'),(166,29,'Ambulance','ambulance',1,1,1,1,'2018-10-26 16:37:59'),(168,30,'Blood Issue','blood_issue',1,1,1,1,'2018-10-26 17:20:15'),(169,30,'Blood Donor','blood_donor',1,1,1,1,'2018-10-26 17:20:19'),(170,25,'Medicine Category','medicine_category',1,1,1,1,'2018-10-24 19:10:24'),(171,27,'Radiology Category','radiology_category',1,1,1,1,'2021-02-25 01:52:34'),(173,31,'Organisation','organisation',1,1,1,1,'2018-10-24 19:10:24'),(175,26,'Pathology Category','pathology_category',1,1,1,1,'2018-10-24 19:10:24'),(176,32,'Hospital Charges','hospital_charges',1,1,1,1,'2021-09-12 20:29:30'),(178,14,'IPD Report','ipd_report',1,0,0,0,'2018-12-11 23:09:24'),(179,14,'Pharmacy Bill Report','pharmacy_bill_report',1,0,0,0,'2018-12-11 23:09:24'),(180,14,'Pathology Patient Report','pathology_patient_report',1,0,0,0,'2018-12-11 23:09:24'),(181,14,'Radiology Patient Report','radiology_patient_report',1,0,0,0,'2018-12-11 23:09:24'),(182,14,'OT Report','ot_report',1,0,0,0,'2019-03-07 19:56:54'),(183,14,'Blood Donor Report','blood_donor_report',1,0,0,0,'2019-03-07 19:56:54'),(184,14,'Payroll Month Report','payroll_month_report',1,0,0,0,'2019-03-07 19:57:25'),(185,14,'Payroll Report','payroll_report',1,0,0,0,'2019-03-07 19:57:35'),(187,14,'User Log','user_log',1,0,0,0,'2018-12-11 23:09:24'),(188,14,'Patient Login Credential','patient_login_credential',1,0,0,0,'2018-12-11 23:09:24'),(189,14,'Email / SMS Log','email_sms_log',1,0,0,0,'2018-12-11 23:09:24'),(190,22,'Yearly Income & Expense Chart','yearly_income_expense_chart',1,0,0,0,'2018-12-11 23:22:05'),(191,22,'Monthly Income & Expense Chart','monthly_income_expense_chart',1,0,0,0,'2018-12-11 23:25:14'),(192,23,'OPD Prescription Print Header Footer ','opd_prescription_print_header_footer',1,0,0,0,'2024-08-21 09:29:55'),(196,24,'Bed','bed',1,1,1,1,'2018-12-11 23:46:01'),(197,24,'IPD Prescription Print Header Footer','ipd_prescription_print_header_footer',1,0,0,0,'2024-08-21 09:29:55'),(198,24,'Bed Status','bed_status',1,0,0,0,'2018-12-11 23:39:42'),(200,25,'Medicine Bad Stock','medicine_bad_stock',1,1,0,1,'2018-12-17 14:12:46'),(201,25,'Pharmacy Bill print Header Footer','pharmacy_bill_print_header_footer',1,0,0,0,'2024-08-21 09:29:55'),(202,30,'Blood Stock','blood_stock',1,1,0,1,'2021-09-10 22:49:52'),(203,32,'Charge Category','charge_category',1,1,1,1,'2018-12-12 00:19:38'),(206,14,'TPA Report','tpa_report',1,0,0,0,'2019-03-07 19:49:25'),(207,14,'Ambulance Report','ambulance_report',1,0,0,0,'2019-03-07 19:49:41'),(208,14,'Discharge Patient Report','discharge_patient_report',1,0,0,0,'2019-03-07 19:49:55'),(209,14,'Appointment Report','appointment_report',1,0,0,0,'2019-03-07 19:50:10'),(210,14,'Transaction Report','transaction_report',1,0,0,0,'2019-03-07 19:57:35'),(211,14,'Blood Issue Report','blood_issue_report',1,0,0,0,'2019-03-07 19:57:35'),(212,14,'Income Report','income_report',1,0,0,0,'2019-03-07 19:57:35'),(213,14,'Expense Report','expense_report',1,0,0,0,'2019-03-07 19:57:35'),(214,34,'Birth Record','birth_record',1,1,1,1,'2018-06-21 23:36:02'),(215,34,'Death Record','death_record',1,1,1,1,'2018-06-21 23:36:02'),(218,23,'Move Patient in IPD','opd_move_patient_in_ipd',1,0,0,0,'2021-09-16 21:00:06'),(219,23,'Manual Prescription','manual_prescription',1,0,0,0,'2019-09-22 17:52:06'),(220,24,'Prescription ','ipd_prescription',1,1,1,1,'2019-09-23 13:59:27'),(221,23,'Charges','opd_charges',1,1,1,1,'2019-09-22 17:58:03'),(222,23,'Payment','opd_payment',1,1,1,1,'2024-08-21 09:29:55'),(224,25,'Import Medicine','import_medicine',1,0,0,0,'2019-09-22 18:03:31'),(225,25,'Medicine Purchase','medicine_purchase',1,1,0,1,'2021-10-02 04:59:02'),(226,25,'Medicine Supplier','medicine_supplier',1,1,1,1,'2019-09-22 18:09:36'),(227,25,'Medicine Dosage','medicine_dosage',1,1,1,1,'2019-09-22 18:17:16'),(236,36,'Patient','patient',1,1,1,1,'2021-09-21 21:29:37'),(237,36,'Enabled/Disabled','enabled_disabled',1,0,0,0,'2019-09-22 19:25:35'),(238,22,'Notification Center','notification_center',1,0,0,0,'2019-09-23 16:48:33'),(239,36,'Import','patient_import',1,0,0,0,'2019-10-03 14:20:26'),(240,34,'Birth Print Header Footer','birth_print_header_footer',1,0,0,0,'2024-08-21 09:29:55'),(242,34,'Death Print Header Footer','death_print_header_footer',1,0,0,0,'2024-08-21 09:29:55'),(243,26,'Print Header Footer','pathology_print_header_footer',1,0,0,0,'2024-08-21 09:29:55'),(244,27,'Print Header Footer','radiology_print_header_footer',1,0,0,0,'2024-08-21 09:29:55'),(246,30,'Print Header Footer','bloodbank_print_header_footer',1,0,0,0,'2021-10-07 04:06:58'),(247,29,'Print Header Footer','ambulance_print_header_footer',1,0,0,0,'2024-08-21 09:29:55'),(248,24,'IPD Bill Print Header Footer','ipd_bill_print_header_footer',1,0,0,0,'2024-08-21 09:29:55'),(249,18,'Print Payslip Header Footer','print_payslip_header_footer',1,0,0,0,'2024-08-21 09:29:55'),(250,14,'Income Group Report','income_group_report',1,0,0,0,'2020-08-11 18:52:52'),(251,14,'Expense Group Report','expense_group_report',1,0,0,0,'2019-10-03 17:15:56'),(253,14,'Inventory Stock Report','inventory_stock_report',1,0,0,0,'2019-10-03 18:20:31'),(254,14,'Inventory Item Report','add_item_report',1,0,0,0,'2019-10-03 18:23:22'),(255,14,'Inventory Issue Report','issue_inventory_report',1,0,0,0,'2019-10-03 18:24:40'),(256,14,'Expiry Medicine Report','expiry_medicine_report',1,0,0,0,'2019-10-03 19:00:11'),(257,26,'Pathology Bill','pathology_bill',1,1,1,1,'2021-02-25 01:58:10'),(258,14,'Birth Report','birth_report',1,0,0,0,'2019-10-13 16:12:35'),(259,14,'Death Report','death_report',1,0,0,0,'2019-10-13 16:13:56'),(260,26,'Pathology Unit','pathology_unit',1,1,1,1,'2020-07-21 14:13:49'),(261,27,'Radiology Unit','radiology_unit',1,1,1,1,'2020-07-21 14:14:47'),(262,27,'Radiology Parameter','radiology_parameter',1,1,1,1,'2020-07-21 14:20:28'),(263,26,'Pathology Parameter','pathology_parameter',1,1,1,1,'2020-07-21 14:20:28'),(264,32,'Charge Type','charge_type',1,1,1,1,'2024-08-21 09:29:55'),(265,14,'OPD Balance Report','opd_balance_report',1,0,0,0,'2020-07-27 15:03:34'),(266,14,'IPD Balance Report','ipd_balance_report',1,0,0,0,'2020-07-27 15:03:34'),(267,15,'Symptoms Type','symptoms_type',1,1,1,1,'2021-09-13 21:36:22'),(269,37,'Live Consultation','live_consultation',1,1,0,1,'2020-08-12 19:19:27'),(270,37,'Live Meeting','live_meeting',1,1,0,1,'2020-08-12 19:19:27'),(271,14,'Live Consultation Report','live_consultation_report',1,0,0,0,'2021-09-13 02:11:19'),(272,14,'Live Meeting Report','live_meeting_report',1,0,0,0,'2021-09-13 02:11:14'),(273,37,'Setting','setting',1,0,1,0,'2020-08-12 20:03:28'),(274,15,'Language Switcher','language_switcher',1,0,0,0,'2020-08-20 17:48:53'),(279,15,'Symptoms Head','symptoms_head',1,1,1,1,'2021-09-13 21:36:27'),(280,18,'Specialist','specialist',1,1,1,1,'2019-10-03 10:01:33'),(281,22,'General Income Widget','general_income_widget',1,0,0,0,'2018-12-19 16:38:05'),(282,22,'Expenses Widget','expenses_widget',1,0,0,0,'2018-12-19 16:38:05'),(283,38,'Referral Category','referral_category',1,1,1,1,'2021-06-11 02:54:41'),(284,38,'Referral Commission','referral_commission',1,1,1,1,'2021-06-11 02:54:41'),(285,38,'Referral Person','referral_person',1,1,1,1,'2021-06-11 02:55:21'),(286,38,'Referral Payment','referral_payment',1,1,1,1,'2021-06-11 02:55:21'),(287,15,'Prefix Setting','prefix_setting',1,0,1,0,'2021-06-11 20:46:10'),(288,15,'Captcha Setting','captcha_setting',1,0,1,0,'2021-06-11 21:43:53'),(289,32,'Tax Category','tax_category',1,1,1,1,'2021-06-11 22:16:39'),(290,32,'Unit Type','unit_type',1,1,1,1,'2021-06-11 22:16:39'),(291,25,'Dosage Interval','dosage_interval',1,1,1,1,'2021-06-12 00:15:37'),(292,25,'Dosage Duration','dosage_duration',1,1,1,1,'2021-06-12 00:15:37'),(293,30,'Blood Bank Product','blood_bank_product',1,1,1,1,'2021-06-12 00:51:23'),(294,39,'Slot','online_appointment_slot',1,1,1,1,'2021-09-14 01:04:31'),(295,39,'Doctor Shift','online_appointment_doctor_shift',1,0,1,0,'2021-06-12 01:43:48'),(296,39,'Shift','online_appointment_shift',1,1,1,1,'2021-06-12 01:24:25'),(297,39,'Doctor Wise Appointment','doctor_wise_appointment',1,0,0,0,'2021-10-07 01:45:39'),(298,39,'Patient Queue','patient_queue',1,0,0,0,'2021-10-07 01:45:42'),(299,23,'OPD Medication','opd_medication',1,1,1,1,'2021-06-14 20:00:12'),(300,24,'IPD Medication','ipd_medication',1,1,1,1,'2021-06-14 20:00:12'),(301,24,'Bed History','bed_history',1,0,0,0,'2021-06-14 20:00:12'),(302,30,'Blood Bank Components','blood_bank_components',1,1,0,1,'2021-06-15 00:46:48'),(303,23,'Operation Theatre','opd_operation_theatre',1,1,1,1,'2021-09-07 22:49:13'),(304,23,'Lab Investigation','opd_lab_investigation',1,0,0,0,'2021-09-06 19:36:10'),(305,23,'Patient Discharge','opd_patient_discharge',1,0,1,0,'2021-09-06 19:39:16'),(306,23,'Patient Discharge Revert','opd_patient_discharge_revert',1,0,0,0,'2021-09-06 19:39:38'),(307,23,'Treatment History','opd_treatment_history',1,0,0,0,'2021-09-06 19:49:05'),(308,24,'Lab Investigation','ipd_lab_investigation',1,0,0,0,'2021-09-06 20:45:59'),(309,24,'Patient Discharge','ipd_patient_discharge',1,0,1,0,'2021-09-06 22:08:20'),(310,24,'Patient Discharge Revert','ipd_patient_discharge_revert',1,0,0,0,'2021-09-06 22:14:54'),(311,30,'Issue Component','issue_component',1,1,1,1,'2021-09-06 22:21:53'),(312,26,'	Add/Edit Collection Person','pathology_add_edit_collection_person',1,0,1,0,'2021-09-16 20:06:13'),(313,25,'Partial Payment','pharmacy_partial_payment',1,1,0,1,'2021-09-07 01:10:15'),(314,26,'Partial Payment','pathology_partial_payment',1,1,0,1,'2021-09-07 02:34:33'),(315,27,'Partial Payment','radiology_partial_payment',1,1,0,1,'2021-09-07 02:38:15'),(316,28,'Partial Payment','radiology_partial_payment',1,1,0,1,'2021-09-07 02:39:02'),(317,30,'Partial Payment','blood_bank_partial_payment',1,1,0,1,'2021-09-07 02:47:22'),(318,29,'Partial Payment','ambulance_partial_payment',1,1,0,1,'2021-09-07 02:48:10'),(319,23,'Checkup','checkup',1,1,1,1,'2021-09-16 20:40:33'),(320,23,'Print Bill','opd_print_bill',1,0,0,0,'2021-09-07 23:09:27'),(321,23,'Live Consult','opd_live_consult',1,0,0,0,'2021-09-08 00:53:31'),(322,24,'Nurse Note','nurse_note',1,1,1,1,'2021-09-08 01:20:07'),(323,24,'Bed Type','bed_type',1,1,1,1,'2021-09-08 20:06:39'),(324,24,'Bed Group','bed_group',1,1,1,1,'2021-09-08 20:07:08'),(325,24,'Floor','floor',1,1,1,1,'2021-09-08 20:08:35'),(326,24,'Operation Theatre','ipd_operation_theatre',1,1,1,1,'2021-09-08 22:38:14'),(327,24,'Live Consult','ipd_live_consultation',1,0,0,0,'2021-09-08 23:05:26'),(329,24,'Treatment History','ipd_treatment_history',1,0,0,0,'2021-09-06 20:45:59'),(330,41,'OPD Billing','opd_billing',1,0,0,0,'2021-09-09 00:33:14'),(331,41,'OPD Billing Payment','opd_billing_payment',1,1,0,0,'2021-09-09 01:10:36'),(332,41,'IPD Billing','ipd_billing',1,0,0,0,'2021-09-09 00:52:26'),(333,41,'IPD Billing Payment','ipd_billing_payment',1,1,0,0,'2021-09-09 00:53:03'),(334,41,'Pharmacy Billing','pharmacy_billing',1,0,0,0,'2021-09-09 00:53:03'),(335,41,'Pharmacy Billing Payment','pharmacy_billing_payment',1,1,0,0,'2021-09-09 00:53:03'),(336,41,'Pathology Billing','pathology_billing',1,0,0,0,'2021-09-09 00:53:03'),(337,41,'Pathology Billing Payment','pathology_billing_payment',1,1,0,0,'2021-09-09 00:53:03'),(338,41,'Radiology Billing','radiology_billing',1,0,0,0,'2021-09-09 00:53:03'),(339,41,'Radiology Billing Payment','radiology_billing_payment',1,1,0,0,'2021-09-09 00:53:03'),(340,41,'Blood Bank Billing','blood_bank_billing',1,0,0,0,'2021-09-09 00:53:03'),(341,41,'Blood Bank Billing Payment','blood_bank_billing_payment',1,1,0,0,'2021-09-09 00:53:03'),(342,41,'Ambulance Billing','ambulance_billing',1,0,0,0,'2021-09-09 00:53:03'),(343,41,'Ambulance Billing Payment','ambulance_billing_payment',1,1,0,0,'2021-09-09 00:53:03'),(344,41,'Generate Bill','generate_bill',1,0,0,0,'2021-09-09 20:36:09'),(345,41,'Generate Discharge Card','generate_discharge_card',1,0,0,0,'2021-09-09 00:53:03'),(346,40,'Online Appointment','online_appointment',1,0,0,0,'2021-09-09 02:15:17'),(347,31,'TPA Charges ','tpa_charges',1,0,1,1,'2018-10-24 19:10:24'),(348,15,'System Notification Setting','system_notification_setting',1,0,1,0,'2018-07-04 22:08:41'),(349,14,'All Transaction Report','all_transaction_report',1,0,0,0,'2021-09-13 02:29:20'),(350,14,'Patient Visit Report','patient_visit_report',1,0,0,0,'2019-10-03 18:23:22'),(351,14,'Patient Bill Report','patient_bill_report',1,0,0,0,'2019-10-03 17:15:56'),(352,14,'Referral Report','referral_report',1,0,0,0,'2019-10-03 17:15:56'),(353,27,'Add/Edit Collection Person','radiology_add_edit_collection_person',1,0,1,0,'2021-09-16 20:06:41'),(354,27,'Add/Edit  Report','radiology_add_edit_report',1,0,1,0,'2021-09-16 20:06:50'),(355,26,'Add/Edit Report','pathology_add_edit_report',1,0,1,0,'2021-09-16 20:06:24'),(362,42,'Generate Certificate','generate_certificate',1,0,0,0,'2021-09-20 16:48:25'),(363,42,'Certificate','certificate',1,1,1,1,'2021-09-20 16:48:25'),(364,42,'Generate Staff ID Card','generate_staff_id_card',1,0,0,0,'2021-09-20 16:56:38'),(365,42,'Staff ID Card','staff_id_card',1,1,1,1,'2021-09-20 16:56:09'),(366,42,'Generate Patient ID Card','generate_patient_id_card',1,0,0,0,'2021-09-20 23:13:54'),(367,42,'Patient ID Card','patient_id_card',1,1,1,1,'2021-09-20 16:54:38'),(369,14,'Component Issue Report','component_issue_report',1,0,0,0,'2019-03-07 19:57:35'),(370,14,'Audit Trail Report','audit_trail_report',1,0,0,0,'2021-09-28 01:08:22'),(371,43,'Chat','chat',1,0,0,0,'2021-10-07 05:05:15'),(372,15,'Custom Fields','custom_fields',1,0,0,0,'2021-10-29 07:41:26'),(373,14,'Daily Transaction Report','daily_transaction_report',1,0,0,0,'2021-10-29 07:42:08'),(374,15,'Operation','operation',1,1,1,1,'2021-10-29 07:45:14'),(375,15,'Operation Category','operation_category',1,1,1,1,'2021-10-29 07:45:14'),(386,39,'Appointment','appointment',1,1,0,1,'2021-12-24 09:36:15'),(387,39,'Reschedule','reschedule',1,0,0,0,'2021-12-24 09:36:15'),(388,15,'Finding','finding',1,1,1,1,'2021-10-29 07:45:14'),(389,15,'Finding Category','finding_category',1,1,1,1,'2021-10-29 07:45:14'),(390,41,'Appointment Billing','appointment_billing',1,0,0,0,'2021-09-09 00:53:03'),(391,15,'Vital','vital',1,1,1,1,'2021-10-29 07:45:14'),(392,23,'OPD Vitals','opd_vitals',1,1,1,1,'2018-12-19 22:37:26'),(393,24,'IPD Vitals','ipd_vitals',1,1,1,1,'2021-02-25 01:30:00'),(394,24,'Previous Obstetric History','ipd_previous_obstetric_history',1,1,1,1,'2021-02-25 01:30:00'),(395,24,'Postnatal History','ipd_postnatal_history',1,1,1,1,'2021-02-25 01:30:00'),(396,24,'Antenatal','ipd_antenatal',1,1,1,1,'2021-02-25 01:30:00'),(397,39,'Print Appointment Header Footer','print_appointment_header_footer',1,0,0,0,'2024-02-29 09:05:48'),(398,23,'Antenatal','opd_antenatal',1,1,1,1,'2024-03-11 11:24:19'),(399,41,'Payment Receipt Header Footer','payment_receipt_header_footer',1,0,0,0,'2024-02-29 10:44:39'),(400,13,'Send Credential','send_credential',1,0,0,0,'2024-02-29 10:44:43'),(401,24,'IPD Antenatal Finding Print Header Footer','ipd_antenatal_finding_print_header_footer',1,0,0,0,'2024-02-29 10:44:47'),(402,23,'OPD Antenatal Finding Print Header Footer ','opd_antenatal_finding_print_header_footer',1,0,0,0,'2024-02-29 10:44:52'),(403,24,'Discharge Summary Print Header Footer','discharge_summary_print_header_footer',1,0,0,0,'2024-02-29 10:44:57'),(404,24,'IPD Obstetric History Print Header Footer','ipd_obstetric_history_print_header_footer',1,0,0,0,'2024-02-29 10:44:47'),(405,39,'Appointment Priority','appointment_priority',1,1,1,1,'2021-06-12 01:24:25'),(406,25,'Unit','medicine_unit',1,1,1,1,'2018-10-24 19:10:24'),(407,25,'Company','medicine_company',1,1,1,1,'2018-10-24 19:10:24'),(408,25,'Medicine Group','medicine_group',1,1,1,1,'2018-10-24 19:10:24'),(409,8,'Content Share List','content_share_list',1,0,0,1,'2024-04-20 06:05:46'),(410,8,'Upload/Share Content','upload_share_content',1,1,0,1,'2024-04-20 06:41:55'),(411,8,'Generate URL','generate_url',1,0,0,0,'2024-04-20 06:41:55'),(412,8,'Share','share_content',1,0,0,0,'2024-04-20 06:41:55'),(413,23,'OPD Bill Print Header Footer','opd_bill_print_header_footer',1,0,1,0,'2024-05-01 12:39:20'),(414,15,'Attendance Setting','attendance_setting',1,0,1,0,'2018-07-04 22:08:35'),(415,44,'Duty Roster','duty_roster',1,0,0,0,'2018-07-04 22:08:35'),(416,44,'Shift','roster_shift',1,1,1,1,'2024-08-08 09:03:23'),(417,44,'Roster List','roster_list',1,1,1,1,'2018-07-04 22:08:35'),(418,44,'Roster Assign','roster_assign',1,1,1,1,'2018-07-04 22:08:35'),(419,45,'Annual Calendar','annual_calendar',1,1,1,1,'2018-07-04 22:08:35'),(420,46,'Physiotherapy Patient','physiotherapy_patient',1,1,1,1,'2026-11-07 21:53:41'),(421,46,'Physiotherapy Bill','physiotherapy_billing',1,1,1,1,'2026-11-07 21:53:41'),(422,46,'Physiotherapy Report','physiotherapy_report',1,0,0,0,'2026-11-07 21:53:41'),(423,46,'Physiotherapy Print Header Footer','physiotherapy_print_header_footer',1,0,1,0,'2026-11-07 23:19:46'),(424,47,'Pediatric Patient','pediatric_patient',1,1,1,1,'2026-11-08 11:32:32'),(425,47,'Pediatric Bill','pediatric_billing',1,1,1,1,'2026-11-08 11:32:32'),(426,47,'Pediatric Report','pediatric_report',1,0,0,0,'2026-11-08 11:32:32'),(427,47,'Pediatric Print Header Footer','pediatric_print_header_footer',1,0,1,0,'2026-11-08 11:32:32'),(428,48,'Gynaecology Patient','gynaecology_patient',1,1,1,1,'2026-11-08 12:08:35'),(429,48,'Gynaecology Bill','gynaecology_billing',1,1,1,1,'2026-11-08 12:08:35'),(430,48,'Gynaecology Report','gynaecology_report',1,0,0,0,'2026-11-08 12:08:35'),(431,48,'Gynaecology Print Header Footer','gynaecology_print_header_footer',1,0,1,0,'2026-11-08 12:08:35');
/*!40000 ALTER TABLE `permission_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permission_group`
--

DROP TABLE IF EXISTS `permission_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permission_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `short_code` varchar(100) NOT NULL,
  `is_active` int(11) DEFAULT 0,
  `system` int(11) NOT NULL,
  `sort_order` decimal(10,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `index_name` (`name`),
  KEY `index_short_code` (`short_code`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permission_group`
--

LOCK TABLES `permission_group` WRITE;
/*!40000 ALTER TABLE `permission_group` DISABLE KEYS */;
INSERT INTO `permission_group` VALUES (3,'Income','income',1,0,15.00,'2021-10-22 00:07:50'),(4,'Expense','expense',1,0,16.00,'2021-10-22 00:07:55'),(8,'Download Center','download_center',1,0,19.00,'2021-10-22 00:13:38'),(10,'Inventory','inventory',1,0,18.00,'2021-10-22 00:13:22'),(13,'Messaging','communicate',1,0,17.00,'2021-10-22 00:13:08'),(14,'Reports','reports',1,1,23.00,'2021-10-22 00:14:35'),(15,'System Settings','system_settings',1,1,24.00,'2021-10-22 00:16:02'),(16,'Front CMS','front_cms',1,0,21.00,'2021-10-22 00:14:07'),(17,'Front Office','front_office',1,0,10.00,'2021-10-22 00:05:56'),(18,'Human Resource','human_resource',1,1,12.00,'2021-10-22 00:06:27'),(21,'Calendar To Do List','calendar_to_do_list',1,0,28.00,'2021-10-22 00:22:27'),(22,'Dashboard and Widgets','dashboard_and_widgets',1,1,0.01,'2021-10-22 00:18:00'),(23,'OPD','opd',1,0,3.00,'2021-10-22 00:04:29'),(24,'IPD','ipd',1,0,4.00,'2021-10-22 00:04:38'),(25,'Pharmacy','pharmacy',1,0,5.00,'2021-10-22 00:04:47'),(26,'Pathology','pathology',1,0,6.00,'2021-10-22 00:04:59'),(27,'Radiology','radiology',1,0,7.00,'2021-10-22 00:05:09'),(29,'Ambulance','ambulance',1,0,9.00,'2021-10-22 00:05:31'),(30,'Blood Bank','blood_bank',1,0,8.00,'2021-10-22 00:05:21'),(31,'TPA Management','tpa_management',1,0,14.00,'2021-10-22 00:06:58'),(32,'Hospital Charges','hospital_charges',1,1,26.00,'2021-10-22 00:19:04'),(34,'Birth Death Record','birth_death_report',1,0,11.00,'2021-10-22 00:06:10'),(36,'Patient','patient',1,0,25.00,'2021-10-22 00:18:46'),(37,'Live Consultation','live_consultation',1,0,22.00,'2021-10-22 00:14:21'),(38,'Referral','referral',1,0,13.00,'2021-10-22 00:06:48'),(39,'Appointment','appointment',1,0,2.00,'2021-10-22 00:04:15'),(41,'Billing','bill',1,0,1.00,'2024-08-21 09:29:55'),(42,'Certificate','certificate',1,0,20.00,'2021-10-04 03:36:58'),(43,'Chat','chat',1,0,27.00,'2021-10-22 00:22:19'),(44,'Duty Roster','duty_roster',1,0,12.10,'2024-08-09 10:37:56'),(45,'Annual Calendar','annual_calendar',1,0,12.20,'2024-08-17 06:32:13'),(46,'Physiotherapy','physiotherapy',1,0,28.00,'2026-11-07 21:53:41'),(47,'Pediatric','pediatric',1,0,29.00,'2026-11-08 11:32:32'),(48,'Gynaecology','gynaecology',1,0,30.00,'2026-11-08 12:08:35');
/*!40000 ALTER TABLE `permission_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permission_patient`
--

DROP TABLE IF EXISTS `permission_patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permission_patient` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permission_group_short_code` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `short_code` varchar(100) NOT NULL,
  `is_active` int(11) DEFAULT NULL,
  `system` int(11) NOT NULL,
  `sort_order` decimal(10,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `index_permission_group_short_code` (`permission_group_short_code`),
  KEY `index_name` (`name`),
  KEY `index_short_code` (`short_code`),
  KEY `index_is_active` (`is_active`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permission_patient`
--

LOCK TABLES `permission_patient` WRITE;
/*!40000 ALTER TABLE `permission_patient` DISABLE KEYS */;
INSERT INTO `permission_patient` VALUES (1,'appointment','My Appointments','my_appointments',1,0,1.00,'2021-09-27 13:17:05'),(2,'opd','OPD','opd',1,0,2.00,'2021-09-27 13:17:21'),(3,'ipd','IPD','ipd',1,0,3.00,'2021-09-25 09:33:07'),(4,'pharmacy','Pharmacy','pharmacy',1,0,4.00,'2021-09-25 06:03:29'),(5,'pathology','Pathology','pathology',1,0,5.00,'2021-09-27 13:15:45'),(6,'radiology','Radiology','radiology',1,0,6.00,'2021-09-27 13:15:47'),(7,'ambulance','Ambulance','ambulance',1,0,7.00,'2021-09-27 13:15:50'),(8,'blood_bank','Blood Bank','blood_bank',1,0,8.00,'2021-09-24 07:40:59'),(9,'live_consultation','Live Consultation','live_consultation',1,0,9.00,'2021-09-27 13:16:49'),(10,'calendar_to_do_list','Calendar To Do List','calendar_to_do_list',1,0,11.00,'2021-10-04 09:07:25'),(11,'chat','Chat','chat',1,0,11.00,'2021-10-04 07:34:59'),(12,'download_center','Download Center','download_center',1,0,12.00,'2024-06-26 12:29:50');
/*!40000 ALTER TABLE `permission_patient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pharmacy`
--

DROP TABLE IF EXISTS `pharmacy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pharmacy` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `medicine_name` varchar(200) DEFAULT NULL,
  `medicine_category_id` int(11) DEFAULT NULL,
  `medicine_image` text NOT NULL,
  `medicine_company` varchar(100) DEFAULT NULL,
  `medicine_composition` varchar(100) DEFAULT NULL,
  `medicine_group` varchar(100) DEFAULT NULL,
  `unit` varchar(50) DEFAULT NULL,
  `min_level` varchar(50) DEFAULT NULL,
  `reorder_level` varchar(50) DEFAULT NULL,
  `vat` float DEFAULT NULL,
  `unit_packing` varchar(50) DEFAULT NULL,
  `vat_ac` varchar(50) DEFAULT NULL,
  `rack_number` varchar(255) NOT NULL,
  `note` text DEFAULT NULL,
  `is_active` varchar(10) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `medicine_category_id` (`medicine_category_id`),
  KEY `idx_medicine_name` (`medicine_name`),
  KEY `index_medicine_name` (`medicine_name`),
  KEY `index_medicine_company` (`medicine_company`),
  KEY `index_medicine_composition` (`medicine_composition`),
  KEY `index_medicine_group` (`medicine_group`),
  KEY `index_unit` (`unit`),
  KEY `index_min_level` (`min_level`),
  KEY `index_reorder_level` (`reorder_level`),
  KEY `index_vat` (`vat`),
  KEY `index_unit_packing` (`unit_packing`),
  KEY `index_vat_ac` (`vat_ac`),
  KEY `index_rack_number` (`rack_number`),
  CONSTRAINT `pharmacy_ibfk_1` FOREIGN KEY (`medicine_category_id`) REFERENCES `medicine_category` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pharmacy`
--

LOCK TABLES `pharmacy` WRITE;
/*!40000 ALTER TABLE `pharmacy` DISABLE KEYS */;
/*!40000 ALTER TABLE `pharmacy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pharmacy_bill_basic`
--

DROP TABLE IF EXISTS `pharmacy_bill_basic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pharmacy_bill_basic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `ipd_prescription_basic_id` int(11) DEFAULT NULL,
  `case_reference_id` int(11) DEFAULT NULL,
  `customer_name` varchar(50) DEFAULT NULL,
  `customer_type` varchar(50) DEFAULT NULL,
  `doctor_name` varchar(50) DEFAULT NULL,
  `file` varchar(200) NOT NULL,
  `total` float(10,2) DEFAULT 0.00,
  `discount_percentage` float(10,2) DEFAULT 0.00,
  `discount` float(10,2) DEFAULT 0.00,
  `tax_percentage` float(10,2) DEFAULT 0.00,
  `tax` float(10,2) DEFAULT 0.00,
  `net_amount` float(10,2) DEFAULT 0.00,
  `note` text DEFAULT NULL,
  `generated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `patient_id` (`patient_id`),
  KEY `case_reference_id` (`case_reference_id`),
  KEY `generated_by` (`generated_by`),
  KEY `ipd_prescription_basic_id` (`ipd_prescription_basic_id`),
  KEY `index_customer_name` (`customer_name`),
  KEY `index_customer_type` (`customer_type`),
  KEY `index_doctor_name` (`doctor_name`),
  KEY `index_total` (`total`),
  KEY `index_discount_percentage` (`discount_percentage`),
  KEY `index_discount` (`discount`),
  KEY `index_tax_percentage` (`tax_percentage`),
  KEY `index_tax` (`tax`),
  KEY `index_net_amount` (`net_amount`),
  CONSTRAINT `pharmacy_bill_basic_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE,
  CONSTRAINT `pharmacy_bill_basic_ibfk_2` FOREIGN KEY (`case_reference_id`) REFERENCES `case_references` (`id`) ON DELETE CASCADE,
  CONSTRAINT `pharmacy_bill_basic_ibfk_3` FOREIGN KEY (`generated_by`) REFERENCES `staff` (`id`) ON DELETE CASCADE,
  CONSTRAINT `pharmacy_bill_basic_ibfk_4` FOREIGN KEY (`ipd_prescription_basic_id`) REFERENCES `ipd_prescription_basic` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pharmacy_bill_basic`
--

LOCK TABLES `pharmacy_bill_basic` WRITE;
/*!40000 ALTER TABLE `pharmacy_bill_basic` DISABLE KEYS */;
/*!40000 ALTER TABLE `pharmacy_bill_basic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pharmacy_bill_detail`
--

DROP TABLE IF EXISTS `pharmacy_bill_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pharmacy_bill_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pharmacy_bill_basic_id` int(11) DEFAULT NULL,
  `medicine_batch_detail_id` int(11) DEFAULT NULL,
  `quantity` varchar(100) NOT NULL,
  `sale_price` float(10,2) NOT NULL,
  `amount` float(10,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `pharmacy_bill_basic_id` (`pharmacy_bill_basic_id`),
  KEY `medicine_batch_detail_id` (`medicine_batch_detail_id`),
  KEY `index_quantity` (`quantity`),
  KEY `index_sale_price` (`sale_price`),
  KEY `index_amount` (`amount`),
  CONSTRAINT `pharmacy_bill_detail_ibfk_1` FOREIGN KEY (`pharmacy_bill_basic_id`) REFERENCES `pharmacy_bill_basic` (`id`) ON DELETE CASCADE,
  CONSTRAINT `pharmacy_bill_detail_ibfk_2` FOREIGN KEY (`medicine_batch_detail_id`) REFERENCES `medicine_batch_details` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pharmacy_bill_detail`
--

LOCK TABLES `pharmacy_bill_detail` WRITE;
/*!40000 ALTER TABLE `pharmacy_bill_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `pharmacy_bill_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pharmacy_company`
--

DROP TABLE IF EXISTS `pharmacy_company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pharmacy_company` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_name` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `index_company_name` (`company_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pharmacy_company`
--

LOCK TABLES `pharmacy_company` WRITE;
/*!40000 ALTER TABLE `pharmacy_company` DISABLE KEYS */;
/*!40000 ALTER TABLE `pharmacy_company` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `physiotherapy`
--

DROP TABLE IF EXISTS `physiotherapy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `physiotherapy` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `height` varchar(20) DEFAULT NULL,
  `weight` varchar(20) DEFAULT NULL,
  `bp` varchar(20) DEFAULT NULL,
  `symptoms` text DEFAULT NULL,
  `note` text DEFAULT NULL,
  `assessment_treatment` varchar(255) DEFAULT NULL,
  `diagnosis` text DEFAULT NULL,
  `referring_doctor` varchar(150) DEFAULT NULL,
  `pain_level` varchar(50) DEFAULT NULL,
  `pain_location` varchar(150) DEFAULT NULL,
  `physiotherapy_assessment` text DEFAULT NULL,
  `treatment_exercise` text DEFAULT NULL,
  `physiotherapist_id` int(11) NOT NULL,
  `session_date` datetime NOT NULL,
  `session_duration` varchar(50) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `organisation_id` int(11) DEFAULT NULL,
  `charge_id` int(11) DEFAULT NULL,
  `standard_charge` float(10,2) DEFAULT 0.00,
  `apply_charge` float(10,2) DEFAULT 0.00,
  `generated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `patient_id` (`patient_id`),
  KEY `physiotherapist_id` (`physiotherapist_id`),
  KEY `charge_id` (`charge_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `physiotherapy`
--

LOCK TABLES `physiotherapy` WRITE;
/*!40000 ALTER TABLE `physiotherapy` DISABLE KEYS */;
INSERT INTO `physiotherapy` VALUES (1,'PHYB1',1,'175 cm','70 kg','120/80','Lower back stiffness and pain after lifting','Patient reports recurring pain for 2 weeks','Spinal mobilization & stretching','Lumbar strain','Dr. Smith','6','Lower Back / L4-L5','Decreased lumbar flexion with muscle spasm','Core stabilization & Heat therapy',1,'2026-11-08 10:00:00','45 Mins','Follow-up session scheduled in 3 days',NULL,NULL,150.00,150.00,1,'2026-11-07 22:21:18');
/*!40000 ALTER TABLE `physiotherapy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `physiotherapy_instructions`
--

DROP TABLE IF EXISTS `physiotherapy_instructions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `physiotherapy_instructions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `physiotherapy_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `consultant_doctor` int(11) NOT NULL,
  `instruction` text NOT NULL,
  `instruction_date` datetime NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `physiotherapy_id` (`physiotherapy_id`),
  KEY `patient_id` (`patient_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `physiotherapy_instructions`
--

LOCK TABLES `physiotherapy_instructions` WRITE;
/*!40000 ALTER TABLE `physiotherapy_instructions` DISABLE KEYS */;
INSERT INTO `physiotherapy_instructions` VALUES (1,1,1,1,'Continue heat pack application twice daily. Begin gentle pelvic tilts.','2026-11-08 11:00:00','2026-11-07 22:21:55');
/*!40000 ALTER TABLE `physiotherapy_instructions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `postnatal_examine`
--

DROP TABLE IF EXISTS `postnatal_examine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `postnatal_examine` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) NOT NULL,
  `labor_time` datetime NOT NULL,
  `delivery_time` datetime NOT NULL,
  `routine_question` text NOT NULL,
  `general_remark` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `patient_id` (`patient_id`),
  KEY `index_labor_time` (`labor_time`),
  KEY `index_delivery_time` (`delivery_time`),
  CONSTRAINT `postnatal_examine_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `postnatal_examine`
--

LOCK TABLES `postnatal_examine` WRITE;
/*!40000 ALTER TABLE `postnatal_examine` DISABLE KEYS */;
/*!40000 ALTER TABLE `postnatal_examine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prefixes`
--

DROP TABLE IF EXISTS `prefixes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prefixes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(100) DEFAULT NULL,
  `prefix` varchar(20) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `index_type` (`type`),
  KEY `index_prefix` (`prefix`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prefixes`
--

LOCK TABLES `prefixes` WRITE;
/*!40000 ALTER TABLE `prefixes` DISABLE KEYS */;
INSERT INTO `prefixes` VALUES (1,'ipd_no','IPDN','2021-06-30 17:40:23'),(2,'opd_no','OPDN','2021-02-22 13:38:01'),(3,'ipd_prescription','IPDP','2021-02-12 18:42:07'),(4,'opd_prescription','OPDP','2021-02-12 18:42:17'),(5,'appointment','APPN','2021-10-22 05:37:43'),(6,'pharmacy_billing','PHAB','2021-10-22 05:37:43'),(7,'operation_theater_reference_no','OTRN','2021-10-22 05:37:43'),(8,'blood_bank_billing','BLBB','2021-10-22 05:40:38'),(9,'ambulance_call_billing','AMCB','2021-10-22 05:40:38'),(10,'radiology_billing','RADB','2021-10-22 05:40:38'),(11,'pathology_billing','PATB','2021-10-22 05:40:38'),(12,'checkup_id','OCID','2021-10-22 05:44:25'),(13,'purchase_no','PHPN','2021-10-22 05:44:25'),(14,'transaction_id','TRID','2021-10-22 05:44:25'),(15,'birth_record_reference_no','BRRN','2021-10-22 05:44:25'),(16,'death_record_reference_no','DRRN','2021-10-22 05:44:25'),(17,'physiotherapy_billing','PHYB','2026-11-07 21:53:41'),(18,'pediatric_billing','PEDB','2026-11-08 11:32:32'),(19,'gynaecology_billing','GYNB','2026-11-08 12:08:35');
/*!40000 ALTER TABLE `prefixes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `primary_examine`
--

DROP TABLE IF EXISTS `primary_examine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `primary_examine` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ipdid` int(11) DEFAULT NULL,
  `visit_details_id` int(11) DEFAULT NULL,
  `bleeding` varchar(250) DEFAULT NULL,
  `headache` varchar(250) DEFAULT NULL,
  `pain` varchar(250) DEFAULT NULL,
  `constipation` varchar(250) DEFAULT NULL,
  `urinary_symptoms` varchar(250) NOT NULL,
  `vomiting` varchar(250) DEFAULT NULL,
  `cough` varchar(250) DEFAULT NULL,
  `vaginal` varchar(250) DEFAULT NULL,
  `discharge` varchar(250) DEFAULT NULL,
  `oedema` varchar(250) DEFAULT NULL,
  `haemoroids` varchar(250) DEFAULT NULL,
  `weight` varchar(250) NOT NULL,
  `height` varchar(11) NOT NULL,
  `date` datetime DEFAULT NULL,
  `general_condition` text NOT NULL,
  `finding_remark` varchar(250) NOT NULL,
  `pelvic_examination` text NOT NULL,
  `sp` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `visit_details_id` (`visit_details_id`),
  KEY `ipdid` (`ipdid`),
  KEY `index_bleeding` (`bleeding`),
  KEY `index_headache` (`headache`),
  KEY `index_pain` (`pain`),
  KEY `index_constipation` (`constipation`),
  KEY `index_urinary_symptoms` (`urinary_symptoms`),
  KEY `index_vomiting` (`vomiting`),
  KEY `index_cough` (`cough`),
  KEY `index_vaginal` (`vaginal`),
  KEY `index_discharge` (`discharge`),
  KEY `index_oedema` (`oedema`),
  KEY `index_haemoroids` (`haemoroids`),
  KEY `index_weight` (`weight`),
  KEY `index_height` (`height`),
  KEY `index_date` (`date`),
  CONSTRAINT `primary_examine_ibfk_1` FOREIGN KEY (`visit_details_id`) REFERENCES `visit_details` (`id`) ON DELETE CASCADE,
  CONSTRAINT `primary_examine_ibfk_2` FOREIGN KEY (`ipdid`) REFERENCES `ipd_details` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `primary_examine`
--

LOCK TABLES `primary_examine` WRITE;
/*!40000 ALTER TABLE `primary_examine` DISABLE KEYS */;
/*!40000 ALTER TABLE `primary_examine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `print_setting`
--

DROP TABLE IF EXISTS `print_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `print_setting` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `print_header` text NOT NULL,
  `print_footer` text NOT NULL,
  `setting_for` varchar(200) NOT NULL,
  `is_active` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `print_setting`
--

LOCK TABLES `print_setting` WRITE;
/*!40000 ALTER TABLE `print_setting` DISABLE KEYS */;
INSERT INTO `print_setting` VALUES (1,'uploads/printing/1.jpg','','opdpre','yes','2021-09-25 06:44:20'),(2,'uploads/printing/2.jpg','','opd','yes','2021-09-25 06:44:20'),(3,'uploads/printing/3.jpg','','ipdpres','yes','2021-09-25 06:44:20'),(4,'uploads/printing/4.jpg','','ipd','yes','2021-09-25 06:44:20'),(5,'uploads/printing/5.jpg','','bill','yes','2021-09-25 06:44:20'),(6,'uploads/printing/6.jpg','','pharmacy','yes','2021-09-25 06:44:20'),(7,'uploads/printing/7.jpg','','payslip','yes','2021-09-25 06:44:20'),(8,'uploads/printing/8.jpg','','paymentreceipt','yes','2021-09-25 06:44:20'),(9,'uploads/printing/9.jpg','','birth','yes','2021-09-25 06:44:20'),(10,'uploads/printing/10.jpg','','death','yes','2021-09-25 06:44:20'),(11,'uploads/printing/11.jpg','','pathology','yes','2021-09-25 06:44:20'),(12,'uploads/printing/12.jpg','','radiology','yes','2021-09-25 06:44:20'),(13,'uploads/printing/13.jpg','','ot','yes','2021-09-25 06:44:20'),(14,'uploads/printing/14.jpg','','bloodbank','yes','2021-09-25 06:44:20'),(15,'uploads/printing/15.jpg','','ambulance','yes','2021-09-25 06:44:20'),(16,'uploads/printing/16.jpg','','discharge_card','yes','2021-09-25 06:44:20'),(17,'uploads/printing/17.jpg','','obstetric_history','yes','2021-09-25 06:44:20'),(18,'uploads/printing/18.jpg','','opd_antenatal_finding','yes','2021-09-25 06:44:20'),(19,'uploads/printing/19.jpg','','ipd_antenatal_finding','yes','2021-09-25 06:44:20'),(20,'uploads/printing/20.jpg','','appointment','yes','2021-09-25 06:44:20'),(21,'','','physiotherapy','yes','2026-11-07 21:53:41'),(22,'','','pediatric','yes','2026-11-08 11:32:32'),(23,'','','gynaecology','yes','2026-11-08 12:08:35');
/*!40000 ALTER TABLE `print_setting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `radio`
--

DROP TABLE IF EXISTS `radio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `radio` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `test_name` varchar(255) DEFAULT NULL,
  `short_name` varchar(100) DEFAULT NULL,
  `test_type` varchar(100) DEFAULT NULL,
  `radiology_category_id` int(11) DEFAULT NULL,
  `sub_category` varchar(50) NOT NULL,
  `report_days` varchar(50) NOT NULL,
  `charge_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `charge_id` (`charge_id`),
  KEY `index_test_name` (`test_name`),
  KEY `index_short_name` (`short_name`),
  KEY `index_test_type` (`test_type`),
  CONSTRAINT `radio_ibfk_1` FOREIGN KEY (`charge_id`) REFERENCES `charges` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `radio`
--

LOCK TABLES `radio` WRITE;
/*!40000 ALTER TABLE `radio` DISABLE KEYS */;
/*!40000 ALTER TABLE `radio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `radiology_billing`
--

DROP TABLE IF EXISTS `radiology_billing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `radiology_billing` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) DEFAULT NULL,
  `case_reference_id` int(11) DEFAULT NULL,
  `ipd_prescription_basic_id` int(11) DEFAULT NULL,
  `doctor_id` int(11) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `doctor_name` varchar(100) NOT NULL,
  `total` float(10,2) NOT NULL,
  `discount_percentage` float(10,2) NOT NULL,
  `discount` float(10,2) NOT NULL,
  `tax_percentage` float(10,2) NOT NULL,
  `tax` float(10,2) NOT NULL,
  `net_amount` float(10,2) NOT NULL,
  `transaction_id` int(11) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `organisation_id` int(11) DEFAULT NULL,
  `insurance_validity` date DEFAULT NULL,
  `insurance_id` varchar(250) DEFAULT NULL,
  `generated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `patient_id` (`patient_id`),
  KEY `case_reference_id` (`case_reference_id`),
  KEY `doctor_id` (`doctor_id`),
  KEY `transaction_id` (`transaction_id`),
  KEY `generated_by` (`generated_by`),
  KEY `ipd_prescription_basic_id` (`ipd_prescription_basic_id`),
  KEY `index_date` (`date`),
  KEY `index_doctor_name` (`doctor_name`),
  KEY `index_total` (`total`),
  KEY `index_discount_percentage` (`discount_percentage`),
  KEY `index_discount` (`discount`),
  KEY `index_tax_percentage` (`tax_percentage`),
  KEY `index_tax` (`tax`),
  KEY `index_net_amount` (`net_amount`),
  KEY `index_transaction_id` (`transaction_id`),
  KEY `index_organisation_id` (`organisation_id`),
  KEY `index_insurance_validity` (`insurance_validity`),
  KEY `index_insurance_id` (`insurance_id`),
  CONSTRAINT `radiology_billing_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE,
  CONSTRAINT `radiology_billing_ibfk_2` FOREIGN KEY (`case_reference_id`) REFERENCES `case_references` (`id`) ON DELETE CASCADE,
  CONSTRAINT `radiology_billing_ibfk_3` FOREIGN KEY (`doctor_id`) REFERENCES `staff` (`id`) ON DELETE CASCADE,
  CONSTRAINT `radiology_billing_ibfk_4` FOREIGN KEY (`generated_by`) REFERENCES `staff` (`id`) ON DELETE CASCADE,
  CONSTRAINT `radiology_billing_ibfk_5` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`) ON DELETE SET NULL,
  CONSTRAINT `radiology_billing_ibfk_6` FOREIGN KEY (`ipd_prescription_basic_id`) REFERENCES `ipd_prescription_basic` (`id`) ON DELETE CASCADE,
  CONSTRAINT `radiology_billing_ibfk_7` FOREIGN KEY (`organisation_id`) REFERENCES `organisation` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `radiology_billing`
--

LOCK TABLES `radiology_billing` WRITE;
/*!40000 ALTER TABLE `radiology_billing` DISABLE KEYS */;
/*!40000 ALTER TABLE `radiology_billing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `radiology_parameter`
--

DROP TABLE IF EXISTS `radiology_parameter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `radiology_parameter` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parameter_name` varchar(100) NOT NULL,
  `test_value` varchar(100) NOT NULL,
  `reference_range` varchar(100) NOT NULL,
  `range_from` varchar(500) DEFAULT NULL,
  `range_to` varchar(500) DEFAULT NULL,
  `gender` varchar(100) NOT NULL,
  `unit` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `index_parameter_name` (`parameter_name`),
  KEY `index_test_value` (`test_value`),
  KEY `index_reference_range` (`reference_range`),
  KEY `index_range_from` (`range_from`),
  KEY `index_range_to` (`range_to`),
  KEY `index_gender` (`gender`),
  KEY `index_unit` (`unit`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `radiology_parameter`
--

LOCK TABLES `radiology_parameter` WRITE;
/*!40000 ALTER TABLE `radiology_parameter` DISABLE KEYS */;
/*!40000 ALTER TABLE `radiology_parameter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `radiology_parameterdetails`
--

DROP TABLE IF EXISTS `radiology_parameterdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `radiology_parameterdetails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `radiology_id` int(11) DEFAULT NULL,
  `radiology_parameter_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `radiology_id` (`radiology_id`),
  KEY `radiology_parameter_id` (`radiology_parameter_id`),
  CONSTRAINT `radiology_parameterdetails_ibfk_1` FOREIGN KEY (`radiology_id`) REFERENCES `radio` (`id`) ON DELETE CASCADE,
  CONSTRAINT `radiology_parameterdetails_ibfk_2` FOREIGN KEY (`radiology_parameter_id`) REFERENCES `radiology_parameter` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `radiology_parameterdetails`
--

LOCK TABLES `radiology_parameterdetails` WRITE;
/*!40000 ALTER TABLE `radiology_parameterdetails` DISABLE KEYS */;
/*!40000 ALTER TABLE `radiology_parameterdetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `radiology_report`
--

DROP TABLE IF EXISTS `radiology_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `radiology_report` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `radiology_bill_id` int(11) DEFAULT NULL,
  `radiology_id` int(11) DEFAULT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `customer_type` varchar(50) DEFAULT NULL,
  `patient_name` varchar(100) DEFAULT NULL,
  `consultant_doctor` varchar(10) NOT NULL,
  `reporting_date` date DEFAULT NULL,
  `parameter_update` date DEFAULT NULL,
  `description` text DEFAULT NULL,
  `radiology_report` text DEFAULT NULL,
  `report_name` text DEFAULT NULL,
  `radiology_result` text DEFAULT NULL COMMENT 'test result',
  `tax_percentage` float(10,2) NOT NULL DEFAULT 0.00,
  `apply_charge` float(10,2) NOT NULL DEFAULT 0.00,
  `radiology_center` varchar(250) NOT NULL,
  `generated_by` int(11) DEFAULT NULL,
  `collection_specialist` int(11) DEFAULT NULL,
  `collection_date` date DEFAULT NULL,
  `approved_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `radiology_id` (`radiology_id`),
  KEY `radiology_bill_id` (`radiology_bill_id`),
  KEY `patient_id` (`patient_id`),
  KEY `generated_by` (`generated_by`),
  KEY `collection_specialist` (`collection_specialist`),
  KEY `approved_by` (`approved_by`),
  KEY `index_customer_type` (`customer_type`),
  KEY `index_patient_name` (`patient_name`),
  KEY `index_consultant_doctor` (`consultant_doctor`),
  KEY `index_reporting_date` (`reporting_date`),
  KEY `index_parameter_update` (`parameter_update`),
  KEY `index_tax_percentage` (`tax_percentage`),
  KEY `index_apply_charge` (`apply_charge`),
  KEY `index_radiology_center` (`radiology_center`),
  CONSTRAINT `radiology_report_ibfk_1` FOREIGN KEY (`radiology_id`) REFERENCES `radio` (`id`) ON DELETE CASCADE,
  CONSTRAINT `radiology_report_ibfk_2` FOREIGN KEY (`radiology_bill_id`) REFERENCES `radiology_billing` (`id`) ON DELETE CASCADE,
  CONSTRAINT `radiology_report_ibfk_3` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE,
  CONSTRAINT `radiology_report_ibfk_4` FOREIGN KEY (`generated_by`) REFERENCES `staff` (`id`) ON DELETE CASCADE,
  CONSTRAINT `radiology_report_ibfk_5` FOREIGN KEY (`collection_specialist`) REFERENCES `staff` (`id`) ON DELETE CASCADE,
  CONSTRAINT `radiology_report_ibfk_6` FOREIGN KEY (`approved_by`) REFERENCES `staff` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `radiology_report`
--

LOCK TABLES `radiology_report` WRITE;
/*!40000 ALTER TABLE `radiology_report` DISABLE KEYS */;
/*!40000 ALTER TABLE `radiology_report` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `radiology_report_parameterdetails`
--

DROP TABLE IF EXISTS `radiology_report_parameterdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `radiology_report_parameterdetails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `radiology_report_id` int(11) DEFAULT NULL,
  `radiology_parameterdetail_id` int(11) DEFAULT NULL,
  `radiology_report_value` varchar(200) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `radiology_report_id` (`radiology_report_id`),
  KEY `radiology_parameterdetail_id` (`radiology_parameterdetail_id`),
  CONSTRAINT `radiology_report_parameterdetails_ibfk_1` FOREIGN KEY (`radiology_report_id`) REFERENCES `radiology_report` (`id`) ON DELETE CASCADE,
  CONSTRAINT `radiology_report_parameterdetails_ibfk_2` FOREIGN KEY (`radiology_parameterdetail_id`) REFERENCES `radiology_parameterdetails` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `radiology_report_parameterdetails`
--

LOCK TABLES `radiology_report_parameterdetails` WRITE;
/*!40000 ALTER TABLE `radiology_report_parameterdetails` DISABLE KEYS */;
/*!40000 ALTER TABLE `radiology_report_parameterdetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `read_notification`
--

DROP TABLE IF EXISTS `read_notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `read_notification` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `staff_id` int(11) DEFAULT NULL,
  `notification_id` int(11) DEFAULT NULL,
  `is_active` varchar(10) DEFAULT 'no',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `staff_id` (`staff_id`),
  CONSTRAINT `read_notification_ibfk_1` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `read_notification`
--

LOCK TABLES `read_notification` WRITE;
/*!40000 ALTER TABLE `read_notification` DISABLE KEYS */;
/*!40000 ALTER TABLE `read_notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `read_systemnotification`
--

DROP TABLE IF EXISTS `read_systemnotification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `read_systemnotification` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `notification_id` int(11) DEFAULT NULL,
  `receiver_id` int(11) DEFAULT NULL,
  `is_active` varchar(10) NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `notification_id` (`notification_id`),
  CONSTRAINT `read_systemnotification_ibfk_1` FOREIGN KEY (`notification_id`) REFERENCES `system_notification` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `read_systemnotification`
--

LOCK TABLES `read_systemnotification` WRITE;
/*!40000 ALTER TABLE `read_systemnotification` DISABLE KEYS */;
/*!40000 ALTER TABLE `read_systemnotification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `referral_category`
--

DROP TABLE IF EXISTS `referral_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `referral_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `is_active` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `index_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `referral_category`
--

LOCK TABLES `referral_category` WRITE;
/*!40000 ALTER TABLE `referral_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `referral_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `referral_commission`
--

DROP TABLE IF EXISTS `referral_commission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `referral_commission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `referral_category_id` int(11) DEFAULT NULL,
  `referral_type_id` int(11) DEFAULT NULL,
  `commission` float DEFAULT NULL,
  `is_active` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `referral_category_id` (`referral_category_id`),
  KEY `referral_type_id` (`referral_type_id`),
  CONSTRAINT `referral_commission_ibfk_1` FOREIGN KEY (`referral_category_id`) REFERENCES `referral_category` (`id`) ON DELETE CASCADE,
  CONSTRAINT `referral_commission_ibfk_2` FOREIGN KEY (`referral_type_id`) REFERENCES `referral_type` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `referral_commission`
--

LOCK TABLES `referral_commission` WRITE;
/*!40000 ALTER TABLE `referral_commission` DISABLE KEYS */;
/*!40000 ALTER TABLE `referral_commission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `referral_payment`
--

DROP TABLE IF EXISTS `referral_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `referral_payment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `referral_person_id` int(11) DEFAULT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `referral_type` int(11) DEFAULT NULL,
  `billing_id` int(11) NOT NULL,
  `bill_amount` float(10,2) DEFAULT 0.00,
  `percentage` float(10,2) DEFAULT 0.00,
  `amount` float(10,2) DEFAULT 0.00,
  `date` datetime NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `patient_id` (`patient_id`),
  KEY `referral_person_id` (`referral_person_id`),
  KEY `referral_type` (`referral_type`),
  KEY `index_bill_amount` (`bill_amount`),
  KEY `index_percentage` (`percentage`),
  KEY `index_amount` (`amount`),
  KEY `index_date` (`date`),
  CONSTRAINT `referral_payment_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE,
  CONSTRAINT `referral_payment_ibfk_2` FOREIGN KEY (`referral_person_id`) REFERENCES `referral_person` (`id`) ON DELETE CASCADE,
  CONSTRAINT `referral_payment_ibfk_3` FOREIGN KEY (`referral_type`) REFERENCES `referral_type` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `referral_payment`
--

LOCK TABLES `referral_payment` WRITE;
/*!40000 ALTER TABLE `referral_payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `referral_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `referral_person`
--

DROP TABLE IF EXISTS `referral_person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `referral_person` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `contact` varchar(20) DEFAULT NULL,
  `person_name` varchar(100) DEFAULT NULL,
  `person_phone` varchar(50) DEFAULT NULL,
  `standard_commission` float(10,2) NOT NULL DEFAULT 0.00,
  `address` varchar(100) DEFAULT NULL,
  `is_active` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `referral_category` (`category_id`),
  KEY `index_name` (`name`),
  KEY `index_contact` (`contact`),
  KEY `index_person_name` (`person_name`),
  KEY `index_person_phone` (`person_phone`),
  KEY `index_standard_commission` (`standard_commission`),
  CONSTRAINT `referral_person_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `referral_category` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `referral_person`
--

LOCK TABLES `referral_person` WRITE;
/*!40000 ALTER TABLE `referral_person` DISABLE KEYS */;
/*!40000 ALTER TABLE `referral_person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `referral_person_commission`
--

DROP TABLE IF EXISTS `referral_person_commission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `referral_person_commission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `referral_person_id` int(11) DEFAULT NULL,
  `referral_type_id` int(11) DEFAULT NULL,
  `commission` float(10,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `referral_person_id` (`referral_person_id`),
  KEY `referral_type_id` (`referral_type_id`),
  CONSTRAINT `referral_person_commission_ibfk_1` FOREIGN KEY (`referral_person_id`) REFERENCES `referral_person` (`id`) ON DELETE CASCADE,
  CONSTRAINT `referral_person_commission_ibfk_2` FOREIGN KEY (`referral_type_id`) REFERENCES `referral_type` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `referral_person_commission`
--

LOCK TABLES `referral_person_commission` WRITE;
/*!40000 ALTER TABLE `referral_person_commission` DISABLE KEYS */;
/*!40000 ALTER TABLE `referral_person_commission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `referral_type`
--

DROP TABLE IF EXISTS `referral_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `referral_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `prefixes_type` varchar(100) NOT NULL,
  `is_active` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `index_name` (`name`),
  KEY `index_prefixes_type` (`prefixes_type`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `referral_type`
--

LOCK TABLES `referral_type` WRITE;
/*!40000 ALTER TABLE `referral_type` DISABLE KEYS */;
INSERT INTO `referral_type` VALUES (1,'opd','opd_no',1,'2021-09-17 02:07:51'),(2,'ipd','ipd_no',1,'2021-09-17 02:07:51'),(3,'pharmacy','pharmacy_billing',1,'2021-09-17 02:07:51'),(4,'pathology','pathology_billing',1,'2021-09-17 02:07:51'),(5,'radiology','radiology_billing',1,'2021-09-17 02:07:51'),(6,'blood_bank','blood_bank_billing',1,'2021-09-17 02:07:51'),(7,'ambulance','ambulance_call_billing',1,'2021-09-17 02:07:51');
/*!40000 ALTER TABLE `referral_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `slug` varchar(150) DEFAULT NULL,
  `is_active` int(11) DEFAULT 0,
  `is_system` int(11) NOT NULL DEFAULT 0,
  `is_superadmin` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `index_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Admin',NULL,0,1,0,'2018-12-25 06:19:43'),(2,'Accountant',NULL,0,1,0,'2018-12-25 06:19:38'),(3,'Doctor',NULL,0,1,0,'2018-07-21 05:07:36'),(4,'Pharmacist',NULL,0,1,0,'2018-07-21 05:08:26'),(5,'Pathologist',NULL,0,1,0,'2018-12-25 06:19:59'),(6,'Radiologist',NULL,0,1,0,'2018-12-25 06:20:27'),(7,'Super Admin',NULL,0,1,1,'2018-12-25 06:22:24'),(8,'Receptionist',NULL,0,1,0,'2018-12-25 06:20:22'),(9,'Nurse',NULL,0,1,0,'2020-12-23 01:58:58'),(10,'Physiotherapist',NULL,0,1,0,'2026-11-07 23:08:11'),(11,'Pediatrician',NULL,0,1,0,'2026-11-08 11:32:32'),(12,'Gynaecologist',NULL,0,1,0,'2026-11-08 12:08:35');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles_permissions`
--

DROP TABLE IF EXISTS `roles_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) DEFAULT NULL,
  `perm_cat_id` int(11) DEFAULT NULL,
  `can_view` int(11) DEFAULT NULL,
  `can_add` int(11) DEFAULT NULL,
  `can_edit` int(11) DEFAULT NULL,
  `can_delete` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `index_can_view` (`can_view`),
  KEY `index_can_add` (`can_add`),
  KEY `index_can_edit` (`can_edit`),
  KEY `index_can_delete` (`can_delete`),
  KEY `role_id` (`role_id`),
  KEY `perm_cat_id` (`perm_cat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2444 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles_permissions`
--

LOCK TABLES `roles_permissions` WRITE;
/*!40000 ALTER TABLE `roles_permissions` DISABLE KEYS */;
INSERT INTO `roles_permissions` VALUES (1,1,346,1,0,0,0,'2021-09-15 02:19:21'),(2,1,80,1,1,1,1,'2021-09-15 02:31:34'),(3,1,81,1,1,1,1,'2021-09-15 02:31:34'),(4,1,82,1,1,1,1,'2021-09-15 02:31:34'),(5,1,83,1,1,1,1,'2021-09-15 02:31:34'),(6,1,84,1,1,1,1,'2021-09-15 02:31:34'),(7,1,85,1,1,1,1,'2021-09-15 02:31:34'),(8,1,204,1,1,1,1,'2021-09-15 02:22:47'),(9,1,205,1,0,0,0,'2021-09-15 02:20:15'),(10,1,216,1,0,0,0,'2021-09-15 02:20:15'),(11,1,217,1,0,0,0,'2021-09-15 02:20:15'),(14,1,237,1,0,0,0,'2021-09-15 02:25:31'),(15,1,239,1,0,0,0,'2021-09-15 02:25:31'),(16,1,214,1,1,1,1,'2021-09-15 02:35:14'),(17,1,215,1,1,1,1,'2021-09-15 02:35:14'),(18,1,240,1,0,1,0,'2021-09-15 02:35:14'),(19,1,242,1,0,1,0,'2021-09-15 02:35:14'),(36,1,48,1,0,0,0,'2021-09-15 18:37:59'),(37,1,89,1,0,0,0,'2021-09-15 18:37:59'),(38,1,91,1,0,0,0,'2021-09-15 18:37:59'),(39,1,178,1,0,0,0,'2021-09-15 18:37:59'),(40,1,179,1,0,0,0,'2021-09-15 18:37:59'),(41,1,180,1,0,0,0,'2021-09-15 18:37:59'),(42,1,181,1,0,0,0,'2021-09-15 18:37:59'),(43,1,182,1,0,0,0,'2021-09-15 18:37:59'),(44,1,183,1,0,0,0,'2021-09-15 18:37:59'),(45,1,184,1,0,0,0,'2021-09-15 18:37:59'),(46,1,185,1,0,0,0,'2021-09-15 18:37:59'),(47,1,187,1,0,0,0,'2021-09-15 18:37:59'),(48,1,188,1,0,0,0,'2021-09-15 18:37:59'),(49,1,189,1,0,0,0,'2021-09-15 18:37:59'),(50,1,206,1,0,0,0,'2021-09-15 18:37:59'),(51,1,207,1,0,0,0,'2021-09-15 18:37:59'),(52,1,208,1,0,0,0,'2021-09-15 18:37:59'),(53,1,209,1,0,0,0,'2021-09-15 18:37:59'),(54,1,210,1,0,0,0,'2021-09-15 18:37:59'),(55,1,211,1,0,0,0,'2021-09-15 18:37:59'),(56,1,212,1,0,0,0,'2021-09-15 18:37:59'),(57,1,213,1,0,0,0,'2021-09-15 18:37:59'),(58,1,250,1,0,0,0,'2021-09-15 18:37:59'),(59,1,251,1,0,0,0,'2021-09-15 18:37:59'),(60,1,253,1,0,0,0,'2021-09-15 18:37:59'),(61,1,254,1,0,0,0,'2021-09-15 18:37:59'),(62,1,255,1,0,0,0,'2021-09-15 18:37:59'),(63,1,256,1,0,0,0,'2021-09-15 18:37:59'),(64,1,258,1,0,0,0,'2021-09-15 18:37:59'),(65,1,259,1,0,0,0,'2021-09-15 18:37:59'),(66,1,265,1,0,0,0,'2021-09-15 18:37:59'),(67,1,266,1,0,0,0,'2021-09-15 18:37:59'),(68,1,271,1,0,0,0,'2021-09-15 18:37:59'),(69,1,272,1,0,0,0,'2021-09-15 18:37:59'),(70,1,349,1,0,0,0,'2021-09-15 18:37:59'),(71,1,350,1,0,0,0,'2021-09-15 18:37:59'),(72,1,351,1,0,0,0,'2021-09-15 18:37:59'),(73,1,352,1,0,0,0,'2021-09-15 18:37:59'),(78,1,12,1,1,1,1,'2021-09-17 21:55:07'),(79,1,13,1,1,1,1,'2021-09-17 21:55:07'),(81,1,134,1,1,1,1,'2021-10-07 04:54:53'),(84,1,192,1,0,1,0,'2021-10-07 04:54:53'),(105,1,140,1,1,1,1,'2021-10-07 04:55:23'),(106,1,142,1,1,1,1,'2021-10-07 04:55:23'),(114,1,300,1,1,1,1,'2021-09-16 22:16:20'),(117,1,309,1,0,1,0,'2021-09-16 22:16:20'),(119,1,322,1,1,1,1,'2021-09-16 22:16:20'),(125,1,170,1,1,1,1,'2021-09-17 19:38:24'),(127,1,201,1,0,1,0,'2021-09-15 23:45:28'),(131,1,227,1,1,1,1,'2021-09-17 19:10:09'),(132,1,291,1,1,1,1,'2021-09-17 19:10:09'),(133,1,292,1,1,1,1,'2021-09-17 19:10:09'),(142,1,317,1,1,0,1,'2021-09-15 20:15:33'),(143,1,269,1,1,0,1,'2021-09-15 20:16:52'),(144,1,270,1,1,0,1,'2021-09-15 20:16:52'),(149,1,54,1,0,1,0,'2021-10-07 00:37:31'),(150,1,56,1,0,1,0,'2021-10-07 00:37:31'),(151,1,57,1,0,1,0,'2021-09-15 20:53:19'),(152,1,58,1,0,1,0,'2021-09-15 20:53:19'),(153,1,59,1,0,1,0,'2021-09-15 20:53:19'),(154,1,60,1,0,1,0,'2021-09-15 20:53:19'),(155,1,126,1,0,0,0,'2021-09-15 20:53:19'),(156,1,130,1,1,0,1,'2021-09-15 20:53:19'),(157,1,131,1,0,0,0,'2021-09-15 20:54:53'),(158,1,267,1,1,1,1,'2021-09-15 20:54:53'),(159,1,274,1,0,0,0,'2021-09-15 20:54:53'),(160,1,279,1,1,1,1,'2021-09-15 20:54:53'),(161,1,287,1,0,1,0,'2021-09-15 20:54:53'),(162,1,288,1,0,1,0,'2021-09-15 20:54:53'),(163,1,348,1,0,1,0,'2021-09-15 20:54:53'),(164,1,61,1,1,0,1,'2021-10-07 04:57:12'),(165,1,62,1,1,0,1,'2021-10-07 04:57:12'),(166,1,63,1,1,0,1,'2021-10-07 04:57:12'),(167,1,64,1,1,1,1,'2021-10-07 04:57:12'),(168,1,65,1,1,1,1,'2021-10-07 04:57:12'),(169,1,66,1,1,1,1,'2021-10-07 04:57:12'),(170,1,67,1,1,1,1,'2021-10-07 04:57:12'),(171,1,43,1,1,1,1,'2021-09-15 21:54:11'),(172,1,44,1,0,0,0,'2021-09-15 21:53:24'),(175,1,283,1,1,1,1,'2021-09-17 22:22:19'),(176,1,284,1,1,1,1,'2021-09-17 22:22:19'),(177,1,285,1,1,1,1,'2021-09-17 22:22:19'),(178,1,286,1,1,1,1,'2021-09-17 22:22:19'),(181,1,146,1,1,1,1,'2021-09-17 02:03:26'),(182,1,148,1,1,1,1,'2021-09-17 02:03:26'),(184,1,86,1,1,1,1,'2021-09-17 23:02:51'),(192,1,127,1,0,0,0,'2021-09-16 00:46:49'),(193,1,118,1,0,0,0,'2021-09-16 00:59:08'),(194,1,152,1,1,1,1,'2021-09-16 23:30:15'),(195,1,153,1,1,1,1,'2021-09-16 19:14:09'),(197,1,354,1,0,1,0,'2021-09-17 19:42:16'),(199,1,261,1,1,1,1,'2021-09-17 19:42:16'),(200,1,262,1,1,1,1,'2021-09-17 19:42:16'),(201,1,315,1,1,0,1,'2021-09-17 19:42:16'),(202,1,244,1,0,1,0,'2021-09-16 20:29:17'),(221,1,138,1,1,1,1,'2021-10-07 04:55:23'),(222,1,139,1,1,1,1,'2021-10-07 04:55:23'),(223,1,143,1,1,1,1,'2021-10-07 04:55:23'),(224,1,144,1,1,0,1,'2021-10-07 04:55:23'),(226,1,197,1,0,1,0,'2021-09-17 02:01:37'),(228,1,248,1,0,1,0,'2021-10-07 04:55:23'),(229,1,301,1,0,0,0,'2021-09-16 22:16:20'),(230,1,308,1,0,0,0,'2021-09-16 22:16:20'),(236,1,149,1,1,1,1,'2021-10-22 00:28:29'),(237,1,175,1,1,1,1,'2021-10-22 00:28:29'),(238,1,243,1,0,1,0,'2021-10-22 00:28:29'),(239,1,257,1,1,1,1,'2021-10-22 00:28:29'),(243,1,314,1,1,0,1,'2021-10-22 00:28:29'),(245,1,310,1,0,0,0,'2021-09-16 22:29:09'),(247,1,355,1,0,1,0,'2021-10-22 00:28:29'),(248,1,260,1,1,1,1,'2021-10-22 00:28:29'),(249,1,263,1,1,1,1,'2021-10-22 00:28:29'),(250,1,312,1,0,1,0,'2021-10-22 00:28:29'),(254,1,135,1,1,1,1,'2021-10-07 04:54:53'),(255,1,137,1,1,1,1,'2021-10-07 04:54:53'),(257,1,219,1,0,0,0,'2021-09-17 01:09:11'),(258,1,221,1,1,1,1,'2021-09-18 00:55:57'),(259,1,222,1,1,0,1,'2021-09-17 01:13:33'),(260,1,299,1,1,1,1,'2021-09-17 01:14:24'),(261,1,303,1,1,1,1,'2021-09-17 01:17:48'),(262,1,304,1,0,0,0,'2021-09-17 01:21:20'),(263,1,305,1,0,1,0,'2021-09-17 01:22:28'),(264,1,306,1,0,0,0,'2021-09-17 01:22:43'),(265,1,307,1,0,0,0,'2021-09-17 01:23:28'),(266,1,319,1,1,1,1,'2021-10-07 05:01:26'),(274,1,220,1,1,1,1,'2021-09-17 02:02:20'),(275,1,326,1,1,1,1,'2021-09-17 18:09:51'),(276,1,200,1,1,0,1,'2021-09-17 18:59:44'),(277,1,225,1,1,1,1,'2021-09-17 19:10:09'),(278,1,226,1,1,1,1,'2021-09-17 19:10:09'),(279,1,224,1,0,0,0,'2021-09-17 19:38:24'),(280,1,313,1,1,0,1,'2021-09-17 19:39:06'),(281,1,171,1,1,1,1,'2021-09-17 19:46:07'),(282,1,353,1,0,1,0,'2021-09-17 19:46:38'),(283,1,168,1,1,1,1,'2021-09-17 20:14:24'),(284,1,169,1,1,1,1,'2021-09-17 20:16:16'),(285,1,311,1,1,1,1,'2021-09-17 20:24:00'),(286,1,246,1,1,1,1,'2021-09-17 20:26:44'),(287,1,202,1,1,0,1,'2021-09-17 20:30:46'),(288,1,293,1,1,1,1,'2021-09-17 20:30:46'),(289,1,302,1,1,0,1,'2021-09-17 20:30:46'),(290,1,173,1,1,1,1,'2021-09-17 20:36:23'),(291,1,347,1,0,1,1,'2021-09-17 20:36:23'),(292,1,273,1,0,1,0,'2021-09-17 21:43:50'),(293,1,9,1,1,1,1,'2021-09-17 21:47:50'),(294,1,10,1,1,1,1,'2021-09-17 21:47:50'),(295,1,176,1,1,1,1,'2021-09-20 23:45:51'),(296,1,102,1,1,1,1,'2021-10-07 05:04:58'),(297,1,31,1,1,0,1,'2021-10-07 00:40:13'),(298,1,32,1,1,1,1,'2021-09-17 22:47:43'),(299,1,33,1,1,1,1,'2021-09-17 22:47:43'),(300,1,34,1,1,1,1,'2021-09-17 22:47:43'),(301,1,35,1,1,1,1,'2021-09-17 22:47:43'),(302,1,104,1,1,1,1,'2021-09-17 22:47:43'),(303,1,87,1,0,0,0,'2021-09-17 23:01:48'),(304,1,88,1,1,1,0,'2021-09-17 23:33:38'),(305,1,90,1,1,0,1,'2021-09-17 23:34:45'),(306,1,108,1,1,1,1,'2021-09-17 23:37:46'),(307,1,109,1,1,0,1,'2021-09-17 23:39:39'),(308,1,110,1,1,1,1,'2021-10-07 04:56:43'),(309,1,111,1,1,1,1,'2021-10-07 04:56:43'),(310,1,112,1,1,1,1,'2021-10-07 04:56:43'),(311,1,249,1,1,1,1,'2021-10-07 04:56:43'),(313,1,203,1,1,1,1,'2021-09-17 23:08:50'),(314,1,264,1,1,0,1,'2021-09-17 23:08:50'),(315,1,289,1,1,1,1,'2021-09-17 23:08:50'),(316,1,290,1,1,1,1,'2021-09-17 23:08:50'),(317,1,165,1,1,1,1,'2021-09-17 23:23:51'),(318,1,166,1,1,1,1,'2021-09-17 23:23:51'),(319,1,247,1,1,1,1,'2021-09-17 23:23:51'),(320,1,318,1,1,0,1,'2021-09-17 23:23:51'),(324,2,237,1,0,0,0,'2021-09-18 01:01:56'),(327,2,135,1,1,1,0,'2021-10-07 01:01:51'),(334,2,221,1,1,1,1,'2021-09-18 01:25:50'),(335,2,222,1,1,0,1,'2021-09-18 01:26:52'),(336,2,299,1,0,0,0,'2021-10-07 01:01:51'),(337,2,303,1,0,0,0,'2021-10-07 01:01:51'),(339,2,305,1,0,1,0,'2021-09-18 01:38:56'),(341,2,307,1,0,0,0,'2021-09-18 01:43:41'),(343,2,320,1,0,0,0,'2021-09-18 01:44:37'),(346,2,138,1,1,1,0,'2021-10-07 01:02:47'),(350,2,143,1,1,1,1,'2021-09-19 23:54:42'),(351,2,144,1,1,0,1,'2021-09-19 23:54:42'),(354,2,329,1,0,0,0,'2021-09-18 02:23:47'),(356,2,326,1,0,0,0,'2021-10-07 05:33:02'),(357,3,132,1,1,1,1,'2021-09-21 20:39:45'),(358,3,134,1,1,1,1,'2021-09-19 19:30:16'),(362,3,135,1,1,1,1,'2021-09-19 19:45:00'),(363,3,137,1,1,1,1,'2021-09-19 19:45:00'),(364,3,192,1,0,1,0,'2021-09-19 19:46:00'),(372,1,295,1,0,1,0,'2021-10-07 04:56:29'),(373,3,218,1,0,0,0,'2021-09-19 21:47:53'),(374,3,219,1,0,0,0,'2021-09-19 21:48:21'),(375,3,221,1,1,1,1,'2021-09-19 21:48:54'),(376,3,222,1,1,0,1,'2021-09-19 21:51:36'),(377,3,299,1,1,1,1,'2021-09-19 21:53:11'),(378,3,303,1,1,1,1,'2021-09-19 22:05:35'),(379,2,139,1,1,1,0,'2021-10-07 01:02:47'),(380,3,304,1,0,0,0,'2021-09-19 22:21:44'),(382,3,305,1,0,1,0,'2021-09-19 22:23:53'),(384,2,198,1,0,0,0,'2021-09-19 22:24:26'),(386,2,300,1,1,1,1,'2021-09-19 23:54:42'),(387,2,301,1,0,0,0,'2021-09-19 22:24:26'),(388,2,308,1,0,0,0,'2021-09-19 22:24:26'),(389,2,309,1,0,0,0,'2021-09-19 22:24:26'),(391,2,323,1,1,1,1,'2021-09-19 23:54:42'),(392,2,324,1,1,1,1,'2021-09-19 23:54:42'),(393,2,325,1,1,1,1,'2021-09-19 23:54:42'),(394,3,306,1,0,0,0,'2021-09-19 22:24:51'),(395,3,307,1,0,0,0,'2021-09-19 22:26:27'),(396,3,319,1,1,1,1,'2021-09-19 22:27:25'),(397,3,320,1,0,0,0,'2021-09-19 22:38:28'),(398,3,321,1,0,0,0,'2021-09-19 22:46:51'),(399,3,138,1,1,1,1,'2021-09-19 22:47:05'),(400,3,139,1,1,1,1,'2021-09-19 22:50:25'),(401,3,140,1,1,1,1,'2021-09-19 22:51:13'),(402,3,142,1,1,1,1,'2021-09-19 22:51:13'),(403,3,143,1,1,1,1,'2021-09-19 22:51:13'),(404,3,144,1,1,0,1,'2021-09-19 22:52:59'),(405,3,196,1,1,1,1,'2021-09-19 22:56:19'),(406,3,197,1,0,1,0,'2021-09-19 22:57:00'),(407,3,198,1,0,0,0,'2021-09-19 22:57:21'),(408,3,220,1,1,1,1,'2021-09-19 22:57:21'),(409,3,248,1,0,1,0,'2021-09-19 22:58:10'),(410,3,300,1,1,1,1,'2021-09-19 22:58:10'),(411,3,301,1,0,0,0,'2021-09-19 22:59:15'),(412,3,308,1,0,0,0,'2021-09-19 22:59:50'),(413,3,309,1,0,1,0,'2021-09-19 23:00:17'),(414,3,310,1,0,0,0,'2021-09-19 23:00:37'),(415,3,322,1,1,1,1,'2021-09-19 23:01:22'),(416,3,323,1,1,1,1,'2021-09-19 23:02:41'),(417,3,324,1,1,1,1,'2021-09-19 23:02:41'),(418,3,325,1,1,1,1,'2021-09-19 23:02:41'),(419,3,326,1,1,1,1,'2021-09-19 23:03:57'),(420,3,327,1,0,0,0,'2021-09-19 23:10:25'),(421,3,329,1,0,0,0,'2021-09-19 23:10:25'),(422,3,146,1,0,0,0,'2021-09-21 21:58:29'),(424,2,327,1,0,0,0,'2021-09-19 23:14:27'),(425,3,236,1,1,1,1,'2021-10-07 02:00:54'),(433,3,226,1,0,0,0,'2021-09-20 19:02:48'),(435,3,291,1,0,0,0,'2021-09-20 19:02:48'),(436,3,292,1,0,0,0,'2021-09-20 19:02:48'),(438,3,149,1,0,0,0,'2021-10-07 01:50:27'),(444,3,312,1,0,0,0,'2021-10-07 01:50:27'),(447,2,149,1,0,0,0,'2021-10-07 01:17:28'),(453,2,312,1,0,1,0,'2021-09-20 00:04:18'),(454,2,314,1,1,0,1,'2021-09-22 19:32:53'),(455,2,355,1,0,1,0,'2021-09-20 00:04:18'),(456,3,152,1,0,0,0,'2021-10-07 01:50:59'),(463,3,353,1,0,0,0,'2021-10-07 01:50:59'),(465,2,152,1,0,0,0,'2021-10-07 01:21:53'),(466,2,153,1,0,0,0,'2021-10-07 01:22:48'),(472,2,353,1,0,1,0,'2021-09-20 00:34:19'),(474,3,168,1,0,0,0,'2021-10-07 01:56:13'),(475,2,146,1,0,0,0,'2021-10-07 01:12:21'),(476,2,148,1,0,0,0,'2021-10-07 01:12:21'),(478,2,200,1,0,0,0,'2021-10-07 01:14:19'),(481,2,225,1,0,0,0,'2021-10-07 01:14:19'),(484,2,291,1,1,0,0,'2021-10-07 05:33:32'),(485,2,292,1,1,0,0,'2021-10-07 05:33:32'),(486,2,313,1,1,0,0,'2021-10-07 05:33:32'),(495,3,270,1,1,0,1,'2021-09-20 01:25:18'),(496,2,168,1,0,0,0,'2021-10-07 01:24:37'),(498,2,202,1,0,0,0,'2021-10-07 01:24:42'),(500,2,293,1,0,0,0,'2021-10-07 01:25:10'),(501,2,302,1,0,0,0,'2021-10-07 01:25:10'),(502,2,311,1,0,0,0,'2021-10-07 01:25:10'),(503,2,317,1,1,0,1,'2021-09-21 02:02:20'),(504,3,102,1,1,1,1,'2021-09-20 01:26:19'),(506,3,118,1,0,0,0,'2021-09-20 01:29:24'),(519,3,173,1,0,0,0,'2021-10-07 01:56:37'),(520,3,347,1,0,0,0,'2021-10-07 01:56:37'),(527,3,176,1,0,0,0,'2021-10-07 02:01:51'),(530,3,289,1,0,0,0,'2021-10-07 02:01:51'),(531,3,290,1,0,0,0,'2021-10-07 02:01:51'),(533,3,330,1,0,0,0,'2021-09-20 01:46:52'),(534,3,331,1,0,0,0,'2021-10-07 05:42:53'),(535,3,332,1,0,0,0,'2021-09-20 01:46:52'),(536,3,333,1,0,0,0,'2021-09-20 01:46:52'),(537,3,334,1,0,0,0,'2021-09-20 01:46:52'),(538,3,335,1,0,0,0,'2021-10-07 02:00:10'),(539,3,336,1,0,0,0,'2021-09-20 01:46:52'),(540,3,337,1,0,0,0,'2021-09-20 01:46:52'),(541,3,338,1,0,0,0,'2021-09-20 01:46:52'),(542,3,339,1,0,0,0,'2021-10-07 02:00:10'),(543,3,340,1,0,0,0,'2021-09-20 01:46:52'),(544,3,341,1,0,0,0,'2021-09-21 02:32:35'),(545,3,342,1,0,0,0,'2021-09-20 01:46:52'),(546,3,343,1,0,0,0,'2021-09-20 01:46:52'),(547,3,344,1,0,0,0,'2021-09-20 01:46:52'),(548,3,345,1,0,0,0,'2021-09-20 01:46:52'),(550,3,166,1,0,0,0,'2021-09-21 01:50:56'),(565,3,204,1,1,1,1,'2021-09-20 18:43:10'),(566,3,205,1,0,0,0,'2021-09-20 02:08:03'),(567,3,216,1,0,0,0,'2021-09-20 02:08:03'),(568,3,217,1,0,0,0,'2021-09-20 02:08:03'),(573,3,214,1,1,1,1,'2021-09-20 02:18:50'),(574,3,215,1,1,1,1,'2021-09-20 02:18:50'),(577,3,294,1,1,1,1,'2021-10-07 05:43:36'),(578,3,295,1,0,1,0,'2021-09-20 23:39:37'),(579,3,296,1,1,1,1,'2021-09-20 23:39:37'),(580,3,297,1,0,0,0,'2021-10-07 05:43:36'),(581,3,298,1,0,0,0,'2021-10-07 05:43:36'),(584,2,165,1,0,0,0,'2021-10-07 05:35:28'),(585,2,166,1,0,0,0,'2021-10-07 01:35:03'),(594,2,204,1,1,1,1,'2021-09-20 18:35:02'),(596,2,216,1,0,0,0,'2021-09-20 18:14:53'),(597,2,217,1,0,0,0,'2021-09-20 18:14:53'),(607,2,294,1,1,1,1,'2021-09-20 20:46:45'),(608,2,295,1,0,1,0,'2021-09-20 19:50:38'),(609,2,296,1,1,1,1,'2021-09-20 20:46:45'),(610,2,297,1,0,1,0,'2021-09-20 19:50:38'),(611,2,298,1,0,1,0,'2021-09-20 19:50:38'),(612,2,102,1,1,1,1,'2021-10-07 01:46:19'),(614,2,304,1,0,0,0,'2021-09-20 20:11:46'),(619,3,302,1,0,0,0,'2021-10-07 01:56:13'),(620,3,311,1,0,0,0,'2021-10-07 01:56:13'),(624,3,269,1,1,0,1,'2021-09-20 20:50:56'),(626,2,176,1,1,1,1,'2021-09-20 20:55:32'),(627,2,203,1,1,1,1,'2021-09-20 20:55:32'),(629,2,289,1,1,1,1,'2021-09-20 20:55:32'),(630,2,290,1,1,1,1,'2021-09-20 20:55:32'),(631,2,9,1,1,1,1,'2021-10-07 01:27:11'),(632,2,10,1,1,1,1,'2021-10-07 01:27:11'),(633,2,12,1,1,1,1,'2021-09-20 21:09:31'),(634,2,13,1,1,1,1,'2021-09-22 19:19:22'),(639,2,330,1,0,0,0,'2021-09-20 22:27:44'),(640,2,331,1,1,0,0,'2021-09-20 22:53:32'),(641,2,332,1,0,0,0,'2021-09-20 22:27:44'),(642,2,333,1,1,0,0,'2021-09-20 22:53:32'),(643,2,334,1,0,0,0,'2021-09-20 22:27:44'),(644,2,335,1,1,0,0,'2021-09-21 01:52:27'),(646,2,337,1,1,0,0,'2021-09-21 19:15:44'),(647,2,338,1,0,0,0,'2021-09-20 22:27:44'),(648,2,339,1,1,0,0,'2021-09-21 00:38:37'),(649,2,340,1,0,0,0,'2021-09-20 22:27:44'),(650,2,341,1,1,0,0,'2021-09-22 19:19:22'),(651,2,342,1,0,0,0,'2021-09-20 22:27:44'),(652,2,343,1,1,0,0,'2021-09-22 19:19:22'),(653,2,344,1,0,0,0,'2021-09-20 22:27:44'),(654,2,345,1,0,0,0,'2021-09-20 22:27:44'),(655,2,48,1,0,0,0,'2021-09-20 23:01:51'),(658,2,178,1,0,0,0,'2021-09-20 23:01:51'),(659,2,179,1,0,0,0,'2021-09-20 23:01:51'),(660,2,180,1,0,0,0,'2021-09-20 23:01:51'),(661,2,181,1,0,0,0,'2021-09-20 23:01:51'),(662,2,182,1,0,0,0,'2021-09-20 23:01:51'),(667,2,188,1,0,0,0,'2021-09-20 23:01:51'),(668,2,189,1,0,0,0,'2021-09-20 23:01:51'),(669,2,206,1,0,0,0,'2021-09-20 23:01:51'),(670,2,207,1,0,0,0,'2021-09-20 23:01:51'),(671,2,208,1,0,0,0,'2021-09-20 23:01:51'),(672,2,209,1,0,0,0,'2021-09-20 23:01:51'),(673,2,210,1,0,0,0,'2021-09-20 23:01:51'),(675,2,212,1,0,0,0,'2021-09-20 23:01:51'),(676,2,213,1,0,0,0,'2021-09-20 23:01:51'),(677,2,250,1,0,0,0,'2021-09-20 23:01:51'),(678,2,251,1,0,0,0,'2021-09-20 23:01:51'),(679,2,253,1,0,0,0,'2021-09-20 23:01:51'),(680,2,254,1,0,0,0,'2021-09-20 23:01:51'),(681,2,255,1,0,0,0,'2021-09-20 23:01:51'),(687,2,271,1,0,0,0,'2021-09-20 23:01:51'),(688,2,272,1,0,0,0,'2021-09-20 23:01:51'),(689,2,349,1,0,0,0,'2021-09-20 23:01:51'),(690,2,350,1,0,0,0,'2021-09-20 23:01:51'),(691,2,351,1,0,0,0,'2021-09-20 23:01:51'),(692,2,352,1,0,0,0,'2021-09-20 23:01:51'),(693,3,86,1,0,0,0,'2021-10-07 02:07:51'),(695,2,43,1,1,1,1,'2021-09-21 00:07:38'),(696,2,44,1,0,0,0,'2021-09-20 23:59:29'),(700,3,109,1,1,0,1,'2021-10-07 02:07:51'),(703,2,27,1,1,0,1,'2021-09-21 00:22:26'),(706,2,31,1,1,0,1,'2021-09-21 00:38:37'),(707,2,32,1,1,1,1,'2021-09-21 00:38:37'),(708,2,33,1,1,1,1,'2021-09-21 00:38:37'),(709,2,34,1,1,1,1,'2021-09-21 00:38:37'),(710,2,35,1,1,1,1,'2021-09-21 00:38:37'),(711,2,104,1,1,1,1,'2021-09-21 00:38:37'),(712,2,315,1,1,0,1,'2021-09-22 19:34:31'),(726,3,43,1,1,1,1,'2021-09-21 01:03:20'),(727,3,44,1,0,0,0,'2021-09-21 01:03:20'),(728,3,27,1,1,0,1,'2021-09-21 01:12:55'),(735,3,165,1,0,0,0,'2021-10-07 02:02:19'),(750,3,267,1,1,1,1,'2021-09-21 01:47:43'),(751,3,274,1,0,0,0,'2021-09-21 01:45:32'),(752,3,279,1,1,1,1,'2021-09-21 01:47:43'),(757,2,86,1,1,1,1,'2021-09-21 20:06:20'),(764,2,283,1,1,1,1,'2021-09-22 01:07:28'),(765,2,284,1,1,1,1,'2021-09-22 01:07:28'),(766,2,285,1,1,1,1,'2021-09-22 01:07:28'),(767,2,286,1,1,1,1,'2021-09-22 01:07:28'),(768,3,48,1,0,0,0,'2021-09-21 02:12:03'),(771,3,178,1,0,0,0,'2021-09-21 02:12:03'),(775,3,182,1,0,0,0,'2021-09-21 02:12:03'),(801,3,272,1,0,0,0,'2021-09-21 02:12:03'),(806,2,88,1,0,0,0,'2021-10-07 05:36:29'),(807,2,90,1,0,0,0,'2021-10-07 05:36:29'),(809,2,109,1,1,0,1,'2021-09-27 06:57:53'),(814,2,249,1,1,1,1,'2021-09-22 01:43:04'),(816,2,310,1,0,0,0,'2021-09-21 18:00:40'),(817,2,129,0,1,0,1,'2021-09-22 01:43:04'),(819,1,362,1,0,0,0,'2021-09-21 18:50:19'),(820,1,363,1,1,1,1,'2021-09-21 19:07:31'),(821,1,364,1,0,0,0,'2021-09-21 18:59:42'),(822,1,365,1,1,1,1,'2021-09-21 19:03:37'),(823,1,366,1,0,0,0,'2021-09-21 18:59:42'),(826,2,132,1,1,1,0,'2021-10-07 01:01:51'),(849,2,319,1,0,0,0,'2021-10-07 05:31:49'),(870,3,368,1,0,0,0,'2021-09-21 20:33:40'),(924,8,152,1,0,0,0,'2021-10-07 04:04:37'),(927,4,270,1,0,0,0,'2021-10-07 02:27:36'),(948,4,334,1,0,0,0,'2021-09-21 23:56:07'),(949,4,335,1,1,0,0,'2021-09-30 06:47:45'),(962,4,176,1,1,1,1,'2021-10-07 05:52:38'),(963,4,203,1,1,1,1,'2021-10-07 05:52:38'),(965,4,289,1,1,1,1,'2021-09-30 07:32:30'),(966,4,290,1,1,1,1,'2021-09-30 07:32:30'),(983,4,216,1,0,0,0,'2021-09-22 00:25:36'),(984,4,217,1,0,0,0,'2021-09-22 00:34:54'),(990,4,86,1,0,0,0,'2021-10-07 02:37:32'),(995,4,109,1,1,0,1,'2021-10-01 00:27:47'),(1001,2,118,1,0,0,0,'2021-09-22 00:55:25'),(1016,4,43,1,1,1,1,'2021-09-22 01:04:08'),(1017,4,44,1,0,0,0,'2021-09-22 01:04:08'),(1018,4,27,1,1,0,1,'2021-09-22 01:12:34'),(1060,4,179,1,0,0,0,'2021-09-22 01:51:01'),(1099,2,336,1,0,0,0,'2021-09-22 19:19:22'),(1119,1,367,1,1,1,1,'2021-10-07 05:04:40'),(1134,9,102,1,1,1,1,'2021-09-22 20:44:30'),(1136,9,132,1,0,0,0,'2021-10-07 04:18:18'),(1137,9,134,1,0,0,0,'2021-10-07 04:18:34'),(1138,9,135,1,0,0,0,'2021-10-07 04:18:50'),(1141,9,218,1,0,0,0,'2021-09-22 20:46:41'),(1142,9,219,1,0,0,0,'2021-09-22 20:46:41'),(1145,9,299,1,1,1,1,'2021-09-22 22:31:25'),(1146,9,303,1,0,0,0,'2021-10-07 04:24:16'),(1147,9,304,1,0,0,0,'2021-09-22 20:46:41'),(1148,9,305,1,0,0,0,'2021-10-07 04:25:46'),(1150,9,307,1,0,0,0,'2021-09-22 20:46:41'),(1151,9,319,1,0,0,0,'2021-10-07 04:25:46'),(1165,5,308,1,0,0,0,'2021-09-22 20:57:37'),(1175,5,329,1,0,0,0,'2021-09-22 22:14:39'),(1188,1,53,1,1,0,0,'2021-09-22 23:24:10'),(1189,5,149,1,1,1,1,'2021-09-22 22:40:24'),(1190,5,175,1,1,1,1,'2021-09-22 22:59:48'),(1191,5,243,1,0,1,0,'2021-09-22 22:59:48'),(1193,5,260,1,1,1,1,'2021-09-22 22:59:48'),(1194,5,263,1,1,1,1,'2021-09-22 22:59:48'),(1195,5,312,1,0,1,0,'2021-09-22 22:59:48'),(1196,5,314,1,1,0,1,'2021-09-22 22:59:48'),(1197,5,355,1,0,1,0,'2021-09-22 22:59:48'),(1204,9,138,1,0,0,0,'2021-10-07 04:51:18'),(1205,9,139,1,0,0,0,'2021-10-07 04:51:18'),(1206,9,140,1,1,1,1,'2021-10-23 04:56:32'),(1207,9,142,1,1,1,1,'2021-10-23 04:56:32'),(1210,9,196,1,0,0,0,'2021-10-07 04:27:45'),(1212,9,198,1,0,0,0,'2021-09-22 23:19:30'),(1213,9,220,1,0,0,0,'2021-10-07 04:27:45'),(1215,9,300,1,1,1,1,'2021-09-23 01:24:52'),(1216,9,301,1,0,0,0,'2021-09-22 23:19:30'),(1217,9,308,1,0,0,0,'2021-09-22 23:19:30'),(1218,9,309,1,0,0,0,'2021-10-07 04:27:45'),(1220,9,322,1,1,1,1,'2021-09-23 01:24:52'),(1224,9,326,1,0,0,0,'2021-10-07 04:27:45'),(1225,9,327,1,0,0,0,'2021-09-22 23:19:30'),(1226,9,329,1,0,0,0,'2021-09-22 23:19:30'),(1235,1,191,1,0,0,0,'2021-09-22 23:49:17'),(1246,5,317,1,1,0,1,'2021-09-23 00:16:36'),(1248,5,270,1,0,0,0,'2021-10-07 03:23:02'),(1250,5,102,1,1,1,1,'2021-09-23 00:32:09'),(1251,5,346,1,0,0,0,'2021-09-23 00:32:09'),(1269,5,337,1,1,0,0,'2021-09-23 01:31:48'),(1278,5,236,1,0,0,0,'2021-10-07 03:26:02'),(1306,5,216,1,0,0,0,'2021-09-23 01:40:28'),(1307,5,217,1,0,0,0,'2021-09-23 01:40:28'),(1317,5,86,1,0,0,0,'2021-10-07 03:29:26'),(1322,5,109,1,1,0,1,'2021-09-23 19:36:32'),(1329,5,43,1,1,1,1,'2021-09-30 00:45:54'),(1330,5,44,1,0,0,0,'2021-09-23 02:12:30'),(1331,5,27,1,1,0,1,'2021-09-23 02:15:51'),(1355,9,270,1,0,0,0,'2021-10-07 06:17:12'),(1358,9,236,1,0,0,0,'2021-10-07 04:42:28'),(1370,5,158,1,0,0,0,'2021-09-23 19:44:20'),(1416,5,369,1,0,0,0,'2021-09-23 20:16:25'),(1426,5,180,1,0,0,0,'2021-09-23 20:23:15'),(1460,6,270,1,0,0,0,'2021-10-07 03:38:49'),(1503,6,304,1,0,0,0,'2021-09-27 00:19:54'),(1509,6,319,1,0,0,0,'2021-10-07 06:03:09'),(1518,9,216,1,0,0,0,'2021-09-27 00:45:44'),(1519,9,217,1,0,0,0,'2021-09-27 00:45:44'),(1579,2,155,1,0,0,0,'2021-09-27 05:41:19'),(1580,2,156,1,0,0,0,'2021-09-27 05:41:19'),(1581,2,157,1,0,0,0,'2021-09-27 05:41:19'),(1582,2,158,1,0,0,0,'2021-09-27 05:41:19'),(1583,2,159,1,0,0,0,'2021-09-27 05:41:19'),(1584,2,161,1,0,0,0,'2021-09-27 05:41:19'),(1585,2,162,1,0,0,0,'2021-09-27 05:41:19'),(1586,2,190,1,0,0,0,'2021-09-27 05:41:19'),(1587,2,191,1,0,0,0,'2021-09-27 05:41:19'),(1588,2,238,1,0,0,0,'2021-09-27 05:41:19'),(1596,9,48,1,0,0,0,'2021-09-27 06:56:58'),(1599,9,178,1,0,0,0,'2021-09-27 06:56:58'),(1603,9,182,1,0,0,0,'2021-09-27 06:56:58'),(1631,9,350,1,0,0,0,'2021-09-27 06:56:58'),(1663,9,27,1,0,0,0,'2021-10-23 04:59:59'),(1664,9,43,1,1,1,1,'2021-09-28 01:25:13'),(1665,9,44,1,0,0,0,'2021-09-28 01:20:42'),(1666,9,86,1,0,0,0,'2021-10-07 04:46:07'),(1671,9,109,1,1,0,1,'2021-09-28 01:58:50'),(1679,9,204,1,1,1,1,'2021-09-28 03:31:04'),(1680,9,205,1,0,0,0,'2021-09-28 03:31:04'),(1697,6,152,1,1,1,1,'2021-09-28 05:21:22'),(1698,6,153,1,1,1,1,'2021-09-28 05:21:22'),(1699,6,171,1,1,1,1,'2021-09-28 05:21:22'),(1700,6,244,1,0,1,0,'2021-09-28 05:21:22'),(1701,6,261,1,1,1,1,'2021-09-28 05:21:22'),(1702,6,262,1,1,1,1,'2021-09-28 05:21:22'),(1703,6,315,1,1,0,1,'2021-09-28 05:21:22'),(1704,6,353,1,0,1,0,'2021-09-28 05:21:22'),(1705,6,354,1,0,1,0,'2021-09-28 05:21:22'),(1713,6,236,1,0,0,0,'2021-10-07 03:46:01'),(1716,6,176,1,1,1,1,'2021-10-07 06:04:58'),(1719,6,289,1,1,1,1,'2021-09-28 06:47:58'),(1720,6,290,1,1,1,1,'2021-09-28 06:47:58'),(1739,6,43,1,1,1,1,'2021-09-28 07:53:01'),(1740,6,44,1,0,0,0,'2021-09-28 07:51:03'),(1741,6,27,1,1,0,1,'2021-09-28 07:57:40'),(1742,6,118,1,0,0,0,'2021-09-28 07:59:22'),(1747,6,159,1,0,0,0,'2021-09-28 07:59:22'),(1782,2,205,1,0,0,0,'2021-09-29 03:01:52'),(1823,6,338,1,0,0,0,'2021-09-29 05:47:03'),(1824,6,339,1,1,0,0,'2021-09-29 06:07:31'),(1831,2,318,1,1,0,1,'2021-09-29 06:26:26'),(1838,6,181,1,0,0,0,'2021-09-29 06:27:14'),(1872,6,102,1,1,1,1,'2021-09-29 06:31:52'),(1873,6,86,1,0,0,0,'2021-10-07 03:48:51'),(1878,6,109,1,1,0,1,'2021-09-29 07:05:03'),(1900,6,329,1,0,0,0,'2021-09-29 07:59:38'),(1906,5,370,1,0,0,0,'2021-09-30 02:11:43'),(1908,4,146,1,1,1,1,'2021-10-07 02:24:11'),(1909,4,148,1,1,1,1,'2021-10-07 02:24:11'),(1910,4,170,1,1,1,1,'2021-10-07 02:24:11'),(1911,4,200,1,1,0,1,'2021-10-07 02:24:11'),(1912,4,201,1,0,1,0,'2021-09-30 05:42:41'),(1913,4,224,1,0,0,0,'2021-09-30 05:36:57'),(1914,4,225,1,1,0,1,'2021-10-07 02:24:11'),(1915,4,226,1,1,1,1,'2021-10-07 02:24:11'),(1916,4,227,1,1,1,1,'2021-10-07 02:24:11'),(1917,4,291,1,1,1,1,'2021-10-07 02:24:11'),(1918,4,292,1,1,1,1,'2021-10-07 02:24:11'),(1919,4,313,1,1,0,1,'2021-10-07 02:24:11'),(1931,4,236,1,0,0,0,'2021-10-07 02:30:35'),(1934,4,118,1,0,0,0,'2021-10-01 00:51:45'),(1937,4,157,1,0,0,0,'2021-10-01 00:51:45'),(1944,4,238,1,0,0,0,'2021-10-01 00:51:45'),(1957,4,256,1,0,0,0,'2021-10-01 00:54:01'),(1976,4,102,1,1,1,1,'2021-10-01 01:33:49'),(1977,4,274,1,0,0,0,'2021-10-01 01:36:40'),(1980,9,137,1,1,1,1,'2021-10-23 04:54:52'),(1981,2,173,1,1,1,1,'2021-10-07 05:34:24'),(1982,2,347,1,0,1,1,'2021-10-07 05:34:24'),(1995,1,196,1,1,1,1,'2021-10-07 04:55:23'),(1996,1,323,1,1,1,1,'2021-10-07 04:55:23'),(1997,1,324,1,1,1,1,'2021-10-07 04:55:23'),(1998,1,325,1,1,1,1,'2021-10-07 04:55:23'),(1999,1,236,1,1,1,1,'2021-10-07 00:36:12'),(2001,2,270,1,0,0,0,'2021-10-07 01:25:46'),(2002,2,236,1,1,1,0,'2021-10-07 01:28:54'),(2003,2,266,1,0,0,0,'2021-10-07 01:43:54'),(2019,8,132,1,1,1,1,'2021-10-07 04:00:10'),(2020,8,135,1,1,1,1,'2021-10-07 04:00:10'),(2021,8,218,1,0,0,0,'2021-10-07 04:00:10'),(2022,8,219,1,0,0,0,'2021-10-07 04:00:10'),(2023,8,221,1,1,1,1,'2021-10-07 06:09:52'),(2024,8,222,1,1,0,1,'2021-10-07 06:09:52'),(2025,8,138,1,1,1,1,'2021-10-07 04:00:35'),(2026,8,139,1,1,1,1,'2021-10-07 04:00:35'),(2027,8,143,1,1,1,1,'2021-10-07 06:10:36'),(2028,8,144,1,1,0,1,'2021-10-07 06:10:36'),(2029,8,326,1,0,0,0,'2021-10-07 04:01:17'),(2031,8,196,1,1,1,1,'2021-10-07 06:10:36'),(2032,8,198,1,0,0,0,'2021-10-07 04:03:01'),(2034,4,202,1,0,0,0,'2021-10-07 04:03:15'),(2035,8,146,1,0,0,0,'2021-10-07 04:03:54'),(2036,8,148,1,0,0,0,'2021-10-07 04:03:54'),(2037,8,200,1,0,0,0,'2021-10-07 04:03:54'),(2038,8,225,1,0,0,0,'2021-10-07 04:03:54'),(2039,8,149,1,0,0,0,'2021-10-07 04:04:27'),(2042,8,168,1,0,0,0,'2021-10-07 04:04:59'),(2043,8,270,1,0,0,0,'2021-10-07 04:05:25'),(2044,8,173,1,0,0,0,'2021-10-07 04:06:20'),(2045,8,347,1,0,0,0,'2021-10-07 04:06:20'),(2046,8,330,1,0,0,0,'2021-10-07 04:08:02'),(2047,8,332,1,0,0,0,'2021-10-07 04:08:02'),(2048,8,334,1,0,0,0,'2021-10-07 04:08:02'),(2049,8,336,1,0,0,0,'2021-10-07 04:08:02'),(2050,8,338,1,0,0,0,'2021-10-07 04:08:02'),(2051,8,340,1,0,0,0,'2021-10-07 04:08:02'),(2052,8,342,1,0,0,0,'2021-10-07 04:08:02'),(2053,8,236,1,1,1,0,'2021-10-07 04:08:58'),(2055,8,165,1,1,1,1,'2021-10-07 06:12:31'),(2056,8,166,1,1,1,1,'2021-10-07 06:12:31'),(2057,8,80,1,1,1,1,'2021-10-07 04:11:10'),(2058,8,81,1,1,1,1,'2021-10-07 04:11:10'),(2059,8,82,1,1,1,1,'2021-10-07 04:11:10'),(2060,8,83,1,1,1,1,'2021-10-07 04:11:10'),(2061,8,84,1,1,1,1,'2021-10-07 04:11:10'),(2062,8,85,1,1,1,1,'2021-10-07 04:11:10'),(2063,8,204,1,1,1,1,'2021-10-07 04:11:10'),(2064,8,205,1,0,0,0,'2021-10-07 04:11:10'),(2065,8,214,1,0,0,0,'2021-10-07 04:11:28'),(2066,8,215,1,0,0,0,'2021-10-07 04:11:28'),(2067,8,86,1,0,0,0,'2021-10-07 04:11:47'),(2068,8,109,1,1,0,1,'2021-10-07 04:11:47'),(2069,8,31,1,0,0,0,'2021-10-07 04:12:14'),(2070,8,32,1,0,0,0,'2021-10-07 04:12:14'),(2071,8,48,1,0,0,0,'2021-10-07 04:13:52'),(2072,8,89,1,0,0,0,'2021-10-07 04:13:52'),(2073,8,178,1,0,0,0,'2021-10-07 04:13:52'),(2074,8,180,1,0,0,0,'2021-10-07 04:13:52'),(2075,8,181,1,0,0,0,'2021-10-07 04:13:52'),(2076,8,182,1,0,0,0,'2021-10-07 04:13:52'),(2077,8,207,1,0,0,0,'2021-10-07 04:13:52'),(2078,8,208,1,0,0,0,'2021-10-07 04:13:52'),(2079,8,209,1,0,0,0,'2021-10-07 04:13:52'),(2080,8,253,1,0,0,0,'2021-10-07 04:13:52'),(2081,8,254,1,0,0,0,'2021-10-07 04:13:52'),(2082,8,255,1,0,0,0,'2021-10-07 04:13:52'),(2083,8,118,1,0,0,0,'2021-10-07 04:14:18'),(2084,8,238,1,0,0,0,'2021-10-07 04:14:18'),(2085,8,102,1,1,1,1,'2021-10-07 04:14:38'),(2086,9,321,1,0,0,0,'2021-10-07 04:25:46'),(2093,1,132,1,1,1,1,'2021-10-07 04:54:53'),(2094,1,198,1,0,0,0,'2021-10-07 04:55:23'),(2095,1,327,1,0,0,0,'2021-10-07 04:55:23'),(2096,1,329,1,0,0,0,'2021-10-07 04:55:23'),(2108,1,294,1,1,1,1,'2021-10-07 04:56:29'),(2109,1,296,1,1,1,1,'2021-10-07 04:56:29'),(2110,1,297,1,0,0,0,'2021-10-07 04:56:29'),(2111,1,298,1,0,0,0,'2021-10-07 04:56:29'),(2112,1,129,0,1,0,1,'2021-10-07 04:56:43'),(2113,1,27,1,1,0,1,'2021-10-07 04:56:54'),(2114,1,155,1,0,0,0,'2021-10-07 04:57:41'),(2115,1,156,1,0,0,0,'2021-10-07 04:57:41'),(2116,1,157,1,0,0,0,'2021-10-07 04:57:41'),(2117,1,158,1,0,0,0,'2021-10-07 04:57:41'),(2118,1,159,1,0,0,0,'2021-10-07 04:57:41'),(2119,1,161,1,0,0,0,'2021-10-07 04:57:41'),(2120,1,162,1,0,0,0,'2021-10-07 04:57:41'),(2121,1,190,1,0,0,0,'2021-10-07 04:57:41'),(2122,1,238,1,0,0,0,'2021-10-07 04:57:41'),(2127,1,320,1,0,0,0,'2021-10-07 05:01:34'),(2128,1,321,1,0,0,0,'2021-10-07 05:01:34'),(2135,1,371,1,0,0,0,'2021-10-07 05:05:30'),(2150,1,280,1,1,1,1,'2021-10-07 05:29:08'),(2151,1,369,1,0,0,0,'2021-10-07 05:30:23'),(2152,1,370,1,0,0,0,'2021-10-07 05:30:23'),(2153,1,281,1,0,0,0,'2021-10-07 05:30:36'),(2154,1,282,1,0,0,0,'2021-10-07 05:30:36'),(2155,2,321,1,0,0,0,'2021-10-07 05:31:49'),(2156,2,197,1,0,0,0,'2021-10-07 05:33:02'),(2157,2,248,1,0,0,0,'2021-10-07 05:33:02'),(2158,2,264,1,1,0,1,'2021-10-07 05:34:52'),(2159,2,247,1,0,0,0,'2021-10-07 05:35:28'),(2160,2,281,1,0,0,0,'2021-10-07 05:40:09'),(2161,2,282,1,0,0,0,'2021-10-07 05:40:09'),(2162,2,371,1,0,0,0,'2021-10-07 05:40:26'),(2163,3,257,1,0,0,0,'2021-10-07 05:41:20'),(2164,3,355,1,0,0,0,'2021-10-07 05:41:20'),(2165,3,153,1,0,0,0,'2021-10-07 05:41:40'),(2166,3,244,1,0,0,0,'2021-10-07 05:41:40'),(2167,3,354,1,0,0,0,'2021-10-07 05:41:40'),(2168,3,202,1,0,0,0,'2021-10-07 05:42:06'),(2169,3,246,1,0,0,0,'2021-10-07 05:42:06'),(2170,3,237,1,0,0,0,'2021-10-07 05:43:04'),(2171,3,240,1,0,1,0,'2021-10-07 05:43:28'),(2172,3,242,1,0,1,0,'2021-10-07 05:43:28'),(2173,3,129,0,1,0,1,'2021-10-07 05:43:59'),(2174,3,183,1,0,0,0,'2021-10-07 05:46:03'),(2175,3,188,1,0,0,0,'2021-10-07 05:46:03'),(2176,3,206,1,0,0,0,'2021-10-07 05:46:03'),(2177,3,207,1,0,0,0,'2021-10-07 05:46:03'),(2178,3,208,1,0,0,0,'2021-10-07 05:46:03'),(2179,3,209,1,0,0,0,'2021-10-07 05:46:03'),(2180,3,211,1,0,0,0,'2021-10-07 05:46:03'),(2181,3,258,1,0,0,0,'2021-10-07 05:46:03'),(2182,3,271,1,0,0,0,'2021-10-07 05:46:03'),(2183,3,350,1,0,0,0,'2021-10-07 05:46:03'),(2184,3,369,1,0,0,0,'2021-10-07 05:46:03'),(2185,3,238,1,0,0,0,'2021-10-07 05:46:28'),(2186,3,362,1,0,0,0,'2021-10-07 05:46:52'),(2187,3,363,1,1,1,1,'2021-10-07 05:47:07'),(2188,3,366,1,0,0,0,'2021-10-07 05:46:52'),(2189,3,367,1,1,1,1,'2021-10-07 05:47:07'),(2190,3,371,1,0,0,0,'2021-10-07 05:47:23'),(2194,4,132,1,0,0,0,'2021-10-07 05:50:59'),(2195,4,138,1,0,0,0,'2021-10-07 05:51:05'),(2196,4,264,1,1,0,1,'2021-10-07 05:52:38'),(2198,4,371,1,0,0,0,'2021-10-07 05:56:00'),(2201,5,132,1,0,0,0,'2021-10-07 05:56:53'),(2202,5,304,1,0,0,0,'2021-10-07 05:56:53'),(2204,5,138,1,0,0,0,'2021-10-07 05:57:32'),(2205,5,139,1,0,0,0,'2021-10-07 05:57:32'),(2206,5,307,1,0,0,0,'2021-10-07 05:57:47'),(2207,5,257,1,1,1,1,'2021-10-07 05:58:05'),(2209,5,168,1,1,1,1,'2021-10-07 05:58:48'),(2210,5,169,1,1,1,1,'2021-10-07 05:58:48'),(2211,5,202,1,1,0,1,'2021-10-07 05:58:48'),(2212,5,246,1,0,0,0,'2021-10-07 05:58:48'),(2213,5,293,1,1,1,1,'2021-10-07 05:58:48'),(2214,5,302,1,1,0,1,'2021-10-07 05:58:48'),(2215,5,311,1,1,1,1,'2021-10-07 05:58:48'),(2216,5,336,1,0,0,0,'2021-10-07 05:59:04'),(2217,5,274,1,0,0,0,'2021-10-07 06:00:38'),(2219,5,183,1,0,0,0,'2021-10-07 06:01:42'),(2220,5,211,1,0,0,0,'2021-10-07 06:01:42'),(2221,5,371,1,0,0,0,'2021-10-07 06:02:10'),(2222,6,132,1,0,0,0,'2021-10-07 06:03:09'),(2223,6,135,1,0,0,0,'2021-10-07 06:03:09'),(2224,6,138,1,0,0,0,'2021-10-07 06:03:45'),(2225,6,139,1,0,0,0,'2021-10-07 06:03:45'),(2226,6,308,1,0,0,0,'2021-10-07 06:03:45'),(2227,6,309,1,0,0,0,'2021-10-07 06:03:45'),(2228,6,203,1,1,1,1,'2021-10-07 06:04:58'),(2229,6,264,1,1,0,1,'2021-10-07 06:04:58'),(2231,6,274,1,0,0,0,'2021-10-07 06:06:19'),(2232,6,371,1,0,0,0,'2021-10-07 06:07:27'),(2233,8,304,1,0,0,0,'2021-10-07 06:09:52'),(2234,8,305,1,0,1,0,'2021-10-07 06:09:52'),(2235,8,306,1,0,0,0,'2021-10-07 06:09:52'),(2236,8,307,1,0,0,0,'2021-10-07 06:09:52'),(2237,8,319,1,1,1,1,'2021-10-07 06:09:52'),(2238,8,320,1,0,0,0,'2021-10-07 06:09:52'),(2239,8,301,1,0,0,0,'2021-10-07 06:10:36'),(2240,8,309,1,0,1,0,'2021-10-07 06:10:36'),(2241,8,310,1,0,0,0,'2021-10-07 06:10:36'),(2242,8,329,1,0,0,0,'2021-10-07 06:10:36'),(2243,8,257,1,0,0,0,'2021-10-07 06:10:57'),(2244,8,153,1,0,0,0,'2021-10-07 06:11:07'),(2245,8,169,1,0,0,0,'2021-10-07 06:11:37'),(2246,8,202,1,0,0,0,'2021-10-07 06:11:37'),(2247,8,302,1,0,0,0,'2021-10-07 06:11:37'),(2248,8,311,1,0,0,0,'2021-10-07 06:11:37'),(2249,2,348,1,0,1,0,'2021-10-07 06:17:44'),(2250,8,247,1,1,1,1,'2021-10-07 06:12:31'),(2251,8,318,1,1,0,1,'2021-10-07 06:12:31'),(2252,8,294,1,1,1,1,'2021-10-07 06:13:02'),(2253,8,295,1,0,1,0,'2021-10-07 06:13:02'),(2254,8,296,1,1,1,1,'2021-10-07 06:13:02'),(2255,8,297,1,0,0,0,'2021-10-07 06:13:02'),(2256,8,298,1,0,0,0,'2021-10-07 06:13:02'),(2257,2,56,1,0,0,0,'2021-10-07 06:13:19'),(2258,8,43,1,1,1,1,'2021-10-07 06:13:22'),(2259,8,44,1,0,0,0,'2021-10-07 06:13:22'),(2260,8,27,1,1,0,1,'2021-10-07 06:13:28'),(2261,8,274,1,0,0,0,'2021-10-07 06:13:45'),(2262,2,54,1,0,0,0,'2021-10-07 06:13:47'),(2263,8,183,1,0,0,0,'2021-10-07 06:15:00'),(2264,8,256,1,0,0,0,'2021-10-07 06:15:00'),(2265,8,258,1,0,0,0,'2021-10-07 06:15:00'),(2266,8,259,1,0,0,0,'2021-10-07 06:15:00'),(2267,8,350,1,0,0,0,'2021-10-07 06:15:00'),(2268,8,162,1,0,0,0,'2021-10-07 06:15:18'),(2269,8,371,1,0,0,0,'2021-10-07 06:15:32'),(2271,9,274,1,0,0,0,'2021-10-07 06:19:59'),(2272,9,118,1,0,0,0,'2021-10-07 06:20:29'),(2273,9,238,1,0,0,0,'2021-10-07 06:20:29'),(2274,9,371,1,0,0,0,'2021-10-07 06:20:40'),(2275,1,218,1,0,0,0,'2021-10-07 06:20:53'),(2276,1,330,1,0,0,0,'2021-10-22 00:27:48'),(2277,1,331,1,1,0,0,'2021-10-22 00:27:48'),(2278,1,332,1,0,0,0,'2021-10-22 00:27:48'),(2279,1,333,1,1,0,0,'2021-10-22 00:27:48'),(2280,1,334,1,0,0,0,'2021-10-22 00:27:48'),(2281,1,335,1,1,0,0,'2021-10-22 00:27:48'),(2282,1,336,1,0,0,0,'2021-10-22 00:27:48'),(2283,1,337,1,1,0,0,'2021-10-22 00:27:48'),(2284,1,338,1,0,0,0,'2021-10-22 00:27:48'),(2285,1,339,1,1,0,0,'2021-10-22 00:27:48'),(2286,1,340,1,0,0,0,'2021-10-22 00:27:48'),(2287,1,341,1,1,0,0,'2021-10-22 00:27:48'),(2288,1,342,1,0,0,0,'2021-10-22 00:27:48'),(2289,1,343,1,1,0,0,'2021-10-22 00:27:48'),(2290,1,344,1,0,0,0,'2021-10-22 00:27:48'),(2291,1,345,1,0,0,0,'2021-10-22 00:27:48'),(2292,1,372,1,NULL,NULL,NULL,'2021-10-29 07:41:42'),(2293,1,373,1,NULL,NULL,NULL,'2021-10-29 07:42:20'),(2294,1,374,1,1,1,1,'2021-10-29 07:45:25'),(2295,1,375,1,1,1,1,'2021-10-29 07:45:25'),(2296,1,386,1,1,0,1,'2021-11-10 06:22:22'),(2297,3,386,1,1,0,1,'2021-11-10 06:22:22'),(2298,1,387,1,0,0,0,'2021-11-10 06:24:10'),(2299,3,387,1,0,0,0,'2021-11-10 06:24:10'),(2300,1,419,1,1,1,1,'2024-08-20 10:19:15'),(2301,1,415,1,0,0,0,'2024-08-20 10:19:36'),(2302,1,416,1,1,1,1,'2024-08-20 10:19:36'),(2303,1,417,1,1,1,1,'2024-08-20 10:19:36'),(2304,1,418,1,1,1,1,'2024-08-20 10:19:36'),(2305,1,414,1,0,1,0,'2024-08-20 10:20:08'),(2306,1,398,1,1,1,1,'2024-08-20 10:21:04'),(2307,1,402,1,0,0,0,'2024-08-20 10:21:04'),(2308,1,413,1,0,1,0,'2024-08-20 10:21:04'),(2309,1,409,1,0,0,1,'2024-08-20 10:21:50'),(2310,1,410,1,1,0,1,'2024-08-20 10:21:50'),(2311,1,411,1,0,0,0,'2024-08-20 10:21:50'),(2312,1,412,1,0,0,0,'2024-08-20 10:21:50'),(2313,1,406,1,1,1,1,'2024-08-20 10:22:23'),(2314,1,407,1,1,1,1,'2024-08-20 10:22:23'),(2315,1,408,1,1,1,1,'2024-08-20 10:22:23'),(2316,1,405,1,1,1,1,'2024-08-20 10:22:33'),(2317,1,393,1,1,1,1,'2024-08-20 10:23:11'),(2318,1,394,1,1,1,1,'2024-08-20 10:23:11'),(2319,1,395,1,1,1,1,'2024-08-20 10:23:11'),(2320,1,396,1,1,1,1,'2024-08-20 10:23:11'),(2321,1,401,1,0,0,0,'2024-08-20 10:23:11'),(2322,1,403,1,0,0,0,'2024-08-20 10:23:11'),(2323,1,404,1,0,0,0,'2024-08-20 10:23:11'),(2324,1,392,1,1,1,1,'2024-08-20 10:25:03'),(2325,1,400,1,0,0,0,'2024-08-20 10:25:23'),(2326,1,390,1,0,0,0,'2024-08-20 10:25:53'),(2327,1,399,1,0,0,0,'2024-08-20 10:25:53'),(2328,1,388,1,1,1,1,'2024-08-20 10:27:59'),(2329,1,389,1,1,1,1,'2024-08-20 10:27:59'),(2330,1,391,1,1,1,1,'2024-08-20 10:27:59'),(2331,1,397,1,0,0,0,'2024-08-20 10:31:13'),(2332,1,420,1,1,1,1,'2026-11-07 23:11:07'),(2333,1,421,1,1,1,1,'2026-11-07 23:11:07'),(2334,1,422,1,0,0,0,'2026-11-07 23:11:07'),(2335,1,423,1,0,1,0,'2026-11-07 23:11:07'),(2336,10,270,1,0,0,0,'2026-11-07 23:11:07'),(2337,10,304,1,0,0,0,'2026-11-07 23:11:07'),(2338,10,319,1,0,0,0,'2026-11-07 23:11:07'),(2339,10,236,1,0,0,0,'2026-11-07 23:11:07'),(2340,10,176,1,1,1,1,'2026-11-07 23:11:07'),(2341,10,289,1,1,1,1,'2026-11-07 23:11:07'),(2342,10,290,1,1,1,1,'2026-11-07 23:11:07'),(2343,10,43,1,1,1,1,'2026-11-07 23:11:07'),(2344,10,44,1,0,0,0,'2026-11-07 23:11:07'),(2345,10,27,1,1,0,1,'2026-11-07 23:11:07'),(2346,10,118,1,0,0,0,'2026-11-07 23:11:07'),(2347,10,102,1,1,1,1,'2026-11-07 23:11:07'),(2348,10,86,1,0,0,0,'2026-11-07 23:11:07'),(2349,10,109,1,1,0,1,'2026-11-07 23:11:07'),(2350,10,329,1,0,0,0,'2026-11-07 23:11:07'),(2351,10,132,1,0,0,0,'2026-11-07 23:11:07'),(2352,10,135,1,0,0,0,'2026-11-07 23:11:07'),(2353,10,138,1,0,0,0,'2026-11-07 23:11:07'),(2354,10,139,1,0,0,0,'2026-11-07 23:11:07'),(2355,10,308,1,0,0,0,'2026-11-07 23:11:07'),(2356,10,309,1,0,0,0,'2026-11-07 23:11:07'),(2357,10,203,1,1,1,1,'2026-11-07 23:11:07'),(2358,10,264,1,1,0,1,'2026-11-07 23:11:07'),(2359,10,274,1,0,0,0,'2026-11-07 23:11:07'),(2360,10,371,1,0,0,0,'2026-11-07 23:11:07'),(2361,10,420,1,1,1,1,'2026-11-07 23:11:07'),(2362,10,421,1,1,1,1,'2026-11-07 23:11:07'),(2363,10,422,1,0,0,0,'2026-11-07 23:11:07'),(2364,10,423,1,0,1,0,'2026-11-07 23:11:07'),(2365,11,270,1,0,0,0,'2026-11-08 11:32:32'),(2366,11,304,1,0,0,0,'2026-11-08 11:32:32'),(2367,11,319,1,0,0,0,'2026-11-08 11:32:32'),(2377,11,236,1,0,0,0,'2026-11-08 11:32:32'),(2378,11,176,1,1,1,1,'2026-11-08 11:32:32'),(2379,11,289,1,1,1,1,'2026-11-08 11:32:32'),(2380,11,290,1,1,1,1,'2026-11-08 11:32:32'),(2381,11,43,1,1,1,1,'2026-11-08 11:32:32'),(2382,11,44,1,0,0,0,'2026-11-08 11:32:32'),(2383,11,27,1,1,0,1,'2026-11-08 11:32:32'),(2384,11,118,1,0,0,0,'2026-11-08 11:32:32'),(2389,11,102,1,1,1,1,'2026-11-08 11:32:32'),(2390,11,86,1,0,0,0,'2026-11-08 11:32:32'),(2391,11,109,1,1,0,1,'2026-11-08 11:32:32'),(2392,11,329,1,0,0,0,'2026-11-08 11:32:32'),(2393,11,132,1,0,0,0,'2026-11-08 11:32:32'),(2394,11,135,1,0,0,0,'2026-11-08 11:32:32'),(2395,11,138,1,0,0,0,'2026-11-08 11:32:32'),(2396,11,139,1,0,0,0,'2026-11-08 11:32:32'),(2397,11,308,1,0,0,0,'2026-11-08 11:32:32'),(2398,11,309,1,0,0,0,'2026-11-08 11:32:32'),(2399,11,203,1,1,1,1,'2026-11-08 11:32:32'),(2400,11,264,1,1,0,1,'2026-11-08 11:32:32'),(2401,11,274,1,0,0,0,'2026-11-08 11:32:32'),(2402,11,371,1,0,0,0,'2026-11-08 11:32:32'),(2403,11,424,1,1,1,1,'2026-11-08 11:32:32'),(2404,11,425,1,1,1,1,'2026-11-08 11:32:32'),(2405,11,426,1,0,0,0,'2026-11-08 11:32:32'),(2406,11,427,1,0,1,0,'2026-11-08 11:32:32'),(2407,1,424,1,1,1,1,'2026-11-08 11:32:32'),(2408,1,425,1,1,1,1,'2026-11-08 11:32:32'),(2409,1,426,1,0,0,0,'2026-11-08 11:32:32'),(2410,1,427,1,0,1,0,'2026-11-08 11:32:32'),(2411,12,270,1,0,0,0,'2026-11-08 12:08:35'),(2412,12,304,1,0,0,0,'2026-11-08 12:08:35'),(2413,12,319,1,0,0,0,'2026-11-08 12:08:35'),(2414,12,236,1,0,0,0,'2026-11-08 12:08:35'),(2415,12,176,1,1,1,1,'2026-11-08 12:08:35'),(2416,12,289,1,1,1,1,'2026-11-08 12:08:35'),(2417,12,290,1,1,1,1,'2026-11-08 12:08:35'),(2418,12,43,1,1,1,1,'2026-11-08 12:08:35'),(2419,12,44,1,0,0,0,'2026-11-08 12:08:35'),(2420,12,27,1,1,0,1,'2026-11-08 12:08:35'),(2421,12,118,1,0,0,0,'2026-11-08 12:08:35'),(2422,12,102,1,1,1,1,'2026-11-08 12:08:35'),(2423,12,86,1,0,0,0,'2026-11-08 12:08:35'),(2424,12,109,1,1,0,1,'2026-11-08 12:08:35'),(2425,12,329,1,0,0,0,'2026-11-08 12:08:35'),(2426,12,132,1,0,0,0,'2026-11-08 12:08:35'),(2427,12,135,1,0,0,0,'2026-11-08 12:08:35'),(2428,12,138,1,0,0,0,'2026-11-08 12:08:35'),(2429,12,139,1,0,0,0,'2026-11-08 12:08:35'),(2430,12,308,1,0,0,0,'2026-11-08 12:08:35'),(2431,12,309,1,0,0,0,'2026-11-08 12:08:35'),(2432,12,203,1,1,1,1,'2026-11-08 12:08:35'),(2433,12,264,1,1,0,1,'2026-11-08 12:08:35'),(2434,12,274,1,0,0,0,'2026-11-08 12:08:35'),(2435,12,371,1,0,0,0,'2026-11-08 12:08:36'),(2436,12,428,1,1,1,1,'2026-11-08 12:08:36'),(2437,12,429,1,1,1,1,'2026-11-08 12:08:36'),(2438,12,430,1,0,0,0,'2026-11-08 12:08:36'),(2439,12,431,1,0,1,0,'2026-11-08 12:08:36'),(2440,1,428,1,1,1,1,'2026-11-08 12:08:36'),(2441,1,429,1,1,1,1,'2026-11-08 12:08:36'),(2442,1,430,1,0,0,0,'2026-11-08 12:08:36'),(2443,1,431,1,0,1,0,'2026-11-08 12:08:36');
/*!40000 ALTER TABLE `roles_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sch_settings`
--

DROP TABLE IF EXISTS `sch_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sch_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `base_url` varchar(500) DEFAULT NULL,
  `folder_path` text DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `biometric` int(11) DEFAULT 0,
  `biometric_device` text DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `start_month` varchar(100) NOT NULL,
  `session_id` int(11) DEFAULT NULL,
  `lang_id` int(11) DEFAULT NULL,
  `languages` varchar(255) NOT NULL DEFAULT '["4"]',
  `dise_code` varchar(50) DEFAULT NULL,
  `date_format` varchar(50) NOT NULL,
  `time_format` varchar(20) DEFAULT '24-hour',
  `currency` varchar(50) NOT NULL,
  `currency_symbol` varchar(50) NOT NULL,
  `is_rtl` varchar(10) DEFAULT 'disabled',
  `timezone` varchar(30) DEFAULT 'UTC',
  `image` varchar(100) DEFAULT NULL,
  `mini_logo` varchar(200) NOT NULL,
  `theme` varchar(200) NOT NULL DEFAULT 'default.jpg',
  `credit_limit` varchar(255) DEFAULT NULL,
  `opd_record_month` varchar(50) DEFAULT NULL,
  `is_active` varchar(255) DEFAULT 'no',
  `cron_secret_key` varchar(100) NOT NULL,
  `doctor_restriction` varchar(100) NOT NULL,
  `superadmin_restriction` varchar(200) NOT NULL,
  `patient_panel` varchar(50) NOT NULL,
  `scan_code_type` varchar(50) NOT NULL DEFAULT 'barcode',
  `mobile_api_url` varchar(200) NOT NULL,
  `app_primary_color_code` varchar(50) NOT NULL,
  `app_secondary_color_code` varchar(50) NOT NULL,
  `app_logo` varchar(200) NOT NULL,
  `zoom_api_key` varchar(200) NOT NULL,
  `zoom_api_secret` varchar(200) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `lang_id` (`lang_id`),
  KEY `session_id` (`session_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sch_settings`
--

LOCK TABLES `sch_settings` WRITE;
/*!40000 ALTER TABLE `sch_settings` DISABLE KEYS */;
INSERT INTO `sch_settings` VALUES (1,NULL,NULL,'SEFU',0,NULL,'Your Hospital Email','Your Hospital Phone','Your Hospital Address','',NULL,4,'[\"4\"]','Your Hospital Code','m/d/Y','12-hour','KES','KES','disabled','UTC','0.png','0mini_logo.png','blue.jpg','20000','1','no','','disabled','enabled','enabled','barcode','','#424242','#eeeeee','0app_logo.png','','','2026-11-09 10:49:41');
/*!40000 ALTER TABLE `sch_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `send_notification`
--

DROP TABLE IF EXISTS `send_notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `send_notification` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) DEFAULT NULL,
  `publish_date` date DEFAULT NULL,
  `date` date DEFAULT NULL,
  `message` text DEFAULT NULL,
  `visible_staff` varchar(10) NOT NULL DEFAULT 'no',
  `visible_patient` varchar(10) NOT NULL DEFAULT 'no',
  `created_by` varchar(60) DEFAULT NULL,
  `created_id` int(11) DEFAULT NULL,
  `is_active` varchar(10) DEFAULT 'no',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `created_id` (`created_id`),
  KEY `index_title` (`title`),
  KEY `index_publish_date` (`publish_date`),
  KEY `index_date` (`date`),
  KEY `index_visible_staff` (`visible_staff`),
  KEY `index_visible_patient` (`visible_patient`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `send_notification`
--

LOCK TABLES `send_notification` WRITE;
/*!40000 ALTER TABLE `send_notification` DISABLE KEYS */;
/*!40000 ALTER TABLE `send_notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `share_content_for`
--

DROP TABLE IF EXISTS `share_content_for`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `share_content_for` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` varchar(20) DEFAULT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `share_content_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `upload_content_id` (`share_content_id`),
  KEY `student_id` (`patient_id`),
  KEY `staff_id` (`staff_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `share_content_for`
--

LOCK TABLES `share_content_for` WRITE;
/*!40000 ALTER TABLE `share_content_for` DISABLE KEYS */;
/*!40000 ALTER TABLE `share_content_for` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `share_contents`
--

DROP TABLE IF EXISTS `share_contents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `share_contents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `send_to` varchar(50) DEFAULT NULL,
  `title` text DEFAULT NULL,
  `share_date` date DEFAULT NULL,
  `valid_upto` date DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `created_by` (`created_by`),
  KEY `index_send_to` (`send_to`),
  KEY `index_share_date` (`share_date`),
  KEY `index_valid_upto` (`valid_upto`),
  KEY `index_created_by` (`created_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `share_contents`
--

LOCK TABLES `share_contents` WRITE;
/*!40000 ALTER TABLE `share_contents` DISABLE KEYS */;
/*!40000 ALTER TABLE `share_contents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `share_upload_contents`
--

DROP TABLE IF EXISTS `share_upload_contents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `share_upload_contents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `upload_content_id` int(11) DEFAULT NULL,
  `share_content_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `upload_content_id` (`upload_content_id`),
  KEY `share_content_id` (`share_content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `share_upload_contents`
--

LOCK TABLES `share_upload_contents` WRITE;
/*!40000 ALTER TABLE `share_upload_contents` DISABLE KEYS */;
/*!40000 ALTER TABLE `share_upload_contents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shift_details`
--

DROP TABLE IF EXISTS `shift_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shift_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `staff_id` int(11) DEFAULT NULL,
  `consult_duration` int(11) DEFAULT NULL,
  `charge_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `staff_id` (`staff_id`),
  KEY `charge_id` (`charge_id`),
  KEY `index_consult_duration` (`consult_duration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shift_details`
--

LOCK TABLES `shift_details` WRITE;
/*!40000 ALTER TABLE `shift_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `shift_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sms_config`
--

DROP TABLE IF EXISTS `sms_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sms_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `api_id` varchar(100) NOT NULL,
  `authkey` varchar(100) NOT NULL,
  `senderid` varchar(100) NOT NULL,
  `contact` text DEFAULT NULL,
  `username` varchar(150) DEFAULT NULL,
  `url` varchar(150) DEFAULT NULL,
  `password` varchar(150) DEFAULT NULL,
  `is_active` varchar(10) DEFAULT 'disabled',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sms_config`
--

LOCK TABLES `sms_config` WRITE;
/*!40000 ALTER TABLE `sms_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `sms_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `source`
--

DROP TABLE IF EXISTS `source`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `source` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `source` varchar(100) NOT NULL,
  `description` mediumtext DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `index_source` (`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `source`
--

LOCK TABLES `source` WRITE;
/*!40000 ALTER TABLE `source` DISABLE KEYS */;
/*!40000 ALTER TABLE `source` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `specialist`
--

DROP TABLE IF EXISTS `specialist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `specialist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `specialist_name` varchar(200) NOT NULL,
  `is_active` varchar(100) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `index_specialist_name` (`specialist_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `specialist`
--

LOCK TABLES `specialist` WRITE;
/*!40000 ALTER TABLE `specialist` DISABLE KEYS */;
/*!40000 ALTER TABLE `specialist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `staff` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` varchar(200) DEFAULT NULL,
  `lang_id` int(11) NOT NULL,
  `department_id` int(11) DEFAULT NULL,
  `staff_designation_id` int(11) DEFAULT NULL,
  `specialist` varchar(200) NOT NULL,
  `qualification` varchar(200) NOT NULL,
  `work_exp` varchar(200) NOT NULL,
  `specialization` varchar(200) NOT NULL,
  `name` varchar(200) NOT NULL,
  `surname` varchar(200) NOT NULL,
  `father_name` varchar(200) NOT NULL,
  `mother_name` varchar(200) NOT NULL,
  `contact_no` varchar(200) NOT NULL,
  `emergency_contact_no` varchar(200) NOT NULL,
  `email` varchar(200) NOT NULL,
  `dob` date DEFAULT NULL,
  `marital_status` varchar(100) NOT NULL,
  `date_of_joining` date DEFAULT NULL,
  `date_of_leaving` date DEFAULT NULL,
  `local_address` varchar(300) NOT NULL,
  `permanent_address` varchar(200) NOT NULL,
  `note` varchar(200) NOT NULL,
  `image` varchar(200) NOT NULL,
  `password` varchar(250) NOT NULL,
  `gender` varchar(50) NOT NULL,
  `blood_group` varchar(100) NOT NULL,
  `account_title` varchar(200) NOT NULL,
  `bank_account_no` varchar(200) NOT NULL,
  `bank_name` varchar(200) NOT NULL,
  `ifsc_code` varchar(200) NOT NULL,
  `bank_branch` varchar(100) NOT NULL,
  `payscale` varchar(200) NOT NULL,
  `basic_salary` varchar(200) NOT NULL,
  `epf_no` varchar(200) NOT NULL,
  `contract_type` varchar(100) NOT NULL,
  `shift` varchar(100) NOT NULL,
  `location` varchar(100) NOT NULL,
  `facebook` varchar(200) NOT NULL,
  `twitter` varchar(200) NOT NULL,
  `linkedin` varchar(200) NOT NULL,
  `instagram` varchar(200) NOT NULL,
  `resume` varchar(200) NOT NULL,
  `joining_letter` varchar(200) NOT NULL,
  `resignation_letter` varchar(200) NOT NULL,
  `other_document_name` varchar(200) NOT NULL,
  `other_document_file` varchar(200) NOT NULL,
  `user_id` int(11) NOT NULL,
  `is_active` int(11) NOT NULL,
  `verification_code` varchar(100) NOT NULL,
  `zoom_api_key` varchar(100) NOT NULL,
  `zoom_api_secret` varchar(100) NOT NULL,
  `pan_number` varchar(30) NOT NULL,
  `identification_number` varchar(30) NOT NULL,
  `local_identification_number` varchar(30) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `employee_id` (`employee_id`),
  KEY `staff_designation_id` (`staff_designation_id`),
  KEY `department_id` (`department_id`),
  KEY `index_name` (`name`),
  KEY `index_surname` (`surname`),
  KEY `index_father_name` (`father_name`),
  KEY `index_mother_name` (`mother_name`),
  KEY `index_contact_no` (`contact_no`),
  KEY `index_emergency_contact_no` (`emergency_contact_no`),
  KEY `index_email` (`email`),
  KEY `index_dob` (`dob`),
  KEY `index_marital_status` (`marital_status`),
  KEY `index_date_of_joining` (`date_of_joining`),
  KEY `index_date_of_leaving` (`date_of_leaving`),
  KEY `index_gender` (`gender`),
  KEY `index_blood_group` (`blood_group`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` VALUES (1,'9001',0,NULL,NULL,'','','','','Super Admin','','','','','','admin@sfu.com',NULL,'',NULL,NULL,'','','','','$2y$10$tdV4YL0X.MzmbfJYhqUmKO8.WmlYC.HGZeu1qNlAhqM/aGZd6u8tK','','','','','','','','','','','','','','','','','','','','','','',0,1,'','','','','','','2026-11-05 13:45:38'),(2,'78',0,0,0,'','','','','Ahmed','Zara','','','','','zarajeff333@gmail.com','1998-12-28','Single',NULL,NULL,'hrsnhrshj','hrsnhrshj','','','$2y$10$gUy97kZS0VL6EoFoWWkIaeuG771xWsGxKrITaM8JgRY0KMEvcpB4m','Male','O-','','','','','','','','','','','','','','','','','','','','',0,1,'','','','','','','2026-11-05 15:41:50');
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff_attendance`
--

DROP TABLE IF EXISTS `staff_attendance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `staff_attendance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `staff_attendance_type_id` int(11) DEFAULT NULL,
  `biometric_attendence` int(11) DEFAULT 0,
  `biometric_device_data` text DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `remark` varchar(200) NOT NULL,
  `is_active` int(11) NOT NULL,
  `in_time` time DEFAULT NULL,
  `out_time` time DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `staff_id` (`staff_id`),
  KEY `staff_attendance_type_id` (`staff_attendance_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff_attendance`
--

LOCK TABLES `staff_attendance` WRITE;
/*!40000 ALTER TABLE `staff_attendance` DISABLE KEYS */;
/*!40000 ALTER TABLE `staff_attendance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff_attendance_type`
--

DROP TABLE IF EXISTS `staff_attendance_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `staff_attendance_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(200) NOT NULL,
  `key_value` varchar(200) NOT NULL,
  `is_active` varchar(50) NOT NULL,
  `long_lang_name` varchar(250) DEFAULT NULL,
  `long_name_style` varchar(250) DEFAULT NULL,
  `for_schedule` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_at` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_type` (`type`),
  KEY `index_key_value` (`key_value`),
  KEY `index_is_active` (`is_active`),
  KEY `index_long_lang_name` (`long_lang_name`),
  KEY `index_long_name_style` (`long_name_style`),
  KEY `index_for_schedule` (`for_schedule`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff_attendance_type`
--

LOCK TABLES `staff_attendance_type` WRITE;
/*!40000 ALTER TABLE `staff_attendance_type` DISABLE KEYS */;
INSERT INTO `staff_attendance_type` VALUES (1,'Present','<b class=\"text text-success\">P</b>','yes','present',NULL,1,'2024-08-21 09:29:55',NULL),(2,'Late','<b class=\"text text-warning\">L</b>','yes','late',NULL,1,'2024-08-21 09:29:55',NULL),(3,'Absent','<b class=\"text text-danger\">A</b>','yes','absent',NULL,0,'2024-08-21 09:29:55',NULL),(4,'Half Day','<b class=\"text text-warning\">F</b>','yes','half_day',NULL,1,'2024-08-21 09:29:55',NULL),(5,'Holiday','H','yes','holiday',NULL,0,'2024-08-21 09:29:55',NULL),(6,'Half Day Second Shift','<b class=\"text text-warning\">SH</b>','yes','half_day_second_shift','label label-info',1,'2024-06-08 16:35:55',NULL);
/*!40000 ALTER TABLE `staff_attendance_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff_attendence_schedules`
--

DROP TABLE IF EXISTS `staff_attendence_schedules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `staff_attendence_schedules` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `staff_attendence_type_id` int(11) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  `entry_time_from` time DEFAULT NULL,
  `entry_time_to` time DEFAULT NULL,
  `total_institute_hour` time DEFAULT NULL,
  `is_active` int(11) DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `role_id` (`role_id`),
  KEY `staff_attendence_type_id` (`staff_attendence_type_id`),
  KEY `index_entry_time_from` (`entry_time_from`),
  KEY `index_entry_time_to` (`entry_time_to`),
  KEY `index_total_institute_hour` (`total_institute_hour`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff_attendence_schedules`
--

LOCK TABLES `staff_attendence_schedules` WRITE;
/*!40000 ALTER TABLE `staff_attendence_schedules` DISABLE KEYS */;
/*!40000 ALTER TABLE `staff_attendence_schedules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff_designation`
--

DROP TABLE IF EXISTS `staff_designation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `staff_designation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `designation` varchar(200) NOT NULL,
  `is_active` varchar(10) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `index_designation` (`designation`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff_designation`
--

LOCK TABLES `staff_designation` WRITE;
/*!40000 ALTER TABLE `staff_designation` DISABLE KEYS */;
INSERT INTO `staff_designation` VALUES (1,'Physiotherapist','yes','2026-11-07 23:09:40'),(2,'Pediatrician','yes','2026-11-08 11:32:32'),(3,'Gynaecologist','yes','2026-11-08 12:08:35');
/*!40000 ALTER TABLE `staff_designation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff_id_card`
--

DROP TABLE IF EXISTS `staff_id_card`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `staff_id_card` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `hospital_name` varchar(255) NOT NULL,
  `hospital_address` varchar(255) NOT NULL,
  `background` text NOT NULL,
  `logo` text NOT NULL,
  `sign_image` text NOT NULL,
  `header_color` varchar(100) NOT NULL,
  `enable_staff_role` tinyint(1) NOT NULL COMMENT '0=disable,1=enable',
  `enable_staff_id` tinyint(1) NOT NULL COMMENT '0=disable,1=enable',
  `enable_staff_department` tinyint(1) NOT NULL COMMENT '0=disable,1=enable',
  `enable_designation` tinyint(1) NOT NULL COMMENT '0=disable,1=enable',
  `enable_name` tinyint(1) NOT NULL COMMENT '0=disable,1=enable',
  `enable_fathers_name` tinyint(1) NOT NULL COMMENT '0=disable,1=enable',
  `enable_mothers_name` tinyint(1) NOT NULL COMMENT '0=disable,1=enable',
  `enable_date_of_joining` tinyint(1) NOT NULL COMMENT '0=disable,1=enable',
  `enable_permanent_address` tinyint(1) NOT NULL COMMENT '0=disable,1=enable',
  `enable_staff_dob` tinyint(1) NOT NULL COMMENT '0=disable,1=enable',
  `enable_staff_phone` tinyint(1) NOT NULL COMMENT '0=disable,1=enable',
  `enable_staff_barcode` tinyint(1) NOT NULL COMMENT '0=disable,1=enable',
  `status` tinyint(1) NOT NULL COMMENT '0=disable,1=enable',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `index_title` (`title`),
  KEY `index_hospital_name` (`hospital_name`),
  KEY `index_hospital_address` (`hospital_address`),
  KEY `index_header_color` (`header_color`),
  KEY `index_enable_staff_role` (`enable_staff_role`),
  KEY `index_enable_staff_id` (`enable_staff_id`),
  KEY `index_enable_staff_department` (`enable_staff_department`),
  KEY `index_enable_designation` (`enable_designation`),
  KEY `index_enable_name` (`enable_name`),
  KEY `index_enable_fathers_name` (`enable_fathers_name`),
  KEY `index_enable_mothers_name` (`enable_mothers_name`),
  KEY `index_enable_date_of_joining` (`enable_date_of_joining`),
  KEY `index_enable_permanent_address` (`enable_permanent_address`),
  KEY `index_enable_staff_dob` (`enable_staff_dob`),
  KEY `index_enable_staff_phone` (`enable_staff_phone`),
  KEY `index_enable_staff_barcode` (`enable_staff_barcode`),
  KEY `index_status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff_id_card`
--

LOCK TABLES `staff_id_card` WRITE;
/*!40000 ALTER TABLE `staff_id_card` DISABLE KEYS */;
INSERT INTO `staff_id_card` VALUES (1,'Sample Staff Id Card','National Hospital','Habibganj Rd, Opp Cricket Club, E-3, Arera Colony, Bhopal','background.jpg','logo.jpg','signature.png','#0e5c9f',0,1,0,1,1,0,0,0,1,1,1,0,1,'2021-10-19 06:58:50');
/*!40000 ALTER TABLE `staff_id_card` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff_leave_details`
--

DROP TABLE IF EXISTS `staff_leave_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `staff_leave_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `staff_id` int(11) DEFAULT NULL,
  `leave_type_id` int(11) DEFAULT NULL,
  `alloted_leave` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `staff_id` (`staff_id`),
  KEY `leave_type_id` (`leave_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff_leave_details`
--

LOCK TABLES `staff_leave_details` WRITE;
/*!40000 ALTER TABLE `staff_leave_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `staff_leave_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff_leave_request`
--

DROP TABLE IF EXISTS `staff_leave_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `staff_leave_request` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `staff_id` int(11) DEFAULT NULL,
  `leave_type_id` int(11) DEFAULT NULL,
  `leave_from` date NOT NULL,
  `leave_to` date NOT NULL,
  `leave_days` int(11) NOT NULL,
  `employee_remark` varchar(200) NOT NULL,
  `admin_remark` varchar(200) NOT NULL,
  `status` varchar(100) NOT NULL,
  `approved_date` date DEFAULT NULL,
  `applied_by` int(11) DEFAULT NULL,
  `status_updated_by` int(11) DEFAULT NULL,
  `document_file` text NOT NULL,
  `date` date NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `staff_id` (`staff_id`),
  KEY `leave_type_id` (`leave_type_id`),
  KEY `applied_by` (`applied_by`),
  KEY `index_leave_from` (`leave_from`),
  KEY `index_leave_to` (`leave_to`),
  KEY `index_leave_days` (`leave_days`),
  KEY `index_employee_remark` (`employee_remark`),
  KEY `index_admin_remark` (`admin_remark`),
  KEY `index_status` (`status`),
  KEY `index_approved_date` (`approved_date`),
  KEY `index_status_updated_by` (`status_updated_by`),
  KEY `index_date` (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff_leave_request`
--

LOCK TABLES `staff_leave_request` WRITE;
/*!40000 ALTER TABLE `staff_leave_request` DISABLE KEYS */;
/*!40000 ALTER TABLE `staff_leave_request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff_payroll`
--

DROP TABLE IF EXISTS `staff_payroll`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `staff_payroll` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `basic_salary` float(10,2) NOT NULL,
  `pay_scale` int(11) NOT NULL,
  `grade` varchar(50) NOT NULL,
  `is_active` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff_payroll`
--

LOCK TABLES `staff_payroll` WRITE;
/*!40000 ALTER TABLE `staff_payroll` DISABLE KEYS */;
/*!40000 ALTER TABLE `staff_payroll` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff_payslip`
--

DROP TABLE IF EXISTS `staff_payslip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `staff_payslip` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `staff_id` int(11) DEFAULT NULL,
  `basic` float(10,2) NOT NULL,
  `total_allowance` float(10,2) NOT NULL,
  `total_deduction` float(10,2) NOT NULL,
  `leave_deduction` int(11) NOT NULL,
  `tax` float(10,2) NOT NULL DEFAULT 0.00,
  `net_salary` float(10,2) NOT NULL,
  `status` varchar(100) NOT NULL,
  `month` varchar(200) NOT NULL,
  `year` varchar(200) NOT NULL,
  `cheque_no` varchar(250) DEFAULT NULL,
  `cheque_date` date DEFAULT NULL,
  `attachment` varchar(250) DEFAULT NULL,
  `attachment_name` text DEFAULT NULL,
  `payment_mode` varchar(200) NOT NULL,
  `payment_date` date NOT NULL,
  `remark` text DEFAULT NULL,
  `generated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `staff_id` (`staff_id`),
  KEY `generated_by` (`generated_by`),
  KEY `index_basic` (`basic`),
  KEY `index_total_allowance` (`total_allowance`),
  KEY `index_total_deduction` (`total_deduction`),
  KEY `index_leave_deduction` (`leave_deduction`),
  KEY `index_tax` (`tax`),
  KEY `index_net_salary` (`net_salary`),
  KEY `index_status` (`status`),
  KEY `index_month` (`month`),
  KEY `index_year` (`year`),
  KEY `index_cheque_no` (`cheque_no`),
  KEY `index_cheque_date` (`cheque_date`),
  KEY `index_attachment` (`attachment`),
  KEY `index_payment_mode` (`payment_mode`),
  KEY `index_payment_date` (`payment_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff_payslip`
--

LOCK TABLES `staff_payslip` WRITE;
/*!40000 ALTER TABLE `staff_payslip` DISABLE KEYS */;
/*!40000 ALTER TABLE `staff_payslip` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff_roles`
--

DROP TABLE IF EXISTS `staff_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `staff_roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) DEFAULT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `is_active` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `role_id` (`role_id`),
  KEY `staff_id` (`staff_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff_roles`
--

LOCK TABLES `staff_roles` WRITE;
/*!40000 ALTER TABLE `staff_roles` DISABLE KEYS */;
INSERT INTO `staff_roles` VALUES (1,7,1,0,'2026-11-05 13:45:38'),(2,3,2,0,'2026-11-05 15:41:50');
/*!40000 ALTER TABLE `staff_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff_timeline`
--

DROP TABLE IF EXISTS `staff_timeline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `staff_timeline` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `staff_id` int(11) DEFAULT NULL,
  `title` varchar(200) NOT NULL,
  `timeline_date` date NOT NULL,
  `description` text DEFAULT NULL,
  `document` text NOT NULL,
  `status` varchar(10) NOT NULL,
  `date` date NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `staff_id` (`staff_id`),
  KEY `index_title` (`title`),
  KEY `index_timeline_date` (`timeline_date`),
  KEY `index_status` (`status`),
  KEY `index_date` (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff_timeline`
--

LOCK TABLES `staff_timeline` WRITE;
/*!40000 ALTER TABLE `staff_timeline` DISABLE KEYS */;
/*!40000 ALTER TABLE `staff_timeline` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supplier_bill_basic`
--

DROP TABLE IF EXISTS `supplier_bill_basic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `supplier_bill_basic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `invoice_no` varchar(100) NOT NULL,
  `date` datetime NOT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `file` varchar(200) NOT NULL,
  `total` float(10,2) NOT NULL,
  `tax` float(10,2) NOT NULL,
  `discount` float(10,2) NOT NULL,
  `net_amount` float(10,2) NOT NULL,
  `note` text DEFAULT NULL,
  `payment_mode` varchar(30) DEFAULT NULL,
  `cheque_no` varchar(255) DEFAULT NULL,
  `cheque_date` date DEFAULT NULL,
  `payment_date` datetime DEFAULT NULL,
  `received_by` int(11) DEFAULT NULL,
  `attachment` varchar(255) DEFAULT NULL,
  `attachment_name` varchar(255) DEFAULT NULL,
  `payment_note` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `supplier_id` (`supplier_id`),
  KEY `received_by` (`received_by`),
  KEY `index_total` (`total`),
  KEY `index_tax` (`tax`),
  KEY `index_discount` (`discount`),
  KEY `index_net_amount` (`net_amount`),
  KEY `index_payment_mode` (`payment_mode`),
  KEY `index_cheque_no` (`cheque_no`),
  KEY `index_cheque_date` (`cheque_date`),
  KEY `index_payment_date` (`payment_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supplier_bill_basic`
--

LOCK TABLES `supplier_bill_basic` WRITE;
/*!40000 ALTER TABLE `supplier_bill_basic` DISABLE KEYS */;
/*!40000 ALTER TABLE `supplier_bill_basic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `symptoms`
--

DROP TABLE IF EXISTS `symptoms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `symptoms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `symptoms_title` varchar(200) NOT NULL,
  `description` text DEFAULT NULL,
  `type` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `index_symptoms_title` (`symptoms_title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `symptoms`
--

LOCK TABLES `symptoms` WRITE;
/*!40000 ALTER TABLE `symptoms` DISABLE KEYS */;
/*!40000 ALTER TABLE `symptoms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `symptoms_classification`
--

DROP TABLE IF EXISTS `symptoms_classification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `symptoms_classification` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `symptoms_type` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `index_symptoms_type` (`symptoms_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `symptoms_classification`
--

LOCK TABLES `symptoms_classification` WRITE;
/*!40000 ALTER TABLE `symptoms_classification` DISABLE KEYS */;
/*!40000 ALTER TABLE `symptoms_classification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_notification`
--

DROP TABLE IF EXISTS `system_notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `system_notification` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `notification_title` varchar(200) NOT NULL,
  `notification_type` varchar(50) NOT NULL,
  `notification_desc` text DEFAULT NULL,
  `notification_for` varchar(50) NOT NULL,
  `role_id` int(11) DEFAULT NULL,
  `receiver_id` int(11) DEFAULT NULL,
  `date` datetime NOT NULL,
  `is_active` varchar(10) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_notification_title` (`notification_title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_notification`
--

LOCK TABLES `system_notification` WRITE;
/*!40000 ALTER TABLE `system_notification` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_notification_setting`
--

DROP TABLE IF EXISTS `system_notification_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `system_notification_setting` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `event` varchar(100) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `staff_message` text DEFAULT NULL,
  `is_staff` int(11) NOT NULL DEFAULT 1,
  `patient_message` text DEFAULT NULL,
  `is_patient` int(11) NOT NULL DEFAULT 0,
  `variables` text DEFAULT NULL,
  `url` varchar(255) NOT NULL,
  `patient_url` varchar(255) NOT NULL,
  `notification_type` varchar(255) NOT NULL,
  `is_active` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `index_event` (`event`),
  KEY `index_is_staff` (`is_staff`),
  KEY `index_is_patient` (`is_patient`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_notification_setting`
--

LOCK TABLES `system_notification_setting` WRITE;
/*!40000 ALTER TABLE `system_notification_setting` DISABLE KEYS */;
INSERT INTO `system_notification_setting` VALUES (1,'notification_appointment_created','New Appointment Created','Appointment has been created for Patient: {{patient_name}} ({{patient_id}}). Appointment Date: {{appointment_date}}  With Doctor Name: {{doctor_name}}.',1,'Dear {{patient_name}} ({{patient_id}}) your appointment has been created with Doctor: {{doctor_name}}.',1,'{{appointment_date}} {{patient_name}} {{patient_id}} {{doctor_name}} {{message}}','','','appointment',1,'2021-09-17 02:54:13'),(2,'appointment_approved','Appointment Status','Patient: {{patient_name}} ({{patient_id}}) appointment status is {{appointment_status}} with Doctor:  {{doctor_name}} Date: {{appointment_date}}.',1,'Dear {{patient_name}} ({{patient_id}}) your appointment status is {{appointment_status}} Date: {{appointment_date}} with Doctor {{doctor_name}}.',1,'{{appointment_date}} {{patient_name}} {{patient_id}} {{doctor_name}} {{message}} {{appointment_status}}','','','appointment',1,'2021-09-17 02:54:13'),(3,'opd_visit_created','New OPD Visit Created','OPD Visit has been created for patient: {{patient_name}} ({{patient_id}}) with doctor: {{doctor_name}}. Patient Symptoms Details are {{symptoms_description}} and any known allergies: {{any_known_allergies}} .',1,'Dear: {{patient_name}} ({{patient_id}}) your OPD visit has been created.  Your Symptoms Details are {{symptoms_description}} and any known allergies: {{any_known_allergies}}. ',1,'{{patient_name}} {{patient_id}} {{symptoms_description}} {{any_known_allergies}} {{appointment_date}} {{doctor_name}}','','','opd',1,'2021-09-17 02:54:13'),(4,'notification_opd_prescription_created','New OPD Prescription Created','New OPD prescription has been created for Patient: {{patient_name}} ({{patient_id}}) Checkup ID: ({{checkup_id}}). Prescription {{prescription_no}} prescribe by {{prescribe_by}}.  \r\n\r\n Prescription Details.\r\n(1) Finding Description: {{finding_description}}\r\n(2) Medicine Details: {{medicine}}\r\n(3) Radiology Test: {{radilogy_test}}\r\n(4) Pathology Test: {{pathology_test}}',1,'Dear {{patient_name}} ({{patient_id}}) Checkup ID: ({{checkup_id}}) your OPD ({{opd_no}}) prescription has been created . Please Check your finding details {{finding_description}} prescribe by {{prescribe_by}}.\r\n\r\nPlease Check prescription details. \r\n(1) Medicines Details: {{medicine}}\r\n(2) Radiology Test: {{radilogy_test}}\r\n(3) Pathology Test: {{pathology_test}}',1,'{{prescription_no}} {{opd_no}} {{checkup_id}} {{finding_description}} {{medicine}} {{radilogy_test}} {{pathology_test}} {{prescribe_by}} {{generated_by}} {{patient_name}} {{patient_id}}','','','opd',1,'2021-09-17 02:54:13'),(5,'add_opd_patient_charge','Add OPD Patient Charge','New OPD charges added in OPD Number: ({{opd_no}}) For Patient: {{patient_name}} ({{patient_id}}). In OPD applied charges is {{charge_type}}, charge category {{charge_category}} and charge Name {{charge_name}} quantity {{qty}}. Total net payable bill amount is {{net_amount}} date {{date}}',1,'Dear {{patient_name}}({{patient_id}}) OPD Number ({{opd_no}}) . In OPD applied charge name {{charge_type}} , category {{charge_category}},  charge name {{charge_name}} quantity {{qty}} and your net payable bill amount is {{net_amount}} Date {{date}}.',1,'{{patient_name}} {{patient_id}}  {{opd_no}} {{charge_type}} {{charge_category}} {{charge_name}} {{qty}} {{net_amount}} {{date}} {{doctor_name}}','','','opd',1,'2021-09-17 02:54:13'),(6,'add_opd_payment','Add OPD Payment','New OPD payment has been received from Patient: {{patient_name}}({{patient_id}}) OPD Number: ({{opd_no}}) transaction id: {{transaction_id}} payment date: {{date}} payment amount: {{amount}} payment mode: {{payment_mode}}.',1,'Dear {{patient_name}} ({{patient_id}}) your payment successfully received. OPD Number: {{opd_no}} transaction id: {{transaction_id}} payment date: {{date}} payment amount: ${{amount}} payment mode: {{payment_mode}}. ',1,'{{patient_name}} {{patient_id}} {{opd_no}} {{date}} {{amount}} {{payment_mode}} {{transaction_id}}','','','opd',1,'2021-09-17 02:54:13'),(7,'add_opd_medication_dose','New OPD Medication Dose','Consultant Doctor {{doctor_name}} has given medicine {{medicine_name}} Category is {{medicine_category}} Dosage {{dosage}} for OPD patient number is  {{opd_no}} patient name is {{patient_name}} medicine time  {{date}} {{time}}.',1,'Dear {{patient_name}} ({{patient_id}}) OPD Number: {{opd_no}} you have been given the Medicine is {{medicine_name}} Dose ({{dosage}}) medicine time {{date}} {{time}}.',1,'{{patient_name}} {{patient_id}}  {{opd_no}} {{case_id}} \r\n{{date}} {{time}}  {{medicine_name}} {{dosage}} {{medicine_category}}  {{doctor_name}}','','','opd',1,'2021-09-17 02:54:13'),(8,'add_nurse_note','New IPD Nurse Note','Add New Nurse Note for IPD Number: ({{ipd_no}}) Patient: {{patient_name}} ({{patient_id}}) Case ID: {{case_id}} with consultant doctor  {{doctor_name}}. \r\n\r\nNurse Note Details:\r\n(1) Nurse Name: {{nurse_name}} ({{nurse_id}})\r\n(2) Note: {{note}}\r\n(3) Comment: {{comment}}',1,'Dear {{patient_name}} ({{patient_id}}) IPD Number: ({{ipd_no}}) and Case ID: {{case_id}} your consultant doctor is {{doctor_name}}. \r\n\r\nNurse Note Details:\r\n(1) Nurse Name: {{nurse_name}} ({{nurse_id}})\r\n(2) Note: {{note}}\r\n(3) Comment: {{comment}}',1,'{{patient_name}} {{patient_id}} {{ipd_no}} {{case_id}} {{doctor_name}} {{date}} {{nurse_name}} {{nurse_id}} {{note}} {{comment}}','','','ipd',1,'2021-09-17 02:54:13'),(9,'move_in_ipd_from_opd','Patient Move in IPD From OPD','Patient {{patient_name}} ({{patient_id}}) move in IPD From OPD. Symptoms Details: {{symptoms_description}} and known allergies is  {{any_known_allergies}}. The patient is being shifted from opd to ipd whose consultant doctor is {{doctor_name}}.',1,'Dear {{patient_name}} ({{patient_id}}) you have been shifted from OPD to IPD consultant doctor is {{doctor_name}}. Check your symptoms details {{symptoms_description}} and known allergies {{any_known_allergies}}.\r\n\r\n',1,'{{patient_name}} {{patient_id}} {{symptoms_description}} {{any_known_allergies}} {{appointment_date}} {{doctor_name}}','','','opd',1,'2021-09-17 02:54:13'),(10,'add_opd_operation','New OPD Operation','OPD Number: ({{opd_no}}) Patient: {{patient_name}} ({{patient_id}}) Case id: {{case_id}} has been shifted to the operation ward. Consultant Doctor is {{doctor_name}} .\r\n\r\nOperation Details.\r\nOperation Name: {{operation_name}}\r\nOperation Date: {{operation_date}}',1,'Dear {{patient_name}} {{patient_id}} your operation {{operation_name}} date is on {{operation_date}} and your consultant doctor is {{doctor_name}}.',1,'{{patient_name}} {{patient_id}} {{opd_no}} {{case_id}} {{operation_name}} {{operation_date}} {{doctor_name}}','','','opd',1,'2021-09-17 02:54:13'),(11,'ipd_visit_created','New IPD Visit Created','IPD Visit has been created for {{patient_name}} ({{patient_id}}) with Doctor: {{doctor_name}}. Patient Symptoms Details are {{symptoms_description}}.',1,'Dear {{patient_name}} ({{patient_id}}) your IPD visit has been created .',1,'{{patient_name}} {{patient_id}} {{symptoms_description}} {{admission_date}} {{doctor_name}} {{bed_location}}','','','ipd',1,'2021-09-17 02:54:13'),(12,'notification_ipd_prescription_created','Notification IPD Prescription Created','Prescription({{prescription_no}}) for IPD ({{ipd_no}}) prescribe by: {{priscribe_by}}. \r\n\r\nPrescription  Details-\r\nFinding Description: {{finding_description}}\r\nMedicine Name: {{medicine}}\r\nRadiology Test: {{radilogy_test}}\r\nPathology Test: {{pathology_test}}\r\n{{priscribe_by}}',1,'Dear {{patient_name}} {{patient_id}} your IPD prescription number {{prescription_no}} is prescribe by: {{priscribe_by}}. \r\n\r\nPrescription  Details-\r\n Finding Description: {{finding_description}}\r\n Medicine Name : {{medicine}}\r\n Radiology Test: {{radilogy_test}}\r\n Pathology Test: {{pathology_test}}',1,'{{prescription_no}} {{ipd_no}} {{finding_description}} {{medicine}} {{radilogy_test}} {{pathology_test}} {{priscribe_by}} {{generated_by}} {{patient_name}} {{patient_id}}','','','ipd',1,'2021-09-17 02:54:13'),(14,'add_ipd_operation','Add IPD Operation','Patient Name : {{patient_name}} ({{patient_id}}) IPD Number : {{ipd_no}} Case Id : {{case_id}} has been shifted to the operation ward. Whose doctor is {{doctor_name}}.\r\n\r\nOperation Details-\r\n(1) Operation Name: {{operation_name}}\r\n(2) Operation  Date:  {{operation_date}}',1,'Dear {{patient_name}} ({{patient_id}}) your operation {{operation_name}} date is on {{operation_date}} with {{doctor_name}}.',1,'{{patient_name}} {{patient_id}} {{ipd_no}} {{case_id}} {{operation_name}} {{operation_date}} {{doctor_name}}','','','ipd',1,'2021-09-17 02:54:13'),(15,'add_ipd_generate_bill','Add IPD Generate Bill','Generated bill for IPD Number {{ipd_no}}  Patient Name {{patient_name}} {{patient_id}} .\r\n\r\nBill Details\r\nTotal Amount {{total}}\r\nNet Amount {{net_amount}}\r\nTax  {{tax}}\r\nPaid Amount   {{paid}}\r\nDue Amount   {{due}}',1,'Dear {{patient_name}} {{patient_id}}  your IPD bill is generated for Case Id {{case_id}} .\r\n\r\nBill Details\r\nTotal Amount {{total}}\r\nNet Amount {{net_amount}}\r\nTax  {{tax}}\r\nPaid Amount   {{paid}}\r\nDue Amount   {{due}}',1,'{{patient_name}} {{patient_id}} {{ipd_no}} {{case_id}} {{net_amount}} {{total}} {{tax}} {{paid}} {{due}}','','','ipd',1,'2021-09-17 02:54:13'),(16,'add_ipd_patient_charge','Add IPD Patient Charge','Add Charge for IPD Patient Name : {{patient_name}} ({{patient_id}}) IPD Number ({{ipd_no}}) has applied charge {{charge_type}}, category  {{charge_category}}, and Name {{charge_name}} total quantity {{qty}} . Now total net amount {{net_amount}} date {{date}}.',1,'Dear {{patient_name}} ({{patient_id}}) IPD Number {{ipd_no}} you have applied charge name is {{charge_type}}, category {{charge_category}} ,charge name {{charge_name}}  and total quantity {{qty}} now your net amount {{net_amount}} and date {{date}}.',1,'{{patient_name}} {{patient_id}} {{ipd_no}} {{charge_type}} {{charge_category}} {{charge_name}} {{qty}} {{net_amount}} {{date}}','','','ipd',1,'2021-09-17 02:54:13'),(17,'add_ipd_payment','Add IPD Payment','Payment has been received from Patient Name: {{patient_name}} ({{patient_id}}) IPD NO: {{ipd_no}} transaction id: {{transaction_id}} payment date: {{date}} payment amount: {{amount}} payment mode: {{payment_mode}}.',1,'Dear {{patient_name}} ({{patient_id}}) IPD: {{ipd_no}} we have received your payment amount ({{amount}}) transaction id: {{transaction_id}} payment date: {{date}} payment mode: {{payment_mode}} .',1,'{{patient_name}} {{patient_id}} {{ipd_no}} {{date}} {{amount}} {{payment_mode}} {{transaction_id}}','','','ipd',1,'2021-09-17 02:54:13'),(18,'add_ipd_medication_dose','Add IPD Medication Dose','Doctor {{doctor_name}}  has given medicine {{medicine_name}} Category is {{medicine_category}} Dosage {{dosage}} to Patient:  {{patient_name}} {{patient_id}} at {{date}} {{time}}.',1,'Dear {{patient_name}} ({{patient_id}}) IPD Number {{ipd_no}} you have been given the {{medicine_name}} dose {{dosage}} of medicine at {{date}} {{time}}.',1,'{{patient_name}} {{patient_id}} {{ipd_no}} {{case_id}} {{date}} {{time}} {{medicine_name}} {{dosage}} {{medicine_category}} {{doctor_name}}','','','ipd',1,'2021-09-17 02:54:13'),(20,'add_consultant_register','Add Consultant Register','New Consultant Register: {doctor_name}} has been added  some instructions: {{instruction}} on date {{applied_date}} for the patients {{patient_name}} ({{patient_id}}) of IPD {{ipd_no}}.',1,'Dear {{patient_name}} ({{patient_id}}) IPD Number: ({{ipd_no}}). Consultant: {{doctor_name}} has added some instructions: {{instruction}} on applied date {{applied_date}}.',1,'{{patient_name}} {{patient_id}} {{ipd_no}} {{case_id}} {{applied_date}} {{instruction_date}} {{doctor_name}} {{instruction}}','','','ipd',1,'2021-09-17 02:54:13'),(22,'pharmacy_generate_bill','Pharmacy Generate Bill','Pharmacy Bill Generated for Patient: {{patient_name}} ({{patient_id}}) Case ID: {{case_id}}.\r\n\r\nPharmacy Bill Details-\r\nTotal Amount: {{total}}\r\nNet Amount: {{net_amount}}\r\nDiscount: {discount}} \r\nTax: {{tax}}\r\nPaid Amount  $ {{paid}}\r\nDue Amount  $ {{due_amount}}',1,'Dear {{patient_name}} {{patient_id}} your pharmacy bill is generated. \r\n\r\nBill Details-\r\nTotal Amount: {{total}}\r\nNet Amount: {{net_amount}}\r\nDiscount: {{discount}}\r\nTax: {{tax}}\r\nPaid Amount: {{paid}}\r\nDue Amount: {{due_amount}}',1,'{{patient_name}} {{patient_id}} {{case_id}} {{bill_no}} {{medicine_details}} {{doctor_name}} {{total}} {{discount}} {{tax}} {{net_amount}} {{date}} {{paid}} {{due_amount}}','','','pharmacy',1,'2021-09-17 02:54:13'),(23,'add_medicine','Add Medicine','New Add Medicine Details: \r\n\r\nMedicine Name  {{medicine_name}} , \r\nMedicine Category  {{medicine_category}} ,\r\nMedicine Company  {{medicine_company}} ,\r\nMedicine Composition  {{medicine_composition}} ,\r\nMedicine Group {{medicine_group}} , \r\nUnit {{unit}} ,\r\nPacking  {{unit_packing}} ,',1,'',0,'{{medicine_name}} {{medicine_category}} {{medicine_company}} {{medicine_composition}} {{medicine_group}} {{unit}} {{unit_packing}}','','','pharmacy',1,'2021-09-17 02:54:13'),(24,'add_bad_stock','Add Bad Stock','Add Bad Stock Details :\r\n\r\nBatch No {{batch_no}}\r\nExpiry Date  {{expiry_date}}\r\nOutward Date   {{outward_date}}  \r\n Total Qty  {{qty}}',1,'',0,'{{batch_no}} {{expiry_date}} {{outward_date}} {{qty}}','','','pharmacy',1,'2021-09-17 02:54:13'),(25,'purchase_medicine','Purchase Medicine','Purchase Medicine Details :\r\nSupplier Name: {{supplier_name}} \r\nMedicine Details: {{medicine_details}}\r\nPurchase Date: {{purchase_date}}\r\nInvoice Number:  {{invoice_number}}\r\nTotal: {{total}}\r\nDiscount: {{discount}} \r\nTax: {{tax}}\r\nNet Amount: {{net_amount}}',1,'',0,'{{supplier_name}} {{medicine_details}} {{purchase_date}} {{invoice_number}} {{total}} {{discount}} {{tax}} {{net_amount}}','','','pharmacy',1,'2021-09-17 02:54:13'),(26,'pathology_investigation','Pathology Investigation','Pathology Test Report for Patient: {{patient_name}} ({{patient_id}}) case id: {{case_id}}. Pathology test assign by {{doctor_name}}. pathology charge- total amount {{total}}, discount {{discount}} ,tax {{tax}}  net amount is {{net_amount}} and total paid amount {{paid_amount}}.',1,'Dear {{patient_name}} ({{patient_id}}) case id: {{case_id}}. Your pathology test bill number is {{bill_no}} and total amount {{total}}, tax {{tax}}, discount {{discount}} so now your net amount is {{net_amount}}.  You have paid your total amount {{paid_amount}}.',1,'{{patient_name}} {{patient_id}} {{case_id}} {{bill_no}} {{date}} {{doctor_name}}  {{total}} {{discount}} {{tax}} {{net_amount}} {{paid_amount}}','','','pathology',1,'2021-09-17 02:54:13'),(27,'pathology_sample_collection','Pathology Sample Collection','Pathology Bill Number {{bill_no}} Patient: {{patient_name}} ({{patient_id}}) Case id: {{case_id}}. Sample Collected  by  {{sample_collected_person_name}} on {{collected_date}} from {{pathology_center}} and report expected date is {{expected_date}}.',1,'Dear {{patient_name}} {{patient_id}} Case id: {{case_id}}  your pathology test sample collected by {{sample_collected_person_name}} on {{collected_date}} from {{pathology_center}} . Pathology Test report expected date {{expected_date}}. ',1,'{{patient_name}} {{patient_id}} {{case_id}} {{bill_no}} {{test_name}} {{sample_collected_person_name}} {{collected_date}} {{pathology_center}} {{expected_date}} {{doctor_name}}','','','pathology',1,'2021-09-17 02:54:13'),(28,'pathology_test_report','Pathology Test Report','Pathology Test Report Bill Number {{bill_no}} for Patient Name is {{patient_name}} {{patient_id}} Case id {{case_id}} and test approved by {{approved_by}} on {{approve_date}} . Pathology Test {{test_name}} sample collected by {{sample_collected_person_name}} on {{collected_date}} from {{pathology_center}} and Expected date {{expected_date}} . {{doctor_name}}',1,'Dear {{patient_name}} {{patient_id}} Case id  {{case_id}}. Your Pathology Test {{test_name}} sample collected by {{sample_collected_person_name}} on  {{collected_date}} from {{pathology_center}} .',1,'{{patient_name}} {{patient_id}} {{case_id}} {{bill_no}} {{test_name}} {{sample_collected_person_name}} {{collected_date}} {{pathology_center}} {{expected_date}} {{approved_by}} {{approve_date}} {{doctor_name}}','','','pathology',1,'2021-09-17 02:54:13'),(29,'radiology_investigation','Radiology Investigation','Radiology Test Report for Patient: {{patient_name}} ({{patient_id}}) case id: {{case_id}}. Radiology test assign by {{doctor_name}}. Test Charge total amount {{total}}, total discount {{discount}}, tax {{tax}}.',1,'Dear {{patient_name}} ({{patient_id}}) case id: {{case_id}}. Your Radiology test bill number is {{bill_no}},  total bill amount {{total}} tax {{tax}}, discount {{discount}} so now your net amount {{net_amount}} and total paid amount is {{paid}}. ',1,'{{patient_name}} {{patient_id}} {{case_id}} {{bill_no}} {{date}} {{doctor_name}}  {{total}} {{net_amount}} {{paid}} {{discount}} {{tax}}','','','radiology',1,'2021-09-17 02:54:13'),(30,'radiology_sample_collection','Radiology Sample Collection','Radiology Bill Number: {{bill_no}} for Patient: {{patient_name}} ({{patient_id}}) Case id: {{case_id}}. Radiology test name is {{test_name}} and sample collected by {{sample_collected_person_name}} on {{collected_date}} from {{radiology_center}} and report expected date is {{expected_date}}.',1,'Dear {{patient_name}} {{patient_id}} Case id: {{case_id}}  your radiology test is {{test_name}} and  sample collected by {{sample_collected_person_name}} on {{collected_date}} from {{radiology_center}}. Test report expected date {{expected_date}}. ',1,'{{patient_name}} {{patient_id}} {{case_id}} {{bill_no}} {{test_name}} {{sample_collected_person_name}} {{collected_date}} {{radiology_center}} {{expected_date}} {{doctor_name}}','','','radiology',1,'2021-09-17 02:54:13'),(31,'radiology_test_report','Radiology Test Report','Radiology Bill Number {{bill_no}} Patient Name {{patient_name}} ({{patient_id}}) Case id ( {{case_id}}). Sample Collected  by  {{sample_collected_person_name}} on {{collected_date}} from {{radiology_center}} and Expected date is {{expected_date}}.',1,'Dear {{patient_name}} {{patient_id}} Case id ({{case_id}}) your radiology test sample collected by {{sample_collected_person_name}} on {{collected_date}} from  {{radiology_center}}. radiology test report expected date {{expected_date}} .',1,'{{patient_name}} {{patient_id}} {{case_id}} {{bill_no}} {{test_name}} {{sample_collected_person_name}} {{collected_date}} {{radiology_center}} {{expected_date}} {{approved_by}} {{approved_date}} {{doctor_name}}','','','radiology',1,'2021-09-17 02:54:13'),(32,'add_bag_stock','Add Bag Stock','New Add Bag Stock Details- Donor Name: {{donor_name}}, Blood Group: ({{blood_group}}) and contact number {{contact_no}} . Donate bag details blood bag number ({{bag}}) and charge {{charge_name}} donated date {{donate_date}}. Total amount {{total}} discount {{discount}} tax {{tax}} so total net amount is {{net_amount}}.',1,'',0,'{{donor_name}} {{blood_group}} {{contact_no}} {{donate_date}} {{bag}} {{charge_name}} {{total}} {{discount}} {{tax}} {{net_amount}}','','','blood_bank',1,'2021-09-17 02:54:13'),(33,'blood_issue','Blood Issue','Blood issue for Bill Number {{bill_no}} Patient: {{patient_name}} ({{patient_id}}) Case Id {{case_id}} . Patient blood group is {{blood_group}} and bag number ({{bag}}) issue on {{issue_date}}, reference by {{reference_name}}. Applied charge name is {{charge_name}} and total amount {{total}}, discount {{discount}}, tax {{tax}}, now total net amount{{net_amount}}.',1,'Dear {{patient_name}} ({{patient_id}}) case id: {{case_id}} your bill number {{bill_no}} blood group {{blood_group}} bag number is {{bag}} charge name  {{charge_name}} issue on {{issue_date}} reference by {{reference_name}} .Total amount {{total}}, discount {{discount}}, tax {{tax}} now your total net amount {{net_amount}}.',1,'{{patient_name}} {{patient_id}} {{case_id}} {{bill_no}} {{issue_date}} {{reference_name}} {{blood_group}} {{bag}} {{charge_name}} {{total}} {{discount}} {{tax}} {{net_amount}} ','','','blood_bank',1,'2021-09-17 02:54:13'),(34,'add_component_of_blood','Add Component of Blood','{{component_name}} component has been added on the bag number {{bag}} of Blood Group {{blood_group}} .',1,'',0,'{{blood_group}} {{bag}} {{ component_name}} {{component_bag}}','','','blood_bank',1,'2021-09-17 02:54:13'),(35,'component_issue','Component Issue','Component Issue for  Bill Number {{bill_no}} Patient Name is {{patient_name}} ({{patient_id}}) Case Id: {{case_id}}.  Blood group {{blood_group}} Component: {{component}}, bag number {{bag}} issue on {{issue_date}}  reference by {{reference_name}}. Applied charge name {{charge_name}} total amount {{total}}  discount {{discount}} tax {{tax}} now total net amount {{net_amount}}.',1,'Dear {{patient_name}} ({{patient_id}}) {{case_id}} you have issued a component {{component}} Bag number is {{bag}}  blood group is {{blood_group}} issue on  {{issue_date}} reference by {{reference_name}} . Total amount {{total}} Discount {{discount}} Tax {{tax}} now your total net amount  is {{net_amount}}.',1,'{{patient_name}} {{patient_id}} {{case_id}} {{bill_no}} {{issue_date}} {{reference_name}} {{blood_group}} {{component}} {{bag}} {{charge_name}} {{total}} {{discount}} {{tax}} {{net_amount}} ','','','blood_bank',1,'2021-09-17 02:54:13'),(36,'live_opd_consultation_add','Live OPD Consultation Add','Live Consultation for  OPD {{opd_no}} Patient  Name {{patient_name}} {{patient_id}}  with Consultant Doctor {{doctor_name}} {{doctor_id}} . Live consulatent Title  {{consultation_title}} Date {{consultation_date}} minutes {{consultation_date}} {{consultation_duration_minutes}}.',1,'Dear {{patient_name}} {{patient_id}} your live consultation subject {{consultation_title}} date {{consultation_date}} minute {{consultation_duration_minutes}}  with Consultant Doctor {{doctor_name}} ({{doctor_id}}).',1,'{{patient_name}} {{patient_id}} {{consultation_title}} {{consultation_date}} {{consultation_duration_minutes}}  {{opd_no}} {{checkup_id}} {{doctor_id}} {{doctor_name}}','','','live_consultation',1,'2021-09-17 02:54:13'),(37,'live_opd_consultation_start','Live Opd Consultation Start','patient_name: {{patient_name}} patient_id: {{patient_id}} consultation_title: {{consultation_title}} consultation_date: {{consultation_date}}  consultation_duration_minutes: {{consultation_duration_minutes}} opd_no: {{opd_no}} checkup_id: {{checkup_id}} doctor_name: {{doctor_name}}',1,'patient_name: {{patient_name}} patient_id: {{patient_id}} consultation_title: {{consultation_title}} consultation_date: {{consultation_date}}  consultation_duration_minutes: {{consultation_duration_minutes}} opd_no: {{opd_no}} checkup_id: {{checkup_id}} doctor_name: {{doctor_name}}',1,'{{patient_name}} {{patient_id}} {{consultation_title}} {{consultation_date}} {{consultation_duration_minutes}}  {{opd_no}} {{checkup_id}} {{doctor_name}}','','','live_consultation',1,'2021-09-17 02:54:13'),(38,'live_meeting_start','Live Meeting Start','Live Meeting has been created for Staff: {{staff_list}}  Meeting Title is {{meeting_title}}  and Meeting Date {{meeting_date}} Meeting Duration Minutes: {{meeting_duration_minutes}}.',1,'',0,'{{meeting_title}} {{meeting_date}} {{meeting_duration_minutes}} {{staff_list}}','','','live_consultation',1,'2021-09-17 02:54:13'),(39,'live_meeting_add','Live Meeting Add','Live Meeting Created for Staff {{staff_list}} and  Meeting Title is {{meeting_title}} on Meeting Date {{meeting_date}} Meeting Duration Minutes{{meeting_duration_minutes}} .',1,'',0,'{{meeting_title}} {{meeting_date}} {{meeting_duration_minutes}} {{staff_list}}','','','live_consultation',1,'2021-09-17 02:54:13'),(40,'add_referral_payment','Add Referral Payment','Patient Name {{patient_name}} ({{patient_id}}) in {{patient_type}} Bill number {{bill_no}} and patient bill amount is {{patient_bill_amount}}. Commission percentage of total bill {{commission_percentage}}. Commission amount {{commission_amount}} has been given to the payee {{payee}}.',1,'',0,'{{patient_name}} {{patient_id}} {{patient_type}} {{bill_no}} {{patient_bill_amount}} {{payee}} {{commission_percentage}} {{commission_amount}}','','','referral',1,'2021-09-17 02:54:13'),(41,'patient_certificate_generate','Patient Certificate Generate','Patient Name {{patient_name}} {{patient_id}} certificate {{certificate_name}} has been generated. OPD/ IPD number {{opd_ipd_no}}.',1,'Dear Patient {{patient_name}} {{patient_id}} OPD / IPD number is {{opd_ipd_no}}  your certificate {{certificate_name}} has been generated.',1,'{{patient_name}} {{patient_id}} {{opd_ipd_no}} {{certificate_name}}','','','certificate',1,'2021-09-17 02:54:13'),(42,'patient_id_card_generate','remaining','ID Card is generated for Patient Name {{patient_name}} {{patient_id}} .',1,'Dear {{patient_name}} {{patient_id}} your id card is generated .',1,'{{patient_name}} {{patient_id}}  {{id_card_template}}','','','certificate',1,'2021-09-17 02:54:13'),(43,'generate_staff_id_card','Generate Staff ID Card','Staff ID card is generated for Role: {{role}}, staff name {{staff_name}} suename {{staff_surname}} employee id: {{employee_id}}.',1,'',0,'{{role}} {{staff_name}} {{staff_surname}} {{employee_id}} {{id_card_template}}','','','certificate',1,'2021-09-17 02:54:13'),(44,'create_ambulance_call','Create Ambulance Call','{{patient_name}} {{patient_id}} has booked an ambulance on {{date}} his charge name {{charge_name}} tax {{tax}}  net amount {{net_amount}} and total paid  amount {{paid_amount}}.\r\n\r\nAmbulance Details \r\n\r\nVehicle Model  {{vehicle_model}}\r\nDriver Name  {{driver_name}}',1,'Dear {{patient_name}} {{patient_id}} your ambulance is booked on {{date}} . Charge applied {{charge_name}}, tax {{tax}} net amount is {{net_amount}} and your paid amount is {{paid_amount}} .\r\n\r\nAmbulance Details-\r\nVehicle Model: {{vehicle_model}}\r\nDriver Name: {{driver_name}}',1,'{{patient_name}} {{patient_id}} {{vehicle_model}} {{driver_name}} {{date}} {{charge_name}} {{tax}} {{net_amount}} {{paid_amount}}','','','ambulance',1,'2021-09-17 02:54:13'),(45,'add_birth_record','Add Birth Record','Patient {{mother_name}} ({{mother_id}}) has given birth to a new baby {{child_name}} on {{birth_date}}.',1,'Dear {{mother_name}} {{mother_id}} case id : {{case_id}} your baby {{child_name}} is born on {{birth_date}}.',1,'{{mother_name}} {{mother_id}} {{child_name}} {{birth_date}} {{case_id}}','','','birth_death_record',1,'2021-09-17 02:54:13'),(46,'add_death_record','Add Death Record','Patient {{patient_name}} ({{patient_id}}) Case id :{{case_id}} has died on {{death_date}}.',1,'',0,'{{case_id}} {{patient_name}} {{patient_id}} {{death_date}}','','','birth_death_record',1,'2021-09-17 02:54:13'),(47,'staff_enabale_disable','Staff Enabale/Disable','Staff Name: {{staff_name}} surname: {{staff_surname}} Employment ID: ({{employee_id}}) has been {{status}}.',1,'',0,'{{staff_name}} {{staff_surname}} {{employee_id}} {{status}}','','','human_resource',1,'2021-09-17 02:54:13'),(48,'staff_generate_payroll','Staff Generate Payroll','Payroll Generated for  Month {{month}} year {{year}}  Role {{role}} . Basic Salary is {{basic_salary}} Earning  {{earning}} Deduction {{deduction}} Gross salary  {{gross_salary}}.  Now Total Net Salary {{net_salary}}.',1,'',0,'{{role}} {{month}} {{year}} {{basic_salary}} {{earning}} {{deduction}} {{gross_salary}} {{tax_amount}} {{net_salary}}','','','human_resource',1,'2021-09-17 02:54:13'),(49,'staff_leave','Staff Leave','Staff {{staff_name}} {{staff_surname}} ({{employee_id}}) has applied leave on Date {{apply_date}} for leave {{days}} days. date {{leave_date}} . Currently Leave Status is {{leave_status}} .',1,'',0,'{{apply_date}} {{leave_type}} {{leave_date}} {{days}} {{staff_name}} {{staff_surname}} {{employee_id}}\r\n{{leave_status}}','','','human_resource',1,'2021-09-17 02:54:13'),(50,'staff_leave_status','Staff Leave Status','Staff Name {{staff_name}} {{staff_surname}} {{employee_id}} has applied leave for {{days}} days. leave date: {{leave_date}}, Leave Status:  {{leave_status}}.',1,'',0,'{{apply_date}} {{leave_type}} {{leave_date}} {{days}} {{staff_name}} {{staff_surname}} {{employee_id}}\r\n{{leave_status}}','','','human_resource',1,'2021-09-17 02:54:13'),(51,'live_ipd_consultation_add','Live IPD Consultation Add','Live Consultation for IPD {{ipd_no}} Patient  Name {{patient_name}} {{patient_id}} with Consultant Doctor {{doctor_name}} {{doctor_id}} . Live consulatent Title  {{consultation_title}} Date {{consultation_date}} minutes {{consultation_date}} {{consultation_duration_minutes}}.',1,'Dear {{patient_name}} {{patient_id}} your live consultation subject {{consultation_title}} date {{consultation_date}} minute {{consultation_duration_minutes}}  with Consultant Doctor {{doctor_name}} ({{doctor_id}}).',1,'{{patient_name}} {{patient_id}} {{consultation_title}} {{consultation_date}} {{consultation_duration_minutes}} \r\n{{ipd_no}} {{doctor_id}} {{doctor_name}}','','','live_consultation',1,'2021-09-17 02:54:13'),(52,'live_ipd_consultation_start','Live IPD Consultation Start','IPD No {{ipd_no}} Patient Name {{patient_name}} {{patient_id}}. Live Consultation Doctor {{doctor_name}}. \r\n\r\nLive Consultation Details.\r\nConsultation Title {{consultation_title}}\r\nConsultation Date  {{consultation_date}}\r\nConsultation Duration Minutes  {{consultation_duration_minutes}}',1,'Dear patient patient_name: {{patient_name}} patient_id: {{patient_id}} , your live consultation consultation_title: {{consultation_title}} has been scheduled on Consultation Date: {{consultation_date}} for the duration of consultation_duration_minutes: {{consultation_duration_minutes}} minute, ipd_no: {{ipd_no}} and your consultant doctor doctor_name: {{doctor_name}}  please do not share the link to any body.',1,'{{patient_name}} {{patient_id}} {{consultation_title}} {{consultation_date}} {{consultation_duration_minutes}}  {{ipd_no}} {{doctor_name}}','','','live_consultation',1,'2021-09-17 02:54:13'),(53,'add_ipd_discharge_patient','Add IPD Discharge Patient','IPD Patient: {{patient_name}}({{patient_id}}) status: ({{discharge_status}}) on {{discharge_date}}.',1,'Dear {{patient_name}} {{patient_id}} you have been {{discharge_status}} on {{discharge_date}}.',1,'{{patient_name}} {{patient_id}} {{discharge_status}} {{discharge_date}} {{ipd_no}} {{case_id}}','','','ipd',1,'2021-09-17 02:54:13'),(54,'add_opd_discharge_patient','Add OPD Discharge Patient','OPD Patient {{patient_name}} {{patient_id}} discharge status: {discharge_status}} on {{discharge_date}}.',1,'\r\nDear {{patient_name}} {{patient_id}} you have been {{discharge_status}} on {{discharge_date}}.',1,'{{patient_name}} {{patient_id}} {{discharge_status}} {{discharge_date}} {{opd_no}} {{case_id}}','','','opd',1,'2021-09-17 02:54:13'),(55,'add_payroll_payment','Add Payroll Payment','Month {{month}} salary amount {{payment_amount}} has been given to staff name {{staff}} on date {{payment_date}}.',1,'staff: {{staff}} payment_amount: {{payment_amount}} month: {{month}} year: {{year}} payment_mode: {{payment_mode}} payment_date: {{payment_date}}\r\n',0,'{{staff}} {{payment_amount}} {{month}} {{year}} {{payment_mode}} {{payment_date}}','','','human_resource',1,'2021-09-17 02:54:13'),(56,'add_opd_generate_bill','Add OPD Generate Bill','Generated bill for OPD Number {{opd_id}}  Patient Name {{patient_name}} {{patient_id}} .\r\n\r\nBill Details\r\nTotal Amount {{total}}\r\nNet Amount {{net_amount}}\r\nTax  {{tax}}\r\nPaid Amount   {{paid}}\r\nDue Amount   {{due}}',1,'Dear {{patient_name}} {{patient_id}}  your OPD bill is generated for Case Id {{case_id}} .\r\n\r\nBill Details\r\nTotal Amount {{total}}\r\nNet Amount {{net_amount}}\r\nTax  {{tax}}\r\nPaid Amount   {{paid}}\r\nDue Amount   {{due}}',1,'{{patient_name}} {{patient_id}} {{opd_id}} {{case_id}} {{net_amount}} {{total}} {{tax}} {{paid}} {{due}}','','','opd',1,'2021-09-17 02:54:13'),(57,'patient_consultation_add','Patient Consultation Add','Live Consultation for Patient  Name {{patient_name}} {{patient_id}}  with Consultant Doctor {{doctor_name}} . Live consulatent Title  {{consultation_title}} Date {{consultation_date}} minutes {{consultation_date}} {{consultation_duration_minutes}}.',1,'Dear {{patient_name}} {{patient_id}} your live consultation subject {{consultation_title}} date {{consultation_date}} minute {{consultation_duration_minutes}}  with Consultant Doctor {{doctor_name}}.',1,'{{patient_name}} {{patient_id}} {{consultation_title}} {{consultation_date}} {{consultation_duration_minutes}}  {{checkup_id}} {{doctor_name}}','','','live_consultation',1,'2021-09-17 02:54:13'),(58,'opd_patient_discharge_revert','opd_patient_discharge_revert','patient_name: {{patient_name}} patient_id: {{patient_id}} discharge_status: {{discharge_status}} discharge_date: {{discharge_date}} opd_no: {{opd_no}} case_id: {{case_id}}',1,'patient_name: {{patient_name}} patient_id: {{patient_id}} discharge_status: {{discharge_status}} discharge_date: {{discharge_date}} opd_no: {{opd_no}} case_id: {{case_id}}',1,'{{patient_name}} {{patient_id}} {{discharge_status}} {{discharge_date}} {{opd_no}} {{case_id}}','','','opd',1,'2021-09-17 02:54:13'),(59,'ipd_patient_discharge_revert','ipd_patient_discharge_revert','patient_name: {{patient_name}} patient_id: {{patient_id}} discharge_status: {{discharge_status}} discharge_date: {{discharge_date}} ipd_no: {{ipd_no}} case_id: {{case_id}}',1,'patient_name: {{patient_name}} patient_id: {{patient_id}} discharge_status: {{discharge_status}} discharge_date: {{discharge_date}} ipd_no: {{ipd_no}} case_id: {{case_id}}',1,'{{patient_name}} {{patient_id}} {{discharge_status}} {{discharge_date}} {{ipd_no}} {{case_id}}','','','opd',1,'2021-09-17 02:54:13'),(60,'add_ipd_previous_obstetric_history','Add IPD  Previous Obstetric History','IPD  Previous Obstetric History been created for Patient: {{patient_name}} ({{patient_id}}).',1,'IPD  Previous Obstetric History been created for Patient: {{patient_name}} ({{patient_id}}). ',1,'{{patient_name}} {{patient_id}} {{ipd_no}} {{case_id}} {{place_of_delivery}}','','','ipd',1,'2021-09-17 02:54:13'),(61,'add_ipd_postnatal_history','Add IPD Postnatal History','IPD Postnatal History\r\n has been created for Patient: {{patient_name}} ({{patient_id}}).',1,'IPD Postnatal History\r\n has been created for Patient: {{patient_name}} ({{patient_id}}).\r\n',1,'{{patient_name}} {{patient_id}} {{ipd_no}} {{case_id}} {{labor_time}} {{delivery_time}}','','','ipd',1,'2021-09-17 02:54:13'),(62,'add_ipd_antenatal','Add IPD Antenatal','IPD Antenatal has been created for Patient: {{patient_name}} ({{patient_id}}).',1,'IPD Antenatal has been created for Patient: {{patient_name}} ({{patient_id}}). \r\n\r\n',1,'{{patient_name}} {{patient_id}} {{ipd_no}} {{case_id}} {{date}}','','','ipd',1,'2021-09-17 02:54:13'),(63,'add_opd_antenatal','Add OPD Antenatal','OPD Antenatal has been created for Patient: {{patient_name}} ({{patient_id}}).',1,'\r\n OPD Antenatal has been created for Patient: {{patient_name}} ({{patient_id}}).',1,'{{patient_name}} {{patient_id}} {{opd_no}} {{case_id}} {{date}}','','','opd',1,'2021-09-17 02:54:13'),(64,'opd_new_checkup_created','OPD New Checkup Created','OPD New Checkup Created {{patient_name}} doctor and admin msg',1,'OPD New Checkup Created {{patient_name}} patient mesg',1,'{{patient_name}} {{patient_id}} {{ipd_no}} {{case_id}} {{place_of_delivery}}','','','opd',1,'2021-09-17 02:54:13');
/*!40000 ALTER TABLE `system_notification_setting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tax_category`
--

DROP TABLE IF EXISTS `tax_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tax_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `percentage` float(10,2) DEFAULT 0.00,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `index_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tax_category`
--

LOCK TABLES `tax_category` WRITE;
/*!40000 ALTER TABLE `tax_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `tax_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(100) DEFAULT NULL,
  `section` varchar(50) NOT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `case_reference_id` int(11) DEFAULT NULL,
  `opd_id` int(11) DEFAULT NULL,
  `ipd_id` int(11) DEFAULT NULL,
  `pharmacy_bill_basic_id` int(11) DEFAULT NULL,
  `pathology_billing_id` int(11) DEFAULT NULL,
  `radiology_billing_id` int(11) DEFAULT NULL,
  `blood_donor_cycle_id` int(11) DEFAULT NULL,
  `blood_issue_id` int(11) DEFAULT NULL,
  `ambulance_call_id` int(11) DEFAULT NULL,
  `appointment_id` int(11) DEFAULT NULL,
  `attachment` text DEFAULT NULL,
  `attachment_name` text DEFAULT NULL,
  `amount_type` varchar(10) DEFAULT NULL,
  `amount` float(10,2) DEFAULT NULL,
  `payment_mode` varchar(100) DEFAULT NULL,
  `cheque_no` varchar(100) DEFAULT NULL,
  `cheque_date` date DEFAULT NULL,
  `payment_date` datetime DEFAULT NULL,
  `note` text DEFAULT NULL,
  `received_by` int(11) DEFAULT NULL,
  `bill_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `patient_id` (`patient_id`),
  KEY `case_reference_id` (`case_reference_id`),
  KEY `opd_id` (`opd_id`),
  KEY `ipd_id` (`ipd_id`),
  KEY `pharmacy_bill_basic_id` (`pharmacy_bill_basic_id`),
  KEY `pathology_billing_id` (`pathology_billing_id`),
  KEY `radiology_billing_id` (`radiology_billing_id`),
  KEY `blood_donor_cycle_id` (`blood_donor_cycle_id`),
  KEY `blood_issue_id` (`blood_issue_id`),
  KEY `ambulance_call_id` (`ambulance_call_id`),
  KEY `appointment_id` (`appointment_id`),
  KEY `bill_id` (`bill_id`),
  KEY `idx_type` (`type`),
  KEY `idx_patient_id` (`patient_id`),
  KEY `index_type` (`type`),
  KEY `index_section` (`section`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactions`
--

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactions_processing`
--

DROP TABLE IF EXISTS `transactions_processing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transactions_processing` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gateway_ins_id` int(11) NOT NULL,
  `type` varchar(100) DEFAULT NULL,
  `section` varchar(50) NOT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `case_reference_id` int(11) DEFAULT NULL,
  `opd_id` int(11) DEFAULT NULL,
  `ipd_id` int(11) DEFAULT NULL,
  `pharmacy_bill_basic_id` int(11) DEFAULT NULL,
  `pathology_billing_id` int(11) DEFAULT NULL,
  `radiology_billing_id` int(11) DEFAULT NULL,
  `blood_donor_cycle_id` int(11) DEFAULT NULL,
  `blood_issue_id` int(11) DEFAULT NULL,
  `ambulance_call_id` int(11) DEFAULT NULL,
  `appointment_id` int(11) DEFAULT NULL,
  `attachment` varchar(250) DEFAULT NULL,
  `attachment_name` text DEFAULT NULL,
  `amount_type` varchar(10) DEFAULT NULL,
  `amount` float(10,2) DEFAULT NULL,
  `payment_mode` varchar(100) DEFAULT NULL,
  `cheque_no` varchar(100) DEFAULT NULL,
  `cheque_date` date DEFAULT NULL,
  `payment_date` datetime DEFAULT NULL,
  `note` text DEFAULT NULL,
  `received_by` int(11) DEFAULT NULL,
  `bill_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `patient_id` (`patient_id`),
  KEY `case_reference_id` (`case_reference_id`),
  KEY `opd_id` (`opd_id`),
  KEY `ipd_id` (`ipd_id`),
  KEY `pharmacy_bill_basic_id` (`pharmacy_bill_basic_id`),
  KEY `pathology_billing_id` (`pathology_billing_id`),
  KEY `radiology_billing_id` (`radiology_billing_id`),
  KEY `blood_donor_cycle_id` (`blood_donor_cycle_id`),
  KEY `blood_issue_id` (`blood_issue_id`),
  KEY `ambulance_call_id` (`ambulance_call_id`),
  KEY `appointment_id` (`appointment_id`),
  KEY `bill_id` (`bill_id`),
  KEY `index_attachment` (`attachment`),
  KEY `index_amount_type` (`amount_type`),
  KEY `index_amount` (`amount`),
  KEY `index_payment_mode` (`payment_mode`),
  KEY `index_cheque_no` (`cheque_no`),
  KEY `index_cheque_date` (`cheque_date`),
  KEY `index_payment_date` (`payment_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactions_processing`
--

LOCK TABLES `transactions_processing` WRITE;
/*!40000 ALTER TABLE `transactions_processing` DISABLE KEYS */;
/*!40000 ALTER TABLE `transactions_processing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unit`
--

DROP TABLE IF EXISTS `unit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unit_name` varchar(100) NOT NULL,
  `unit_type` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `index_unit_name` (`unit_name`),
  KEY `index_unit_type` (`unit_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unit`
--

LOCK TABLES `unit` WRITE;
/*!40000 ALTER TABLE `unit` DISABLE KEYS */;
/*!40000 ALTER TABLE `unit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `upload_contents`
--

DROP TABLE IF EXISTS `upload_contents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `upload_contents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content_type_id` int(11) NOT NULL,
  `image` text DEFAULT NULL,
  `thumb_path` text DEFAULT NULL,
  `dir_path` varchar(300) DEFAULT NULL,
  `real_name` text NOT NULL,
  `img_name` text DEFAULT NULL,
  `thumb_name` varchar(300) DEFAULT NULL,
  `file_type` varchar(100) NOT NULL,
  `mime_type` text NOT NULL,
  `file_size` varchar(100) NOT NULL,
  `vid_url` text NOT NULL,
  `vid_title` varchar(250) NOT NULL,
  `upload_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `upload_by` (`upload_by`),
  KEY `upload_contents_ibfk_2` (`content_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `upload_contents`
--

LOCK TABLES `upload_contents` WRITE;
/*!40000 ALTER TABLE `upload_contents` DISABLE KEYS */;
/*!40000 ALTER TABLE `upload_contents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userlog`
--

DROP TABLE IF EXISTS `userlog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userlog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user` varchar(100) DEFAULT NULL,
  `role` varchar(100) DEFAULT NULL,
  `ipaddress` varchar(100) DEFAULT NULL,
  `user_agent` varchar(500) DEFAULT NULL,
  `login_datetime` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userlog`
--

LOCK TABLES `userlog` WRITE;
/*!40000 ALTER TABLE `userlog` DISABLE KEYS */;
INSERT INTO `userlog` VALUES (1,'admin@sfu.com','Super Admin','::1','Chrome 156.0.0.0, Windows 10','2026-11-05 13:51:14'),(2,'admin@sfu.com','Super Admin','::1','Chrome 156.0.0.0, Windows 10','2026-11-05 14:20:47'),(3,'admin@sfu.com','Super Admin','::1','Unidentified User Agent, Unknown Platform','2026-11-07 22:46:50'),(4,'admin@sfu.com','Super Admin','::1','Chrome 156.0.0.0, Windows 10','2026-11-07 22:48:35'),(5,'admin@sfu.com','Super Admin','::1','Unidentified User Agent, Unknown Platform','2026-11-07 23:12:09'),(6,'admin@sfu.com','Super Admin','::1','Unidentified User Agent, Unknown Platform','2026-11-07 23:20:00'),(7,'admin@sfu.com','Super Admin','::1','Unidentified User Agent, ','2026-11-08 11:42:20');
/*!40000 ALTER TABLE `userlog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `childs` text DEFAULT NULL,
  `role` varchar(30) NOT NULL,
  `verification_code` varchar(200) NOT NULL,
  `is_active` varchar(10) DEFAULT 'yes',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,1,'pat1','$2y$10$uMfZ9vn5jywqiyMCvAakxu4flInj.SM7dFrAJwlFRLG13.RAs.DvC',NULL,'patient','','yes','2026-11-08 15:06:44');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_authentication`
--

DROP TABLE IF EXISTS `users_authentication`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_authentication` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `users_id` int(11) DEFAULT NULL,
  `token` varchar(200) NOT NULL,
  `expired_at` datetime NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_authentication`
--

LOCK TABLES `users_authentication` WRITE;
/*!40000 ALTER TABLE `users_authentication` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_authentication` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicles`
--

DROP TABLE IF EXISTS `vehicles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vehicles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vehicle_no` varchar(20) DEFAULT NULL,
  `vehicle_model` varchar(100) NOT NULL DEFAULT 'None',
  `manufacture_year` varchar(4) DEFAULT NULL,
  `vehicle_type` varchar(100) NOT NULL,
  `driver_name` varchar(50) DEFAULT NULL,
  `driver_licence` varchar(50) NOT NULL DEFAULT 'None',
  `driver_contact` varchar(20) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `index_vehicle_no` (`vehicle_no`),
  KEY `index_vehicle_model` (`vehicle_model`),
  KEY `index_manufacture_year` (`manufacture_year`),
  KEY `index_vehicle_type` (`vehicle_type`),
  KEY `index_driver_name` (`driver_name`),
  KEY `index_driver_licence` (`driver_licence`),
  KEY `index_driver_contact` (`driver_contact`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicles`
--

LOCK TABLES `vehicles` WRITE;
/*!40000 ALTER TABLE `vehicles` DISABLE KEYS */;
/*!40000 ALTER TABLE `vehicles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visit_details`
--

DROP TABLE IF EXISTS `visit_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `visit_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `opd_details_id` int(11) DEFAULT NULL,
  `organisation_id` int(11) DEFAULT NULL,
  `patient_charge_id` int(11) DEFAULT NULL,
  `transaction_id` int(11) DEFAULT NULL,
  `cons_doctor` int(11) DEFAULT NULL,
  `case_type` varchar(200) NOT NULL,
  `appointment_date` datetime DEFAULT NULL,
  `symptoms_type` int(11) DEFAULT NULL,
  `symptoms` text DEFAULT NULL,
  `bp` varchar(100) DEFAULT NULL,
  `height` varchar(100) DEFAULT NULL,
  `weight` varchar(100) DEFAULT NULL,
  `pulse` varchar(200) DEFAULT NULL,
  `temperature` varchar(200) DEFAULT NULL,
  `respiration` varchar(200) DEFAULT NULL,
  `known_allergies` varchar(100) DEFAULT NULL,
  `patient_old` varchar(50) DEFAULT NULL,
  `casualty` varchar(200) DEFAULT NULL,
  `refference` varchar(200) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `note` text DEFAULT NULL,
  `note_remark` mediumtext DEFAULT NULL,
  `payment_mode` varchar(100) NOT NULL,
  `generated_by` int(11) DEFAULT NULL,
  `live_consult` varchar(50) DEFAULT NULL,
  `is_antenatal` int(11) NOT NULL,
  `can_delete` varchar(11) NOT NULL DEFAULT 'yes',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `generated_by` (`generated_by`),
  KEY `opd_details_id` (`opd_details_id`),
  KEY `organisation_id` (`organisation_id`),
  KEY `cons_doctor` (`cons_doctor`),
  KEY `patient_charge_id` (`patient_charge_id`),
  KEY `transaction_id` (`transaction_id`),
  KEY `index_case_type` (`case_type`),
  KEY `index_appointment_date` (`appointment_date`),
  KEY `index_symptoms_type` (`symptoms_type`),
  KEY `index_bp` (`bp`),
  KEY `index_height` (`height`),
  KEY `index_weight` (`weight`),
  KEY `index_pulse` (`pulse`),
  KEY `index_temperature` (`temperature`),
  KEY `index_respiration` (`respiration`),
  KEY `index_known_allergies` (`known_allergies`),
  KEY `index_patient_old` (`patient_old`),
  KEY `index_casualty` (`casualty`),
  KEY `index_refference` (`refference`),
  KEY `index_date` (`date`),
  KEY `index_payment_mode` (`payment_mode`),
  KEY `index_generated_by` (`generated_by`),
  KEY `index_live_consult` (`live_consult`),
  KEY `index_is_antenatal` (`is_antenatal`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visit_details`
--

LOCK TABLES `visit_details` WRITE;
/*!40000 ALTER TABLE `visit_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `visit_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visitors_book`
--

DROP TABLE IF EXISTS `visitors_book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `visitors_book` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `source` varchar(100) DEFAULT NULL,
  `purpose` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `contact` varchar(12) NOT NULL,
  `id_proof` varchar(50) NOT NULL,
  `visit_to` varchar(20) NOT NULL,
  `ipd_opd_staff_id` int(11) DEFAULT NULL,
  `related_to` varchar(60) NOT NULL,
  `no_of_pepple` int(11) NOT NULL,
  `date` date NOT NULL,
  `in_time` varchar(20) NOT NULL,
  `out_time` varchar(20) NOT NULL,
  `note` mediumtext DEFAULT NULL,
  `image` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `index_source` (`source`),
  KEY `index_purpose` (`purpose`),
  KEY `index_name` (`name`),
  KEY `index_email` (`email`),
  KEY `index_contact` (`contact`),
  KEY `index_id_proof` (`id_proof`),
  KEY `index_visit_to` (`visit_to`),
  KEY `index_related_to` (`related_to`),
  KEY `index_no_of_pepple` (`no_of_pepple`),
  KEY `index_date` (`date`),
  KEY `index_in_time` (`in_time`),
  KEY `index_out_time` (`out_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visitors_book`
--

LOCK TABLES `visitors_book` WRITE;
/*!40000 ALTER TABLE `visitors_book` DISABLE KEYS */;
/*!40000 ALTER TABLE `visitors_book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visitors_purpose`
--

DROP TABLE IF EXISTS `visitors_purpose`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `visitors_purpose` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `visitors_purpose` varchar(100) NOT NULL,
  `description` mediumtext DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `index_visitors_purpose` (`visitors_purpose`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visitors_purpose`
--

LOCK TABLES `visitors_purpose` WRITE;
/*!40000 ALTER TABLE `visitors_purpose` DISABLE KEYS */;
/*!40000 ALTER TABLE `visitors_purpose` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vitals`
--

DROP TABLE IF EXISTS `vitals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vitals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `reference_range` varchar(100) NOT NULL,
  `unit` varchar(11) DEFAULT NULL,
  `is_system` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `unit` (`unit`),
  KEY `index_name` (`name`),
  KEY `index_reference_range` (`reference_range`),
  KEY `index_unit` (`unit`),
  KEY `index_is_system` (`is_system`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vitals`
--

LOCK TABLES `vitals` WRITE;
/*!40000 ALTER TABLE `vitals` DISABLE KEYS */;
INSERT INTO `vitals` VALUES (1,'Height','1  -  200','Centimeters',1,'2024-03-14 06:03:18'),(2,'Weight','0  -  150','Kilograms',1,'2024-05-20 09:06:24'),(3,'Pulse ','70 -   100 ','Beats per',1,'2024-03-07 11:27:43'),(4,'Temperature','95.8  -  99.3','Fahrenheit ',1,'2024-05-16 10:59:30'),(5,'BP','90/60  -  140/90','mmHg',1,'2024-03-07 11:27:48');
/*!40000 ALTER TABLE `vitals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zoom_settings`
--

DROP TABLE IF EXISTS `zoom_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zoom_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `zoom_api_key` varchar(200) DEFAULT NULL,
  `zoom_api_secret` varchar(200) DEFAULT NULL,
  `use_doctor_api` int(11) DEFAULT 1,
  `use_zoom_app` int(11) DEFAULT 1,
  `opd_duration` int(11) DEFAULT NULL,
  `ipd_duration` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zoom_settings`
--

LOCK TABLES `zoom_settings` WRITE;
/*!40000 ALTER TABLE `zoom_settings` DISABLE KEYS */;
INSERT INTO `zoom_settings` VALUES (1,'','',0,0,0,0,'2021-10-29 09:58:05');
/*!40000 ALTER TABLE `zoom_settings` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-09 15:50:29
