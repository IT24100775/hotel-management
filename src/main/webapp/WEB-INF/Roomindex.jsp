<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Room Management System</title>

    <!-- Add your CSS framework here (Bootstrap/Tailwind CSS) -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>

<title>Welcome to Room Management</title>
<style>
    /* Style to set the image as the background for the entire page */
    body {
        margin: 0;
        padding: 0;
    height: 100%;
        background-image: url("${pageContext.request.contextPath}/images/room-image.jpg");
        background-size: cover; /* Ensure the image covers the entire page */
        background-position: center center; /* Center the image */
        background-attachment: fixed; /* Make the image stay fixed while scrolling */
    }
</style>
</head>
<body>
<div style="color: white; text-align: center; padding: 20px;">
    <h1>Welcome to Room Management</h1>

</div>
</body>
</html>

<div class="row">
    <div class="col-12 text-center">
        <p>Manage rooms, bookings and much more.</p>
    </div>
</div>

<!-- Admin Login or Dashboard Link -->
<div class="row">
    <div class="col-12 text-center">
        <a href="adminLogin.jsp" class="btn btn-primary btn-lg">Admin Login</a>
    </div>
</div>

<!-- Regular User Login or Registration Link -->
<div class="row mt-3">
    <div class="col-12 text-center">
        <a href="userLogin.jsp" class="btn btn-secondary btn-lg">User Login</a>
    </div>
</div>

<!-- Public/Guest Access to Rooms (Optional) -->
<div class="row mt-3">
    <div class="col-12 text-center">
        <a href="bookingPage.jsp" class="btn btn-info btn-lg">Browse Rooms</a>
    </div>
</div>

</div>

<!-- Optional: Add JavaScript for Bootstrap or your custom JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>


</body>
</html>
