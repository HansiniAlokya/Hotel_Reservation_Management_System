package com.hotelreservation.exception;

public class PaymentFailedException extends RuntimeException {
    
    public PaymentFailedException(String message) {
        super(message);
    }
    
    public PaymentFailedException(String message, Throwable cause) {
        super(message, cause);
    }
    
    public PaymentFailedException(String paymentReference, String reason) {
        super(String.format("Payment failed for reference '%s': %s", paymentReference, reason));
    }
}
