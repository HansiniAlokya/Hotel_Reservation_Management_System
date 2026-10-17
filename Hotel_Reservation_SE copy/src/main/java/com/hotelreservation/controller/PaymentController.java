package com.hotelreservation.controller;

import com.hotelreservation.dto.PaymentDTO;
import com.hotelreservation.model.Payment;
import com.hotelreservation.repository.PaymentRepository;
import com.hotelreservation.service.PaymentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/api/payments")
public class PaymentController {

    @Autowired
    private PaymentService paymentService;

    @Autowired
    private PaymentRepository paymentRepository;

    @GetMapping
    public String paymentsPage(Model model) {
        try {
            List<Payment> payments = paymentRepository.findAll();
            List<PaymentDTO> paymentDTOs = payments.stream()
                    .map(this::convertToDTO)
                    .collect(Collectors.toList());
            
            model.addAttribute("payments", paymentDTOs);
            model.addAttribute("totalPayments", paymentDTOs.size());
            model.addAttribute("totalAmount", paymentDTOs.stream()
                    .mapToDouble(p -> p.getAmount().doubleValue())
                    .sum());
            
            return "payments";
        } catch (Exception e) {
            model.addAttribute("error", "Error loading payments: " + e.getMessage());
            return "payments";
        }
    }

    @GetMapping("/api")
    @ResponseBody
    public ResponseEntity<List<PaymentDTO>> getAllPayments() {
        try {
            List<Payment> payments = paymentRepository.findAll();
            List<PaymentDTO> paymentDTOs = payments.stream()
                    .map(this::convertToDTO)
                    .collect(Collectors.toList());
            return ResponseEntity.ok(paymentDTOs);
        } catch (Exception e) {
            return ResponseEntity.status(500).body(null);
        }
    }

    @PostMapping("/api")
    @ResponseBody
    public ResponseEntity<?> createPayment(@RequestBody PaymentDTO paymentDTO) {
        try {
            Payment payment = paymentService.createPayment(paymentDTO);
            PaymentDTO responseDTO = convertToDTO(payment);
            return ResponseEntity.ok(responseDTO);
        } catch (Exception e) {
            return ResponseEntity.status(500).body(Map.of(
                "error", "Error creating payment",
                "message", e.getMessage()
            ));
        }
    }

    @PutMapping("/api/{id}")
    @ResponseBody
    public ResponseEntity<?> updatePayment(@PathVariable Long id, @RequestBody PaymentDTO paymentDTO) {
        try {
            Payment payment = paymentService.updatePayment(id, paymentDTO);
            PaymentDTO responseDTO = convertToDTO(payment);
            return ResponseEntity.ok(responseDTO);
        } catch (Exception e) {
            return ResponseEntity.status(500).body(Map.of(
                "error", "Error updating payment",
                "message", e.getMessage()
            ));
        }
    }

    @DeleteMapping("/api/{id}")
    @ResponseBody
    public ResponseEntity<?> deletePayment(@PathVariable Long id) {
        try {
            paymentService.deletePayment(id);
            return ResponseEntity.ok(Map.of("message", "Payment deleted successfully"));
        } catch (Exception e) {
            return ResponseEntity.status(500).body(Map.of(
                "error", "Error deleting payment",
                "message", e.getMessage()
            ));
        }
    }

    private PaymentDTO convertToDTO(Payment payment) {
        PaymentDTO dto = new PaymentDTO();
        dto.setId(payment.getId());
        dto.setAmount(payment.getAmount());
        dto.setPaymentMethod(payment.getPaymentMethod() != null ? payment.getPaymentMethod().name() : "UNKNOWN");
        dto.setStatus(payment.getStatus() != null ? payment.getStatus().name() : "PENDING");
        dto.setCreatedAt(payment.getCreatedAt());
        
        if (payment.getReservation() != null) {
            dto.setReservationId(payment.getReservation().getId());
            dto.setReservationNumber(payment.getReservation().getReservationNumber());
            
            if (payment.getReservation().getUser() != null) {
                dto.setGuestName(payment.getReservation().getUser().getFirstName() + " " + 
                               payment.getReservation().getUser().getLastName());
            }
        }
        
        return dto;
    }
}
