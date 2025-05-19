<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>Home - The Seabreeze Hotel</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/index.css">
    <style>
        .admin-login {
            position: fixed;
            top: 20px;
            right: 20px;
            background: rgba(255, 255, 255, 0.9);
            padding: 15px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
        }
        .admin-login form {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }
        .admin-login input {
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .admin-login button {
            background: #006994;
            color: white;
            border: none;
            padding: 8px;
            border-radius: 4px;
            cursor: pointer;
        }
        .admin-login button:hover {
            background: #005177;
        }
        .admin-link {
            color: #006994;
            text-decoration: none;
            font-size: 0.9em;
        }
        .admin-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<!-- JSP TEST: If you see a context path below, JSP is working -->
<div style="background-color: yellow; padding: 10px; margin: 10px; border: 2px solid red;">
    <p><b>JSP TEST:</b> Context Path = "<%= request.getContextPath() %>"</p>
    <p>Current Time: <%= new java.util.Date() %></p>
    <p>If you can see this yellow box with the context path and current time, JSP is working correctly!</p>
</div>

<div class="navbar">
  <div style="
    display: flex;
    align-items: center;
    justify-content: center;
text-decoration-color: white;">
      <img src="<%= request.getContextPath() %>/images/hotellogo.png" height="110px" width="140px">
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

<!-- Admin Login Section -->
<div class="admin-login">
    <form action="<%= request.getContextPath() %>/login" method="post">
        <h3 style="margin: 0 0 10px 0; color: #006994;">Admin Login</h3>
        <%
            String error = request.getParameter("error");
            if (error != null && error.equals("invalid_admin")) {
        %>
            <div style="color: red; font-size: 0.9em; margin-bottom: 10px;">
                Invalid admin credentials
            </div>
        <%
            }
        %>
        <input type="hidden" name="action" value="login">
        <input type="text" name="username" placeholder="Admin Username" required>
        <input type="password" name="password" placeholder="Password" required>
        <button type="submit">Login as Admin</button>
        <a href="<%= request.getContextPath() %>/login" class="admin-link">Admin Portal</a>
    </form>
</div>

<div class="content1">
  <img src="<%= request.getContextPath() %>/images/seabreeze.png" alt="Hotel Image" width=100% height="auto">
</div>

<div class="content2" style="font-family: 'Carla Sans', serif; color: #006994; line-height: 1.8; font-size:x-large;"><p><b>WELCOME TO THE SEABREEZE HOTEL!</b><br>
    <i>Where Coastal Comfort Meets Elegant Escape</i></div>
<div class="content3" style="font-family: 'Carla Sans', serif; color:black; line-height: 1.8; font-size:x-large;">
    Set along the tranquil shoreline, Seabreeze offers oceanfront luxury with relaxed charm. Whether for a peaceful escape or a scenic business stay, our boutique hotel features elegant rooms, thoughtful service, and coastal-inspired comfort. Wake to the sound of waves, savor a fresh seaside breakfast, and enjoy moments made to be remembered.
</div>

<img src="<%= request.getContextPath() %>/images/White%20and%20Gold%20Minimalist%20Feminine%20Hotel%20Logo%20(1).png" class="image-right">
<footer>
  <p><b>Explore</b><br>
      <a href="index.jsp" style="text-decoration: none; color: white;">Home</a> | <a href="index.jsp" style="text-decoration: none;color: white;">About Us</a> | <a href="#" style="text-decoration: none;color: white;">Rooms</a> | <a href="pages/login.jsp" style="text-decoration: none;color: white;">Login</a> | <a href="pages/signup.jsp" style="text-decoration: none;color: white;">Sign Up</a>
  <br><br><b>Get in Touch</b><br>
   Hotel Contact Information<br>
      <a href="mailto:info@seabreeze.com"  style="text-decoration: none; color: white;">info@seabreeze.com</a><br>
   +94 113 393 830<br><br>
      <b>Follow Us</b><br>
    <img src="<%= request.getContextPath() %>/images/socialmedia.png" height="50" width="200" align="center"><br><br>
   ©2025 The Seabreeze Hotel, Inc. All rights reserved</p>
</footer>

</body>
</html>