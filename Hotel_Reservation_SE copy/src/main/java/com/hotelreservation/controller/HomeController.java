package com.hotelreservation.controller;

import com.hotelreservation.model.User;
import com.hotelreservation.model.Hotel;
import com.hotelreservation.repository.UserRepository;
import com.hotelreservation.service.HotelService;
import com.hotelreservation.service.ReservationService;
import com.hotelreservation.dto.ReservationResponseDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import jakarta.servlet.http.HttpSession;

import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Optional;

@Controller
public class HomeController {
    
    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private HotelService hotelService;
    
    @Autowired
    private ReservationService reservationService;
    
    @GetMapping("/")
    public String home() {
        return "index";
    }
    
    @GetMapping("/login")
    public String login() {
        return "login";
    }
    
    @GetMapping("/register")
    public String register() {
        return "register";
    }
    
    @GetMapping("/events")
    public String events() {
        return "events";
    }
    
    @GetMapping("/guest-portal")
    public String guestPortal() {
        return "guestPortal";
    }
    
    @GetMapping("/dashboard")
    public String dashboard(Model model, HttpSession session) {
        // Get user info from session
        User user = (User) session.getAttribute("user");
        String userRole = (String) session.getAttribute("userRole");
        Boolean isGuest = (Boolean) session.getAttribute("isGuest");
        
        if (user != null) {
            model.addAttribute("user", user);
            model.addAttribute("userRole", userRole);
            model.addAttribute("isGuest", isGuest);
        }
        
        return "dashboard";
    }
    
    @GetMapping("/reservations")
    public String reservations() {
        return "reservations";
    }
    
    @GetMapping("/payments")
    public String payments() {
        return "redirect:/api/payments";
    }
    
    @GetMapping("/reports")
    public String reports() {
        return "reports";
    }
    
    @GetMapping("/my-reservations")
    public String myReservations() {
        return "redirect:/my-reservations-page";
    }
    
    @GetMapping("/my-reservations-page")
    @ResponseBody
    public String myReservationsPage(HttpSession session) {
        try {
            // Get user from session or use test user
            User user = (User) session.getAttribute("user");
            if (user == null) {
                user = userRepository.findByEmail("test@example.com").orElse(null);
            }
            
            if (user == null) {
                return buildErrorPage("No user found. Please login first.");
            }
            
            // Fetch reservations
            List<ReservationResponseDTO> reservations = new java.util.ArrayList<>();
            try {
                reservations = reservationService.getReservationsByUser(user.getId());
            } catch (Exception e) {
                System.err.println("Error fetching reservations: " + e.getMessage());
                e.printStackTrace();
            }
            
            return buildReservationsPage(user, reservations);
            
        } catch (Exception e) {
            System.err.println("Error: " + e.getMessage());
            e.printStackTrace();
            return buildErrorPage("Error: " + e.getMessage());
        }
    }
    
