package org.example.hotelmanagement;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "login-servlet", value = "/login-servlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        request.getSession().setAttribute("username", username);

        if (!username.isEmpty()) {
            response.sendRedirect("../hotel_management_war_exploded/index.jsp");

        } else {
            response.sendRedirect("../webapp/pages/login.jsp?error=true");
        }
    }
}
