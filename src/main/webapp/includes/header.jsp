<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hotel Reservation System - Admin</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/admin.css">
</head>
<body>
    <c:if test="${empty param.hideSidebar}">
        <div class="sidebar">
            <div class="sidebar-header">
                <h3>HRS Admin</h3>
            </div>
            <ul>
                <li class="${pageContext.request.servletPath eq '/adminDashboard.jsp' ? 'active' : ''}">
                    <a href="<%= request.getContextPath() %>/dashboard">
                        <i class="icon-dashboard"></i> <span>Dashboard</span>
                    </a>
                </li>
                <li class="submenu-header">Management</li>
                <li class="${pageContext.request.servletPath eq '/pages/adminManagement.jsp' ? 'active' : ''}">
                    <a href="<%= request.getContextPath() %>/admin/">
                        <i class="icon-admin"></i> <span>Admin Management</span>
                    </a>
                </li>
                <li>
                    <a href="#">
                        <i class="icon-user"></i> <span>User Management</span>
                    </a>
                </li>
                <li>
                    <a href="#">
                        <i class="icon-room"></i> <span>Room Management</span>
                    </a>
                </li>
                <li>
                    <a href="#">
                        <i class="icon-booking"></i> <span>Bookings</span>
                    </a>
                </li>
                <li class="submenu-header">System</li>
                <li class="${pageContext.request.servletPath eq '/pages/adminLogs.jsp' ? 'active' : ''}">
                    <a href="<%= request.getContextPath() %>/admin/logs">
                        <i class="icon-logs"></i> <span>Admin Logs</span>
                    </a>
                </li>
                <li>
                    <a href="#">
                        <i class="icon-settings"></i> <span>Settings</span>
                    </a>
                </li>
            </ul>
        </div>
        
        <div class="content">
    </c:if>
    
    <c:if test="${not empty param.hideSidebar}">
        <div class="content full-width">
    </c:if>
    
        <div class="page-header">
            <div class="header-content">
                <h1>${param.pageTitle}</h1>
                <p>${param.pageSubtitle}</p>
            </div>
            <div class="header-actions">
                <div class="user-info">
                    <c:if test="${not empty sessionScope.admin}">
                        <span>${sessionScope.admin.username}</span>
                        <a href="<%= request.getContextPath() %>/logout" class="logout-btn">Logout</a>
                    </c:if>
                </div>
            </div>
        </div>
        
        <c:if test="${not empty successMessage}">
            <div class="notification success-notification">
                <i class="icon-success"></i>
                <div class="notification-content">
                    <h4>Success</h4>
                    <p>${successMessage}</p>
                </div>
                <button class="close-notification">&times;</button>
            </div>
        </c:if>
        
        <c:if test="${not empty error}">
            <div class="notification error-notification">
                <i class="icon-error"></i>
                <div class="notification-content">
                    <h4>Error</h4>
                    <p>${error}</p>
                </div>
                <button class="close-notification">&times;</button>
            </div>
        </c:if>
        
        <!-- Main content starts here -->
</body>
</html> 