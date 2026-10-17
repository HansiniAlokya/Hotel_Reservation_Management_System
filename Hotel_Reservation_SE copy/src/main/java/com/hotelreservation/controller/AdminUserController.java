package com.hotelreservation.controller;

import com.hotelreservation.dto.UserDTO;
import com.hotelreservation.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/api/admin")
public class AdminUserController {
    
    @Autowired
    private UserService userService;
    
    @GetMapping("/users")
    public String getAllUsersPage() {
        return "adminUserManagement";
    }
    
    @GetMapping("/users/api")
    public ResponseEntity<?> getAllUsersApi() {
        try {
            System.out.println("Getting all users...");
            List<UserDTO> users = userService.getAllUsers();
            System.out.println("Found " + users.size() + " users");
            return ResponseEntity.ok(users);
        } catch (Exception e) {
            System.err.println("Error getting users: " + e.getMessage());
            e.printStackTrace();
            return ResponseEntity.status(500).body(Map.of(
                "error", "Error getting users",
                "message", e.getMessage()
            ));
        }
    }
    
    @GetMapping("/users/test")
    public ResponseEntity<?> testUsers() {
        return ResponseEntity.ok(Map.of("message", "User management endpoint is working"));
    }
    
    @PutMapping("/users/api/{id}")
    public ResponseEntity<?> updateUserApi(@PathVariable Long id, @RequestBody UserDTO userDTO) {
        try {
            UserDTO updatedUser = userService.updateUser(id, userDTO);
            return ResponseEntity.ok(updatedUser);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of(
                "error", "Error updating user",
                "message", e.getMessage()
            ));
        }
    }
    
    @DeleteMapping("/users/api/{id}")
    public ResponseEntity<?> deleteUserApi(@PathVariable Long id) {
        try {
            userService.deleteUser(id);
            return ResponseEntity.ok(Map.of(
                "message", "User deleted successfully"
            ));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of(
                "error", "Error deleting user",
                "message", e.getMessage()
            ));
        }
    }
    
    @PutMapping("/users/{id}")
    public ResponseEntity<?> updateUser(@PathVariable Long id, @RequestBody UserDTO userDTO) {
        try {
            UserDTO updatedUser = userService.updateUser(id, userDTO);
            return ResponseEntity.ok(updatedUser);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of(
                "error", "Error updating user",
                "message", e.getMessage()
            ));
        }
    }
    
    @DeleteMapping("/users/{id}")
    public ResponseEntity<?> deleteUser(@PathVariable Long id) {
        try {
            userService.deleteUser(id);
            return ResponseEntity.ok(Map.of(
                "message", "User deleted successfully"
            ));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of(
                "error", "Error deleting user",
                "message", e.getMessage()
            ));
        }
    }
    
}
