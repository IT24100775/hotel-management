package org.example.dao;

import org.example.model.AdminUser;

import java.io.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for AdminUser entities.
 * Handles CRUD operations for admin accounts stored in admins.txt file.
 * Implements encapsulation by hiding the data storage implementation.
 */
public class AdminDAO {
    private static final String DATA_DIR = System.getProperty("catalina.base", System.getProperty("user.dir")) + File.separator + "data";
    private static final String ADMIN_FILE = DATA_DIR + File.separator + "admins.txt";
    private static final String ADMIN_LOG_FILE = DATA_DIR + File.separator + "admin_logs.txt";

    public AdminDAO() {
        try {
            // Create data directory if it doesn't exist
            File dataDir = new File(DATA_DIR);
            if (!dataDir.exists()) {
                dataDir.mkdirs();
                System.out.println("Created data directory at: " + DATA_DIR);
            }
            
            createFileIfNotExists(ADMIN_FILE);
            createFileIfNotExists(ADMIN_LOG_FILE);
            
            System.out.println("AdminDAO initialized. Using files:");
            System.out.println("Admin file: " + ADMIN_FILE);
            System.out.println("Admin log file: " + ADMIN_LOG_FILE);
        } catch (IOException e) {
            System.err.println("Error creating admin files: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private void createFileIfNotExists(String filename) throws IOException {
        File file = new File(filename);
        if (!file.exists()) {
            file.createNewFile();
            System.out.println("Created file: " + filename);
        }
    }

    public List<AdminUser> getAllAdmins() {
        List<AdminUser> admins = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(ADMIN_FILE))) {
            String line;
            while ((line = reader.readLine()) != null) {
                try {
                    admins.add(AdminUser.fromCsvString(line));
                } catch (Exception e) {
                    // skip invalid lines
                    System.err.println("Error parsing admin from line: " + line);
                    e.printStackTrace();
                }
            }
        } catch (IOException e) {
            System.err.println("Error reading admins file: " + e.getMessage());
            e.printStackTrace();
        }
        return admins;
    }

    public AdminUser getAdminByUsername(String username) {
        if (username == null) {
            return null;
        }
        
        for (AdminUser admin : getAllAdmins()) {
            if (username.equals(admin.getUsername())) {
                return admin;
            }
        }
        return null;
    }

    public AdminUser validateCredentials(String username, String password) {
        AdminUser admin = getAdminByUsername(username);
        if (admin != null && password != null && password.equals(admin.getPassword())) {
            return admin;
        }
        return null;
    }

    public boolean createAdmin(AdminUser admin) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(ADMIN_FILE, true))) {
            writer.write(admin.toCsvString());
            writer.newLine();
            return true;
        } catch (IOException e) {
            System.err.println("Error writing to admins file: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateAdmin(AdminUser updatedAdmin) {
        List<AdminUser> admins = getAllAdmins();
        boolean found = false;
        for (int i = 0; i < admins.size(); i++) {
            if (admins.get(i).getUsername().equals(updatedAdmin.getUsername())) {
                admins.set(i, updatedAdmin);
                found = true;
                break;
            }
        }
        if (found) {
            return writeAllAdmins(admins);
        }
        return false;
    }

    public boolean deleteAdmin(String username) {
        List<AdminUser> admins = getAllAdmins();
        boolean removed = admins.removeIf(admin -> admin.getUsername().equals(username));
        if (removed) {
            return writeAllAdmins(admins);
        }
        return false;
    }

    private boolean writeAllAdmins(List<AdminUser> admins) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(ADMIN_FILE, false))) {
            for (AdminUser admin : admins) {
                writer.write(admin.toCsvString());
                writer.newLine();
            }
            return true;
        } catch (IOException e) {
            System.err.println("Error writing all admins to file: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public void logAdminActivity(AdminUser admin, String action) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(ADMIN_LOG_FILE, true))) {
            String logEntry = admin.logAction(action);
            writer.write(logEntry);
            writer.newLine();
        } catch (IOException e) {
            System.err.println("Error writing admin activity log: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public List<String> getAdminLogs() {
        List<String> logs = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(ADMIN_LOG_FILE))) {
            String line;
            while ((line = reader.readLine()) != null) {
                logs.add(line);
            }
        } catch (IOException e) {
            System.err.println("Error reading admin logs: " + e.getMessage());
            e.printStackTrace();
        }
        return logs;
    }
} 