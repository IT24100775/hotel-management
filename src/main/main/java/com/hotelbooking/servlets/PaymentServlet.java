
package com.hotelbooking.servlets;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.hotelbooking.models.Payment;
import com.hotelbooking.services.PaymentService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PaymentServlet extends HttpServlet {
    private final PaymentService paymentService;
    private final ObjectMapper objectMapper;
    
    public PaymentServlet() {
        this.paymentService = new PaymentService();
        this.objectMapper = new ObjectMapper();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        String pathInfo = request.getPathInfo();
        
        // GET /api/payments
        if (pathInfo == null || pathInfo.equals("/")) {
            List<Payment> payments = paymentService.getAllPayments();
            objectMapper.writeValue(response.getWriter(), payments);
        } 
        // GET /api/payments/refundable
        else if (pathInfo.equals("/refundable")) {
            List<Payment> payments = paymentService.getRefundablePayments();
            objectMapper.writeValue(response.getWriter(), payments);
        } 
        // GET /api/payments/status/{status}
        else if (pathInfo.startsWith("/status/")) {
            String status = pathInfo.substring("/status/".length());
            List<Payment> payments = paymentService.getPaymentsByStatus(status);
            objectMapper.writeValue(response.getWriter(), payments);
        } 
        // GET /api/payments/{id}
        else {
            String paymentId = pathInfo.substring(1); // Remove the leading slash
            Payment payment = paymentService.getPaymentById(paymentId);
            
            if (payment != null) {
                objectMapper.writeValue(response.getWriter(), payment);
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                Map<String, String> error = new HashMap<>();
                error.put("message", "Payment not found");
                objectMapper.writeValue(response.getWriter(), error);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        String pathInfo = request.getPathInfo();
        
        // Parse request body for POST methods that need it
        StringBuilder sb = new StringBuilder();
        BufferedReader reader = request.getReader();
        String line;
        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }
        
        // POST /api/payments
        if (pathInfo == null || pathInfo.equals("/")) {
            Payment payment = objectMapper.readValue(sb.toString(), Payment.class);
            Payment createdPayment = paymentService.createPayment(payment);
            objectMapper.writeValue(response.getWriter(), createdPayment);
        } 
        // POST /api/payments/{id}/refund
        else if (pathInfo.endsWith("/refund")) {
            String paymentId = pathInfo.substring(1, pathInfo.lastIndexOf("/refund"));
            Payment payment = paymentService.processRefund(paymentId);
            
            Map<String, Object> responseData = new HashMap<>();
            if (payment != null && payment.getStatus().equals("refunded")) {
                responseData.put("success", true);
                responseData.put("payment", payment);
            } else {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                responseData.put("success", false);
                responseData.put("message", "Refund failed or payment not eligible for refund");
            }
            
            objectMapper.writeValue(response.getWriter(), responseData);
        } else {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            Map<String, String> error = new HashMap<>();
            error.put("message", "Invalid endpoint");
            objectMapper.writeValue(response.getWriter(), error);
        }
    }
}
