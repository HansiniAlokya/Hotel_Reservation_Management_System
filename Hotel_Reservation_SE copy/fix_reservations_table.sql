-- Fix reservations table by dropping and letting Hibernate recreate it
-- Run this in MySQL Workbench

USE hotel_reservation_db;

-- Drop dependent tables first (foreign key constraints)
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS reservations;

-- Show confirmation
SELECT 'Tables dropped successfully! Now restart your Spring Boot application.' AS Status;

