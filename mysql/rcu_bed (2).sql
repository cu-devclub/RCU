-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Feb 10, 2025 at 08:46 PM
-- Server version: 5.6.23-log
-- PHP Version: 5.6.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `on_rcu`
--

-- --------------------------------------------------------

--
-- Table structure for table `rcu_bed`
--

CREATE TABLE `rcu_bed` (
  `bed_id` int(10) NOT NULL,
  `bed_no` varchar(10) CHARACTER SET tis620 NOT NULL,
  `room_no` varchar(20) CHARACTER SET tis620 NOT NULL,
  `floor_no` int(5) NOT NULL,
  `building_no` int(2) NOT NULL,
  `building_name` varchar(100) CHARACTER SET tis620 NOT NULL,
  `student_id` varchar(20) CHARACTER SET tis620 DEFAULT NULL,
  `bed_status` int(2) NOT NULL DEFAULT '0',
  `re_mark` varchar(200) CHARACTER SET tis620 DEFAULT NULL,
  `reserve` int(2) NOT NULL DEFAULT '0',
  `bed_locked` varchar(1) CHARACTER SET tis620 NOT NULL DEFAULT '0',
  `bed_reset` int(2) NOT NULL DEFAULT '1',
  `reset_by` varchar(40) DEFAULT NULL,
  `UpdateDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='เก็บข้อมูลเตียงและห้';

--
-- Indexes for dumped tables
--

--
-- Indexes for table `rcu_bed`
--
ALTER TABLE `rcu_bed`
  ADD PRIMARY KEY (`bed_id`),
  ADD KEY `student_id` (`student_id`),
  ADD KEY `student_id_2` (`student_id`),
  ADD KEY `bed_no` (`bed_no`),
  ADD KEY `room_no` (`room_no`),
  ADD KEY `building_no` (`building_no`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `rcu_bed`
--
ALTER TABLE `rcu_bed`
  MODIFY `bed_id` int(10) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
