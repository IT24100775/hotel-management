<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Room Booking</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
  <h2 class="mb-4">Book a Room</h2>

  <form action="confirmBooking.jsp" method="POST">
    <div class="mb-3">
      <label for="room" class="form-label">Choose Room</label>
      <select class="form-select" name="roomID" id="room" required>
        <c:forEach var="room" items="${availableRooms}">
          <option value="${room.roomID}">${room.type} - ${room.availability}</option>
        </c:forEach>
      </select>
    </div>

    <div class="mb-3">
      <label for="bookingDate" class="form-label">Booking Date</label>
      <input type="date" class="form-control" id="bookingDate" name="bookingDate" required>
    </div>

    <button type="submit" class="btn btn-primary">Book Room</button>
  </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>