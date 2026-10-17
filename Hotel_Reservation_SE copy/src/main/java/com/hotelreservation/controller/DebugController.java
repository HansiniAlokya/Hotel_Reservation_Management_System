package com.hotelreservation.controller;

import com.hotelreservation.model.Event;
import com.hotelreservation.model.Hotel;
import com.hotelreservation.service.EventService;
import com.hotelreservation.service.HotelService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/debug")
public class DebugController {

    @Autowired
    private EventService eventService;

    @Autowired
    private HotelService hotelService;

    @GetMapping("/events")
    public String debugEvents(Model model) {
        try {
            List<Event> events = eventService.getAllEvents();
            model.addAttribute("events", events);
            model.addAttribute("eventCount", events.size());
            model.addAttribute("message", "Events loaded successfully");
            return "debugEvents";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("errorMessage", "Error loading events: " + e.getMessage());
            model.addAttribute("events", new java.util.ArrayList<>());
            model.addAttribute("eventCount", 0);
            return "debugEvents";
        }
    }

    @GetMapping("/hotels")
    public String debugHotels(Model model) {
        try {
            List<Hotel> hotels = hotelService.getAllActiveHotels();
            model.addAttribute("hotels", hotels);
            model.addAttribute("hotelCount", hotels.size());
            model.addAttribute("message", "Hotels loaded successfully");
            return "debugHotels";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("errorMessage", "Error loading hotels: " + e.getMessage());
            model.addAttribute("hotels", new java.util.ArrayList<>());
            model.addAttribute("hotelCount", 0);
            return "debugHotels";
        }
    }
}
