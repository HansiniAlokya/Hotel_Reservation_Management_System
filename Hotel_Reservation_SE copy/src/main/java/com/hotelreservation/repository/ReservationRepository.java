package com.hotelreservation.repository;

import com.hotelreservation.model.Reservation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Repository
public interface ReservationRepository extends JpaRepository<Reservation, Long> {
    
    Optional<Reservation> findByReservationNumber(String reservationNumber);
    
    @Query("SELECT r FROM Reservation r LEFT JOIN FETCH r.user LEFT JOIN FETCH r.hotel LEFT JOIN FETCH r.event WHERE r.user.id = :userId")
    List<Reservation> findByUserId(@Param("userId") Long userId);
    
    // @Query("SELECT r FROM Reservation r WHERE r.guest.id = :guestId")
    // List<Reservation> findByGuestId(@Param("guestId") Long guestId);
    
    // @Query("SELECT r FROM Reservation r WHERE r.event.id = :eventId")
    // List<Reservation> findByEventId(@Param("eventId") Long eventId);
    
    @Query("SELECT r FROM Reservation r WHERE r.hotel.id = :hotelId")
    List<Reservation> findByHotelId(@Param("hotelId") Long hotelId);
    
    // @Query("SELECT r FROM Reservation r WHERE r.room.id = :roomId")
    // List<Reservation> findByRoomId(@Param("roomId") Long roomId);
    
    // @Query("SELECT r FROM Reservation r WHERE r.status = :status")
    // List<Reservation> findByStatus(Reservation.ReservationStatus status);
    
    @Query("SELECT r FROM Reservation r WHERE r.checkInDate >= :startDate AND r.checkOutDate <= :endDate")
    List<Reservation> findByDateRange(@Param("startDate") LocalDateTime startDate, 
                                     @Param("endDate") LocalDateTime endDate);
    
    @Query("SELECT r FROM Reservation r WHERE r.checkInDate <= :date AND r.checkOutDate >= :date")
    List<Reservation> findReservationsForDate(@Param("date") LocalDateTime date);
    
    @Query("SELECT r FROM Reservation r LEFT JOIN FETCH r.user LEFT JOIN FETCH r.hotel")
    List<Reservation> findAllWithDetails();
    
    // @Query("SELECT COUNT(r) FROM Reservation r WHERE r.event.id = :eventId AND r.status IN ('CONFIRMED', 'CHECKED_IN')")
    // Long countConfirmedReservationsByEvent(@Param("eventId") Long eventId);
}
