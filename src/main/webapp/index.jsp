<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>Home - The Seabreeze Hotel</title>
    <link rel="stylesheet" href="CSS/index.css">
</head>
<body>

<div class="navbar">
  <div style="
    display: flex;
    align-items: center;
    justify-content: center;
text-decoration-color: white;">
      <img src="images/hotellogo.png" height="110px" width="140px">
      <a href="index.jsp">Home</a>
      <a href="#">About Us</a>
      <a href="#">Rooms</a>

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
          <div class="dropbutton">Hello, <%= username %> ▾</div>
          <div class="dropdown-content">
              <a href="updateprofile-servlet">Update Profile</a>
              <a href="logout-servlet">Logout</a>
          </div>
          </div>
      </div>
      <%
          }
      %>

  </div>
</div>

<div class="content1">
  <img src="images/seabreeze.png" alt="Hotel Image"  width=100% height="auto">
</div>

<div class="content2" style="font-family: 'Carla Sans', serif; color: #006994; line-height: 1.8; font-size:x-large;"><p><b>WELCOME TO THE SEABREEZE HOTEL!</b><br>
    <i>Where Coastal Comfort Meets Elegant Escape</i></div>
<div class="content3" style="font-family: 'Carla Sans', serif; color:black; line-height: 1.8; font-size:x-large;">
    Set along the tranquil shoreline, Seabreeze offers oceanfront luxury with relaxed charm. Whether for a peaceful escape or a scenic business stay, our boutique hotel features elegant rooms, thoughtful service, and coastal-inspired comfort. Wake to the sound of waves, savor a fresh seaside breakfast, and enjoy moments made to be remembered.
</div>

<img src="images/White%20and%20Gold%20Minimalist%20Feminine%20Hotel%20Logo%20(1).png" class="image-right">
<footer>
  <p><b>Explore</b><br>
      <a href="index.jsp" style="text-decoration: none; color: white;">Home</a> | <a href="index.jsp" style="text-decoration: none;color: white;">About Us</a> | <a href="#" style="text-decoration: none;color: white;">Rooms</a> | <a href="pages/login.jsp" style="text-decoration: none;color: white;">Login</a> | <a href="pages/signup.jsp" style="text-decoration: none;color: white;">Sign Up</a>
  <br><br><b>Get in Touch</b><br>
   Hotel Contact Information<br>
      <a href="mailto:info@seabreeze.com"  style="text-decoration: none; color: white;">info@seabreeze.com</a><br>
   +94 113 393 830<br><br>
      <b>Follow Us</b><br>
    <img src="images/socialmedia.png" height="50"  width="200" align="center"><br><br>
   ©2025 The Seabreeze Hotel, Inc. All rights reserved</p>
</footer>

</body>
</html>