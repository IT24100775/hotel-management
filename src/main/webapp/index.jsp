<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>Home - The Seabreeze Hotel</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/index.css">
    <style>
        .admin-login {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: rgba(255, 255, 255, 0.95);
            padding: 24px 32px;
            border-radius: 8px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.15);
            z-index: 10;
            min-width: 300px;
        }
        .admin-login form {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }
        .admin-login input {
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .admin-login button {
            background: #006994;
            color: white;
            border: none;
            padding: 10px;
            border-radius: 4px;
            cursor: pointer;
        }
        .admin-login button:hover {
            background: #005177;
        }
        @media (max-width: 600px) {
            .admin-login {
                min-width: 90vw;
                padding: 16px 8px;
            }
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
          Object adminObj = request.getSession().getAttribute("admin");
          String username = null;
          if (adminObj != null) {
              // AdminUser object, get username via reflection (since class may not be imported in JSP)
              try {
                  java.lang.reflect.Method getUsername = adminObj.getClass().getMethod("getUsername");
                  username = (String) getUsername.invoke(adminObj);
              } catch (Exception e) {
                  username = "Admin";
              }
          } else {
              username = (String) request.getSession().getAttribute("username");
          }
          if (username == null || username.isEmpty()) {
      %>
      <a href="index.jsp">Login</a>
      <a href="pages/signup.jsp">Sign Up</a>
      <%
      } else {
      %>
      <div class="dropdown">
          <div class="dropbutton">Hello, <%= username %> ▾</div>
          <div class="dropdown-content">
              <a href="updateprofile-servlet">Update Profile</a>
              <a href="logout-servlet">Logout</a>
              <a href="<%= request.getContextPath() %>/dashboard">Admin Dashboard</a>
          </div>
          </div>
      </div>
      <%
          }
      %>

  </div>
</div>

<div class="content1" style="position:relative;">
  <img src="<%= request.getContextPath() %>/images/seabreeze.png" alt="Hotel Image" width=100% height="auto">
  <div class="admin-login">
    <form action="<%= request.getContextPath() %>/login" method="post">
        <h3 style="margin: 0 0 10px 0; color: #006994;">Login</h3>
        <% String error = request.getParameter("error");
           if (error != null && error.equals("invalid_admin")) { %>
            <div style="color: red; font-size: 0.9em; margin-bottom: 10px;">
                Invalid credentials
            </div>
        <% } %>
        <input type="hidden" name="action" value="login">
        <input type="text" name="username" placeholder="Username" required>
        <input type="password" name="password" placeholder="Password" required>
        <button type="submit">Login</button>
    </form>
  </div>
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