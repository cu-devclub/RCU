-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Feb 10, 2025 at 08:49 PM
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
-- Table structure for table `rcu_data`
--

CREATE TABLE `rcu_data` (
  `id` int(20) NOT NULL,
  `student_id` varchar(15) DEFAULT '',
  `sex` varchar(20) DEFAULT '',
  `prefix` varchar(50) NOT NULL DEFAULT '',
  `name` varchar(50) NOT NULL DEFAULT '',
  `nick_name` varchar(50) DEFAULT NULL,
  `student_level` varchar(5) DEFAULT '',
  `faculty` varchar(50) DEFAULT '',
  `section` varchar(50) DEFAULT '',
  `st_type` varchar(255) DEFAULT NULL,
  `ability` varchar(255) DEFAULT NULL,
  `schol` varchar(255) DEFAULT NULL,
  `schol_amount` varchar(255) DEFAULT NULL,
  `entry_date` varchar(50) DEFAULT '',
  `address` tinytext,
  `tumbol` varchar(200) DEFAULT NULL,
  `district` varchar(100) DEFAULT '',
  `province` varchar(100) DEFAULT '',
  `zip_code` varchar(50) DEFAULT '',
  `tel_no` varchar(50) DEFAULT NULL,
  `e_mail` varchar(50) DEFAULT NULL,
  `b_type` varchar(50) DEFAULT '',
  `disease` varchar(100) DEFAULT NULL,
  `drug` varchar(100) DEFAULT NULL,
  `doctor` varchar(200) DEFAULT NULL,
  `hospital` varchar(200) DEFAULT NULL,
  `d_day` varchar(10) DEFAULT NULL,
  `origin` varchar(50) DEFAULT '',
  `nation` varchar(50) DEFAULT '',
  `religion` varchar(50) DEFAULT '',
  `hischool` varchar(255) DEFAULT '',
  `sh_province` varchar(255) DEFAULT '',
  `sh_year` varchar(50) DEFAULT '',
  `sh_grade` varchar(50) DEFAULT '',
  `b_university` varchar(255) DEFAULT NULL,
  `b_faculty` varchar(255) DEFAULT NULL,
  `b_year` varchar(50) DEFAULT NULL,
  `b_section` varchar(100) DEFAULT NULL,
  `m_university` varchar(100) DEFAULT NULL,
  `m_faculty` varchar(100) DEFAULT NULL,
  `m_year` varchar(20) DEFAULT NULL,
  `m_section` varchar(100) DEFAULT NULL,
  `advisor` varchar(200) DEFAULT NULL,
  `resign` int(2) NOT NULL DEFAULT '0',
  `resign_date` varchar(50) DEFAULT NULL,
  `resign_reason` varchar(255) DEFAULT NULL,
  `st_style` varchar(100) DEFAULT NULL,
  `ac_no` varchar(100) DEFAULT NULL,
  `UpdateDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=tis620 COMMENT='??红????ŷ???仢ͧ?';

--
-- Indexes for dumped tables
--

--
-- Indexes for table `rcu_data`
--
ALTER TABLE `rcu_data`
  ADD PRIMARY KEY (`id`),
  ADD KEY `student_id` (`student_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `rcu_data`
--
ALTER TABLE `rcu_data`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
