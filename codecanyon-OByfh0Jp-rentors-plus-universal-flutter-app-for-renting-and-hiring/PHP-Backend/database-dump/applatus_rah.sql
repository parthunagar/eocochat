-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 05, 2021 at 11:31 PM
-- Server version: 5.7.23-23
-- PHP Version: 7.3.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `applatus_rah`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL,
  `status` int(2) NOT NULL DEFAULT '1' COMMENT '1. active 0. inactive',
  `last_login` datetime NOT NULL,
  `role` int(11) NOT NULL DEFAULT '1' COMMENT '1. Manager 0. Super Admin',
  `verified_code` varchar(150) NOT NULL,
  `created_on` varchar(50) NOT NULL,
  `updated_on` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `name`, `email`, `password`, `status`, `last_login`, `role`, `verified_code`, `created_on`, `updated_on`) VALUES
(1, 'Admin', 'admin@gmail.com', '123456', 1, '2021-11-05 23:00:56', 0, '', '1525257831', '1525257831');

-- --------------------------------------------------------

--
-- Table structure for table `booking_product`
--

CREATE TABLE `booking_product` (
  `id` int(11) NOT NULL COMMENT '11',
  `product_id` int(11) NOT NULL COMMENT '11',
  `user_id` int(11) NOT NULL COMMENT '11',
  `address` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `city` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `state` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `pincode` int(11) NOT NULL,
  `doc_dl` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `doc_id` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
  `price_unit` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `payable_amount` double NOT NULL DEFAULT '0',
  `booking_user_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `period` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `start_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `end_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `start_time` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `end_time` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `booking_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '0:pending, 1:confirm, 2:reject'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `booking_product`
--

INSERT INTO `booking_product` (`id`, `product_id`, `user_id`, `address`, `city`, `state`, `pincode`, `doc_dl`, `doc_id`, `price_unit`, `payable_amount`, `booking_user_name`, `period`, `start_date`, `end_date`, `start_time`, `end_time`, `booking_date`, `status`) VALUES
(1, 1, 45, 'Laxman', 'Indore', 'MP', 455001, '', '', 'Hour', 2280, 'Neel', '0', '2021-10-21 06:00:00', '2021-10-22 06:00:00', '1:28 PM', '2:28 PM', '2021-10-20 08:00:56', 1),
(2, 1, 45, '28', 'Indore', 'MP', 455001, '', '', 'Hour', 15960, 'Neel', '0', '2021-10-23 06:00:00', '2021-10-30 06:00:00', '5:29 PM', '5:29 PM', '2021-10-20 06:00:00', 0);

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `id` int(11) NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 NOT NULL,
  `category_image` text CHARACTER SET utf8 NOT NULL,
  `category_icon` varchar(255) CHARACTER SET utf8 NOT NULL,
  `category_color` varchar(255) CHARACTER SET utf8 DEFAULT '#00aabb',
  `status` binary(1) NOT NULL DEFAULT '1' COMMENT '1:active,0:inactive',
  `deleted` binary(1) NOT NULL DEFAULT '0' COMMENT '0: deleted',
  `created_at` int(20) NOT NULL,
  `updated_at` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id`, `name`, `category_image`, `category_icon`, `category_color`, `status`, `deleted`, `created_at`, `updated_at`) VALUES
(6, 'Automobiles', '[{\"image\":\"https:\\/\\/api.applatus.com\\/rah\\/api\\/uploads\\/category\\/1627907317.jpg\"},{\"image\":\"https:\\/\\/api.applatus.com\\/rah\\/api\\/uploads\\/category\\/16279073171.jpg\"},{\"image\":\"https:\\/\\/api.applatus.com\\/rah\\/api\\/uploads\\/category\\/16279073172.jpg\"}]', 'https://api.applatus.com/rah/api/uploads/category/6107cf8e5ef84front-view-yellow-car-icon-in-flat-design-vector-16737535.jpg', '#18d190', 0x31, 0x30, 1594101355, 1627907326),
(7, 'Electronics', '[{\"image\":\"https:\\/\\/api.applatus.com\\/rah\\/api\\/uploads\\/category\\/1627907355.jpg\"},{\"image\":\"https:\\/\\/api.applatus.com\\/rah\\/api\\/uploads\\/category\\/16279073551.jpg\"},{\"image\":\"https:\\/\\/api.applatus.com\\/rah\\/api\\/uploads\\/category\\/16279073552.jpg\"}]', 'https://api.applatus.com/rah/api/uploads/category/6107d0d91b1e9set-technology-devices-icon-vector-12390685.jpg', '#18d190', 0x31, 0x30, 1594101443, 1627907357),
(8, 'Real Estate', '[{\"image\":\"https:\\/\\/api.applatus.com\\/rah\\/api\\/uploads\\/category\\/1627907372.jpg\"},{\"image\":\"https:\\/\\/api.applatus.com\\/rah\\/api\\/uploads\\/category\\/16279073721.jpg\"},{\"image\":\"https:\\/\\/api.applatus.com\\/rah\\/api\\/uploads\\/category\\/16279073722.jpg\"}]', 'https://api.applatus.com/rah/api/uploads/category/6107cef284e21houses-real-estate-logo-vector-1515888.jpg', '#fb6c2e', 0x31, 0x30, 1594101491, 1627907375),
(9, 'Sofa', '[{\"image\":\"https:\\/\\/api.applatus.com\\/rah\\/api\\/uploads\\/category\\/1627907405.jpg\"},{\"image\":\"https:\\/\\/api.applatus.com\\/rah\\/api\\/uploads\\/category\\/16279074051.jpg\"},{\"image\":\"https:\\/\\/api.applatus.com\\/rah\\/api\\/uploads\\/category\\/16279074052.jpg\"}]', 'https://api.applatus.com/rah/api/uploads/category/61825ac405c89tm3 red.PNG', NULL, 0x31, 0x30, 1594101562, 1635932905),
(10, 'Handyman', '[{\"image\":\"https:\\/\\/api.applatus.com\\/rah\\/api\\/uploads\\/category\\/1627907425.jpg\"},{\"image\":\"https:\\/\\/api.applatus.com\\/rah\\/api\\/uploads\\/category\\/16279074251.jpg\"},{\"image\":\"https:\\/\\/api.applatus.com\\/rah\\/api\\/uploads\\/category\\/16279074252.jpg\"}]', 'https://api.applatus.com/rah/api/uploads/category/6107d3264da3ecartoon-icon-handyman-vector-26526629.jpg', '#f8ac52', 0x31, 0x30, 1594101591, 1627907427);

-- --------------------------------------------------------

--
-- Table structure for table `chat`
--

CREATE TABLE `chat` (
  `id` int(11) NOT NULL,
  `thread_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `user_id_receiver` int(11) NOT NULL,
  `message` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `sender_name` varchar(50) CHARACTER SET utf8mb4 NOT NULL,
  `date` varchar(50) NOT NULL,
  `media` text NOT NULL,
  `chat_type` varchar(50) NOT NULL DEFAULT '1' COMMENT '1. Text 2. Image',
  `chat_state` varchar(5) NOT NULL DEFAULT '0' COMMENT '0 sent , 1 delivered, 2 read'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `chat`
--

INSERT INTO `chat` (`id`, `thread_id`, `user_id`, `user_id_receiver`, `message`, `sender_name`, `date`, `media`, `chat_type`, `chat_state`) VALUES
(1, 2, 26, 1, 'ff', 'Rae', '1632609206', '', '2', '0'),
(2, 4, 31, 1, 'hi', '', '1632751729', '', '2', '0'),
(3, 4, 31, 1, 'hlo', '', '1632751737', '', '2', '0'),
(4, 4, 31, 1, 'How are u', '', '1632751747', '', '2', '0'),
(5, 6, 37, 1, 'hi', 'Arslan Farooq Arslan Farooq', '1632857707', '', '2', '0'),
(6, 8, 43, 1, 'hi', 'Sadiq Rahman Sadiq Rahman', '1633013062', '', '2', '0'),
(7, 11, 52, 1, 'hii', '', '1633456995', '', '2', '0'),
(8, 12, 60, 1, 'halo', 'Tol', '1633804186', '', '2', '0'),
(9, 16, 69, 1, 'vjvivvcc', 'Chu Hai Chu Hai', '1634370778', '', '2', '0'),
(10, 17, 73, 1, 'hi', 'tejpalsing', '1634445770', '', '2', '0'),
(11, 22, 83, 45, 'hi', 'odince Goodwill odince Goodwill', '1634924787', '', '2', '0'),
(12, 23, 74, 1, 'hi', 'Bernard Kioko Bernard Kioko', '1635090278', '', '2', '0'),
(13, 24, 89, 1, 'hi', 'esiribiz esiribiz', '1635231690', '', '2', '0'),
(14, 25, 105, 45, 'this is a test message', '', '1635460533', '', '2', '0'),
(15, 30, 45, 68, 'hi', 'Nilesh', '1635846628', '', '2', '0');

-- --------------------------------------------------------

--
-- Table structure for table `chat_thread`
--

CREATE TABLE `chat_thread` (
  `id` int(11) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `receiver_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `chat_thread`
--

INSERT INTO `chat_thread` (`id`, `sender_id`, `receiver_id`, `created_at`) VALUES
(1, 25, 1, '2021-09-25 12:49:37'),
(2, 26, 1, '2021-09-26 05:33:23'),
(3, 30, 1, '2021-09-27 08:58:53'),
(4, 31, 1, '2021-09-27 09:08:45'),
(5, 36, 1, '2021-09-29 02:31:13'),
(6, 37, 1, '2021-09-29 02:35:02'),
(7, 39, 1, '2021-09-29 02:20:55'),
(8, 43, 1, '2021-09-30 09:44:12'),
(9, 48, 1, '2021-10-02 11:10:32'),
(10, 33, 1, '2021-10-04 07:49:56'),
(11, 52, 1, '2021-10-06 01:03:09'),
(12, 60, 1, '2021-10-10 01:29:36'),
(13, 61, 1, '2021-10-11 01:56:48'),
(14, 62, 1, '2021-10-11 03:14:31'),
(15, 63, 1, '2021-10-11 03:42:36'),
(16, 69, 1, '2021-10-16 02:52:51'),
(17, 73, 1, '2021-10-17 11:42:34'),
(18, 74, 68, '2021-10-17 03:06:06'),
(19, 77, 1, '2021-10-19 01:17:17'),
(20, 77, 68, '2021-10-19 01:17:37'),
(21, 76, 1, '2021-10-20 09:00:09'),
(22, 83, 45, '2021-10-23 12:46:20'),
(23, 74, 1, '2021-10-24 10:44:35'),
(24, 89, 1, '2021-10-26 02:01:12'),
(25, 105, 45, '2021-10-29 05:35:19'),
(26, 105, 1, '2021-10-29 06:50:26'),
(27, 106, 1, '2021-10-29 07:42:56'),
(28, 110, 45, '2021-10-29 10:52:55'),
(29, 113, 68, '2021-11-01 02:36:22'),
(30, 45, 68, '2021-11-02 04:50:23'),
(31, 90, 1, '2021-11-03 04:32:05'),
(32, 123, 45, '2021-11-04 05:40:37');

-- --------------------------------------------------------

--
-- Table structure for table `city`
--

CREATE TABLE `city` (
  `id` int(11) NOT NULL,
  `city_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` int(20) NOT NULL DEFAULT '0' COMMENT '0',
  `updated_at` int(20) NOT NULL DEFAULT '0' COMMENT '0',
  `status` int(11) NOT NULL COMMENT '1',
  `deleted` int(11) NOT NULL COMMENT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `city`
--

INSERT INTO `city` (`id`, `city_name`, `created_at`, `updated_at`, `status`, `deleted`) VALUES
(1, 'karimnagar', 1593542438, 1624851885, 1, 0),
(2, 'Indore', 1594722877, 1594722877, 1, 0),
(3, 'bhopal', 1594932712, 1594932712, 1, 0),
(4, 'Mumbai', 1595483113, 1595483113, 0, 0),
(5, '97ui', 1596011265, 1624252931, 0, 0),
(6, 'mike6', 1598435919, 1609781730, 0, 0),
(7, 'Hargeisa ', 1598551791, 1598551791, 1, 0),
(8, 'Burco', 1599468191, 1599468191, 1, 0),
(9, 'borama', 1599468204, 1599468204, 1, 0),
(10, 'barbara', 1599468213, 1599468213, 0, 0),
(11, 'wajaale', 1599468234, 1599468234, 1, 0),
(12, 'JIIQLE', 1599668960, 1599669004, 1, 0),
(13, 'Cascavel', 1601174664, 1601174664, 1, 0),
(14, 'Cape Town', 1603447410, 1603447410, 1, 0),
(15, 'Bandel', 1607025532, 1607025532, 1, 0),
(16, 'Kolkata', 1607025542, 1607025542, 0, 0),
(17, 'Santorini ', 1607896938, 1607896938, 1, 0),
(18, 'mombasa', 1609930864, 1609930864, 1, 0),
(19, 'EGYPT', 1610743350, 1610743350, 1, 0),
(20, 'Mau', 1611384937, 1611384965, 1, 0),
(21, 'River3', 1611605599, 1611605599, 0, 0),
(22, 'Accra', 1611777212, 1611777212, 0, 0),
(23, 'Douala', 1612654250, 1612654250, 1, 0),
(24, 'Cairo', 1615055788, 1615055788, 1, 0),
(25, 'New York', 1615481738, 1615481738, 1, 0),
(26, 'Nairobi', 1616253268, 1616253268, 1, 0),
(28, 'Deoria, Uttar Pradesh', 1621878617, 1621878617, 1, 0),
(27, 'Zürich', 1621179538, 1621179538, 1, 0),
(29, 'Zürich', 1621956474, 1621956474, 0, 0),
(30, 'Manila', 1621956494, 1621956494, 1, 0),
(31, 'ahmedabad', 1622459014, 1622459014, 1, 0),
(32, 'krishnagiri', 1624941407, 1624941407, 1, 0),
(33, 'santo doingo', 1626074533, 1626074533, 1, 0),
(34, 'BANGALORE', 1627038590, 1627038590, 1, 0),
(35, 'Dubai', 1627301249, 1627301249, 1, 0),
(36, 'ratangarh', 1635908469, 1635908666, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `featured_product`
--

CREATE TABLE `featured_product` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `subscription_id` int(11) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '1,active 0,inactive',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `history`
--

CREATE TABLE `history` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `start_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `end_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `start_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `end_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '1,active 2,deactive',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `end_timestamp` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'CURRENT_TIMESTAMP'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `like_product`
--

CREATE TABLE `like_product` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL DEFAULT '0',
  `title` varchar(250) NOT NULL,
  `type` varchar(250) NOT NULL DEFAULT 'Individual',
  `msg` text CHARACTER SET utf8 NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `user_id`, `title`, `type`, `msg`, `created_at`) VALUES
(1, 1, 'product status change', 'Nofification', 'Your Product is Published now', '2021-09-09 07:25:55'),
(2, 1, 'product status change', 'Nofification', 'Your Product is Published now', '2021-09-14 09:36:34'),
(3, 60, 'user complaint', 'Nofification', 'Thanks. You have registered a Complaint Successfully', '2021-10-10 01:47:35'),
(4, 68, 'product status change', 'Nofification', 'Your Product is Published now', '2021-10-15 08:32:25'),
(5, 121, 'product status change', 'Nofification', 'Your Product is Published now', '2021-11-03 04:09:06');

-- --------------------------------------------------------

--
-- Table structure for table `pay_subscription_log`
--

CREATE TABLE `pay_subscription_log` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `package_id` int(11) NOT NULL,
  `amount` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `currency` varchar(155) COLLATE utf8_unicode_ci NOT NULL,
  `client_secret` text COLLATE utf8_unicode_ci NOT NULL,
  `payment_method` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `note` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `pay_subscription_log`
--

INSERT INTO `pay_subscription_log` (`id`, `user_id`, `package_id`, `amount`, `currency`, `client_secret`, `payment_method`, `note`, `created_at`) VALUES
(1, 89, 10, '200', 'usd', 'pi_3JojkaJcjbNSgRrv1KkRxsWb_secret_Lb8CrSaQZJIaPO4AzyahmTXkW', '', 'For product 2021-10-26 10:07:09.947130', '0000-00-00 00:00:00'),
(2, 92, 9, '3500', 'usd', 'pi_3JpHlbJcjbNSgRrv1u03zOKj_secret_W4fTqBT1QlA8af7lvaJYP7tzH', '', '', '0000-00-00 00:00:00'),
(3, 90, 1, '1500', 'usd', 'pi_3Jrfw6JcjbNSgRrv0FrG1ekb_secret_cyx4DDxGGflTCPQ8pnRYOyLwi', '', 'For product 2021-11-03 10:39:12.716958', '0000-00-00 00:00:00'),
(4, 90, 1, '1500', 'usd', 'pi_3JrfwMJcjbNSgRrv0uGRaN8R_secret_lJWtApNEAi6RVQuLvrxRQ7mOu', '', 'For product 2021-11-03 10:39:28.382276', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `product_id` varchar(155) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `details` varchar(1024) COLLATE utf8_unicode_ci DEFAULT NULL,
  `category_id` int(11) NOT NULL,
  `sub_category_id` int(11) NOT NULL,
  `category_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sub_category_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_featured` int(11) DEFAULT '0' COMMENT '1 means featured',
  `featured_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` int(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  `is_delete` int(11) NOT NULL DEFAULT '0',
  `is_approved` int(11) NOT NULL DEFAULT '0' COMMENT '0:not approved, 1:approved',
  `lat` double NOT NULL,
  `lng` double NOT NULL,
  `city_id` int(11) NOT NULL,
  `city_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `address` text COLLATE utf8_unicode_ci NOT NULL,
  `price` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `product_id`, `name`, `details`, `category_id`, `sub_category_id`, `category_name`, `sub_category_name`, `is_featured`, `featured_at`, `created_at`, `updated_at`, `user_id`, `status`, `is_delete`, `is_approved`, `lat`, `lng`, `city_id`, `city_name`, `address`, `price`) VALUES
(1, 'R25995', 'Harrier', '{\"address\":\"Laxman Nagar\",\"category\":\"Automobiles\",\"city\":\"Indore\",\"description\":\"Lovely Ride\",\"document\":\"[]\",\"fileds\":[{\"key\":\"Mileage\",\"value\":\"10 miles/litre\"},{\"key\":\"Fuel Variant\",\"value\":\"Petrol\"},{\"key\":\"Seats\",\"value\":\"4\"},{\"key\":\"Baggage\",\"value\":\"Yes\"},{\"key\":\"Engine\",\"value\":\"1200 cc\"},{\"key\":\"Gear Type\",\"value\":\"Automatic\"}],\"images\":\"[https://api.applatus.com/rah/apinew/api/uploads/457289-1631633707.png]\",\"min_booking_amount\":\"95\",\"mobile_no\":\"+919827433134\",\"name\":\"Nilesh\",\"price\":\"95\",\"price_unit\":\"Hour\",\"product_name\":\"Harrier\",\"subcategory\":\"Car\",\"lat\":\"22.9620208\",\"lng\":\"76.0419106\",\"city_id\":\"2\"}', 6, 3, 'Automobiles', 'Car', 0, '2021-09-14 09:36:14', '2021-09-14 09:36:14', 0, 1, 1, 0, 1, 22.9620208, 76.0419106, 2, 'Indore', 'Laxman Nagar', 95),
(2, 'R93295', 'Monty Test Car', '{\"address\":\"indore\",\"category\":\"Automobiles\",\"city\":\"Dubai\",\"description\":\"hshshsbs\",\"document\":\"[]\",\"fileds\":[{\"key\":\"Mileage\",\"value\":\"12\"},{\"key\":\"Fuel Variant\",\"value\":\"12\"},{\"key\":\"Seats\",\"value\":\"56\"},{\"key\":\"Baggage\",\"value\":\"hsh\"},{\"key\":\"Engine\",\"value\":\"636\"},{\"key\":\"Gear Type\",\"value\":\"nula\"}],\"images\":\"[https://api.applatus.com/rah/apinew/api/uploads/195470-1634308269.png]\",\"min_booking_amount\":\"5454\",\"mobile_no\":\"+919977337676\",\"name\":\"Monty\",\"price\":\"12133\",\"price_unit\":\"Hour\",\"product_name\":\"Monty Test Car\",\"subcategory\":\"Car\",\"lat\":\"22.7436822\",\"lng\":\"75.8725054\",\"city_id\":\"35\"}', 6, 3, 'Automobiles', 'Car', 0, '2021-10-15 08:32:02', '2021-10-15 08:32:02', 0, 68, 1, 0, 1, 22.7436822, 75.8725054, 35, 'Dubai', 'indore', 12133),
(3, 'R56568', 'Row House', '{\"address\":\"Laxman Nagar\",\"category\":\"Real Estate\",\"city\":\"Dubai\",\"description\":\"Excellent luxury House\",\"document\":\"[]\",\"fileds\":[{\"key\":\"Floor\",\"value\":\"2\"},{\"key\":\"Furnishing\",\"value\":\"Semi Furnished\"},{\"key\":\"Area\",\"value\":\"1500 Sq. Ft.\"},{\"key\":\"BHK\",\"value\":\"2 BHK\"},{\"key\":\"Bathroom\",\"value\":\"2\"},{\"key\":\"Tenants Preferred\",\"value\":\"Family\"},{\"key\":\"Balcony\",\"value\":\"2\"},{\"key\":\"Location\",\"value\":\"Indore\"},{\"key\":\"Overlooking\",\"value\":\"NA\"},{\"key\":\"Parking\",\"value\":\"Yes\"},{\"key\":\"Facing\",\"value\":\"East\"}],\"images\":\"[https://api.applatus.com/rah/api/api/uploads/105258-1634715865.png]\",\"min_booking_amount\":\"500\",\"mobile_no\":\"+919826801615\",\"name\":\"Nilesh\",\"price\":\"1500\",\"price_unit\":\"Month\",\"product_name\":\"Row House\",\"subcategory\":\"Apartment\",\"lat\":\"22.9616824\",\"lng\":\"76.04970650000001\",\"city_id\":\"35\"}', 8, 12, 'Real Estate', 'Apartment', 0, '2021-10-20 01:46:49', '2021-10-20 01:46:49', 0, 45, 1, 0, 1, 22.9616824, 76.04970650000001, 35, 'Dubai', 'Laxman Nagar', 1500),
(4, 'R16622', 'sofix', '{\"address\":\"sikorskiego\",\"category\":\"Sofa\",\"city\":\"Dubai\",\"description\":\"Standardowa\",\"document\":\"[]\",\"fileds\":[{\"key\":\"Sitting Capacity\",\"value\":\"3\"},{\"key\":\"Sofa Type\",\"value\":\"\"},{\"key\":\"Material\",\"value\":\"\"},{\"key\":\"Style\",\"value\":\"\"},{\"key\":\"Shape\",\"value\":\"\"},{\"key\":\"Filling Material\",\"value\":\"\"},{\"key\":\"Upholstery Material\",\"value\":\"\"},{\"key\":\"Color\",\"value\":\"\"},{\"key\":\"Width\",\"value\":\"\"},{\"key\":\"Height\",\"value\":\"\"},{\"key\":\"Depth\",\"value\":\"\"},{\"key\":\"Weight\",\"value\":\"\"},{\"key\":\"Seat Height\",\"value\":\"\"}],\"images\":\"[https://api.applatus.com/rah/api/api/uploads/399881-1635932664.png, https://api.applatus.com/rah/api/api/uploads/890660-1635934020.png]\",\"min_booking_amount\":\"500\",\"mobile_no\":\"+91604961536\",\"name\":\"NA\",\"price\":\"500\",\"price_unit\":\"Month\",\"product_name\":\"sofix\",\"subcategory\":\"Sofa\",\"lat\":\"52.2296756\",\"lng\":\"21.01222870000001\",\"city_id\":\"35\"}', 9, 15, 'Furniture', 'Sofa', 0, '2021-11-03 03:44:37', '2021-11-03 03:44:37', 1635934111, 121, 1, 0, 1, 52.2296756, 21.01222870000001, 35, 'Dubai', 'sikorskiego', 500);

-- --------------------------------------------------------

--
-- Table structure for table `rent`
--

CREATE TABLE `rent` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `description` text NOT NULL,
  `image` text NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '1=active ,0=deactive',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `rent_hire_history`
--

CREATE TABLE `rent_hire_history` (
  `id` int(11) NOT NULL,
  `order_id` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `product_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `request_review`
--

CREATE TABLE `request_review` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `receiver_user_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1',
  `deleted` int(11) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `review`
--

CREATE TABLE `review` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `star` int(11) NOT NULL,
  `comment` varchar(255) CHARACTER SET utf8 NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `setting`
--

CREATE TABLE `setting` (
  `id` int(11) NOT NULL,
  `firebase_api_key` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `stripe_api_key` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `sendgrid_key` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `sendgrid_email` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `setting`
--

INSERT INTO `setting` (`id`, `firebase_api_key`, `stripe_api_key`, `sendgrid_key`, `sendgrid_email`, `created_at`, `updated_at`) VALUES
(1, '******', '******', 'SG.xxxx23232323323232', 'test@gmail.com', '2021-04-26 20:05:07', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `slider_image`
--

CREATE TABLE `slider_image` (
  `id` int(11) NOT NULL,
  `image` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subscription`
--

CREATE TABLE `subscription` (
  `id` int(11) NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `price` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `start_date` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `end_date` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(155) COLLATE utf8_unicode_ci NOT NULL,
  `period` int(11) NOT NULL,
  `no_of_products` int(11) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '1,active 0,inactive',
  `currency_type` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `deleted` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `subscription`
--

INSERT INTO `subscription` (`id`, `title`, `description`, `price`, `start_date`, `end_date`, `type`, `period`, `no_of_products`, `status`, `currency_type`, `created_at`, `updated_at`, `deleted`) VALUES
(1, 'Basic Plan', '', '15', '', '', 'normal', 1, 0, 1, 'usd', '2021-07-05 03:31:42', '2021-07-05 03:31:42', 0),
(2, 'basic', '', '0.00', '', '', 'feature', 1, 4, 1, 'usd', '2021-07-05 03:59:21', '0000-00-00 00:00:00', 0),
(3, 'Free', '', '0', '', '', 'normal', 1, 0, 1, 'INR', '2021-06-04 12:12:04', '0000-00-00 00:00:00', 0),
(4, 'free', '', '0', '', '', 'normal', 6, 0, 1, 'usd', '2021-03-11 11:25:06', '0000-00-00 00:00:00', 0),
(5, 'Week', '', '5', '', '', 'feature', 1, 0, 1, 'usd', '2021-03-06 12:39:08', '0000-00-00 00:00:00', 0),
(6, 'month', '', '20', '', '', 'feature', 3, 0, 1, 'usd', '2021-03-06 12:39:30', '0000-00-00 00:00:00', 0),
(8, '3 months', '', '50', '', '', 'feature', 4, 0, 1, 'usd', '2021-03-06 12:39:51', '0000-00-00 00:00:00', 0),
(9, 'Y-APP', '', '35', '', '', 'normal', 3, 0, 1, 'usd', '2021-03-21 13:34:10', '0000-00-00 00:00:00', 0),
(10, '1 week', '', '2', '', '', 'normal', 1, 0, 1, 'usd', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0),
(11, '6 months', '', '100', '', '', 'feature', 5, 0, 1, 'usd', '2021-03-06 12:40:11', '0000-00-00 00:00:00', 0),
(12, 'year', '', '12', '', '', 'feature', 6, 0, 1, 'usd', '2021-03-06 12:40:25', '0000-00-00 00:00:00', 0),
(13, 'Bulanan', '', '500', '', '', 'normal', 3, 0, 1, 'usd', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0),
(14, 'Best Plan', '', '0', '', '', 'feature', 6, 0, 1, 'INR', '2021-10-26 05:39:00', '0000-00-00 00:00:00', 0),
(15, 'Week Unlimited', '', '0', '', '', 'normal', 1, 0, 1, 'usd', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0),
(17, 'Test sub', '', '12', '', '', 'normal', 1, 3, 1, 'usd', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0);

-- --------------------------------------------------------

--
-- Table structure for table `subscription_period`
--

CREATE TABLE `subscription_period` (
  `id` int(11) NOT NULL,
  `period_title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1',
  `deleted` int(11) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `subscription_period`
--

INSERT INTO `subscription_period` (`id`, `period_title`, `status`, `deleted`) VALUES
(1, 'Week', 1, 0),
(2, 'Fortnight', 1, 0),
(3, 'Month', 1, 0),
(4, '3 Months', 1, 0),
(5, '6 Months', 1, 0),
(6, '1 Year', 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `sub_category`
--

CREATE TABLE `sub_category` (
  `id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sub_cat_icon` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sub_cat_image` text COLLATE utf8_unicode_ci,
  `form_field` text COLLATE utf8_unicode_ci,
  `verification_required` int(11) DEFAULT '0',
  `status` int(11) DEFAULT '1',
  `created_at` int(20) NOT NULL,
  `updated_at` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `sub_category`
--

INSERT INTO `sub_category` (`id`, `category_id`, `name`, `sub_cat_icon`, `sub_cat_image`, `form_field`, `verification_required`, `status`, `created_at`, `updated_at`) VALUES
(3, 6, 'Car', 'https://api.applatus.com/rah/api/uploads/subcategory/6107d6511f4f8113-1133694_free-lamborghini-gallardo-vector-psd-lamborghini-gallardo-vector.png', '', '[{\"lable\":\"Mileage\"},{\"lable\":\"Fuel Variant\"},{\"lable\":\"Seats\"},{\"lable\":\"Baggage\"},{\"lable\":\"Engine\"},{\"lable\":\"Gear Type\"}]', 0, 1, 1594102048, 1627905069),
(4, 6, 'Bike', 'https://api.applatus.com/rah/api/uploads/subcategory/6107d6f02b964scrambler-1.jpg', '', '[{\"lable\":\"Mileage\"},{\"lable\":\"Fuel Variant\"},{\"lable\":\"Seats\"},{\"lable\":\"Engine\"},{\"lable\":\"Gear\"}]', 0, 1, 1594102313, 1627905146),
(5, 6, 'Bus', 'https://api.applatus.com/rah/api/uploads/subcategory/6107d72c11021bus.png', '', '[{\"lable\":\"Mileage\"},{\"lable\":\"Fuel Variant\"},{\"lable\":\"Seats\"},{\"lable\":\"Luggage\"},{\"lable\":\"Engine\"},{\"lable\":\"Gear Type\"}]', 0, 1, 1594102500, 1627905204),
(6, 6, 'Truck', 'https://api.applatus.com/rah/api/uploads/subcategory/6107d80d10f47vector-truck-icon.jpg', '', '[{\"lable\":\"Mileage\"},{\"lable\":\"Fuel Variant\"},{\"lable\":\"Goods Capacity\"},{\"lable\":\"Engine\"},{\"lable\":\"Gear Type\"}]', 0, 1, 1594102632, 1627905326),
(7, 7, 'Laptop', 'https://api.applatus.com/rah/api/uploads/subcategory/6107db2590a08laptop.png', '', '[{\"lable\":\"Processor Brand\"},{\"lable\":\"Processor Name\"},{\"lable\":\"Generation\"},{\"lable\":\"RAM\"},{\"lable\":\"RAM Type\"},{\"lable\":\"Storage HDD\"},{\"lable\":\"Power Backup\"},{\"lable\":\"Operating System\"},{\"lable\":\"Touchscreen \"},{\"lable\":\"Screen Size\"},{\"lable\":\"Screen Resolution\"},{\"lable\":\"Screen Type\"},{\"lable\":\"Web Camera\"}]', 0, 1, 1594102907, 1627905402),
(8, 7, 'Desktop', 'https://api.applatus.com/rah/api/uploads/subcategory/6107dbe62b320download.png', '', '[{\"lable\":\"Processor Brand\"},{\"lable\":\"Processor Name\"},{\"lable\":\"Generation\"},{\"lable\":\"RAM\"},{\"lable\":\"RAM Type\"},{\"lable\":\"Storage HDD\"},{\"lable\":\"Mouse\"},{\"lable\":\"Keypboard\"},{\"lable\":\"Touchscreen Support\"},{\"lable\":\"Display Size\"},{\"lable\":\"Display Resolution\"},{\"lable\":\"Display Type\"},{\"lable\":\"Web Camera\"}]', 0, 1, 1594103053, 1627905478),
(9, 7, 'Television', 'https://api.applatus.com/rah/apinew/uploads/subcategory/613cbd81bc103telev.jpg', '', '[{\"lable\":\"Model\"},{\"lable\":\"Display Size\"},{\"lable\":\"Display Type\"},{\"lable\":\"HD Technology\"},{\"lable\":\"3D\"},{\"lable\":\"Smart TV\"},{\"lable\":\"Curve TV\"},{\"lable\":\"Touch Screen\"},{\"lable\":\"Built in Wifi\"},{\"lable\":\"HDMI\"},{\"lable\":\"USB\"},{\"lable\":\"Supported Apps\"},{\"lable\":\"Operating System\"},{\"lable\":\"Screen Mirroring\"},{\"lable\":\"Bluetooth\"},{\"lable\":\"Speakers\"},{\"lable\":\"Speaker Output RMS\"},{\"lable\":\"test\"}]', 0, 1, 1594103228, 1631370628),
(10, 7, 'Speakers', 'https://api.applatus.com/rah/api/uploads/subcategory/6107df1862aacimages.png', '[{\"image\":\"https:\\/\\/api.applatus.com\\/rah\\/api\\/uploads\\/subcategory\\/1594103274.jpg\"},{\"image\":\"https:\\/\\/api.applatus.com\\/rah\\/api\\/uploads\\/subcategory\\/15941032741.jpg\"}]', '[{\"lable\":\"Model\"},{\"lable\":\"Type\"},{\"lable\":\"Portable\"},{\"lable\":\"Bluetooth\"},{\"lable\":\"Wired\\/Wireless\"},{\"lable\":\"Headphone Jack\"},{\"lable\":\"Configuration\"},{\"lable\":\"Compatible Devices\"},{\"lable\":\"Audio Features\"},{\"lable\":\"Other Details\"},{\"lable\":\"Satellite Dimensions\"},{\"lable\":\"Sub Woofer Dimensions\"}]', 0, 1, 1594103374, 1627905819),
(11, 8, 'Flat', 'https://api.applatus.com/rah/api/uploads/subcategory/6107d86bba45areal_estate_preview_846a.png', '[{\"image\":\"https:\\/\\/api.applatus.com\\/rah\\/api\\/uploads\\/subcategory\\/1594103501.jpg\"},{\"image\":\"https:\\/\\/api.applatus.com\\/rah\\/api\\/uploads\\/subcategory\\/15941035011.jpg\"},{\"image\":\"https:\\/\\/api.applatus.com\\/rah\\/api\\/uploads\\/subcategory\\/15941035012.jpg\"}]', '[{\"lable\":\"Floor\"},{\"lable\":\"Area\"},{\"lable\":\"Bedroom\"},{\"lable\":\"Bathroom\"},{\"lable\":\"Tenants Preferred\"},{\"lable\":\"Balcony\"},{\"lable\":\"Location\"},{\"lable\":\"Overlooking\"},{\"lable\":\"Parking\"},{\"lable\":\"Facing\"},{\"lable\":\"new\"}]', 0, 1, 1594103603, 1627904119),
(12, 8, 'Apartment', 'https://api.applatus.com/rah/api/uploads/subcategory/6107d8cf97754icon-apartment-vector-1389226.jpg', '[{\"image\":\"https:\\/\\/api.applatus.com\\/rah\\/api\\/uploads\\/subcategory\\/1594103501.jpg\"},{\"image\":\"https:\\/\\/api.applatus.com\\/rah\\/api\\/uploads\\/subcategory\\/15941035011.jpg\"},{\"image\":\"https:\\/\\/api.applatus.com\\/rah\\/api\\/uploads\\/subcategory\\/15941035012.jpg\"}]', '[{\"lable\":\"Floor\"},{\"lable\":\"Furnishing\"},{\"lable\":\"Area\"},{\"lable\":\"BHK\"},{\"lable\":\"Bathroom\"},{\"lable\":\"Tenants Preferred\"},{\"lable\":\"Balcony\"},{\"lable\":\"Location\"},{\"lable\":\"Overlooking\"},{\"lable\":\"Parking\"},{\"lable\":\"Facing\"}]', 0, 1, 0, 1627904210),
(13, 8, 'PG Homes', 'https://api.applatus.com/rah/api/uploads/subcategory/6107d9d9df434green-house-icon-transparent-png-images-.png', '[{\"image\":\"https:\\/\\/api.applatus.com\\/rah\\/api\\/uploads\\/subcategory\\/1594103848.jpg\"},{\"image\":\"https:\\/\\/api.applatus.com\\/rah\\/api\\/uploads\\/subcategory\\/15941038481.jpg\"},{\"image\":\"https:\\/\\/api.applatus.com\\/rah\\/api\\/uploads\\/subcategory\\/15941038482.jpg\"}]', '[{\"lable\":\"Sharing\"},{\"lable\":\"Area\"},{\"lable\":\"Attached Bathroom\"},{\"lable\":\"Wifi\"},{\"lable\":\"AC\"},{\"lable\":\"Food\"},{\"lable\":\"Power Backup\"},{\"lable\":\"Room Cleaning\"},{\"lable\":\"Attached Washroom\"},{\"lable\":\"Preferred\"},{\"lable\":\"Location\"}]', 0, 1, 1594103950, 1627904477),
(14, 8, 'Office', 'https://api.applatus.com/rah/api/uploads/subcategory/6107da45a3ceaoffice_building_architecture_icon_colored_modern_3d_sketch_6839637.jpg', '[{\"image\":\"https:\\/\\/api.applatus.com\\/rah\\/api\\/uploads\\/subcategory\\/1594111306.jpg\"},{\"image\":\"https:\\/\\/api.applatus.com\\/rah\\/api\\/uploads\\/subcategory\\/15941113061.jpg\"},{\"image\":\"https:\\/\\/api.applatus.com\\/rah\\/api\\/uploads\\/subcategory\\/15941113062.jpg\"}]', '[{\"lable\":\"Carpet Area\"},{\"lable\":\"Floor\"},{\"lable\":\"Furnishing\"},{\"lable\":\"Cabins\"},{\"lable\":\"Sitting Capacity\"},{\"lable\":\"Washroom\"},{\"lable\":\"Location\"},{\"lable\":\"Parking\"},{\"lable\":\"Security\"},{\"lable\":\"Facing\"}]', 0, 1, 1594104158, 1627904584),
(15, 9, 'Sofa', 'https://api.applatus.com/rah/api/uploads/subcategory/6107dfec68cafdribbble.jpg', '[{\"image\":\"https:\\/\\/api.applatus.com\\/rah\\/api\\/uploads\\/subcategory\\/1594104304.jpg\"},{\"image\":\"https:\\/\\/api.applatus.com\\/rah\\/api\\/uploads\\/subcategory\\/15941043041.jpg\"}]', '[{\"lable\":\"Sitting Capacity\"},{\"lable\":\"Sofa Type\"},{\"lable\":\"Material\"},{\"lable\":\"Style\"},{\"lable\":\"Shape\"},{\"lable\":\"Filling Material\"},{\"lable\":\"Upholstery Material\"},{\"lable\":\"Color\"},{\"lable\":\"Width\"},{\"lable\":\"Height\"},{\"lable\":\"Depth\"},{\"lable\":\"Weight\"},{\"lable\":\"Seat Height\"}]', 0, 1, 1594104612, 1627906030),
(16, 9, 'Bed', 'https://api.applatus.com/rah/api/uploads/subcategory/6107e024c4407download1.png', '[{\"image\":\"https:\\/\\/api.applatus.com\\/rah\\/api\\/uploads\\/subcategory\\/1594104662.jpg\"},{\"image\":\"https:\\/\\/api.applatus.com\\/rah\\/api\\/uploads\\/subcategory\\/15941046621.jpg\"}]', '[{\"lable\":\"Bed Type\"},{\"lable\":\"Bed Material\"},{\"lable\":\"Storage\"},{\"lable\":\"Bed Size\"},{\"lable\":\"Dimensions (W*H*D)\"},{\"lable\":\"Recommended Mattress Size\"},{\"lable\":\"Color\"},{\"lable\":\"With\\/Without Mattress\"},{\"lable\":\"Weight\"}]', 0, 1, 1594104887, 1627906087),
(17, 9, 'Table', 'https://api.applatus.com/rah/api/uploads/subcategory/6107e061a2263images1.png', '[{\"image\":\"https:\\/\\/api.applatus.com\\/rah\\/api\\/uploads\\/subcategory\\/1594104927.jpg\"},{\"image\":\"https:\\/\\/api.applatus.com\\/rah\\/api\\/uploads\\/subcategory\\/15941049271.jpg\"}]', '[{\"lable\":\"Table Type\"},{\"lable\":\"Structure Material\"},{\"lable\":\"Table Top Material\"},{\"lable\":\"Color\"},{\"lable\":\"Dimensions (W*H*D)\"},{\"lable\":\"Table Shape\"},{\"lable\":\"Storage\"},{\"lable\":\"Shelves\"},{\"lable\":\"Drawers\"}]', 0, 1, 1594105089, 1627906147),
(18, 9, 'Chairs', 'https://api.applatus.com/rah/api/uploads/subcategory/6107e09948f58download2.png', '[{\"image\":\"https:\\/\\/api.applatus.com\\/rah\\/api\\/uploads\\/subcategory\\/1594105138.jpg\"},{\"image\":\"https:\\/\\/api.applatus.com\\/rah\\/api\\/uploads\\/subcategory\\/15941051381.jpg\"}]', '[{\"lable\":\"Suitable For\"},{\"lable\":\"Style\"},{\"lable\":\"Color\"},{\"lable\":\"Dimensions (W*H)\"},{\"lable\":\"Armest\"},{\"lable\":\"Adjustable\"},{\"lable\":\"Structure Material\"},{\"lable\":\"Upholstery Material\"},{\"lable\":\"Swivel\"},{\"lable\":\"Seat Lock\"},{\"lable\":\"Wheels\"},{\"lable\":\"Head Support\"}]', 0, 1, 1594105348, 1627906204),
(19, 10, 'Maid', 'https://api.applatus.com/rah/api/uploads/subcategory/6107e0ceac22c49-493580_grades-clipart-student-improvement-job-icons-png.png', '[{\"image\":\"https:\\/\\/api.applatus.com\\/rah\\/api\\/uploads\\/subcategory\\/1594111278.jpg\"},{\"image\":\"https:\\/\\/api.applatus.com\\/rah\\/api\\/uploads\\/subcategory\\/15941112781.jpg\"},{\"image\":\"https:\\/\\/api.applatus.com\\/rah\\/api\\/uploads\\/subcategory\\/15941112782.jpg\"}]', '[{\"lable\":\"Skills\"},{\"lable\":\"Experience\"},{\"lable\":\"Any References\"},{\"lable\":\"Reference Contact\"}]', 0, 1, 1594105745, 1627906260),
(20, 10, 'Carpenter', 'https://api.applatus.com/rah/api/uploads/subcategory/6107e104f2423man-carpenter-icon-isometric-style-vector-23916578.jpg', '[{\"image\":\"https:\\/\\/api.applatus.com\\/rah\\/api\\/uploads\\/subcategory\\/1594105812.jpg\"},{\"image\":\"https:\\/\\/api.applatus.com\\/rah\\/api\\/uploads\\/subcategory\\/15941058121.jpg\"}]', '[{\"lable\":\"Skills\"},{\"lable\":\"Experience\"},{\"lable\":\"Any References\"},{\"lable\":\"Reference Contact\"}]', 0, 1, 1594105838, 1627906312),
(21, 10, 'Tattooer', 'https://api.applatus.com/rah/api/uploads/subcategory/6107e13818887210-2101413_tattoo-machine-icon-free-tattoo-icon-hd-png.png', '[{\"image\":\"https:\\/\\/api.applatus.com\\/rah\\/api\\/uploads\\/subcategory\\/1594111257.jpg\"},{\"image\":\"https:\\/\\/api.applatus.com\\/rah\\/api\\/uploads\\/subcategory\\/15941112571.jpg\"},{\"image\":\"https:\\/\\/api.applatus.com\\/rah\\/api\\/uploads\\/subcategory\\/15941112572.jpg\"}]', '[{\"lable\":\"Skills\"},{\"lable\":\"Experience\"},{\"lable\":\"Any References\"},{\"lable\":\"Reference Contact\"}]', 0, 1, 1594105904, 1627906364),
(22, 10, 'Plumber', 'https://api.applatus.com/rah/api/uploads/subcategory/6107e185ac6e2images.jpg', '[{\"image\":\"https:\\/\\/api.applatus.com\\/rah\\/api\\/uploads\\/subcategory\\/http:\\/\\/localhost\\/rental\\/rentors\\/uploads\\/subcategory\\/1594105954.jpg\"},{\"image\":\"https:\\/\\/api.applatus.com\\/rah\\/api\\/uploads\\/subcategory\\/http:\\/\\/localhost\\/rental\\/rentors\\/uploads\\/subcategory\\/15941059541.jpg\"}]', '[{\"lable\":\"Skills\"},{\"lable\":\"Experience\"},{\"lable\":\"Any References\"},{\"lable\":\"Reference Contact\"}]', 0, 1, 1594105988, 1627906448);

-- --------------------------------------------------------

--
-- Table structure for table `sub_cat_form_fields`
--

CREATE TABLE `sub_cat_form_fields` (
  `id` int(11) NOT NULL,
  `sub_cat_id` int(11) NOT NULL,
  `form_field` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `last_login` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `device_token` text,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` int(11) NOT NULL DEFAULT '1',
  `email_verified` int(11) NOT NULL DEFAULT '0' COMMENT 'o : not verified'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `password`, `name`, `last_login`, `device_token`, `created_at`, `updated_at`, `status`, `email_verified`) VALUES
(1, 'applatusacc@gmail.com', NULL, 'Nilesh', '2021-10-20 19:02:11', 'ev0BDlwDQ823DUg3xhzFUq:APA91bFNSk7SP8KHHfxVLIy91xdJ1yaJHUKneb8OtbmONrQAJFgqOKr_YGBQ8oIRiyMcbtsScxw8Uzd4-9a1n1cTsGmD6conADxNPI2-V5aOJpSF5Fcm-kkO0m2yGVw7mRVahoOA86wO,fA-ghrj_Tu6L28-8Lv9Pxd:APA91bFOGp1YDZ5rrZUO7Fl0y18bB2qHLQkRKY_49lihWqGOIQfspghWYldftQktiz80y-lBN4k4iSBKzlWt5xpHFkaaviV4I8vKIpvwV5qvwNNQWEKRbqc_KmhdEYv-ttlcT2qZ6OCN,ev3JP3IpR76EZeBgdUordt:APA91bErUqDdgSi4SNXvktA1-H7gi3__uq3p2kVXha_bxtgIkeUXQOwJAfb-aIhVUa76asIxA5AYAJs7ILwC19-ebyNTy3PdBrUEZKQ8_w895anslEnMK5eXP-Zb2hFyBrkcJqu6_SxA,dPGoR5BFS3ex4vjZ82osb_:APA91bFMoMgz0b7sXzrMFGXOpVcjcaVtZ0W6Togj6fpNMVJg4vQX7WpDwOKLIhy8VKkpOcvG2FDxic5ERd3_0VcH3utNNgHNFbEwyweXiiKzWEFCaZKG_hPsSLpGpDdtLiAX9Fp0ZUTb', '2021-09-11 04:05:07', '2021-10-20 06:02:11', 1, 0),
(2, '', NULL, 'Amit Sharma Amit Sharma', '2021-09-11 04:45:06', NULL, '2021-09-11 04:45:06', '2021-09-11 04:45:06', 1, 0),
(3, '', NULL, 'Amit Sharma Amit Sharma', '2021-09-11 04:45:14', NULL, '2021-09-11 04:45:14', '2021-09-11 04:45:14', 1, 0),
(4, '', NULL, 'Amit Sharma Amit Sharma', '2021-09-11 04:46:55', NULL, '2021-09-11 04:46:55', '2021-09-11 04:46:55', 1, 0),
(5, 'shalineegangrade@gmail.com', '$6$rounds=5042$613cbc10c64d52.2$7HI0zCLOKl5MkUrAuuu.v557TdJCOS1OJ1GuGuf4TLgXtF4rBQPgkV4i6kzPS.r2QAKEjVUHGn.9r..Q5Wzjg.', '', '2021-09-19 18:46:38', 'test12,dLyoF5F5QiiACZHCaI85XA:APA91bEk-QAmHUm4PmXrgKVvX-jWfP8Dwn52DEmCRLWdbRh1iIASjn5oRAIH6z7aUGvE_E59cKgRTDLZrMbQ-aglJVitxHxDceVSjnfCZ89k7Siq1ELtkmU7hgDFUwAPsY8lvclmagVx,eoRiwmmcSICiyq1ms2ctM8:APA91bEIttz5298GU6Y7KctxxMUVzZlHfFIvQ4XPFnVPMI9G6SK-SMzjDqfl1ZJ22Zj8oBpnZ_W5FfO1jYoVRVdGjXqygEVnGCHMvjdTjH21SaJz6NQ7hLZ17j44nbFH42T9XiQczVaJ', '2021-09-11 08:24:16', '2021-09-19 05:46:38', 1, 0),
(6, '', NULL, 'Amit Sharma Amit Sharma', '2021-09-11 08:27:02', NULL, '2021-09-11 08:27:02', '2021-09-11 08:27:02', 1, 0),
(7, '', NULL, 'Amit Sharma Amit Sharma', '2021-09-16 10:51:49', NULL, '2021-09-16 10:51:49', '2021-09-16 10:51:49', 1, 0),
(8, '', NULL, '', '2021-09-16 10:54:49', 'fUuDVZD_TZma53WsdsVCnA:APA91bGjzrf_G17GnmHFLTDFpMa2NMlvHR-SUrrZnRA0eb0pbCQC9JhA8lioJgBCb8SEfd443tuCu7X7xl-G8nmz24YsfQE7hvRovD7Negamhdc784pECp5eUbIik7MTSXhVx7BNuKxq', '2021-09-16 10:54:49', '2021-09-16 10:54:49', 1, 0),
(9, '', NULL, 'Shalinee Gangrade Shalinee Gangrade', '2021-09-19 05:36:01', NULL, '2021-09-19 05:36:01', '2021-09-19 05:36:01', 1, 0),
(10, '', NULL, 'shalinee gangrade shalinee gangrade', '2021-09-19 05:36:13', NULL, '2021-09-19 05:36:13', '2021-09-19 05:36:13', 1, 0),
(11, '', NULL, 'Shalinee Gangrade Shalinee Gangrade', '2021-09-19 05:36:39', NULL, '2021-09-19 05:36:39', '2021-09-19 05:36:39', 1, 0),
(12, '', NULL, 'Shalinee Gangrade Shalinee Gangrade', '2021-09-19 05:40:45', 'fwe8KE8pRpGVaitk62l_o1:APA91bE11MCFhBGH1enoR7q2JD_7-CTUcccvXFKqE9EJGy0IDat-ks0kUOtVECVMRtO6fITofvchVmQ8UVfBQC_bm9J1D2JQVr6-dkUIeRrxzoqrokNbn5c9ZETKefT0HsUNDsrk3Pod', '2021-09-19 05:40:45', '2021-09-19 05:40:45', 1, 0),
(13, '', NULL, 'Shalinee Gangrade Shalinee Gangrade', '2021-09-19 05:47:07', NULL, '2021-09-19 05:47:07', '2021-09-19 05:47:07', 1, 0),
(14, '', NULL, 'Shalinee Gangrade Shalinee Gangrade', '2021-09-19 05:55:46', NULL, '2021-09-19 05:55:46', '2021-09-19 05:55:46', 1, 0),
(15, '', NULL, 'Shalinee Gangrade Shalinee Gangrade', '2021-09-19 05:57:28', NULL, '2021-09-19 05:57:28', '2021-09-19 05:57:28', 1, 0),
(16, '', NULL, 'Shalinee Gangrade Shalinee Gangrade', '2021-09-19 05:59:02', NULL, '2021-09-19 05:59:02', '2021-09-19 05:59:02', 1, 0),
(17, '', NULL, 'Shalinee Gangrade Shalinee Gangrade', '2021-09-19 06:00:00', NULL, '2021-09-19 06:00:00', '2021-09-19 06:00:00', 1, 0),
(18, '', NULL, 'Shalinee Gangrade Shalinee Gangrade', '2021-09-19 06:00:43', NULL, '2021-09-19 06:00:43', '2021-09-19 06:00:43', 1, 0),
(19, '', NULL, 'Shalinee Gangrade Shalinee Gangrade', '2021-09-19 06:00:57', NULL, '2021-09-19 06:00:57', '2021-09-19 06:00:57', 1, 0),
(20, '', NULL, 'Shalinee Gangrade Shalinee Gangrade', '2021-09-19 06:01:33', NULL, '2021-09-19 06:01:33', '2021-09-19 06:01:33', 1, 0),
(21, '', NULL, 'Shalinee Gangrade Shalinee Gangrade', '2021-09-19 19:02:55', NULL, '2021-09-19 06:02:55', '2021-09-19 06:02:55', 1, 0),
(22, '', NULL, '', '2021-09-20 14:27:46', 'fUuDVZD_TZma53WsdsVCnA:APA91bGjzrf_G17GnmHFLTDFpMa2NMlvHR-SUrrZnRA0eb0pbCQC9JhA8lioJgBCb8SEfd443tuCu7X7xl-G8nmz24YsfQE7hvRovD7Negamhdc784pECp5eUbIik7MTSXhVx7BNuKxq', '2021-09-20 01:27:46', '2021-09-20 01:27:46', 1, 0),
(23, '', NULL, 'Amit Sharma Amit Sharma', '2021-11-06 11:36:10', NULL, '2021-09-24 00:46:20', '2021-11-05 22:36:10', 1, 0),
(24, '', NULL, 'Jaime Clegane Jaime Clegane', '2021-09-25 07:02:28', NULL, '2021-09-24 18:02:28', '2021-09-24 18:02:28', 1, 0),
(25, '', NULL, '', '2021-09-25 12:47:59', 'dZfMwSi0RAa_2D_YwhZS4b:APA91bEbzaILOvoYItyXa38MMLEU3mb53LHsNNVt2FPS28VCSI9TtZS0Bab1_ZQGmkO8oat8wTk_8qCZk6-HjaALPqyD-ONbOHKl27bjMMbrtxgiU_TlgfB-WoHfxZuzNrXy2K8jyqDQ', '2021-09-24 23:47:59', '2021-09-24 23:47:59', 1, 0),
(26, 'Raechisholm@gmail.com', NULL, 'Rae', '2021-09-26 05:29:37', 'ejLSxRAeSWGW1ExVpRHH9Q:APA91bEnv3VDdbsx3FfWduCg50ZjDh_BgUs9e0PRlGpldG4RSa0JVHw6dkEDpMXJm7sqTUpdqt1UGhqsZahENQNflUTPwipr-DEcYI1_6mouBUD6wWDOJL9GQr6fh6SESOUJkQhc0iml', '2021-09-25 16:29:37', '2021-09-25 16:31:46', 1, 0),
(27, '', NULL, '', '2021-09-26 06:16:21', 'ejLSxRAeSWGW1ExVpRHH9Q:APA91bEnv3VDdbsx3FfWduCg50ZjDh_BgUs9e0PRlGpldG4RSa0JVHw6dkEDpMXJm7sqTUpdqt1UGhqsZahENQNflUTPwipr-DEcYI1_6mouBUD6wWDOJL9GQr6fh6SESOUJkQhc0iml', '2021-09-25 17:16:21', '2021-09-25 17:16:21', 1, 0),
(28, '', NULL, 'Kalai Carft Kalai Carft', '2021-09-27 00:21:57', NULL, '2021-09-26 11:21:57', '2021-09-26 11:21:57', 1, 0),
(29, 'azamataa@gmail.com', NULL, 'Fr', '2021-09-27 06:45:34', 'fyh0lE7_TxKA8PKU4L9IJf:APA91bFHSQdwF-xtLyE4oicF2LiNrE45U0thD-79soK2xDvxGmdv0utGS51L9P9LKfNaGCooG8UzqxENADEHg97qy0QaeTowm0CcMZAtxxTMYA7QwsjnBTOiGBsbASDH8RaYoOShDJzS', '2021-09-26 17:45:34', '2021-09-26 17:51:00', 1, 0),
(30, '', NULL, 'al amin al amin', '2021-09-27 20:48:16', NULL, '2021-09-27 07:48:16', '2021-09-27 07:48:16', 1, 0),
(31, 'sadiq7171@gmail.com', NULL, 'Sadiq', '2021-09-27 21:07:37', 'dbmY3yAaRgyJ0Bg_La8AMV:APA91bHOiifWv-tNJDKH-Tqzhf_jVep76Iu73-IkItIM9aTXxXAHm67wrgFmw786bjrO4NzGicyBS4lrwoZ4Rcqk4Jcv4ePalwiyZgfHbhkrz7b7d7bDEGbSaEHnBJMhYm2kl8TX4g3a', '2021-09-27 08:07:37', '2021-09-27 09:18:20', 1, 0),
(32, '', NULL, 'Hany Ahmed Hany Ahmed', '2021-09-28 03:01:48', NULL, '2021-09-27 14:01:48', '2021-09-27 14:01:48', 1, 0),
(33, '', NULL, 'Kuo Ching Liew Kuo Ching Liew', '2021-10-12 04:12:57', NULL, '2021-09-27 17:47:58', '2021-10-11 15:12:57', 1, 0),
(34, '', NULL, '', '2021-09-28 12:17:32', 'dbmY3yAaRgyJ0Bg_La8AMV:APA91bHOiifWv-tNJDKH-Tqzhf_jVep76Iu73-IkItIM9aTXxXAHm67wrgFmw786bjrO4NzGicyBS4lrwoZ4Rcqk4Jcv4ePalwiyZgfHbhkrz7b7d7bDEGbSaEHnBJMhYm2kl8TX4g3a', '2021-09-27 23:17:32', '2021-09-27 23:17:32', 1, 0),
(35, '', NULL, 'Karthik k Karthik k', '2021-10-24 15:18:19', NULL, '2021-09-27 23:26:11', '2021-10-24 02:18:19', 1, 0),
(36, 'hussein.iosdeveloper@gmail.com', NULL, 'NA', '2021-09-29 02:29:55', 'd14_pCr4TL6YvAk1-HMc5v:APA91bH0ilJXKIXJFk0DC_DhJgf9JNyRU5dXwaHO5OS9-GL3ljMmYvoglW4GV9Bx0OT6wl_1iNCq8FXfAysHK1eTqGWyel7sbw97WMhy7yR5QSdyGJWsl7iFy3OZaJhsdn54YYRmdHLn', '2021-09-28 13:29:55', '2021-09-28 13:33:11', 1, 0),
(37, '', NULL, 'Arslan Farooq Arslan Farooq', '2021-10-06 01:22:54', NULL, '2021-09-28 13:33:30', '2021-10-05 12:22:54', 1, 0),
(38, 'husseinomda16@yahoo.com', NULL, 'NA', '2021-09-29 02:59:47', 'd14_pCr4TL6YvAk1-HMc5v:APA91bH0ilJXKIXJFk0DC_DhJgf9JNyRU5dXwaHO5OS9-GL3ljMmYvoglW4GV9Bx0OT6wl_1iNCq8FXfAysHK1eTqGWyel7sbw97WMhy7yR5QSdyGJWsl7iFy3OZaJhsdn54YYRmdHLn', '2021-09-28 13:59:47', '2021-09-28 14:00:45', 1, 0),
(39, 'hme@incosys.io', NULL, 'NA', '2021-09-29 14:20:10', 'cwXjZHF-Q7qw26bKNlIBKc:APA91bEPFQiHgJxU-dSapLMkO-5VtG4Vk8fW9Iygy2WfUYZqGyq0mST2ExfPiteoPSrkAMKREQDuZokYgPScCnPxdk-MUl1I8ZI78xjMygqab9uaz8N2KQxmU6cQ1RjwuxkJrfe-llkG', '2021-09-29 01:20:10', '2021-09-29 01:22:42', 1, 0),
(40, '', NULL, '', '2021-09-29 14:32:27', 'csu-2TZ-TV6gER5H3YK0RB:APA91bHKKPCGs5o_kv4caMb71I1XV8NPilOJJsIuLc-0xY7IYTeEXZrl2ltayee2plmLr5QQVHmkqfyiZhvH1boi4xfIrWwvysvsTtEBm1QGQl_3CuBnQKHQeAJnWfc7oRdYNGiQEYbl', '2021-09-29 01:32:27', '2021-09-29 01:32:27', 1, 0),
(41, '', NULL, '', '2021-09-29 21:05:22', 'd14_pCr4TL6YvAk1-HMc5v:APA91bH0ilJXKIXJFk0DC_DhJgf9JNyRU5dXwaHO5OS9-GL3ljMmYvoglW4GV9Bx0OT6wl_1iNCq8FXfAysHK1eTqGWyel7sbw97WMhy7yR5QSdyGJWsl7iFy3OZaJhsdn54YYRmdHLn', '2021-09-29 08:05:22', '2021-09-29 08:05:22', 1, 0),
(42, 'anin.bd@gmail.com', NULL, 'Salah Uddin', '2021-09-30 04:40:27', NULL, '2021-09-29 15:40:27', '2021-09-29 15:44:09', 1, 0),
(43, '', NULL, 'Sadiq Rahman Sadiq Rahman', '2021-09-30 21:41:36', NULL, '2021-09-30 08:41:36', '2021-09-30 08:41:36', 1, 0),
(44, '', NULL, 'Sohel Rana Sohel Rana', '2021-10-01 04:50:03', NULL, '2021-09-30 13:50:47', '2021-09-30 15:50:03', 1, 0),
(45, 'nilaish.sonu@gmail.com', NULL, 'Nilesh', '2021-11-02 16:47:58', NULL, '2021-10-01 10:22:12', '2021-11-02 03:47:58', 1, 0),
(46, '', NULL, 'Factify Factify', '2021-10-02 02:22:30', NULL, '2021-10-01 13:22:30', '2021-10-01 13:22:30', 1, 0),
(47, '', NULL, '', '2021-10-02 15:08:57', 'dpxpaiAcTR2fX-Qt8P42Pm:APA91bHIO2HQdZql2zgArKQPyY-aREorPOXZWWhThwzHyeGz6JjuyP4LOtlhXi28NWh8ug9qCqVq0Y_W9KsTQZnNWBT4AOwHUUlc3jw8J09y3La544Y64oUHvcZLaOlCMBgkv55xruQa', '2021-10-02 02:08:57', '2021-10-02 02:08:57', 1, 0),
(48, '', NULL, 'احمد البهجي احمد البهجي', '2021-10-02 23:08:50', NULL, '2021-10-02 10:08:50', '2021-10-02 10:08:50', 1, 0),
(49, '', NULL, 'İsmail İsmail', '2021-10-04 16:22:07', NULL, '2021-10-04 03:22:07', '2021-10-04 03:22:07', 1, 0),
(50, '', NULL, '', '2021-10-04 18:45:26', 'dpxpaiAcTR2fX-Qt8P42Pm:APA91bHIO2HQdZql2zgArKQPyY-aREorPOXZWWhThwzHyeGz6JjuyP4LOtlhXi28NWh8ug9qCqVq0Y_W9KsTQZnNWBT4AOwHUUlc3jw8J09y3La544Y64oUHvcZLaOlCMBgkv55xruQa', '2021-10-04 05:45:26', '2021-10-04 05:45:26', 1, 0),
(51, '', NULL, '', '2021-10-04 21:13:32', 'fg2dL0t0RyiC82X3chWW20:APA91bHDfhAKQNMYLddI6zWkZtvdNvdifv0CWRZ-tHieiyix-OY8qCp8kq3q2TIkbAJcGiGjyuH_d1RHZ5MTR9Qw5XzeAY9ySyVVcQOPwHlhvMvmwDO4xVgYX_KSI9kyeKh847ydxOqR', '2021-10-04 08:13:32', '2021-10-04 08:13:32', 1, 0),
(52, '', NULL, '', '2021-10-06 01:02:08', 'd-v5Xw6nSFeZ8zbYMF7EAN:APA91bHPDd7UsDZ1EBvaf8-B7a3Vyn_U0jzKYT9IW_6R9g5hPSBjl0PCX5AM0OObjKhQE9-1egz3E1WtgApt9YdKPiHiLPdhtOJa4kPLIaqWZ8P0CJvHDV0Auja5SJj8gjAadf7GIfHl', '2021-10-05 12:02:08', '2021-10-05 12:02:08', 1, 0),
(53, '', NULL, '', '2021-10-06 14:32:09', 'eGb0xDTaT3S0PdWoZLv0iN:APA91bGGco_0KPbxF_DcLxESgGsh-eFPp_Z6ynXCEYRTF5xHK_6xqFlMp_8FJ3GtViTWGNJ-VZVlSlfla06qMXTj908uyeKRYIxlWXgi0SrxLoVromS2ZZ0sSqMhk-k6wJQr_sxgUTej', '2021-10-06 01:32:09', '2021-10-06 01:32:09', 1, 0),
(54, '', NULL, '', '2021-10-07 01:19:53', 'fvJueIqoRYidnJIab8YeLL:APA91bEatXQGuANQM8PbusZNz1IeLfY2_2NA0W9Vcz1qS7SsVA9E-1YxcR_PzFm7lGNOIhXvGwJ1diIryi8bnC5Xq9Ik7KUYkWrCQEFTrYiuQiqXVAy3pkNddA7nTb2J3t9GWvq4qKEp', '2021-10-06 12:19:53', '2021-10-06 12:19:53', 1, 0),
(55, '', NULL, 'Tioh Boon Kok Tioh Boon Kok', '2021-11-01 06:43:35', NULL, '2021-10-06 18:05:51', '2021-10-31 17:43:35', 1, 0),
(56, '', NULL, '', '2021-10-07 11:09:50', 'ckSnWThTRWazSFtrxxovly:APA91bG2DcKn3jlHcUqTBSusBK_wqLxdfOAscOqVnPZFybQ2MjgfD9ANjQv6h3Wp_-iLQ-p5APCBqnKFo8nhoVJQRj-xIT9Jub5OY0hg0WF0fttjguRg-ekK360gNUoYz-zgFVv3NvlO', '2021-10-06 22:09:50', '2021-10-06 22:09:50', 1, 0),
(57, '', NULL, '', '2021-10-08 04:14:53', 'dhx9FR5hTuiGKkbvU16Vmz:APA91bHkJxWYDvV9BABzx1eHFH-QTvmt8hzHDXamBC_A6cpBkaY8-TH4SvJwhXQ-aHlRzYCw4zVc8_SiCA2u4i_VXc9hG1ikaUSc_jIdDQvN43jgSCorLMExFGQTNr0FjoW7Fbjj5J4I', '2021-10-07 15:14:53', '2021-10-07 15:14:53', 1, 0),
(58, '', NULL, 'Demo IN Demo IN', '2021-10-08 15:18:40', NULL, '2021-10-08 01:19:48', '2021-10-08 02:18:40', 1, 0),
(59, '', NULL, 'Tolhah Aminuddin Tolhah Aminuddin', '2021-10-10 01:01:22', NULL, '2021-10-09 12:01:22', '2021-10-09 12:01:22', 1, 0),
(60, 'mr.tolhah@gmail.com', NULL, 'Tol', '2021-10-10 01:08:39', 'db10gyiMSlSTCyzmwA0wOy:APA91bEezp4xeAvj-2y3zuDCWePZ1S7yk12knfZdVYzh3bepZuC-OOEViiw-P0yQq6slPgL60sTcsuOrev7avULC2NL4SsSrOMWnEeDpv0JlNtEaMB7Rb7dNdUJA1NRgVGFr6gvmgq02', '2021-10-09 12:08:39', '2021-10-09 12:42:35', 1, 0),
(61, 'guestscents@gmail.com', NULL, 'Rumo', '2021-10-11 01:12:23', 'dS-P0p55R-qD8Pj45HRYNB:APA91bGESwhPuq5dvVDHF5LapVA5-eDJHXGvsdE5WvvmhLTidYRLiSgGuTok-5xLQlnXQFmW38leTIogTV8hEP5CKc_jT4HmTt5TCZfDnRfKDUpVDvRjGCNRgeg5Wj4XczpWNj9SqX6P', '2021-10-10 12:12:23', '2021-10-10 12:51:44', 1, 0),
(62, '', NULL, '', '2021-10-11 03:13:57', 'fM9qx_W6S0Sh16ETTt_VJC:APA91bHgMblpe6CiJYA45JHHq9P-lFWwHq07grYgDrqRDbAY2kznd-IbxxMkFf1YDGpXVsKLZ5s3-fE1YFFyVxSF1OyPnTgLnopHiMwaXYcFRQVGQpmQyaapAMORi4i33LsXhKhmTznI', '2021-10-10 14:13:57', '2021-10-10 14:13:57', 1, 0),
(63, 'bkioko@bernsoft.com', NULL, 'Bernard', '2021-10-11 03:23:08', 'eMhmBP8tTHag7PeNuwkCF6:APA91bESQYnNn3dtsBU4dFWwJvdOmQ0-fc8czA0_2nlOtONE3pLYQfRVirdV22UOQnnvRJ4Gnf3El9uxsIes25QDx1fsrDrII7BJtykZrD8wuSJOtVb7ilFe_VaXXsj0sota0M6qpuCp', '2021-10-10 14:23:08', '2021-10-10 14:35:46', 1, 0),
(64, '', NULL, 'Atoumbré KOUASSI Atoumbré KOUASSI', '2021-10-11 11:22:44', NULL, '2021-10-10 22:22:44', '2021-10-10 22:22:44', 1, 0),
(65, 'a@gmail.com', NULL, 'NA', '2021-10-29 13:04:12', 'fqsP-hFXT_iUdX8o-fa4ZZ:APA91bFZoej_27uLz7XENADRk_fnuXyvjMRgwcIxQuQSZJo-4k4hr8Yr3LBKA9814ks2_t62UvyEIYK1akyjPgTlQ0zuRouMtv0JZyQkxdrPh3L66NEOyq2713T590XjEqion4BvTDrs,dMrZJdh8SMeAfU_08NKKth:APA91bFJL5NuhrETJPtVbZ4IpjK71A84u9hI1-IoXLdZ1FNqQo1acQCjckDqkV4D2lfyT7y2LV1Z5qL7c5ex5WyjM4XAAH34zeKizemJROS5kCkD4fNXiBNZaeAqElBmv4gi4oKz3Obl,d4LD_A1UQ0SrwwiCP9Murb:APA91bFZ2lJ5z4ACJqvq7d4-XrBbDIrOFbiwV9KbuiEMaioNOC8q0pOmrQXFZwQFs31uhDgbOeh5WKFJ9QD5EUIdI20RzokVt8NicUEF27cFxKSDFg6eTnC-y4YmroqFoESi8GNTU9fb', '2021-10-11 00:30:14', '2021-10-29 00:04:12', 1, 0),
(66, '', NULL, 'CREATİVERA YAZILIM TEKNOLOJİLERİ CREATİVERA YAZILIM TEKNOLOJİLERİ', '2021-10-14 22:18:51', NULL, '2021-10-14 09:18:51', '2021-10-14 09:18:51', 1, 0),
(67, '', NULL, '', '2021-10-15 21:00:08', NULL, '2021-10-15 08:00:08', '2021-10-15 08:00:08', 1, 0),
(68, 'coolusertest@gmail.com', NULL, 'Monty', '2021-11-04 11:16:05', 'drBqC_93Tsapi0KT_fJicb:APA91bETAfuvbpv7837xbniFmlqFeHO-csSgz0SUSxwnsuvuOVDHLmMJFCS5HOYdByBmtUdikem0snZE1GcWjzs-S46FLED2bL-DArSda_9ZXAOxaPZc5QnALFa0hecSdeRjFtRbMftG,cGLEql9yTXesPx0Ux3NNL0:APA91bHLGTfFqSh1nnmo7oEV5cz-G8I1wIsX3vyjgDmc_E9ydKwXI3Udxkyk1IQrMM7F70-1EU2dOOOhpm7UG8fHHXaBJRQsKwNDmylhccQHOx34re5ne4lrxpnpy-r4Z3NRD6olOCe9,e4nXK3IxT2GHscBmFzeM1W:APA91bFg02FVMsAtFvZ0CSKiKGRqzWHrQQBkEZxr4ostWEjWVzDFRnkmu7c5_5oVY4VgZHOuX_hU7yJmdLYVQCWUDNJpfa4AbXGACi9FS_8KlWOzhcjoySeDM07ekDMpVThKH7MQFXZs,cRFf_Rry8EUkiVkJJSEYbj:APA91bHkvb9RSvPTOWc14F2zwnikNju6dEd0Gvia2kRIq10QMMVq_FKjm3xJhoISixyqB5U70XCaUoRs2AhohrpySXc8-IthUSM-ZssUvSdwufk9esPKPTFS3HPFA0cmIMHEYgFxhYV4,dhdXH2ylsExavjVkDQfNLb:APA91bHJR2e7VthZTbLtnXbGbeFlyU6OXs1_qlE2rsgtq9lZkZkayIi_QQD8X84NpY9d5NCvCtk51DkVYcB5uiOh0ZPwp44D0NNUz3XTz1PmN14PF8DdHJjoxHxwqdjnXpLTQ7dUit6l,cDpC9LCvmEAbmWpQGhf6A_:APA91bFTsOfLZzsat0dyOOJIiJvwrkJU_NsjWb5iPmNb_D0owWlc6YjV7GhTyVktcvSD58d7vD1JQWAPt0osYH3ihZO7B5Z1kEcBjqzfg2cc40JJdlzoLn-id22I_jN884nTizxux6hI', '2021-10-15 08:24:30', '2021-11-03 22:16:05', 1, 0),
(69, '', NULL, 'Chu Hai Chu Hai', '2021-10-16 16:42:34', NULL, '2021-10-16 01:37:45', '2021-10-16 03:42:34', 1, 0),
(70, '', NULL, '', '2021-10-27 15:38:29', NULL, '2021-10-16 06:25:39', '2021-10-27 02:38:29', 1, 0),
(71, '', NULL, '', '2021-10-16 19:36:19', 'drBqC_93Tsapi0KT_fJicb:APA91bETAfuvbpv7837xbniFmlqFeHO-csSgz0SUSxwnsuvuOVDHLmMJFCS5HOYdByBmtUdikem0snZE1GcWjzs-S46FLED2bL-DArSda_9ZXAOxaPZc5QnALFa0hecSdeRjFtRbMftG', '2021-10-16 06:36:19', '2021-10-16 06:36:19', 1, 0),
(72, '', NULL, 'Star Buko Star Buko', '2021-10-30 07:13:20', NULL, '2021-10-16 22:07:47', '2021-10-29 18:13:20', 1, 0),
(73, 'hr7bolt@gmail.com', NULL, 'tejpalsing', '2021-10-17 11:36:05', 'fFf6CWMQQ-Wrawlf-LjIEU:APA91bFV_7YUKhkEaTzhPqiePQA4zZTEa5Htawbgdu1-eCaS1WvR3GFZegBiakqcaJ3MQ-j1FWWXAuCJtO-z5pf2aYbEaWKcRvBwxk3Vyb42PjLoIcqaXAe1vVtsF61AyqghwfKnDoGM', '2021-10-16 22:36:05', '2021-10-16 22:39:48', 1, 0),
(74, '', NULL, 'Bernard Kioko Bernard Kioko', '2021-10-24 22:39:31', NULL, '2021-10-17 02:05:25', '2021-10-24 09:39:31', 1, 0),
(75, '', NULL, '', '2021-10-17 16:48:25', 'fziFDO5lQjSZTKRAU-HIAe:APA91bFVgAbRz1MZDto7FHPMoo0FcTuhpQKUeVRhQJMogqTeqb-NXMhD60UPCiLrtuHoXuo0RUTjkjyXvWdCG34QXDA39Azasjj9ez2WuEWr7JyfT1H7d_MwcFKG3EvqJ7Cqy3Dn6bdH', '2021-10-17 03:48:25', '2021-10-17 03:48:25', 1, 0),
(76, '', NULL, 'Tejpal Rajput Tejpal Rajput', '2021-10-20 08:58:56', NULL, '2021-10-17 08:34:25', '2021-10-19 19:58:56', 1, 0),
(77, '', NULL, 'Narayan soni Narayan soni', '2021-10-19 01:16:04', NULL, '2021-10-18 12:16:04', '2021-10-18 12:16:04', 1, 0),
(78, '', NULL, 'Pe Ba Pe Ba', '2021-10-20 16:39:48', NULL, '2021-10-20 03:39:48', '2021-10-20 03:39:48', 1, 0),
(79, '', NULL, '', '2021-10-20 18:16:26', 'eDGfEEqX40g:APA91bEv0SdM0cAMvypV0BH8siY1d338dT1GCI0tu4oFPG_5lxpUg93Igxf3jZvBwiHKRMnaK_LUki14EN6xM3KiTqHvurGvFeOSY-o6Bw1q5D5tsoJmTkYfKwxjeYC26xpm6-autnSW', '2021-10-20 05:16:26', '2021-10-20 05:16:26', 1, 0),
(80, '', NULL, '', '2021-10-21 18:18:48', 'cJ0xcDrGRzuUhClRWoBvTd:APA91bGWOsRqliE9KWohNOtyG7oje-zEEpbjAXZfcLxRiwuvKeFrIKYy5L_8l2Jci9_lwjvZeWodJ3V3Ovw63RLB1D3BqzAuNwikbcJFt8uwpIJGdfv3zRJV8NKrTHPyjUxe1xCQMpTp', '2021-10-21 05:18:48', '2021-10-21 05:18:48', 1, 0),
(81, '', NULL, 'Mostafa shoukry Mostafa shoukry', '2021-10-30 06:45:13', NULL, '2021-10-21 19:35:42', '2021-10-29 17:45:13', 1, 0),
(82, '', NULL, '', '2021-10-25 20:36:52', 'do-DSVn70UpRmCaSzxabuh:APA91bG7vQzDZBdd5aF6cdoO1tthrWlCc6MS1FtssR2EjTM7kSHUXDkaNVCZkg_s3uqjwJ4HcuHdpk5ZSnQ9iTxd-nCE9zIBwyx_ql_y_pa2ykR925fBAIQoC5fQI_swy-Chmj1p7eC2', '2021-10-22 09:59:03', '2021-10-25 07:36:52', 1, 0),
(83, '', NULL, 'odince Goodwill odince Goodwill', '2021-10-23 00:44:36', NULL, '2021-10-22 11:44:36', '2021-10-22 11:44:36', 1, 0),
(84, 'qjsjdjdjdj@jsj.cc', NULL, 'karwan khalid', '2021-10-23 23:23:46', NULL, '2021-10-23 10:23:46', '2021-10-23 10:28:28', 1, 0),
(85, '', NULL, '', '2021-11-04 01:44:46', 'dchSBveZdEFLgd9b3O-c8g:APA91bGnR2kLChciuyNHqZAONFnQ9wvI_91Idld_XzrqA10BBxMAjQSy1ha2qHGqhCX0MQ9bt20067EoE3Rg9F5vanJmAT95212WuLhNKQBKl8iZ7bPDZnym_e_1KaYbzzME00djqz7h,cbENse6gg0tWnHyf4XljZm:APA91bF77G7Vi11sCQZ37vxP-ZHasx3Bv6tAqSKlQuTyA9BY_XY9h-nprD0Pe_Sz5fXAGlz2NZFvU5_A4cXZnWtDxoz4aY0PsQageAxsWldyQQ8j4nJSqE8TBxKEo6ti12GFGuTviMCf,ey54RAqcwEvRonYGnxJHQc:APA91bE1w89W4S4ymK9g_yCx2gBPGFhzkY2K7cCYbYvickFnguIWKhccS6FMkmWi5uJi8yTSlWCqSUGIUVxLXZubFFSKq0KaclaRvCqyDawUAVsHkXsm43Rov9Z2h-vr_cQ-bHMz2HBE', '2021-10-24 02:42:31', '2021-11-03 12:44:46', 1, 0),
(86, '', NULL, 'Darlington Chiiko Darlington Chiiko', '2021-10-24 15:45:06', NULL, '2021-10-24 02:44:49', '2021-10-24 02:45:06', 1, 0),
(87, '', NULL, '', '2021-10-26 07:52:32', 'dLcjyw0goUV2rJ16uPG-S1:APA91bF0GYv9QTDtWsUSqp2yPwbrUkKVfRpBR2Fxz_JPvr4hxHrdBsNI66S7giUnIcJYPKIkfPJ3z-13yW0EmTjvk6TZgLMjgikOgdhHyEOnRj5-KvRlbhIMM_n-gd6Yl8IdJkJwSwDB', '2021-10-25 18:52:32', '2021-10-25 18:52:32', 1, 0),
(88, '', NULL, '', '2021-10-26 13:57:54', 'f9UxWDzzRPWFHmiHPbQP-t:APA91bFi0ptiiO6y3LYYDheLr0Li_E_m-WjpKKfM4IwgcFH8ZMThOdv7XBDxDpGpSzMfojXd01Gi3iQPv4jk0xOmI9x7z75kS4k0k9UdS9qTEMjvaE6loAqFPtX2XOWr8l6jkVM3NDIH', '2021-10-26 00:57:54', '2021-10-26 00:57:54', 1, 0),
(89, '', NULL, 'esiribiz esiribiz', '2021-10-31 23:32:58', NULL, '2021-10-26 00:58:47', '2021-10-31 10:32:58', 1, 0),
(90, '', NULL, '', '2021-11-03 16:22:42', 'fVvnL7dwT5mzIKliYHdrwA:APA91bEk7K2UFSr4AR8R4C18PreTMyPl8rmjFSjwbAN5eI_oj0Pg5mU1pFRESHq6QzibHCJF5vfc15AV-fMtQAiRvdEqBzei8OT48WUPfz9fW2a7lLn2LDsTueLDPDHzbroHoGfo5QWf,clQ4dqv8Ts-TYfrrrP3IMp:APA91bEgLIEXIcrDsR7Ll8wwj8UDua2ACJJiigkHBt6m-iIEcv7dHXrwxIcTantlHUrE0kRiAgS5GUHs9d7TSWIPiOKefLJ5Oefn7751xuvJ6Hyf0zSHhHrG8mcLXB7LEbFNMpkckvY3', '2021-10-26 04:10:20', '2021-11-03 03:22:42', 1, 0),
(91, '', NULL, 'Eric Gisore Eric Gisore', '2021-10-28 00:00:45', NULL, '2021-10-27 11:00:45', '2021-10-27 11:00:45', 1, 0),
(92, '', NULL, '', '2021-10-28 01:38:55', 'fnPOPMWkaBo:APA91bFmqfVX4RORJ7zK4xrW5z8Ick9BoYQen3k7XmzNuhNwp68wcO0qw7QHoOrvlcofN3EmOW3V0RXeBKMNuqZNsG4dhLfmOjTBosmh0-EkzdVgdY6odP1REiGYja4Mju5TJTAEzvqU', '2021-10-27 12:38:55', '2021-10-27 12:38:55', 1, 0),
(93, '', NULL, '', '2021-10-28 02:07:31', 'exkxDU2a2FE:APA91bHYHLNSMkOVN4KLt8ZXGkd47GBwYjwPg1Bq3VFz_LnOXI9DtKWNWQMWl56qNrM6npfH_GzpDr2n2DUlY0KBT-35Fd06Y_zFdW9V7LdAHnaj-5Ngm9I0jeU1BJYJvesVAqFfixqS', '2021-10-27 13:07:31', '2021-10-27 13:07:31', 1, 0),
(94, '', NULL, '', '2021-10-28 06:39:54', 'cBBi40DuS5OMuIqohIn4Yr:APA91bGaygzfIOVOo1TTia4YNMPsxM-ybTvbc3-hWw2PkX63f8N_4p-prK6BMe1e52Hb0lcKymRl0kS6hJiacmfJCiIOvkDw7IGlj47V5Y_Tw6Zw0QchpIkz94B3W7xyJoi5hye3T0z5', '2021-10-27 17:39:54', '2021-10-27 17:39:54', 1, 0),
(95, '', NULL, '', '2021-10-28 15:35:25', 'fqsP-hFXT_iUdX8o-fa4ZZ:APA91bFZoej_27uLz7XENADRk_fnuXyvjMRgwcIxQuQSZJo-4k4hr8Yr3LBKA9814ks2_t62UvyEIYK1akyjPgTlQ0zuRouMtv0JZyQkxdrPh3L66NEOyq2713T590XjEqion4BvTDrs', '2021-10-28 02:35:25', '2021-10-28 02:35:25', 1, 0),
(96, '', NULL, '', '2021-10-28 15:51:36', 'eY3n1s-lRGWtgyBhRlcTd7:APA91bGBj8okawMKLs6mZYr9YxlykrKE5lvtispArsY8oI_iemmzssqOvE9ddNjFgih5UK9EMHRwoswF572P9CgOnUFMYrcKu67mhpEcDXtyyqhfLqI8Z_N0eCFrqPtDb6m7CEPhhH8v', '2021-10-28 02:51:36', '2021-10-28 02:51:36', 1, 0),
(97, '', NULL, 'Geric Calvin Geric Calvin', '2021-10-28 17:53:35', NULL, '2021-10-28 04:53:35', '2021-10-28 04:53:35', 1, 0),
(98, '', NULL, '', '2021-10-28 19:58:49', 'eo288IKHQ7WZ8czcOxUwzh:APA91bGNGVkb8YMk5qMADjsfwyVMsC5Ehw5UUKqg59HbO4Hv0XEkDYm67OBIK9pB86hnfoiG-Fxryp433j7cZLwr0C4cdGxNCrJ2DodBvkluMYQb_rJrkEQ77rYmY0j7Bv5JjMGrywl7', '2021-10-28 06:58:49', '2021-10-28 06:58:49', 1, 0),
(99, '', NULL, '', '2021-10-28 20:28:01', 'c9NTOwec20eQgziqpbqZKO:APA91bEoffpxvq2xNUyh4ZKFsF5rdgw3oZKG_XPKLn6LN95CMBHp5KereHdy_LYylzD3p1nhtbmjRI3v9U6CxDhrRGdmpaht0hVtiQBuMlzyS5fomHeKAKhfZqakFxtI_KMEUwDFoHxe', '2021-10-28 07:28:01', '2021-10-28 07:28:01', 1, 0),
(100, '', NULL, '', '2021-10-28 23:05:46', 'fvtnht63yEvskhXOb2vYY9:APA91bGVQTP_RnZqckcpG1hyXJ8_3gh_Tbt-t1EX6uSSnjXqVPdbDubWrZXEsyeFQNJyZ37VrNz58CRWrPdWIAw46QCEpYUvMFSML9w2AiiNan5qQ3NVG5YWDw-Diujy7h6PTYz7OhtI', '2021-10-28 10:05:46', '2021-10-28 10:05:46', 1, 0),
(101, '', NULL, '', '2021-11-03 22:04:33', 'ef6fGMOiNY4:APA91bEv1j011vn_bDs0P00HUEyF7pel8jt5QHLpctKhqIgZrwkkJADZEm7X3yL-1q1yTwZ9ngAxGU309CcRBoWNmFVKfmcQ5eYTrGomD8ca2uMm4JFwQYMumpnhNuRkH_SklCYvoAo8', '2021-10-28 11:16:29', '2021-11-03 09:04:33', 1, 0),
(102, '', NULL, 'Melinda Barton Melinda Barton', '2021-10-29 01:26:20', NULL, '2021-10-28 12:26:20', '2021-10-28 12:26:20', 1, 0),
(103, '', NULL, 'Pablo Colon Pablo Colon', '2021-10-29 01:38:42', NULL, '2021-10-28 12:38:42', '2021-10-28 12:38:42', 1, 0),
(104, '', NULL, 'Fred Romero Fred Romero', '2021-10-29 02:08:46', NULL, '2021-10-28 13:08:46', '2021-10-28 13:08:46', 1, 0),
(105, 'florimi.tirane@gmail.com', NULL, 'NAakaja', '2021-10-29 05:34:50', 'fFlodlx6T5a_rnBfMZ1-66:APA91bHtusyspR72A-RX82SerRfzslY-WCeyDKg6KNIyJxX7DIfLSiq5j74yS4Tp1vW713aj7PfpFAuLnpJ0g7NOfxu11x-NL6t_KkaW3KW5bKzVJpUXnGeUADDdiCAyrDX1iefyDlb3', '2021-10-28 16:34:49', '2021-10-28 17:50:01', 1, 0),
(106, '', NULL, 'H4WL3RY H4WL3RY', '2021-11-01 01:21:42', NULL, '2021-10-28 18:42:23', '2021-10-31 12:21:42', 1, 0),
(107, '', NULL, 'Shelly Weber Shelly Weber', '2021-10-29 13:43:34', NULL, '2021-10-29 00:43:34', '2021-10-29 00:43:34', 1, 0),
(108, '', NULL, 'Jim Haynes Jim Haynes', '2021-10-29 13:46:33', NULL, '2021-10-29 00:46:33', '2021-10-29 00:46:33', 1, 0),
(109, '', NULL, 'Stephania Reedy Stephania Reedy', '2021-10-29 14:35:56', NULL, '2021-10-29 01:35:56', '2021-10-29 01:35:56', 1, 0),
(110, '', NULL, 'Florim Brahimi Florim Brahimi', '2021-10-29 22:52:39', NULL, '2021-10-29 09:52:39', '2021-10-29 09:52:39', 1, 0),
(111, '', NULL, 'wave 61 wave 61', '2021-10-30 11:47:00', NULL, '2021-10-29 22:47:00', '2021-10-29 22:47:00', 1, 0),
(112, '', NULL, '', '2021-10-31 14:34:33', 'euxufGsy2hk:APA91bFHO7h9-HScw1d0mcb3rykcpVCAqtTcNPpNDY-zNq1lOwsBIiGfjLXfOr5YZq8JObDoZlJbRTTiSrObAXTg045yPRugHzzm8OtsIXmpYy3hleeQez6YQgAwaDhhJ_WN2wHQZUHd', '2021-10-31 01:34:33', '2021-10-31 01:34:33', 1, 0),
(113, '', NULL, 'orion terolli orion terolli', '2021-11-01 02:36:03', NULL, '2021-10-31 13:36:03', '2021-10-31 13:36:03', 1, 0),
(114, '', NULL, '', '2021-11-01 12:29:03', 'edcZ1hSPSGSAWcdJBsX4c4:APA91bGJjnOP6rs4R2XB7CspuIF3jWTcYosKNecrkaUHkcfOwwcpQ_XRkRt8tEON-1FY1_B8KFliJdX1iPSLf89DvU0Ei-lXtDucAhzaOm3QFvy-XGo_zHnX1waUbAQJVbwkH7-Wj-K0', '2021-10-31 23:29:03', '2021-10-31 23:29:03', 1, 0),
(115, 'yogeshchotia09@gmail.com', NULL, 'NA', '2021-11-02 10:33:54', 'fmj4Fy9JjXg:APA91bG1es82MvNgfkkfr3Tk-Mgiz-QunIVoHNTROSdykSAbOnMAolIzAYDrrfXheKc0Ldgdsa3HIL4QLJwQfqgBH6BCnEGLQG_tqdKSJ19yuZpETouw-8BxUFrjynXenvPzCp6rXL6k', '2021-11-01 21:33:54', '2021-11-01 21:37:35', 1, 0),
(116, 'sumit@gmail.com', NULL, 'sumit sindhu', '2021-11-02 13:49:36', NULL, '2021-11-02 00:41:03', '2021-11-02 00:49:36', 1, 0),
(117, '', NULL, 'Madhukar Jha Madhukar Jha', '2021-11-02 14:25:42', NULL, '2021-11-02 01:25:42', '2021-11-02 01:25:42', 1, 0),
(118, '', NULL, '', '2021-11-02 19:37:51', 'fLKqR0p3Lk2RusVLEgINZD:APA91bGm0jHYjH6Uj1MPsEq6YGTMTHptQMR8qLvXLepnoW--JqRIXttS9-Ew9vXdfOSrrCjnMtM4K9EIXQeGNIbxx3clmTTXKb2zVKRzcbaTa4HTuwYZXc71nBJ72vTpAlLOTL9lQ_UZ', '2021-11-02 06:37:51', '2021-11-02 06:37:51', 1, 0),
(119, '', NULL, '', '2021-11-02 21:42:00', 'd5q1DTqe5ENAubyWhdw0UW:APA91bEWsfka7LPXbZCuA5k3RYC17lodD3oCj7g23NZlVsIRkwuhRvVUYaPiJlMaLTL6fw0TNux78IfMgxE6iG3AbpRohDJkgP4oiCNqymqmKbXSnfoHS87KSTEd2PJoAqfNSZodMQya', '2021-11-02 08:42:00', '2021-11-02 08:42:00', 1, 0),
(120, '', NULL, '', '2021-11-02 21:43:32', 'cfse8kGe0korr4yK0jyqmi:APA91bHVepVtliLPcaqETfK3OGs7hURTvKpQ8bcplA01syC69qojh0V954bhO7BeHJKcCQPDMylpzCzehAz5tlz4S8dFa0tiSgqax4Fg5JbhP7j3fWsZO3g8qwdck5emrCVPwqAa1yLa', '2021-11-02 08:43:32', '2021-11-02 08:43:32', 1, 0),
(121, 'chieftan@poczta.fm', NULL, 'NA', '2021-11-03 16:30:41', 'cO6SFWIMRWuVujxvlnU2wg:APA91bHMrh7pLC9fEeRmPH8iZnX78tkuJtL3eZI-jH7YrcwFoioRNOR2qUbHRmd-GI0WDXiEKP5o0VpI0ni-tbBN498Tl59lAZzWbmONAYOT2zzvUfeHzePAeJOCr95Y1ic5O0d4oDjV,d1zOiRC-SDm2M7_Begeatm:APA91bEiddN4sSlHkONeqoEHopE9SXZ17JYbxxY6z-zL5W_LdOR1UmsupkquOL3tFC0x8V2Dru5t0s4xXhfIR0O40uN--l2JXHrSgJMcDQN3x-m-se2LSYbLz56Y7Hm6TKyTgRtUPukO', '2021-11-03 03:26:11', '2021-11-03 03:33:23', 1, 0),
(122, '', NULL, '', '2021-11-04 07:17:41', 'dvc9597080frsW4qBPwZVK:APA91bHDKKW804a7tmoRNF4pbok8kgIpkYuB7NZFJhdng7ySTNf4bKRcm-iYGKbGkTOzw1SHla34hlBD5qbx5mpPPm_8iwrO0Z5q2kQbp5As4JRSEzvebSYxm8Es5j89O88bU738Fp6Y', '2021-11-03 18:00:26', '2021-11-03 18:17:41', 1, 0),
(123, '', NULL, 'MD Nazrul Islam MD Nazrul Islam', '2021-11-04 17:34:46', NULL, '2021-11-04 04:34:46', '2021-11-04 04:34:46', 1, 0),
(124, '', NULL, '', '2021-11-04 18:43:30', 'f7uvZijd34A:APA91bGuZrP0JXlSWCRLJ-9rCy1ahRVj85EiWoxiYf777zWC2mMWXhO0hkIaNrD3B4ME8bZp8-H2xDAQe-tfh1pf0DNsNsJQdoYQOZE8MO6eaiWdyGajN7tAvjDQhdpbKKHlRYPMxuVB', '2021-11-04 05:43:30', '2021-11-04 05:43:30', 1, 0),
(125, '', NULL, '', '2021-11-05 04:49:16', 'eHBrY_b3SbqVa-37OLKfGo:APA91bHjVd4fJcq6AFZy5nFtGGV-1aHgarmNeYZQVrWtnZ1QHyAGPEvLDQ5k4-xEqg_10DxEE2raK2AFI_ULNiBnNT2gRIfHd5-MC8_9vn8w2nC0-4q8UMTJGctLXd_4MOBZ-yhVh-P6', '2021-11-04 15:49:16', '2021-11-04 15:49:16', 1, 0),
(126, '', NULL, 'Yasser Tamimi Yasser Tamimi', '2021-11-05 06:16:33', NULL, '2021-11-04 17:16:33', '2021-11-04 17:16:33', 1, 0),
(127, '', NULL, 'Bruno Lovatti Bruno Lovatti', '2021-11-05 17:14:47', NULL, '2021-11-05 04:14:47', '2021-11-05 04:14:47', 1, 0),
(128, '', NULL, 'Saad Ghandour Saad Ghandour', '2021-11-05 21:20:36', NULL, '2021-11-05 08:20:36', '2021-11-05 08:20:36', 1, 0),
(129, '', NULL, '', '2021-11-05 23:35:54', 'daJSihHTG60:APA91bErlxDQj0sLiZOoTNuvKRnM3Py4HeGgT1xpkYB4EWVwGfijLCB2b-lerlDwDlSnnpjRioLZyZvqORT8V_AAwIyaaQ7xJUXSRxaSo2X9tqADAgFHDbChSL_-1gwsoiqu84Q2a-YI', '2021-11-05 10:35:54', '2021-11-05 10:35:54', 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `userstemp`
--

CREATE TABLE `userstemp` (
  `id` int(11) NOT NULL,
  `email` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='User table';

--
-- Dumping data for table `userstemp`
--

INSERT INTO `userstemp` (`id`, `email`, `password`, `created_at`, `updated_at`) VALUES
(1, 'abc@gmail.com', 'abc', '2019-12-31 16:18:10', '2019-12-31 16:18:10');

-- --------------------------------------------------------

--
-- Table structure for table `users_authentication`
--

CREATE TABLE `users_authentication` (
  `id` int(11) NOT NULL,
  `users_id` int(11) NOT NULL,
  `token` varchar(255) NOT NULL,
  `expired_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users_authentication`
--

INSERT INTO `users_authentication` (`id`, `users_id`, `token`, `expired_at`, `created_at`, `updated_at`) VALUES
(1, 1, '$6$rounds=5042$613c7f53d3a4f8.1$woNhpYgF1dPrW2kLWwdIp32EHTEL37DLkFzAh.6mpuSdXtQPyH74dgEPpR94a3YtKv2gBQZ4JWM5fe7Yse1fC/', '2021-09-12 09:40:16', '2021-09-11 04:05:07', '2021-09-11 21:40:16'),
(2, 5, '$6$rounds=5042$613cbc163f8014.7$eE.AnSkR824ODpHlbOK.TMUZXTKbSxaU0/iewyAe1aaybXu26XDUxa9oLtB8RweaU2GhUSdxglepUT7XtXVRg1', '2021-09-12 09:24:22', '2021-09-11 08:24:22', '2021-09-11 08:24:22'),
(3, 5, '$6$rounds=5042$613cbc461aa452.8$kle5..aUpeaBba/HxHtKwOui6CNrcM9m6oL9qXZf70IDsnhmxjhH/AkBbwplIwnshjz1ALBZLQHBb3STvyAG0/', '2021-09-12 09:39:07', '2021-09-11 08:25:10', '2021-09-11 21:39:07'),
(4, 5, '$6$rounds=5042$613cbc949ba482.9$H5CuWHhEX/bHEBYVh.b2ksZpZ.enT71a1NiwFpXFkeM3/nsD5Sbpfbvhe8.ABiAndhv/Sf7LKaNwUkBXrZOtD1', '2021-09-12 09:34:59', '2021-09-11 08:26:28', '2021-09-11 21:34:59'),
(5, 5, '$6$rounds=5042$613cbee69a1321.7$J1lbLfGGJS0SbLS3RMDtKbljLuVnewj5QbRwZDnmF9URSu7INEUQJP6kge6XC.nH4AMuukb7vFD0N8BRNGbSv0', '2021-09-12 09:41:30', '2021-09-11 08:36:22', '2021-09-11 21:41:30'),
(6, 5, '$6$rounds=5042$613e3fc47e4682.0$LotHTkUMweFTE8yiL48pFjo8bfLBN1NlBMn3DMmT/LFlfnuHNirw9thq3mR0l1FUzszWg7x6sv.dDjsi4FL8U0', '2021-09-13 12:58:28', '2021-09-12 11:58:28', '2021-09-12 11:58:28'),
(7, 5, '$6$rounds=5042$613e4022c12806.1$r3QQh7F1yGyc21GurdU3wPNZJJwgEbSDu/VVGCB//nJBUnrS/QSWJiCS9756GldtApxIUotHGqEIPB1N8xm//0', '2021-09-13 13:00:20', '2021-09-12 12:00:02', '2021-09-13 01:00:20'),
(8, 1, '$6$rounds=5042$613eee8192d8d8.9$j.Fmz.Cd99KDsS8cfpiCU3Ncyte01ED000frxZAVOC6HSUcXiEgsItahunz59OX/pUc2WwCHRH1.N.hNjWaZB.', '2021-09-14 01:24:19', '2021-09-13 00:24:01', '2021-09-13 13:24:19'),
(9, 5, '$6$rounds=5042$614051f8501e86.9$hr.Sv/uOxIx7sZ2cmYK2Wh6PWB6THZiPe2Fgs6HyhvMJPKflPLAtRUdpNvYHuIWARVO7FzUepIsFfxEN3ILKx1', '2021-09-15 10:49:17', '2021-09-14 01:40:40', '2021-09-14 22:49:17'),
(10, 5, '$6$rounds=5042$614052bb689a09.2$lPET7V99mYFtppC6nlayRLTQ2Njm3mUs8T88reSH1i1syVB.TW6EChHJhSSuX0H4fKuqtRThRf1WF1oxzXHEe1', '2021-09-15 02:44:28', '2021-09-14 01:43:55', '2021-09-14 14:44:28'),
(11, 1, '$6$rounds=5042$6140a7719465d0.9$ZzvXwBgat6VWOSM5QB20MRDKSi0kbCSIYOyMzpg0axqfl8nCXuSyno09ztIlyM61FjZH.2/7zlsBYO4hsNawl0', '2021-09-15 10:38:51', '2021-09-14 07:45:21', '2021-09-14 22:38:51'),
(12, 5, '$6$rounds=5042$61471d66e9dfd7.3$MlGb9ThmDfHY8X1GR8a0TtWbGvYerso0eE78psi1UgpXHGP/mIkijgjOvdg7J4b3lZyHHD5H98TtSyWHvJSBD/', '2021-09-20 06:22:14', '2021-09-19 05:22:14', '2021-09-19 05:22:14'),
(13, 5, '$6$rounds=5042$61471d99d9bbf7.2$oOUP7K3DLedxbHz4h/9rFQwlYv8Gmmd23G/1UrWo8sL5O2WXBtDVghadzbLKyWaR51FiPwng1zoz.KXd3/Zca0', '2021-09-20 06:23:05', '2021-09-19 05:23:05', '2021-09-19 05:23:05'),
(14, 5, '$6$rounds=5042$6147231ed57205.8$7LsMfLIhh.1wdJq44UscYeZjwmLQfRuJ4FcMrhRNK/e0iq00oIrA6CbXLFBTtms3wxnQATyieKAOwgrjd.UJ3/', '2021-09-20 06:46:38', '2021-09-19 05:46:38', '2021-09-19 05:46:38'),
(15, 21, '$6$rounds=5042$614726ef97f868.0$rVOZrL/74YwvaXzssuyrLQAMLRZxoP7iH7vffJNA3PvWJWw2/.hf2FM5VYFXkizdUe53u5RxywuYyvGcWYp9Y.', '2021-09-20 07:02:55', '2021-09-19 06:02:55', '2021-09-19 06:02:55'),
(16, 22, '$6$rounds=5042$614837f247dfe2.9$AFE/iZvAUCEngblJ/RNv.VI9h1Y.KgHwv9.g8oCw1kcVWWX3lT4cgcyzOdMH1vgTqUWYh1qncJOpSwjqdNDtt.', '2021-09-21 02:28:03', '2021-09-20 01:27:46', '2021-09-20 14:28:03'),
(17, 23, '$6$rounds=5042$614d743c514341.1$DJd3EgWVHgEjDIw6PJ/NJ43ot7D/VQIpJpSkDuK.aPNtjAPZ.W0A/JxOcVfn6hzY0zn7vIuz2e5iOkB1Dn3VI1', '2021-09-25 01:58:19', '2021-09-24 00:46:20', '2021-09-24 13:58:19'),
(18, 24, '$6$rounds=5042$614e67144b0448.4$WDXK8XfbAsDDtBvDbuZb7l58exJEgQxx6nGjHGadflhSo27YVgD4/KoyXMFT8ieJrOYD49Ofnw..hX55m0xrZ0', '2021-09-25 19:05:21', '2021-09-24 18:02:28', '2021-09-25 07:05:21'),
(19, 25, '$6$rounds=5042$614eb80f977fb8.6$CyCz2LKtgLQiFzEugM66U5R2dFECbOQB1y9wQprZQnBKCRUwUIdV.X6irxIqfe1sLBFg054HUpVwtyCafrTph.', '2021-09-26 00:49:54', '2021-09-24 23:47:59', '2021-09-25 12:49:54'),
(20, 26, '$6$rounds=5042$614fa2d19f46c9.3$sp547qRziTGmFMmEwOzqIR7SSbFnvk6MGaBzBkJINvOS65x4bykCsHVGgEk5/rdSxHknvvoWxH0Eoyuh7tj/0.', '2021-09-26 17:44:39', '2021-09-25 16:29:37', '2021-09-26 05:44:39'),
(21, 27, '$6$rounds=5042$614fadc50584f1.3$rhrUgS1.Xy5RVSwzKNE6zTn6X7wHtuM7j/4rYUn5l.4mI6QBxuFJ63.JI.9AdfWSGJKmrPwFmB7DD2YczNZU6.', '2021-09-26 19:58:18', '2021-09-25 17:16:21', '2021-09-26 07:58:18'),
(22, 28, '$6$rounds=5042$6150ac35ed7361.7$NJa5PQtUHonCzuF.xXWBkw65z1dVUkr7I1nM.YJ91RCXZuTJaoYivrGdnqZCUdOZ/A6895d/xxf0KvgaRMrj3.', '2021-09-27 12:22:24', '2021-09-26 11:21:57', '2021-09-27 00:22:24'),
(23, 29, '$6$rounds=5042$6151061e26a7d0.7$lxma5T/eOaXsglc0QWgiorIjmUCrhSKx.izOSYvEaF0/9nNAkECOVDVwldQF/8.i6pXvI2Dv35JucoC9/EonO1', '2021-09-27 19:38:08', '2021-09-26 17:45:34', '2021-09-27 07:38:08'),
(24, 30, '$6$rounds=5042$6151cba0d43e34.1$IDwIx3j9A6ZaoYkLPX0OUm9vjxfXZ4vsNeiPNVt0zL/hPYUzzQiNros6ovTA/qOg2S5sjzlGK1KDChDtmkxmL0', '2021-09-28 09:04:25', '2021-09-27 07:48:16', '2021-09-27 21:04:25'),
(25, 31, '$6$rounds=5042$6151d029126409.7$3Q4XIm7WTGdRhZUTA5F/BTY947l2DxqqQjieQh05BAoFXGW3KJzpID61nVwQ344pnOGAs7MocXGuKNCuqtoeB1', '2021-09-28 10:27:56', '2021-09-27 08:07:37', '2021-09-27 22:27:56'),
(26, 32, '$6$rounds=5042$6152232c088568.9$kn/0y3pjpxO33A8hOmNw1MZOr/ZdDdDDAeXFm.OfL88JkGP70fxIvZ.fKduWaFo5c7hko..V1R801iYeJIIC/0', '2021-09-28 15:02:51', '2021-09-27 14:01:48', '2021-09-28 03:02:51'),
(27, 33, '$6$rounds=5042$6152582eeff4f3.0$wgaGjPayFc3PaN/e8gCtSvxtN87dKZW9uZBnXrEzgSTF8Iw61tBameHx8ADSGx7fO3Uo0SDCsCzDExWbPmWKT/', '2021-09-28 18:48:51', '2021-09-27 17:47:58', '2021-09-28 06:48:51'),
(28, 34, '$6$rounds=5042$6152a56c912ff5.6$4uoBAj7bvY/PZKnS3EA.5/at2IkbR/4GC6mMf6VW90m0f.CvU6HKCxMmj1ooOsL6cCzLwd.oQZZ.94QF5alKc.', '2021-09-29 02:35:25', '2021-09-27 23:17:32', '2021-09-28 14:35:25'),
(29, 35, '$6$rounds=5042$6152a773e7b257.1$YSJIumJhIU.k3X7u/i85vgq/5xagalkUNi3Avg52ilp1ldEbgGAT10rwjvFpdk9ixhy765kyCrtx3x4wzGyIA0', '2021-09-29 00:42:42', '2021-09-27 23:26:11', '2021-09-28 12:42:42'),
(30, 35, '$6$rounds=5042$6152af2b1e1ec0.0$0KY7E1n7otiksmrYzQ.NapWjHtTrztzlS9.ofMkZwWFj9Ym6kx.M7G/Yfq4q6JXb5ysmScnE1oyDBGssGjaDK0', '2021-09-29 00:59:20', '2021-09-27 23:59:07', '2021-09-28 12:59:20'),
(31, 36, '$6$rounds=5042$61536d33a4e226.7$vsHx7kBwMoJ5H6C6NoKLxFrfIEUrFP81zSf9zYdZnjeVBwq2WIJydQgCgIAQQ3NQZfW2pyAevaQucQZBArhap1', '2021-09-29 14:57:57', '2021-09-28 13:29:55', '2021-09-29 02:57:57'),
(32, 37, '$6$rounds=5042$61536e0a7d3d11.6$zwn0v1uKEdZcMZtf2qk3oWziqL9.TqNbOnWdKxegvp590gIgC0ammR8HBfU7UyMEXEeUPMN4RksG1FK1LXk0B1', '2021-09-29 14:37:34', '2021-09-28 13:33:30', '2021-09-29 02:37:34'),
(33, 38, '$6$rounds=5042$61537433aae320.5$yqFBKoora7pKr3gGmJmURwqVwXylLugWIWV8vUBCEwJoqpg//UDemdIs5HFxwkljtzXuXJxB.7OPTvmKWZmbS.', '2021-09-29 15:01:03', '2021-09-28 13:59:47', '2021-09-29 03:01:03'),
(34, 39, '$6$rounds=5042$615413aaefbd33.4$XMnpuoxrjem7XNvdDSXUGeZ/b81XjlQ1VMtj5zA29JcZmeWx6EcVvXYF2UXUjVY2nlfIz1i4L7LVUDHZLqeOA0', '2021-09-30 02:23:05', '2021-09-29 01:20:10', '2021-09-29 14:23:05'),
(35, 40, '$6$rounds=5042$6154168b3b1b10.2$x3pb3CdTAVkfoXqo0ivcRaBhX3Zb8zLjnU5vtq912vMsC4oRZ1h0O3noASTmwFCeoBLgabLqu/0h26ZCGn73H.', '2021-09-30 02:38:03', '2021-09-29 01:32:27', '2021-09-29 14:38:03'),
(36, 41, '$6$rounds=5042$615472a2987d11.4$6suTwHHojqsCaRJJLC9xaGDR3j8dmE/HALNoTkCFcaWcymjjEXa7qmAO0YMK8yuAaxmgsN0pVeMTlB20Q7XYx.', '2021-09-30 09:08:43', '2021-09-29 08:05:22', '2021-09-29 21:08:43'),
(37, 42, '$6$rounds=5042$6154dd4b252552.4$Vduq3Ug9aWzaGgi1/8lgaKD.BW/vtbKGbEulHAoCre9dZS2jd93scu2x/AqCcuEhIWbsd//LIjOsJnE3QHfCu/', '2021-09-30 16:52:52', '2021-09-29 15:40:27', '2021-09-30 04:52:52'),
(38, 43, '$6$rounds=5042$6155cca0a980c4.6$TTNsCimquueDvUGwXn.hjwlMFKnzvjN/NGRFnaIPFZfjKvnLRt/MJkc15he8avb3.3uv2XuT3h/HtNzObLFLr.', '2021-10-01 09:44:44', '2021-09-30 08:41:36', '2021-09-30 21:44:44'),
(39, 44, '$6$rounds=5042$61561517b7dc67.2$uZAXaRoEukYjshFRYoChdL5MePDjjhDipLzp43Zp98vRaizBrrSq34vP94QxTHKx6sn3Iev5qiC3I2c3i9H9x/', '2021-10-01 14:52:09', '2021-09-30 13:50:47', '2021-10-01 02:52:09'),
(40, 44, '$6$rounds=5042$6156310b814ce4.8$zuhqPW1hr/t9kbG9NDabxr7tn.Ot0t4lMSK4zTudnjrjx3rbRSWUvWMcTZm5eaipp2RC0/VzAnc7MqJQyAM4e1', '2021-10-01 16:50:12', '2021-09-30 15:50:03', '2021-10-01 04:50:12'),
(41, 45, '$6$rounds=5042$615735b474bb40.4$SEQ8sAhjtwcSNaRGDEY2WDDau18KwP1NA8Koft7.XGqMzRsH35/zX0b49Bl704WgDCm9hPoj7PkK1MXDM/mJb/', '2021-10-02 21:52:01', '2021-10-01 10:22:12', '2021-10-02 09:52:01'),
(42, 46, '$6$rounds=5042$61575ff65a31d5.4$me9/Lo3QKH3/mJ79qBXAlTjHOX0n5nxqjEsyN43TnRPPMqPRxhw.RUZSkO.s0bPvg/TQe6mYyXMKJ9J/tqY3K0', '2021-10-02 14:28:27', '2021-10-01 13:22:30', '2021-10-02 02:28:27'),
(43, 47, '$6$rounds=5042$61581399790622.1$pnWM16LK4Mo/noB3uajXpTsO0HS8Cw.8JTirptKGiL9hcCZUbwR0tW4XJwkQSerxt9D2hJHlIea2Yy9vKJChJ.', '2021-10-03 13:28:19', '2021-10-02 02:08:57', '2021-10-03 01:28:19'),
(44, 48, '$6$rounds=5042$6158841265b954.0$NPT3.KphpsHiP6stSmjUMmB2eaosGvEpALu7RT6VBRjlIEcoOu5dEvJvaKamKSRFGLgQShamzREU2la9c46qu1', '2021-10-03 11:11:17', '2021-10-02 10:08:50', '2021-10-02 23:11:17'),
(45, 33, '$6$rounds=5042$615a4f749fcf52.1$yaqh7rVL6VsRtdiVPc0OC/EUqK2avWhHAN9oPGU8l6FMtivQC0UvGYj7ikErjBjcDPTxvDkB7uDiMmNg7604z1', '2021-10-04 19:50:08', '2021-10-03 18:48:52', '2021-10-04 07:50:08'),
(46, 49, '$6$rounds=5042$615ac7bf179549.9$oyvOaZ5kPEn00RLnYQKG8AHwVqEplABPf2MbVCV3NoaSdwU.8nzvxd9oGkkJZw8wKH1RP2EOFeVb7RLRBWv3B1', '2021-10-05 04:22:35', '2021-10-04 03:22:07', '2021-10-04 16:22:35'),
(47, 50, '$6$rounds=5042$615ae95653f5b2.7$kwNQ6kl8j6tudRXxchzVF9rCsIiOtzC0cjMlHgpBT8SbRHrB9PBJhr352uQSaywLSzhaHqqwtuEKelw9NcXc11', '2021-10-05 06:53:24', '2021-10-04 05:45:26', '2021-10-04 18:53:24'),
(48, 51, '$6$rounds=5042$615b0c0c147995.6$CpIFEpmNL6Vqc6.MqFQ6um/m5QQW/xqJ.Yx30EewDfggIintVmrmFJ.WKd1FiB9JjHLuH5qDCe0hiFWt7HMZJ0', '2021-10-05 09:14:21', '2021-10-04 08:13:32', '2021-10-04 21:14:21'),
(49, 52, '$6$rounds=5042$615c9320d70358.6$57IThFEdR.5pg5sVyfNwFfrLrzmfK4DYo3200MbsxNrXC.OjWL.UOePRaHXUAayhajVJ3Vkrgwhnb0ncCK3FR1', '2021-10-06 13:04:30', '2021-10-05 12:02:08', '2021-10-06 01:04:30'),
(50, 37, '$6$rounds=5042$615c97fe225d10.5$PKYRnHjNLV7WEFOnDzjjNCfVc3zr1mW63IzfsCahu2RdcbK6RuDnjX9oRK0oFkAicRVnkTUdqjOalD4wC.e.a1', '2021-10-06 13:24:17', '2021-10-05 12:22:54', '2021-10-06 01:24:17'),
(51, 53, '$6$rounds=5042$615d50f981d498.4$v3zQjtVThuXphIIkMq5jR1LVTfo3Myuyzmn4tpw32KDiFBhKuaFIlGRVOWkVbXoBEVSstSZYEdVDffky7rrRs1', '2021-10-07 02:32:38', '2021-10-06 01:32:09', '2021-10-06 14:32:38'),
(52, 54, '$6$rounds=5042$615de8c9819d50.7$40dzXCNpJ.TppM7IKW97gkhS5jk2UkMbUwF.3WsUa4SIPbiWeSwYfnBaEzq/lsv9d2jMso60MQR/FFURWRrIM/', '2021-10-07 13:27:08', '2021-10-06 12:19:53', '2021-10-07 01:27:08'),
(53, 55, '$6$rounds=5042$615e39df923c91.6$.qx3pkT2004sygVhlsyDe7oEw.ZWdrroaBwiVG527tqEfStt20NquhJYdOVSBaSGPy/6d2Jp8l/wPpHS.QHX8.', '2021-10-07 19:07:41', '2021-10-06 18:05:51', '2021-10-07 07:07:41'),
(54, 56, '$6$rounds=5042$615e730e0534b2.1$gqrvFJ/Xo50bYNxQlZATszr5IVigV7F0XonQn2WzhvaIm9S/w7qXCF5A5pFGJyT5QBupUvSGjeyYmP3SSC/rV0', '2021-10-07 23:13:02', '2021-10-06 22:09:50', '2021-10-07 11:13:02'),
(55, 57, '$6$rounds=5042$615f634dbc3d05.1$QTG4Cn3P6HwNoOKMOOYf4D/ov2Z4E5BQAJfi4/5lYzYxnanKYxfwOA.ogi/kpFrI9XU0VM90hDRGaSAALUgfn1', '2021-10-08 17:00:49', '2021-10-07 15:14:53', '2021-10-08 05:00:49'),
(56, 58, '$6$rounds=5042$615ff114a972c9.2$OPvjRP4/onlEc22HTTQ5JavPYTsSON2vqP92POaEAknoGGpRlO3ODITHGTZ.S8vhoDAK1ooQ1573IlhDZNNbD0', '2021-10-09 03:18:20', '2021-10-08 01:19:48', '2021-10-08 15:18:20'),
(57, 58, '$6$rounds=5042$615ffee0c86371.2$jAG9VFEVEb16mjjmaHJPL9G0f33j7bUbcrtJwaGN1a.cy15ZUFeCR0I4AAnpcvdBgNQv22uH3YQlOYFciwFj50', '2021-10-09 03:29:39', '2021-10-08 02:18:40', '2021-10-08 15:29:39'),
(58, 35, '$6$rounds=5042$6160a24652ea76.9$K9DuEBMD5PUqLgp4AxPTJ9dWBEfmUQtwCrlMljXMb8yGTxsMvWLGVEFylMycVbgPLLSQ4SU5QtgYNSidgRweI0', '2021-10-10 00:40:24', '2021-10-08 13:55:50', '2021-10-09 12:40:24'),
(59, 59, '$6$rounds=5042$6161d8f209a537.3$FiES4qP3NL5avWkaed81Cg.UkoCgj5NwWwTk4DUlUG18MlIrbKgzxOD3qrb9rMZ1JFJuQLbfMhlHWFiPvs/Wc/', '2021-10-10 13:03:51', '2021-10-09 12:01:22', '2021-10-10 01:03:51'),
(60, 60, '$6$rounds=5042$6161daa77f5d57.8$kf13LT6QaEhO/cqPDFFkE/AQNjRqSt2j8zM6IchQ10Nq0OfpAO2DG9ExiqQ9M0/XA6IIe2dXUnbwdfJcLFcau1', '2021-10-10 13:47:35', '2021-10-09 12:08:39', '2021-10-10 01:47:35'),
(61, 1, '$6$rounds=5042$6162572065c0e0.2$vWimRrmXr65GNRNcqIQMfbiBVMaW9Zf0ZgoBB7xcz40oX5hfywzgziCy.vqdPh2tw9j1KxqRtn3654H/B1UF70', '2021-10-10 21:59:52', '2021-10-09 20:59:44', '2021-10-10 09:59:52'),
(62, 35, '$6$rounds=5042$6162960ec4c409.9$Rw7zjZhzUogFc9uLfcccsF9YDwIeyYKYl..J03B.N08yHxniA3QsHzpdcusrBnqQ6H5EH6qrtFzOfYECrVlLA/', '2021-10-11 02:59:24', '2021-10-10 01:28:14', '2021-10-10 14:59:24'),
(63, 61, '$6$rounds=5042$61632d07559d78.1$VzJ/Kd3GSK4Js3slWEjEdV8xB48I2INiuu1eIXTuo8ZQS2FUq5kMVfJaQLnMZHSjk174wiuXewXI.4YJdkGHP.', '2021-10-11 13:58:42', '2021-10-10 12:12:23', '2021-10-11 01:58:42'),
(64, 62, '$6$rounds=5042$616349854a1038.0$ZkclljyVDc8dx1GCxU/C3oBt5sBW9C7U5ftYNL6ifgvREDya/PcJAjBnI2MjCl5Pde1pvyjovtL4oCRzrrYQO.', '2021-10-11 15:47:42', '2021-10-10 14:13:57', '2021-10-11 03:47:42'),
(65, 63, '$6$rounds=5042$61634bac796c55.1$t1lrGRqS/IwebkkuC6P3EMMLthDdZdi4Za1IB3wNElRBSP0sJjk5snmUpx1BO4XfVwzJljK7ghDUKnvbLg2Wk.', '2021-10-11 15:47:52', '2021-10-10 14:23:08', '2021-10-11 03:47:52'),
(66, 64, '$6$rounds=5042$6163bc14677b29.9$DBFwiqF2T7cpk8VjY9mfqf2.skKkNnjU1higokbpOBU92MobJRLNwGnPDracc/zru0WvuZLdheo1km2qjgi/a/', '2021-10-11 23:26:20', '2021-10-10 22:22:44', '2021-10-11 11:26:20'),
(67, 65, '$6$rounds=5042$6163d9f65e5915.7$XIXD0LX3wcLedtX17ih541M7GlcLYmBR6KANSRO7Pt/bYqaT6dTVVPynsoT/wIfMS.78NNe5EzfHMKQ8MvKBt0', '2021-10-12 01:40:00', '2021-10-11 00:30:14', '2021-10-11 13:40:00'),
(68, 33, '$6$rounds=5042$6164a8d9858167.7$SPPF5XG7w/ur7ELBoMnbjRp1vrAmn4YC3errXf1uKppNJhPh2KKdiYneg.1LAqCSekLtI/c7qgK7Du7hj2ZFn.', '2021-10-12 16:12:58', '2021-10-11 15:12:57', '2021-10-12 04:12:58'),
(69, 66, '$6$rounds=5042$61684a5b7760b2.2$/OwVIk8fqEX9DlY/F7L2JxIOxj.DGE.XbXnC5HW8vUjUj04egwCAztzHT77bzLpYd0jaKzZ8KjlkMGckOjEAu/', '2021-10-15 10:19:38', '2021-10-14 09:18:51', '2021-10-14 22:19:38'),
(70, 67, '$6$rounds=5042$61698968bff832.7$WJXQK6HGE2lAalHlim2It732f/AeG5DeDeLsVA80PL9b0Ub5cEa5kHkaLYSYIc5gIpKizI8wo66KtDRzMhqT91', '2021-10-16 13:56:35', '2021-10-15 08:00:08', '2021-10-16 01:56:35'),
(71, 68, '$6$rounds=5042$61698f1ede4dc9.0$4bQ0Z6lkyLqxFo3hl/JtbRnFVT4hK.ZBFIA80WKfs.9urDmavktpDC6ZYPjytovk6XEXe42CZUPEuP6t/oosH0', '2021-10-16 10:39:11', '2021-10-15 08:24:30', '2021-10-15 22:39:11'),
(72, 69, '$6$rounds=5042$616a8149afb490.0$vMBtMl9812QEDeo2VruG/SyOQ.Da1ItlxqeYn2YIKxmAVbxy/Xbax6TyWC9RT92TuQbfoipg0Ra4yIbEZLs5v1', '2021-10-17 02:54:49', '2021-10-16 01:37:45', '2021-10-16 14:54:49'),
(73, 69, '$6$rounds=5042$616a9e8a9165d4.3$4Z7jt9KEOhBTSM8ckKOKB1hOEcY0ZGYlW7JB5UnUEy.I2y22LnQymGKBk3baFmZroo0UtUSEbSbY0vyDUbZNj/', '2021-10-17 04:42:35', '2021-10-16 03:42:34', '2021-10-16 16:42:35'),
(74, 70, '$6$rounds=5042$616ac4c3e27ed8.6$Ll4qe6jQbT6wfL8fXiqY/3izmow3044x7MfbzpX0SOUv43DXgThBzlExI624swHxWAzazTQBh3AyOE8lxqf0X0', '2021-10-17 07:38:30', '2021-10-16 06:25:39', '2021-10-16 19:38:30'),
(75, 71, '$6$rounds=5042$616ac74342bfb8.6$r2fcJoZnRRVBjQfOZPlqVk2WcBWiM9yXWNOf9y.KEas6JI8lkEYCgB0SIP3HiCbe.zkhZx8jf2JHzNN8m2Bfo0', '2021-10-17 07:40:08', '2021-10-16 06:36:19', '2021-10-16 19:40:08'),
(76, 23, '$6$rounds=5042$616b066705c391.4$SAOTfri6sCO9Rym7J0wM6fnn9gj1T6yeNKMGumZjawQjy51/uprwJauxcMnLP1e.xnEG.b4myQ7zY.1cTICDz/', '2021-10-17 12:05:44', '2021-10-16 11:05:43', '2021-10-17 00:05:44'),
(77, 72, '$6$rounds=5042$616ba1934e2e14.3$1aldq.vRxaKfZielANkZ1kv1yepLMUUBorRe1NnHcODoUYWxOg4ffEY9/LWz0nZUf1.IW5EQK/wmmTlOL2ANu0', '2021-10-17 23:14:10', '2021-10-16 22:07:47', '2021-10-17 11:14:10'),
(78, 73, '$6$rounds=5042$616ba83509ef26.3$WwrxB49M4ib3Hn1srsRY4jqTBiN6D2/uvR8BOHC3V9F7OS9y7qMvJyZZg8BEWPE904Vp5zgYtZGC1M3Zy9KLl1', '2021-10-18 09:34:06', '2021-10-16 22:36:05', '2021-10-17 21:34:06'),
(79, 45, '$6$rounds=5042$616bb968c45998.6$VMwmS03HfnoN.XmsX9ETMHdsYAGycibHpJaKW3U.Ir0YrOIKHvnegqUni/d3GZL56c4HlOxhB5PveKaROIA56/', '2021-10-18 00:49:29', '2021-10-16 23:49:28', '2021-10-17 12:49:29'),
(80, 74, '$6$rounds=5042$616bd945854c86.9$TfG4jmpt.ueZqfS.RsoIrQ1bjfEqmMHh5BNknA7alCYTYcrqw3pWrjQrBqeeyxG2mOzSyjXIQiI7u/gvA6iTC0', '2021-10-18 03:06:07', '2021-10-17 02:05:25', '2021-10-17 15:06:07'),
(81, 75, '$6$rounds=5042$616bf1696701b0.0$m9IThxQtaFt95/BhJ01RNKstFsqYfyv7V8JSWLLQJkuhP6.Cdr4.4rqtCOV329avJOjQFBgGOBbmh06nQ0goB1', '2021-10-18 04:49:37', '2021-10-17 03:48:25', '2021-10-17 16:49:37'),
(82, 76, '$6$rounds=5042$616c3471b10d17.1$ozsiLbmL7O6Kb/H7lB.rl936RjbhVuwkpbUawAVuQ6O6a/p2QcHpTi.j6iBAF17QnbCG.K9tkH9qOazgyLMOp0', '2021-10-18 09:35:02', '2021-10-17 08:34:25', '2021-10-17 21:35:02'),
(83, 23, '$6$rounds=5042$616d1277c172f1.6$R/tltQdWJdzRojrTxcJ6g3uV0o1FsG6ookJjDiTcP0UHqrcb61N8VqlR63DcSqRtpKj4C2w.8uaVpEUqznIhx/', '2021-10-19 01:55:11', '2021-10-18 00:21:43', '2021-10-18 13:55:11'),
(84, 68, '$6$rounds=5042$616d246eebcfc3.4$H/Vpbr.lCeKDijyHNgEcBYfStb38HDwq16zeo7Y5j/nwZzoLL.CB3orK6Pllvi/T61UYXuKLs7h9sNImC/zlR/', '2021-10-19 02:38:24', '2021-10-18 01:38:23', '2021-10-18 14:38:24'),
(85, 77, '$6$rounds=5042$616db9e46bbbc7.7$J0YWGPWAVd7SJlnSVCj48CyxnrS1z1.09iUCnFBNOX7uHH8h2eo/vpEiEYjE74YAZ/Dm/Pub.GwcJsNdWEjI2/', '2021-10-19 13:18:25', '2021-10-18 12:16:04', '2021-10-19 01:18:25'),
(86, 68, '$6$rounds=5042$616e5d38234176.6$CB1kPWc9ylpOzzaIkrhVsoVGYZU4ZM3WolddkHm7B1MwZnuJSCsO9iOW5SxrpdDxbhgr9s04k8kc11tUhi8xA0', '2021-10-20 02:40:43', '2021-10-18 23:52:56', '2021-10-19 14:40:43'),
(87, 23, '$6$rounds=5042$616e5d78b3d792.9$Bzlc5XuWhNHc8gYG3Us5Ye9EK9nWNFAWS8SjsS0UfMn9pkxFdK31Q7w8T0W..5xypYugsPKFyCjecWvYS8tVp.', '2021-10-20 00:54:23', '2021-10-18 23:54:00', '2021-10-19 12:54:23'),
(88, 45, '$6$rounds=5042$616e82f8ebb950.2$T7hK3LlVpJVrl095UXNG.SAq3Ww8ceDxKMwNW.XGOHKWQCuSRhFh4XsvbT5LSZRXu868JRskJDUuPBy3C7BjM0', '2021-10-20 03:34:26', '2021-10-19 02:34:00', '2021-10-19 15:34:26'),
(89, 68, '$6$rounds=5042$616e83ef935a02.4$xbuccdUYHj/iX69qAUaz2dhxKEakSJJIiY3MsXGUFA57Pjtx5obWwNxnt6GHEakERcinNJYsWHwmgmc/0opTm.', '2021-10-20 03:38:27', '2021-10-19 02:38:07', '2021-10-19 15:38:27'),
(90, 76, '$6$rounds=5042$616f77e074bf38.0$STpL2scroDTuEmx22ZmKUvAbuNQebU5qKaUVxP78hKyfZlf5KrK/5euLBmyFXQ1nGTMJDo2LIG1TJ29QYz1lr.', '2021-10-20 21:17:32', '2021-10-19 19:58:56', '2021-10-20 09:17:32'),
(91, 45, '$6$rounds=5042$616fc45fb7e519.8$ORqzT/TY.x6KhaPO.Wx0MpnV3fJFc7K4dSoeuHIcFYu69bK9N4rxQ8IMXtcGkVBvqL3WJJRjqCsQJGWJtbgMC1', '2021-10-21 02:59:14', '2021-10-20 01:25:19', '2021-10-20 14:59:14'),
(92, 1, '$6$rounds=5042$616fcc9850a653.9$Dmb1uJka9wpcwiHua51.CJHlae31VlmQWmUplNClgH820eTXIqlLLANo.PSNGADennGzb.Vg27mYUGl2eulCc.', '2021-10-21 03:00:56', '2021-10-20 02:00:24', '2021-10-20 15:00:56'),
(93, 45, '$6$rounds=5042$616fccca293af0.0$dwOynx1HVGqJT5JU41wYnU3gCkEPr/PUJtKeSvHZ0Ib9jflVx7jlnQ6OnmFEphWbbe3bhzo8lu4z0ul6Zj1gp/', '2021-10-21 03:11:58', '2021-10-20 02:01:14', '2021-10-20 15:11:58'),
(94, 78, '$6$rounds=5042$616fe3e4b7ccf5.7$JUdZcReRPWa5w47B03q.I.t2X.8nlNrZNYsznSxMncQPf9pSrxxcWBCj8FmUkmtlKj34SS5injwZ6ZNIn26vg.', '2021-10-21 13:11:18', '2021-10-20 03:39:48', '2021-10-21 01:11:18'),
(95, 23, '$6$rounds=5042$616ff23f8084e2.6$R1a6lMQbRrUATjFWTqiMFcufBeLnvR5QjMeAXtsssZkvy0RScsJxsH5yghoQgyL.Z5AVruf1ikHeDYl.qH3xP.', '2021-10-21 06:33:49', '2021-10-20 04:41:03', '2021-10-20 18:33:49'),
(96, 79, '$6$rounds=5042$616ffa8a414d69.9$yQZ85N4Mqi55HwiBf4IGth/SAykY38rK216lWnihRT4UUUyCldwsmNsSFLtxm3vPrDfyPhU3cifaFswbhCk4O.', '2021-10-21 06:16:41', '2021-10-20 05:16:26', '2021-10-20 18:16:41'),
(97, 45, '$6$rounds=5042$6170045b0ab357.4$euEhMlRylbKLcXeKdgTc2FqFBmxUzOu7XAjqJvg7tcJAYKE121qIISP5cngNQB.bRpZx624Ie0TiqaqucjjzQ0', '2021-10-21 07:01:20', '2021-10-20 05:58:19', '2021-10-20 19:01:20'),
(98, 1, '$6$rounds=5042$6170054380f2f2.4$OKk/dT.YNESeDRebUJ09a5Sswr9POeoNyBTAKn.4fSibXIsJIRYmLNd4TNi8Jw2bmnkqyV49tAzsI0n5jGdGa0', '2021-10-21 07:02:20', '2021-10-20 06:02:11', '2021-10-20 19:02:20'),
(99, 80, '$6$rounds=5042$61714c98b462f9.9$a5h17LYyLWXrMOdqWwM7s53oJHG4NK2.Hq33vRdd97NnG9LsjpucZ0M9lyL2YYH9WeNZYvJ1tgwrqmINSSzyz.', '2021-10-22 06:18:49', '2021-10-21 05:18:48', '2021-10-21 18:18:49'),
(100, 81, '$6$rounds=5042$6172156e95ab88.5$.6oUFR08fCnXPEcOSJftcv9/F/q6x9PecrRWX3hk.Qgecz/0V7bLE.RXxPZ6tKZrMUnW6Ws/ZWyseRVI7O9UD.', '2021-10-22 20:36:56', '2021-10-21 19:35:42', '2021-10-22 08:36:56'),
(101, 82, '$6$rounds=5042$6172dfc74cc918.2$N1zZfAnbMd3HmSzqZsKKysCRb0oXWDfNQw7AZ/iOcHZZynSYm2SbieifmHB9sEXXUnjZnt2vxBd.qs7HCNGFt/', '2021-10-23 10:59:03', '2021-10-22 09:59:03', '2021-10-22 09:59:03'),
(102, 83, '$6$rounds=5042$6172f8845d6fa9.0$dpqfL6AiKC1PL4NqKnPsqVrJBRD5pBaoqad2cOpi3kRYOTJxqbaHDpoeSTQGQxnMC8ZTNOeQ4.cGCLWDITONm0', '2021-10-23 12:47:10', '2021-10-22 11:44:36', '2021-10-23 00:47:10'),
(103, 84, '$6$rounds=5042$61743712198682.4$9vXkqlqBh3I54m7NCCuL2LGJEej6NRUzYN/j.5JSApfMcFNM6PiwMoxQ1Cr8l3fObllla2Z.kGYJyVeFI54sR1', '2021-10-24 15:02:30', '2021-10-23 10:23:46', '2021-10-24 03:02:30'),
(104, 70, '$6$rounds=5042$6174f88e8ad278.6$FBuNF05w5V09ohPz5XBW.EaQaL3j7H5//Vo4yleOVv3Ipl8R4sucuVY4ssBnPMuKNPzh/b1vI.66cdnP97Py7/', '2021-10-25 01:31:09', '2021-10-24 00:09:18', '2021-10-24 13:31:09'),
(105, 68, '$6$rounds=5042$6174fde98f3b84.0$Qtc9l.lzd7H5B25tmzn9zAJp219ttBH78rL1cXThzbqOIxRnkp6dbITrHibf21I2f4Bmc6a4EEOtTJw3EHEr6.', '2021-10-25 04:50:54', '2021-10-24 00:32:09', '2021-10-24 16:50:54'),
(106, 23, '$6$rounds=5042$6174ff08b5bf52.8$YsHF9cJEF9fLS.rV8.CiMElhxuVy3JD00hgRL0DKDWj3dHYDvV3Qm8SOmkSZkLiQBKzULq.gYLuwLBVLeIIq21', '2021-10-25 01:37:09', '2021-10-24 00:36:56', '2021-10-24 13:37:09'),
(107, 45, '$6$rounds=5042$617500bdc9a241.8$J12pIzrlEIx1FNkXm..vohTgz2S4lv9.EQKlkuLRrg8k3tKYjnFMl4Ijwz6a036k0YcPFLs3IhJMBHdyAJ3ra1', '2021-10-25 01:44:14', '2021-10-24 00:44:13', '2021-10-24 13:44:14'),
(108, 35, '$6$rounds=5042$617516cbf2f752.4$Q98M2LVLnR0mHgTtJnCQdrGQUkIy2hIOXDbxAvWtCVV6MskvncCT.t.bxpjn38MsuPV9JScshYHwaEsNABDhy1', '2021-10-25 03:23:26', '2021-10-24 02:18:20', '2021-10-24 15:23:26'),
(109, 85, '$6$rounds=5042$61751c77f01ea9.6$MPg0etxjz23CePOPYzUkrGAd/ttiZ2GFmYYvYYg5yvflcOYMTFUxzS5IYOGO7DI5AoiLkwfZRSF8Fx2046eh81', '2021-10-25 03:45:12', '2021-10-24 02:42:31', '2021-10-24 15:45:12'),
(110, 86, '$6$rounds=5042$61751d014b2bf8.4$Tb4UtV4lU.i3PpjDp8T88r6hJBJyn9JbCc0Ke116fjYLXaj51HauSAuCaKsoOcNQmW/vS0ZKxKvcQxlhQCXhY.', '2021-10-25 03:44:49', '2021-10-24 02:44:49', '2021-10-24 02:44:49'),
(111, 86, '$6$rounds=5042$61751d12d5a9d1.6$GMMJhS5KkitTx2c2V5Kg9k/3fCi.qTUrajze5cMRh6SnqF39rqhJiz6ib64dwoFyFx582MEYSMEJPJGXI6bLe/', '2021-10-25 03:52:04', '2021-10-24 02:45:06', '2021-10-24 15:52:04'),
(112, 74, '$6$rounds=5042$61757e33156793.5$UoZWeI5SuOIT/T/k6lsZZv1WzmWby3UFKabwOm5NBcLUUSaXLdBFUt1fP05q/tIocivAi49yc98KgcH8R/F8j0', '2021-10-25 11:08:00', '2021-10-24 09:39:31', '2021-10-24 23:08:00'),
(113, 23, '$6$rounds=5042$617633e806acd7.0$aIlyE//t.koWx77NtF4Bf6s3LBPmiYK6jSRhs4l1y0.xZToM54kekbwsRqyZiySMHAEyv2CGWGrBPMgNUTsXn/', '2021-10-25 23:34:49', '2021-10-24 22:34:48', '2021-10-25 11:34:49'),
(114, 82, '$6$rounds=5042$6176b2f4a00913.3$uvRdIQjQSsYvQ/yLgvGRFfWgkjjSQglxXYraY938EddEM8f6x5ARBnxyHfB0hUkAyNGFdMT2XGmlN68HqzHsX.', '2021-10-26 08:36:52', '2021-10-25 07:36:52', '2021-10-25 07:36:52'),
(115, 87, '$6$rounds=5042$61775150d84545.9$0cCkEcKqxphr/u72EgJGwv8oAnCHetCNhE5R1OWRreQGWNcGcO.J794ZqKqFxLs4ntsLIU01hb7wpzYSrFWza0', '2021-10-26 19:52:32', '2021-10-25 18:52:32', '2021-10-25 18:52:32'),
(116, 88, '$6$rounds=5042$6177a6f2234aa3.2$EwZjHIRBPQ0zfpa3nn4ta.G4Gsyi980dLN9Q2a5OJ4XOAiZTAZlmW/9NV8nI3YHHwgJWQiF3CF0dhazxZW1TW1', '2021-10-27 01:58:57', '2021-10-26 00:57:54', '2021-10-26 13:58:57'),
(117, 89, '$6$rounds=5042$6177a727849605.8$6td5s7Z5xPdHXmcwySDW2Q6cWSGoPyLtL7Dnmq/tdCiH2SlcT7MIPM0HOlkVYCnKLj6k26L5mhQ8r/vHbpqA.1', '2021-10-27 02:08:58', '2021-10-26 00:58:47', '2021-10-26 14:08:58'),
(118, 90, '$6$rounds=5042$6177d40cdeb961.6$IGj584LJFGOBecb1ZREJNU0ATEThwvO0YTPSJ7e/yzDl/PmsjalUmKQQ13PggTDeRsuU2.lIqqz1NaqBh02A.1', '2021-10-27 05:10:20', '2021-10-26 04:10:20', '2021-10-26 04:10:20'),
(119, 70, '$6$rounds=5042$617910050ab1a7.3$V1PAI43g7hVJeyegzjeUOGsrRS0lcsfjf6YYmk6pfxEsISRPkp3qKpYeuGJ89wplT5pDpJgqRtw11VZBwQLAg1', '2021-10-28 03:38:32', '2021-10-27 02:38:29', '2021-10-27 15:38:32'),
(120, 68, '$6$rounds=5042$6179124f3f11e2.8$AeNYrXC/NLvRRPMd35xUjMwOhqcsH0lqh/do.WNGwB1dCJLnAlPOkmUgZ7lO0kL0TwPL82Q5Y4amXEh888xan1', '2021-10-28 03:48:16', '2021-10-27 02:48:15', '2021-10-27 15:48:16'),
(121, 91, '$6$rounds=5042$617985bd6ba6c3.0$LlCIIvaXdLd1CeYkR8E4xcIqgE9sgCvxIttWLgsNnOvbEhZFRSPK14Tqvf64DZ9Fe4LhXIg5gkWAXb7fhuc0r1', '2021-10-28 12:17:46', '2021-10-27 11:00:45', '2021-10-28 00:17:46'),
(122, 92, '$6$rounds=5042$61799cbf23edd1.8$kB2IF7TDyCVco1QifznNiU30QgRckRaz4AUG/jyHSY4NUespqD6JGvSCcwZktm6MkCku2z6g4arr6b/U5QO5s.', '2021-10-28 14:27:50', '2021-10-27 12:38:55', '2021-10-28 02:27:50'),
(123, 93, '$6$rounds=5042$6179a373b1e033.8$WXahDHcx3RuEgFgMBcMp7oD9enTaU0AZDaz2TpqBuNuGgkLwXeNOXGUXBI5yJoUlNHvhctVW8y0cDijTjYxRr/', '2021-10-28 23:12:13', '2021-10-27 13:07:31', '2021-10-28 11:12:13'),
(124, 94, '$6$rounds=5042$6179e34a478484.8$XKp2aYG9K1AXRbQJWV0ADfVZsh5b0k2Q4iLZl4TzcxD.48weuypV9Yv48H0hdwTcpsnS4s6TaOkti0he1Dliz0', '2021-10-28 18:39:54', '2021-10-27 17:39:54', '2021-10-27 17:39:54'),
(125, 95, '$6$rounds=5042$617a60cd6b7fe8.0$lBAqzYWm8cbmNMyJiB82mLBxXJsm8dZFcZApuaIq7AWKDsDVQlpEL9qU07V3lT5Y/kAIgfDZXZiSYGjD3ZSTg.', '2021-10-29 03:35:42', '2021-10-28 02:35:25', '2021-10-28 15:35:42'),
(126, 65, '$6$rounds=5042$617a614235d138.1$3LTn7kTgub4x5c2JSOfbOxTqQ2iIcVawxfQDCOTpBxL5jYVGzb5AuuBe9e8b82zPgnWTv5ISAIqLk2mRzQ9qD0', '2021-10-29 06:03:21', '2021-10-28 02:37:22', '2021-10-28 18:03:21'),
(127, 96, '$6$rounds=5042$617a6498f2fcc3.2$a/MV.yUdSSoL8nlrgll8FNy2SssGiHEkVoBb7iVvvjMSp4z7myMYOGvNZ7fLzI8VoMf5vpg1IVGJX3Q7/Wo9j1', '2021-10-29 03:56:21', '2021-10-28 02:51:36', '2021-10-28 15:56:21'),
(128, 97, '$6$rounds=5042$617a812f81bd56.9$mXOIWXaJTwbSAqzdVRR4jm/HOdbNeoQ7hPAY5AWy16j5x.hCjYFYqT6lfVRKpA8afTrx3o7KYRQ1JqZYeLaMj1', '2021-10-29 05:59:24', '2021-10-28 04:53:35', '2021-10-28 17:59:24'),
(129, 45, '$6$rounds=5042$617a8bb61e2011.2$evfoyS1OaKQVG5r2PIjo3zYpR25i3Yr9j6AKrXbGo8qm5ujw/AEE9owkDY259VAkP4YN29M4ZFEIvlnGR535c/', '2021-10-29 06:39:33', '2021-10-28 05:38:30', '2021-10-28 18:39:33'),
(130, 45, '$6$rounds=5042$617a8de1529d14.4$GGNq1sAArBGqRWag3jTvS5REAOobN0ZuBjaCe8RzaopdMSwWBpmcYxX8ultLNw8SdGLEjon4FSCWcjLNe.Kwi1', '2021-10-29 06:59:35', '2021-10-28 05:47:45', '2021-10-28 18:59:35'),
(131, 98, '$6$rounds=5042$617a9e89214913.9$UlnBCyeLZOgqkh8hrUrL.obngkSQMpS0OiwB3KMngle/iDZ55dBcxyObEiS/ybVgsNrmnfzQsTAVYmxmp6tcb.', '2021-10-29 08:00:45', '2021-10-28 06:58:49', '2021-10-28 20:00:45'),
(132, 99, '$6$rounds=5042$617aa561d197e7.9$S0bUlMIp8ZpuOaJbrV4Jufyfdi5Lt3p1VDcxUsYf8iZvzkxNrvwsNOGzIJR.YVPRvjSwHMJsEpD.DLHzFCy9r0', '2021-10-29 08:28:01', '2021-10-28 07:28:01', '2021-10-28 07:28:01'),
(133, 100, '$6$rounds=5042$617aca5a6987a1.5$RJJlA3HWQeWEaEW6XkHuzmBsSxnS9fph3NKPw9f0oCqNyUB6B82S9dJUGoIC3qTZCKayJWVouOzD6sKsBP1VJ1', '2021-10-29 11:05:46', '2021-10-28 10:05:46', '2021-10-28 10:05:46'),
(134, 101, '$6$rounds=5042$617adaed8a0874.0$SYIiArGlQWMAd9qg5SXU8y3aY7dlzZHTzbMW2Zij8SASzjnRJP8B4M/darlyfMmMY.Kh3wRhySsZT.rv/nHMC1', '2021-10-29 12:19:07', '2021-10-28 11:16:29', '2021-10-29 00:19:07'),
(135, 81, '$6$rounds=5042$617addf8d88908.6$0/9YJsk1/sHBM9IvYHeFgLhZZ0wBw/6VcvS4FtO58Whx1VIw5yMiyzV5MWDfAOOw7RlA4zy0XC2bAPPLAmpAB.', '2021-10-29 12:30:09', '2021-10-28 11:29:28', '2021-10-29 00:30:09'),
(136, 23, '$6$rounds=5042$617ae595cb0c27.3$Lapsv.6YNwN2R3IG.c9b/SXuhqna1RdItrfYVFjvnDvCaayx4TSfn9OjAafkmaLBRpVNlYuj7k.wuRksScECu1', '2021-10-29 13:04:53', '2021-10-28 12:01:57', '2021-10-29 01:04:53'),
(137, 102, '$6$rounds=5042$617aeb4c82a421.2$RchkJQHJy17TbkR3PG/HvVtyLZNAVhk2FMDkl2EYcN1nmswyrMoNLPOpWmvXUVq/Eju128qo.f5WlM0abJUZy/', '2021-10-29 13:30:32', '2021-10-28 12:26:20', '2021-10-29 01:30:32'),
(138, 103, '$6$rounds=5042$617aee32df51d6.2$0XbqHlD.U0lFe9ThrIgVQkc9FQVYUkU2WHYudtWfV8ACXOQLFxtaZ1K9qnGUz5AdWNbrQcjtYcyx5nY1SCI8v0', '2021-10-29 13:42:00', '2021-10-28 12:38:42', '2021-10-29 01:42:00'),
(139, 104, '$6$rounds=5042$617af53e7ba6d2.7$O8R1wULCJ00S/yxFB18E3pZvKKQtHOcV9OhNrDto1Ep1OjBJqadUGfiM.W8QxRLr7YX3h6lKEs4XyASQFlXBx/', '2021-10-29 14:11:39', '2021-10-28 13:08:46', '2021-10-29 02:11:39'),
(140, 105, '$6$rounds=5042$617b258a0b1a79.4$xad2OjUD2U0fT.Qv4A5tjmeV3/96lphx6UZFSSaPw7rqRQRPEeeKncBj4oO210NRxVfVz1nlHV5NRk1IJ/wp//', '2021-10-29 18:50:41', '2021-10-28 16:34:50', '2021-10-29 06:50:41'),
(141, 106, '$6$rounds=5042$617b436f696ef9.6$fe2Dfkb4Vz4QlFeEM48r1z2h63ONgEb6W7FyuC.hwCOt0misaKtUMt2WpOB/Kl1S3.13SpeFpswbILS4tQ9qo0', '2021-10-29 19:44:06', '2021-10-28 18:42:23', '2021-10-29 07:44:06'),
(142, 65, '$6$rounds=5042$617b8edc349769.0$yrLkPCYJT1t5qMG5GpwtuNW367MZfLNoWNZ5dLZqRYbwH2zjJ/hfyha45OvFIMcvqa92.eMeytuPU9ndKwM9U1', '2021-10-30 01:05:32', '2021-10-29 00:04:12', '2021-10-29 13:05:32'),
(143, 45, '$6$rounds=5042$617b96c4c11b93.4$9oAIo8DHUxAozP2cfVfGxn9XEb2El2FdXWCT9aqcxrs7aqcOUzYIkvt8X12N7b0um/6FCVXlK5qbLoEFXnq4.1', '2021-10-30 01:37:58', '2021-10-29 00:37:56', '2021-10-29 13:37:58'),
(144, 107, '$6$rounds=5042$617b9816ee8b95.3$xUBj83jznyQOSDqnjOMmgkLeKh8leYDRNVOm6MondneSPFP/YY8/ajGH9d/pNsVTs.aIPLWZMmW0/g4PPG/.L.', '2021-10-30 01:46:28', '2021-10-29 00:43:34', '2021-10-29 13:46:28'),
(145, 108, '$6$rounds=5042$617b98c96748d8.0$PN6ePWZ18ohqj4P2uXlYh2gOK0t3qmFi9uePNQZdq6uDd/B3Jik0IvP6t4xVqhfJmG1U7b6TSF5jRLcCq/vrI.', '2021-10-30 01:47:08', '2021-10-29 00:46:33', '2021-10-29 13:47:08'),
(146, 109, '$6$rounds=5042$617ba45cb64805.2$UxSQKa5mh3Bra4gmk2iKLU.AZMv/Nx6ANKSBe6zD0XltiEY8VcGKcNol/YsU9MjG9Ivdduhsks74wUwNKKhS/.', '2021-10-30 02:39:52', '2021-10-29 01:35:56', '2021-10-29 14:39:52'),
(147, 72, '$6$rounds=5042$617be028211a88.4$iIELo2RF7zIFGLJO/wQHNkqCq.n.kbJZGr3MSnjRDMEc7f4nzvkkrVYQ/FEaRRg/mDcOCd5ECqr3BVdZ.Ky5L1', '2021-10-30 06:51:04', '2021-10-29 05:51:04', '2021-10-29 05:51:04'),
(148, 72, '$6$rounds=5042$617be0295e6fc6.9$HDKeeF.5FT0XQCTcMu.nvJQNiMM2sVceTo9bP/tPBPYbpuxJtrgmKV8mpFQvM0L3eE7p2pThc5tjTgINIt5AQ/', '2021-10-30 06:51:05', '2021-10-29 05:51:05', '2021-10-29 05:51:05'),
(149, 72, '$6$rounds=5042$617be02a21d7d5.9$DRMmM.i6fbr1quDen1UDVB2LNYru5xuywyLzPyy98aNviXFve.AB/NfvG7k8RfLttomy29GDq6dv3vPZUKd9T.', '2021-10-30 06:55:29', '2021-10-29 05:51:06', '2021-10-29 18:55:29'),
(150, 110, '$6$rounds=5042$617c18c7539836.6$nPGbkw8ApozJY8wbccegsQzCAiDu./nmHi2e.jPgv9xXwWDVq3spTCWIIz.B5a9ggnM3y.J/mcQ01y1QIq1Lw.', '2021-10-30 10:53:47', '2021-10-29 09:52:39', '2021-10-29 22:53:47'),
(151, 81, '$6$rounds=5042$617c87895cd283.1$hsSdv0u21jaVFqoLtYAZ7bc8mEbjy6NtWm3n3JzIfO7YJKh9.Kpdq6jR.YU4l6p2ECUg2RVmFE8zhSBnQnT1z/', '2021-10-30 18:45:14', '2021-10-29 17:45:13', '2021-10-30 06:45:14'),
(152, 72, '$6$rounds=5042$617c8c27281d25.9$C9TZNgkpcn/BFXmoRo8bAvPP0gP3HxjpBRRXEamcE4omMaiBK9haDxnlRvoekU2mrYTNz3yS.buzrHaclXfUI/', '2021-10-30 19:04:55', '2021-10-29 18:04:55', '2021-10-29 18:04:55'),
(153, 72, '$6$rounds=5042$617c8e20d13776.1$5xT97Ph/GkLpR.OvsxI3eRMqdEufvQ6mWa.djH.iBrijRUiI413b33rmR8DAOTq7DOX4xesRfeuwhthL7NZXw.', '2021-10-30 19:13:57', '2021-10-29 18:13:20', '2021-10-30 07:13:57'),
(154, 111, '$6$rounds=5042$617cce446525a1.8$Q/BukGDI4fp6CMJ.vmPvi.5BLnqwGPFzOuV.8wdWr.CYmp43fwsV7uSiVsI35bIQeyODds96gcYv9688S2XJ5.', '2021-10-30 23:47:08', '2021-10-29 22:47:00', '2021-10-30 11:47:08'),
(155, 106, '$6$rounds=5042$617d3da2577ee3.6$TJLcPVxPnWksJyEjAi6vwCuqBIyOioHw5EcrOmuIAgRJ5CsH.pLYjqWdOukQVosz..GRuWpNB9ug/j3/OI/Rx0', '2021-10-31 07:42:19', '2021-10-30 06:42:10', '2021-10-30 19:42:19'),
(156, 112, '$6$rounds=5042$617e47094448a1.4$.2cWIQ9mgh/DeCGy43zjfGUw/B59Q1awb2jiWcx96BqzXgLfRJFOB219sSB0BZwGcSMSvarT7lf7c2RkfSjZ01', '2021-11-01 02:35:03', '2021-10-31 01:34:33', '2021-10-31 14:35:03'),
(157, 89, '$6$rounds=5042$617ec53a811694.9$4Ye4kjpQe8A12D92rNobcPRAzZ.yyQm4H2ENH/8NWcnrkjPIxNqyip8cAW6XbAIAN/yb6IpBUdcpX.S3CL0ln1', '2021-11-01 11:33:57', '2021-10-31 10:32:58', '2021-10-31 23:33:57'),
(158, 106, '$6$rounds=5042$617edeb6b57cd4.4$n1FbjNB31kMygyHt9MlUOAPLmKbkg9QCBIzwzO1OE1eVaiF1bFFsYVE77RrC/C.XA1X/Jd2z1RBNeWMV7NSke/', '2021-11-01 13:24:16', '2021-10-31 12:21:42', '2021-11-01 01:24:16'),
(159, 113, '$6$rounds=5042$617ef02392e6e6.6$Us/JWAYGrGKob2tcdl6TENcz5eYShKvzUe4SCz2.yL3FbqwJTaeKHYjdqnfUsGsQ0cTpVJHS5PCWBRkBgZ1kB0', '2021-11-01 14:39:12', '2021-10-31 13:36:03', '2021-11-01 02:39:12'),
(160, 55, '$6$rounds=5042$617f2a275dc9e6.7$FYxfmPdV1chZOFgw5BUSf0lNqFsBVniLOkkCh.kEk3k65mypQIXAecxWZYrXmMjzYZ9PE8rteMFBL52VhUCAl/', '2021-11-01 18:44:01', '2021-10-31 17:43:35', '2021-11-01 06:44:01'),
(161, 114, '$6$rounds=5042$617f7b1fe85657.9$.eGVOWHa/ixjodIK/uuI8v5X.Yl68F33XbNjLY8YFlbaSQT2YXFFYe4H3VQ/zYTd4Ct6j5vcB/NOaf8qiUA9k0', '2021-11-02 00:29:03', '2021-10-31 23:29:03', '2021-10-31 23:29:03'),
(162, 115, '$6$rounds=5042$6180b1a29d75c7.2$mv6il5zb8D5q.ZMo8BHvnrT/hc1kABObOykzGYQJK3qSlwzYtlakHa/VxDhsW8gMQbWn/7m52zdheB/jfHeJ51', '2021-11-03 02:17:18', '2021-11-01 21:33:54', '2021-11-02 14:17:18'),
(163, 116, '$6$rounds=5042$6180dd7f205179.1$UeRJE4mf0x6hAAl/n5O8eo70tlJn/Ec7wbwrrAqOqepSxFSlXPXsndee.oo0NebU9VrdLzJ/56bdPwlG0Jx5x1', '2021-11-03 01:46:28', '2021-11-02 00:41:03', '2021-11-02 13:46:28'),
(164, 116, '$6$rounds=5042$6180df805fd5b4.4$T9xYtwOcs/nMzmHbztkMBhlASvP.kqMQTLJQjv7ez.vqcur8cunA6/A6aPiePwAquvtwpGKndfETqL1WphZFG1', '2021-11-03 01:51:31', '2021-11-02 00:49:36', '2021-11-02 13:51:31'),
(165, 117, '$6$rounds=5042$6180e7f6627983.6$hxC8.FhAprO/JnKxXgS7wcixsyekCX1V.Hmzk6zdb0WrFrOqS6aHtDmxciznO3ndzr6zIvMsI.rG4BPJ7f2421', '2021-11-03 02:26:33', '2021-11-02 01:25:42', '2021-11-02 14:26:33'),
(166, 45, '$6$rounds=5042$6181094e9c5a08.1$3FI0gOYjMeWM.Nzt/0mAnNmLUXy3QlqoQ1s9q607fsnLF.RCqxc9tyuh1uQlgE8.I6084xUQtt9dlLCCb/lAT/', '2021-11-03 04:57:24', '2021-11-02 03:47:58', '2021-11-02 16:57:24'),
(167, 118, '$6$rounds=5042$6181311f75c9c9.0$6d8TdTcEUBzvd3YW98pQ7WFUnGrj1Efl5kQLFGkTsGpbA1Dd9LPWG423TEPamfkoz3QWbKC1lWGHbmMlZ04cC1', '2021-11-03 07:37:51', '2021-11-02 06:37:51', '2021-11-02 06:37:51'),
(168, 119, '$6$rounds=5042$61814e388be521.7$2E1h8m/WlS/y7I7WxusWpCqv/HnkWY0P1bF3EgsWXJT4RpSL7zJxVGN5EeUgkCQRjmnRwSIvfpbr6alrHbgG20', '2021-11-03 10:39:07', '2021-11-02 08:42:00', '2021-11-02 22:39:07'),
(169, 120, '$6$rounds=5042$61814e94ed6012.4$Jc58v7ylUM.ZkRyTfo9OIx6NXAsdh./swjZ6CzZInVWmMYWa3jsP.vz5Emq95anU2yHUxcWaKoYy9zqH352zp0', '2021-11-03 10:39:35', '2021-11-02 08:43:32', '2021-11-02 22:39:35'),
(170, 68, '$6$rounds=5042$6182186a48fff0.6$7KmTj72A8lxGVSDnec3RIhBHunyzNnfsW/clW/ygfkGs9F/LjsyHTj59Xu1GRLkih9MuPtAmSvw61n3XShjYD1', '2021-11-04 00:13:01', '2021-11-02 23:04:42', '2021-11-03 12:13:01'),
(171, 68, '$6$rounds=5042$618219f8b82d41.3$DBmeOfeotJfSVkuwsxeqznCC9C.z3WloFSh1xmSFpvTjytpGtXzozTQOXHB4oIYw5Y54fIGKs0KufS5WQIUkB0', '2021-11-04 06:40:27', '2021-11-02 23:11:20', '2021-11-03 18:40:27'),
(172, 68, '$6$rounds=5042$61821b2233bbe4.4$uzARg02Uv6uEY..5h0mYkR.wxpZMLeeB9Qen1iPQPrMBJNtX7lG3.DEg3XAlsHCMJyl//ZHdDg/LsQgHHHkfr/', '2021-11-04 00:25:20', '2021-11-02 23:16:18', '2021-11-03 12:25:20'),
(173, 90, '$6$rounds=5042$618254e2853374.6$9NtZlpn7qY0rCEIn.ATtJ166.6./R9IAZ2ldyhs8bBvFEbD35X00s55CL.3XhD.1nB3dCYrkXPkp4rkEIZ/nA/', '2021-11-04 05:10:55', '2021-11-03 03:22:42', '2021-11-03 17:10:55'),
(174, 121, '$6$rounds=5042$618255b3569a06.6$xc4QUl1kKLNdlKOncYSGBcwipEKDy9VaLKVWUvMb10LpwOqNcZgteg47PJiFHe/.pNXFMbYwi7zM8Ke9Jdic4/', '2021-11-04 04:26:11', '2021-11-03 03:26:11', '2021-11-03 03:26:11'),
(175, 121, '$6$rounds=5042$618256c162c024.6$aFEqmaPDRcEbOHOiv39DnbeXyIDaAQfkxVIty5sgdqHX11Q/dLY3rsqGJ9D6xDyyGBx/XRz93a773mgG2VB2b.', '2021-11-04 05:09:56', '2021-11-03 03:30:41', '2021-11-03 17:09:56'),
(176, 101, '$6$rounds=5042$6182a50184db33.0$AyDl/r2j1waGvwKUcWGbzoiukxcJ7xE.YvAcgGu9iSAt3yky.kRpOcrACEikPZJmVwZBZfMlI9AROGQyUGCDD1', '2021-11-04 10:04:48', '2021-11-03 09:04:33', '2021-11-03 22:04:48'),
(177, 85, '$6$rounds=5042$6182cf837f2052.5$29YACcLaFCppfB.tS714NMdcyNg7BzIng5n0ZQjw2zW5hSSia299xpS4v0WF9PUwW9zAyBZAxgXQxsZ/GI9IJ1', '2021-11-04 13:05:55', '2021-11-03 12:05:55', '2021-11-03 12:05:55'),
(178, 85, '$6$rounds=5042$6182d89e8bfd35.9$hQ0tezrZ9Bgylz9.xe2LEtEp4x3ypiR/vuiltTE.kK79fjkq9L6ffv7Z21JRglw9XDguAbQEdOP6MZ82Nr8961', '2021-11-04 13:48:54', '2021-11-03 12:44:46', '2021-11-04 01:48:54'),
(179, 122, '$6$rounds=5042$6183229aec7d49.6$8SncNkCkPcGTOJQtqIZaoebwiVYyf9Nklm9ekzeQ8q4hHND5pwLOgOedjPHfB.lbntyfBaO57OtVLQNtpTUyW1', '2021-11-04 19:07:32', '2021-11-03 18:00:26', '2021-11-04 07:07:32'),
(180, 122, '$6$rounds=5042$618326a576af73.8$Rtbl2UqD1KHlfeMXn30lFFyV28Ore/PwSlZR3/N./6O1A4BbBkWVs.sqr3Z5rjnllcNBzaUAm9IXp7on18yrM1', '2021-11-04 19:47:42', '2021-11-03 18:17:41', '2021-11-04 07:47:42'),
(181, 68, '$6$rounds=5042$61835e85316916.8$RDnC9ioWI96iLiaVenjKtoFbKM1hlP08GlrRFFto0sZ0HVfuK0OFidrLYehjNMDhzHWQk/syjsnxu3dwyF1IZ.', '2021-11-05 01:48:43', '2021-11-03 22:16:05', '2021-11-04 13:48:43'),
(182, 123, '$6$rounds=5042$6183b746b2c663.6$lyoUzAZG8OcJMwHI3NbA1YNuoYXdHNnaM9xwFz7JoUg6JJf5YghUp/ZBYqrpSZLWAGqJ2e..LJLfcw2uJIoJn1', '2021-11-05 05:42:17', '2021-11-04 04:34:46', '2021-11-04 17:42:17'),
(183, 124, '$6$rounds=5042$6183c76273a742.4$QEuxZMx0zpwN3K5VS6ICzDNyuTo7DTjlYNyirNki.gR3XFzTyrGzNKzxCiksg9VER0mws.q9cKb5rbUgHEChZ0', '2021-11-05 06:45:43', '2021-11-04 05:43:30', '2021-11-04 18:45:43'),
(184, 125, '$6$rounds=5042$6184555c963809.3$lS4UuobgbfzANX4lgv10dA7EwofJwSEXJqW1OSlMhgi64f6Vz6SKismihZoR/98V613gwYGCSPvb61lMltXqw0', '2021-11-05 16:49:54', '2021-11-04 15:49:16', '2021-11-05 04:49:54'),
(185, 126, '$6$rounds=5042$618469d1279333.9$BlkDs1jBWeSTC..b1D9wD/sfaW2.gG3VwbVdJkreWJQI0ibr4iBxK2bcNHMln7iYUnvUegsexXJoeqCbzL/D50', '2021-11-05 18:17:45', '2021-11-04 17:16:33', '2021-11-05 06:17:45'),
(186, 127, '$6$rounds=5042$61850417c76267.6$G1C4RaVW0JO/wk05JxMm/XpkvBf6bq2O1asDs0PwpeANaRs7Nep8bGGXWHEUGHuQvKV3XOJ8G069X0tttPKEe.', '2021-11-06 05:19:38', '2021-11-05 04:14:47', '2021-11-05 17:19:38'),
(187, 128, '$6$rounds=5042$61853db4364c26.1$hLrodvSkkp1brWIbyIpoR/gbWjKXcG5YhyPSxZY3HvhTQmKsqmLRXCeQBX70C/5ccJajdCqskP5UGF9.9GovQ/', '2021-11-06 09:22:08', '2021-11-05 08:20:36', '2021-11-05 21:22:08'),
(188, 129, '$6$rounds=5042$61855d6aca21b0.8$FWGgSlu1zHRM9b/Ec3ywKst8q9iNj8g108eG3s.bX7PpEfpH4wZ.FTS1r41oxujtd63uQ14H445Mfj2JlOi7g1', '2021-11-06 11:37:30', '2021-11-05 10:35:54', '2021-11-05 23:37:30'),
(189, 23, '$6$rounds=5042$6186063a41ea75.8$YFR.3.cd03SW/6Gx/wPsZcWtItMrc7bx1JWmM8g0Iv4NCkUBRn9h36RP6rVE9vj/SRtIbOBJIbeGOZnT/EVpA0', '2021-11-07 00:12:09', '2021-11-05 22:36:10', '2021-11-06 12:12:09');

-- --------------------------------------------------------

--
-- Table structure for table `user_complaint`
--

CREATE TABLE `user_complaint` (
  `id` int(11) NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'NA',
  `user_id` int(11) NOT NULL,
  `complaint` text COLLATE utf8_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `user_complaint`
--

INSERT INTO `user_complaint` (`id`, `title`, `user_id`, `complaint`, `created_at`) VALUES
(1, 'komplen', 60, 'kok gak diaprove2', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `user_profile`
--

CREATE TABLE `user_profile` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `type` int(11) NOT NULL DEFAULT '1' COMMENT '1 for normal, 2 for fb, 3 for gplus',
  `profile_pic` varchar(250) CHARACTER SET utf8 NOT NULL DEFAULT 'NA',
  `name` varchar(250) CHARACTER SET utf8 NOT NULL DEFAULT 'NA',
  `last_name` varchar(250) CHARACTER SET utf8 NOT NULL DEFAULT 'NA',
  `mobile` varchar(20) CHARACTER SET utf8 NOT NULL DEFAULT 'NA',
  `country_code` varchar(20) CHARACTER SET utf8 NOT NULL DEFAULT '91',
  `address` varchar(500) CHARACTER SET utf8 NOT NULL DEFAULT 'NA',
  `social_id` varchar(255) CHARACTER SET utf8 NOT NULL,
  `documents` text CHARACTER SET utf8 NOT NULL,
  `is_verified` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0:pending, 1:approve, 2:reject',
  `created_at` int(20) NOT NULL DEFAULT '0',
  `updated_at` int(20) NOT NULL DEFAULT '0',
  `city` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `state` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `pincode` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `national_id_proof` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `address_proof` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `is_subscribe` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `user_profile`
--

INSERT INTO `user_profile` (`id`, `user_id`, `type`, `profile_pic`, `name`, `last_name`, `mobile`, `country_code`, `address`, `social_id`, `documents`, `is_verified`, `created_at`, `updated_at`, `city`, `state`, `pincode`, `national_id_proof`, `address_proof`, `is_subscribe`) VALUES
(1, 1, 1, 'NA', 'Nilesh', 'Yadav', '9827433134', '+91', 'Laxman Nagar', '', '', 1, 1631354707, 1631354707, 'Indore', 'MP', '455001', 'https://api.applatus.com/rah/apinew/api/uploads/286370-1631633593.png', '', ''),
(21, 21, 2, 'NA', 'Shalinee Gangrade', 'Shalinee Gangrade', '', '', 'NA', 'fH9JbLlRd4db7OLldKaNb2iCqws2', '', 0, 1632052975, 1632052975, '', '', '', '', '', ''),
(22, 22, 1, 'NA', 'NA', 'NA', '9827433134', '9827433134', 'NA', '', '', 0, 1632122866, 1632122866, '', '', '', '', '', ''),
(23, 23, 3, 'NA', 'Amit Sharma', 'Amit Sharma', '', '', 'NA', 'IDucaYHWJ5U3UYwR6srZ5jCCEw92', '', 0, 1632465980, 1632465980, '', '', '', '', '', ''),
(24, 24, 3, 'NA', 'Jaime Clegane', 'Jaime Clegane', '', '', 'NA', 'unXiZ2hyCAOqdkoOxdr4tpGKPAC2', '', 0, 1632528148, 1632528148, '', '', '', '', '', ''),
(25, 25, 1, 'NA', 'NA', 'NA', '9111107373', '9111107373', 'NA', '', '', 0, 1632548879, 1632548879, '', '', '', '', '', ''),
(26, 26, 1, 'NA', 'Rae', 'chisholm', '7274954531', '+1', '416 rockaway pkwy', '', '', 0, 1632608977, 1632608977, 'Dubai', 'ny', '11212', 'https://api.applatus.com/rah/apinew/api/uploads/104020-1632609086.png', '', ''),
(27, 27, 1, 'NA', 'NA', 'NA', '7274954531', '7274954531', 'NA', '', '', 0, 1632611781, 1632611781, '', '', '', '', '', ''),
(28, 28, 3, 'NA', 'Kalai Carft', 'Kalai Carft', '', '', 'NA', 'jg9H6UHMzEMaTdKvZZEWFfppJ7d2', '', 0, 1632676917, 1632676917, '', '', '', '', '', ''),
(29, 29, 1, 'NA', 'Fr', 'An', '506981977', '+380', '123 unused st', '', '', 0, 1632699934, 1632699934, 'Dubai', 'Dbx', '123', 'https://api.applatus.com/rah/apinew/api/uploads/196899-1632700243.png', '', ''),
(30, 30, 3, 'NA', 'al amin', 'al amin', '', '', 'NA', 'XzI1yZ1wOhOsD4Y5n8FnFvKoYb13', '', 0, 1632750496, 1632750496, '', '', '', '', '', ''),
(31, 31, 1, 'NA', 'Sadiq', 'Rahman', '1770250865', '+880', 'Dhaka', '', '', 0, 1632751657, 1632751657, 'BANGALORE', 'Dhaka', '1234', 'https://api.applatus.com/rah/apinew/api/uploads/491713-1632755865.png', '', ''),
(32, 32, 3, 'NA', 'Hany Ahmed', 'Hany Ahmed', '', '', 'NA', 'K63g5RwXtQebsfoiOqbIeP5KI9M2', '', 0, 1632772908, 1632772908, '', '', '', '', '', ''),
(33, 33, 3, 'NA', 'Kuo Ching Liew', 'Kuo Ching Liew', '', '', 'NA', 'yskpAFHkIvXvrbeGQYFtd9MXeJo1', '', 0, 1632786478, 1632786478, '', '', '', '', '', ''),
(34, 34, 1, 'NA', 'NA', 'NA', '1770250865', '1770250865', 'NA', '', '', 0, 1632806252, 1632806252, '', '', '', '', '', ''),
(35, 35, 3, 'NA', 'Karthik k', 'Karthik k', '', '', 'NA', 'CRl5gEz3iERKhwCOJiHjC2Xkk842', '', 0, 1632806771, 1632806771, '', '', '', '', '', ''),
(36, 36, 1, 'NA', 'NA', 'NA', '522946005', '+522946005', 'dubai', '', '', 0, 1632857395, 1632857395, 'Dubai', 'dubai', '12345', 'https://api.applatus.com/rah/apinew/api/uploads/116931-1632857532.png', '', ''),
(37, 37, 3, 'NA', 'Arslan Farooq', 'Arslan Farooq', '', '', 'NA', '2F75qMzh77gbWqS1uM8ty1sHnMB2', '', 0, 1632857610, 1632857610, '', '', '', '', '', ''),
(38, 38, 1, 'NA', 'NA', 'NA', '522946005', '+522946005', 'Dubai', '', '', 0, 1632859187, 1632859187, 'Dubai', 'Dubai', '12345', 'https://api.applatus.com/rah/apinew/api/uploads/580476-1632859240.png', '', ''),
(39, 39, 1, 'NA', 'NA', 'NA', '0664662654', '+33', 'rue de renory', '', '', 0, 1632900010, 1632900010, 'wajaale', 'France', '6535', 'https://api.applatus.com/rah/apinew/api/uploads/273248-1632900129.png', '', ''),
(40, 40, 1, 'NA', 'NA', 'NA', '7704078280', '7704078280', 'NA', '', '', 0, 1632900747, 1632900747, '', '', '', '', '', ''),
(41, 41, 1, 'NA', 'NA', 'NA', '522946005', '522946005', 'NA', '', '', 0, 1632924322, 1632924322, '', '', '', '', '', ''),
(42, 42, 3, 'NA', 'Salah Uddin', 'Salah Uddin', '1820066662', '+880', 'jj', 'UrmVjfb2Dzd4LbYP0SeR6XVOTan1', '', 1, 1632951627, 1632951627, 'mombasa', 'gg', '455', 'https://api.applatus.com/rah/apinew/api/uploads/182591-1632951789.png', '', ''),
(43, 43, 3, 'NA', 'Sadiq Rahman', 'Sadiq Rahman', '', '', 'NA', 'GBnSis2pILSv4NdOuWHkHZb5k6n2', '', 0, 1633012896, 1633012896, '', '', '', '', '', ''),
(44, 44, 3, 'NA', 'Sohel Rana', 'Sohel Rana', '', '', 'NA', '6hAMLQCrIANlE3whbNDiROtrXjh2', '', 0, 1633031447, 1633031447, '', '', '', '', '', ''),
(45, 45, 3, 'https://api.applatus.com/rah/api/api/uploads/477816-1634715733.png', 'Nilesh', 'Yadav', '9826801615', '+91', 'Laxman Nagar', 'D30K0LU5TfaX6rxtgOarvWxCWx12', '', 1, 1633105332, 1633105332, 'Indore', 'MP', '455001', 'https://api.applatus.com/rah/api/api/uploads/886617-1634715549.png', '', ''),
(46, 46, 3, 'NA', 'Factify', 'Factify', '', '', 'NA', '7A1HHGW3k6gEgOsuT5YNFmJABtf2', '', 0, 1633116150, 1633116150, '', '', '', '', '', ''),
(47, 47, 1, 'NA', 'NA', 'NA', '0542122132', '0542122132', 'NA', '', '', 0, 1633162137, 1633162137, '', '', '', '', '', ''),
(48, 48, 3, 'NA', 'احمد البهجي', 'احمد البهجي', '', '', 'NA', 'HQFv0SIOAMeSHfSrsk6WXvdvwmS2', '', 0, 1633190930, 1633190930, '', '', '', '', '', ''),
(49, 49, 3, 'NA', 'İsmail', 'İsmail', '', '', 'NA', 'v0p1xxjYL6bMxA4E1Soc39mp6Oh1', '', 0, 1633339327, 1633339327, '', '', '', '', '', ''),
(50, 50, 1, 'NA', 'NA', 'NA', '542122132', '542122132', 'NA', '', '', 0, 1633347926, 1633347926, '', '', '', '', '', ''),
(51, 51, 1, 'NA', 'NA', 'NA', '1017982085', '1017982085', 'NA', '', '', 0, 1633356812, 1633356812, '', '', '', '', '', ''),
(52, 52, 1, 'NA', 'NA', 'NA', '504677727', '504677727', 'NA', '', '', 0, 1633456928, 1633456928, '', '', '', '', '', ''),
(53, 53, 1, 'NA', 'NA', 'NA', '9677249250', '9677249250', 'NA', '', '', 0, 1633505529, 1633505529, '', '', '', '', '', ''),
(54, 54, 1, 'NA', 'NA', 'NA', '1644819157', '1644819157', 'NA', '', '', 0, 1633544393, 1633544393, '', '', '', '', '', ''),
(55, 55, 3, 'NA', 'Tioh Boon Kok', 'Tioh Boon Kok', '', '', 'NA', 'SmYCsUK8wYTcSOc1MXroX0IAJG22', '', 0, 1633565151, 1633565151, '', '', '', '', '', ''),
(56, 56, 1, 'NA', 'NA', 'NA', '01025555225', '01025555225', 'NA', '', '', 0, 1633579790, 1633579790, '', '', '', '', '', ''),
(57, 57, 1, 'NA', 'NA', 'NA', '3016604705', '3016604705', 'NA', '', '', 0, 1633641293, 1633641293, '', '', '', '', '', ''),
(58, 58, 3, 'NA', 'Demo IN', 'Demo IN', '', '', 'NA', 'jzKr2PsstAYQiIBhDjzPjOybKOD2', '', 0, 1633677588, 1633677588, '', '', '', '', '', ''),
(59, 59, 3, 'NA', 'Tolhah Aminuddin', 'Tolhah Aminuddin', '', '', 'NA', 'K7LnjcxbbGWUU0FcId5BD9goiFl1', '', 0, 1633802482, 1633802482, '', '', '', '', '', ''),
(60, 60, 1, 'NA', 'Tol', 'hah', '89612933341', '+62', 'jl sudirman', '', '', 0, 1633802919, 1633802919, 'New York', 'hhhj', '717181', 'https://api.applatus.com/rah/apinew/api/uploads/18061-1633803079.png', '', ''),
(61, 61, 1, 'NA', 'Rumo', 'Ruru', '743601863', '+743601863', 'Pretoria', '', '', 0, 1633889543, 1633889543, 'Cape Town', 'Gauteng', '0002', 'https://api.applatus.com/rah/apinew/api/uploads/832018-1633891898.png', '', ''),
(62, 62, 1, 'NA', 'NA', 'NA', '1521401675', '1521401675', 'NA', '', '', 0, 1633896837, 1633896837, '', '', '', '', '', ''),
(63, 63, 1, 'NA', 'Bernard', 'Kioko', '722540883', '+722540883', 'nairobi', '', '', 0, 1633897388, 1633897388, 'Dubai', 'dubai', '1234', 'https://api.applatus.com/rah/apinew/api/uploads/947985-1633898143.png', '', ''),
(64, 64, 3, 'NA', 'Atoumbré KOUASSI', 'Atoumbré KOUASSI', '', '', 'NA', 'KT80ldf3QhgCsdbb9RAueIZwtGp2', '', 0, 1633926164, 1633926164, '', '', '', '', '', ''),
(65, 65, 1, 'NA', 'NA', 'NA', '909859667', '+998', 'a', '', '', 0, 1633933814, 1633933814, 'BANGALORE', 'a', '1234', 'https://api.applatus.com/rah/apinew/api/uploads/162422-1633934126.png', '', ''),
(66, 66, 3, 'NA', 'CREATİVERA YAZILIM TEKNOLOJİLERİ', 'CREATİVERA YAZILIM TEKNOLOJİLERİ', '', '', 'NA', 'Q8oNS60FB4OkdW1z5VxjmekZYk63', '', 0, 1634224731, 1634224731, '', '', '', '', '', ''),
(67, 67, 1, 'NA', 'NA', 'NA', '999999', '+91', 'NA', '', '', 0, 1634306408, 1634306408, '', '', '', '', '', ''),
(68, 68, 1, 'NA', 'Monty', 'Sonty', '9977337676', '+91', 'indore', '', '', 1, 1634307870, 1634307870, 'Douala', 'St', '455555', 'https://api.applatus.com/rah/apinew/api/uploads/977577-1634307953.png', '', ''),
(69, 69, 3, 'NA', 'Chu Hai', 'Chu Hai', '', '', 'NA', 'ZfPhaUvLhqNDV6SpddPZOHJdB7f2', '', 0, 1634369865, 1634369865, '', '', '', '', '', ''),
(70, 70, 1, 'NA', 'NA', 'NA', '00993000000', '+91', 'NA', '', '', 0, 1634387139, 1634387139, '', '', '', '', '', ''),
(71, 71, 1, 'NA', 'NA', 'NA', '9977337676', '9977337676', 'NA', '', '', 0, 1634387779, 1634387779, '', '', '', '', '', ''),
(72, 72, 3, 'NA', 'Star Buko', 'Star Buko', '', '', 'NA', 'WFJd7e1GcchniXK5IvRaaupmIhE3', '', 0, 1634443667, 1634443667, '', '', '', '', '', ''),
(73, 73, 1, 'NA', 'tejpalsing', 'Rajput', '9922245799', '+91', 'krisna 305', '', '', 0, 1634445365, 1634445365, 'BANGALORE', 'karnataka', '412207', 'https://api.applatus.com/rah/apinew/api/uploads/307101-1634445518.png', '', ''),
(74, 74, 3, 'NA', 'Bernard Kioko', 'Bernard Kioko', '', '', 'NA', 'NXrT0hSjU7fQdgH83Iw9MNlpCv53', '', 0, 1634457925, 1634457925, '', '', '', '', '', ''),
(75, 75, 1, 'NA', 'NA', 'NA', '0868204926', '0868204926', 'NA', '', '', 0, 1634464105, 1634464105, '', '', '', '', '', ''),
(76, 76, 3, 'NA', 'Tejpal Rajput', 'Tejpal Rajput', '', '', 'NA', 'eVIwtlq5HbT2LI3bnfYjR5hlcYq2', '', 0, 1634481265, 1634481265, '', '', '', '', '', ''),
(77, 77, 3, 'NA', 'Narayan soni', 'Narayan soni', '', '', 'NA', 'kJgiG0lnmSZGms4fA2QDk5bUpCH2', '', 0, 1634580964, 1634580964, '', '', '', '', '', ''),
(78, 78, 3, 'NA', 'Pe Ba', 'Pe Ba', '', '', 'NA', 'L67JeghChoMzYXQmnlDKlR9DSnc2', '', 0, 1634722788, 1634722788, '', '', '', '', '', ''),
(79, 79, 1, 'NA', 'NA', 'NA', '9849627312', '91', 'NA', '', '', 0, 1634728586, 1634728586, '', '', '', '', '', ''),
(80, 80, 1, 'NA', 'NA', 'NA', '9789042380', '9789042380', 'NA', '', '', 0, 1634815128, 1634815128, '', '', '', '', '', ''),
(81, 81, 3, 'NA', 'Mostafa shoukry', 'Mostafa shoukry', '', '', 'NA', 'UXEhHxplPpQ7Uu2j1t5goQp3Hua2', '', 0, 1634866542, 1634866542, '', '', '', '', '', ''),
(82, 82, 1, 'NA', 'NA', 'NA', '168008400', '168008400', 'NA', '', '', 0, 1634918343, 1634918343, '', '', '', '', '', ''),
(83, 83, 3, 'NA', 'odince Goodwill', 'odince Goodwill', '', '', 'NA', 'FKMOGHkadSdjbPd4gJAgPj2Nb6I2', '', 0, 1634924676, 1634924676, '', '', '', '', '', ''),
(84, 84, 3, 'NA', 'karwan khalid', 'karwan khalid', '7504474667', '+964', 'chhhhh', 'DZvjzSH7gLfGhsCGWkqnXW7NBAM2', '', 0, 1635006226, 1635006226, 'Dubai', 'hhh', '443', 'https://api.applatus.com/rah/apinew/api/uploads/442813-1635006452.png', '', ''),
(85, 85, 1, 'NA', 'NA', 'NA', '8871242999', '8871242999', 'NA', '', '', 0, 1635064951, 1635064951, '', '', '', '', '', ''),
(86, 86, 3, 'NA', 'Darlington Chiiko', 'Darlington Chiiko', '', '', 'NA', 'NZkzeRnMlgeZ47Rlr2GGujPt96R2', '', 0, 1635065089, 1635065089, '', '', '', '', '', ''),
(87, 87, 1, 'NA', 'NA', 'NA', '99108030', '99108030', 'NA', '', '', 0, 1635209552, 1635209552, '', '', '', '', '', ''),
(88, 88, 1, 'NA', 'NA', 'NA', '7350922828', '7350922828', 'NA', '', '', 0, 1635231474, 1635231474, '', '', '', '', '', ''),
(89, 89, 3, 'NA', 'esiribiz', 'esiribiz', '', '', 'NA', 'as4F8pk3JxUZCFJ7bapp1iT00lk2', '', 0, 1635231527, 1635231527, '', '', '', '', '', ''),
(90, 90, 1, 'NA', 'NA', 'NA', '531881388', '531881388', 'NA', '', '', 0, 1635243020, 1635243020, '', '', '', '', '', ''),
(91, 91, 3, 'NA', 'Eric Gisore', 'Eric Gisore', '', '', 'NA', '2B92HajI72Xf5hyGXNpW7t2QLG12', '', 0, 1635354045, 1635354045, '', '', '', '', '', ''),
(92, 92, 1, 'NA', 'NA', 'NA', '981291299', '51', 'NA', '', '', 0, 1635359935, 1635359935, '', '', '', '', '', ''),
(93, 93, 1, 'NA', 'NA', 'NA', '6391671146', '52', 'NA', '', '', 0, 1635361651, 1635361651, '', '', '', '', '', ''),
(94, 94, 1, 'NA', 'NA', 'NA', '5338863534', '5338863534', 'NA', '', '', 0, 1635377994, 1635377994, '', '', '', '', '', ''),
(95, 95, 1, 'NA', 'NA', 'NA', '909859667', '909859667', 'NA', '', '', 0, 1635410125, 1635410125, '', '', '', '', '', ''),
(96, 96, 1, 'NA', 'NA', 'NA', '8867005682', '8867005682', 'NA', '', '', 0, 1635411096, 1635411096, '', '', '', '', '', ''),
(97, 97, 2, 'NA', 'Geric Calvin', 'Geric Calvin', '', '', 'NA', 'jzrTpfQy0SRLomYoCtx53zWBJxi2', '', 0, 1635418415, 1635418415, '', '', '', '', '', ''),
(98, 98, 1, 'NA', 'NA', 'NA', '8787765733', '8787765733', 'NA', '', '', 0, 1635425929, 1635425929, '', '', '', '', '', ''),
(99, 99, 1, 'NA', 'NA', 'NA', '7414926016', '7414926016', 'NA', '', '', 0, 1635427681, 1635427681, '', '', '', '', '', ''),
(100, 100, 1, 'NA', 'NA', 'NA', '650193020', '650193020', 'NA', '', '', 0, 1635437146, 1635437146, '', '', '', '', '', ''),
(101, 101, 1, 'NA', 'NA', 'NA', '982767325', '51', 'NA', '', '', 0, 1635441389, 1635441389, '', '', '', '', '', ''),
(102, 102, 3, 'NA', 'Melinda Barton', 'Melinda Barton', '', '', 'NA', 'y5rP6dQ0LceuZE50lTv0pM9jwY53', '', 0, 1635445580, 1635445580, '', '', '', '', '', ''),
(103, 103, 3, 'NA', 'Pablo Colon', 'Pablo Colon', '', '', 'NA', 'P39beyw9w9MT4SpRN4kUN19LkBq1', '', 0, 1635446322, 1635446322, '', '', '', '', '', ''),
(104, 104, 3, 'NA', 'Fred Romero', 'Fred Romero', '', '', 'NA', 'mgAwSkdck9dmxNj9pE9FDpyyo0j1', '', 0, 1635448126, 1635448126, '', '', '', '', '', ''),
(105, 105, 1, 'NA', 'NAakaja', 'NAanajan', '44377797', '+44377797', 'no address at all', '', '', 0, 1635460490, 1635460490, 'Dubai', 'kosovo', '12345', 'https://api.applatus.com/rah/api/api/uploads/326967-1635464955.png', '', ''),
(106, 106, 3, 'NA', 'H4WL3RY', 'H4WL3RY', '', '', 'NA', 'Zc6g7TmsKARgkTUqQsB4cbXqbyO2', '', 0, 1635468143, 1635468143, '', '', '', '', '', ''),
(107, 107, 3, 'NA', 'Shelly Weber', 'Shelly Weber', '', '', 'NA', 'ftYXATGCjkY4io64xFD8iEY4emp2', '', 0, 1635489814, 1635489814, '', '', '', '', '', ''),
(108, 108, 3, 'NA', 'Jim Haynes', 'Jim Haynes', '', '', 'NA', 'tD4QDu7CLfQqaQ3zIrIvqIRdX3h1', '', 0, 1635489993, 1635489993, '', '', '', '', '', ''),
(109, 109, 3, 'NA', 'Stephania Reedy', 'Stephania Reedy', '', '', 'NA', 'JbFogvOZezaKLG7YrDffldImJS13', '', 0, 1635492956, 1635492956, '', '', '', '', '', ''),
(110, 110, 3, 'NA', 'Florim Brahimi', 'Florim Brahimi', '', '', 'NA', 'uBYHdzeahhdz2Hks5odP4ruCB4K2', '', 0, 1635522759, 1635522759, '', '', '', '', '', ''),
(111, 111, 3, 'NA', 'wave 61', 'wave 61', '', '', 'NA', '9PRFriGx8tRPj9WeKX3bw5atcJF3', '', 0, 1635569220, 1635569220, '', '', '', '', '', ''),
(112, 112, 1, 'NA', 'NA', 'NA', '1019084771', '20', 'NA', '', '', 0, 1635665673, 1635665673, '', '', '', '', '', ''),
(113, 113, 3, 'NA', 'orion terolli', 'orion terolli', '', '', 'NA', '77Q20x5JFDgXBZahJOHybJTjkB22', '', 0, 1635708963, 1635708963, '', '', '', '', '', ''),
(114, 114, 1, 'NA', 'NA', 'NA', '7976612512', '7976612512', 'NA', '', '', 0, 1635744543, 1635744543, '', '', '', '', '', ''),
(115, 115, 1, 'https://api.applatus.com/rah/api/api/uploads/970280-1635824233.png', 'NA', 'NA', '7976612512', '91', 'Ratangarh', '', '', 0, 1635824034, 1635824034, '', '', '', '', '', ''),
(116, 116, 3, 'NA', 'sumit sindhu', 'sumit sindhu', '7696426228', '+91', 'chandigarh', 'MakcoiWOObOEL4D86QtS9rydwFE2', '', 0, 1635835263, 1635835263, 'Kolkata', 'Chandigarh', '124001', 'https://api.applatus.com/rah/api/api/uploads/877408-1635835527.png', '', ''),
(117, 117, 3, 'NA', 'Madhukar Jha', 'Madhukar Jha', '', '', 'NA', '1yS4ggnYcbMlZHqJfs3tPHyxJGs2', '', 0, 1635837942, 1635837942, '', '', '', '', '', ''),
(118, 118, 1, 'NA', 'NA', 'NA', '3472240432', '3472240432', 'NA', '', '', 0, 1635856671, 1635856671, '', '', '', '', '', ''),
(119, 119, 1, 'NA', 'NA', 'NA', '1000377743', '1000377743', 'NA', '', '', 0, 1635864120, 1635864120, '', '', '', '', '', ''),
(120, 120, 1, 'NA', 'NA', 'NA', '1120231725', '1120231725', 'NA', '', '', 0, 1635864212, 1635864212, '', '', '', '', '', ''),
(121, 121, 1, 'NA', 'NA', 'NA', '604961536', '+48', 'sikorskiego', '', '', 1, 1635931571, 1635931571, 'Dubai', 'juh', '1111', 'https://api.applatus.com/rah/api/api/uploads/871671-1635931977.png', '', ''),
(122, 122, 1, 'NA', 'NA', 'NA', '5027802430', '5027802430', 'NA', '', '', 0, 1635984026, 1635984026, '', '', '', '', '', ''),
(123, 123, 3, 'NA', 'MD Nazrul Islam', 'MD Nazrul Islam', '', '', 'NA', 'aYZzpQw6YvMyiDP1E6rxxy7lTnJ3', '', 0, 1636022086, 1636022086, '', '', '', '', '', ''),
(124, 124, 1, 'NA', 'NA', 'NA', '487012156', '32', 'NA', '', '', 0, 1636026210, 1636026210, '', '', '', '', '', ''),
(125, 125, 1, 'NA', 'NA', 'NA', '923353562', '923353562', 'NA', '', '', 0, 1636062556, 1636062556, '', '', '', '', '', ''),
(126, 126, 3, 'NA', 'Yasser Tamimi', 'Yasser Tamimi', '', '', 'NA', 'KwnOzt4qlPXTXaV8SAbd37385ue2', '', 0, 1636067793, 1636067793, '', '', '', '', '', ''),
(127, 127, 3, 'NA', 'Bruno Lovatti', 'Bruno Lovatti', '', '', 'NA', 'gn6nEqBbprZSMgn4AVDv25wPdRc2', '', 0, 1636107287, 1636107287, '', '', '', '', '', ''),
(128, 128, 3, 'NA', 'Saad Ghandour', 'Saad Ghandour', '', '', 'NA', 'c516FyKFXpQiM23zLizPURBnd582', '', 0, 1636122036, 1636122036, '', '', '', '', '', ''),
(129, 129, 1, 'NA', 'NA', 'NA', '61009452', '229', 'NA', '', '', 0, 1636130154, 1636130154, '', '', '', '', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `user_subscription`
--

CREATE TABLE `user_subscription` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `plan_id` int(11) NOT NULL,
  `details` text COLLATE utf8_unicode_ci,
  `start_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `expiry_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '1'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `user_subscription`
--

INSERT INTO `user_subscription` (`id`, `user_id`, `plan_id`, `details`, `start_date`, `expiry_date`, `status`) VALUES
(1, 3, 1, '{\r\n  \"amount\": 300,\r\n  \"canceledAt\": 0,\r\n  \"captureMethod\": \"automatic\",\r\n  \"clientSecret\": \"pi_1H0qeuJcjbNSgRrvNjmMDnN1_secret_LXr2miDRd5CAQTkxuJ9DqG8FB\",\r\n  \"confirmationMethod\": \"automatic\",\r\n  \"created\": 1593789516,\r\n  \"currency\": \"usd\",\r\n  \"id\": \"pi_1H0qeuJcjbNSgRrvNjmMDnN1\",\r\n  \"isLiveMode\": false,\r\n  \"objectType\": \"payment_intent\",\r\n  \"paymentMethodTypes\": [\r\n    \"card\"\r\n  ],\r\n  \"status\": \"Succeeded\"\r\n}', '2020-07-04 04:18:57', '2020-07-13 15:18:57', 1),
(2, 125, 1, 'kdfg', '2020-07-04 04:23:07', '2020-07-03 15:23:07', 1),
(3, 1, 1, 'kdfg', '2020-07-04 04:23:20', '2020-07-03 15:23:20', 1),
(4, 1, 1, '', '2020-07-04 06:55:16', '2020-07-03 17:55:17', 1),
(5, 1, 1, 'kdfg', '2020-07-04 07:11:20', '2020-07-11 07:11:20', 1),
(6, 1, 1, '', '2020-07-04 07:12:03', '2020-07-11 07:12:03', 1),
(7, 1, 1, '', '2020-07-04 08:28:59', '2020-07-11 08:28:59', 1),
(8, 1, 1, '', '2020-07-04 08:29:09', '2020-07-11 08:29:09', 1),
(9, 1, 1, '', '2020-07-06 19:54:14', '2020-07-13 19:54:14', 1),
(10, 1, 1, '', '2020-07-06 19:56:16', '2020-07-13 19:56:16', 1),
(11, 10, 1, '', '2020-07-06 19:58:09', '2020-07-13 19:58:09', 1),
(12, 10, 1, '', '2020-07-06 20:00:39', '2020-07-13 20:00:39', 1),
(13, 40, 3, 'pay_FUGfR8rMomKqeq', '2020-08-24 05:20:10', '2020-11-24 06:20:10', 1),
(14, 40, 3, 'pay_FUH6IBFaxag5Su', '2020-08-24 05:45:33', '2020-11-24 06:45:33', 1),
(15, 40, 3, 'pay_FUHIQa5aQNBKpv', '2020-08-24 05:57:05', '2020-11-24 06:57:05', 1),
(16, 40, 3, 'pay_FUa18n7YlA1s4e', '2020-08-25 00:15:53', '2020-11-25 01:15:53', 1),
(17, 295, 9, '{\n  \"amount\": 3500,\n  \"canceledAt\": 0,\n  \"captureMethod\": \"automatic\",\n  \"clientSecret\": \"pi_1HPtPpJcjbNSgRrvU9sYksNU_secret_vpqto1Gsy2mfGlT5PDRBt2FTA\",\n  \"confirmationMethod\": \"automatic\",\n  \"created\": 1599758313,\n  \"currency\": \"usd\",\n  \"id\": \"pi_1HPtPpJcjbNSgRrvU9sYksNU\",\n  \"isLiveMode\": false,\n  \"objectType\": \"payment_intent\",\n  \"paymentMethodTypes\": [\n    \"card\"\n  ],\n  \"status\": \"Succeeded\"\n}', '2020-09-11 06:25:53', '2020-10-11 06:25:53', 1),
(18, 10, 2, '', '2020-11-20 09:49:27', '2020-11-27 09:49:27', 0),
(19, 418, 10, 'Instance of \'PaymentIntentResult\'', '2020-12-05 08:15:28', '2020-12-12 08:15:28', 1),
(20, 418, 9, '{paymentIntentId: pi_1HuipvJcjbNSgRrvj6roHc5T, status: succeeded}', '2020-12-05 08:17:01', '2021-01-05 08:17:01', 1),
(21, 418, 3, 'pay_G93hgVzZDZSvbM', '2020-12-05 08:18:16', '2021-12-05 08:18:16', 1),
(22, 418, 9, 'Instance of \'ChargeResponseData\'', '2020-12-05 08:20:31', '2021-01-05 08:20:31', 1),
(23, 418, 10, '{paymentIntentId: pi_1HuizMJcjbNSgRrv6My4fYvB, status: succeeded}', '2020-12-05 08:26:45', '2020-12-12 08:26:45', 1),
(24, 418, 10, '{paymentIntentId: pi_1Huj5eJcjbNSgRrvhR500ctz, status: succeeded}', '2020-12-05 08:33:16', '2020-12-12 08:33:16', 1),
(25, 418, 10, '{paymentIntentId: pi_1Huj7cJcjbNSgRrvDSddWMJj, status: succeeded}', '2020-12-05 08:35:17', '2020-12-12 08:35:17', 1),
(26, 306, 2, '{paymentIntentId: pi_1I0pgTJcjbNSgRrvhs1WZnt7, status: succeeded, paymentMethodId: pm_1I0pgXJcjbNSgRrvWboKFzh3}', '2020-12-22 04:48:51', '2020-12-29 04:48:51', 1),
(27, 306, 2, '{paymentIntentId: pi_1I0pgiJcjbNSgRrvpyshgJMO, status: succeeded, paymentMethodId: pm_1I0pglJcjbNSgRrv8G5rD25q}', '2020-12-22 04:48:55', '2020-12-29 04:48:55', 1),
(28, 306, 10, '{paymentIntentId: pi_1I4OoIJcjbNSgRrvIB82AuvM, status: succeeded, paymentMethodId: pm_1I4OoKJcjbNSgRrvpQLuXSqj}', '2021-01-01 00:55:21', '2021-01-08 00:55:21', 1),
(29, 516, 9, '{paymentIntentId: pi_1IC5szJcjbNSgRrvR3PPELVo, status: succeeded, paymentMethodId: pm_1IC5t0JcjbNSgRrvBEpvCnlX}', '2021-01-22 06:19:57', '2021-02-22 06:19:57', 1),
(30, 855, 9, '{paymentIntentId: pi_1IfuT9JcjbNSgRrvkuhtBjW7, status: succeeded}', '2021-04-14 11:12:33', '2021-05-14 11:12:33', 1),
(31, 89, 1, 'pay_IDsOz4YV5zfPdq', '2021-10-26 20:06:16', '2021-11-02 20:06:16', 1);

-- --------------------------------------------------------

--
-- Table structure for table `wish_list`
--

CREATE TABLE `wish_list` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `wish_list`
--

INSERT INTO `wish_list` (`id`, `user_id`, `product_id`, `status`, `created_at`) VALUES
(1, 26, 1, 1, '2021-09-25 16:34:56'),
(2, 54, 1, 1, '2021-10-06 12:26:36'),
(4, 61, 1, 1, '2021-10-10 12:58:35'),
(5, 83, 3, 1, '2021-10-22 11:45:23'),
(8, 45, 2, 1, '2021-11-02 03:48:34'),
(11, 90, 4, 1, '2021-11-03 04:10:16');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `booking_product`
--
ALTER TABLE `booking_product`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `chat`
--
ALTER TABLE `chat`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `chat_thread`
--
ALTER TABLE `chat_thread`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `city`
--
ALTER TABLE `city`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `featured_product`
--
ALTER TABLE `featured_product`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `history`
--
ALTER TABLE `history`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `like_product`
--
ALTER TABLE `like_product`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pay_subscription_log`
--
ALTER TABLE `pay_subscription_log`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id_fk_on_product` (`category_id`),
  ADD KEY `sub-category_id_fk_on_product` (`sub_category_id`);

--
-- Indexes for table `rent`
--
ALTER TABLE `rent`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rent_hire_history`
--
ALTER TABLE `rent_hire_history`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `request_review`
--
ALTER TABLE `request_review`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `review`
--
ALTER TABLE `review`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `setting`
--
ALTER TABLE `setting`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `slider_image`
--
ALTER TABLE `slider_image`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `subscription`
--
ALTER TABLE `subscription`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `subscription_period`
--
ALTER TABLE `subscription_period`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sub_category`
--
ALTER TABLE `sub_category`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id_fk` (`category_id`);

--
-- Indexes for table `sub_cat_form_fields`
--
ALTER TABLE `sub_cat_form_fields`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`email`);

--
-- Indexes for table `userstemp`
--
ALTER TABLE `userstemp`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users_authentication`
--
ALTER TABLE `users_authentication`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_complaint`
--
ALTER TABLE `user_complaint`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_profile`
--
ALTER TABLE `user_profile`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id_fk` (`user_id`);

--
-- Indexes for table `user_subscription`
--
ALTER TABLE `user_subscription`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `wish_list`
--
ALTER TABLE `wish_list`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `booking_product`
--
ALTER TABLE `booking_product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '11', AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `chat`
--
ALTER TABLE `chat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `chat_thread`
--
ALTER TABLE `chat_thread`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `city`
--
ALTER TABLE `city`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `featured_product`
--
ALTER TABLE `featured_product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `history`
--
ALTER TABLE `history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `like_product`
--
ALTER TABLE `like_product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `pay_subscription_log`
--
ALTER TABLE `pay_subscription_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `rent`
--
ALTER TABLE `rent`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rent_hire_history`
--
ALTER TABLE `rent_hire_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `request_review`
--
ALTER TABLE `request_review`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `review`
--
ALTER TABLE `review`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `setting`
--
ALTER TABLE `setting`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `slider_image`
--
ALTER TABLE `slider_image`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subscription`
--
ALTER TABLE `subscription`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `subscription_period`
--
ALTER TABLE `subscription_period`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `sub_category`
--
ALTER TABLE `sub_category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `sub_cat_form_fields`
--
ALTER TABLE `sub_cat_form_fields`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=130;

--
-- AUTO_INCREMENT for table `userstemp`
--
ALTER TABLE `userstemp`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users_authentication`
--
ALTER TABLE `users_authentication`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=190;

--
-- AUTO_INCREMENT for table `user_complaint`
--
ALTER TABLE `user_complaint`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user_profile`
--
ALTER TABLE `user_profile`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=130;

--
-- AUTO_INCREMENT for table `user_subscription`
--
ALTER TABLE `user_subscription`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `wish_list`
--
ALTER TABLE `wish_list`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `sub_category`
--
ALTER TABLE `sub_category`
  ADD CONSTRAINT `sub_category_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `user_profile`
--
ALTER TABLE `user_profile`
  ADD CONSTRAINT `user_profile_ibfk_4` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
