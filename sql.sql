-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jan 22, 2022 at 02:59 PM
-- Server version: 5.7.36
-- PHP Version: 7.4.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `javaweb`
--

-- --------------------------------------------------------

--
-- Table structure for table `booking`
--

DROP TABLE IF EXISTS `booking`;
CREATE TABLE IF NOT EXISTS `booking` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `roomId` int(11) NOT NULL,
  `clientId` int(11) NOT NULL,
  `startDate` date NOT NULL,
  `endDate` date NOT NULL,
  `price` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk` (`roomId`),
  KEY `fk2` (`clientId`)
) ENGINE=MyISAM AUTO_INCREMENT=34 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `booking`
--

INSERT INTO `booking` (`id`, `roomId`, `clientId`, `startDate`, `endDate`, `price`) VALUES
(21, 30, 28, '2022-02-01', '2022-02-03', 2000),
(20, 32, 34, '2022-01-21', '2022-01-22', 5000),
(17, 30, 28, '2022-01-18', '2022-01-22', 5000),
(16, 29, 28, '2022-01-06', '2022-01-14', 4000),
(19, 29, 28, '2022-01-21', '2022-01-28', 35000),
(15, 28, 28, '2022-01-02', '2022-01-05', 1000),
(22, 30, 33, '2022-02-03', '2022-02-05', 2000),
(23, 29, 33, '2022-03-02', '2022-03-04', 10000),
(24, 30, 33, '2022-04-08', '2022-04-15', 7000),
(25, 29, 28, '2022-05-13', '2022-05-19', 30000),
(26, 28, 28, '2022-01-22', '2022-01-28', 6000),
(27, 30, 33, '2022-06-03', '2022-06-10', 7000),
(28, 30, 28, '2022-07-02', '2022-07-06', 4000),
(29, 31, 33, '2022-08-03', '2022-08-12', 45000),
(30, 31, 28, '2022-09-02', '2022-09-17', 75000),
(31, 32, 28, '2022-10-07', '2022-10-21', 70000),
(32, 32, 33, '2022-12-02', '2022-12-16', 70000),
(33, 31, 28, '2022-11-03', '2022-11-11', 40000);

-- --------------------------------------------------------

--
-- Table structure for table `room`
--

DROP TABLE IF EXISTS `room`;
CREATE TABLE IF NOT EXISTS `room` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `num` varchar(20) NOT NULL,
  `type` enum('Single','Double','Suite','King','Queen','Studio') NOT NULL,
  `price` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `num` (`num`)
) ENGINE=MyISAM AUTO_INCREMENT=34 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `room`
--

INSERT INTO `room` (`id`, `num`, `type`, `price`) VALUES
(33, '666', 'Double', 1000),
(32, '555', 'Single', 5000),
(31, '444', 'Suite', 5000),
(30, '333', 'King', 1000),
(29, '222', 'Suite', 5000),
(28, '111', 'Double', 1000);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL,
  `role` varchar(20) NOT NULL,
  `verified` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=35 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `username`, `email`, `password`, `role`, `verified`) VALUES
(28, 'meeteorss', 'i.sigma98@gmail.com', '13085a63a2b3e4beb7ab10ee395aefe4', 'admin', 1),
(33, 'tester', 'test@test.com', '98f6bcd4621d373cade4e832627b4f6', 'client', 0),
(34, 'ismail', 'ismail.laanait98@gmail.com', '13085a63a2b3e4beb7ab10ee395aefe4', 'client', 1),
(31, 'user', 'user@use.com', '13085a63a2b3e4beb7ab10ee395aefe4', 'client', 0),
(32, 'user10', 'user10@user.com', '13085a63a2b3e4beb7ab10ee395aefe4', 'client', 0);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
