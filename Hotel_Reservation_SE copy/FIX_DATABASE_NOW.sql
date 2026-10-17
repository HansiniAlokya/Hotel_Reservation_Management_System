-- COMPLETE DATABASE FIX - Run ALL of this in MySQL Workbench
-- This will add the missing event_id column to reservations table

USE hotel_reservation_db;

-- Step 1: Check current structure
SELECT 'BEFORE - Current reservations table structure:' AS '';
DESCRIBE reservations;

-- Step 2: Add event_id column if it doesn't exist
-- Using a procedure to check if column exists first
SET @dbname = 'hotel_reservation_db';
SET @tablename = 'reservations';
SET @columnname = 'event_id';
SET @preparedStatement = (SELECT IF(
  (
    SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS
    WHERE
      (table_name = @tablename)
      AND (table_schema = @dbname)
      AND (column_name = @columnname)
  ) > 0,
  "SELECT 'Column event_id already exists' AS Info;",
  "ALTER TABLE reservations ADD COLUMN event_id BIGINT NULL;"
));
PREPARE alterIfNotExists FROM @preparedStatement;
EXECUTE alterIfNotExists;
DEALLOCATE PREPARE alterIfNotExists;

-- Step 3: Make hotel_id nullable (for event-only reservations)
ALTER TABLE reservations 
MODIFY COLUMN hotel_id BIGINT NULL;

-- Step 4: Make sure user_id is NOT NULL
ALTER TABLE reservations 
MODIFY COLUMN user_id BIGINT NOT NULL;

-- Step 5: Verify the final structure
SELECT 'AFTER - Updated reservations table structure:' AS '';
DESCRIBE reservations;

-- Step 6: Show success message
SELECT 'SUCCESS! Database structure updated. Now RESTART your Spring Boot application!' AS Status;

