<%@ page import="java.util.*, RoomManagement.Room, RoomManagement.RoomFileHandler" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Rooms</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
</head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
<body class="container mt-5">
<h2 class="mb-4">Rooms</h2>
<style>
    table {
        border-collapse: collapse;
        width: 100%;
        font-family: Arial, sans-serif;
    }

    th, td {
        text-align: left;
        padding: 12px 15px;
        border: 1px solid #ddd;
    }

    thead th {
        background-color: #007bff; /* Bootstrap primary blue */
        color: white;
        font-weight: bold;
    }

    tbody tr:nth-child(even) {
        background-color: #f2f2f2; /* light gray for even rows */
    }

    tbody tr:hover {
        background-color: #cce5ff; /* light blue hover effect */
    }

    button.btn-sm {
        padding: 4px 10px;
    }
</style>

<!-- Add Room Form: inputs and button in one row -->
<form action="RoomServlet" method="post" class="mb-4 row g-3 align-items-center">
    <div class="col-auto">
        <input type="text" name="roomID" class="form-control" placeholder="Room ID" required />
    </div>
    <div class="col-auto">
        <select name="roomType" class="form-select" required>
            <option value="">Select Room Type</option>
            <option value="Single">Single</option>
            <option value="Double">Double</option>
            <option value="Suite">Suite</option>
        </select>
    </div>
    <div class="col-auto">
        <select name="availability" class="form-select" required>
            <option value="true">Available</option>
            <option value="false">Unavailable</option>
        </select>
    </div>
    <div class="col-auto">
        <button type="submit" name="action" value="add" class="btn btn-success">Add Room</button>
    </div>
</form>

<!-- Rooms Table -->
<table class="table table-bordered">
    <thead class="table-light">
    <tr>
        <th>Room ID</th>
        <th>Room Type</th>
        <th>Availability</th>
        <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <%
        List<Room> roomList = RoomFileHandler.loadRooms();
        if (roomList == null || roomList.isEmpty()) {
        roomList = new ArrayList<>();
        roomList.add(new Room("R100", "Single", true));
    }

        for (Room room : roomList) {
    %>
    <tr>
        <td><%= room.getRoomID() %></td>
        <td><%= room.getType() %></td>
        <td><%= room.isAvailable() ? "Available" : "Unavailable" %></td>
        <td>
            <!-- Edit Button -->
            <form action="RoomServlet" method="post" class="d-inline">
                <input type="hidden" name="roomID" value="<%= room.getRoomID() %>" />
                <button type="submit" name="action" value="edit" class="btn btn-warning btn-sm">Edit</button>
            </form>

            <!-- Delete Button -->
            <form action="RoomServlet" method="post" class="d-inline ms-1">
                <input type="hidden" name="roomID" value="<%= room.getRoomID() %>" />
                <button type="submit" name="action" value="delete" class="btn btn-danger btn-sm">Delete</button>
            </form>
        </td>
    </tr>
    <%
        }
    %>
    </tbody>
</table>
</body>
</html>