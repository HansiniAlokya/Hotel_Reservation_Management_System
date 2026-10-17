package com.hotelreservation.dto;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public class RoomDTO {
    private Long id;
    // private String roomNumber;
    private String roomType;
    // private String description;
    private Integer capacity;
    private BigDecimal pricePerNight;
    // private String amenities;
    // private Boolean isAvailable;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private Long hotelId;
    private String hotelName;

    // Constructors
    public RoomDTO() {}

    public RoomDTO(Long id, String roomType, 
                   Integer capacity, BigDecimal pricePerNight) {
        this.id = id;
        // this.roomNumber = roomNumber;
        this.roomType = roomType;
        this.capacity = capacity;
        this.pricePerNight = pricePerNight;
    }

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
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

    // public String getDescription() {
    //     return description;
    // }

    // public void setDescription(String description) {
    //     this.description = description;
    // }

    public Integer getCapacity() {
        return capacity;
    }

    public void setCapacity(Integer capacity) {
        this.capacity = capacity;
    }

    public BigDecimal getPricePerNight() {
        return pricePerNight;
    }

    public void setPricePerNight(BigDecimal pricePerNight) {
        this.pricePerNight = pricePerNight;
    }

    // public String getAmenities() {
    //     return amenities;
    // }

    // public void setAmenities(String amenities) {
    //     this.amenities = amenities;
    // }

    // public Boolean getIsAvailable() {
    //     return isAvailable;
    // }

    // public void setIsAvailable(Boolean isAvailable) {
    //     this.isAvailable = isAvailable;
    // }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

    public Long getHotelId() {
        return hotelId;
    }

    public void setHotelId(Long hotelId) {
        this.hotelId = hotelId;
    }

    public String getHotelName() {
        return hotelName;
    }

    public void setHotelName(String hotelName) {
        this.hotelName = hotelName;
    }
}
