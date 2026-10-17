package com.hotelreservation.exception;

public class ReservationConflictException extends RuntimeException {
    
    public ReservationConflictException(String message) {
        super(message);
    }
    
    public ReservationConflictException(String message, Throwable cause) {
        super(message, cause);
    }
    
    public ReservationConflictException(String eventName, String reason) {
        super(String.format("Reservation conflict for event '%s': %s", eventName, reason));
    }
}
