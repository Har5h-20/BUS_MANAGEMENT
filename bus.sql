
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

-- Table structure for table `amenities`

CREATE TABLE `amenities` (
  `bus_id` int(11) NOT NULL,
  `has_ac` tinyint(1) DEFAULT NULL,
  `has_wifi` tinyint(1) DEFAULT NULL,
  `has_sleeper` tinyint(1) DEFAULT NULL,
  `has_washroom` tinyint(1) DEFAULT NULL,
  `has_meals` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `amenities`
--

INSERT INTO `amenities` (`bus_id`, `has_ac`, `has_wifi`, `has_sleeper`, `has_washroom`, `has_meals`) VALUES
(1, 0, 1, 1, 0, 0),
(2, 1, 0, 0, 1, 0),
(3, 0, 0, 0, 0, 1),
(4, 0, 1, 0, 1, 0),
(5, 0, 0, 0, 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `amenitiesshare`
--

CREATE TABLE `amenitiesshare` (
  `amenity_name` varchar(50) NOT NULL,
  `percentage` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `booking_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `bus_id` int(11) DEFAULT NULL,
  `travel_date` date DEFAULT NULL,
  `booking_date` date NOT NULL,
  `seat_number` int(11) NOT NULL,
  `direction` tinyint(4) NOT NULL COMMENT '0: Outbound | 1: Inbound',
  `total_fare` decimal(10,2) NOT NULL,
  `status` tinyint(4) NOT NULL COMMENT '0: Pending | 1: Confirmed'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`booking_id`, `customer_id`, `bus_id`, `travel_date`, `booking_date`, `seat_number`, `direction`, `total_fare`, `status`) VALUES
(1, 7, 5, '2023-08-22', '2024-01-19', 10, 0, 119.00, 1),
(2, 6, 5, '2024-02-02', '2023-05-27', 48, 1, 481.00, 1),
(3, 8, 3, '2023-04-22', '2023-12-01', 59, 1, 138.00, 1),
(4, 9, 5, '2024-04-27', '2024-01-26', 35, 1, 280.00, 1),
(5, 10, 5, '2025-02-04', '2024-01-22', 55, 1, 141.00, 1),
(6, 3, 1, '2023-08-14', '2024-01-04', 46, 1, 373.00, 1),
(7, 2, 5, '2024-04-29', '2024-01-16', 1, 0, 254.00, 1),
(8, 4, 1, '2024-07-05', '2023-09-13', 3, 1, 310.00, 1),
(9, 6, 4, '2024-12-15', '2023-05-28', 34, 0, 440.00, 1),
(10, 3, 5, '2025-02-12', '2023-10-01', 25, 1, 270.00, 1),
(11, 1, 4, '2024-09-09', '2024-03-09', 8, 1, 81.00, 1),
(12, 7, 4, '2023-10-26', '2023-07-10', 10, 0, 462.00, 1),
(13, 5, 3, '2024-11-20', '2024-01-15', 25, 0, 345.00, 1),
(14, 9, 3, '2024-10-05', '2023-05-06', 14, 1, 117.00, 1),
(15, 7, 5, '2024-12-09', '2023-05-28', 55, 1, 155.00, 1),
(16, 4, 3, '2023-11-27', '2023-11-11', 7, 1, 453.00, 1),
(17, 7, 2, '2024-08-28', '2023-10-06', 8, 1, 331.00, 1),
(18, 5, 2, '2023-10-10', '2023-04-22', 31, 1, 336.00, 1),
(19, 7, 3, '2023-11-11', '2023-09-23', 25, 1, 422.00, 1),
(20, 10, 3, '2023-07-26', '2024-02-13', 44, 1, 151.00, 1);

-- --------------------------------------------------------

--
-- Table structure for table `businfo`
--

CREATE TABLE `businfo` (
  `bus_id` int(11) NOT NULL,
  `bus_name` varchar(100) NOT NULL,
  `total_seats` int(11) NOT NULL,
  `origin_city` varchar(100) NOT NULL,
  `destination_city` varchar(100) NOT NULL,
  `base_price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `businfo`
--

INSERT INTO `businfo` (`bus_id`, `bus_name`, `total_seats`, `origin_city`, `destination_city`, `base_price`) VALUES
(1, 'Anderson, Miller and Woods Bus', 54, 'Codyfort', 'New Holly', 206.00),
(2, 'Lara-Hicks Bus', 37, 'Antonioview', 'Port Wanda', 325.00),
(3, 'Bautista Group Bus', 38, 'East Sara', 'Cohenborough', 480.00),
(4, 'Warner LLC Bus', 41, 'Lake Isaac', 'South Melvin', 319.00),
(5, 'Palmer-Miller Bus', 29, 'North Cody', 'Jonesfort', 471.00);

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `customer_id` int(11) NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `username` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `is_admin` tinyint(1) NOT NULL DEFAULT 0,
  `password_hash` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `phone_number` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`customer_id`, `full_name`, `username`, `email`, `is_admin`, `password_hash`, `address`, `phone_number`) VALUES
(1, 'John Sims', 'john578', 'oleon@example.net', 0, '%^!7+Jiy&j', '247 Jose Square\nBarrettview, AL 27470', '+1-659-305-2439'),
(2, 'Joshua Gaines', 'joshua697', 'jskinner@example.com', 1, '#6Y$J#6ROm', '740 Hill Park\nKyleville, AR 86367', '+1-751-652-0272'),
(3, 'Cheryl Nelson', 'cheryl886', 'chase94@example.net', 0, '&fWu5!ReVX', '82218 William Viaduct\nPort Michelleville, CT 52571', '001-979-991-998'),
(4, 'Amanda Anderson', 'amanda906', 'jackiecohen@example.net', 1, '&bO1Vs8g%4', '118 Young Square Suite 676\nSusanbury, OR 54092', '+1-284-505-4745'),
(5, 'William Lane', 'william558', 'kaylaferguson@example.org', 1, '_6FXkJcsR+', '066 Williams Prairie\nWest Sophia, NJ 02605', '+1-793-588-1252'),
(6, 'John Hudson', 'john320', 'sperez@example.com', 0, '42z7NmBmN&', '79892 Wall Lake\nEvanfurt, DC 62027', '389.942.7533x13'),
(7, 'Cody Haley', 'cody177', 'upatton@example.org', 1, 'yqI6@AXqS(', '688 Williams Manors Apt. 916\nValerieshire, WY 95069', '+1-882-714-8904'),
(8, 'James Burns', 'james349', 'sallen@example.com', 1, '3^0LRJClA#', '10868 Frost Cliffs Apt. 027\nMoranshire, PW 59026', '312-529-4457x23'),
(9, 'Autumn Watts', 'autumn458', 'stephanieclark@example.org', 1, 'RH7Asmnq%(', '6175 Kaufman Gateway Suite 197\nMcdanielton, KY 80304', '001-810-283-775'),
(10, 'Chad Montgomery', 'chad576', 'laura95@example.net', 1, 'JrVi@tK*&1', '96304 Mills Square Suite 999\nPort Elizabeth, WV 31549', '772.295.1523');

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `payment_id` int(11) NOT NULL,
  `booking_id` int(11) DEFAULT NULL,
  `payment_date` date DEFAULT NULL,
  `amount_paid` decimal(10,2) NOT NULL,
  `status` tinyint(4) NOT NULL COMMENT '0: Pending | 1: Completed | -1: Failed'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`payment_id`, `booking_id`, `payment_date`, `amount_paid`, `status`) VALUES
(1, 1, '2024-04-02', 227.00, 0),
(2, 2, '2023-04-29', 480.00, 0),
(3, 3, '2023-05-08', 347.00, 1),
(4, 4, '2023-12-20', 351.00, 0),
(5, 5, '2024-02-03', 430.00, 1),
(6, 6, '2024-02-24', 349.00, 1),
(7, 7, '2023-06-28', 230.00, -1),
(8, 8, '2023-10-18', 170.00, 0),
(9, 9, '2023-05-30', 295.00, 0),
(10, 10, '2024-01-26', 451.00, 1),
(11, 11, '2023-06-05', 180.00, -1),
(12, 12, '2024-02-09', 80.00, 0),
(13, 13, '2023-11-23', 313.00, 0),
(14, 14, '2023-04-23', 272.00, 1),
(15, 15, '2023-12-11', 221.00, 1),
(16, 16, '2023-11-17', 334.00, 0),
(17, 17, '2024-04-03', 370.00, 0),
(18, 18, '2023-12-01', 489.00, -1),
(19, 19, '2023-07-31', 197.00, -1),
(20, 20, '2023-07-05', 222.00, 0);

-- --------------------------------------------------------

--
-- Table structure for table `schedule`
--

CREATE TABLE `schedule` (
  `bus_id` int(11) NOT NULL,
  `arrival_time` time NOT NULL,
  `departure_time` time NOT NULL,
  `direction` tinyint(4) NOT NULL COMMENT '0: Outbound | 1: Inbound'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `schedule`
--

INSERT INTO `schedule` (`bus_id`, `arrival_time`, `departure_time`, `direction`) VALUES
(1, '07:27:43', '00:47:02', 0),
(2, '22:16:36', '08:40:57', 0),
(3, '18:18:16', '13:18:48', 1),
(4, '14:21:40', '07:34:09', 1),
(5, '15:00:29', '11:28:41', 1);

-- --------------------------------------------------------

--
-- Table structure for table `totalfare`
--

CREATE TABLE `totalfare` (
  `bus_id` int(11) NOT NULL,
  `total_fare` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `totalfare`
--

INSERT INTO `totalfare` (`bus_id`, `total_fare`) VALUES
(1, 4829.00),
(2, 3570.00),
(3, 2301.00),
(4, 3373.00),
(5, 1696.00);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `amenities`
--
ALTER TABLE `amenities`
  ADD PRIMARY KEY (`bus_id`);

--
-- Indexes for table `amenitiesshare`
--
ALTER TABLE `amenitiesshare`
  ADD PRIMARY KEY (`amenity_name`);

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`booking_id`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `bus_id` (`bus_id`);

--
-- Indexes for table `businfo`
--
ALTER TABLE `businfo`
  ADD PRIMARY KEY (`bus_id`),
  ADD UNIQUE KEY `bus_name` (`bus_name`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customer_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `booking_id` (`booking_id`);

--
-- Indexes for table `schedule`
--
ALTER TABLE `schedule`
  ADD PRIMARY KEY (`bus_id`);

--
-- Indexes for table `totalfare`
--
ALTER TABLE `totalfare`
  ADD PRIMARY KEY (`bus_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `booking_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `businfo`
--
ALTER TABLE `businfo`
  MODIFY `bus_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

-- Constraints for table `amenities`

ALTER TABLE `amenities`
  ADD CONSTRAINT `amenities_ibfk_1` FOREIGN KEY (`bus_id`) REFERENCES `businfo` (`bus_id`) ON DELETE CASCADE;

--
-- Constraints for table `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`bus_id`) REFERENCES `businfo` (`bus_id`) ON DELETE CASCADE;

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`booking_id`) ON DELETE CASCADE;

--
-- Constraints for table `schedule`
--
ALTER TABLE `schedule`
  ADD CONSTRAINT `schedule_ibfk_1` FOREIGN KEY (`bus_id`) REFERENCES `businfo` (`bus_id`) ON DELETE CASCADE;

--
-- Constraints for table `totalfare`
--
ALTER TABLE `totalfare`
  ADD CONSTRAINT `totalfare_ibfk_1` FOREIGN KEY (`bus_id`) REFERENCES `businfo` (`bus_id`) ON DELETE CASCADE;
COMMIT;
