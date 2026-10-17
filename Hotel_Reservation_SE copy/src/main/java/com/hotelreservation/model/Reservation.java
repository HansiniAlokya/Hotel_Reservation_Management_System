package com.hotelreservation.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Set;

@Entity
@Table(name = "reservations")
public class Reservation {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(name = "reservation_number", unique = true)
    private String reservationNumber;
    
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;
    
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "event_id", referencedColumnName = "event_id", nullable = true)
    private Event event;
    
    // @ManyToOne(fetch = FetchType.LAZY)
    // @JoinColumn(name = "guest_id")
    // private Guest guest;
    
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "hotel_id", nullable = true)
    private Hotel hotel;
    
    // @ManyToOne(fetch = FetchType.LAZY)
    // @JoinColumn(name = "room_id", nullable = true)
    // private Room room;
    
    @NotNull
    @Column(name = "check_in_date")
    private LocalDateTime checkInDate;
    
    @NotNull
    @Column(name = "check_out_date")
    private LocalDateTime checkOutDate;
    
    // @Positive
    // @Column(name = "number_of_rooms")
    // private Integer numberOfRooms;
    
    // @Positive
    // @Column(name = "number_of_guests")
    // private Integer numberOfGuests;
    
    @NotNull
    @Column(name = "total_amount", precision = 10, scale = 2)
    private BigDecimal totalAmount;
    
    @Enumerated(EnumType.STRING)
    @Column(name = "reservation_status")
    private ReservationStatus status = ReservationStatus.PENDING;
    
    // @Column(name = "special_requests", length = 1000)
    // private String specialRequests;
    
    @Column(name = "created_at")
    private LocalDateTime createdAt;
    
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
    
    @OneToMany(mappedBy = "reservation", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private Set<Payment> payments;
    
    // Constructors
    public Reservation() {}
    
    public Reservation(User user, Hotel hotel, /* Room room, */ LocalDateTime checkInDate, 
                      LocalDateTime checkOutDate, /* Integer numberOfRooms, */ /* Integer numberOfGuests, */ BigDecimal totalAmount) {
        this.user = user;
        this.hotel = hotel;
        // this.room = room;
        this.checkInDate = checkInDate;
        this.checkOutDate = checkOutDate;
        // this.numberOfRooms = numberOfRooms;
        // this.numberOfGuests = numberOfGuests;
        this.totalAmount = totalAmount;
        this.reservationNumber = generateReservationNumber();
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
    }
    
    @PrePersist
    protected void onCreate() {
        if (reservationNumber == null) {
            reservationNumber = generateReservationNumber();
        }
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
    }
    
    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }
    
    private String generateReservationNumber() {
        return "RES" + System.currentTimeMillis();
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
    
    public User getUser() {
        return user;
    }
    
    public void setUser(User user) {
        this.user = user;
    }
    
    public Event getEvent() {
        return event;
    }
    
    public void setEvent(Event event) {
        this.event = event;
    }
    
    // public Guest getGuest() {
    //     return guest;
    // }
    
    // public void setGuest(Guest guest) {
    //     this.guest = guest;
    // }
    
    public Hotel getHotel() {
        return hotel;
    }
    
    public void setHotel(Hotel hotel) {
        this.hotel = hotel;
    }
    
    // public Room getRoom() {
    //     return room;
    // }
    
    // public void setRoom(Room room) {
    //     this.room = room;
    // }
    
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
    
    // public Integer getNumberOfRooms() {
    //     return numberOfRooms;
    // }
    
    // public void setNumberOfRooms(Integer numberOfRooms) {
    //     this.numberOfRooms = numberOfRooms;
    // }
    
    // public Integer getNumberOfGuests() {
    //     return numberOfGuests;
    // }
    
    // public void setNumberOfGuests(Integer numberOfGuests) {
    //     this.numberOfGuests = numberOfGuests;
    // }
    
    public BigDecimal getTotalAmount() {
        return totalAmount;
    }
    
    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }
    
    public ReservationStatus getStatus() {
        return status;
    }
    
    public void setStatus(ReservationStatus status) {
        this.status = status;
    }
    
    // public String getSpecialRequests() {
    //     return specialRequests;
    // }
    
    // public void setSpecialRequests(String specialRequests) {
    //     this.specialRequests = specialRequests;
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
    
    public Set<Payment> getPayments() {
        return payments;
    }
    
    public void setPayments(Set<Payment> payments) {
        this.payments = payments;
    }
    
    public enum ReservationStatus {
        PENDING, CONFIRMED, RESERVED, CHECKED_IN, CHECKED_OUT, CANCELLED, NO_SHOW
    }
}
