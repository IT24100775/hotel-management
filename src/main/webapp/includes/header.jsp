<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% 
    Object adminObj = session.getAttribute("admin");
    String username = null;
    boolean isAdmin = false;
    if (adminObj != null) {
        isAdmin = true;
        try {
            java.lang.reflect.Method getUsername = adminObj.getClass().getMethod("getUsername");
            username = (String) getUsername.invoke(adminObj);
        } catch (Exception e) {
            username = "Admin";
        }
    } else {
        username = (String) session.getAttribute("username");
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hotel Reservation System</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/index.css">
</head>
<body>
    <div class="navbar" style="background: #167bbf; color: white;">
        <div style="display: flex; align-items: center; justify-content: center; text-decoration-color: white;">
            <img src="<%= request.getContextPath() %>/images/hotellogo.png" height="110px" width="140px">
            <a href="<%= request.getContextPath() %>/index.jsp" style="color: white;">Home</a>
            <a href="#" style="color: white;">About Us</a>
            <a href="#" style="color: white;">Rooms</a>
            <% if (!isAdmin && (username == null || username.isEmpty())) { %>
                <a href="<%= request.getContextPath() %>/index.jsp" style="color: white;">Login</a>
                <a href="<%= request.getContextPath() %>/pages/signup.jsp" style="color: white;">Sign Up</a>
            <% } else if (isAdmin) { %>
                <div class="dropdown">
                    <div class="dropbutton">Hello, <%= username %> ▾</div>
                    <div class="dropdown-content">
                        <a href="<%= request.getContextPath() %>/adminDashboard.jsp">Dashboard</a>
                        <a href="<%= request.getContextPath() %>/logout">Logout</a>
                    </div>
                </div>
            <% } else { %>
                <div class="dropdown">
                    <div class="dropbutton">Hello, <%= username %> ▾</div>
                    <div class="dropdown-content">
                        <a href="updateprofile-servlet">Update Profile</a>
                        <a href="logout-servlet">Logout</a>
                    </div>
                </div>
            <% } %>
        </div>
    </div>

    <div>
</div>
</body>
</html> 