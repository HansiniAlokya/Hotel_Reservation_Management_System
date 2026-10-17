package com.hotelreservation.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "rooms")
public class Room {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    // @NotBlank(message = "Room number is required")
    // @Size(max = 20, message = "Room number must not exceed 20 characters")
    // @Column(name = "room_number", nullable = false)
    // private String roomNumber;
    
    @NotBlank(message = "Room type is required")
    @Size(max = 50, message = "Room type must not exceed 50 characters")
    @Column(name = "room_type", nullable = false)
    private String roomType; // Single, Double, Suite, etc.
    
    // @Size(max = 500, message = "Description must not exceed 500 characters")
    // @Column(length = 500)
    // private String description;
    
    @Min(value = 1, message = "Capacity must be at least 1")
    @Column(nullable = false)
    private Integer capacity;
    
    @DecimalMin(value = "0.0", message = "Price must be non-negative")
    @Column(nullable = false, precision = 10, scale = 2)
    private BigDecimal pricePerNight;
    
    // @Size(max = 200, message = "Amenities must not exceed 200 characters")
    // @Column(length = 200, nullable = true)
    // private String amenities; // Comma-separated list of amenities
    
    // @Column(name = "is_available")
    // private Boolean isAvailable = true;
    
    @CreationTimestamp
    @Column(name = "created_at")
    private LocalDateTime createdAt;
    
    @UpdateTimestamp
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "hotel_id", nullable = false)
    @JsonIgnore
    private Hotel hotel;
    
    // @OneToMany(mappedBy = "room", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    // @JsonIgnore
    // private Set<Reservation> reservations = new HashSet<>();
    
    // Constructors
    public Room() {}
    
    public Room(String roomType, Integer capacity, BigDecimal pricePerNight, Hotel hotel) {
        // this.roomNumber = roomNumber;
        this.roomType = roomType;
        this.capacity = capacity;
        this.pricePerNight = pricePerNight;
        this.hotel = hotel;
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
    
    public Hotel getHotel() {
        return hotel;
    }
    
    public void setHotel(Hotel hotel) {
        this.hotel = hotel;
    }
    
    // public Set<Reservation> getReservations() {
    //     return reservations;
    // }
    
    // public void setReservations(Set<Reservation> reservations) {
    //     this.reservations = reservations;
    // }
    
    // Helper methods
    // public String[] getAmenitiesList() {
    //     if (amenities == null || amenities.trim().isEmpty()) {
    //         return new String[0];
    //     }
    //     return amenities.split(",");
    // }
    
    // public void setAmenitiesList(String[] amenitiesArray) {
    //     if (amenitiesArray == null || amenitiesArray.length == 0) {
    //         this.amenities = "";
    //     } else {
    //         this.amenities = String.join(",", amenitiesArray);
    //     }
    // }
}
