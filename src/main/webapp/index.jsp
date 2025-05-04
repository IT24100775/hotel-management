<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Home - The Seabreeze Hotel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="./CSS/index.css">
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>

</head>
<body>
<div class="navbar" style="overflow: visible">
    <div class="nav-left">
        <img src="images/hotellogo.png" height="110px" width="140px">
    </div>
    <div class="nav-center">
        <a href="index.jsp">Home</a>
        <a href="#AboutUs">About Us</a>
        <a href="#">Rooms</a>
    </div>
    <div class="nav-right">
        <%
            String username = (String) request.getSession().getAttribute("username");
            if (username == null || username.isEmpty()) {
        %>
        <a href="pages/login.jsp">Login</a>
        <a href="pages/signup.jsp">Sign Up</a>
        <%
        } else {
        %>
        <div class="dropdown">
            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false" style="color: white; text-decoration: none;">
                Hello, <%= username %>
            </a>
            <ul class="dropdown-menu">
                <li><a class="dropdown-item" style="color: #000000" href="pages/viewprofile.jsp">View Profile</a></li>
                <li><a class="dropdown-item" style="color: #000000" href="pages/updateprofile.jsp">Update Profile</a>
                <li><a class="dropdown-item" style="color: #000000" href="logout-servlet">Logout</a></li>
            </ul>
        </div>
        <%
            }
        %>
    </div>
</div>


<div class="content1">
     <img src="images/seabreeze.png" alt="Hotel Image" width="100%" height="auto"><br><br><br>
    </div>
<section id="AboutUs">
<div class="content2" style="font-family: 'Carla Sans', serif; color: #006994; line-height: 1.8; font-size:x-large;">
    <p><b>WELCOME TO THE SEABREEZE HOTEL!</b><br>
        <i>Where Coastal Comfort Meets Elegant Escape</i>
    </p>
</div>


<div class="content3" style="font-family: 'Carla Sans', serif; color:black; line-height: 1.8; font-size:x-large;">
    Set along the tranquil shoreline, Seabreeze offers oceanfront luxury with relaxed charm. Whether for a peaceful escape or a scenic business stay, our boutique hotel features elegant rooms, thoughtful service, and coastal-inspired comfort. Wake to the sound of waves, savor a fresh seaside breakfast, and enjoy moments made to be remembered.
</div>

</section>
<img src="images/White%20and%20Gold%20Minimalist%20Feminine%20Hotel%20Logo%20(1).png" class="image-right">
<div id="map"></div>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        const map = L.map('map').setView([7.2486, 79.8417], 15); // Coordinates for Negombo Beach

        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            maxZoom: 19,
            attribution: '© <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
        }).addTo(map);

        L.marker([7.2486, 79.8417]).addTo(map)
            .bindPopup('The Seabreeze Hotel<br>Negombo Beach, Sri Lanka')
            .openPopup();
    });
</script>
<footer>
    <p><b>Explore</b><br>
        <a href="index.jsp" style="text-decoration: none; color: white;">Home</a> | <a href="index.jsp" style="text-decoration: none;color: white;">About Us</a> | <a href="#" style="text-decoration: none;color: white;">Rooms</a> | <a href="pages/login.jsp" style="text-decoration: none;color: white;">Login</a> | <a href="pages/signup.jsp" style="text-decoration: none;color: white;">Sign Up</a>
        <br><br><b>Get in Touch</b><br>
        Hotel Contact Information<br>
        <a href="mailto:info@seabreeze.com" style="text-decoration: none; color: white;">info@seabreeze.com</a><br>
        +94 113 393 830<br><br>
        <b>Follow Us</b><br>
        <img src="images/socialmedia.png" height="50" width="200" align="center"><br><br>
        ©2025 The Seabreeze Hotel, Inc. All rights reserved</p>
</footer>
</body>
</html>