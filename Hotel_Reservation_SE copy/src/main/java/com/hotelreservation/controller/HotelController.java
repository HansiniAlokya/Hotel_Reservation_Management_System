package com.hotelreservation.controller;

import com.hotelreservation.dto.HotelDTO;
import com.hotelreservation.dto.RoomDTO;
import com.hotelreservation.model.Hotel;
import com.hotelreservation.model.Room;
import com.hotelreservation.service.HotelService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/hotels")
public class HotelController {
    
    @Autowired
    private HotelService hotelService;
    
    @GetMapping
    public ResponseEntity<List<HotelDTO>> getAllHotels() {
        List<Hotel> hotels = hotelService.getAllActiveHotels();
        List<HotelDTO> hotelDTOs = hotels.stream()
                .map(this::convertToHotelDTO)
                .collect(Collectors.toList());
        return ResponseEntity.ok(hotelDTOs);
    }
    
    @GetMapping("/{id}")
    public ResponseEntity<HotelDTO> getHotelById(@PathVariable Long id) {
        return hotelService.getHotelById(id)
                .map(this::convertToHotelDTO)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }
    
    @GetMapping("/{hotelId}/rooms")
    public ResponseEntity<List<RoomDTO>> getRoomsByHotel(@PathVariable Long hotelId) {
        List<Room> rooms = hotelService.getRoomsByHotel(hotelId);
        List<RoomDTO> roomDTOs = rooms.stream()
                .map(this::convertToRoomDTO)
                .collect(Collectors.toList());
        return ResponseEntity.ok(roomDTOs);
    }
    
    // @GetMapping("/{hotelId}/rooms/available")
    // public ResponseEntity<List<RoomDTO>> getAvailableRooms(
    //         @PathVariable Long hotelId,
    //         @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime checkInDate,
    //         @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime checkOutDate,
    //         @RequestParam Integer numberOfGuests) {
    //     List<Room> availableRooms = hotelService.findAvailableRooms(hotelId, checkInDate, checkOutDate, numberOfGuests);
    //     List<RoomDTO> roomDTOs = availableRooms.stream()
    //             .map(this::convertToRoomDTO)
    //             .collect(Collectors.toList());
    //     return ResponseEntity.ok(roomDTOs);
    // }
    
    @GetMapping("/test")
    public ResponseEntity<HotelDTO> testEndpoint() {
        HotelDTO testDTO = new HotelDTO();
        testDTO.setId(999L);
        testDTO.setName("Test Hotel");
        testDTO.setLocation("Test Location");
        testDTO.setDescription("Test Description");
        testDTO.setStarRating(5);
        testDTO.setIsActive(true);
        return ResponseEntity.ok(testDTO);
    }
    
    
    @GetMapping("/debug/rooms")
    public ResponseEntity<?> debugRooms() {
        try {
            List<Room> allRooms = hotelService.getAllRooms();
            return ResponseEntity.ok("Total rooms: " + allRooms.size());
        } catch (Exception e) {
            return ResponseEntity.ok("Error: " + e.getMessage());
        }
    }

    private HotelDTO convertToHotelDTO(Hotel hotel) {
        HotelDTO dto = new HotelDTO();
        dto.setId(hotel.getId());
        dto.setName(hotel.getName());
        dto.setLocation(hotel.getLocation());
        dto.setDescription(hotel.getDescription());
        dto.setFacilities(hotel.getFacilities());
        dto.setStarRating(hotel.getStarRating());
        dto.setContactPhone(hotel.getContactPhone());
        dto.setContactEmail(hotel.getContactEmail());
        dto.setIsActive(hotel.getIsActive());
        dto.setCreatedAt(hotel.getCreatedAt());
        dto.setUpdatedAt(hotel.getUpdatedAt());
        
        // Don't include rooms in the hotel DTO to avoid circular reference
        // Rooms can be fetched separately via /api/hotels/{id}/rooms
        
        return dto;
    }

    private RoomDTO convertToRoomDTO(Room room) {
        RoomDTO dto = new RoomDTO();
        dto.setId(room.getId());
        // dto.setRoomNumber(room.getRoomNumber());
        dto.setRoomType(room.getRoomType());
        // dto.setDescription(room.getDescription());
        dto.setCapacity(room.getCapacity());
        dto.setPricePerNight(room.getPricePerNight());
        // dto.setAmenities(room.getAmenities());
        // dto.setIsAvailable(room.getIsAvailable());
        dto.setCreatedAt(room.getCreatedAt());
        dto.setUpdatedAt(room.getUpdatedAt());
        
        if (room.getHotel() != null) {
            dto.setHotelId(room.getHotel().getId());
            dto.setHotelName(room.getHotel().getName());
        }
        
        return dto;
    }
}
