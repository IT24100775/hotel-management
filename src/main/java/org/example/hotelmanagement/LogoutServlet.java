package org.example.hotelmanagement;

import java.io.*;
        import jakarta.servlet.http.*;
        import jakarta.servlet.annotation.*;

@WebServlet(name = "logout-servlet", value = "/logout-servlet")
public class LogoutServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect("index.jsp");
    }
}







