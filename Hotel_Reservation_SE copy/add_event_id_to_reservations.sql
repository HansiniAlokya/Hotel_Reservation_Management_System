-- Add event_id column to reservations table if it doesn't exist
USE hotel_reservation_db;

-- Add event_id column (nullable)
ALTER TABLE reservations 
ADD COLUMN IF NOT EXISTS event_id BIGINT NULL AFTER user_id;

-- Add foreign key constraint
ALTER TABLE reservations 
ADD CONSTRAINT fk_reservations_event 
FOREIGN KEY (event_id) REFERENCES events(event_id) 
ON DELETE SET NULL;

-- Make hotel_id nullable too (in case it's not)
ALTER TABLE reservations 
MODIFY COLUMN hotel_id BIGINT NULL;

-- Show the updated structure
DESCRIBE reservations;

