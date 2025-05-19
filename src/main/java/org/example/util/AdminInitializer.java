package org.example.util;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import org.example.dao.AdminDAO;
import org.example.model.AdminUser;
import java.time.LocalDateTime;

/**
 * Context listener that initializes admin data when the application starts
 */
@WebListener
public class AdminInitializer implements ServletContextListener {
    private final AdminDAO adminDAO = new AdminDAO();
    
    @Override
    public void contextInitialized(ServletContextEvent event) {
        // Initialize default admin account if it doesn't exist
        initializeDefaultAdmin();
    }
    
    @Override
    public void contextDestroyed(ServletContextEvent event) {
        // Cleanup if needed
    }
    
    private void initializeDefaultAdmin() {
        AdminUser existingAdmin = adminDAO.getAdminByUsername("admin");
        
        if (existingAdmin == null) {
            AdminUser defaultAdmin = new AdminUser();
            defaultAdmin.setUsername("admin");
            defaultAdmin.setPassword("admin123"); // In production use a secure hashed password
            defaultAdmin.setEmail("admin@hotelreservation.com");
            defaultAdmin.setContactNumber("+1234567890");
            defaultAdmin.setCreatedBy("system");
            defaultAdmin.setCreatedAt(LocalDateTime.now());
            
            if (adminDAO.createAdmin(defaultAdmin)) {
                adminDAO.logAdminActivity(defaultAdmin, "Default admin account created by system");
            }
        }
    }
} 