-- MySQL Database Setup Script for Hotel Reservation System
-- Run this script in MySQL Workbench or MySQL command line

-- Create database
CREATE DATABASE IF NOT EXISTS hotel_reservation_db 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

-- Use the database
USE hotel_reservation_db;

-- Create a dedicated user for the application (optional)
CREATE USER IF NOT EXISTS 'hotelapp'@'localhost' IDENTIFIED BY 'hotelapp123';
GRANT ALL PRIVILEGES ON hotel_reservation_db.* TO 'hotelapp'@'localhost';
FLUSH PRIVILEGES;

-- Verify database creation
SHOW DATABASES;

-- Show current database
SELECT DATABASE();

-- Note: Tables will be created automatically by Hibernate when you run the application
-- The following tables will be created:
-- - roles
-- - users  
-- - user_roles
-- - hotels
-- - rooms
-- - events
-- - reservations
-- - payments

-- After running the application, you can verify data with:
-- SELECT * FROM users;
-- SELECT * FROM roles;
-- SELECT * FROM hotels;
-- SELECT * FROM events;
