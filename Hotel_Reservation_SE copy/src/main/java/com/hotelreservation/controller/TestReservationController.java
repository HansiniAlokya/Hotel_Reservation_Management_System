package com.hotelreservation.controller;

import com.hotelreservation.dto.ReservationResponseDTO;
import com.hotelreservation.model.User;
import com.hotelreservation.repository.UserRepository;
import com.hotelreservation.service.ReservationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/test")
public class TestReservationController {
    
    @Autowired
    private ReservationService reservationService;
    
    @Autowired
    private UserRepository userRepository;
    
    @GetMapping("/reservations")
    public Map<String, Object> testReservations() {
        Map<String, Object> response = new HashMap<>();
        
        try {
            // Find test user
            User user = userRepository.findByEmail("test@example.com").orElse(null);
            
            if (user == null) {
                response.put("error", "Test user not found");
                return response;
            }
            
            response.put("userId", user.getId());
            response.put("userEmail", user.getEmail());
            
            // Try to fetch reservations
            List<ReservationResponseDTO> reservations = reservationService.getReservationsByUser(user.getId());
            
            response.put("success", true);
            response.put("reservationCount", reservations.size());
            response.put("reservations", reservations);
            
        } catch (Exception e) {
            response.put("success", false);
            response.put("error", e.getMessage());
            response.put("errorType", e.getClass().getName());
            e.printStackTrace();
        }
        
        return response;
    }
}