    private String buildReservationsPage(User user, List<ReservationResponseDTO> reservations) {
        StringBuilder html = new StringBuilder();
        html.append("<!DOCTYPE html><html><head><meta charset='UTF-8'><meta name='viewport' content='width=device-width,initial-scale=1.0'>");
        html.append("<title>My Reservations - GrandStay Paradise</title>");
        html.append("<style>");
        html.append("*{margin:0;padding:0;box-sizing:border-box}");
        html.append("body{font-family:'Segoe UI',Arial,sans-serif;");
        html.append("background:linear-gradient(135deg,#667eea 0%,#764ba2 50%,#f093fb 100%);");
        html.append("background-attachment:fixed;min-height:100vh;padding:20px;");
        html.append("background-image:url('https://images.unsplash.com/photo-1566073771259-6a8506099945?w=1920&q=80');");
        html.append("background-size:cover;background-position:center;background-blend-mode:overlay}");
        html.append(".container{max-width:1200px;margin:0 auto;background:rgba(255,255,255,0.95);");
        html.append("border-radius:20px;padding:40px;box-shadow:0 20px 60px rgba(0,0,0,0.3);backdrop-filter:blur(10px)}");
        html.append(".header{text-align:center;margin-bottom:30px;padding-bottom:20px;border-bottom:2px solid #667eea}");
        html.append("h1{color:#333;font-size:2.5rem;margin-bottom:10px;background:linear-gradient(135deg,#667eea,#764ba2);");
        html.append("-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text}");
        html.append(".user-info{display:flex;justify-content:space-between;align-items:center;padding:15px;");
        html.append("background:linear-gradient(135deg,rgba(102,126,234,0.1),rgba(118,75,162,0.1));");
        html.append("border-radius:10px;margin-bottom:20px}");
        html.append(".user-email{color:#667eea;font-weight:600;font-size:1.1rem}");
        html.append(".count-badge{background:linear-gradient(135deg,#667eea,#764ba2);color:white;");
        html.append("padding:8px 20px;border-radius:20px;font-weight:bold;box-shadow:0 4px 10px rgba(102,126,234,0.3)}");
        html.append("table{width:100%;border-collapse:collapse;margin-top:20px;overflow:hidden;border-radius:10px;");
        html.append("box-shadow:0 4px 15px rgba(0,0,0,0.1)}");
        html.append("th{background:linear-gradient(135deg,#667eea,#764ba2);color:white;padding:15px;text-align:left;");
        html.append("font-weight:600;text-transform:uppercase;letter-spacing:1px;font-size:0.9rem}");
        html.append("td{padding:15px;border-bottom:1px solid #e0e0e0;color:#333;transition:background 0.3s ease}");
        html.append("tr:hover td{background:rgba(102,126,234,0.05)}");
        html.append("tr:last-child td{border-bottom:none}");
        html.append(".badge{padding:6px 14px;border-radius:20px;color:white;font-weight:bold;font-size:0.85rem;");
        html.append("display:inline-block;box-shadow:0 2px 8px rgba(0,0,0,0.2);text-transform:uppercase;letter-spacing:0.5px}");
        html.append(".PENDING{background:linear-gradient(135deg,#ffc107,#ff9800)}");
        html.append(".CONFIRMED,.RESERVED{background:linear-gradient(135deg,#28a745,#20c997)}");
        html.append(".CHECKED_IN{background:linear-gradient(135deg,#007bff,#0056b3)}");
        html.append(".CHECKED_OUT{background:linear-gradient(135deg,#6c757d,#495057)}");
        html.append(".CANCELLED,.NO_SHOW{background:linear-gradient(135deg,#dc3545,#c82333)}");
        html.append(".nav-buttons{margin-top:30px;display:flex;gap:15px;justify-content:center;flex-wrap:wrap}");
        html.append(".btn{padding:12px 30px;border-radius:25px;text-decoration:none;font-weight:600;");
        html.append("transition:all 0.3s ease;display:inline-block;box-shadow:0 4px 15px rgba(0,0,0,0.2)}");
        html.append(".btn-primary{background:linear-gradient(135deg,#667eea,#764ba2);color:white}");
        html.append(".btn-primary:hover{transform:translateY(-2px);box-shadow:0 6px 20px rgba(102,126,234,0.4)}");
        html.append(".btn-secondary{background:white;color:#667eea;border:2px solid #667eea}");
        html.append(".btn-secondary:hover{background:#667eea;color:white;transform:translateY(-2px)}");
        html.append(".empty-state{text-align:center;padding:60px 20px;color:#666}");
        html.append(".empty-state h3{color:#333;margin-bottom:15px;font-size:1.5rem}");
        html.append("@media(max-width:768px){.container{padding:20px}h1{font-size:1.8rem}");
        html.append("table{font-size:0.9rem}th,td{padding:10px}.user-info{flex-direction:column;gap:10px}}");
        html.append("</style></head><body>");
        html.append("<div class='container'>");
        html.append("<div class='header'><h1>📋 My Reservations</h1>");
        html.append("<p style='color:#666;font-size:1.1rem'>View and manage your hotel reservations</p></div>");
        html.append("<div class='user-info'>");
        html.append("<span class='user-email'>👤 ").append(user.getEmail()).append("</span>");
        html.append("<span class='count-badge'>").append(reservations.size()).append(" Reservation");
        html.append(reservations.size() != 1 ? "s" : "").append("</span></div>");
        
        if (reservations.isEmpty()) {
            html.append("<div class='empty-state'>");
            html.append("<h3>🏨 No Reservations Yet</h3>");
            html.append("<p style='margin:20px 0'>You haven't made any reservations yet. Start planning your perfect getaway!</p>");
            html.append("<a href='/make-reservation' class='btn btn-primary'>Make Your First Reservation</a>");
            html.append("</div>");
        } else {
            html.append("<table><tr><th>ID</th><th>Reservation #</th><th>Hotel/Event</th><th>Check-in</th><th>Check-out</th><th>Amount</th><th>Status</th></tr>");
            
            java.time.format.DateTimeFormatter formatter = java.time.format.DateTimeFormatter.ofPattern("MMM dd, yyyy");
            
            for (ReservationResponseDTO r : reservations) {
                html.append("<tr>");
                html.append("<td>").append(r.getId()).append("</td>");
                html.append("<td>").append(r.getReservationNumber() != null ? r.getReservationNumber() : "N/A").append("</td>");
                html.append("<td>").append(r.getHotelName() != null ? r.getHotelName() : "N/A").append("</td>");
                html.append("<td>").append(r.getCheckInDate() != null ? r.getCheckInDate().format(formatter) : "N/A").append("</td>");
                html.append("<td>").append(r.getCheckOutDate() != null ? r.getCheckOutDate().format(formatter) : "N/A").append("</td>");
                html.append("<td>$").append(r.getTotalAmount() != null ? String.format("%.2f", r.getTotalAmount()) : "0.00").append("</td>");
                String status = r.getStatus() != null ? r.getStatus() : "PENDING";
                html.append("<td><span class='badge ").append(status).append("'>").append(status).append("</span></td>");
                html.append("</tr>");
            }
            
            html.append("</table>");
        }
        
        html.append("<div class='nav-buttons'>");
        html.append("<a href='/dashboard' class='btn btn-secondary'>← Back to Dashboard</a>");
        html.append("<a href='/make-reservation' class='btn btn-primary'>+ Make New Reservation</a>");
        html.append("</div></div></body></html>");
        return html.toString();
    }
    
