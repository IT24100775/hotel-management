<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Confirmation | Hotel Reservation System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin-top: 100px;
            background-image: url('../images/background.png');
            background-repeat: no-repeat;
            background-size: cover;
            background-position: center center;
        }

        .confirmation-card {
            max-width: 600px;
            margin: 50px auto;
            padding: 30px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .check-icon {
            font-size: 5rem;
            color: #28a745;
            margin-bottom: 20px;
        }

        .booking-details {
            background-color: #e9ecef;
            padding: 20px;
            border-radius: 8px;
            margin: 20px 0;
        }

        .booking-details p {
            margin-bottom: 10px;
        }

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
            height: 60px;
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
            overflow: visible;
        }

        .dropdown-content {
            display: none;
            position: absolute;
            background-color: white;
            min-width: 120px;
            box-shadow: 0px 8px 16px rgba(221, 221, 221, 0.5);
            z-index: 9999;
            top: 100%;
            left: 0;
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
            display: block;
        }

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
            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"
               style="color: white; text-decoration: none;">
                <img src="../images/userlogo.png" alt="default User"
                     style="width:40px; height:40px; border-radius:50%;"/> Hello, <%= session.getAttribute("username") != null ? session.getAttribute("username") : "Guest" %>
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
    <div class="confirmation-card text-center">
        <div class="check-icon">
            <svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" fill="currentColor"
                 class="bi bi-check-circle-fill" viewBox="0 0 16 16">
                <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-3.97-3.03a.75.75 0 0 0-1.08.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06l2.5 2.5a.75.75 0 0 0 1.08-.022l4.5-5.5a.75.75 0 0 0-.022-1.08z"/>
            </svg>
        </div>
        <div class="alert alert-success" role="alert">
            <h4 class="alert-heading">Booking Confirmed!</h4>
            <p>Your booking has been successfully confirmed. We're excited to welcome you to our resort!</p>
        </div>
        <p class="card-text">
            We’ve received your booking and everything is set.<br>
            A confirmation email has been sent to your registered email address.
        </p>

        <div class="booking-details">
            <h4>Booking Summary:</h4>
            <p><strong>Booking ID:</strong> <span id="bookingIdDisplay"><%= request.getAttribute("bookingId") != null ? request.getAttribute("bookingId") : "N/A" %></span></p>
            <p><strong>Room Type:</strong> <span id="roomType"><%= request.getAttribute("roomType") != null ? request.getAttribute("roomType") : "N/A" %></span></p>
            <p><strong>Check-in Date:</strong> <span id="checkInDate"><%= request.getAttribute("checkInDate") != null ? request.getAttribute("checkInDate") : "N/A" %></span></p>
            <p><strong>Check-out Date:</strong> <span id="checkOutDate"><%= request.getAttribute("checkOutDate") != null ? request.getAttribute("checkOutDate") : "N/A" %></span></p>
            <p><strong>Total Price:</strong> <span id="totalPrice"><%= request.getAttribute("totalPrice") != null ? request.getAttribute("totalPrice") : "N/A" %></span></p>
            <p><strong>Number of Guests:</strong> <span id="guests"><%= request.getAttribute("guests") != null ? request.getAttribute("guests") : "N/A" %></span></p>
        </div>

        <p class="card-text">
            <strong>Need Help?</strong><br>
            For changes or cancellations, contact us at:<br>
            <a href="tel:+94771278532">+94 77 1278532</a>
        </p>

        <div class="text-center mt-4">
            <a href="cancel-confirmation.jsp?bookingId=<%= request.getAttribute("bookingId") %>" class="btn btn-danger">Cancel Booking</a>
        </div>
    </div>
</div>

<footer>
    <p><b>Explore</b><br>
        <a href="../index.jsp" style="text-decoration: none; color: white;">Home</a> |
        <a href="../index.jsp" style="text-decoration: none;color: white;">About Us</a> |
        <a href="#" style="text-decoration: none;color: white;">Rooms</a> |
        <a href="../pages/login.jsp" style="text-decoration: none;color: white;">Login</a> |
        <a href="../pages/signup.jsp" style="text-decoration: none;color: white;">Sign Up</a>
        <br><br><b>Get in Touch</b><br>
        Hotel Contact Information<br>
        <a href="mailto:info@seabreeze.com" style="text-decoration: none; color: white;">info@seabreeze.com</a><br>
        +94 113 393 830<br><br>
        <b>Follow Us</b><br>
        <div class="social-icons">
            <img src="../images/socialmedia.png" alt="Follow us on social media" style="height: 50px; width: 200px;">
        </div><br>
        ©2025 The Seabreeze Hotel, Inc. All rights reserved</p>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>