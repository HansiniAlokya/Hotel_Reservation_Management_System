package com.hotelreservation.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "payments")
public class Payment {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    // @Column(name = "payment_reference", unique = true)
    // private String paymentReference;
    
    @NotNull
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "reservation_id")
    private Reservation reservation;
    
    @NotNull
    @Positive
    @Column(name = "amount", precision = 10, scale = 2)
    private BigDecimal amount;
    
    @Enumerated(EnumType.STRING)
    @Column(name = "payment_method")
    private PaymentMethod paymentMethod;
    
    @Enumerated(EnumType.STRING)
    @Column(name = "payment_status")
    private PaymentStatus status = PaymentStatus.PENDING;
    
    // @Column(name = "transaction_id")
    // private String transactionId;
    
    // @Column(name = "gateway_response", length = 1000)
    // private String gatewayResponse;
    
    // @Column(name = "payment_date")
    // private LocalDateTime paymentDate;
    
    @Column(name = "created_at")
    private LocalDateTime createdAt;
    
    // @Column(name = "updated_at")
    // private LocalDateTime updatedAt;
    
    // Constructors
    public Payment() {}
    
    public Payment(Reservation reservation, BigDecimal amount, PaymentMethod paymentMethod) {
        this.reservation = reservation;
        this.amount = amount;
        this.paymentMethod = paymentMethod;
        // this.paymentReference = generatePaymentReference();
        this.createdAt = LocalDateTime.now();
        // this.updatedAt = LocalDateTime.now();
    }
    
    // @PrePersist
    // protected void onCreate() {
    //     if (paymentReference == null) {
    //         paymentReference = generatePaymentReference();
    //     }
    //     createdAt = LocalDateTime.now();
    //     updatedAt = LocalDateTime.now();
    // }
    
    // @PreUpdate
    // protected void onUpdate() {
    //     updatedAt = LocalDateTime.now();
    // }
    
    // private String generatePaymentReference() {
    //     return "PAY" + System.currentTimeMillis();
    // }
    
    // Getters and Setters
    public Long getId() {
        return id;
    }
    
    public void setId(Long id) {
        this.id = id;
    }
    
    // public String getPaymentReference() {
    //     return paymentReference;
    // }
    
    // public void setPaymentReference(String paymentReference) {
    //     this.paymentReference = paymentReference;
    // }
    
    public Reservation getReservation() {
        return reservation;
    }
    
    public void setReservation(Reservation reservation) {
        this.reservation = reservation;
    }
    
    public BigDecimal getAmount() {
        return amount;
    }
    
    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }
    
    public PaymentMethod getPaymentMethod() {
        return paymentMethod;
    }
    
    public void setPaymentMethod(PaymentMethod paymentMethod) {
        this.paymentMethod = paymentMethod;
    }
    
    public PaymentStatus getStatus() {
        return status;
    }
    
    public void setStatus(PaymentStatus status) {
        this.status = status;
    }
    
    // public String getTransactionId() {
    //     return transactionId;
    // }
    
    // public void setTransactionId(String transactionId) {
    //     this.transactionId = transactionId;
    // }
    
    // public String getGatewayResponse() {
    //     return gatewayResponse;
    // }
    
    // public void setGatewayResponse(String gatewayResponse) {
    //     this.gatewayResponse = gatewayResponse;
    // }
    
    // public LocalDateTime getPaymentDate() {
    //     return paymentDate;
    // }
    
    // public void setPaymentDate(LocalDateTime paymentDate) {
    //     this.paymentDate = paymentDate;
    // }
    
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
    
    // public LocalDateTime getUpdatedAt() {
    //     return updatedAt;
    // }
    
    // public void setUpdatedAt(LocalDateTime updatedAt) {
    //     this.updatedAt = updatedAt;
    // }
    
    public enum PaymentMethod {
        CREDIT_CARD, DEBIT_CARD, BANK_TRANSFER, CASH, PAYPAL, STRIPE
    }
    
    public enum PaymentStatus {
        PENDING, COMPLETED, FAILED, REFUNDED, CANCELLED
    }
}
