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
import java.util.ArrayList;
import java.util.List;

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

    private void writeUserToJsonFile(User user) throws IOException {
        String filePath = getServletContext().getRealPath("/WEB-INF/data-store/data.json");
        File file = new File(filePath);

        ObjectMapper objectMapper = new ObjectMapper();
        List<User> users;

        File parentDir = file.getParentFile();
        if (!parentDir.exists()) {
            parentDir.mkdirs();
        }

        if (file.exists()) {
            try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
                users = objectMapper.readValue(reader,
                        objectMapper.getTypeFactory().constructCollectionType(List.class, User.class));
            } catch (Exception e) {
                e.printStackTrace();
                users = new ArrayList<>();
            }
        } else {
            file.createNewFile();
            users = new ArrayList<>();
        }

        users.add(user);

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(file))) {
            objectMapper.writeValue(writer, users);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String fullname = request.getParameter("fullname");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        fullname = fullname.trim();
        username = username.trim();
        password = password.trim();

        if (fullname.isEmpty() || username.isEmpty() || password.isEmpty()) {
            response.sendRedirect("pages/signup.jsp?error=emptyfields");
            return;
        }

        String hashedPassword = hashPassword(password);

        String filePath = getServletContext().getRealPath("/WEB-INF/data-store/data.json");
        File file = new File(filePath);
        boolean userExists = false;

        if (file.exists()) {
            //this location is on server that why we can't see it on the project
            System.out.println("file location: " + getServletContext().getRealPath("/WEB-INF/data-store/data.json"));
            try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
                ObjectMapper objectMapper = new ObjectMapper();
                List<User> users = objectMapper.readValue(reader, objectMapper.getTypeFactory().constructCollectionType(List.class, User.class));

                for (User user : users) {
                    if (user.username.equals(username)) {
                        userExists = true;
                        break;
                    }
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        if (userExists) {
            response.sendRedirect("pages/signup.jsp?error=userexists");
            return;
        } else {
            User newUser = new User(username, fullname, hashedPassword);
            try {
                writeUserToJsonFile(newUser);
            } catch (IOException e) {
                e.printStackTrace();
                response.sendRedirect("pages/signup.jsp?error=errorwritingfile");
                return;
            }

            // Set session attributes
            HttpSession session = request.getSession(true);
            session.setAttribute("fullname", fullname);
            session.setAttribute("username", username);
            session.setAttribute("password", hashedPassword);

            System.out.println("New user registered: " + username);
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        }
    }

}
