package com.hotelreservation.repository;

import com.hotelreservation.model.Payment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Repository
public interface PaymentRepository extends JpaRepository<Payment, Long> {
    
    // Optional<Payment> findByPaymentReference(String paymentReference);
    
    // Optional<Payment> findByTransactionId(String transactionId);
    
    @Query("SELECT p FROM Payment p WHERE p.reservation.id = :reservationId")
    List<Payment> findByReservationId(@Param("reservationId") Long reservationId);
    
    @Query("SELECT p FROM Payment p WHERE p.status = :status")
    List<Payment> findByStatus(@Param("status") Payment.PaymentStatus status);
    
    @Query("SELECT p FROM Payment p WHERE p.paymentMethod = :paymentMethod")
    List<Payment> findByPaymentMethod(@Param("paymentMethod") Payment.PaymentMethod paymentMethod);
    
    // @Query("SELECT p FROM Payment p WHERE p.paymentDate >= :startDate AND p.paymentDate <= :endDate")
    // List<Payment> findByPaymentDateRange(@Param("startDate") LocalDateTime startDate, 
    //                                    @Param("endDate") LocalDateTime endDate);
    
    // @Query("SELECT SUM(p.amount) FROM Payment p WHERE p.status = 'COMPLETED' AND p.paymentDate >= :startDate AND p.paymentDate <= :endDate")
    // Double getTotalRevenueByDateRange(@Param("startDate") LocalDateTime startDate, 
    //                                 @Param("endDate") LocalDateTime endDate);
    
    // @Query("SELECT COUNT(p) FROM Payment p WHERE p.status = 'COMPLETED' AND p.paymentDate >= :startDate AND p.paymentDate <= :endDate")
    // Long getCompletedPaymentCountByDateRange(@Param("startDate") LocalDateTime startDate, 
    //                                        @Param("endDate") LocalDateTime endDate);
}
