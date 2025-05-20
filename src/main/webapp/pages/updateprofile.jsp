<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>Update Profile - The Seabreeze Hotel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <link href="../CSS/updateprofile.css" rel="stylesheet">
</head>
<body style="background-image: url('../images/bglogin.jpg'); background-repeat: no-repeat; background-size: cover; background-position: center; margin: 0; height: 100vh;">
<jsp:include page="/pages/reusableComponents/navbar.jsp" />

<%
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String fullname = (String) session.getAttribute("fullname");
    String email = (String) session.getAttribute("email");
    String phone = (String) session.getAttribute("phone");

    if (fullname == null) fullname = "";
    if (email == null) email = "";
    if (phone == null) phone = "";
%>

<div class="container mt-5">
    <div class="card">
        <div class="card-header">
            <h2><br>Update Profile</h2>
        </div>
        <div class="card-body">
            <%
                if (request.getParameter("success") != null && request.getParameter("success").equals("updated")) {
            %>
            <div class="alert alert-success">Profile successfully updated!</div>
            <%
                }
            %>

            <form action="${pageContext.request.contextPath}/updateprofile-servlet" method="post">
                <div class="mb-3">
                    <label class="form-label">Username (cannot be changed):</label>
                    <input type="text" class="form-control" name="username" value="<%= session.getAttribute("username") %>" readonly />
                </div>

                <div class="mb-3">
                    <label class="form-label">Full Name:</label>
                    <input type="text" class="form-control" name="fullname" value="<%= fullname %>" required />
                </div>

                <div class="mb-3">
                    <label class="form-label">New Password (leave blank to keep current):</label>
                    <input type="password" class="form-control" name="password" placeholder="Enter new password" />
                </div>

                <div class="mb-3">
                    <label class="form-label">Email:</label>
                    <input type="email" class="form-control" name="email" value="<%= email %>" placeholder="Enter email" />
                </div>

                <div class="mb-3">
                    <label class="form-label">Phone:</label>
                    <input type="text" class="form-control" name="phone" value="<%= phone %>" placeholder="Enter phone number" />
                </div>

                <div class="mb-3" style="text-align: center; padding-top: 20px;">
                    <input type="submit" class="btn btn-primary" value="Save Changes" />
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="/pages/reusableComponents/footer.jsp" />

</body>
</html>

