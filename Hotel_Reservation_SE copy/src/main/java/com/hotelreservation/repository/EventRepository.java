package com.hotelreservation.repository;

import com.hotelreservation.model.Event;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface EventRepository extends JpaRepository<Event, Long> {
    
    /**
     * Find all active events
     */
    List<Event> findByIsActive(Boolean isActive);
    
    /**
     * Find events by upcoming date (after the given date)
     */
    List<Event> findByEventDateAfter(LocalDateTime date);
    
    /**
     * Find upcoming active events
     */
    List<Event> findByEventDateAfterAndIsActive(LocalDateTime date, Boolean isActive);
    
    /**
     * Find events by date range
     */
    @Query("SELECT e FROM Event e WHERE e.eventDate BETWEEN :startDate AND :endDate AND e.isActive = true")
    List<Event> findEventsByDateRange(@Param("startDate") LocalDateTime startDate, 
                                     @Param("endDate") LocalDateTime endDate);
    
    /**
     * Find events by location
     */
    List<Event> findByLocationContainingIgnoreCaseAndIsActive(String location, Boolean isActive);
    
    /**
     * Find events by name containing (case insensitive)
     */
    List<Event> findByEventNameContainingIgnoreCaseAndIsActive(String eventName, Boolean isActive);
    
    /**
     * Find events happening this week
     */
    @Query("SELECT e FROM Event e WHERE e.eventDate BETWEEN :startOfWeek AND :endOfWeek AND e.isActive = true")
    List<Event> findThisWeeksEvents(@Param("startOfWeek") LocalDateTime startOfWeek, 
                                    @Param("endOfWeek") LocalDateTime endOfWeek);
    
    /**
     * Count active events
     */
    long countByIsActive(Boolean isActive);
    
    /**
     * Count upcoming events
     */
    long countByEventDateAfterAndIsActive(LocalDateTime date, Boolean isActive);
}