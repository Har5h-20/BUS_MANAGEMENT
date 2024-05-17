-- Create the database if not exists
CREATE DATABASE IF NOT EXISTS bus;
USE bus;

-- Create Customer table
CREATE TABLE IF NOT EXISTS Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    username VARCHAR(100) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    is_admin BOOLEAN NOT NULL DEFAULT 0,
    password_hash VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL,
    phone_number VARCHAR(15) NOT NULL,
    is_approved BOOLEAN NOT NULL DEFAULT 0
);

-- Create LoginCredentials table
CREATE TABLE IF NOT EXISTS LoginCredentials (
    login_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    FOREIGN KEY (username) REFERENCES Customers(username) ON DELETE CASCADE
);

-- Create SignupRequests table
CREATE TABLE IF NOT EXISTS SignupRequests (
    request_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    username VARCHAR(100) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL,
    phone_number VARCHAR(15) NOT NULL,
    status TINYINT NOT NULL COMMENT '0: Pending | 1: Approved | -1: Rejected'
);

-- Create BusInfo table
CREATE TABLE IF NOT EXISTS BusInfo (
    bus_id INT AUTO_INCREMENT PRIMARY KEY,
    bus_name VARCHAR(100) NOT NULL UNIQUE,
    total_seats INT NOT NULL,
    origin_city VARCHAR(100) NOT NULL,
    destination_city VARCHAR(100) NOT NULL,
    base_price DECIMAL(10,2) NOT NULL
);

-- Create Booking table
CREATE TABLE IF NOT EXISTS Bookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    bus_id INT,
    travel_date DATE,
    booking_date DATE NOT NULL,
    seat_number INT NOT NULL,
    direction TINYINT NOT NULL COMMENT '0: Outbound | 1: Inbound',
    total_fare DECIMAL(10,2) NOT NULL,
    status TINYINT NOT NULL COMMENT '0: Pending | 1: Confirmed',
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) ON DELETE CASCADE,
    FOREIGN KEY (bus_id) REFERENCES BusInfo(bus_id) ON DELETE CASCADE
);

-- Create Payment table
CREATE TABLE IF NOT EXISTS Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT,
    payment_date DATE,
    amount_paid DECIMAL(10,2) NOT NULL,
    status TINYINT NOT NULL COMMENT '0: Pending | 1: Completed | -1: Failed',
    FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id) ON DELETE CASCADE
);

-- Create Amenities table
CREATE TABLE IF NOT EXISTS Amenities (
    bus_id INT PRIMARY KEY,
    has_ac BOOLEAN,
    has_wifi BOOLEAN,
    has_sleeper BOOLEAN,
    has_washroom BOOLEAN,
    has_meals BOOLEAN,
    FOREIGN KEY (bus_id) REFERENCES BusInfo(bus_id) ON DELETE CASCADE
);

-- Create AmenitiesShare table
CREATE TABLE IF NOT EXISTS AmenitiesShare (
    amenity_name VARCHAR(50) PRIMARY KEY,
    percentage INT NOT NULL
);

-- Create Schedule table
CREATE TABLE IF NOT EXISTS Schedule (
    bus_id INT PRIMARY KEY,
    arrival_time TIME NOT NULL,
    departure_time TIME NOT NULL,
    direction TINYINT NOT NULL COMMENT '0: Outbound | 1: Inbound',
    FOREIGN KEY (bus_id) REFERENCES BusInfo(bus_id) ON DELETE CASCADE
);

-- Create TotalFare table
CREATE TABLE IF NOT EXISTS TotalFare (
    bus_id INT PRIMARY KEY,
    total_fare DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (bus_id) REFERENCES BusInfo(bus_id) ON DELETE CASCADE
);
