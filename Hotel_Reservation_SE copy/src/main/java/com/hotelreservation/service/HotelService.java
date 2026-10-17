package com.hotelreservation.service;

import com.hotelreservation.model.Hotel;
import com.hotelreservation.model.Room;
import com.hotelreservation.repository.HotelRepository;
import com.hotelreservation.repository.RoomRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class HotelService {
    
    @Autowired
    private HotelRepository hotelRepository;
    
    @Autowired
    private RoomRepository roomRepository;
    
    public List<Hotel> getAllHotels() {
        return hotelRepository.findActiveHotelsWithoutRooms();
    }
    
    public List<Hotel> getAllActiveHotels() {
        return hotelRepository.findByIsActiveTrue();
    }
    
    public Optional<Hotel> getHotelById(Long id) {
        return hotelRepository.findById(id);
    }
    
    public Hotel saveHotel(Hotel hotel) {
        return hotelRepository.save(hotel);
    }
    
    public void deleteHotel(Long id) {
        hotelRepository.deleteById(id);
    }
    
    public List<Room> getRoomsByHotel(Long hotelId) {
        return roomRepository.findByHotelId(hotelId);
    }
    
    public Optional<Room> getRoomById(Long id) {
        return roomRepository.findById(id);
    }
    
    public Room saveRoom(Room room) {
        return roomRepository.save(room);
    }
    
    public void deleteRoom(Long id) {
        roomRepository.deleteById(id);
    }
    
    // public List<Room> findAvailableRooms(Long hotelId, LocalDateTime checkInDate, LocalDateTime checkOutDate, Integer numberOfGuests) {
    //     return roomRepository.findAvailableRooms(hotelId, checkInDate, checkOutDate, numberOfGuests);
    // }
    
    // public List<Room> getAvailableRooms(Long hotelId, LocalDateTime checkIn, LocalDateTime checkOut, Integer guests) {
    //     Optional<Hotel> hotel = hotelRepository.findByIdAndIsActiveTrue(hotelId);
    //     if (hotel.isPresent()) {
    //         return roomRepository.findAvailableRooms(hotelId, checkIn, checkOut, guests);
    //     }
    //     return List.of();
    // }
    
    public List<String> getRoomTypes(Long hotelId) {
        Optional<Hotel> hotel = hotelRepository.findByIdAndIsActiveTrue(hotelId);
        if (hotel.isPresent()) {
            return roomRepository.findDistinctRoomTypesByHotel(hotel.get());
        }
        return List.of();
    }
    
    public long getActiveHotelCount() {
        return hotelRepository.countActiveHotels();
    }
    
    public long countAvailableRoomsByHotel(Long hotelId) {
        Optional<Hotel> hotel = hotelRepository.findByIdAndIsActiveTrue(hotelId);
        if (hotel.isPresent()) {
            return roomRepository.countAvailableRoomsByHotel(hotel.get());
        }
        return 0;
    }
    
    public List<Room> getAllRooms() {
        return roomRepository.findAll();
    }
}
