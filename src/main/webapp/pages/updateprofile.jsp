<%--
  Created by IntelliJ IDEA.
  User: Nuha
  Date: 4/17/2025
  Time: 7:45 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Update Profile</title>
</head>
<body>
<h2>Personal Details</h2>
<h3>Update your info</h3>>
<h2>Update Your Profile</h2>
<form action="update-profile-servlet" method="post">
    <label>Full Name:</label><br>
    <%
        String fullname = (String) session.getAttribute("fullname");
    %>
    <input type="text" name="fullname" value="<%= fullname %>" required><br><br>

    <label>New Password (leave blank to keep current):</label><br>
    <input type="password" name="password"><br><br>

    <input type="submit" value="Update Profile">
</form>

</body>
</html>
