-- phpMyAdmin SQL Dump
-- version 4.6.6deb5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Mar 27, 2019 at 07:32 AM
-- Server version: 5.7.25-0ubuntu0.18.04.2
-- PHP Version: 7.0.30-0ubuntu0.16.04.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `attendance_mang_system`
--
CREATE DATABASE IF NOT EXISTS `attendance_mang_system` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `attendance_mang_system`;

-- --------------------------------------------------------

--
-- Table structure for table `attendance`
--

DROP TABLE IF EXISTS `attendance`;
CREATE TABLE IF NOT EXISTS `attendance` (
  `att_id` int(8) NOT NULL AUTO_INCREMENT,
  `att_date` date NOT NULL,
  `att_prs_abs` tinyint(1) NOT NULL DEFAULT '0',
  `cls_id` int(3) NOT NULL,
  `std_id` int(5) NOT NULL,
  `teach_id` int(5) NOT NULL,
  PRIMARY KEY (`att_id`),
  KEY `att_cls_fk` (`cls_id`),
  KEY `att_std_id` (`std_id`),
  KEY `att_teach_fk` (`teach_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `attendance`
--

INSERT INTO `attendance` (`att_id`, `att_date`, `att_prs_abs`, `cls_id`, `std_id`, `teach_id`) VALUES
(1, '2019-03-25', 1, 100, 10001, 50000),
(2, '2019-03-24', 0, 100, 10001, 50000),
(3, '2019-03-20', 1, 100, 10001, 50000);

-- --------------------------------------------------------

--
-- Table structure for table `class`
--

DROP TABLE IF EXISTS `class`;
CREATE TABLE IF NOT EXISTS `class` (
  `cls_id` int(3) NOT NULL,
  `cls_name` varchar(50) NOT NULL,
  `teach_id` int(5) NOT NULL,
  PRIMARY KEY (`cls_id`),
  KEY `cls_taech_fk` (`teach_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `class`
--

INSERT INTO `class` (`cls_id`, `cls_name`, `teach_id`) VALUES
(100, 'A', 50000),
(101, 'B', 50001),
(102, 'C', 50002),
(103, 'D', 50001);

-- --------------------------------------------------------

--
-- Table structure for table `login`
--

DROP TABLE IF EXISTS `login`;
CREATE TABLE IF NOT EXISTS `login` (
  `user_id` int(5) NOT NULL,
  `user_name` varchar(50) NOT NULL,
  `pass_wd` varchar(50) NOT NULL,
  `teach_or_std` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `login`
--

INSERT INTO `login` (`user_id`, `user_name`, `pass_wd`, `teach_or_std`) VALUES
(10000, 'John', 'passwd', 0),
(10001, 'Priya', 'passwd', 0),
(10002, 'hema', 'passwd', 0),
(10003, 'thiru', 'passwd', 0),
(10004, 'kamalesh', 'passwd', 0),
(10005, 'avinash', 'passwd', 0),
(50000, 'moni', 'passwd', 1),
(50001, 'santheep', 'passwd', 1),
(50002, 'stalin', 'passwd', 1);

-- --------------------------------------------------------

--
-- Table structure for table `Students`
--

DROP TABLE IF EXISTS `Students`;
CREATE TABLE IF NOT EXISTS `Students` (
  `std_id` int(5) NOT NULL,
  `std_name` varchar(50) NOT NULL,
  `std_contact` int(10) NOT NULL,
  `std_address` varchar(255) NOT NULL,
  `class_id` int(3) NOT NULL,
  PRIMARY KEY (`std_id`),
  KEY `cls_std_fk` (`class_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Students`
--

INSERT INTO `Students` (`std_id`, `std_name`, `std_contact`, `std_address`, `class_id`) VALUES
(10000, 'John Doe', 908976782, 'Chennai', 100),
(10001, 'Priya', 908976782, 'Chennai', 100),
(10002, 'Hema', 998976782, 'Chennai', 100),
(10003, 'Thiru', 908976782, 'Chennai', 101),
(10004, 'Kamalesh', 908576782, 'Chennai', 101),
(10005, 'Avinash', 908896782, 'Chennai', 102);

-- --------------------------------------------------------

--
-- Table structure for table `teacher`
--

DROP TABLE IF EXISTS `teacher`;
CREATE TABLE IF NOT EXISTS `teacher` (
  `teach_id` int(5) NOT NULL,
  `teach_name` varchar(50) NOT NULL,
  `teach_contact` int(10) NOT NULL,
  `teach_specialisation` varchar(70) NOT NULL,
  PRIMARY KEY (`teach_id`),
  UNIQUE KEY `teach_contact` (`teach_contact`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `teacher`
--

INSERT INTO `teacher` (`teach_id`, `teach_name`, `teach_contact`, `teach_specialisation`) VALUES
(50000, 'Moni', 876765765, 'Tamil'),
(50001, 'Santheep', 878765765, 'English'),
(50002, 'Stalin', 976765765, 'Science');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `attendance`
--
ALTER TABLE `attendance`
  ADD CONSTRAINT `att_cls_fk` FOREIGN KEY (`cls_id`) REFERENCES `class` (`cls_id`),
  ADD CONSTRAINT `att_std_id` FOREIGN KEY (`std_id`) REFERENCES `Students` (`std_id`),
  ADD CONSTRAINT `att_teach_fk` FOREIGN KEY (`teach_id`) REFERENCES `teacher` (`teach_id`);

--
-- Constraints for table `class`
--
ALTER TABLE `class`
  ADD CONSTRAINT `cls_taech_fk` FOREIGN KEY (`teach_id`) REFERENCES `teacher` (`teach_id`);

--
-- Constraints for table `Students`
--
ALTER TABLE `Students`
  ADD CONSTRAINT `cls_std_fk` FOREIGN KEY (`class_id`) REFERENCES `class` (`cls_id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
