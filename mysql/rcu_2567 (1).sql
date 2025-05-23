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
-- Table structure for table `rcu_2567`
--


CREATE TABLE `rcu_2567` (
  `id` int(20) NOT NULL,
  `student_id` varchar(15) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `nick_name` varchar(50) DEFAULT NULL,
  `sex` varchar(6) DEFAULT NULL,
  `prefix` varchar(20) DEFAULT NULL,
  `tel_no` varchar(50) DEFAULT NULL,
  `e_mail` varchar(100) DEFAULT NULL,


  faculty
  branch
  



  `st_type` varchar(100) DEFAULT NULL,
  `st_year` varchar(2) DEFAULT NULL,
  `province` varchar(100) DEFAULT NULL,
  `faculty` varchar(100) DEFAULT NULL,
  `section` varchar(100) DEFAULT NULL,
  `student_level` varchar(2) NOT NULL DEFAULT '1',
  `building_no` int(2) DEFAULT '0',
  `floor_no` int(5) DEFAULT NULL,
  `room_no` varchar(5) DEFAULT NULL,
  `bed_no` varchar(2) DEFAULT NULL,
  `n_building_no` int(2) DEFAULT NULL,
  `n_floor_no` int(5) DEFAULT NULL,
  `n_room_no` varchar(5) DEFAULT NULL,
  `n_bed_no` varchar(2) DEFAULT NULL,
  `rcu_number` varchar(50) DEFAULT NULL,
  `gpax` varchar(5) DEFAULT NULL,
  `interview1` int(2) DEFAULT '0',
  `interview2` int(2) NOT NULL DEFAULT '1',
  `bed_reserve` int(2) DEFAULT '0',
  `stay_06` int(3) NOT NULL DEFAULT '0',
  `stay_07` int(3) NOT NULL DEFAULT '0',
  `stay_08` int(3) NOT NULL DEFAULT '0',
  `stay_09` int(3) NOT NULL DEFAULT '0',
  `stay_10` int(3) NOT NULL DEFAULT '0',
  `stay_11` int(3) NOT NULL DEFAULT '0',
  `stay_12` int(3) NOT NULL DEFAULT '0',
  `stay_01` int(3) NOT NULL DEFAULT '0',
  `stay_02` int(3) NOT NULL DEFAULT '0',
  `stay_03` int(3) NOT NULL DEFAULT '0',
  `stay_04` int(3) NOT NULL,
  `stay_05` int(3) NOT NULL,
  `stay_summer` int(2) NOT NULL DEFAULT '0',
  `pay_summer` int(2) NOT NULL DEFAULT '0',
  `pay_01` int(2) NOT NULL DEFAULT '0',
  `pay_02` int(2) NOT NULL DEFAULT '0',
  `pay_dec` int(2) NOT NULL DEFAULT '0',
  `pay_dec_d` int(3) DEFAULT NULL,
  `pay_dec_m` varchar(3) DEFAULT NULL,
  `pay_dec_y` varchar(5) DEFAULT NULL,
  `pay_dec_amo` varchar(10) DEFAULT NULL,
  `pay_dec_by` varchar(40) DEFAULT NULL,
  `pay_dec_dmy` varchar(50) DEFAULT NULL,
  `pay_dec_amount` varchar(20) DEFAULT NULL,
  `s_building_no` int(2) DEFAULT '0',
  `s_floor_no` int(5) DEFAULT '0',
  `s_room_no` varchar(20) DEFAULT NULL,
  `s_bed_no` varchar(10) DEFAULT NULL,
  `pay_summer_d` int(3) NOT NULL DEFAULT '0',
  `pay_summer_m` varchar(10) DEFAULT NULL,
  `pay_summer_y` varchar(10) DEFAULT NULL,
  `pay_summer_amo` varchar(10) DEFAULT NULL,
  `pay_summer_by` varchar(20) DEFAULT NULL,
  `pay_summer_dmy` varchar(50) DEFAULT NULL,
  `pay_summer_amount` varchar(10) DEFAULT NULL,
  `pay_01_d` int(3) NOT NULL DEFAULT '0',
  `pay_01_m` varchar(10) DEFAULT NULL,
  `pay_01_y` varchar(10) DEFAULT NULL,
  `pay_01_amo` varchar(10) DEFAULT NULL,
  `pay_01_by` varchar(20) DEFAULT NULL,
  `pay_01_dmy` varchar(50) DEFAULT NULL,
  `pay_01_amount` varchar(20) DEFAULT NULL,
  `pay_02_d` int(3) NOT NULL DEFAULT '0',
  `pay_02_m` varchar(10) DEFAULT NULL,
  `pay_02_y` varchar(10) DEFAULT NULL,
  `pay_02_amo` varchar(10) DEFAULT NULL,
  `pay_02_by` varchar(20) DEFAULT NULL,
  `pay_02_dmy` varchar(50) DEFAULT NULL,
  `pay_02_amount` varchar(10) DEFAULT NULL,
  `elec_use` varchar(255) DEFAULT NULL,
  `elec_1` varchar(10) DEFAULT NULL,
  `elec_2` varchar(10) DEFAULT NULL,
  `elec_3` varchar(10) DEFAULT NULL,
  `elec_4` varchar(10) DEFAULT NULL,
  `elec_5` varchar(10) DEFAULT NULL,
  `elec_6` varchar(10) DEFAULT NULL,
  `elec_7` varchar(10) DEFAULT NULL,
  `start_type1` varchar(100) DEFAULT NULL,
  `start_type2` varchar(100) DEFAULT NULL,
  `start_type3` varchar(100) DEFAULT NULL,
  `start_type4` varchar(100) DEFAULT NULL,
  `start_type5` varchar(100) DEFAULT NULL,
  `start_type6` varchar(100) DEFAULT NULL,
  `start_type7` varchar(100) DEFAULT NULL,
  `end_type1` varchar(100) DEFAULT NULL,
  `end_type2` varchar(100) DEFAULT NULL,
  `end_type3` varchar(100) DEFAULT NULL,
  `end_type4` varchar(100) DEFAULT NULL,
  `end_type5` varchar(100) DEFAULT NULL,
  `end_type6` varchar(100) DEFAULT NULL,
  `end_type7` varchar(100) DEFAULT NULL,
  `pay_elec_1` varchar(20) DEFAULT NULL,
  `pay_elec_2` varchar(20) DEFAULT NULL,
  `pay_elec_3` varchar(20) DEFAULT NULL,
  `pay_elec_1_date` varchar(15) DEFAULT NULL,
  `pay_elec_2_date` varchar(15) DEFAULT NULL,
  `pay_elec_3_date` varchar(15) DEFAULT NULL,
  `loc` int(2) NOT NULL DEFAULT '0',
  `card_prnt` int(2) NOT NULL DEFAULT '0',
  `act_do1` varchar(255) DEFAULT NULL,
  `act_do2` varchar(255) DEFAULT NULL,
  `act_do3` varchar(255) DEFAULT NULL,
  `good_do1` varchar(255) DEFAULT NULL,
  `good_do2` varchar(255) DEFAULT NULL,
  `approve_item` tinytext,
  `comment` tinytext,
  `com_record` text,
  `app_con_1` int(2) NOT NULL DEFAULT '0',
  `app_con_1_date` varchar(50) DEFAULT NULL,
  `app_con_1_pass` int(2) NOT NULL DEFAULT '0',
  `app_con` int(2) NOT NULL DEFAULT '0',
  `gpax_file` varchar(100) DEFAULT NULL,
  `r_file` varchar(100) DEFAULT NULL,
  `r_file2` varchar(100) DEFAULT NULL,
  `cudson_file` varchar(40) DEFAULT NULL,
  `level` int(2) NOT NULL DEFAULT '2',
  `app_no` int(10) NOT NULL DEFAULT '0',
  `app_date` varchar(50) DEFAULT NULL,
  `justment` int(2) NOT NULL DEFAULT '0',
  `sup_name` varchar(100) DEFAULT NULL,
  `inter_date` varchar(100) DEFAULT NULL,
  `poll_no1` int(2) NOT NULL DEFAULT '0',
  `poll_no2` int(2) NOT NULL DEFAULT '0',
  `new_entry_year` varchar(10) DEFAULT NULL,
  `new_entry_term` varchar(5) DEFAULT NULL,
  `electric` decimal(9,2) DEFAULT NULL,
  `water` decimal(9,2) DEFAULT NULL,
  `insurance` decimal(9,2) DEFAULT NULL,
  `fine_etc` decimal(9,2) DEFAULT NULL,
  `act_attended` int(11) NOT NULL DEFAULT '0',
  `reset_by` varchar(40) NOT NULL,
  `app_type` varchar(1) DEFAULT NULL,
  `UpdateDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='ประวัตินิสิตรายปี';

--
-- Indexes for dumped tables
--

--
-- Indexes for table `rcu_2567`
--
ALTER TABLE `rcu_2567`
  ADD PRIMARY KEY (`id`),
  ADD KEY `student_id` (`student_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `rcu_2567`
--
ALTER TABLE `rcu_2567`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
