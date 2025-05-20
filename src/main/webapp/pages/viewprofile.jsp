<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
  <title>View Profile - The Seabreeze Hotel</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  <link href="../CSS/viewprofile.css" rel="stylesheet">
</head>
<body style="background-image: url('../images/bglogin.jpg');">
<jsp:include page="./reusableComponents/navbar.jsp"/>

<%
  String username = (String) session.getAttribute("username");
  if (username == null || username.isEmpty()) {
    response.sendRedirect("login.jsp");
    return;
  }

  // If logged in, retrieve the user profile details
  String fullname = (String) session.getAttribute("fullname");
  String email = (String) session.getAttribute("email");
  String phone = (String) session.getAttribute("phone");

  fullname = (fullname != null && !fullname.isEmpty()) ? fullname : "Not Set";
  email = (email != null && !email.isEmpty()) ? email : "Not Set";
  phone = (phone != null && !phone.isEmpty()) ? phone : "Not Set";
%>

<div class="container mt-5">
  <div class="card">
    <div class="card-header">
      <img src="../images/human.png" alt="default User" style="width:100px; height:100px; border-radius:50%;" >
      <h2>My Profile</h2>
    </div>
    <div class="card-body"><br>
      <div class="profile-row">
        <div class="label">Username</div>
        <div class="value"><%= username %></div>
      </div>
      <div class="profile-row">
        <div class="label">Full Name</div>
        <div class="value"><%= fullname %></div>
      </div>
      <div class="profile-row">
        <div class="label">Email</div>
        <div class="value"><%= email %></div>
      </div>
      <div class="profile-row">
        <div class="label">Phone</div>
        <div class="value"><%= phone %></div>
      </div>

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
    </div>
  </div>
</div>


<jsp:include page="./reusableComponents/footer.jsp"/>
</body>
</html>
