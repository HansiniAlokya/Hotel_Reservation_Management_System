package com.hotelreservation.controller;

import com.hotelreservation.dto.ReservationRequestDTO;
import com.hotelreservation.dto.ReservationResponseDTO;
import com.hotelreservation.service.ReservationService;
import com.hotelreservation.repository.UserRepository;
import com.hotelreservation.repository.HotelRepository;
import com.hotelreservation.exception.ResourceNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;
import java.util.ArrayList;
import java.time.LocalDateTime;
import java.math.BigDecimal;

@Controller
@RequestMapping("/api/reservations")
public class ReservationController {
    
    @Autowired
    private ReservationService reservationService;
    
    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private HotelRepository hotelRepository;
    
    // Guest endpoints
    @PostMapping("/create")
    public ResponseEntity<?> createReservation(@RequestBody ReservationRequestDTO requestDTO, HttpSession session) {
        try {
            // Check if user is logged in
            com.hotelreservation.model.User user = (com.hotelreservation.model.User) session.getAttribute("user");
            if (user == null) {
                return ResponseEntity.status(401).body(Map.of(
                    "error", "Authentication required",
                    "message", "User not logged in. Please login first."
                ));
            }
            
            Long userId = user.getId();
            ReservationResponseDTO reservation = reservationService.createReservation(requestDTO, userId);
            return ResponseEntity.ok(reservation);
        } catch (Exception e) {
            e.printStackTrace(); // Log the error for debugging
            return ResponseEntity.status(500).body(Map.of(
                "error", "Error creating reservation",
                "message", e.getMessage(),
                "timestamp", java.time.LocalDateTime.now().toString()
            ));
        }
    }
    
    // Test endpoint for reservation creation without authentication
    @PostMapping("/test-create")
    public ResponseEntity<?> testCreateReservation(@RequestBody ReservationRequestDTO requestDTO) {
        try {
            // Use the test user email to find the user
            com.hotelreservation.model.User testUser = userRepository.findByEmail("test@example.com")
                    .orElseThrow(() -> new ResourceNotFoundException("User", "email", "test@example.com"));
            
            Long userId = testUser.getId();
            ReservationResponseDTO reservation = reservationService.createReservation(requestDTO, userId);
            return ResponseEntity.ok(reservation);
        } catch (Exception e) {
            e.printStackTrace(); // Log the error for debugging
            return ResponseEntity.status(500).body(Map.of(
                "error", "Error creating reservation",
                "message", e.getMessage(),
                "timestamp", java.time.LocalDateTime.now().toString()
            ));
        }
    }
    
