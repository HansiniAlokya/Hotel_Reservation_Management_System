package com.hotelreservation.service;

import com.hotelreservation.dto.PaymentDTO;
import com.hotelreservation.exception.ResourceNotFoundException;
import com.hotelreservation.model.Payment;
import com.hotelreservation.model.Reservation;
import com.hotelreservation.repository.PaymentRepository;
import com.hotelreservation.repository.ReservationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class PaymentService {

    @Autowired
    private PaymentRepository paymentRepository;

    @Autowired
    private ReservationRepository reservationRepository;

    public Payment createPayment(PaymentDTO paymentDTO) {
        Payment payment = new Payment();
        
        // Get reservation
        Reservation reservation = reservationRepository.findById(paymentDTO.getReservationId())
                .orElseThrow(() -> new ResourceNotFoundException("Reservation", "id", paymentDTO.getReservationId()));
        
        payment.setReservation(reservation);
        payment.setAmount(paymentDTO.getAmount());
        
        if (paymentDTO.getPaymentMethod() != null) {
            try {
                payment.setPaymentMethod(Payment.PaymentMethod.valueOf(paymentDTO.getPaymentMethod()));
            } catch (IllegalArgumentException e) {
                payment.setPaymentMethod(Payment.PaymentMethod.CREDIT_CARD); // Default
            }
        } else {
            payment.setPaymentMethod(Payment.PaymentMethod.CREDIT_CARD);
        }
        
        if (paymentDTO.getStatus() != null) {
            try {
                payment.setStatus(Payment.PaymentStatus.valueOf(paymentDTO.getStatus()));
            } catch (IllegalArgumentException e) {
                payment.setStatus(Payment.PaymentStatus.PENDING); // Default
            }
        } else {
            payment.setStatus(Payment.PaymentStatus.PENDING);
        }
        
        payment.setCreatedAt(LocalDateTime.now());
        
        return paymentRepository.save(payment);
    }

    public Payment updatePayment(Long id, PaymentDTO paymentDTO) {
        Payment payment = paymentRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Payment", "id", id));
        
        if (paymentDTO.getAmount() != null) {
            payment.setAmount(paymentDTO.getAmount());
        }
        
        if (paymentDTO.getPaymentMethod() != null) {
            try {
                payment.setPaymentMethod(Payment.PaymentMethod.valueOf(paymentDTO.getPaymentMethod()));
            } catch (IllegalArgumentException e) {
                // Keep existing payment method if invalid
            }
        }
        
        if (paymentDTO.getStatus() != null) {
            try {
                payment.setStatus(Payment.PaymentStatus.valueOf(paymentDTO.getStatus()));
            } catch (IllegalArgumentException e) {
                // Keep existing status if invalid
            }
        }
        
        return paymentRepository.save(payment);
    }

    public void deletePayment(Long id) {
        Payment payment = paymentRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Payment", "id", id));
        
        paymentRepository.delete(payment);
    }

    public List<Payment> getAllPayments() {
        return paymentRepository.findAll();
    }

    public Payment getPaymentById(Long id) {
        return paymentRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Payment", "id", id));
    }
}
