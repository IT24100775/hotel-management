<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
  <title>View Profile - The Seabreeze Hotel</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<%
  if (session == null || session.getAttribute("username") == null || ((String) session.getAttribute("username")).isEmpty()) {
    response.sendRedirect("${pageContext.request.contextPath}/login.jsp");
    return;
  }

  String username = (String) session.getAttribute("username");
  String fullname = (String) session.getAttribute("fullname");
  String email = (String) session.getAttribute("email");
  String phone = (String) session.getAttribute("phone");

  // Default values if null or empty
  fullname = (fullname != null && !fullname.isEmpty()) ? fullname : "Not set";
  email = (email != null && !email.isEmpty()) ? email : "Not set";
  phone = (phone != null && !phone.isEmpty()) ? phone : "Not set";
%>

<div class="container mt-5">
  <div class="card">
    <div class="card-header">
      <h2>Your Profile</h2>
    </div>
    <div class="card-body">
      <p><b>Username:</b> <%= username %></p>
      <p><b>Full Name:</b> <%= fullname %></p>
      <p><b>Email:</b> <%= email %></p>
      <p><b>Phone:</b> <%= phone %></p>

        <%
    String success = request.getParameter("success");
    if ("updated".equals(success)) {
%>
      <div class="alert alert-success" role="alert">
        Profile updated successfully!
      </div>
        <%
    }
%>

</body>
</html>