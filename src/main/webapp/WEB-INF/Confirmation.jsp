%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Room Management Confirmation</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      background-color: #f4f6f9;
    }
    .confirmation-box {
      margin-top: 100px;
      padding: 30px;
      border-radius: 15px;
      background-color: #ffffff;
      box-shadow: 0 0 15px rgba(0,0,0,0.1);
    }
  </style>
</head>
<body>
<div class="container d-flex justify-content-center align-items-center min-vh-100">
  <div class="confirmation-box text-center">
    <h2 class="text-success mb-3">Success!</h2>

    <%
      String action = request.getParameter("action"); // e.g., "added", "updated", "deleted"
      String roomId = request.getParameter("roomId"); // e.g., "R101"
      if (action != null && roomId != null) {
    %>
    <p>Room with ID <strong><%= roomId %></strong> was successfully <strong><%= action %></strong>.</p>
    <%
    } else {
    %>
    <p>Action completed successfully.</p>
    <%
      }
    %>

    <a href="roomManagement.jsp" class="btn btn-primary mt-3">Back to Room Management</a>
  </div>
</div>
</body>
</html>