-- Add reservation_status column to reservations table
ALTER TABLE reservations ADD COLUMN reservation_status VARCHAR(20) DEFAULT 'PENDING';

-- Update existing reservations to have PENDING status
UPDATE reservations SET reservation_status = 'PENDING' WHERE reservation_status IS NULL;
