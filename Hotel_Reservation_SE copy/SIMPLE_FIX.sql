-- SIMPLE FIX - Copy and paste ALL of this into MySQL Workbench and run it

USE hotel_reservation_db;

-- Show current columns
SELECT 'BEFORE:' AS status;
SHOW COLUMNS FROM reservations;

-- Drop the column if it exists (to start fresh)
ALTER TABLE reservations DROP COLUMN IF EXISTS event_id;

-- Now add it properly
ALTER TABLE reservations 
ADD COLUMN event_id BIGINT NULL AFTER user_id;

-- Make hotel_id nullable
ALTER TABLE reservations 
MODIFY COLUMN hotel_id BIGINT NULL;

-- Show updated columns
SELECT 'AFTER:' AS status;
SHOW COLUMNS FROM reservations;

-- Confirm success
SELECT 'SUCCESS! Column added. Now restart Spring Boot app!' AS message;

