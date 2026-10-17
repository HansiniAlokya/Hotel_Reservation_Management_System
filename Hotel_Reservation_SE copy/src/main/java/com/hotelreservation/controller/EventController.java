package com.hotelreservation.controller;

import com.hotelreservation.model.Event;
import com.hotelreservation.model.Hotel;
import com.hotelreservation.service.EventService;
import com.hotelreservation.service.HotelService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDateTime;
import java.util.List;

@Controller
@RequestMapping("/admin")
public class EventController {
    
    @Autowired
    private EventService eventService;
    
    @Autowired
    private HotelService hotelService;
    
    // Admin Endpoints
    
    /**
     * GET /admin/events → list all events (returns events.jsp)
     */
    @GetMapping("/events")
    public String listEvents(Model model) {
        try {
            List<Event> events = eventService.getAllEvents();
            model.addAttribute("events", events);
            model.addAttribute("totalEvents", events.size());
            model.addAttribute("activeEvents", events.stream().mapToLong(e -> e.getIsActive() ? 1 : 0).sum());
            model.addAttribute("upcomingEvents", events.stream().mapToLong(e -> 
                e.getEventDate() != null && e.getEventDate().isAfter(java.time.LocalDateTime.now()) ? 1 : 0).sum());
            return "elegantEventsBasic";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("errorMessage", "Error loading events: " + e.getMessage());
            model.addAttribute("events", new java.util.ArrayList<>());
            model.addAttribute("totalEvents", 0);
            model.addAttribute("activeEvents", 0);
            model.addAttribute("upcomingEvents", 0);
            return "elegantEventsBasic";
        }
    }
    
    /**
     * Simple REST endpoint to test if controller is working
     */
    @GetMapping("/events/test")
    public String testEvents(Model model) {
        model.addAttribute("message", "Controller is working!");
        return "simpleEvents";
    }
    
    /**
     * Test hotel service
     */
    @GetMapping("/events/test-hotels")
    public String testHotels(Model model) {
        try {
            List<Hotel> hotels = hotelService.getAllActiveHotels();
            model.addAttribute("hotels", hotels);
            model.addAttribute("hotelCount", hotels.size());
            return "eventsTest";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("errorMessage", "Error loading hotels: " + e.getMessage());
            return "eventsTest";
        }
    }
    
    
    
    /**
     * GET /admin/events/new → show form to create event
     */
    @GetMapping("/events/new")
    public String showCreateEventForm(Model model) {
        try {
            System.out.println("Creating new event form...");
            Event event = new Event();
            List<Hotel> hotels = hotelService.getAllActiveHotels();
            
            model.addAttribute("event", event);
            model.addAttribute("hotels", hotels);
            model.addAttribute("isEdit", false);
            
            System.out.println("Hotels loaded: " + hotels.size());
            return "eventForm";
        } catch (Exception e) {
            System.out.println("Error in showCreateEventForm: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("errorMessage", "Error loading form: " + e.getMessage());
            return "eventForm";
        }
    }
    
    @GetMapping("/events/create")
    public String createEvent(Model model) {
        System.out.println("Creating new event form - alternative path...");
        model.addAttribute("message", "Alternative path test");
        return "test";
    }
    
    /**
     * POST /admin/events → save new event
     */
    @PostMapping("/events")
    public String saveEvent(@Valid @ModelAttribute("event") Event event, 
                           @RequestParam("hotelId") Long hotelId,
                           BindingResult bindingResult, 
                           RedirectAttributes redirectAttributes) {
        if (bindingResult.hasErrors()) {
            List<Hotel> hotels = hotelService.getAllActiveHotels();
            redirectAttributes.addFlashAttribute("hotels", hotels);
            return "eventForm";
        }
        
        try {
            // Set the hotel for the event
            Hotel hotel = hotelService.getHotelById(hotelId)
                    .orElseThrow(() -> new IllegalArgumentException("Hotel not found with ID: " + hotelId));
            event.setHotel(hotel);
            
            eventService.validateEvent(event);
            eventService.saveEvent(event);
            redirectAttributes.addFlashAttribute("successMessage", "Event created successfully!");
            return "redirect:/admin/events";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error creating event: " + e.getMessage());
            return "redirect:/admin/events/new";
        }
    }
    
    /**
     * GET /admin/events/edit/{id} → show edit form
     */
    @GetMapping("/events/edit/{id}")
    public String showEditEventForm(@PathVariable Long id, Model model, RedirectAttributes redirectAttributes) {
        try {
            Event event = eventService.getEventById(id);
            List<Hotel> hotels = hotelService.getAllActiveHotels();
            model.addAttribute("event", event);
            model.addAttribute("hotels", hotels);
            model.addAttribute("isEdit", true);
            return "eventForm";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Event not found: " + e.getMessage());
            return "redirect:/admin/events";
        }
    }
    
    /**
     * POST /admin/events/update/{id} → update event
     */
    @PostMapping("/events/update/{id}")
    public String updateEvent(@PathVariable Long id, 
                             @RequestParam("eventName") String eventName,
                             @RequestParam("eventDate") String eventDateStr,
                             @RequestParam("location") String location,
                             @RequestParam(value = "description", required = false) String description,
                             @RequestParam("hotelId") Long hotelId,
                             RedirectAttributes redirectAttributes) {
        System.out.println("=== UPDATE EVENT DEBUG ===");
        System.out.println("Event ID: " + id);
        System.out.println("Event Name: " + eventName);
        System.out.println("Event Date: " + eventDateStr);
        System.out.println("Event Location: " + location);
        System.out.println("Hotel ID: " + hotelId);
        
        try {
            // Get the existing event
            Event event = eventService.getEventById(id);
            
            // Update the event properties
            event.setEventName(eventName);
            event.setLocation(location);
            event.setDescription(description);
            
            // Parse the date
            LocalDateTime eventDate = LocalDateTime.parse(eventDateStr);
            event.setEventDate(eventDate);
            
            // Set the hotel
            Hotel hotel = hotelService.getHotelById(hotelId)
                    .orElseThrow(() -> new IllegalArgumentException("Hotel not found with ID: " + hotelId));
            event.setHotel(hotel);
            
            // Validate and save
            eventService.validateEvent(event);
            eventService.saveEvent(event);
            
            redirectAttributes.addFlashAttribute("successMessage", "Event updated successfully!");
            return "redirect:/admin/events";
        } catch (Exception e) {
            System.out.println("Error updating event: " + e.getMessage());
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "Error updating event: " + e.getMessage());
            return "redirect:/admin/events/edit/" + id;
        }
    }
    
    /**
     * GET /admin/events/delete/{id} → delete event
     */
    @GetMapping("/events/delete/{id}")
    public String deleteEvent(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            eventService.deleteEvent(id);
            redirectAttributes.addFlashAttribute("successMessage", "Event deleted successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error deleting event: " + e.getMessage());
        }
        return "redirect:/admin/events";
    }
    
    /**
     * GET /admin/events/deactivate/{id} → deactivate event (soft delete)
     */
    @GetMapping("/events/deactivate/{id}")
    public String deactivateEvent(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            eventService.deactivateEvent(id);
            redirectAttributes.addFlashAttribute("successMessage", "Event deactivated successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error deactivating event: " + e.getMessage());
        }
        return "redirect:/admin/events";
    }
    
    /**
     * GET /admin/events/activate/{id} → activate event
     */
    @GetMapping("/events/activate/{id}")
    public String activateEvent(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            eventService.activateEvent(id);
            redirectAttributes.addFlashAttribute("successMessage", "Event activated successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error activating event: " + e.getMessage());
        }
        return "redirect:/admin/events";
    }
}