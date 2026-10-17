package com.hotelreservation.dto;

import com.hotelreservation.model.Reservation;
import java.math.BigDecimal;
import java.time.LocalDateTime;

public class ReservationResponseDTO {
    
    private Long id;
    private String reservationNumber;
    private String hotelName;
    // private String roomNumber;
    private String roomType;
    private LocalDateTime checkInDate;
    private LocalDateTime checkOutDate;
    private Integer numberOfRooms;
    private Integer numberOfGuests;
    private BigDecimal totalAmount;
    private String status;
    private String specialRequests;
    private LocalDateTime createdAt;
    private String guestName;
    private String guestEmail;
    
    // Constructors
    public ReservationResponseDTO() {}
    
    public ReservationResponseDTO(Reservation reservation) {
        this.id = reservation.getId();
        this.reservationNumber = reservation.getReservationNumber();
        this.hotelName = (reservation.getHotel() != null && 
                         reservation.getHotel().getName() != null) ? 
            reservation.getHotel().getName() : "Unknown Hotel";
        // this.roomNumber = "N/A"; // No room for now
        this.roomType = "N/A"; // No room for now
        this.checkInDate = reservation.getCheckInDate();
        this.checkOutDate = reservation.getCheckOutDate();
        // this.numberOfRooms = reservation.getNumberOfRooms();
        // this.numberOfGuests = reservation.getNumberOfGuests();
        this.totalAmount = reservation.getTotalAmount();
        this.status = "PENDING"; // Default status for now
        // this.specialRequests = reservation.getSpecialRequests();
        this.createdAt = reservation.getCreatedAt();
        this.guestName = (reservation.getUser() != null && 
                         reservation.getUser().getFirstName() != null && 
                         reservation.getUser().getLastName() != null) ? 
            (reservation.getUser().getFirstName() + " " + reservation.getUser().getLastName()) : "Unknown Guest";
        this.guestEmail = (reservation.getUser() != null && 
                          reservation.getUser().getEmail() != null) ? 
            reservation.getUser().getEmail() : "unknown@example.com";
    }
    
    // Getters and Setters
    public Long getId() {
        return id;
    }
    
    public void setId(Long id) {
        this.id = id;
    }
    
    public String getReservationNumber() {
        return reservationNumber;
    }
    
    public void setReservationNumber(String reservationNumber) {
        this.reservationNumber = reservationNumber;
    }
    
    public String getHotelName() {
        return hotelName;
    }
    
    public void setHotelName(String hotelName) {
        this.hotelName = hotelName;
    }
    
    // public String getRoomNumber() {
    //     return roomNumber;
    // }

    // public void setRoomNumber(String roomNumber) {
    //     this.roomNumber = roomNumber;
    // }
    
    public String getRoomType() {
        return roomType;
    }
    
    public void setRoomType(String roomType) {
        this.roomType = roomType;
    }
    
    public LocalDateTime getCheckInDate() {
        return checkInDate;
    }
    
    public void setCheckInDate(LocalDateTime checkInDate) {
        this.checkInDate = checkInDate;
    }
    
    public LocalDateTime getCheckOutDate() {
        return checkOutDate;
    }
    
    public void setCheckOutDate(LocalDateTime checkOutDate) {
        this.checkOutDate = checkOutDate;
    }
    
    public Integer getNumberOfRooms() {
        return numberOfRooms;
    }
    
    public void setNumberOfRooms(Integer numberOfRooms) {
        this.numberOfRooms = numberOfRooms;
    }
    
    public Integer getNumberOfGuests() {
        return numberOfGuests;
    }
    
    public void setNumberOfGuests(Integer numberOfGuests) {
        this.numberOfGuests = numberOfGuests;
    }
    
    public BigDecimal getTotalAmount() {
        return totalAmount;
    }
    
    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public String getSpecialRequests() {
        return specialRequests;
    }
    
    public void setSpecialRequests(String specialRequests) {
        this.specialRequests = specialRequests;
    }
    
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
    
    public String getGuestName() {
        return guestName;
    }
    
    public void setGuestName(String guestName) {
        this.guestName = guestName;
    }
    
    public String getGuestEmail() {
        return guestEmail;
    }
    
    public void setGuestEmail(String guestEmail) {
        this.guestEmail = guestEmail;
    }
}
