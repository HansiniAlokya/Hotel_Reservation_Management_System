-- Add event_id column to existing reservations table WITHOUT dropping data
-- Run this in MySQL Workbench

USE hotel_reservation_db;

-- Add event_id column (nullable, so existing rows won't break)
ALTER TABLE reservations 
ADD COLUMN event_id BIGINT NULL;

-- Make hotel_id nullable too (for event-only reservations)
ALTER TABLE reservations 
MODIFY COLUMN hotel_id BIGINT NULL;

-- Verify the changes
DESCRIBE reservations;

SELECT 'Column added successfully!' AS Status;

