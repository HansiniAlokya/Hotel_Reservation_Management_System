package com.hotelreservation.util;

import com.hotelreservation.model.Payment;
import org.springframework.stereotype.Component;

import java.math.BigDecimal;
import java.util.Random;

@Component
public class PaymentGatewaySimulator {
    
    private final Random random = new Random();
    
    public PaymentGatewayResponse processPayment(Payment payment) {
        // Simulate payment processing delay
        try {
            Thread.sleep(1000 + random.nextInt(2000)); // 1-3 seconds delay
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        }
        
        // Simulate payment success/failure (90% success rate)
        boolean success = random.nextDouble() < 0.9;
        
        if (success) {
            return new PaymentGatewayResponse(
                true,
                "PAYMENT_SUCCESS",
                "Payment processed successfully",
                generateTransactionId(),
                payment.getAmount()
            );
        } else {
            return new PaymentGatewayResponse(
                false,
                "PAYMENT_FAILED",
                "Payment declined by bank",
                null,
                BigDecimal.ZERO
            );
        }
    }
    
    public PaymentGatewayResponse refundPayment(String transactionId, BigDecimal amount) {
        // Simulate refund processing
        try {
            Thread.sleep(500 + random.nextInt(1000)); // 0.5-1.5 seconds delay
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        }
        
        // Simulate refund success/failure (95% success rate)
        boolean success = random.nextDouble() < 0.95;
        
        if (success) {
            return new PaymentGatewayResponse(
                true,
                "REFUND_SUCCESS",
                "Refund processed successfully",
                generateTransactionId(),
                amount
            );
        } else {
            return new PaymentGatewayResponse(
                false,
                "REFUND_FAILED",
                "Refund could not be processed",
                null,
                BigDecimal.ZERO
            );
        }
    }
    
    private String generateTransactionId() {
        return "TXN" + System.currentTimeMillis() + random.nextInt(1000);
    }
    
    public static class PaymentGatewayResponse {
        private final boolean success;
        private final String code;
        private final String message;
        private final String transactionId;
        private final BigDecimal amount;
        
        public PaymentGatewayResponse(boolean success, String code, String message, 
                                   String transactionId, BigDecimal amount) {
            this.success = success;
            this.code = code;
            this.message = message;
            this.transactionId = transactionId;
            this.amount = amount;
        }
        
        public boolean isSuccess() {
            return success;
        }
        
        public String getCode() {
            return code;
        }
        
        public String getMessage() {
            return message;
        }
        
        public String getTransactionId() {
            return transactionId;
        }
        
        public BigDecimal getAmount() {
            return amount;
        }
    }
}
