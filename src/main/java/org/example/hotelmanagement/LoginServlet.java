package org.example.hotelmanagement;

import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.List;

@WebServlet(name = "login-servlet", value = "/login-servlet")
public class LoginServlet extends HttpServlet {

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
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username == null || password == null || username.trim().isEmpty() || password.trim().isEmpty()) {
            response.sendRedirect("pages/login.jsp?error=emptyfields");
            return;
        }

        String hashedPassword = hashPassword(password);
        String filePath = getServletContext().getRealPath("/WEB-INF/data-store/data.json");
        File file = new File(filePath);

        boolean loginSuccessful = false;
        String fullname = null;

        if (file.exists()) {
            ObjectMapper objectMapper = new ObjectMapper();
            try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
                List<User> users = objectMapper.readValue(reader,
                        objectMapper.getTypeFactory().constructCollectionType(List.class, User.class));

                for (User user : users) {
                    if (user.username.equals(username) && user.password.equals(hashedPassword)) {
                        fullname = user.fullname;
                        loginSuccessful = true;
                        break;
                    }
                }
            } catch (IOException e) {
                e.printStackTrace();
                response.sendRedirect("pages/login.jsp?error=servererror");
                return;
            }
        }

        if (loginSuccessful) {
            HttpSession session = request.getSession(true);
            session.setAttribute("username", username);
            session.setAttribute("fullname", fullname);
            session.setAttribute("password", hashedPassword);
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        } else {
            response.sendRedirect("pages/login.jsp?error=invalidcredentials");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.sendRedirect(request.getContextPath() + "pages/login.jsp");
    }
}