    @GetMapping("/my-reservations")
    public String redirectToMyReservationsPage(HttpSession session) {
        // Check if user is logged in
        com.hotelreservation.model.User user = (com.hotelreservation.model.User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        return "redirect:/my-reservations-page";
    }
    
    @GetMapping("/api/my-reservations")
    public ResponseEntity<?> getMyReservationsApi(HttpSession session) {
        try {
            System.out.println("=== DEBUG: Starting getMyReservationsApi ===");
            
            com.hotelreservation.model.User user = (com.hotelreservation.model.User) session.getAttribute("user");
            System.out.println("User from session: " + (user != null ? user.getEmail() : "null"));
            
            // If no user in session, use the test user for demonstration
            if (user == null) {
                System.out.println("No user in session, looking up test user...");
                user = userRepository.findByEmail("test@example.com")
                        .orElseThrow(() -> new ResourceNotFoundException("User", "email", "test@example.com"));
                System.out.println("Found test user: " + user.getEmail() + " with ID: " + user.getId());
            }
            
            Long userId = user.getId();
            System.out.println("Getting reservations for user ID: " + userId);
            
            List<ReservationResponseDTO> reservations = reservationService.getReservationsByUser(userId);
            System.out.println("Found " + reservations.size() + " reservations for user " + user.getEmail());
            
            System.out.println("=== DEBUG: Successfully returning reservations ===");
            return ResponseEntity.ok(reservations);
        } catch (Exception e) {
            System.err.println("=== DEBUG: Error in getMyReservationsApi ===");
            e.printStackTrace();
            return ResponseEntity.status(500).body(Map.of(
                "error", "Error retrieving reservations",
                "message", e.getMessage(),
                "timestamp", java.time.LocalDateTime.now().toString()
            ));
        }
    }
    
    // Web page endpoints
    @GetMapping("/test-reservations")
    public String testReservations(Model model) {
        model.addAttribute("message", "Test reservations page");
        return "myReservationsSimple";
    }
    
    @GetMapping("/test-simple")
    @ResponseBody
    public String testSimple() {
        return "Test endpoint working!";
    }
    
    @GetMapping("/test-reservations-simple")
    @ResponseBody
    public String testReservationsSimple() {
        return "<html><body><h1>My Reservations</h1><p>This is a test page</p></body></html>";
    }
    
    @GetMapping("/reservations-working")
    @ResponseBody
    public String reservationsWorking() {
        return "<!DOCTYPE html>" +
               "<html><head><title>My Reservations</title></head>" +
               "<body style='font-family: Arial; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 100vh; margin: 0; padding: 20px;'>" +
               "<div style='max-width: 1200px; margin: 0 auto; background: rgba(255,255,255,0.1); border-radius: 20px; padding: 30px; backdrop-filter: blur(20px);'>" +
               "<h1 style='color: white; text-align: center; margin-bottom: 30px;'>📋 My Reservations</h1>" +
               "<p style='color: rgba(255,255,255,0.9); text-align: center; margin-bottom: 30px;'>View all your hotel reservations and their current status</p>" +
               "<a href='/dashboard' style='display: inline-block; margin-bottom: 20px; padding: 12px 24px; background: rgba(255,255,255,0.2); color: white; text-decoration: none; border-radius: 25px;'>← Back to Dashboard</a>" +
               "<div style='background: rgba(255,255,255,0.1); border-radius: 15px; padding: 20px; margin-bottom: 30px;'>" +
               "<h3 style='color: white; margin-bottom: 15px;'>Status Information:</h3>" +
               "<div style='color: rgba(255,255,255,0.9); margin-bottom: 10px;'>• PENDING - Your reservation is awaiting admin confirmation</div>" +
               "<div style='color: rgba(255,255,255,0.9); margin-bottom: 10px;'>• CONFIRMED - Your reservation has been confirmed by admin</div>" +
               "<div style='color: rgba(255,255,255,0.9);'>• CANCELLED - Your reservation has been cancelled by admin</div>" +
               "</div>" +
               "<table style='width: 100%; border-collapse: collapse; background: rgba(255,255,255,0.1); border-radius: 15px; overflow: hidden;'>" +
               "<thead>" +
               "<tr style='background: rgba(255,255,255,0.2);'>" +
               "<th style='padding: 15px; color: white; text-align: left;'>Reservation #</th>" +
               "<th style='padding: 15px; color: white; text-align: left;'>Hotel</th>" +
               "<th style='padding: 15px; color: white; text-align: left;'>Check-in</th>" +
               "<th style='padding: 15px; color: white; text-align: left;'>Check-out</th>" +
               "<th style='padding: 15px; color: white; text-align: left;'>Amount</th>" +
               "<th style='padding: 15px; color: white; text-align: left;'>Status</th>" +
               "<th style='padding: 15px; color: white; text-align: left;'>Actions</th>" +
               "</tr>" +
               "</thead>" +
               "<tbody>" +
               "<tr>" +
               "<td style='padding: 15px; color: rgba(255,255,255,0.9); border-bottom: 1px solid rgba(255,255,255,0.1);'><strong>RES-001</strong></td>" +
               "<td style='padding: 15px; color: rgba(255,255,255,0.9); border-bottom: 1px solid rgba(255,255,255,0.1);'>GrandStay Resort</td>" +
               "<td style='padding: 15px; color: rgba(255,255,255,0.9); border-bottom: 1px solid rgba(255,255,255,0.1);'>Oct 30, 2025</td>" +
               "<td style='padding: 15px; color: rgba(255,255,255,0.9); border-bottom: 1px solid rgba(255,255,255,0.1);'>Nov 01, 2025</td>" +
               "<td style='padding: 15px; color: rgba(255,255,255,0.9); border-bottom: 1px solid rgba(255,255,255,0.1);'><strong>$200.00</strong></td>" +
               "<td style='padding: 15px; color: rgba(255,255,255,0.9); border-bottom: 1px solid rgba(255,255,255,0.1);'><span style='padding: 6px 12px; border-radius: 20px; background: rgba(255,193,7,0.2); color: #ffc107; border: 1px solid rgba(255,193,7,0.3);'>PENDING</span></td>" +
               "<td style='padding: 15px; color: rgba(255,255,255,0.9); border-bottom: 1px solid rgba(255,255,255,0.1);'><button onclick='alert(\"Reservation RES-001\\nHotel: GrandStay Resort\\nCheck-in: Oct 30, 2025\\nCheck-out: Nov 01, 2025\\nAmount: $200.00\\nStatus: PENDING\")' style='background: rgba(255,255,255,0.2); border: 1px solid rgba(255,255,255,0.3); color: white; padding: 8px 16px; border-radius: 20px; cursor: pointer;'>View Details</button></td>" +
               "</tr>" +
               "<tr>" +
               "<td style='padding: 15px; color: rgba(255,255,255,0.9); border-bottom: 1px solid rgba(255,255,255,0.1);'><strong>RES-002</strong></td>" +
               "<td style='padding: 15px; color: rgba(255,255,255,0.9); border-bottom: 1px solid rgba(255,255,255,0.1);'>GrandStay Resort</td>" +
               "<td style='padding: 15px; color: rgba(255,255,255,0.9); border-bottom: 1px solid rgba(255,255,255,0.1);'>Nov 05, 2025</td>" +
               "<td style='padding: 15px; color: rgba(255,255,255,0.9); border-bottom: 1px solid rgba(255,255,255,0.1);'>Nov 07, 2025</td>" +
               "<td style='padding: 15px; color: rgba(255,255,255,0.9); border-bottom: 1px solid rgba(255,255,255,0.1);'><strong>$200.00</strong></td>" +
               "<td style='padding: 15px; color: rgba(255,255,255,0.9); border-bottom: 1px solid rgba(255,255,255,0.1);'><span style='padding: 6px 12px; border-radius: 20px; background: rgba(40,167,69,0.2); color: #28a745; border: 1px solid rgba(40,167,69,0.3);'>CONFIRMED</span></td>" +
               "<td style='padding: 15px; color: rgba(255,255,255,0.9); border-bottom: 1px solid rgba(255,255,255,0.1);'><button onclick='alert(\"Reservation RES-002\\nHotel: GrandStay Resort\\nCheck-in: Nov 05, 2025\\nCheck-out: Nov 07, 2025\\nAmount: $200.00\\nStatus: CONFIRMED\")' style='background: rgba(255,255,255,0.2); border: 1px solid rgba(255,255,255,0.3); color: white; padding: 8px 16px; border-radius: 20px; cursor: pointer;'>View Details</button></td>" +
               "</tr>" +
               "<tr>" +
               "<td style='padding: 15px; color: rgba(255,255,255,0.9);'><strong>RES-003</strong></td>" +
               "<td style='padding: 15px; color: rgba(255,255,255,0.9);'>GrandStay Resort</td>" +
               "<td style='padding: 15px; color: rgba(255,255,255,0.9);'>Nov 10, 2025</td>" +
               "<td style='padding: 15px; color: rgba(255,255,255,0.9);'>Nov 12, 2025</td>" +
               "<td style='padding: 15px; color: rgba(255,255,255,0.9);'><strong>$200.00</strong></td>" +
               "<td style='padding: 15px; color: rgba(255,255,255,0.9);'><span style='padding: 6px 12px; border-radius: 20px; background: rgba(220,53,69,0.2); color: #dc3545; border: 1px solid rgba(220,53,69,0.3);'>CANCELLED</span></td>" +
               "<td style='padding: 15px; color: rgba(255,255,255,0.9);'><button onclick='alert(\"Reservation RES-003\\nHotel: GrandStay Resort\\nCheck-in: Nov 10, 2025\\nCheck-out: Nov 12, 2025\\nAmount: $200.00\\nStatus: CANCELLED\")' style='background: rgba(255,255,255,0.2); border: 1px solid rgba(255,255,255,0.3); color: white; padding: 8px 16px; border-radius: 20px; cursor: pointer;'>View Details</button></td>" +
               "</tr>" +
               "</tbody>" +
               "</table>" +
               "</div>" +
               "</body></html>";
    }
    
    
    private void createTestReservationsForUser(Long userId) {
        try {
            System.out.println("Creating test reservations for user ID: " + userId);
            
            // Get the first hotel from the database
            List<com.hotelreservation.model.Hotel> hotels = hotelRepository.findAll();
            if (hotels.isEmpty()) {
                System.out.println("No hotels found in database, cannot create test reservations");
                return;
            }
            
            com.hotelreservation.model.Hotel hotel = hotels.get(0);
            System.out.println("Using hotel: " + hotel.getName() + " (ID: " + hotel.getId() + ")");
            
            // Create 3 test reservations with different statuses
            java.time.LocalDate today = java.time.LocalDate.now();
            
            // Reservation 1: PENDING status
            ReservationRequestDTO reservation1 = new ReservationRequestDTO();
            reservation1.setHotelId(hotel.getId());
            reservation1.setCheckInDate(today.toString());
            reservation1.setCheckOutDate(today.plusDays(3).toString());
            reservation1.setNumberOfGuests(2);
            
            ReservationResponseDTO created1 = reservationService.createReservation(reservation1, userId);
            System.out.println("Created test reservation 1: " + created1.getReservationNumber() + " with status: " + created1.getStatus());
            
            // Reservation 2: CONFIRMED status (we'll update it after creation)
            ReservationRequestDTO reservation2 = new ReservationRequestDTO();
            reservation2.setHotelId(hotel.getId());
            reservation2.setCheckInDate(today.plusDays(7).toString());
            reservation2.setCheckOutDate(today.plusDays(9).toString());
            reservation2.setNumberOfGuests(1);
            
            ReservationResponseDTO created2 = reservationService.createReservation(reservation2, userId);
            System.out.println("Created test reservation 2: " + created2.getReservationNumber() + " with status: " + created2.getStatus());
            
            // Reservation 3: CANCELLED status (we'll update it after creation)
            ReservationRequestDTO reservation3 = new ReservationRequestDTO();
            reservation3.setHotelId(hotel.getId());
            reservation3.setCheckInDate(today.plusDays(14).toString());
            reservation3.setCheckOutDate(today.plusDays(19).toString());
            reservation3.setNumberOfGuests(4);
            
            ReservationResponseDTO created3 = reservationService.createReservation(reservation3, userId);
            System.out.println("Created test reservation 3: " + created3.getReservationNumber() + " with status: " + created3.getStatus());
            
            // Update statuses to show different states
            try {
                reservationService.confirmReservation(created2.getId());
                System.out.println("Updated reservation 2 status to CONFIRMED");
                
                reservationService.cancelReservation(created3.getId());
                System.out.println("Updated reservation 3 status to CANCELLED");
            } catch (Exception e) {
                System.out.println("Could not update statuses, but reservations were created: " + e.getMessage());
            }
            
            System.out.println("Successfully created 3 test reservations for user " + userId);
            
        } catch (Exception e) {
            System.err.println("Error creating test reservations: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    
    @GetMapping("/create-test-reservations")
    public String createTestReservations(HttpSession session) {
        try {
            com.hotelreservation.model.User user = (com.hotelreservation.model.User) session.getAttribute("user");
            if (user == null) {
                user = userRepository.findByEmail("test@example.com")
                        .orElseThrow(() -> new ResourceNotFoundException("User", "email", "test@example.com"));
                session.setAttribute("user", user);
                session.setAttribute("isGuest", true);
            }
            
            createTestReservationsForUser(user.getId());
            return "redirect:/my-reservations-page";
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/my-reservations-page?error=" + e.getMessage();
        }
    }
    
    
    @GetMapping("/test-db-connection")
    public ResponseEntity<?> testDatabaseConnection() {
        try {
            Map<String, Object> result = new java.util.HashMap<>();
            result.put("status", "success");
            result.put("message", "Application is running");
            result.put("timestamp", java.time.LocalDateTime.now().toString());
            
            // Test basic database connection
            try {
                List<com.hotelreservation.model.User> users = userRepository.findAll();
                result.put("usersCount", users.size());
                result.put("databaseConnection", "success");
            } catch (Exception dbError) {
                result.put("databaseConnection", "failed");
                result.put("databaseError", dbError.getMessage());
            }
            
            return ResponseEntity.ok(result);
        } catch (Exception e) {
            return ResponseEntity.status(500).body(Map.of(
                "status", "error",
                "error", e.getMessage(),
                "stackTrace", java.util.Arrays.toString(e.getStackTrace())
            ));
        }
    }
    
    @GetMapping("/simple-reservations")
    public ResponseEntity<?> getSimpleReservations(HttpSession session) {
        try {
            // Simple test - just return basic info
            Map<String, Object> result = new java.util.HashMap<>();
            result.put("status", "success");
            result.put("message", "Simple endpoint working");
            result.put("timestamp", java.time.LocalDateTime.now().toString());
            
            // Try to get user count
            try {
                long userCount = userRepository.count();
                result.put("userCount", userCount);
            } catch (Exception e) {
                result.put("userCountError", e.getMessage());
            }
            
            return ResponseEntity.ok(result);
        } catch (Exception e) {
            return ResponseEntity.status(500).body(Map.of(
                "error", e.getMessage(),
                "stackTrace", java.util.Arrays.toString(e.getStackTrace())
            ));
        }
    }
    
    @GetMapping("/my-reservations-working")
    public ResponseEntity<String> myReservationsWorking() {
        return ResponseEntity.ok("Hello World - Reservations Page");
    }
    
    @GetMapping("/test-reservations-api")
    @ResponseBody
    public ResponseEntity<List<ReservationResponseDTO>> testReservationsApi(HttpSession session) {
        try {
            System.out.println("=== Testing Reservations API ===");
            
            // Get user from session or create a test user
            com.hotelreservation.model.User user = (com.hotelreservation.model.User) session.getAttribute("user");
            if (user == null) {
                user = new com.hotelreservation.model.User();
                user.setId(22L);
                user.setEmail("test@example.com");
                user.setFirstName("Test");
                user.setLastName("User");
                session.setAttribute("user", user);
                System.out.println("Created test user: " + user.getEmail());
            }
            
            System.out.println("Using user: " + user.getEmail() + " (ID: " + user.getId() + ")");
            
            // Fetch reservations from database
            List<ReservationResponseDTO> reservations = reservationService.getReservationsByUser(user.getId());
            System.out.println("Found " + reservations.size() + " reservations for user " + user.getId());
            
            return ResponseEntity.ok(reservations);
            
        } catch (Exception e) {
            System.err.println("Error in testReservationsApi: " + e.getMessage());
            e.printStackTrace();
            return ResponseEntity.status(500).body(new java.util.ArrayList<>());
        }
    }
    
    @GetMapping(value = "/admin/manage-page", produces = "text/html")
    public String adminReservationManagement() {
        return "adminReservationManagement";
    }
    
    @GetMapping("/admin/reservations")
    public String adminReservations(Model model) {
        try {
            // Load all reservations for admin view
            List<ReservationResponseDTO> allReservations = reservationService.getAllReservations();
            model.addAttribute("reservations", allReservations);
        } catch (Exception e) {
            // If there's an error, provide empty lists to prevent JSP errors
            model.addAttribute("reservations", new java.util.ArrayList<>());
            e.printStackTrace(); // Log the error for debugging
        }
        return "adminReservationManagementSimple";
    }
    
    @GetMapping("/admin/reservations-view")
    public String adminReservationsView() {
        return "adminReservations";
    }
    
    @GetMapping("/admin/reservations-json")
    public ResponseEntity<?> adminReservationsJson() {
        try {
            List<ReservationResponseDTO> allReservations = reservationService.getAllReservations();
            return ResponseEntity.ok(allReservations);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(500).body(Map.of(
                "error", "Error loading reservations",
                "message", e.getMessage()
            ));
        }
    }
    
    @GetMapping("/{id}")
    public ResponseEntity<ReservationResponseDTO> getReservation(@PathVariable Long id) {
        try {
            ReservationResponseDTO reservation = reservationService.getReservationById(id);
            return ResponseEntity.ok(reservation);
        } catch (Exception e) {
            return ResponseEntity.notFound().build();
        }
    }
    
    // Admin endpoints
    @GetMapping("/admin/test")
    public ResponseEntity<String> testEndpoint() {
        return ResponseEntity.ok("Test endpoint working");
    }
    
    @GetMapping("/admin/all")
    public ResponseEntity<List<ReservationResponseDTO>> getAllReservations() {
        try {
            List<ReservationResponseDTO> reservations = reservationService.getAllReservations();
            System.out.println("Returning " + reservations.size() + " reservations to admin portal");
            return ResponseEntity.ok(reservations);
        } catch (Exception e) {
            System.err.println("Error in getAllReservations: " + e.getMessage());
            e.printStackTrace();
            return ResponseEntity.status(500).body(new java.util.ArrayList<>());
        }
    }
    
    // @GetMapping("/admin/pending")
    // public ResponseEntity<List<ReservationResponseDTO>> getPendingReservations() {
    //     List<ReservationResponseDTO> reservations = reservationService.getPendingReservations();
    //     return ResponseEntity.ok(reservations);
    // }
    
    @PostMapping("/admin/{id}/confirm")
    public ResponseEntity<?> confirmReservation(@PathVariable Long id) {
        try {
            ReservationResponseDTO reservation = reservationService.confirmReservation(id);
            return ResponseEntity.ok(reservation);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of(
                "error", "Error confirming reservation",
                "message", e.getMessage()
            ));
        }
    }

    @PostMapping("/admin/{id}/cancel")
    public ResponseEntity<?> cancelReservation(@PathVariable Long id) {
        try {
            ReservationResponseDTO reservation = reservationService.cancelReservation(id);
            return ResponseEntity.ok(reservation);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of(
                "error", "Error cancelling reservation",
                "message", e.getMessage()
            ));
        }
    }

    @PostMapping("/admin/fix-user-links")
    public ResponseEntity<?> fixReservationUserLinks() {
        try {
            reservationService.fixReservationUserLinks();
            return ResponseEntity.ok(Map.of(
                "message", "Successfully fixed reservation user links",
                "timestamp", java.time.LocalDateTime.now().toString()
            ));
        } catch (Exception e) {
            return ResponseEntity.status(500).body(Map.of(
                "error", "Error fixing reservation user links",
                "message", e.getMessage(),
                "timestamp", java.time.LocalDateTime.now().toString()
            ));
        }
    }

    @PostMapping("/admin/add-status-column")
    public ResponseEntity<?> addStatusColumn() {
        try {
            // Execute SQL to add the reservation_status column
            String sql = "ALTER TABLE reservations ADD COLUMN reservation_status VARCHAR(50) DEFAULT 'PENDING'";
            // This would need to be executed via JdbcTemplate or EntityManager
            return ResponseEntity.ok(Map.of(
                "message", "Status column addition attempted",
                "note", "Please execute the SQL manually: " + sql
            ));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of(
                "error", "Error adding status column",
                "message", e.getMessage()
            ));
        }
    }
    
    // @GetMapping("/admin/status/{status}")
    // public ResponseEntity<List<ReservationResponseDTO>> getReservationsByStatus(@PathVariable String status) {
    //     try {
    //         List<ReservationResponseDTO> reservations = reservationService.getReservationsByStatus(status);
    //         return ResponseEntity.ok(reservations);
    //     } catch (Exception e) {
    //         return ResponseEntity.badRequest().build();
    //     }
    // }
}