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
                Booking booking;
                booking = new Booking(
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
                    response.sendRedirect("cancel-confirmation.jsp?error=Cancellation+failed");

                } else {
                    response.sendRedirect("dashboard.jsp?error=Invalid+booking+ID");
                }
            }
        } catch (Exception e) {
            response.sendRedirect("dashboard.jsp?error=Invalid+booking+ID");
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

        String action = request.getParameter("action");

        try {
            if ("view".equals(action)) {
                // View all bookings
                List<Booking> bookings = BookingFileHandler.getUserBookings(userId);
                QuickSort.sortBookingsByCheckInDate(bookings);
                request.setAttribute("bookings", bookings);
                request.getRequestDispatcher("dashboard.jsp").forward(request, response);

            } else if ("cancel".equals(action)) {
                // Show cancel confirmation page
                String bookingId = request.getParameter("bookingId");
                if (bookingId != null && !bookingId.isEmpty()) {
                    Booking booking = BookingFileHandler.getBookingById(bookingId);
                    if (booking != null && booking.getUserId().equals(userId)) {
                        request.setAttribute("booking", booking);
                        request.getRequestDispatcher("cancelBooking.jsp").forward(request, response);
                    } else {
                        response.sendRedirect("dashboard.jsp?error=Booking+not+found");
                    }
                } else {
                    response.sendRedirect("dashboard.jsp?error=Invalid+booking+ID");
                }
            } else {
                // Default action - view bookings
                List<Booking> bookings = BookingFileHandler.getUserBookings(userId);
                QuickSort.sortBookingsByCheckInDate(bookings);
                request.setAttribute("bookings", bookings);
                request.getRequestDispatcher("dashboard.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?message=Error+processing+request");
        }
    }
}