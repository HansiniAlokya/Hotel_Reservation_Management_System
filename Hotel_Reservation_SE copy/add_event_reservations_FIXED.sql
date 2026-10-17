-- Migration to add event reservation support
-- Run this script on your existing database

-- Step 1: Add event_id column to reservations table
ALTER TABLE reservations 
ADD COLUMN event_id BIGINT NULL AFTER hotel_id;

-- Step 2: Add foreign key constraint for event_id (using correct column name)
ALTER TABLE reservations
ADD CONSTRAINT fk_reservations_event
FOREIGN KEY (event_id) REFERENCES events(event_id) ON DELETE CASCADE;

-- Step 3: Make hotel_id nullable (since reservation could be for hotel OR event)
ALTER TABLE reservations 
MODIFY COLUMN hotel_id BIGINT NULL;

-- Step 4: Update reservation_status enum to include RESERVED
ALTER TABLE reservations 
MODIFY COLUMN reservation_status ENUM('PENDING', 'CONFIRMED', 'RESERVED', 'CHECKED_IN', 'CHECKED_OUT', 'CANCELLED', 'NO_SHOW') DEFAULT 'PENDING';

-- Verify the changes
DESCRIBE reservations;

SELECT 'Migration completed successfully!' AS status;

