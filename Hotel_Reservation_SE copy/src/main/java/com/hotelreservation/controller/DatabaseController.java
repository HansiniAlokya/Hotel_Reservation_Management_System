package com.hotelreservation.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.Statement;

@RestController
@RequestMapping("/api/admin")
public class DatabaseController {

    @Autowired
    private DataSource dataSource;

    @PostMapping("/add-reservation-status-column")
    public ResponseEntity<String> addReservationStatusColumn() {
        try (Connection connection = dataSource.getConnection();
             Statement statement = connection.createStatement()) {
            
            // Add the reservation_status column
            statement.executeUpdate("ALTER TABLE reservations ADD COLUMN reservation_status VARCHAR(20) DEFAULT 'PENDING'");
            
            // Update existing reservations to have PENDING status
            statement.executeUpdate("UPDATE reservations SET reservation_status = 'PENDING' WHERE reservation_status IS NULL");
            
            return ResponseEntity.ok("Reservation status column added successfully!");
            
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Error adding column: " + e.getMessage());
        }
    }
}
