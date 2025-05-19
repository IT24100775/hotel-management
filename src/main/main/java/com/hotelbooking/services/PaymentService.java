
package com.hotelbooking.services;

import com.hotelbooking.models.Payment;
import com.hotelbooking.models.Payment.CardDetails;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Collectors;

public class PaymentService {
    private static Map<String, Payment> payments = new HashMap<>();
    
    static {
        // Initialize with sample data
        initializeSamplePayments();
    }
    
    private static void initializeSamplePayments() {
        // Sample payment 1
        Payment payment1 = new Payment(
            "pay-1",
            "book-1",
            85000.00,
            "LKR",
            "completed",
            "2025-04-15T10:30:00Z",
            "credit_card",
            new CardDetails("4242", "Visa"),
            true,
            "Grand Seaside Resort",
            "Deluxe Ocean View",
            "2025-05-10",
            "2025-05-15"
        );
        
        // Sample payment 2
        Payment payment2 = new Payment(
            "pay-2",
            "book-2",
            45000.00,
            "LKR",
            "completed",
            "2025-03-22T14:15:00Z",
            "paypal",
            null,
            false,
            "Mountain View Lodge",
            "Standard Double Room",
            "2025-04-05",
            "2025-04-08"
        );
        
        // Sample payment 3
        Payment payment3 = new Payment(
            "pay-3",
            "book-3",
            200000.00,
            "LKR",
            "refunded",
            "2025-02-17T09:45:00Z",
            "credit_card",
            new CardDetails("1234", "Mastercard"),
            false,
            "City Center Suites",
            "Executive Suite",
            "2025-03-12",
            "2025-03-19"
        );
        
        payments.put(payment1.getId(), payment1);
        payments.put(payment2.getId(), payment2);
        payments.put(payment3.getId(), payment3);
    }

    public List<Payment> getAllPayments() {
        return new ArrayList<>(payments.values());
    }

    public Payment getPaymentById(String id) {
        return payments.get(id);
    }

    public List<Payment> getPaymentsByStatus(String status) {
        return payments.values().stream()
            .filter(payment -> payment.getStatus().equals(status))
            .collect(Collectors.toList());
    }
    
    public List<Payment> getRefundablePayments() {
        return payments.values().stream()
            .filter(Payment::isRefundable)
            .filter(payment -> payment.getStatus().equals("completed"))
            .collect(Collectors.toList());
    }

    public Payment createPayment(Payment payment) {
        if (payment.getId() == null || payment.getId().isEmpty()) {
            payment.setId("pay-" + UUID.randomUUID().toString().substring(0, 8));
        }
        
        if (payment.getDate() == null || payment.getDate().isEmpty()) {
            DateTimeFormatter formatter = DateTimeFormatter.ISO_DATE_TIME;
            payment.setDate(LocalDateTime.now().format(formatter));
        }
        
        payments.put(payment.getId(), payment);
        return payment;
    }

    public Payment processRefund(String paymentId) {
        Payment payment = payments.get(paymentId);
        if (payment != null && payment.isRefundable() && payment.getStatus().equals("completed")) {
            payment.setStatus("refunded");
            payment.setRefundable(false);
            payments.put(paymentId, payment);
        }
        return payment;
    }
}
