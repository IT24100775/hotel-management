package org.example.model;

import java.time.LocalDateTime;

/**
 * Base User class representing any user in the system
 * Contains common properties and methods for all user types
 */
public abstract class User {
    // Encapsulated properties - private to ensure data security
    private String username;
    private String password;
    private String email;
    private LocalDateTime lastLoggedIn;
    private boolean isActive;
    
    /**
     * Default constructor
     */
    public User() {
        this.isActive = true;
        this.lastLoggedIn = LocalDateTime.now();
    }
    
    /**
     * Constructor with basic user information
     * @param username The user's unique username
     * @param password The user's password
     * @param email The user's email address
     */
    public User(String username, String password, String email) {
        this.username = username;
        this.password = password;
        this.email = email;
        this.isActive = true;
        this.lastLoggedIn = LocalDateTime.now();
    }
    
    // Getter and setter methods for encapsulation
    public String getUsername() {
        return username;
    }
    
    public void setUsername(String username) {
        this.username = username;
    }
    
    // Password is encapsulated - getter only returns if it exists, not the actual value
    public boolean hasPassword() {
        return password != null && !password.isEmpty();
    }
    
    // Password getter - returns the actual password
    public String getPassword() {
        return password;
    }
    
    // Password setter - allows changing the password
    public void setPassword(String password) {
        this.password = password;
    }
    
    // Method to validate a password
    public boolean validatePassword(String inputPassword) {
        return this.password != null && this.password.equals(inputPassword);
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public LocalDateTime getLastLoggedIn() {
        return lastLoggedIn;
    }
    
    public void setLastLoggedIn(LocalDateTime lastLoggedIn) {
        this.lastLoggedIn = lastLoggedIn;
    }
    
    public boolean isActive() {
        return isActive;
    }
    
    public void setActive(boolean active) {
        isActive = active;
    }
    
    /**
     * Updates the lastLoggedIn time to now
     */
    public void updateLastLogin() {
        this.lastLoggedIn = LocalDateTime.now();
    }
    
    /**
     * Abstract method that must be implemented by subclasses
     * @return A string description of the user type
     */
    public abstract String getUserType();
    
    /**
     * Determines if the user has permission to access a specific feature
     * @param featureName The name of the feature to check permission for
     * @return true if the user has permission, false otherwise
     */
    public abstract boolean hasPermission(String featureName);
    
    @Override
    public String toString() {
        return String.format("User[username=%s, email=%s, active=%s, lastLogin=%s]", 
                            username, email, isActive, lastLoggedIn);
    }
} 