-- Hotel Reservation System Sample Data
-- This file contains sample data for testing the hotel reservation system

USE hotel_reservation_db;

-- Insert roles
INSERT INTO roles (name, description) VALUES
('ADMIN', 'System administrator with full access'),
('MANAGER', 'Hotel manager with management privileges'),
('RECEPTIONIST', 'Front desk staff with reservation management access'),
('GUEST', 'Regular guest user');

-- Insert sample users
INSERT INTO users (username, email, password, first_name, last_name, phone_number, is_active) VALUES
('admin', 'admin@hotel.com', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'Admin', 'User', '+1-555-0101', TRUE),
('manager1', 'manager@hotel.com', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'John', 'Manager', '+1-555-0102', TRUE),
('reception1', 'reception@hotel.com', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'Sarah', 'Receptionist', '+1-555-0103', TRUE),
('guest1', 'guest1@email.com', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'Alice', 'Johnson', '+1-555-0201', TRUE),
('guest2', 'guest2@email.com', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'Bob', 'Smith', '+1-555-0202', TRUE);

-- Assign roles to users
INSERT INTO user_roles (user_id, role_id) VALUES
(1, 1), -- admin has ADMIN role
(2, 2), -- manager1 has MANAGER role
(3, 3), -- reception1 has RECEPTIONIST role
(4, 4), -- guest1 has GUEST role
(5, 4); -- guest2 has GUEST role

-- Insert sample events
INSERT INTO events (name, description, start_date, end_date, location, max_capacity, current_bookings, price_per_person, event_status) VALUES
('Summer Wedding Reception', 'Beautiful outdoor wedding reception with garden setting', '2024-06-15 18:00:00', '2024-06-15 23:00:00', 'Grand Ballroom', 150, 0, 125.00, 'ACTIVE'),
('Corporate Conference 2024', 'Annual corporate conference with keynote speakers', '2024-07-20 09:00:00', '2024-07-22 17:00:00', 'Conference Center', 300, 0, 200.00, 'ACTIVE'),
('Birthday Celebration', 'Elegant birthday party with live music', '2024-08-10 19:00:00', '2024-08-10 24:00:00', 'Private Dining Room', 50, 0, 85.00, 'ACTIVE'),
('Holiday Gala', 'Annual holiday celebration with dinner and dancing', '2024-12-15 18:30:00', '2024-12-15 23:30:00', 'Main Hall', 200, 0, 150.00, 'ACTIVE'),
('Graduation Party', 'University graduation celebration', '2024-05-25 16:00:00', '2024-05-25 22:00:00', 'Student Center', 100, 0, 75.00, 'ACTIVE');

-- Insert sample guests
INSERT INTO guests (first_name, last_name, email, phone_number, address, city, postal_code, country, nationality, passport_number, special_requirements) VALUES
('Alice', 'Johnson', 'alice.johnson@email.com', '+1-555-0201', '123 Main St', 'New York', '10001', 'USA', 'American', 'A1234567', 'Vegetarian meals required'),
('Bob', 'Smith', 'bob.smith@email.com', '+1-555-0202', '456 Oak Ave', 'Los Angeles', '90210', 'USA', 'American', 'B2345678', 'Wheelchair accessible room needed'),
('Carol', 'Davis', 'carol.davis@email.com', '+1-555-0203', '789 Pine St', 'Chicago', '60601', 'USA', 'American', 'C3456789', 'Late check-in after 10 PM'),
('David', 'Wilson', 'david.wilson@email.com', '+1-555-0204', '321 Elm St', 'Houston', '77001', 'USA', 'American', 'D4567890', 'Ground floor room preferred'),
('Emma', 'Brown', 'emma.brown@email.com', '+1-555-0205', '654 Maple Dr', 'Phoenix', '85001', 'USA', 'American', 'E5678901', 'Quiet room away from elevators');

-- Insert sample reservations
INSERT INTO reservations (reservation_number, user_id, event_id, guest_id, check_in_date, check_out_date, number_of_guests, total_amount, reservation_status, special_requests) VALUES
('RES1734567890123', 4, 1, 1, '2024-06-15 17:00:00', '2024-06-15 23:30:00', 2, 250.00, 'CONFIRMED', 'Table near the dance floor'),
('RES1734567890124', 5, 2, 2, '2024-07-20 08:00:00', '2024-07-22 18:00:00', 1, 200.00, 'PENDING', 'Vegetarian lunch options'),
('RES1734567890125', 4, 3, 3, '2024-08-10 18:30:00', '2024-08-10 23:30:00', 4, 340.00, 'CONFIRMED', 'Birthday cake delivery'),
('RES1734567890126', 5, 4, 4, '2024-12-15 18:00:00', '2024-12-15 23:30:00', 2, 300.00, 'PENDING', 'Holiday decorations'),
('RES1734567890127', 4, 5, 5, '2024-05-25 15:30:00', '2024-05-25 22:30:00', 3, 225.00, 'CONFIRMED', 'Graduation ceremony seating');

-- Insert sample payments
INSERT INTO payments (payment_reference, reservation_id, amount, payment_method, payment_status, transaction_id, payment_date) VALUES
('PAY1734567890123', 1, 250.00, 'CREDIT_CARD', 'COMPLETED', 'TXN1734567890123', '2024-06-10 14:30:00'),
('PAY1734567890124', 2, 200.00, 'DEBIT_CARD', 'PENDING', NULL, NULL),
('PAY1734567890125', 3, 340.00, 'CREDIT_CARD', 'COMPLETED', 'TXN1734567890125', '2024-08-05 16:45:00'),
('PAY1734567890126', 4, 300.00, 'BANK_TRANSFER', 'PENDING', NULL, NULL),
('PAY1734567890127', 5, 225.00, 'CREDIT_CARD', 'COMPLETED', 'TXN1734567890127', '2024-05-20 11:20:00');

-- Update event current bookings based on confirmed reservations
UPDATE events SET current_bookings = (
    SELECT COUNT(*) FROM reservations 
    WHERE event_id = events.id 
    AND reservation_status IN ('CONFIRMED', 'CHECKED_IN')
) WHERE id IN (1, 2, 3, 4, 5);
