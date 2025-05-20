<%@ page import="classes.Booking" %>
<%@ page import="classes.BookingFileHandler" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String bookingId = request.getParameter("bookingId");
    Booking booking = null;

    if (bookingId != null) {
        // Replace Stream API with traditional loop for better compatibility
        List<Booking> allBookings = BookingFileHandler.getAllBookings();
        for (Booking b : allBookings) {
            if (b.getBookingId() != null && b.getBookingId().equals(bookingId)) {
                booking = b;
                break;
            }
        }
    }

    if (booking == null) {
        response.sendRedirect("dashboard.jsp");
        return;
    }
%>
<html>
<head>
    <title>Cancel Booking</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="navbar.jsp" />

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card">
                <div class="card-header bg-danger text-white">
                    <h4>Cancel Booking</h4>
                </div>
                <div class="card-body">
                    <p>Are you sure you want to cancel this booking?</p>

                    <div class="alert alert-warning">
                        <strong>Note:</strong> Cancellations may be subject to fees depending on the timing.
                    </div>

                    <h5>Booking Details</h5>
                    <ul class="list-group mb-4">
                        <li class="list-group-item">
                            <strong>Booking ID:</strong>
                            <%= booking.getBookingId() != null ? booking.getBookingId().substring(0, Math.min(8, booking.getBookingId().length())) : "N/A" %>
                        </li>
                        <li class="list-group-item">
                            <strong>Room ID:</strong> <%= booking.getRoomId() != null ? booking.getRoomId() : "N/A" %>
                        </li>
                        <li class="list-group-item">
                            <strong>Check-in:</strong> <%= booking.getCheckInDate() != null ? booking.getCheckInDate().toString() : "N/A" %>
                        </li>
                        <li class="list-group-item">
                            <strong>Check-out:</strong> <%= booking.getCheckOutDate() != null ? booking.getCheckOutDate().toString() : "N/A" %>
                        </li>
                        <li class="list-group-item">
                            <strong>Total:</strong> $<%= booking.getTotalPrice() != null ? String.format("%.2f", booking.getTotalPrice()) : "0.00" %>
                        </li>
                    </ul>

                    <form action="BookingServlet" method="post">
                        <input type="hidden" name="action" value="cancel">
                        <input type="hidden" name="bookingId" value="<%= booking.getBookingId() != null ? booking.getBookingId() : "" %>">

                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-danger">Confirm Cancellation</button>
                            <a href="dashboard.jsp" class="btn btn-secondary">Go Back</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>