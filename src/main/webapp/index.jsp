<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>Home - My App</title>
  <style>
      body { font-family: 'Arial', sans-serif; margin: 0; padding: 0;}

    .navbar {
      background-color: #006994;
      overflow: hidden;
    }
    .navbar a {
      float: left;
      color: white;
      text-align: center;
      padding: 14px 20px;
      text-decoration: none;
    }
    .navbar a:hover {
      background-color: #ddd;
      color: black;
    }
    .content1 {
      padding: 30px;
    }
.content2{
    padding-right:700px;
    padding-left: 100px;
    font-family:'Carla Sans',sans-serif;
    color: #006994;
}
.content3{
    padding-right:700px;
    padding-left: 100px;
    padding-bottom: 50px;
    font-family:'Carla Sans',sans-serif;
    color: black;

}
      .image-right {
          float: right;
          margin-left: 20px;
          width: 450px;
          height: 400px;
          margin-top: -450px;
          margin-right: 100px;
      }
    footer {
      padding: 20px;
      background-color: #006994;
      text-align: center;
      line-height:1.8;
        color: white;
    }


  </style>
</head>
<body>

<div class="navbar">
  <div style="
    display: flex;
    align-items: center;
    justify-content: center;
text-decoration-color: white;">
      <img src="images/hotellogo.png" height="110px" width="140px">
      <a href="#">Home</a>
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
      <a>Hello: <%= username %></a>
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
Home | About Us | Rooms | Login | Sign Up
  <br><br><b>Get in Touch</b><br>
   Hotel Contact Information<br>
   info@nameofhotel.com<br>
   +94 113 393 830<br><br>
      <b>Follow Us</b><br>
    <img src="images/socialmedia.png" height="50"  width="200" align="center"><br><br>
   ©2025 nameofhotel, Inc. All rights reserved</p>
</footer>





</body>
</html>