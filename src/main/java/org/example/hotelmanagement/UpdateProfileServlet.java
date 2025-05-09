package org.example.hotelmanagement;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.*;

@WebServlet(name = "updateprofile-servlet", value = "/updateprofile-servlet")
public class UpdateProfileServlet extends HttpServlet {

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
        String newFullname = request.getParameter("fullname");
        String newPassword = request.getParameter("password");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");

        HttpSession session = request.getSession(false);
        String username = (session != null) ? (String) session.getAttribute("username") : null;
        System.out.println("Searching for username: " + username);

        if (username == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        if (newFullname == null || newFullname.trim().isEmpty()) {
            response.sendRedirect("pages/updateprofile.jsp?error=emptyfields");
            return;
        }

        String filePath = getServletContext().getRealPath("/WEB-INF/users.txt");
        System.out.println("Reading file at: " + filePath);
        File file = new File(filePath);
        List<String> lines = new ArrayList<>();
        boolean updated = false;

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length >= 3 && parts[0].equals(username)) {
                    String existingFullname = parts[1];
                    String existingHashedPassword = parts[2];
                    String existingEmail = parts.length > 3 ? parts[3] : "";
                    String existingPhone = parts.length > 4 ? parts[4] : "";

                    String hashedPassword = (newPassword != null && !newPassword.trim().isEmpty())
                            ? hashPassword(newPassword)
                            : existingHashedPassword;

                    String updatedFullname = (newFullname != null && !newFullname.trim().isEmpty()) ? newFullname : existingFullname;
                    String updatedEmail = (email != null && !email.trim().isEmpty()) ? email : existingEmail;
                    String updatedPhone = (phone != null && !phone.trim().isEmpty()) ? phone : existingPhone;

                    lines.add(String.join(",", username, updatedFullname, hashedPassword, updatedEmail, updatedPhone));

                    // Update session values
                    session.setAttribute("fullname", updatedFullname);
                    session.setAttribute("password", hashedPassword);
                    session.setAttribute("email", updatedEmail);
                    session.setAttribute("phone", updatedPhone);

                    updated = true;
                } else {
                    lines.add(line);
                }
            }
        }

        if (!updated) {
            response.sendRedirect("pages/updateprofile.jsp?error=usernotfound");
            return;
        }

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(file, false))) {
            for (String l : lines) {
                writer.write(l);
                writer.newLine();
            }
        }

        response.sendRedirect("pages/viewprofile.jsp?success=updated");
    }}
