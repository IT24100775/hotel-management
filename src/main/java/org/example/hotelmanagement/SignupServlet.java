package org.example.hotelmanagement;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

@WebServlet(name = "signup-servlet", value = "/signup-servlet")
public class SignupServlet extends HttpServlet {

    private String hashPassword(String password) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(password.getBytes(StandardCharsets.UTF_8));
            StringBuilder hex = new StringBuilder();
            for (byte b : hash) {
                hex.append(String.format("%02x", b));
            }
            return hex.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Error hashing password", e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String fullname = request.getParameter("fullname");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (fullname == null || username == null || password == null) {
            System.out.println("Missing input: " + (fullname == null ? "fullname " : "")
                    + (username == null ? "username " : "")
                    + (password == null ? "password " : ""));
            response.sendRedirect("/pages/signup.jsp?error=missingfields");
            return;
        }

        fullname = fullname.trim();
        username = username.trim();
        password = password.trim();

        if (fullname.isEmpty() || username.isEmpty() || password.isEmpty()) {
            response.sendRedirect("/pages/signup.jsp?error=emptyfields");
            return;
        }

        String hashedPassword = hashPassword(password);
        String filePath = getServletContext().getRealPath("/WEB-INF/users.txt");
        File file = new File(filePath);

        // Check if username already exists
        boolean userExists = false;
        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length >= 1 && parts[0].equals(username)) {
                    userExists = true;
                    break;
                }
            }
        }

        if (userExists) {
            response.sendRedirect("./pages/signup.jsp?error=userexists");
            return;
        }

        // Append new user to file
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(file, true))) {
            writer.write(String.join(",", username, fullname, hashedPassword, "", ""));
            writer.newLine();
        }

        HttpSession session = request.getSession(true);
        session.setAttribute("fullname", fullname);
        session.setAttribute("username", username);
        session.setAttribute("password", hashedPassword);
        session.setAttribute("email", "");
        session.setAttribute("phone", "");

        System.out.println("New user registered: " + username);
        response.sendRedirect(request.getContextPath() + "/index.jsp");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.sendRedirect(request.getContextPath() + "/pages/signup.jsp");
    }
}