<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Room Management</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
  <h2 class="mb-4">Manage Rooms</h2>
  <div class="mb-3">
    <a href="addRoom.jsp" class="btn btn-primary">Add New Room</a>
  </div>

  <!-- Table of rooms -->
  <table class="table table-bordered table-striped">
    <thead>
    <tr>
      <th>Room ID</th>
      <th>Room Type</th>
      <th>Availability</th>
      <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="room" items="${rooms}">
      <tr>
        <td>${room.roomID}</td>
        <td>${room.type}</td>
        <td>${room.availability}</td>
        <td>
          <a href="editRoom.jsp?roomID=${room.roomID}" class="btn btn-warning btn-sm">Edit</a>
          <a href="deleteRoom.jsp?roomID=${room.roomID}" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this room?')">Delete</a>
        </td>
      </tr>
    </c:forEach>
    </tbody>
  </table>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>