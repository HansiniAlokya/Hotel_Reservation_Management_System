package com.hotelreservation.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

@Component
public class DatabaseConnectionTest implements CommandLineRunner {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public void run(String... args) throws Exception {
        try {
            // Test database connection
            String result = jdbcTemplate.queryForObject("SELECT 'MySQL Connection Successful' as message", String.class);
            System.out.println("✅ " + result);
            
            // Test database name
            String dbName = jdbcTemplate.queryForObject("SELECT DATABASE()", String.class);
            System.out.println("✅ Connected to database: " + dbName);
            
            // Test MySQL version
            String version = jdbcTemplate.queryForObject("SELECT VERSION()", String.class);
            System.out.println("✅ MySQL Version: " + version);
            
        } catch (Exception e) {
            System.err.println("❌ Database connection failed: " + e.getMessage());
            System.err.println("Please check:");
            System.err.println("1. MySQL server is running");
            System.err.println("2. Database credentials are correct");
            System.err.println("3. Database 'hotel_reservation_db' exists or can be created");
            System.err.println("4. User has proper privileges");
        }
    }
}
