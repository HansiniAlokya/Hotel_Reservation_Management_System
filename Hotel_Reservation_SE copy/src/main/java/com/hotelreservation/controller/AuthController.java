package com.hotelreservation.controller;

import com.hotelreservation.dto.UserDTO;
import com.hotelreservation.model.Role;
import com.hotelreservation.model.User;
import com.hotelreservation.repository.RoleRepository;
import com.hotelreservation.repository.UserRepository;
import com.hotelreservation.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import jakarta.servlet.http.HttpSession;

import java.util.HashSet;
import java.util.Set;

@Controller
@RequestMapping("/api/auth")
public class AuthController {

    @Autowired
    private UserService userService;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private RoleRepository roleRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @PostMapping("/login")
    public String login(@RequestParam String email, @RequestParam String password, Model model, HttpSession session) {
        try {
            User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("User not found"));

            if (passwordEncoder.matches(password, user.getPassword())) {
                // Store user info in session
                session.setAttribute("user", user);
                session.setAttribute("userRole", user.getRoles().iterator().next().getName().name());
                session.setAttribute("isGuest", user.getRoles().iterator().next().getName().name().equals("GUEST"));
                
                // Redirect to dashboard on successful login
                return "redirect:/dashboard";
            } else {
                model.addAttribute("error", "Invalid email or password");
                return "login";
            }
        } catch (Exception e) {
            model.addAttribute("error", "Invalid email or password");
            return "login";
        }
    }
    
    // JSON-based login endpoint for API calls
    @PostMapping("/login-json")
    public ResponseEntity<?> loginJson(@RequestBody LoginRequest request, HttpSession session) {
        try {
            User user = userRepository.findByEmail(request.getEmail())
                .orElseThrow(() -> new RuntimeException("User not found"));

            if (passwordEncoder.matches(request.getPassword(), user.getPassword())) {
                // Store user info in session
                session.setAttribute("user", user);
                session.setAttribute("userRole", user.getRoles().iterator().next().getName().name());
                session.setAttribute("isGuest", user.getRoles().iterator().next().getName().name().equals("GUEST"));
                
                return ResponseEntity.ok().body("Login successful");
            } else {
                return ResponseEntity.status(401).body("Invalid email or password");
            }
        } catch (Exception e) {
            return ResponseEntity.status(401).body("Invalid email or password");
        }
    }
    
    // Login request DTO
    public static class LoginRequest {
        private String email;
        private String password;
        
        public String getEmail() { return email; }
        public void setEmail(String email) { this.email = email; }
        public String getPassword() { return password; }
        public void setPassword(String password) { this.password = password; }
    }
    
    // Registration request DTO
    public static class RegistrationRequest {
        private String username;
        private String email;
        private String password;
        private String firstName;
        private String lastName;
        private String phoneNumber;
        private String accountType;
        
        // Getters and setters
        public String getUsername() { return username; }
        public void setUsername(String username) { this.username = username; }
        public String getEmail() { return email; }
        public void setEmail(String email) { this.email = email; }
        public String getPassword() { return password; }
        public void setPassword(String password) { this.password = password; }
        public String getFirstName() { return firstName; }
        public void setFirstName(String firstName) { this.firstName = firstName; }
        public String getLastName() { return lastName; }
        public void setLastName(String lastName) { this.lastName = lastName; }
        public String getPhoneNumber() { return phoneNumber; }
        public void setPhoneNumber(String phoneNumber) { this.phoneNumber = phoneNumber; }
        public String getAccountType() { return accountType; }
        public void setAccountType(String accountType) { this.accountType = accountType; }
    }
    
    // JSON-based registration endpoint for API calls
    @PostMapping("/register")
    @Transactional
    public ResponseEntity<?> register(@RequestBody RegistrationRequest request) {
        try {
            // Check if user already exists
            if (userRepository.findByEmail(request.getEmail()).isPresent()) {
                return ResponseEntity.status(400).body("User with this email already exists");
            }

            // Create new user
            User user = new User();
            user.setUsername(request.getUsername() != null ? request.getUsername() : request.getEmail());
            user.setFirstName(request.getFirstName());
            user.setLastName(request.getLastName());
            user.setEmail(request.getEmail());
            user.setPassword(passwordEncoder.encode(request.getPassword()));
            user.setPhoneNumber(request.getPhoneNumber());

            // Set role - create if it doesn't exist
            Role.RoleType roleType;
            try {
                roleType = Role.RoleType.valueOf(request.getAccountType());
            } catch (IllegalArgumentException e) {
                return ResponseEntity.status(400).body("Invalid account type");
            }
            
            Role userRole = roleRepository.findByName(roleType).orElseGet(() -> {
                Role newRole = new Role(roleType, roleType.name() + " role");
                return roleRepository.save(newRole);
            });
            
            Set<Role> roles = new HashSet<>();
            roles.add(userRole);
            user.setRoles(roles);

            userRepository.save(user);

            return ResponseEntity.ok().body("Account created successfully");
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(500).body("Registration failed: " + e.getMessage());
        }
    }


    @PostMapping("/register-form")
    @Transactional
    public String registerForm(@RequestParam String firstName,
                          @RequestParam String lastName,
                          @RequestParam String email,
                          @RequestParam String password,
                          @RequestParam String phone,
                          @RequestParam String role,
                          Model model) {
        try {
            // Check if user already exists
            if (userRepository.findByEmail(email).isPresent()) {
                model.addAttribute("error", "User with this email already exists");
                return "register";
            }

            // Create new user
            User user = new User();
            user.setUsername(email); // Use email as username for now
            user.setFirstName(firstName);
            user.setLastName(lastName);
            user.setEmail(email);
            user.setPassword(passwordEncoder.encode(password));
            user.setPhoneNumber(phone);

            // Set role - create if it doesn't exist
            Role.RoleType roleType;
            try {
                roleType = Role.RoleType.valueOf(role);
            } catch (IllegalArgumentException e) {
                model.addAttribute("error", "Invalid role selected");
                return "register";
            }
            
            Role userRole = roleRepository.findByName(roleType).orElseGet(() -> {
                Role newRole = new Role(roleType, roleType.name() + " role");
                return roleRepository.save(newRole);
            });
            
            Set<Role> roles = new HashSet<>();
            roles.add(userRole);
            user.setRoles(roles);

            userRepository.save(user);

            model.addAttribute("success", "Account created successfully! Please sign in.");
            return "login";
        } catch (Exception e) {
            e.printStackTrace(); // Log the error for debugging
            model.addAttribute("error", "Registration failed: " + e.getMessage());
            return "register";
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }
}
