package org.example.util;

import org.example.dao.AdminDAO;
import org.example.model.AdminUser;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.time.LocalDateTime;

/**
 * Utility class for setting up the admin system
 */
public class AdminSetup {
    private final AdminDAO adminDAO = new AdminDAO();
    
    /**
     * Initialize the admin system
     */
    public void initialize() {
        try {
            setupDirectories();
            createDefaultAdmin();
        } catch (Exception e) {
            System.err.println("Error initializing admin system: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    /**
     * Create default admin if it doesn't exist
     */
    public void createDefaultAdmin() {
        AdminUser existingAdmin = adminDAO.getAdminByUsername("admin");
        
        if (existingAdmin == null) {
            AdminUser defaultAdmin = new AdminUser();
            defaultAdmin.setUsername("admin");
            defaultAdmin.setPassword("admin123"); // In production, use a secure hashed password
            defaultAdmin.setEmail("admin@hotelreservation.com");
            defaultAdmin.setContactNumber("+1234567890");
            defaultAdmin.setCreatedBy("system");
            defaultAdmin.setCreatedAt(LocalDateTime.now());
            
            if (adminDAO.createAdmin(defaultAdmin)) {
                adminDAO.logAdminActivity(defaultAdmin, "Default admin account created by system");
                System.out.println("Created default admin account");
            } else {
                System.err.println("Failed to create default admin account");
            }
        } else {
            System.out.println("Default admin account already exists");
        }
    }
    
    /**
     * Set up required directories
     */
    public void setupDirectories() throws IOException {
        // Create data directory if it doesn't exist
        String dataDir = "data";
        File dataDirFile = new File(dataDir);
        if (!dataDirFile.exists()) {
            Files.createDirectories(Paths.get(dataDir));
            System.out.println("Created data directory");
        }
    }
    
    /**
     * Clean up data (use with caution)
     */
    public void cleanupData() {
        try {
            File adminsFile = new File("admins.txt");
            File logsFile = new File("admin_logs.txt");
            
            if (adminsFile.exists()) {
                adminsFile.delete();
                System.out.println("Deleted admins file");
            }
            
            if (logsFile.exists()) {
                logsFile.delete();
                System.out.println("Deleted admin logs file");
            }
        } catch (Exception e) {
            System.err.println("Error cleaning up data: " + e.getMessage());
            e.printStackTrace();
        }
    }
} 