
SET time_zone = "+07:00";

CREATE DATABASE IF NOT EXISTS `rcu_prod` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `rcu_prod`;


CREATE TABLE `card_color` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `year` INT(4) NOT NULL,
    `color` varchar(9) NOT NULL
)

CREATE TABLE `user` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `username` VARCHAR(30) NOT NULL,
    `password` CHAR(60) NOT NULL,
    `prev_access` TIMESTAMP DEFAULT NULL,
    `last_access` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `prev_ip` VARCHAR(15) DEFAULT NULL,
    `last_ip` VARCHAR(15) DEFAULT NULL,
    `profile` varchar(30) DEFAULT NULL,
    `first_name` varchar(30) DEFAULT NULL,
    `middle_name` varchar(30) DEFAULT NULL,
    `last_name` varchar(30) DEFAULT NULL,
    `nickname` varchar(30) DEFAULT NULL,
    `gender` ENUM("ชาย", "หญิง") NOT NULL,
    `birthdate` DATE NOT NULL,
    `religion` varchar(50) NOT NULL,
    `blood_type` varchar(2) NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(`username`)
);

CREATE TABLE `contact` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `user_id` INT UNSIGNED NOT NULL,
    `content` VARCHAR(100) NOT NULL,
    `type` ENUM("PHONE", "EMAIL") NOT NULL,
    FOREIGN KEY (`user_id`) REFERENCES `user`(`id`) ON DELETE CASCADE
);

CREATE TABLE `medical` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `user_id` INT UNSIGNED NOT NULL,
    `disease` JSON DEFAULT NULL,
    `drug` JSON DEFAULT NULL,
    `doctor` varchar(120) DEFAULT NULL,
    `hospital` varchar(200) DEFAULT NULL,
    FOREIGN KEY (`user_id`) REFERENCES `user`(`id`) ON DELETE CASCADE
);

CREATE TABLE `faculty` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` varchar(100) NOT NULL
);

CREATE TABLE `branch` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` varchar(100) NOT NULL
);

CREATE TABLE `program` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` varchar(200) NOT NULL
);

CREATE TABLE `student` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `user_id` INT UNSIGNED NOT NULL,
    `chula_id` CHAR(10) UNIQUE,
    `is_resign` BOOLEAN NOT NULL DEFAULT FALSE,
    `faculty_id` INT UNSIGNED NOT NULL,
    `branch_id` INT UNSIGNED NOT NULL,
    `program_id` INT UNSIGNED NOT NULL,
    `type` ENUM("ปริญญาตรี", "ปริญญาโท", "ปริญญาเอก") NOT NULL,
    FOREIGN KEY (`user_id`) REFERENCES `user`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`faculty_id`) REFERENCES `faculty`(`id`),
    FOREIGN KEY (`branch_id`) REFERENCES `branch`(`id`),
    FOREIGN KEY (`program_id`) REFERENCES `program`(`id`)
);

CREATE TABLE `student_skill` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `student_id` INT UNSIGNED NOT NULL,
    `skill` VARCHAR(100) NOT NULL,
    FOREIGN KEY (`student_id`) REFERENCES `student`(`id`)
);

CREATE TABLE `wing` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `room_start` INT(4) NOT NULL,
    `room_end` INT(4) NOT NULL,
    `building_id` INT UNSIGNED NOT NULL,
    FOREIGN KEY (`building_id`) REFERENCES `building`(`id`)
);

CREATE TABLE `wing_representator` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `student_id` INT UNSIGNED NOT NULL,
    `wing_id` INT UNSIGNED NOT NULL,
    `start` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `end` TIMESTAMP DEFAULT NULL,
    `year` INT(4) NOT NULL,
    FOREIGN KEY (`student_id`) REFERENCES `student`(`id`),
    FOREIGN KEY (`wing_id`) REFERENCES `wing`(`id`)
);

CREATE TABLE `building` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` varchar(20) NOT NULL,
    `type` ENUM("รายเทอม", "รายเดือน") DEFAULT "รายเดือน",
    `price` FLOAT NOT NULL,
    `electric_unit` FLOAT NOT NULL,
    `water_unit` FLOAT NOT NULL
);

CREATE TABLE `floor` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `level` INT(2) NOT NULL,
    `building_id` INT UNSIGNED NOT NULL,
    FOREIGN KEY (`building_id`) REFERENCES `building`(`id`)
);

CREATE TABLE `room` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `number` INT(4),
    `floor_id` INT UNSIGNED NOT NULL,
    FOREIGN KEY (`floor_id`) REFERENCES `floor`(`id`)
);

CREATE TABLE `bed` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `code` char(1) NOT NULL,
    `room_id` INT UNSIGNED NOT NULL,
    `floor_id` INT UNSIGNED NOT NULL,
    FOREIGN KEY (`room_id`) REFERENCES `room`(`id`),
    FOREIGN KEY (`floor_id`) REFERENCES `floor`(`id`)
);

CREATE TABLE `activity` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` varchar(300) NOT NULL,
    `date` DATETIME DEFAULT NULL,
    `score` INT DEFAULT 0,
    `year` INT(4) NOT NULL,
    `for_first_year` TINYINT DEFAULT 0,
    `head_student` TINYINT DEFAULT 0
);

CREATE TABLE `activity_attendance` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `activity_id` INT UNSIGNED NOT NULL,
    `user_id` INT UNSIGNED NOT NULL,
    `status` ENUM("PRESENT", "ABSENT", "LATE") NOT NULL DEFAULT "PRESENT",
    FOREIGN KEY (`activity_id`) REFERENCES `activity`(`id`),
    FOREIGN KEY (`user_id`) REFERENCES `user`(`id`) ON DELETE CASCADE
);