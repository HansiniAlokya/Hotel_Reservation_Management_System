package com.hotelreservation.repository;

import com.hotelreservation.model.Hotel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface HotelRepository extends JpaRepository<Hotel, Long> {
    
    List<Hotel> findByIsActiveTrue();
    
    List<Hotel> findByLocationContainingIgnoreCase(String location);
    
    List<Hotel> findByNameContainingIgnoreCase(String name);
    
    @Query("SELECT h FROM Hotel h WHERE h.isActive = true AND " +
           "(LOWER(h.name) LIKE LOWER(CONCAT('%', :searchTerm, '%')) OR " +
           "LOWER(h.location) LIKE LOWER(CONCAT('%', :searchTerm, '%')))")
    List<Hotel> searchActiveHotels(@Param("searchTerm") String searchTerm);
    
    Optional<Hotel> findByIdAndIsActiveTrue(Long id);
    
    @Query("SELECT h FROM Hotel h WHERE h.isActive = true")
    List<Hotel> findActiveHotelsWithoutRooms();
    
    @Query("SELECT COUNT(h) FROM Hotel h WHERE h.isActive = true")
    long countActiveHotels();
}
