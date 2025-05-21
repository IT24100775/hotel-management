package org.example.hotelmanagement;

import com.fasterxml.jackson.databind.ObjectMapper;
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

        if (username == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        if (newFullname == null || newFullname.trim().isEmpty()) {
            response.sendRedirect("pages/updateprofile.jsp?error=emptyfields");
            return;
        }

        String filePath = getServletContext().getRealPath("/WEB-INF/data-store/data.json");
        File file = new File(filePath);
        ObjectMapper objectMapper = new ObjectMapper();
        List<User> users = new ArrayList<>();
        boolean updated = false;

        if (file.exists()) {
            try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
                users = objectMapper.readValue(reader,
                        objectMapper.getTypeFactory().constructCollectionType(List.class, User.class));
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("pages/updateprofile.jsp?error=readerror");
                return;
            }
        }

        for (User user : users) {
            if (user.username.equals(username)) {
                user.fullname = newFullname.trim();

                if (newPassword != null && !newPassword.trim().isEmpty()) {
                    user.password = hashPassword(newPassword.trim());
                    session.setAttribute("password", user.password);
                }

                if (email != null && !email.trim().isEmpty()) {
                    user.email = email.trim();
                    session.setAttribute("email", user.email);
                }

                if (phone != null && !phone.trim().isEmpty()) {
                    user.phone = phone.trim();
                    session.setAttribute("phone", user.phone);
                }

                session.setAttribute("fullname", user.fullname);
                updated = true;
                break;
            }
        }

        if (!updated) {
            response.sendRedirect("pages/updateprofile.jsp?error=usernotfound");
            return;
        }

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(file))) {
            objectMapper.writeValue(writer, users);
        } catch (IOException e) {
            e.printStackTrace();
            response.sendRedirect("pages/updateprofile.jsp?error=writeerror");
            return;
        }

        response.sendRedirect("pages/viewprofile.jsp?success=updated");
    }
}
