-- Fix event_id column in reservations table
-- This makes event_id nullable so hotel reservations can be created without an event

-- Check if column exists, if not add it, if yes modify it to be nullable
ALTER TABLE reservations 
MODIFY COLUMN event_id BIGINT NULL;

-- Also make hotel_id nullable since we might have event-only reservations
ALTER TABLE reservations 
MODIFY COLUMN hotel_id BIGINT NULL;

-- Show the updated structure
DESCRIBE reservations;

