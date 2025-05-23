-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Feb 10, 2025 at 08:47 PM
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
-- Table structure for table `security`
--

CREATE TABLE `security` (
  `id_user` int(10) NOT NULL,
  `user_name` varchar(15) NOT NULL DEFAULT '',
  `user_password` varchar(50) DEFAULT NULL,
  `create_date` date DEFAULT NULL,
  `name` varchar(244) DEFAULT NULL,
  `level` int(2) NOT NULL DEFAULT '2',
  `rcu_level` int(2) NOT NULL DEFAULT '2',
  `student_level` int(2) NOT NULL DEFAULT '1',
  `rcu_start` varchar(50) DEFAULT NULL,
  `rcu_end` varchar(50) DEFAULT NULL,
  `faculty` varchar(100) DEFAULT NULL,
  `province` varchar(100) NOT NULL DEFAULT '',
  `last_access` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `now_access` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ip_address` varchar(20) DEFAULT NULL,
  `last_ip` varchar(20) NOT NULL DEFAULT '',
  `sex` varchar(50) DEFAULT NULL,
  `board_style` int(3) NOT NULL DEFAULT '6',
  `board_post` int(10) NOT NULL DEFAULT '0',
  `avater` varchar(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=tis620 COMMENT='??红?????????Ѻ??͡';

--
-- Indexes for dumped tables
--

--
-- Indexes for table `security`
--
ALTER TABLE `security`
  ADD PRIMARY KEY (`id_user`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `security`
--
ALTER TABLE `security`
  MODIFY `id_user` int(10) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
