<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book a Room | Hotel Reservation System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>

        body {
            background-color: #f8f9fa; /* Fallback background color */
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin-top: 100px;
            background-image: url('../images/background.png'); /* Path to your PNG image */
            background-repeat: no-repeat; /* Prevent the image from repeating */
            background-size: cover; /* Scale the image to cover the entire body */
            background-position: center center; /* Center the image in the body */
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        .search-section {
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
            padding: 20px;
            background-color: white;
            border-radius: 8px;
        }
        .room-card {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            margin-bottom: 20px;
            height: 100%;
        }
        .room-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
        }
        .room-img {
            height: 200px;
            object-fit: cover;
            border-radius: 8px 8px 0 0;
        }
        .amenities-list {
            list-style-type: none;
            padding-left: 0;
        }
        .amenities-list li:before {
            content: "✓ ";
            color: green;
        }
        @media (max-width: 768px) {
            .search-section .row > div {
                margin-bottom: 15px;
            }
        }
        .navbar {
            background-color: #006994;
            display: flex;
            align-items: center;
            padding: 10px 50px;
            position: fixed;
            top: 0;
            width: 100%;
            z-index: 10001;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            overflow: visible;
        }

        .nav-left img {
            height: 60px; /* Adjust this value to make the logo smaller */
            width: auto;
        }

        .nav-center {
            display: flex;
            gap: 20px;
            position: absolute;
            left: 50%;
            transform: translateX(-50%);
        }

        .nav-center a {
            color: white;
            text-decoration: none;
            padding: 10px 15px;
            font-size: 16px;
            transition: background-color 0.3s;
        }

        .nav-center a:hover {
            color: white;
            text-decoration: underline;
            background-color: rgba(255, 255, 255, 0.1);
        }

        .nav-right {
            margin-left: auto;
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .nav-right a {
            color: white;
            text-decoration: none;
            padding: 10px 15px;
            font-size: 16px;
            transition: background-color 0.3s;
        }

        .nav-right a:hover {
            color: white;
            text-decoration: underline;
            background-color: rgba(255, 255, 255, 0.1);
        }

        .dropdown {
            position: relative;
            display: inline-block;
            padding: 10px 0;
            overflow: visible; /* Ensure the dropdown is not clipped */
        }

        .dropdown-menu {
            background-color: white;
        }

        .dropdown-menu a {
            color: #000000 !important;
            padding: 10px 12px;
            text-decoration: none;
            display: block;
            width: 100%;
            box-sizing: border-box;
            text-align: left;
        }

        .dropdown-menu a:hover {
            background-color: #e0e0e0;
            color: #006994 !important;
        }
        footer {
            padding: 20px;
            background-color: #006994;
            text-align: center;
            line-height: 1.8;
            color: white;
            margin-top: 30px; /* Added some top margin to separate from the content */
        }
        footer a {
            color: white;
            text-decoration: none;
        }
        .social-icons {
            margin-top: 10px;
        }
        .social-icons a {
            display: inline-block;
            margin: 0 10px;
        }
        .social-icons img {
            height: 30px;
            width: 30px;
            vertical-align: middle;
        }
    </style>
</head>
<body>
<div class="navbar" style="overflow: visible">
    <div class="nav-left">
        <img src="../images/White and Gold Minimalist Feminine Hotel Logo (1).png" height="60px" width="auto">
    </div>
    <div class="nav-center">
        <a href="../index.jsp">Home</a>
        <a href="../index.jsp#AboutUs">About Us</a>
        <a href="#">Rooms</a>
        <a id="bookNowLink" href="#">Book Now</a>
        <a href="#">Reviews</a>
    </div>
    <div class="nav-right">
        <div class="dropdown">
            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false" style="color: white; text-decoration: none;">
                <img id="userAvatar" src="../images/userlogo.png" alt="default User" style="width:40px; height:40px; border-radius:50%;" /> <span id="greeting">Hello, <%= session.getAttribute("username") != null ? session.getAttribute("username") : "Guest" %></span>
            </a>
            <ul class="dropdown-menu">
                <li><a class="dropdown-item" style="color: #000000" href="../pages/viewprofile.jsp">View Profile</a></li>
                <li><a class="dropdown-item" style="color: #000000" href="../pages/updateprofile.jsp">Update Profile</a></li>
                <li><a class="dropdown-item" style="color: #000000" href="../logout-servlet">Logout</a></li>
            </ul>
        </div>
    </div>
</div>

<div class="container mt-4">
    <h1 class="text-center mb-4">Book a Room</h1>

    <div class="search-section">
        <h3 class="mb-4">Search Available Rooms</h3>
        <form id="searchForm" action="<%= request.getContextPath() %>/booking" method="get">
            <div class="row">
                <div class="col-md-3">
                    <label for="checkInDate" class="form-label">Check-in Date</label>
                    <input type="date" class="form-control" id="checkInDate" name="checkInDate" required>
                </div>
                <div class="col-md-3">
                    <label for="checkOutDate" class="form-label">Check-out Date</label>
                    <input type="date" class="form-control" id="checkOutDate" name="checkOutDate" required>
                </div>
                <div class="col-md-3">
                    <label for="roomType" class="form-label">Room Type</label>
                    <select class="form-select" id="roomType" name="roomType">
                        <option value="all">All Types</option>
                        <option value="single">Single Room</option>
                        <option value="double">Double Room</option>
                        <option value="suite">Suite</option>
                    </select>
                </div>
                <div class="col-md-3 d-flex align-items-end">
                    <button type="submit" class="btn btn-primary w-100">Search Rooms</button>
                    <input type="hidden" name="action" value="search">
                </div>
            </div>
        </form>
    </div>

    <div class="row" id="roomResults">
        <%
            // Assuming you fetch a list of available rooms and store it in a request attribute called "availableRooms"
            List<org.example.hotelmanagement.Room> availableRooms = (List<org.example.hotelmanagement.Room>) request.getAttribute("availableRooms");
            if (availableRooms != null && !availableRooms.isEmpty()) {
                for (org.example.hotelmanagement.Room room : availableRooms) {
        %>
        <div class="col-md-4">
            <div class="card room-card">
                <img src="<%= room.getImageUrl() != null ? room.getImageUrl() : "https://via.placeholder.com/300x200" %>" class="card-img-top room-img" alt="<%= room.getRoomType() %>">
                <div class="card-body">
                    <h5 class="card-title"><%= room.getRoomType() %></h5>
                    <p class="card-text">
                        <strong>Room #:</strong> <%= room.getRoomId() %><br>
                        <strong>Price:</strong> RS.<%= room.getPricePerNight() %> per night<br>
                        <strong>Capacity:</strong> <%= room.getCapacity() %> person<%= room.getCapacity() > 1 ? "s" : "" %>
                    </p>
                    <ul class="amenities-list">
                        <% if (room.hasAmenity("Free WiFi")) { %><li>Free WiFi</li><% } %>
                        <% if (room.hasAmenity("Air Conditioning")) { %><li>Air Conditioning</li><% } %>
                        <% if (room.hasAmenity("TV")) { %><li>TV</li><% } %>
                        <% if (room.hasAmenity("Mini Fridge")) { %><li>Mini Fridge</li><% } %>
                        <% if (room.hasAmenity("Smart TV")) { %><li>Smart TV</li><% } %>
                        <% if (room.hasAmenity("Mini Bar")) { %><li>Mini Bar</li><% } %>
                        </ul>
                    <button class="btn btn-primary book-btn w-100" data-bs-toggle="modal" data-bs-target="#bookingModal"
                            data-room-id="<%= room.getRoomId() %>"
                            data-room-type="<%= room.getRoomType() %>"
                            data-room-price="<%= room.getPricePerNight() %>">
                        Book Now
                    </button>
                </div>
            </div>
        </div>
        <%
                }
            } else {
        %>
        <div class="col-12 text-center">
            <p>No rooms available based on your search criteria.</p>
        </div>
        <%
            }
        %>
    </div>
</div>

<div class="modal fade" id="bookingModal" tabindex="-1" aria-labelledby="bookingModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="bookingModalLabel">Confirm Booking</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="bookingForm" action="<%= request.getContextPath() %>/booking" method="post">
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label">Room Type</label>
                        <input type="text" class="form-control" id="modalRoomType" name="modalRoomType" readonly>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Price per Night (RS)</label>
                        <input type="text" class="form-control" id="modalRoomPrice" name="modalRoomPrice" readonly>
                    </div>
                    <div class="mb-3">
                        <label for="checkInDisplay" class="form-label">Check-in Date</label>
                        <input type="text" class="form-control" id="checkInDisplay" name="checkInDisplay" readonly>
                    </div>
                    <div class="mb-3">
                        <label for="checkOutDisplay" class="form-label">Check-out Date</label>
                        <input type="text" class="form-control" id="checkOutDisplay" name="checkOutDisplay" readonly>
                    </div>
                    <div class="mb-3">
                        <label for="guestName" class="form-label">Full Name</label>
                        <input type="text" class="form-control" id="guestName" name="guestName" required>
                    </div>
                    <div class="mb-3">
                        <label for="guestEmail" class="form-label">Email</label>
                        <input type="email" class="form-control" id="guestEmail" name="guestEmail" required>
                    </div>
                    <div class="mb-3">
                        <label for="guestPhone" class="form-label">Phone Number</label>
                        <input type="tel" class="form-control" id="guestPhone" name="guestPhone" required>
                    </div>
                    <div class="mb-3">
                        <label for="specialRequests" class="form-label">Special Requests</label>
                        <textarea class="form-control" id="specialRequests" name="specialRequests" rows="3"></textarea>
                    </div>
                    <input type="hidden" id="modalRoomId" name="roomId">
                    <input type="hidden" name="action" value="book">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary">Confirm Booking</button>
                </div>
            </form>
        </div>
    </div>
</div>

<footer>
    <p><b>Explore</b><br>
        <a href="../index.jsp" style="text-decoration: none; color: white;">Home</a> | <a href="../index.jsp#AboutUs" style="text-decoration: none;color: white;">About Us</a> | <a href="#" style="text-decoration: none;color: white;">Rooms</a> | <a href="../pages/login.jsp" style="text-decoration: none;color: white;">Login</a> | <a href="../pages/signup.jsp" style="text-decoration: none;color: white;">Sign Up</a>
        <br><br><b>Get in Touch</b><br>
        Hotel Contact Information<br>
        <a href="mailto:info@seabreeze.com" style="text-decoration: none; color: white;">info@seabreeze.com</a><br>
        +94 113 393 830<br><br>
        <b>Follow Us</b><br>
        <div class="social-icons">
            <img src="../images/socialmedia.png" alt="Follow us on social media" style="height: 50px; width: 200px;">
        </div>
        <br>
        ©2025 The Seabreeze Hotel, Inc. All rights reserved</p>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const bookingModal = document.getElementById('bookingModal');
        if (bookingModal) {
            bookingModal.addEventListener('show.bs.modal', function (event) {
                const button = event.relatedTarget;

                // Get data attributes from the triggering button
                const roomId = button.getAttribute('data-room-id');
                const roomType = button.getAttribute('data-room-type');
                const roomPrice = button.getAttribute('data-room-price');

                // Populate modal fields
                const roomIdInput = bookingModal.querySelector('#modalRoomId');
                const roomTypeInput = bookingModal.querySelector('#modalRoomType');
                const roomPriceInput = bookingModal.querySelector('#modalRoomPrice');

                if (roomIdInput) roomIdInput.value = roomId;
                if (roomTypeInput) roomTypeInput.textContent = roomType;
                if (roomPriceInput) roomPriceInput.textContent = roomPrice;
            });
        }
    });
</script>
