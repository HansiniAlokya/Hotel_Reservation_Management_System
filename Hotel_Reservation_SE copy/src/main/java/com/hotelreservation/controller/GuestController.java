package com.hotelreservation.controller;

import com.hotelreservation.model.Event;
import com.hotelreservation.model.Hotel;
import com.hotelreservation.model.User;
import com.hotelreservation.service.EventService;
import com.hotelreservation.service.HotelService;
import com.hotelreservation.service.ReservationService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDateTime;
import java.util.List;

@Controller
@RequestMapping("/guest")
public class GuestController {
    
    @Autowired
    private EventService eventService;
    
    @Autowired
    private HotelService hotelService;
    
    @Autowired
    private ReservationService reservationService;
    
    /**
     * GET /guest/simple-test → Very simple test endpoint
     */
    @GetMapping("/simple-test")
    @ResponseBody
    public String simpleTest() {
        return "Simple test endpoint working!";
    }
    
    /**
     * GET /guest/test-events → Simple test endpoint
     */
    @GetMapping("/test-events")
    public String testEvents(Model model) {
        try {
            model.addAttribute("message", "Test endpoint working!");
            model.addAttribute("events", new java.util.ArrayList<>());
            model.addAttribute("totalEvents", 0);
            return "browseEvents";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("errorMessage", "Test error: " + e.getMessage());
            return "browseEvents";
        }
    }
    
    /**
     * GET /guest/browse-events → Browse all upcoming events
     */
    @GetMapping("/browse-events")
    public String browseEvents(Model model) {
        try {
            List<Event> upcomingEvents = eventService.getUpcomingEvents();
            model.addAttribute("events", upcomingEvents);
            model.addAttribute("totalEvents", upcomingEvents.size());
            return "browseEvents";
        } catch (Exception e) {
            e.printStackTrace();
            // Return empty list instead of throwing error
            model.addAttribute("errorMessage", "Events are temporarily unavailable. Please try again later.");
            model.addAttribute("events", new java.util.ArrayList<>());
            model.addAttribute("totalEvents", 0);
            return "browseEvents";
        }
    }
    
    /**
     * GET /guest/event-details/{id} → View event details and reservation form
     */
    @GetMapping("/event-details/{id}")
    public String eventDetails(@PathVariable Long id, Model model, HttpSession session) {
        try {
            Event event = eventService.getEventById(id);
            User user = (User) session.getAttribute("user");
            
            // If no user in session, try to find test user
            if (user == null) {
                user = reservationService.getUserRepository().findByEmail("test@example.com").orElse(null);
            }
            
            // Convert LocalDateTime to a format JSP can handle
            java.time.format.DateTimeFormatter formatter = 
                java.time.format.DateTimeFormatter.ofPattern("EEEE, MMMM dd, yyyy 'at' HH:mm");
            String formattedDate = event.getEventDate().format(formatter);
            
            model.addAttribute("event", event);
            model.addAttribute("formattedEventDate", formattedDate);
            model.addAttribute("user", user);
            model.addAttribute("currentDate", LocalDateTime.now());
            
            return "eventDetails";
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/guest/browse-events?error=Event not found";
        }
    }
    
    /**
     * POST /guest/reserve-event → Reserve an event
     */
    @PostMapping("/reserve-event")
    public String reserveEvent(@RequestParam Long eventId,
                             @RequestParam String guestName,
                             @RequestParam String guestEmail,
                             @RequestParam String guestPhone,
                             @RequestParam(required = false) String specialRequests,
                             HttpSession session,
                             RedirectAttributes redirectAttributes) {
        try {
            User user = (User) session.getAttribute("user");
            if (user == null) {
                // Try to find test user if not in session
                user = reservationService.getUserRepository().findByEmail("test@example.com")
                    .orElseThrow(() -> new RuntimeException("Please log in to reserve events"));
            }
            
            Event event = eventService.getEventById(eventId);
            
            // Create event reservation using the service
            reservationService.createEventReservation(event, user);
            
            redirectAttributes.addFlashAttribute("successMessage", 
                "Event reserved successfully! Check your reservations.");
            
            return "redirect:/guest/browse-events";
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", 
                "Error reserving event: " + e.getMessage());
            return "redirect:/guest/event-details/" + eventId;
        }
    }
    
    /**
     * GET /guest/my-event-reservations → View guest's event reservations
     */
    @GetMapping("/my-event-reservations")
    public String myEventReservations(Model model, HttpSession session) {
        try {
            User user = (User) session.getAttribute("user");
            if (user == null) {
                return "redirect:/login";
            }
            
            // For now, return empty list - in a real system, you'd query event reservations
            model.addAttribute("reservations", new java.util.ArrayList<>());
            model.addAttribute("user", user);
            
            return "myEventReservations";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("errorMessage", "Error loading reservations: " + e.getMessage());
            return "myEventReservations";
        }
    }
}
