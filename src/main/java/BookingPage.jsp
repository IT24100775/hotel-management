<%@ page import="java.util.*, RoomManagement.Room, RoomManagement.RoomFileHandler" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Booking Page</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
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
</head>
<body class="container mt-5">
<h2 class="mb-4">Available Rooms for Booking</h2>

<table class="table table-bordered">
    <thead class="table-light">
    <tr>
        <th>Room ID</th>
        <th>Room Type</th>
        <th>Availability</th>
        <th>Action</th>
    </tr>
    </thead>
    <tbody>
    <%
        List<Room> rooms = new ArrayList<>();
        rooms.add(new Room("R101", "Single", true));
        rooms.add(new Room("R102", "Double", true));
        rooms.add(new Room("R103", "Suite", true));

        for(Room sampleRoom : rooms) {
    %>
    <tr>
        <td><%= sampleRoom.getRoomID() %></td>
        <td><%= sampleRoom.getType() %></td>
        <td><%= sampleRoom.isAvailable() ? "Available" : "Unavailable" %></td>
        <td>
            <form action="BookingServlet" method="post">
                <input type="hidden" name="roomID" value="<%= sampleRoom.getRoomID() %>" />
                <button type="submit" name="action" value="book" class="btn btn-primary btn-sm">Book Room</button>
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