package com.hotelreservation.service;

import com.hotelreservation.exception.ResourceNotFoundException;
import com.hotelreservation.model.Event;
import com.hotelreservation.repository.EventRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

@Service
@Transactional
public class EventService {
    
    @Autowired
    private EventRepository eventRepository;
    
    /**
     * Get all events (including inactive)
     */
    public List<Event> getAllEvents() {
        return eventRepository.findAll();
    }
    
    /**
     * Get all active events
     */
    public List<Event> getAllActiveEvents() {
        return eventRepository.findByIsActive(true);
    }
    
    /**
     * Get event by ID
     */
    public Event getEventById(Long id) {
        return eventRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Event", "id", id));
    }
    
    /**
     * Get upcoming events (events after current date)
     */
    public List<Event> getUpcomingEvents() {
        return eventRepository.findByEventDateAfterAndIsActive(LocalDateTime.now(), true);
    }
    
    /**
     * Get upcoming events after a specific date
     */
    public List<Event> getUpcomingEvents(LocalDateTime afterDate) {
        return eventRepository.findByEventDateAfterAndIsActive(afterDate, true);
    }
    
    /**
     * Save or update event
     */
    public Event saveEvent(Event event) {
        // Only validate event date is in the future for NEW events
        // Allow updating existing events even if the date has passed
        if (event.getEventId() == null) {
            // New event - validate date is in the future
            if (event.getEventDate() != null && event.getEventDate().isBefore(LocalDateTime.now())) {
                throw new IllegalArgumentException("Event date must be in the future");
            }
            event.setCreatedAt(LocalDateTime.now());
        } else {
            // Updating existing event - no date validation
            event.setUpdatedAt(LocalDateTime.now());
        }
        
        return eventRepository.save(event);
    }
    
    /**
     * Delete event by ID
     */
    public void deleteEvent(Long id) {
        Event event = getEventById(id);
        eventRepository.delete(event);
    }
    
    /**
     * Soft delete event (set as inactive)
     */
    public Event deactivateEvent(Long id) {
        Event event = getEventById(id);
        event.setIsActive(false);
        event.setUpdatedAt(LocalDateTime.now());
        return eventRepository.save(event);
    }
    
    /**
     * Reactivate event
     */
    public Event activateEvent(Long id) {
        Event event = getEventById(id);
        event.setIsActive(true);
        event.setUpdatedAt(LocalDateTime.now());
        return eventRepository.save(event);
    }
    
    /**
     * Get events by date range
     */
    public List<Event> getEventsByDateRange(LocalDateTime startDate, LocalDateTime endDate) {
        return eventRepository.findEventsByDateRange(startDate, endDate);
    }
    
    /**
     * Search events by location
     */
    public List<Event> searchEventsByLocation(String location) {
        return eventRepository.findByLocationContainingIgnoreCaseAndIsActive(location, true);
    }
    
    /**
     * Search events by name
     */
    public List<Event> searchEventsByName(String eventName) {
        return eventRepository.findByEventNameContainingIgnoreCaseAndIsActive(eventName, true);
    }
    
    /**
     * Get today's events
     */
    public List<Event> getTodaysEvents() {
        LocalDateTime now = LocalDateTime.now();
        LocalDateTime startOfDay = now.withHour(0).withMinute(0).withSecond(0);
        LocalDateTime endOfDay = now.withHour(23).withMinute(59).withSecond(59);
        return eventRepository.findEventsByDateRange(startOfDay, endOfDay);
    }
    
    /**
     * Get this week's events
     */
    public List<Event> getThisWeeksEvents() {
        LocalDateTime now = LocalDateTime.now();
        LocalDateTime startOfWeek = now.minusDays(now.getDayOfWeek().getValue() - 1).withHour(0).withMinute(0).withSecond(0);
        LocalDateTime endOfWeek = startOfWeek.plusDays(6).withHour(23).withMinute(59).withSecond(59);
        return eventRepository.findThisWeeksEvents(startOfWeek, endOfWeek);
    }
    
    /**
     * Count active events
     */
    public long countActiveEvents() {
        return eventRepository.countByIsActive(true);
    }
    
    /**
     * Count upcoming events
     */
    public long countUpcomingEvents() {
        return eventRepository.countByEventDateAfterAndIsActive(LocalDateTime.now(), true);
    }
    
    /**
     * Check if event exists
     */
    public boolean eventExists(Long id) {
        return eventRepository.existsById(id);
    }
    
    /**
     * Validate event data
     */
    public void validateEvent(Event event) {
        if (event.getEventName() == null || event.getEventName().trim().isEmpty()) {
            throw new IllegalArgumentException("Event name is required");
        }
        
        if (event.getEventDate() == null) {
            throw new IllegalArgumentException("Event date is required");
        }
        
        // Only validate future date for NEW events (no eventId yet)
        if (event.getEventId() == null && event.getEventDate().isBefore(LocalDateTime.now())) {
            throw new IllegalArgumentException("Event date must be in the future");
        }
        
        if (event.getLocation() == null || event.getLocation().trim().isEmpty()) {
            throw new IllegalArgumentException("Location is required");
        }
        
        if (event.getEventName().length() > 100) {
            throw new IllegalArgumentException("Event name must not exceed 100 characters");
        }
        
        if (event.getLocation().length() > 200) {
            throw new IllegalArgumentException("Location must not exceed 200 characters");
        }
        
        if (event.getDescription() != null && event.getDescription().length() > 1000) {
            throw new IllegalArgumentException("Description must not exceed 1000 characters");
        }
    }
}