package com.hotelreservation.controller;

import com.hotelreservation.model.User;
import com.hotelreservation.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/api/profile")
public class ProfileController {
    
    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private PasswordEncoder passwordEncoder;
    
    /**
     * Update username
     */
    @PostMapping("/update-username")
    public ResponseEntity<?> updateUsername(@RequestBody Map<String, Object> request) {
        try {
            Long userId = Long.valueOf(request.get("userId").toString());
            String newUsername = request.get("newUsername").toString();
            
            // Validate input
            if (newUsername == null || newUsername.trim().isEmpty()) {
                return ResponseEntity.badRequest().body(Map.of(
                    "success", false,
                    "message", "Username cannot be empty"
                ));
            }
            
            // Check if username already exists
            Optional<User> existingUser = userRepository.findByUsername(newUsername);
            if (existingUser.isPresent() && !existingUser.get().getId().equals(userId)) {
                return ResponseEntity.badRequest().body(Map.of(
                    "success", false,
                    "message", "Username already taken"
                ));
            }
            
            // Find and update user
            Optional<User> userOpt = userRepository.findById(userId);
            if (userOpt.isEmpty()) {
                return ResponseEntity.badRequest().body(Map.of(
                    "success", false,
                    "message", "User not found"
                ));
            }
            
            User user = userOpt.get();
            user.setUsername(newUsername);
            userRepository.save(user);
            
            System.out.println("Username updated successfully for user " + userId);
            
            return ResponseEntity.ok(Map.of(
                "success", true,
                "message", "Username updated successfully",
                "newUsername", newUsername
            ));
            
        } catch (Exception e) {
            System.err.println("Error updating username: " + e.getMessage());
            e.printStackTrace();
            return ResponseEntity.status(500).body(Map.of(
                "success", false,
                "message", "Error updating username: " + e.getMessage()
            ));
        }
    }
    
    /**
     * Update password
     */
    @PostMapping("/update-password")
    public ResponseEntity<?> updatePassword(@RequestBody Map<String, Object> request) {
        try {
            Long userId = Long.valueOf(request.get("userId").toString());
            String currentPassword = request.get("currentPassword").toString();
            String newPassword = request.get("newPassword").toString();
            
            // Validate input
            if (newPassword == null || newPassword.length() < 6) {
                return ResponseEntity.badRequest().body(Map.of(
                    "success", false,
                    "message", "Password must be at least 6 characters"
                ));
            }
            
            // Find user
            Optional<User> userOpt = userRepository.findById(userId);
            if (userOpt.isEmpty()) {
                return ResponseEntity.badRequest().body(Map.of(
                    "success", false,
                    "message", "User not found"
                ));
            }
            
            User user = userOpt.get();
            
            // Verify current password
            if (!passwordEncoder.matches(currentPassword, user.getPassword())) {
                return ResponseEntity.badRequest().body(Map.of(
                    "success", false,
                    "message", "Current password is incorrect"
                ));
            }
            
            // Update password
            user.setPassword(passwordEncoder.encode(newPassword));
            userRepository.save(user);
            
            System.out.println("Password updated successfully for user " + userId);
            
            return ResponseEntity.ok(Map.of(
                "success", true,
                "message", "Password updated successfully"
            ));
            
        } catch (Exception e) {
            System.err.println("Error updating password: " + e.getMessage());
            e.printStackTrace();
            return ResponseEntity.status(500).body(Map.of(
                "success", false,
                "message", "Error updating password: " + e.getMessage()
            ));
        }
    }
}

