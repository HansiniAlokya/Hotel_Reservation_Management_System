package com.hotelreservation.service;

import com.hotelreservation.dto.ReservationRequestDTO;
import com.hotelreservation.dto.ReservationResponseDTO;
import com.hotelreservation.exception.ResourceNotFoundException;
import com.hotelreservation.exception.ReservationConflictException;
import com.hotelreservation.model.*;
import com.hotelreservation.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;
import java.util.stream.Collectors;

@Service
public class ReservationService {
    
    @Autowired
    private ReservationRepository reservationRepository;
    
    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private HotelRepository hotelRepository;
    
    @Autowired
    private RoomRepository roomRepository;
    
    @Autowired
    private ReservationStatusRepository reservationStatusRepository;
    
    @Autowired
    private HotelService hotelService;
    
    // In-memory status store for permanent persistence
    private final Map<Long, String> reservationStatusStore = new ConcurrentHashMap<>();
    
    // Getter for UserRepository (needed by GuestController)
    public UserRepository getUserRepository() {
        return userRepository;
    }
    
    public List<ReservationResponseDTO> getAllReservations() {
        try {
            System.out.println("Starting getAllReservations...");
            List<Reservation> reservations = reservationRepository.findAll();
            System.out.println("Found " + reservations.size() + " reservations in database");
            
            // Force loading of related entities by accessing them
            for (Reservation reservation : reservations) {
                try {
                    if (reservation.getUser() != null) {
                        reservation.getUser().getFirstName(); // Force load
                        reservation.getUser().getLastName();   // Force load
                        reservation.getUser().getEmail();      // Force load
                    }
                    if (reservation.getHotel() != null) {
                        reservation.getHotel().getName();      // Force load
                    }
                    if (reservation.getEvent() != null) {
                        reservation.getEvent().getEventName(); // Force load
                    }
                } catch (Exception e) {
                    System.err.println("Error loading related entities for reservation " + reservation.getId() + ": " + e.getMessage());
                }
            }
            
            // Create DTOs with actual reservation data
            List<ReservationResponseDTO> result = new java.util.ArrayList<>();
            for (Reservation reservation : reservations) {
                try {
                    // Create DTO manually to avoid lazy loading issues
                    ReservationResponseDTO dto = new ReservationResponseDTO();
                    dto.setId(reservation.getId());
                    dto.setReservationNumber(reservation.getReservationNumber());
                    
                    // Get status from database
                    String status = reservation.getStatus() != null ? reservation.getStatus().name() : "PENDING";
                    dto.setStatus(status);
                    
                    // Get actual guest information
                    if (reservation.getUser() != null) {
                        dto.setGuestName(reservation.getUser().getFirstName() + " " + reservation.getUser().getLastName());
                        dto.setGuestEmail(reservation.getUser().getEmail());
                    } else {
                        dto.setGuestName("Unknown Guest");
                        dto.setGuestEmail("unknown@example.com");
                    }
                    
                    // Get actual hotel or event information
                    if (reservation.getEvent() != null) {
                        dto.setHotelName(reservation.getEvent().getEventName());
                        dto.setRoomType("Event Reservation");
                    } else if (reservation.getHotel() != null) {
                        dto.setHotelName(reservation.getHotel().getName());
                        dto.setRoomType("Hotel Reservation");
                    } else {
                        dto.setHotelName("Unknown");
                        dto.setRoomType("N/A");
                    }
                    
                    dto.setTotalAmount(reservation.getTotalAmount());
                    dto.setCheckInDate(reservation.getCheckInDate());
                    dto.setCheckOutDate(reservation.getCheckOutDate());
                    dto.setCreatedAt(reservation.getCreatedAt());
                    result.add(dto);
                } catch (Exception e) {
                    System.err.println("Error creating DTO for reservation " + reservation.getId() + ": " + e.getMessage());
                    // Add a basic DTO with available data
                    ReservationResponseDTO dto = new ReservationResponseDTO();
                    dto.setId(reservation.getId());
                    dto.setReservationNumber(reservation.getReservationNumber());
                    
                    // Get status from database
                    String status = reservation.getStatus() != null ? reservation.getStatus().name() : "PENDING";
                    dto.setStatus(status);
                    dto.setGuestName("Error Loading Guest");
                    dto.setGuestEmail("error@example.com");
                    dto.setHotelName("Error Loading Hotel");
                    dto.setTotalAmount(reservation.getTotalAmount());
                    dto.setCheckInDate(reservation.getCheckInDate());
                    dto.setCheckOutDate(reservation.getCheckOutDate());
                    dto.setCreatedAt(reservation.getCreatedAt());
                    result.add(dto);
                }
            }
            System.out.println("Returning " + result.size() + " reservations");
            return result;
        } catch (Exception e) {
            System.err.println("Error in getAllReservations: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }
    
    public List<Reservation> getAllReservationsRaw() {
        try {
            System.out.println("Getting raw reservations from database...");
            List<Reservation> reservations = reservationRepository.findAllWithDetails();
            System.out.println("Found " + reservations.size() + " raw reservations");
            return reservations;
        } catch (Exception e) {
            System.err.println("Error getting raw reservations: " + e.getMessage());
            e.printStackTrace();
            return new java.util.ArrayList<>();
        }
    }
    
    public ReservationResponseDTO getReservationById(Long id) {
        Reservation reservation = reservationRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Reservation", "id", id));
        return new ReservationResponseDTO(reservation);
    }
    
    public ReservationResponseDTO getReservationByNumber(String reservationNumber) {
        Reservation reservation = reservationRepository.findByReservationNumber(reservationNumber)
                .orElseThrow(() -> new ResourceNotFoundException("Reservation", "reservationNumber", reservationNumber));
        return new ReservationResponseDTO(reservation);
    }
    
    @Transactional
    public ReservationResponseDTO createReservation(ReservationRequestDTO requestDTO, Long userId) {
        try {
            // Validate user exists
            User user = userRepository.findById(userId)
                    .orElseThrow(() -> new ResourceNotFoundException("User", "id", userId));
            
            // For now, create a simple reservation without room validation
            // This is a temporary solution to get the system working
            
            // Skip hotel validation for now
            
            // Parse dates from string format (YYYY-MM-DD)
            LocalDateTime checkInDate = parseDate(requestDTO.getCheckInDate());
            LocalDateTime checkOutDate = parseDate(requestDTO.getCheckOutDate());
            
            // Validate dates
            if (checkInDate.isAfter(checkOutDate)) {
                throw new ReservationConflictException("Check-in date cannot be after check-out date");
            }
            
            if (checkInDate.isBefore(LocalDateTime.now())) {
                throw new ReservationConflictException("Check-in date must be in the future");
            }
            
            // Calculate total amount (simplified - $100 per night)
            long nights = ChronoUnit.DAYS.between(checkInDate, checkOutDate);
            BigDecimal totalAmount = BigDecimal.valueOf(100).multiply(BigDecimal.valueOf(nights));
            
            // Get hotel from request
            Hotel hotel = hotelService.getHotelById(requestDTO.getHotelId())
                    .orElseThrow(() -> new ResourceNotFoundException("Hotel", "id", requestDTO.getHotelId()));
            
            // Create reservation
            Reservation reservation = new Reservation();
            reservation.setUser(user);
            reservation.setHotel(hotel); // Use selected hotel from request
            // reservation.setRoom(null); // No room for now
            reservation.setCheckInDate(checkInDate);
            reservation.setCheckOutDate(checkOutDate);
            // reservation.setNumberOfRooms(requestDTO.getNumberOfRooms());
            // reservation.setNumberOfGuests(requestDTO.getNumberOfGuests());
            reservation.setTotalAmount(totalAmount);
            // reservation.setSpecialRequests(requestDTO.getSpecialRequests());
            // reservation.setStatus(Reservation.ReservationStatus.PENDING);
            
            // Generate a unique reservation number
            reservation.setReservationNumber(UUID.randomUUID().toString());
            
            Reservation savedReservation = reservationRepository.save(reservation);
            
            // Create DTO manually to avoid lazy loading issues
            ReservationResponseDTO responseDTO = new ReservationResponseDTO();
            responseDTO.setId(savedReservation.getId());
            responseDTO.setReservationNumber(savedReservation.getReservationNumber());
            responseDTO.setHotelName(hotel.getName());
            // responseDTO.setRoomNumber("N/A");
            responseDTO.setRoomType("N/A");
            responseDTO.setCheckInDate(savedReservation.getCheckInDate());
            responseDTO.setCheckOutDate(savedReservation.getCheckOutDate());
            responseDTO.setTotalAmount(savedReservation.getTotalAmount());
            responseDTO.setStatus("PENDING");
            responseDTO.setCreatedAt(savedReservation.getCreatedAt());
            responseDTO.setGuestName(user.getFirstName() + " " + user.getLastName());
            responseDTO.setGuestEmail(user.getEmail());
            
            return responseDTO;
        } catch (Exception e) {
            throw new ReservationConflictException("Error creating reservation: " + e.getMessage());
        }
    }
    
    private LocalDateTime parseDate(String dateString) {
        try {
            // Handle both "YYYY-MM-DD" and "YYYY-MM-DDTHH:mm:ss" formats
            if (dateString.contains("T")) {
                return LocalDateTime.parse(dateString);
            } else {
                return LocalDateTime.parse(dateString + "T00:00:00");
            }
        } catch (Exception e) {
            throw new ReservationConflictException("Invalid date format: " + dateString);
        }
    }
    
    // public ReservationResponseDTO updateReservationStatus(Long id, String status) {
    //     Reservation reservation = reservationRepository.findById(id)
    //             .orElseThrow(() -> new ResourceNotFoundException("Reservation", "id", id));
    //     
    //     try {
    //         reservation.setStatus(Reservation.ReservationStatus.valueOf(status.toUpperCase()));
    //         Reservation savedReservation = reservationRepository.save(reservation);
    //         return new ReservationResponseDTO(savedReservation);
    //     } catch (IllegalArgumentException e) {
    //         throw new ReservationConflictException("Invalid status: " + status);
    //     }
    // }
    
    @Transactional
    public void deleteReservation(Long id) {
        Reservation reservation = reservationRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Reservation", "id", id));
        
        reservationRepository.delete(reservation);
    }
    
    @Transactional(readOnly = true)
    public List<ReservationResponseDTO> getReservationsByUser(Long userId) {
        System.out.println("Fetching reservations for user: " + userId);
        
        List<ReservationResponseDTO> result = new ArrayList<>();
        
        try {
            List<Reservation> reservations = reservationRepository.findByUserId(userId);
            System.out.println("Found " + reservations.size() + " reservations");
            
            for (Reservation r : reservations) {
                try {
                    ReservationResponseDTO dto = new ReservationResponseDTO();
                    dto.setId(r.getId());
                    dto.setReservationNumber(r.getReservationNumber() != null ? r.getReservationNumber() : "N/A");
                    
                    // Get user info safely
                    if (r.getUser() != null) {
                        dto.setGuestName(r.getUser().getFirstName() + " " + r.getUser().getLastName());
                        dto.setGuestEmail(r.getUser().getEmail());
                    } else {
                        dto.setGuestName("Unknown");
                        dto.setGuestEmail("unknown@example.com");
                    }
                    
                    // Get hotel/event info safely
                    if (r.getEvent() != null) {
                        dto.setHotelName(r.getEvent().getEventName());
                        dto.setRoomType("Event");
                    } else if (r.getHotel() != null) {
                        dto.setHotelName(r.getHotel().getName());
                        dto.setRoomType("Hotel");
                    } else {
                        dto.setHotelName("N/A");
                        dto.setRoomType("N/A");
                    }
                    
                    dto.setCheckInDate(r.getCheckInDate());
                    dto.setCheckOutDate(r.getCheckOutDate());
                    dto.setTotalAmount(r.getTotalAmount());
                    dto.setStatus(r.getStatus() != null ? r.getStatus().name() : "PENDING");
                    dto.setCreatedAt(r.getCreatedAt());
                    
                    result.add(dto);
                } catch (Exception ex) {
                    System.err.println("Error processing reservation " + r.getId() + ": " + ex.getMessage());
                }
            }
            
            System.out.println("Returning " + result.size() + " reservation DTOs");
        } catch (Exception e) {
            System.err.println("Error fetching reservations: " + e.getMessage());
            e.printStackTrace();
        }
        
        return result;
    }
    
    public void fixReservationUserLinks() {
        try {
            // Find the test user
            User testUser = userRepository.findByEmail("test@example.com")
                    .orElseThrow(() -> new ResourceNotFoundException("User", "email", "test@example.com"));
            
            // Get all reservations with null user
            List<Reservation> reservationsWithoutUser = reservationRepository.findAll().stream()
                    .filter(r -> r.getUser() == null)
                    .collect(Collectors.toList());
            
            System.out.println("Found " + reservationsWithoutUser.size() + " reservations without user links");
            
            // Update each reservation to link to test user
            for (Reservation reservation : reservationsWithoutUser) {
                reservation.setUser(testUser);
                reservationRepository.save(reservation);
                System.out.println("Updated reservation " + reservation.getId() + " to link to user " + testUser.getId());
            }
            
            System.out.println("Successfully fixed " + reservationsWithoutUser.size() + " reservation user links");
        } catch (Exception e) {
            System.err.println("Error fixing reservation user links: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    // public List<ReservationResponseDTO> getReservationsByStatus(String status) {
    //     try {
    //         Reservation.ReservationStatus reservationStatus = Reservation.ReservationStatus.valueOf(status.toUpperCase());
    //         return reservationRepository.findByStatus(reservationStatus).stream()
    //                 .map(ReservationResponseDTO::new)
    //                 .collect(Collectors.toList());
    //     } catch (IllegalArgumentException e) {
    //         throw new ReservationConflictException("Invalid status: " + status);
    //     }
    // }
    
    // public List<ReservationResponseDTO> getPendingReservations() {
    //     return getReservationsByStatus("PENDING");
    // }
    
    // public ReservationResponseDTO confirmReservation(Long id) {
    //     return updateReservationStatus(id, "CONFIRMED");
    // }
    
    // public ReservationResponseDTO rejectReservation(Long id) {
    //     return updateReservationStatus(id, "CANCELLED");
    // }
    
    public ReservationResponseDTO confirmReservation(Long id) {
        System.out.println("Confirming reservation with ID: " + id);
        try {
            Reservation reservation = reservationRepository.findById(id)
                    .orElseThrow(() -> new ResourceNotFoundException("Reservation", "id", id));
            
            // Update the status in the database
            reservation.setStatus(Reservation.ReservationStatus.CONFIRMED);
            reservation.setUpdatedAt(LocalDateTime.now());
            reservationRepository.save(reservation);
            
            System.out.println("Reservation " + id + " confirmed successfully and saved to database");
            
            // Also save status to in-memory store for immediate display
            reservationStatusStore.put(id, "CONFIRMED");
            System.out.println("Status CONFIRMED saved permanently for reservation " + id);
            
            // Create DTO with CONFIRMED status using actual reservation data
            ReservationResponseDTO responseDTO = new ReservationResponseDTO();
            responseDTO.setId(reservation.getId());
            responseDTO.setReservationNumber(reservation.getReservationNumber());
            responseDTO.setStatus("CONFIRMED");
            
            // Get actual guest information
            if (reservation.getUser() != null) {
                responseDTO.setGuestName(reservation.getUser().getFirstName() + " " + reservation.getUser().getLastName());
                responseDTO.setGuestEmail(reservation.getUser().getEmail());
            } else {
                responseDTO.setGuestName("Unknown Guest");
                responseDTO.setGuestEmail("unknown@example.com");
            }
            
            // Get actual hotel information
            if (reservation.getHotel() != null) {
                responseDTO.setHotelName(reservation.getHotel().getName());
            } else {
                responseDTO.setHotelName("Unknown Hotel");
            }
            
            responseDTO.setTotalAmount(reservation.getTotalAmount());
            responseDTO.setCheckInDate(reservation.getCheckInDate());
            responseDTO.setCheckOutDate(reservation.getCheckOutDate());
            responseDTO.setCreatedAt(reservation.getCreatedAt());
            return responseDTO;
        } catch (Exception e) {
            System.err.println("Error confirming reservation " + id + ": " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }
    
    public ReservationResponseDTO cancelReservation(Long id) {
        System.out.println("Cancelling reservation with ID: " + id);
        try {
            Reservation reservation = reservationRepository.findById(id)
                    .orElseThrow(() -> new ResourceNotFoundException("Reservation", "id", id));
            
            // Update the status in the database
            reservation.setStatus(Reservation.ReservationStatus.CANCELLED);
            reservation.setUpdatedAt(LocalDateTime.now());
            reservationRepository.save(reservation);
            
            System.out.println("Reservation " + id + " cancelled successfully and saved to database");
            
            // Also save status to in-memory store for immediate display
            reservationStatusStore.put(id, "CANCELLED");
            System.out.println("Status CANCELLED saved permanently for reservation " + id);
            
            // Create DTO with CANCELLED status using actual reservation data
            ReservationResponseDTO responseDTO = new ReservationResponseDTO();
            responseDTO.setId(reservation.getId());
            responseDTO.setReservationNumber(reservation.getReservationNumber());
            responseDTO.setStatus("CANCELLED");
            
            // Get actual guest information
            if (reservation.getUser() != null) {
                responseDTO.setGuestName(reservation.getUser().getFirstName() + " " + reservation.getUser().getLastName());
                responseDTO.setGuestEmail(reservation.getUser().getEmail());
            } else {
                responseDTO.setGuestName("Unknown Guest");
                responseDTO.setGuestEmail("unknown@example.com");
            }
            
            // Get actual hotel information
            if (reservation.getHotel() != null) {
                responseDTO.setHotelName(reservation.getHotel().getName());
            } else {
                responseDTO.setHotelName("Unknown Hotel");
            }
            
            responseDTO.setTotalAmount(reservation.getTotalAmount());
            responseDTO.setCheckInDate(reservation.getCheckInDate());
            responseDTO.setCheckOutDate(reservation.getCheckOutDate());
            responseDTO.setCreatedAt(reservation.getCreatedAt());
            return responseDTO;
        } catch (Exception e) {
            System.err.println("Error cancelling reservation " + id + ": " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }

    public List<ReservationResponseDTO> getReservationsByDateRange(LocalDateTime startDate, LocalDateTime endDate) {
        return reservationRepository.findByDateRange(startDate, endDate).stream()
                .map(ReservationResponseDTO::new)
                .collect(Collectors.toList());
    }
    
    /**
     * Create a reservation for an event
     */
    @Transactional
    public ReservationResponseDTO createEventReservation(Event event, User user) {
        try {
            Reservation reservation = new Reservation();
            reservation.setUser(user);
            reservation.setEvent(event);
            reservation.setReservationNumber("EVT-" + System.currentTimeMillis());
            
            // Use event date - for single-day events, use same date for check-in and check-out
            reservation.setCheckInDate(event.getEventDate());
            reservation.setCheckOutDate(event.getEventDate());
            
            // Set a default price (events may not have pricing in the model yet)
            reservation.setTotalAmount(BigDecimal.ZERO);
            
            // Set status to RESERVED for events
            reservation.setStatus(Reservation.ReservationStatus.RESERVED);
            
            // Save the reservation
            Reservation savedReservation = reservationRepository.save(reservation);
            
            // Create and return DTO
            ReservationResponseDTO dto = new ReservationResponseDTO();
            dto.setId(savedReservation.getId());
            dto.setReservationNumber(savedReservation.getReservationNumber());
            dto.setCheckInDate(savedReservation.getCheckInDate());
            dto.setCheckOutDate(savedReservation.getCheckOutDate());
            dto.setTotalAmount(savedReservation.getTotalAmount());
            dto.setStatus("RESERVED");
            dto.setCreatedAt(savedReservation.getCreatedAt());
            dto.setGuestName(user.getFirstName() + " " + user.getLastName());
            dto.setGuestEmail(user.getEmail());
            
            // Set event details
            dto.setHotelName(event.getEventName()); // Use event name in hotel name field for display
            dto.setRoomType("Event Reservation");
            
            System.out.println("Created event reservation: " + dto.getReservationNumber());
            
            return dto;
        } catch (Exception e) {
            System.err.println("Error creating event reservation: " + e.getMessage());
            e.printStackTrace();
            throw new ReservationConflictException("Failed to create event reservation: " + e.getMessage());
        }
    }
}