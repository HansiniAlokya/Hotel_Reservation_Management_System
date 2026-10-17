# Fix Reservations Table Schema

The error occurs because the existing `reservations` table doesn't have the `event_id` column.

## Option 1: Drop and Recreate (Recommended - Quick Fix)

1. **Stop your Spring Boot application**

2. **Open MySQL command line or MySQL Workbench** and run:
   ```sql
   USE hotel_reservation_db;
   DROP TABLE IF EXISTS payments;
   DROP TABLE IF EXISTS reservations;
   ```

3. **Restart your Spring Boot application**
   - Hibernate will automatically recreate the tables with the correct schema

## Option 2: Manually Add Column

If you want to keep existing reservation data:

```sql
USE hotel_reservation_db;

-- Add event_id column
ALTER TABLE reservations 
ADD COLUMN event_id BIGINT NULL AFTER user_id;

-- Make hotel_id nullable
ALTER TABLE reservations 
MODIFY COLUMN hotel_id BIGINT NULL;
```

## How to Run MySQL Commands

**From Terminal:**
```bash
mysql -u root -pKulith@123
```

Then paste the SQL commands above.

**Or use MySQL Workbench** to connect and run the SQL.

After running either option, restart your application and try creating a reservation again!

