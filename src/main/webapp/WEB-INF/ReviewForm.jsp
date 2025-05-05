<%--
  Created by IntelliJ IDEA.
  User: rozanna
  Date: 5/5/2025
  Time: 10:43 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Hotel Review System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f3f3f3;
            margin: 0;
            padding: 20px;
        }
        .container {
            width: 500px;
            margin: auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 0px 15px rgba(0,0,0,0.2);
        }
        h1 {
            text-align: center;
        }
        label {
            font-weight: bold;
            margin-top: 10px;
            display: block;
        }
        input, textarea, select {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            margin-bottom: 15px;
            border-radius: 5px;
            border: 1px solid #ccc;
            font-size: 1em;
        }
        button {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 12px;
            width: 100%;
            border-radius: 5px;
            font-size: 1em;
            cursor: pointer;
        }
        button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Hotel Review & Rating</h1>
    <form action="submitReview.jsp" method="post">
        <label for="hotelName">Hotel Name:</label>
        <input type="text" id="hotelName" name="hotelName" required>

        <label for="userName">Your Name:</label>
        <input type="text" id="userName" name="userName" required>

        <label for="rating">Rating (1-5):</label>
        <select id="rating" name="rating" required>
            <option value="">Select</option>
            <% for (int i = 1; i <= 5; i++) { %>
            <option value="<%= i %>"><%= i %></option>
            <% } %>
        </select>

        <label for="review">Review:</label>
        <textarea id="review" name="review" rows="5" required></textarea>

        <button type="submit">Submit Review</button>
    </form>
</div>
</body>
</html>