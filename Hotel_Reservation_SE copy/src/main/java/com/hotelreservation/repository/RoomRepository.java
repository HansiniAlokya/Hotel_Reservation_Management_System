package com.hotelreservation.repository;

import com.hotelreservation.model.Room;
import com.hotelreservation.model.Hotel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Repository
public interface RoomRepository extends JpaRepository<Room, Long> {
    
    // List<Room> findByHotelAndIsAvailableTrue(Hotel hotel);
    
    List<Room> findByHotel(Hotel hotel);
    
    List<Room> findByHotelId(Long hotelId);
    
    // @Query("SELECT r FROM Room r WHERE r.hotel.id = :hotelId AND r.capacity >= :numberOfGuests AND r.id NOT IN (" +
    //        "SELECT res.room.id FROM Reservation res WHERE res.status IN ('PENDING', 'CONFIRMED', 'CHECKED_IN') AND " +
    //        "((res.checkInDate < :checkOutDate AND res.checkOutDate > :checkInDate) OR " +
    //        "(res.checkInDate >= :checkInDate AND res.checkInDate < :checkOutDate) OR " +
    //        "(res.checkOutDate > :checkInDate AND res.checkOutDate <= :checkOutDate)))")
    // List<Room> findAvailableRooms(
    //         @Param("hotelId") Long hotelId,
    //         @Param("checkInDate") LocalDateTime checkInDate,
    //         @Param("checkOutDate") LocalDateTime checkOutDate,
    //         @Param("numberOfGuests") Integer numberOfGuests);
    
    // @Query("SELECT r FROM Room r WHERE r.hotel = :hotel AND " +
    //        "r.capacity >= :guests AND r.id NOT IN " +
    //        "(SELECT res.room.id FROM Reservation res WHERE " +
    //        "res.status IN ('CONFIRMED', 'CHECKED_IN') AND " +
    //        "((res.checkInDate <= :checkIn AND res.checkOutDate > :checkIn) OR " +
    //        "(res.checkInDate < :checkOut AND res.checkOutDate >= :checkOut) OR " +
    //        "(res.checkInDate >= :checkIn AND res.checkOutDate <= :checkOut)))")
    // List<Room> findAvailableRooms(@Param("hotel") Hotel hotel, 
    //                              @Param("checkIn") LocalDateTime checkIn,
    //                              @Param("checkOut") LocalDateTime checkOut,
    //                              @Param("guests") Integer guests);
    
    // Optional<Room> findByRoomNumberAndHotel(String roomNumber, Hotel hotel);
    
    List<Room> findByRoomTypeAndHotel(String roomType, Hotel hotel);
    
    @Query("SELECT DISTINCT r.roomType FROM Room r WHERE r.hotel = :hotel")
    List<String> findDistinctRoomTypesByHotel(@Param("hotel") Hotel hotel);
    
    @Query("SELECT COUNT(r) FROM Room r WHERE r.hotel = :hotel")
    long countAvailableRoomsByHotel(@Param("hotel") Hotel hotel);
}
