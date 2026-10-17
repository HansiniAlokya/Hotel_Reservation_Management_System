-- Create tables for Hotel Reservation System
-- This script creates the correct table structure for MySQL

-- Drop existing tables if they exist (in correct order due to foreign keys)
DROP TABLE IF EXISTS reservations;
DROP TABLE IF EXISTS events;
DROP TABLE IF EXISTS rooms;
DROP TABLE IF EXISTS hotels;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS roles;

-- Create roles table
CREATE TABLE roles (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create users table
CREATE TABLE users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone_number VARCHAR(20),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create hotels table
CREATE TABLE hotels (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    location VARCHAR(200) NOT NULL,
    description TEXT,
    facilities VARCHAR(500),
    star_rating INT,
    contact_phone VARCHAR(20),
    contact_email VARCHAR(100),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create events table
CREATE TABLE events (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(1000),
    start_date TIMESTAMP NOT NULL,
    end_date TIMESTAMP,
    location VARCHAR(200) NOT NULL,
    max_capacity INT,
    current_bookings INT DEFAULT 0,
    price_per_person DECIMAL(10,2),
    event_status ENUM('ACTIVE', 'INACTIVE', 'CANCELLED', 'COMPLETED') DEFAULT 'ACTIVE',
    hotel_id BIGINT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (hotel_id) REFERENCES hotels(id) ON DELETE SET NULL
);

-- Create rooms table
CREATE TABLE rooms (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    hotel_id BIGINT NOT NULL,
    room_number VARCHAR(20) NOT NULL,
    room_type VARCHAR(50) NOT NULL,
    capacity INT NOT NULL,
    price_per_night DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (hotel_id) REFERENCES hotels(id) ON DELETE CASCADE,
    UNIQUE KEY unique_room_per_hotel (hotel_id, room_number)
);

-- Create reservations table (supports both hotel and event reservations)
CREATE TABLE reservations (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    reservation_number VARCHAR(255) NOT NULL UNIQUE,
    user_id BIGINT NOT NULL,
    hotel_id BIGINT NULL,
    event_id BIGINT NULL,
    check_in_date TIMESTAMP NOT NULL,
    check_out_date TIMESTAMP NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    reservation_status ENUM('PENDING', 'CONFIRMED', 'RESERVED', 'CHECKED_IN', 'CHECKED_OUT', 'CANCELLED', 'NO_SHOW') DEFAULT 'PENDING',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (hotel_id) REFERENCES hotels(id) ON DELETE CASCADE,
    FOREIGN KEY (event_id) REFERENCES events(id) ON DELETE CASCADE
);

-- Insert sample data
INSERT INTO roles (name) VALUES ('ADMIN'), ('STAFF'), ('GUEST');

INSERT INTO users (username, email, password, first_name, last_name) VALUES 
('admin', 'admin@hotel.com', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'Admin', 'User'),
('staff', 'staff@hotel.com', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'Staff', 'User'),
('testuser', 'test@example.com', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'Test', 'User');

INSERT INTO hotels (name, location, description, facilities, star_rating, contact_phone, contact_email) VALUES 
('GrandStay Resort', '123 Ocean Drive, Miami Beach, Florida, USA', 'Luxury beachfront resort with stunning ocean views', 'WiFi, Pool, Gym, Restaurant, Beach Access', 5, '+1-305-555-0123', 'info@grandstay.com'),
('Metro Plaza Hotel', '456 Business District, New York, New York, USA', 'Modern hotel in the heart of Manhattan', 'WiFi, Pool, Gym, Restaurant, Business Center', 4, '+1-212-555-0456', 'info@metroplaza.com'),
('Mountain View Lodge', '789 Alpine Road, Aspen, Colorado, USA', 'Cozy mountain retreat with ski-in/ski-out access', 'WiFi, Fireplace, Hiking Trails, Ski Storage', 5, '+1-970-555-0789', 'info@mountainview.com');

INSERT INTO rooms (hotel_id, room_number, room_type, capacity, price_per_night) VALUES 
(1, '101', 'Deluxe Ocean View', 2, 299.00),
(1, '102', 'Deluxe Ocean View', 2, 299.00),
(1, '103', 'Deluxe Ocean View', 2, 299.00),
(1, '201', 'Executive Suite', 4, 499.00),
(1, '202', 'Executive Suite', 4, 499.00),
(1, '301', 'Presidential Suite', 6, 899.00),
(1, '302', 'Presidential Suite', 6, 899.00),
(2, '101', 'Standard Room', 2, 199.00),
(2, '102', 'Standard Room', 2, 199.00),
(2, '201', 'Business Suite', 4, 399.00),
(3, '101', 'Mountain View Room', 2, 349.00),
(3, '102', 'Mountain View Room', 2, 349.00),
(3, '201', 'Ski Suite', 4, 599.00);
