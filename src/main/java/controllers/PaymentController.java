
package controllers;

import models.Payment;
import services.PaymentService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PaymentController {
    private final PaymentService paymentService;

    public PaymentController() {
        this.paymentService = new PaymentService();
    }

    public List<Payment> getAllPayments() {
        return paymentService.getAllPayments();
    }

    public Payment getPaymentById(String id) {
        return paymentService.getPaymentById(id);
    }

    public List<Payment> getRefundablePayments() {
        return paymentService.getRefundablePayments();
    }

    public List<Payment> getPaymentsByStatus(String status) {
        return paymentService.getPaymentsByStatus(status);
    }

    public Payment createPayment(Payment payment) {
        return paymentService.createPayment(payment);
    }

    public Map<String, Object> processRefund(String id) {
        Payment payment = paymentService.processRefund(id);
        
        Map<String, Object> response = new HashMap<>();
        if (payment != null && payment.getStatus().equals("refunded")) {
            response.put("success", true);
            response.put("payment", payment);
            return response;
        } else {
            response.put("success", false);
            response.put("message", "Refund failed or payment not eligible for refund");
            return response;
        }
    }
}
