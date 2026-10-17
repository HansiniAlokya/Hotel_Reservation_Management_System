package com.hotelreservation.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class AdminPageController {

    @GetMapping({"", "/", "/dashboard"})
    public String adminDashboard() {
        return "adminDashboard";
    }

    @GetMapping("/users-page")
    public String adminUserManagementPage() {
        return "adminUserManagement";
    }
    
    @GetMapping("/users")
    public String adminUserManagement() {
        return "adminUserManagement";
    }
    
    @GetMapping("/user-management")
    public String userManagement() {
        return "adminUserManagement";
    }
}
