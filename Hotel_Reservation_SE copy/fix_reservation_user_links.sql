-- Fix existing reservations by linking them to the test user
-- This script updates reservations that have null user_id to be linked to the test user

USE hotel_reservation_db;

-- First, let's see what users exist
SELECT id, username, email FROM users;

-- Update reservations with null user_id to be linked to the test user (ID 1)
-- Assuming the test user has ID 1 (first user created)
UPDATE reservations 
SET user_id = (
    SELECT id FROM users WHERE email = 'test@example.com' LIMIT 1
)
WHERE user_id IS NULL;

-- Verify the update
SELECT r.id, r.reservation_number, r.user_id, u.username, u.email 
FROM reservations r 
LEFT JOIN users u ON r.user_id = u.id;