    private String buildErrorPage(String message) {
        return "<!DOCTYPE html><html><head><title>Error</title></head><body style='font-family:Arial;padding:20px'>" +
               "<h1>Error</h1><p>" + message + "</p><a href='/dashboard'>Back to Dashboard</a></body></html>";
    }
    
    private String getStatusStyle(String status) {
        if (status == null) {
            return "background: rgba(255,193,7,0.2); color: #ffc107; border: 1px solid rgba(255,193,7,0.3);";
        }
        
        switch (status.toUpperCase()) {
            case "PENDING":
                return "background: rgba(255,193,7,0.2); color: #ffc107; border: 1px solid rgba(255,193,7,0.3);";
            case "CONFIRMED":
                return "background: rgba(40,167,69,0.2); color: #28a745; border: 1px solid rgba(40,167,69,0.3);";
            case "CHECKED_IN":
                return "background: rgba(0,123,255,0.2); color: #007bff; border: 1px solid rgba(0,123,255,0.3);";
            case "CHECKED_OUT":
                return "background: rgba(108,117,125,0.2); color: #6c757d; border: 1px solid rgba(108,117,125,0.3);";
            case "CANCELLED":
                return "background: rgba(220,53,69,0.2); color: #dc3545; border: 1px solid rgba(220,53,69,0.3);";
            case "NO_SHOW":
                return "background: rgba(220,53,69,0.2); color: #dc3545; border: 1px solid rgba(220,53,69,0.3);";
            default:
                return "background: rgba(255,193,7,0.2); color: #ffc107; border: 1px solid rgba(255,193,7,0.3);";
        }
    }
    
    @GetMapping("/profile")
    @ResponseBody
    public String profile(HttpSession session) {
        try {
            User user = (User) session.getAttribute("user");
            if (user == null) {
                user = userRepository.findByEmail("test@example.com").orElse(null);
            }
            
            if (user == null) {
                return buildErrorPage("No user found. Please login first.");
            }
            
            return buildProfilePage(user);
        } catch (Exception e) {
            System.err.println("Error loading profile: " + e.getMessage());
            e.printStackTrace();
            return buildErrorPage("Error loading profile: " + e.getMessage());
        }
    }
    
