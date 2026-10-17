-- Add reservation_status column to reservations table
USE hotel_reservation_db;

-- Add the reservation_status column
ALTER TABLE reservations 
ADD COLUMN reservation_status VARCHAR(20) DEFAULT 'PENDING';

-- Update existing reservations to have PENDING status
UPDATE reservations 
SET reservation_status = 'PENDING' 
WHERE reservation_status IS NULL;

-- Make the column NOT NULL after setting default values
ALTER TABLE reservations 
MODIFY COLUMN reservation_status VARCHAR(20) NOT NULL DEFAULT 'PENDING';

-- Add a check constraint to ensure valid status values
ALTER TABLE reservations 
ADD CONSTRAINT chk_reservation_status 
CHECK (reservation_status IN ('PENDING', 'CONFIRMED', 'CHECKED_IN', 'CHECKED_OUT', 'CANCELLED', 'NO_SHOW'));

-- Show the updated table structure
DESCRIBE reservations;
