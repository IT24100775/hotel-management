package org.example.hotelmanagement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.List;

@WebServlet("/booking")
public class BookingServlet extends HttpServlet {

    private org.example.hotelmanagement.QuickSort QuickSort;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // First validate user session
        String userId = (String) request.getSession().getAttribute("userId");
        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");

        try {
            if ("book".equals(action)) {
                // Create new booking
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Booking booking = new Booking(
                        userId,
                        request.getParameter("roomId"),
                        sdf.parse(request.getParameter("checkIn")),
                        sdf.parse(request.getParameter("checkOut")),
                        Integer.parseInt(request.getParameter("guests")));

                BookingFileHandler.saveBooking(booking);
                response.sendRedirect("dashboard.jsp?message=Booking+created");

            } else if ("cancel".equals(action)) {
                // Cancel existing booking
                String bookingId = request.getParameter("bookingId");
                if (bookingId != null && !bookingId.isEmpty()) {
                    BookingFileHandler.cancelBooking(bookingId);
                    response.sendRedirect("dashboard.jsp?message=Booking+cancelled");
                } else {
                    response.sendRedirect("dashboard.jsp?error=Invalid+booking+ID");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?message=Booking+operation+failed");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Validate user session
        String userId = (String) request.getSession().getAttribute("userId");
        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            // Get and sort bookings
            List<Booking> bookings = BookingFileHandler.getUserBookings(userId);
            QuickSort.sortBookingsByCheckInDate(bookings);

            // Set attributes and forward to dashboard
            request.setAttribute("bookings", bookings);
            request.getRequestDispatcher("dashboard.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?message=Cannot+load+bookings");
        }
    }
}