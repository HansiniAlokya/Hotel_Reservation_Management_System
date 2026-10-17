package com.hotelreservation.controller;

import com.hotelreservation.model.Event;
import com.hotelreservation.service.EventService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/events")
public class EventApiController {
    
    @Autowired
    private EventService eventService;
    
    /**
     * GET /api/events → get all events as JSON
     */
    @GetMapping
    public List<Event> getAllEvents() {
        return eventService.getAllActiveEvents();
    }
    
    /**
     * GET /api/events/upcoming → get upcoming events as JSON
     */
    @GetMapping("/upcoming")
    public List<Event> getUpcomingEvents() {
        return eventService.getUpcomingEvents();
    }
    
    /**
     * GET /api/events/{id} → get event by ID as JSON
     */
    @GetMapping("/{id}")
    public Event getEventById(@PathVariable Long id) {
        return eventService.getEventById(id);
    }
    
    /**
     * POST /api/events → create event via API
     */
    @PostMapping
    public Event createEvent(@RequestBody Event event) {
        eventService.validateEvent(event);
        return eventService.saveEvent(event);
    }
    
    /**
     * PUT /api/events/{id} → update event via API
     */
    @PutMapping("/{id}")
    public Event updateEvent(@PathVariable Long id, @RequestBody Event event) {
        event.setEventId(id);
        eventService.validateEvent(event);
        return eventService.saveEvent(event);
    }
    
    /**
     * DELETE /api/events/{id} → delete event via API
     */
    @DeleteMapping("/{id}")
    public void deleteEvent(@PathVariable Long id) {
        eventService.deleteEvent(id);
    }
}
