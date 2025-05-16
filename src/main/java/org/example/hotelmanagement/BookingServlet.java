package org.example.hotelmanagement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher; // Import this class
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
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
                String roomId = request.getParameter("modalRoomId");
                String checkInParam = request.getParameter("checkIn");  // Use hidden field names
                String checkOutParam = request.getParameter("checkOut"); // Use hidden field names
                int guests = Integer.parseInt(request.getParameter("guests"));
                String roomType = request.getParameter("modalRoomType");
                String roomPriceStr = request.getParameter("modalRoomPrice");


                Date checkInDate = null;
                Date checkOutDate = null;

                try {
                    checkInDate = sdf.parse(checkInParam);
                    checkOutDate = sdf.parse(checkOutParam);
                } catch (Exception ex) {
                    ex.printStackTrace();
                    response.sendRedirect("booking.jsp?error=Invalid+date+format");
                    return;
                }

                Booking booking = new Booking(
                        userId,
                        roomId,
                        checkInDate,
                        checkOutDate,
                        guests
                );

                // Assuming BookingFileHandler.saveBooking now returns the booking ID or the Booking object itself
                String bookingId = BookingFileHandler.saveBooking(booking);

                double totalPrice = 0;
                try {
                    long diff = checkOutDate.getTime() - checkInDate.getTime();
                    int numberOfNights = (int) (diff / (24 * 60 * 60 * 1000));
                    double roomPrice = Double.parseDouble(roomPriceStr);
                    totalPrice = roomPrice * numberOfNights;
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                    response.sendRedirect("booking.jsp?error=Invalid+room+price");
                    return;
                }


                // Set attributes in the request
                request.setAttribute("bookingId", bookingId);
                request.setAttribute("checkInDate", checkInParam);
                request.setAttribute("checkOutDate", checkOutParam);
                request.setAttribute("totalPrice", totalPrice);
                request.setAttribute("roomType", roomType);
                request.setAttribute("guests", String.valueOf(guests)); // Make sure guests is a String

                // Forward to booking confirmation page with details
                RequestDispatcher rd = request.getRequestDispatcher("/pages/bookingconfirmation.jsp");
                rd.forward(request, response);

            } else if ("cancel".equals(action)) {
                // Cancel existing booking
                String bookingId = request.getParameter("bookingId");
                String reason = request.getParameter("cancellationReason");
                String otherReason = request.getParameter("otherReason");

                // If "Other" is selected, use custom input
                if ("other".equals(reason)) {
                    reason = otherReason;
                }

                if (bookingId != null && !bookingId.isEmpty()) {
                    boolean success = BookingFileHandler.cancelBooking(bookingId);

                    if (success) {
                        // Optionally, you can store the cancellation reason somewhere
                        response.sendRedirect("dashboard.jsp?message=Booking+cancelled+successfully");
                    } else {
                        response.sendRedirect("pages/cancel-confirmation.jsp?error=Cancellation+failed");
                    }
                } else {
                    response.sendRedirect("dashboard.jsp?error=Invalid+booking+ID");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("dashboard.jsp?error=Invalid+booking+details");
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
