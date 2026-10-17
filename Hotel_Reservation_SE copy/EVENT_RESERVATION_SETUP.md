# Event Reservation Setup Guide

## Overview
Event reservations have been successfully implemented! When users reserve an event, it will now:
1. Create a reservation in the database
2. Set the status to "RESERVED"
3. Display in the my-reservations page at `http://localhost:8080/my-reservations-page`

## Database Migration Required

Before testing, you need to update your database schema to support event reservations.

### Option 1: Run the Migration Script (Recommended)

1. Open MySQL Workbench or your MySQL client
2. Connect to your `hotel_reservation_db` database
3. Open and run the file: `add_event_reservations.sql`

```sql
-- This will:
-- 1. Add event_id column to reservations table
-- 2. Add foreign key constraint for events
-- 3. Make hotel_id nullable (since reservation can be for hotel OR event)
-- 4. Add 'RESERVED' to the reservation_status enum
```

### Option 2: Recreate Database (Alternative)

If you prefer to start fresh:

1. Drop and recreate your database:
```sql
DROP DATABASE IF EXISTS hotel_reservation_db;
CREATE DATABASE hotel_reservation_db;
USE hotel_reservation_db;
```

2. Run the updated schema from `src/main/resources/db/create_tables.sql`

## What Was Changed

### 1. Reservation Model
- ✅ Added `event` field to link reservations to events
- ✅ Added `RESERVED` status to the ReservationStatus enum

### 2. ReservationService
- ✅ Added `createEventReservation()` method
- ✅ Updated `getAllReservations()` to handle event reservations
- ✅ Updated `getReservationsByUser()` to display event reservations

### 3. GuestController
- ✅ Updated `reserveEvent()` to actually create reservations (previously just showed a message)

### 4. Database Schema
- ✅ Updated reservations table to support both hotel and event reservations
- ✅ Added `event_id` column (nullable)
- ✅ Made `hotel_id` nullable
- ✅ Added 'RESERVED' to status enum

## How to Test

1. **Run the database migration** (see above)

2. **Start your application**
```bash
./mvnw spring-boot:run
```

3. **Browse events**
   - Go to: `http://localhost:8080/guest/browse-events`
   - Click on any event's "Reserve Now" button

4. **Fill reservation form**
   - Enter your details
   - Submit the form

5. **Check your reservations**
   - Go to: `http://localhost:8080/my-reservations-page`
   - You should see your event reservation with status "RESERVED"

## Expected Behavior

### Event Reservations Display:
- **Hotel/Event Name**: Shows the event name
- **Type**: "Event Reservation"
- **Status**: "RESERVED"
- **Date**: Event date
- **Reservation Number**: Starts with "EVT-"

### Hotel Reservations Display:
- **Hotel/Event Name**: Shows the hotel name
- **Type**: "Hotel Reservation"
- **Status**: "PENDING", "CONFIRMED", etc.
- **Reservation Number**: Starts with "RES"

## Troubleshooting

### Error: "Column 'event_id' doesn't exist"
**Solution**: Run the migration script `add_event_reservations.sql`

### Error: "Unknown column 'RESERVED' in field list"
**Solution**: The status enum wasn't updated. Run the migration script.

### Events don't show in reservations
**Solution**: 
1. Check that the event was actually reserved (look for success message)
2. Verify you're logged in with the same user
3. Check database: `SELECT * FROM reservations WHERE event_id IS NOT NULL;`

### Migration script fails
**Solution**: Drop the foreign key first if it already exists:
```sql
ALTER TABLE reservations DROP FOREIGN KEY IF EXISTS fk_reservations_event;
```
Then run the migration script again.

## Database Verification

After running the migration, verify with:

```sql
-- Check table structure
DESCRIBE reservations;

-- Check for event reservations
SELECT 
    r.reservation_number,
    r.reservation_status,
    e.event_name,
    u.email
FROM reservations r
LEFT JOIN events e ON r.event_id = e.event_id
LEFT JOIN users u ON r.user_id = u.id
WHERE r.event_id IS NOT NULL;
```

## Success! 🎉

Once you see your event reservations appearing on the my-reservations page with "RESERVED" status, everything is working correctly!

