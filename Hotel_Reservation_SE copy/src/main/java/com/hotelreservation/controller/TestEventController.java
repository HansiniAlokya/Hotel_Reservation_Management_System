package com.hotelreservation.controller;

import com.hotelreservation.model.Event;
import com.hotelreservation.service.EventService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/test")
public class TestEventController {
    
    @Autowired
    private EventService eventService;
    
    @GetMapping("/events")
    public String testEvents(Model model) {
        try {
            List<Event> events = eventService.getAllEvents();
            model.addAttribute("events", events);
            model.addAttribute("message", "Events loaded successfully. Count: " + events.size());
            return "eventsTest";
        } catch (Exception e) {
            model.addAttribute("errorMessage", "Error: " + e.getMessage());
            e.printStackTrace();
            return "eventsTest";
        }
    }
}