    private String buildProfilePage(User user) {
        StringBuilder html = new StringBuilder();
        html.append("<!DOCTYPE html><html><head><meta charset='UTF-8'><meta name='viewport' content='width=device-width,initial-scale=1.0'>");
        html.append("<title>My Profile - GrandStay Paradise</title>");
        html.append("<style>");
        html.append("*{margin:0;padding:0;box-sizing:border-box}");
        html.append("body{font-family:'Segoe UI',Arial,sans-serif;");
        html.append("background:url('https://images.unsplash.com/photo-1538683270504-3d09ad7ae739?w=1920') center center/cover no-repeat fixed;");
        html.append("min-height:100vh;padding:20px;margin:0}");
        html.append(".container{max-width:900px;margin:0 auto;background:rgba(255,255,255,0.05);");
        html.append("backdrop-filter:blur(25px);-webkit-backdrop-filter:blur(25px);");
        html.append("border:1px solid rgba(255,255,255,0.1);");
        html.append("border-radius:20px;padding:40px;box-shadow:0 20px 40px rgba(0,0,0,0.1)}");
        html.append(".header{text-align:center;margin-bottom:40px;padding-bottom:20px;border-bottom:2px solid rgba(255,255,255,0.2)}");
        html.append("h1{color:#fff;font-size:2.5rem;margin-bottom:10px;text-shadow:2px 2px 4px rgba(0,0,0,0.3)}");
        html.append(".profile-info{background:rgba(255,255,255,0.08);");
        html.append("backdrop-filter:blur(20px);-webkit-backdrop-filter:blur(20px);");
        html.append("border:1px solid rgba(255,255,255,0.15);");
        html.append("border-radius:15px;padding:30px;margin-bottom:30px}");
        html.append(".info-row{display:flex;justify-content:space-between;padding:15px 0;border-bottom:1px solid rgba(255,255,255,0.1)}");
        html.append(".info-row:last-child{border-bottom:none}");
        html.append(".info-label{font-weight:600;color:#fff;font-size:1rem;text-shadow:1px 1px 2px rgba(0,0,0,0.3)}");
        html.append(".info-value{color:#fff;font-size:1rem;text-shadow:1px 1px 2px rgba(0,0,0,0.3)}");
        html.append(".section{background:rgba(255,255,255,0.08);backdrop-filter:blur(20px);-webkit-backdrop-filter:blur(20px);");
        html.append("border:1px solid rgba(255,255,255,0.15);border-radius:15px;padding:30px;margin-bottom:20px;");
        html.append("box-shadow:0 10px 20px rgba(0,0,0,0.1)}");
        html.append(".section h2{color:#fff;font-size:1.5rem;margin-bottom:20px;padding-bottom:10px;");
        html.append("border-bottom:2px solid rgba(255,255,255,0.2);text-shadow:1px 1px 2px rgba(0,0,0,0.3)}");
        html.append(".form-group{margin-bottom:20px}");
        html.append(".form-group label{display:block;color:#fff;font-weight:600;margin-bottom:8px;font-size:0.95rem;text-shadow:1px 1px 2px rgba(0,0,0,0.3)}");
        html.append(".form-group input{width:100%;padding:12px 15px;border:1px solid rgba(255,255,255,0.2);border-radius:10px;");
        html.append("font-size:0.95rem;transition:all 0.3s ease;background:rgba(255,255,255,0.9);color:#333}");
        html.append(".form-group input:focus{outline:none;border-color:#667eea;background:white;");
        html.append("box-shadow:0 0 0 3px rgba(102,126,234,0.3)}");
        html.append(".btn{padding:12px 30px;border-radius:25px;font-weight:600;border:none;cursor:pointer;");
        html.append("transition:all 0.3s ease;font-size:1rem;margin-right:10px;text-decoration:none;display:inline-block}");
        html.append(".btn-primary{background:#667eea;color:white}");
        html.append(".btn-primary:hover{background:#5a6fd8;transform:translateY(-2px);box-shadow:0 6px 20px rgba(102,126,234,0.5)}");
        html.append(".btn-secondary{background:rgba(255,255,255,0.15);color:#fff;border:1px solid rgba(255,255,255,0.3);");
        html.append("backdrop-filter:blur(10px);-webkit-backdrop-filter:blur(10px)}");
        html.append(".btn-secondary:hover{background:rgba(255,255,255,0.25);transform:translateY(-2px)}");
        html.append(".alert{padding:15px 20px;border-radius:10px;margin-bottom:20px;font-weight:500;display:none}");
        html.append(".alert-success{background:rgba(40,167,69,0.1);color:#28a745;border:1px solid rgba(40,167,69,0.2)}");
        html.append(".alert-error{background:rgba(220,53,69,0.1);color:#dc3545;border:1px solid rgba(220,53,69,0.2)}");
        html.append(".nav-buttons{margin-top:30px;display:flex;gap:15px;justify-content:center;flex-wrap:wrap}");
        html.append("@media(max-width:768px){.container{padding:20px}h1{font-size:1.8rem}");
        html.append(".info-row{flex-direction:column;gap:5px}}");
        html.append("</style></head><body>");
        html.append("<div class='container'>");
        html.append("<div class='header'><h1>👤 My Profile</h1>");
        html.append("<p style='color:rgba(255,255,255,0.9);font-size:1.1rem;text-shadow:1px 1px 2px rgba(0,0,0,0.3)'>Manage your account information</p></div>");
        
        // Account Information Section
        html.append("<div class='profile-info'>");
        html.append("<h2 style='color:#fff;margin-bottom:20px;font-size:1.3rem;text-shadow:1px 1px 2px rgba(0,0,0,0.3)'>📋 Account Information</h2>");
        html.append("<div class='info-row'><span class='info-label'>Full Name:</span>");
        html.append("<span class='info-value'>").append(user.getFirstName()).append(" ").append(user.getLastName()).append("</span></div>");
        html.append("<div class='info-row'><span class='info-label'>Username:</span>");
        html.append("<span class='info-value'>").append(user.getUsername() != null ? user.getUsername() : "N/A").append("</span></div>");
        html.append("<div class='info-row'><span class='info-label'>Email:</span>");
        html.append("<span class='info-value'>").append(user.getEmail()).append("</span></div>");
        html.append("<div class='info-row'><span class='info-label'>Phone:</span>");
        html.append("<span class='info-value'>").append(user.getPhoneNumber() != null ? user.getPhoneNumber() : "N/A").append("</span></div>");
        html.append("<div class='info-row'><span class='info-label'>Account ID:</span>");
        html.append("<span class='info-value'>#").append(user.getId()).append("</span></div>");
        html.append("</div>");
        
        // Update Username Section
        html.append("<div class='section'>");
        html.append("<h2>🔤 Change Username</h2>");
        html.append("<div id='username-alert' class='alert'></div>");
        html.append("<form id='username-form' onsubmit='updateUsername(event)'>");
        html.append("<div class='form-group'>");
        html.append("<label for='new-username'>New Username</label>");
        html.append("<input type='text' id='new-username' name='newUsername' placeholder='Enter new username' required>");
        html.append("</div>");
        html.append("<button type='submit' class='btn btn-primary'>Update Username</button>");
        html.append("</form></div>");
        
        // Update Password Section
        html.append("<div class='section'>");
        html.append("<h2>🔒 Change Password</h2>");
        html.append("<div id='password-alert' class='alert'></div>");
        html.append("<form id='password-form' onsubmit='updatePassword(event)'>");
        html.append("<div class='form-group'>");
        html.append("<label for='current-password'>Current Password</label>");
        html.append("<input type='password' id='current-password' name='currentPassword' placeholder='Enter current password' required>");
        html.append("</div>");
        html.append("<div class='form-group'>");
        html.append("<label for='new-password'>New Password</label>");
        html.append("<input type='password' id='new-password' name='newPassword' placeholder='Enter new password' required minlength='6'>");
        html.append("</div>");
        html.append("<div class='form-group'>");
        html.append("<label for='confirm-password'>Confirm New Password</label>");
        html.append("<input type='password' id='confirm-password' name='confirmPassword' placeholder='Confirm new password' required>");
        html.append("</div>");
        html.append("<button type='submit' class='btn btn-primary'>Update Password</button>");
        html.append("</form></div>");
        
        // Navigation Buttons
        html.append("<div class='nav-buttons'>");
        html.append("<a href='/dashboard' class='btn btn-secondary'>← Back to Dashboard</a>");
        html.append("<a href='/my-reservations-page' class='btn btn-secondary'>My Reservations</a>");
        html.append("</div></div>");
        
        // JavaScript
        html.append("<script>");
        html.append("const userId = ").append(user.getId()).append(";");
        
        html.append("function updateUsername(e) {");
        html.append("  e.preventDefault();");
        html.append("  const newUsername = document.getElementById('new-username').value;");
        html.append("  const alert = document.getElementById('username-alert');");
        html.append("  fetch('/api/profile/update-username', {");
        html.append("    method: 'POST',");
        html.append("    headers: {'Content-Type': 'application/json'},");
        html.append("    body: JSON.stringify({userId: userId, newUsername: newUsername})");
        html.append("  }).then(r => r.json()).then(data => {");
        html.append("    if (data.success) {");
        html.append("      alert.className = 'alert alert-success';");
        html.append("      alert.style.display = 'block';");
        html.append("      alert.textContent = '✓ Username updated successfully!';");
        html.append("      setTimeout(() => location.reload(), 1500);");
        html.append("    } else {");
        html.append("      alert.className = 'alert alert-error';");
        html.append("      alert.style.display = 'block';");
        html.append("      alert.textContent = '✗ ' + (data.message || 'Failed to update username');");
        html.append("    }");
        html.append("  }).catch(err => {");
        html.append("    alert.className = 'alert alert-error';");
        html.append("    alert.style.display = 'block';");
        html.append("    alert.textContent = '✗ Error: ' + err.message;");
        html.append("  });");
        html.append("}");
        
        html.append("function updatePassword(e) {");
        html.append("  e.preventDefault();");
        html.append("  const currentPassword = document.getElementById('current-password').value;");
        html.append("  const newPassword = document.getElementById('new-password').value;");
        html.append("  const confirmPassword = document.getElementById('confirm-password').value;");
        html.append("  const alert = document.getElementById('password-alert');");
        html.append("  if (newPassword !== confirmPassword) {");
        html.append("    alert.className = 'alert alert-error';");
        html.append("    alert.style.display = 'block';");
        html.append("    alert.textContent = '✗ Passwords do not match!';");
        html.append("    return;");
        html.append("  }");
        html.append("  if (newPassword.length < 6) {");
        html.append("    alert.className = 'alert alert-error';");
        html.append("    alert.style.display = 'block';");
        html.append("    alert.textContent = '✗ Password must be at least 6 characters!';");
        html.append("    return;");
        html.append("  }");
        html.append("  fetch('/api/profile/update-password', {");
        html.append("    method: 'POST',");
        html.append("    headers: {'Content-Type': 'application/json'},");
        html.append("    body: JSON.stringify({userId: userId, currentPassword: currentPassword, newPassword: newPassword})");
        html.append("  }).then(r => r.json()).then(data => {");
        html.append("    if (data.success) {");
        html.append("      alert.className = 'alert alert-success';");
        html.append("      alert.style.display = 'block';");
        html.append("      alert.textContent = '✓ Password updated successfully!';");
        html.append("      document.getElementById('password-form').reset();");
        html.append("      setTimeout(() => alert.style.display = 'none', 3000);");
        html.append("    } else {");
        html.append("      alert.className = 'alert alert-error';");
        html.append("      alert.style.display = 'block';");
        html.append("      alert.textContent = '✗ ' + (data.message || 'Failed to update password');");
        html.append("    }");
        html.append("  }).catch(err => {");
        html.append("    alert.className = 'alert alert-error';");
        html.append("    alert.style.display = 'block';");
        html.append("    alert.textContent = '✗ Error: ' + err.message;");
        html.append("  });");
        html.append("}");
        html.append("</script>");
        
        html.append("</body></html>");
        return html.toString();
    }
    
