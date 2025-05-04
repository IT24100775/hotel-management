<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>Update Profile</title>
</head>
<body>
<%
    if (session == null || session.getAttribute("username") == null) {
        System.out.println("Session invalid or no username, redirecting to login.jsp");
        response.sendRedirect("login.jsp");
        return;
    }

    String username = (String) session.getAttribute("username");
    String fullname = (String) session.getAttribute("fullname");
    String email = (String) session.getAttribute("email");
    String phone = (String) session.getAttribute("phone");

    if (fullname == null) fullname = "";
    if (email == null) email = "";
    if (phone == null) phone = "";
%>

<h2>Update Profile</h2>

<!-- Display success message -->
<% if (request.getParameter("success") != null && request.getParameter("success").equals("updated")) { %>
<p style="color: green;">Profile successfully updated!</p>
<% } %>

<!-- Display error message -->
<% if (request.getParameter("error") != null) { %>
<p style="color: red;">Error: <%= request.getParameter("error") %></p>
<% } %>

<form action="${pageContext.request.contextPath}/updateprofile-servlet" method="post">
    <label>Username (cannot be changed):</label><br/>
    <input type="text" name="username" value="<%= username %>" readonly /><br/><br/>

    <label>Full Name:</label><br/>
    <input type="text" name="fullname" value="<%= fullname %>" required /><br/><br/>

    <label>New Password (leave blank to keep current):</label><br/>
    <input type="password" name="password" placeholder="Enter new password" /><br/><br/>

    <label>Email:</label><br/>
    <input type="email" name="email" value="<%= email %>" placeholder="Enter email" /><br/><br/>

    <label>Phone:</label><br/>
    <input type="text" name="phone" value="<%= phone %>" placeholder="Enter phone number" /><br/><br/>

    <input type="submit" value="Save Changes" />
</form>

</body>
</html>
