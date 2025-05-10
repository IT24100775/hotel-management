<%@ page import="classes.Booking" %>
<%@ page import="classes.BookingFileHandler" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.temporal.ChronoUnit" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String bookingId = request.getParameter("bookingId");
    String userId = (String) session.getAttribute("userId");
    Booking booking = null;

    if (bookingId != null && userId != null) {
        List<Booking> bookings = BookingFileHandler.getBookingsByUserId(userId);
        if (bookings != null) {
            booking = bookings.stream()
                    .filter(b -> b.getBookingId().equals(bookingId))
                    .findFirst()
                    .orElse(null);
        }
    }

    if (booking == null) {
        response.sendRedirect("dashboard.jsp");
        return;
    }

    // Calculate cancellation fee (10% if cancelling within 3 days of check-in)
    LocalDate today = LocalDate.now();
    long daysUntilCheckIn = ChronoUnit.DAYS.between(today, booking.getCheckInDate());
    double cancellationFee = (daysUntilCheckIn <= 3) ? booking.getTotalPrice() * 0.1 : 0;
%>
<!DOCTYPE html>
<html>
<head>
    <title>Cancel Booking</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .cancellation-card {
            border-left: 4px solid #dc3545;
        }
        .fee-warning {
            animation: pulse 2s infinite;
        }
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }
        .btn-danger {
            transition: all 0.3s ease;
        }
        .btn-danger:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(220, 53, 69, 0.3);
        }
    </style>
</head>
<body>
<div class="navbar" style="overflow: visible">
    <div class="nav-left">
        <img src="../images/hotellogo.png" height="60px" width="auto">
    </div>
    <div class="nav-center">
        <a href="../index.jsp">Home</a>
        <a href="../index.jsp#AboutUs">About Us</a>
        <a href="#">Rooms</a>
        <%
            String username = (String) session.getAttribute("username");
            if (username != null && !username.isEmpty()) {
        %>
        <a href="#">Book Now</a>
        <%
        } else {
        %>
        <a href="login.jsp" onclick="alert('Please log in or sign up to book.'); return false;">Book Now</a>
        <%
            }
        %>
        <a href="#">Reviews</a>
    </div>
    <div class="nav-right">
        <div class="dropdown">
            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false" style="color: white; text-decoration: none;">
                <img src="../images/human.png" alt="default User" style="width:40px; height:40px; border-radius:50%;" /> Hello, <%= session.getAttribute("username") %>
            </a>
            <ul class="dropdown-menu">
                <li><a class="dropdown-item" style="color: #000000" href="../pages/viewprofile.jsp">View Profile</a></li>
                <li><a class="dropdown-item" style="color: #000000" href="../pages/updateprofile.jsp">Update Profile</a></li>
                <li><a class="dropdown-item" style="color: #000000" href="../logout-servlet">Logout</a></li>
            </ul>
        </div>
    </div>

    <div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card cancellation-card shadow">
                <div class="card-header bg-danger text-white">
                    <h4 class="mb-0"><i class="fas fa-exclamation-triangle me-2"></i>Cancel Booking</h4>
                </div>
                <div class="card-body">
                    <div class="alert alert-danger">
                        <h5 class="alert-heading">Are you sure you want to cancel this booking?</h5>
                        <p class="mb-0">This action cannot be undone.</p>
                    </div>

                    <div class="booking-details mb-4">
                        <h5 class="mb-3"><i class="fas fa-info-circle me-2"></i>Booking Information</h5>
                        <div class="table-responsive">
                            <table class="table table-bordered">
                                <tr>
                                    <th width="30%">Booking Reference:</th>
                                    <td>#<%= booking.getBookingId().substring(0, 8).toUpperCase() %></td>
                                </tr>
                                <tr>
                                    <th>Room Number:</th>
                                    <td><%= booking.getRoomId() %></td>
                                </tr>
                                <tr>
                                    <th>Check-in Date:</th>
                                    <td><%= booking.getFormattedCheckInDate() %></td>
                                </tr>
                                <tr>
                                    <th>Check-out Date:</th>
                                    <td><%= booking.getFormattedCheckOutDate() %></td>
                                </tr>
                                <tr>
                                    <th>Original Total:</th>
                                    <td>$<%= String.format("%.2f", booking.getTotalPrice()) %></td>
                                </tr>
                                <% if (cancellationFee > 0) { %>
                                <tr class="table-warning fee-warning">
                                    <th>Cancellation Fee (10%):</th>
                                    <td><strong>-$<%= String.format("%.2f", cancellationFee) %></strong></td>
                                </tr>
                                <tr class="table-warning">
                                    <th>Refund Amount:</th>
                                    <td class="text-success">$<%= String.format("%.2f", booking.getTotalPrice() - cancellationFee) %></td>
                                </tr>
                                <% } else { %>
                                <tr class="table-success">
                                    <th>Cancellation Fee:</th>
                                    <td>No fee (Full refund)</td>
                                </tr>
                                <% } %>
                            </table>
                        </div>
                        <% if (cancellationFee > 0) { %>
                        <p class="text-muted small mt-2"><i class="fas fa-info-circle me-1"></i> A 10% fee applies for cancellations within 3 days of check-in</p>
                        <% } %>
                    </div>

                    <form action="BookingServlet" method="post" id="cancelForm">
                        <input type="hidden" name="action" value="cancel">
                        <input type="hidden" name="bookingId" value="<%= booking.getBookingId() %>">

                        <div class="mb-4">
                            <h5 class="mb-3"><i class="fas fa-comment me-2"></i>Cancellation Details</h5>
                            <div class="mb-3">
                                <label for="cancellationReason" class="form-label">Reason for cancellation (optional):</label>
                                <select class="form-select" id="cancellationReason" name="cancellationReason">
                                    <option value="">Select a reason...</option>
                                    <option value="change of plans">Change of plans</option>
                                    <option value="found better option">Found better option</option>
                                    <option value="travel restrictions">Travel restrictions</option>
                                    <option value="financial reasons">Financial reasons</option>
                                    <option value="other">Other</option>
                                </select>
                            </div>

                            <div class="mb-3" id="otherReasonContainer" style="display: none;">
                                <label for="otherReason" class="form-label">Please specify:</label>
                                <textarea class="form-control" id="otherReason" name="otherReason" rows="2" placeholder="Enter your reason here..."></textarea>
                            </div>
                        </div>

                        <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-4">
                            <a href="dashboard.jsp" class="btn btn-secondary me-md-2 px-4">
                                <i class="fas fa-arrow-left me-1"></i> Back to Dashboard
                            </a>
                            <button type="submit" class="btn btn-danger px-4">
                                <i class="fas fa-times-circle me-1"></i> Confirm Cancellation
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Show/hide other reason textarea
    document.getElementById('cancellationReason').addEventListener('change', function() {
        const otherContainer = document.getElementById('otherReasonContainer');
        otherContainer.style.display = (this.value === 'other') ? 'block' : 'none';
    });

    // Confirm before submitting if there's a fee
    document.getElementById('cancelForm').addEventListener('submit', function(e) {
        const fee = <%= cancellationFee %>;
        if (fee > 0) {
            if (!confirm('Warning:A cancellation fee of $${fee.toFixed(2)} will be applied.\n\nContinue with cancellation?')) {
                e.preventDefault();
            }
        }
    });
</script>
</body>
</html>