    @GetMapping("/test-admin-dashboard")
    public String testAdminDashboard(Model model, HttpSession session) {
        // Simulate admin user for testing
        User adminUser = new User();
        adminUser.setId(1L);
        adminUser.setFirstName("Admin");
        adminUser.setLastName("User");
        adminUser.setEmail("admin@grandstay.com");
        
        session.setAttribute("user", adminUser);
        session.setAttribute("userRole", "ADMIN");
        session.setAttribute("isGuest", false);
        
        model.addAttribute("user", adminUser);
        model.addAttribute("userRole", "ADMIN");
        model.addAttribute("isGuest", false);
        
        return "dashboard";
    }
    
    @GetMapping("/reservation-confirmation")
    public String reservationConfirmation(Model model, HttpSession session) {
        // Get user info from session
        User user = (User) session.getAttribute("user");
        if (user != null) {
            model.addAttribute("user", user);
        }
        return "reservationConfirmation";
    }

    @GetMapping("/make-reservation")
    public String makeReservation(Model model, HttpSession session) {
        // Get user info from session
        User user = (User) session.getAttribute("user");
        if (user != null) {
            model.addAttribute("user", user);
        }
        
        // Load hotels from database
        try {
            List<Hotel> hotels = hotelService.getAllActiveHotels();
            model.addAttribute("hotels", hotels);
            System.out.println("Loaded " + hotels.size() + " hotels for make-reservation page");
        } catch (Exception e) {
            System.out.println("Error loading hotels: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("hotels", new java.util.ArrayList<>());
        }
        
        return "makeReservation";
    }
}
