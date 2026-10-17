package com.hotelreservation.dto;

import jakarta.validation.constraints.*;

public class ReservationRequestDTO {
    
    //     @NotNull(message = "Hotel ID is required")
    private Long hotelId;
    
    // Room ID removed - no longer needed
    
    @NotNull(message = "Check-in date is required")
    private String checkInDate;
    
    @NotNull(message = "Check-out date is required")
    private String checkOutDate;
    
    @NotNull(message = "Number of rooms is required")
    @Min(value = 1, message = "Number of rooms must be at least 1")
    @Max(value = 10, message = "Number of rooms cannot exceed 10")
    private Integer numberOfRooms;
    
    @NotNull(message = "Number of guests is required")
    @Min(value = 1, message = "Number of guests must be at least 1")
    @Max(value = 10, message = "Number of guests cannot exceed 10")
    private Integer numberOfGuests;
    
    @Size(max = 1000, message = "Special requests must not exceed 1000 characters")
    private String specialRequests;
    
    // Constructors
    public ReservationRequestDTO() {}
    
    public ReservationRequestDTO(Long hotelId, String checkInDate, 
                               String checkOutDate, Integer numberOfRooms, Integer numberOfGuests) {
        this.hotelId = hotelId;
        this.checkInDate = checkInDate;
        this.checkOutDate = checkOutDate;
        this.numberOfRooms = numberOfRooms;
        this.numberOfGuests = numberOfGuests;
    }
    
    // Getters and Setters
    public Long getHotelId() {
        return hotelId;
    }
    
    public void setHotelId(Long hotelId) {
        this.hotelId = hotelId;
    }
    
    public String getCheckInDate() {
        return checkInDate;
    }
    
    public void setCheckInDate(String checkInDate) {
        this.checkInDate = checkInDate;
    }
    
    public String getCheckOutDate() {
        return checkOutDate;
    }
    
    public void setCheckOutDate(String checkOutDate) {
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
    
    public String getSpecialRequests() {
        return specialRequests;
    }
    
    public void setSpecialRequests(String specialRequests) {
        this.specialRequests = specialRequests;
    }
}
