<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>Home - My App</title>
  <style>
    body { font-family: Arial, sans-serif; margin: 0; padding: 0; }
    .navbar {
      background-color: #333;
      overflow: hidden;
    }
    .navbar a {
      float: left;
      color: #f2f2f2;
      text-align: center;
      padding: 14px 20px;
      text-decoration: none;
    }
    .navbar a:hover {
      background-color: #ddd;
      color: black;
    }
    .content {
      padding: 30px;
    }
  </style>
</head>
<body>

<div class="navbar">
  <a href="#">Home</a>
  <a href="#">About</a>
  <a href="pages/login.jsp">Login</a>
  <a href="pages/signup.jsp">Signup</a>
</div>

<div class="content">
  <h1>Welcome to My Hotel Management App!</h1>
</div>
</body>
</html>