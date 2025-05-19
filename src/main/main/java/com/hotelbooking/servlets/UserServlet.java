
package com.hotelbooking.servlets;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.hotelbooking.models.User;
import com.hotelbooking.services.UserService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public class UserServlet extends HttpServlet {
    private final UserService userService;
    private final ObjectMapper objectMapper;
    
    public UserServlet() {
        this.userService = new UserService();
        this.objectMapper = new ObjectMapper();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        String pathInfo = request.getPathInfo();
        
        // Handle GET /api/users/{id}
        if (pathInfo != null && pathInfo.length() > 1) {
            String userId = pathInfo.substring(1); // Remove the leading slash
            User user = userService.getUserById(userId);
            
            if (user != null) {
                objectMapper.writeValue(response.getWriter(), user);
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                Map<String, String> error = new HashMap<>();
                error.put("message", "User not found");
                objectMapper.writeValue(response.getWriter(), error);
            }
        } else {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            Map<String, String> error = new HashMap<>();
            error.put("message", "Invalid user ID");
            objectMapper.writeValue(response.getWriter(), error);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        String pathInfo = request.getPathInfo();
        
        // Parse request body
        StringBuilder sb = new StringBuilder();
        BufferedReader reader = request.getReader();
        String line;
        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }
        Map<String, String> requestData = objectMapper.readValue(sb.toString(), Map.class);
        
        Map<String, Object> responseData = new HashMap<>();
        
        // Handle POST /api/users/login
        if ("/login".equals(pathInfo)) {
            String email = requestData.get("email");
            String password = requestData.get("password");
            
            User user = userService.login(email, password);
            
            if (user != null) {
                responseData.put("success", true);
                responseData.put("user", user);
            } else {
                responseData.put("success", false);
                responseData.put("message", "Invalid credentials");
            }
            
            objectMapper.writeValue(response.getWriter(), responseData);
        } 
        // Handle POST /api/users/register
        else if ("/register".equals(pathInfo)) {
            String name = requestData.get("name");
            String email = requestData.get("email");
            String password = requestData.get("password");
            
            User user = userService.registerUser(name, email, password);
            
            if (user != null) {
                responseData.put("success", true);
                responseData.put("user", user);
            } else {
                responseData.put("success", false);
                responseData.put("message", "Registration failed");
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
