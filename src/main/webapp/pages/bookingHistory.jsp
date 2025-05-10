<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.hotelmanagement.Booking" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Bookings | Hotel Reservation System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
      body {
        background-color: #f8f9fa; /* Fallback background color */
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        margin-top: 100px;
        background-image: url('../images/background.png'); /* Path to your PNG image */
        background-repeat: no-repeat; /* Prevent the image from repeating */
        background-size: cover; /* Scale the image to cover the entire body */
        background-position: center center; /* Center the image in the body */
      }
        .booking-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            overflow: hidden;
        }
        .booking-table th, .booking-table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        .booking-table th {
            background-color: #006994;
            color: white;
            font-weight: bold;
        }
        .booking-table tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        .booking-table tr:hover {
            background-color: #e0e0e0;
        }
        .booking-actions a {
            margin-right: 10px;
            text-decoration: none;
            color: #007bff;
            font-size: 0.9em;
        }
        .booking-actions a:hover {
            text-decoration: underline;
        }
        .no-bookings {
            text-align: center;
            padding: 20px;
            font-style: italic;
            color: #777;
        }
        /* Custom Navbar CSS */
        .navbar {
            background-color: #006994;
            display: flex;
            align-items: center;
            padding: 10px 50px;
            position: fixed;
            top: 0;
            width: 100%;
            z-index: 10001;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            overflow: visible;
        }

        .nav-left img {
            height: 60px; /* Adjust this value to make the logo smaller */
            width: auto;
        }

        .nav-center {
            display: flex;
            gap: 20px;
            position: absolute;
            left: 50%;
            transform: translateX(-50%);
        }

        .nav-center a {
            color: white;
            text-decoration: none;
            padding: 10px 15px;
            font-size: 16px;
            transition: background-color 0.3s;
        }

        .nav-center a:hover {
            color: white;
            text-decoration: underline;
            background-color: rgba(255, 255, 255, 0.1);
        }

        .nav-right {
            margin-left: auto;
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .nav-right a {
            color: white;
            text-decoration: none;
            padding: 10px 15px;
            font-size: 16px;
            transition: background-color 0.3s;
        }

        .nav-right a:hover {
            color: white;
            text-decoration: underline;
            background-color: rgba(255, 255, 255, 0.1);
        }

        .dropdown {
            position: relative;
            display: inline-block;
            padding: 10px 0;
            overflow: visible; /* Ensure the dropdown is not clipped */
        }

        .dropdown-content {
            display: none;
            position: absolute;
            background-color: white;
            min-width: 120px;
            box-shadow: 0px 8px 16px rgba(221, 221, 221, 0.5);
            z-index: 9999;
            margin-top: 0;
            top: 100%; /* Position it just below the button */
            left: 0;    /* Align to the left of the dropdown */
        }

        .dropdown-content a {
            color: #333 !important;
            padding: 10px 12px;
            text-decoration: none;
            display: block;
            width: 100%;
            box-sizing: border-box;
            text-align: center;
        }

        .dropdown-content a:hover {
            background-color: #e0e0e0;
            color: #006994 !important;
        }

        .dropdown:hover .dropdown-content {
            display: block; /* Display the dropdown when hovering over .dropdown */
        }

        /* Footer CSS */
        footer {
            padding: 20px;
            background-color: #006994;
            text-align: center;
            line-height: 1.8;
            color: white;
            margin-top: 30px;
        }
        footer a {
            color: white;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <div class="navbar" style="overflow: visible">
        <div class="nav-left">
            <img src="../images/hotellogo.png" height="60px" width="auto" alt="Hotel Logo">
        </div>
        <div class="nav-center">
            <a href="../index.jsp">Home</a>
            <a href="../index.jsp#AboutUs">About Us</a>
            <a href="#">Rooms</a>
            <a href="#">Book Now</a>
            <a href="#">Reviews</a>
        </div>
        <div class="nav-right">
            <div class="dropdown">
                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false" style="color: white; text-decoration: none;">
                    <img src="../images/userlogo.png" alt="default User" style="width:40px; height:40px; border-radius:50%;" /> Hello, <%= session.getAttribute("username") != null ? session.getAttribute("username") : "Guest" %>
                </a>
                <div class="dropdown-content">
                    <a href="../pages/viewprofile.jsp">View Profile</a>
                    <a href="../pages/updateprofile.jsp">Update Profile</a>
                    <a href="../logout-servlet">Logout</a>
                </div>
            </div>
        </div>
    </div>

    <div class="container mt-5">
        <h2>My Bookings</h2>
        <table class="booking-table">
            <thead>
                <tr>
                    <th>Booking ID</th>
                    <th>Room ID</th>
                    <th>Check-in Date</th>
                    <th>Check-out Date</th>
                    <th>Guests</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody id="booking-list">
                <%
                    List<Booking> bookings = (List<Booking>) request.getAttribute("bookings");
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

                    if (bookings != null && !bookings.isEmpty()) {
                        for (Booking booking : bookings) {
                %>
                <tr>
                    <td><%= booking.getBookingId() %></td>
                    <td><%= booking.getRoomId() %></td>
                    <td><%= sdf.format(booking.getCheckInDate()) %></td>
                    <td><%= sdf.format(booking.getCheckOutDate()) %></td>
                    <td><%= booking.getGuests() %></td>
                    <td><%= booking.getStatus() %></td>
                    <td class="booking-actions">
                        <a href="#">View Details</a>
                        <% if ("CONFIRMED".equals(booking.getStatus())) { %>
                        <a href="<%= request.getContextPath() %>/booking?action=cancel&bookingId=<%= booking.getBookingId() %>">Cancel</a>
                        <% } else { %>
                        <span style="color: #777;">Cancelled</span>
                        <% } %>
                    </td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="7" class="no-bookings">No bookings found.</td>
                </tr>
                <%
                    }
                %>
                </tbody>
        </table>

        </div>

    <footer>
        <p><b>Explore</b><br>
            <a href="../index.jsp" style="text-decoration: none; color: white;">Home</a> | <a href="../index.jsp" style="text-decoration: none;color: white;">About Us</a> | <a href="#" style="text-decoration: none;color: white;">Rooms</a> | <a href="../pages/login.jsp" style="text-decoration: none;color: white;">Login</a> | <a href="../pages/signup.jsp" style="text-decoration: none;color: white;">Sign Up</a>
            <br><br><b>Get in Touch</b><br>
            Hotel Contact Information<br>
            <a href="mailto:info@seabreeze.com" style="text-decoration: none; color: white;">info@seabreeze.com</a><br>
            +94 113 393 830<br><br>
            <b>Follow Us</b><br>
            <div class="social-icons">
                <img src="../images/socialmedia.png" alt="Follow us on social media" style="height: 50px; width: 200px;">
            </div>
            <br>
            ©2025 The Seabreeze Hotel, Inc. All rights reserved</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // JavaScript for any client-side functionality can be added here if needed.
    </script>
</body>
</html>