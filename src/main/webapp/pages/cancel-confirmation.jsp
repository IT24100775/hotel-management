<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Cancelled | Hotel Reservation System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
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

        .cancelled-card {
            max-width: 600px;
            margin: 100px auto;
            padding: 30px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .cancel-icon {
            font-size: 5rem;
            color: #dc3545; /* Red color for cancellation */
            margin-bottom: 20px;
        }

        .need-help {
            margin-top: 30px;
            padding: 20px;
            background-color: #e9ecef;
            border-radius: 8px;
        }

        .need-help p {
            margin-bottom: 10px;
        }

        .contact-info a {
            color: #007bff;
            text-decoration: none;
        }

        .contact-info a:hover {
            text-decoration: underline;
        }

        .go-back-button {
            margin-top: 20px;
        }

        /* Custom Navbar CSS (same as before) */
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
            left: 0; /* Align to the left of the dropdown */
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

        /* Footer CSS (same as before) */
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
    <div class="cancelled-card text-center">
        <div class="cancel-icon">
            <svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" fill="currentColor"
                 class="bi bi-x-circle-fill" viewBox="0 0 16 16">
                <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM5.354 4.646a.5.5 0 1 0-.708.708L7.293 8l-2.647 2.646a.5.5 0 0 0 .708.708L8 8.707l2.646 2.647a.5.5 0 0 0 .708-.708L8.707 8l2.647-2.646a.5.5 0 0 0-.708-.708L8 7.293 5.354 4.646z"/>
            </svg>
        </div>
        <div class="alert alert-danger" role="alert">
            <h4 class="alert-heading">Booking Cancelled</h4>
            <p>Your booking has been successfully cancelled.</p>
            <hr>
            <p class="mb-0">If you have any questions or need further assistance, please don't hesitate to contact us.</p>
        </div>

        <div class="need-help">
            <h5>Need Help?</h5>
            <p>Our support team is ready to assist you.</p>
            <p class="contact-info"><i class="fas fa-phone"></i> <a href="tel:+94771278532">+94 77 1278532</a></p>
            <p class="contact-info"><i class="fas fa-envelope"></i> <a href="mailto:info@seabreeze.com">info@seabreeze.com</a></p>
        </div>

        <div class="go-back-button">
            <a href="../index.jsp" class="btn btn-primary">Return to Homepage</a>
        </div>
    </div>
</div>

<footer>
    <p><b>Explore</b><br>
        <a href="../index.jsp" style="text-decoration: none; color: white;">Home</a> | <a href="../index.jsp"
                                                                                       style="text-decoration: none;color: white;">About
            Us</a> | <a href="#" style="text-decoration: none;color: white;">Rooms</a> | <a
                href="../pages/login.jsp" style="text-decoration: none;color: white;">Login</a> | <a
                href="../pages/signup.jsp" style="text-decoration: none;color: white;">Sign Up</a>
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
</body>
</html>