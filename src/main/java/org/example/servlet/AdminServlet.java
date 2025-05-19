package org.example.servlet;

import org.example.model.AdminUser;
import org.example.dao.AdminDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Servlet for handling administrative user operations
 * Demonstrates abstraction by hiding implementation details and exposing only necessary functionality
 */
@WebServlet(urlPatterns = {"/admin/*", "/dashboard", "/login", "/logout"})
public class AdminServlet extends HttpServlet {
    // Encapsulating the DAO - nobody outside needs direct access to it
    private final AdminDAO adminDAO = new AdminDAO();
    
    /**
     * Handles GET requests for admin operations
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String servletPath = request.getServletPath();
        
        // Check if user is logged in for protected paths
        if (!"/login".equals(servletPath) && !isLoggedIn(request)) {
            response.sendRedirect(request.getContextPath() + "/");
            return;
        }
        
        // Dispatch to appropriate handler based on path
        if ("/dashboard".equals(servletPath)) {
            handleDashboard(request, response);
        } else if ("/login".equals(servletPath)) {
            request.getRequestDispatcher("/pages/login.jsp").forward(request, response);
        } else if ("/logout".equals(servletPath)) {
            handleLogout(request, response);
        } else if ("/admin".equals(servletPath)) {
            handleAdminRequests(request, response);
        }
    }
    
    /**
     * Handle admin-specific path requests
     */
    private void handleAdminRequests(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        if (!isLoggedIn(request)) {
            response.sendRedirect(request.getContextPath() + "/");
            return;
        }
        handleDashboard(request, response);
    }
    
    /**
     * Handles the dashboard request
     */
    private void handleDashboard(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        AdminUser currentAdmin = getCurrentAdmin(request);
        List<AdminUser> admins = adminDAO.getAllAdmins();
        List<String> activities = adminDAO.getAdminLogs();
        
        request.setAttribute("currentAdmin", currentAdmin);
        request.setAttribute("admins", admins);
        request.setAttribute("activities", activities);
        request.getRequestDispatcher("/adminDashboard.jsp").forward(request, response);
    }
    
    /**
     * Handles user logout
     */
    private void handleLogout(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            AdminUser admin = (AdminUser) session.getAttribute("admin");
            if (admin != null) {
                adminDAO.logAdminActivity(admin, "Logged out");
            }
            session.invalidate();
        }
        response.sendRedirect(request.getContextPath() + "/");
    }
    
    /**
     * Checks if the user is logged in
     */
    private boolean isLoggedIn(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session != null && session.getAttribute("admin") != null;
    }
    
    /**
     * Gets the currently logged in admin
     */
    private AdminUser getCurrentAdmin(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session != null ? (AdminUser) session.getAttribute("admin") : null;
    }
    
    /**
     * Handles POST requests for admin operations
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String servletPath = request.getServletPath();
        String action = request.getParameter("action");
        
        if ("/login".equals(servletPath) || ("/admin".equals(servletPath) && "login".equals(action))) {
            handleLogin(request, response);
            return;
        }
        
        // Check login for other paths
        if (!isLoggedIn(request)) {
            response.sendRedirect(request.getContextPath() + "/");
            return;
        }
        
        AdminUser currentAdmin = getCurrentAdmin(request);
        
        if ("create".equals(action)) {
            handleCreateAdmin(request, response, currentAdmin);
        } else if ("update".equals(action)) {
            handleUpdateAdmin(request, response, currentAdmin);
        } else if ("delete".equals(action)) {
            handleDeleteAdmin(request, response, currentAdmin);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
        }
    }
    
    /**
     * Handles admin login
     */
    private void handleLogin(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        if (username != null && password != null) {
            AdminUser admin = adminDAO.validateCredentials(username, password);
            
            if (admin != null) {
                // Create session and store admin
                HttpSession session = request.getSession(true);
                session.setAttribute("admin", admin);
                
                // Log the login activity
                adminDAO.logAdminActivity(admin, "Logged in");
                
                // Redirect to dashboard
                response.sendRedirect(request.getContextPath() + "/dashboard");
                return;
            } else {
                response.sendRedirect(request.getContextPath() + "/?error=invalid_admin");
                return;
            }
        }
        
        // If login failed, redirect to home page
        response.sendRedirect(request.getContextPath() + "/");
    }
    
    /**
     * Handles creating a new admin
     */
    private void handleCreateAdmin(HttpServletRequest request, HttpServletResponse response, AdminUser currentAdmin) 
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        
        if (username != null && password != null && email != null) {
            AdminUser newAdmin = new AdminUser();
            newAdmin.setUsername(username);
            newAdmin.setPassword(password); // In production, this should be hashed
            newAdmin.setEmail(email);
            newAdmin.setCreatedBy(currentAdmin.getUsername());
            newAdmin.setCreatedAt(LocalDateTime.now());
            
            if (adminDAO.createAdmin(newAdmin)) {
                adminDAO.logAdminActivity(currentAdmin, "Created new admin: " + username);
                response.sendRedirect(request.getContextPath() + "/dashboard");
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to create admin");
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing required fields");
        }
    }
    
    /**
     * Handles updating an existing admin
     */
    private void handleUpdateAdmin(HttpServletRequest request, HttpServletResponse response, AdminUser currentAdmin) 
            throws ServletException, IOException {
        String adminId = request.getParameter("adminId");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        
        if (adminId != null && username != null && email != null) {
            AdminUser admin = new AdminUser();
            admin.setId(Integer.parseInt(adminId));
            admin.setUsername(username);
            admin.setEmail(email);
            admin.setUpdatedBy(currentAdmin.getUsername());
            admin.setUpdatedAt(LocalDateTime.now());
            
            if (adminDAO.updateAdmin(admin)) {
                adminDAO.logAdminActivity(currentAdmin, "Updated admin: " + username);
                response.sendRedirect(request.getContextPath() + "/dashboard");
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to update admin");
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing required fields");
        }
    }
    
    /**
     * Handles deleting an admin
     */
    private void handleDeleteAdmin(HttpServletRequest request, HttpServletResponse response, AdminUser currentAdmin) 
            throws ServletException, IOException {
        String adminId = request.getParameter("adminId");
        
        if (adminId != null) {
            AdminUser adminToDelete = adminDAO.getAdminByUsername(adminId);
            if (adminToDelete != null && adminDAO.deleteAdmin(adminId)) {
                adminDAO.logAdminActivity(currentAdmin, "Deleted admin: " + adminToDelete.getUsername());
                response.sendRedirect(request.getContextPath() + "/dashboard");
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to delete admin");
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing admin ID");
        }
    }
} 