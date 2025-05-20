package org.example.model;

import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

/**
 * AdminUser class that inherits from the User base class
 */
public class AdminUser extends User {
    private int id;
    private String username;
    private String password;
    private String email;
    private String contactNumber;
    private LocalDateTime lastActionTime;
    private LocalDateTime createdAt;
    private String createdBy;
    private LocalDateTime updatedAt;
    private String updatedBy;
    
    /**
     * Default constructor
     */
    public AdminUser() {
        super();
        this.lastActionTime = LocalDateTime.now();
    }
    
    /**
     * Constructor with basic admin information
     */
    public AdminUser(String username, String password, String email) {
        super(username, password, email);
        this.lastActionTime = LocalDateTime.now();
    }
    
    /**
     * Get the admin's contact number
     * @return The admin's contact number
     */
    public String getContactNumber() {
        return contactNumber;
    }
    
    /**
     * Set the admin's contact number
     * @param contactNumber The new contact number
     */
    public void setContactNumber(String contactNumber) {
        this.contactNumber = contactNumber;
    }
    
    /**
     * Get the time of the admin's last action
     * @return The last action time
     */
    public LocalDateTime getLastActionTime() {
        return lastActionTime;
    }
    
    /**
     * Update the last action time to now
     */
    public void updateLastActionTime() {
        this.lastActionTime = LocalDateTime.now();
    }
    
    /**
     * Implementation of abstract method from User
     * @return The user type "ADMIN"
     */
    @Override
    public String getUserType() {
        return "ADMIN";
    }
    
    /**
     * Check if this admin has a specific permission
     * @param featureName The feature to check permission for
     * @return true since all AdminUsers have access to all features
     */
    @Override
    public boolean hasPermission(String featureName) {
        // All AdminUsers have access to all features
        return true;
    }
    
    /**
     * Admin-specific method to log an admin action
     * @param action The action being performed
     * @return A formatted log entry string
     */
    public String logAction(String action) {
        updateLastActionTime();
        return String.format("%s,%s,%s", 
                            LocalDateTime.now(), 
                            getUsername(), 
                            action);
    }
    
    @Override
    public String toString() {
        return String.format("AdminUser[%s, contactNumber=%s, lastAction=%s]",
                           super.toString(),
                           contactNumber,
                           lastActionTime);
    }
    
    /**
     * Convert to CSV format for storage
     * @return CSV string representation of the admin user
     */
    public String toCsvString() {
        return String.format("%s,%s,%s,%s,%s",
                           getUsername(),
                           getPassword(),
                           getEmail(),
                           contactNumber,
                           getLastLoggedIn());
    }
    
    /**
     * Create an AdminUser from a CSV string
     * @param csvString The CSV string to parse
     * @return A new AdminUser object
     */
    public static AdminUser fromCsvString(String csvString) {
        String[] parts = csvString.split(",");
        if (parts.length < 5) {
            throw new IllegalArgumentException("Invalid CSV format for AdminUser");
        }
        
        AdminUser admin = new AdminUser();
        admin.setUsername(parts[0]);
        admin.setPassword(parts[1]);
        admin.setEmail(parts[2]);
        admin.setContactNumber(parts[3]);
        
        try {
            admin.setLastLoggedIn(LocalDateTime.parse(parts[4]));
        } catch (Exception e) {
            System.err.println("Error parsing date in CSV: " + parts[4]);
            admin.setLastLoggedIn(LocalDateTime.now());
        }
        
        return admin;
    }
    
    // Getters and Setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public String getUsername() {
        return username;
    }
    
    public void setUsername(String username) {
        this.username = username;
    }
    
    public String getPassword() {
        return password;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getCreatedBy() {
        return createdBy;
    }
    
    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }
    
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
    
    public String getUpdatedBy() {
        return updatedBy;
    }
    
    public void setUpdatedBy(String updatedBy) {
        this.updatedBy = updatedBy;
    }
    
    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }
    
    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }
} 