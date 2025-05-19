<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="includes/header.jsp">
    <jsp:param name="pageTitle" value="Admin Dashboard" />
    <jsp:param name="pageSubtitle" value="Manage your hotel reservations" />
    <jsp:param name="hideSidebar" value="true" />
</jsp:include>

<!-- Welcome Section -->
<div class="welcome-section">
    <div class="welcome-card">
        <div class="welcome-icon">
            <i class="icon-admin"></i>
        </div>
        <div class="welcome-content">
            <h2>Welcome, ${sessionScope.admin.username}!</h2>
            <p>Last login: ${sessionScope.admin.lastLoggedIn}</p>
        </div>
    </div>
</div>

<!-- Stats Overview -->
<div class="stats-overview">
    <h3>System Overview</h3>
    <div class="stats-container">
        <div class="stat-card">
            <div class="stat-icon rooms-icon">
                <i class="icon-room"></i>
            </div>
            <div class="stat-info">
                <h3>Total Rooms</h3>
                <p class="stat-number">${stats.roomsCount}</p>
            </div>
        </div>
        
        <div class="stat-card">
            <div class="stat-icon users-icon">
                <i class="icon-user"></i>
            </div>
            <div class="stat-info">
                <h3>Registered Users</h3>
                <p class="stat-number">${stats.usersCount}</p>
            </div>
        </div>
        
        <div class="stat-card">
            <div class="stat-icon bookings-icon">
                <i class="icon-booking"></i>
            </div>
            <div class="stat-info">
                <h3>Active Bookings</h3>
                <p class="stat-number">${stats.bookingsCount}</p>
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-icon admins-icon">
                <i class="icon-admin"></i>
            </div>
            <div class="stat-info">
                <h3>Admin Accounts</h3>
                <p class="stat-number">${stats.adminsCount}</p>
            </div>
        </div>
    </div>
</div>

<!-- Admin Functions Tiles -->
<div class="admin-functions">
    <h3>Admin Functions</h3>
    <div class="admin-tiles">
        <a href="${pageContext.request.contextPath}/admin/" class="admin-tile">
            <div class="tile-icon">
                <i class="icon-admin"></i>
            </div>
            <div class="tile-info">
                <h3>Admin Management</h3>
                <p>Manage administrator accounts</p>
            </div>
        </a>
        
        <a href="${pageContext.request.contextPath}/pages/userManagement.jsp" class="admin-tile">
            <div class="tile-icon">
                <i class="icon-user"></i>
            </div>
            <div class="tile-info">
                <h3>User Management</h3>
                <p>Manage user accounts</p>
            </div>
        </a>
        
        <a href="${pageContext.request.contextPath}/pages/roomManagement.jsp" class="admin-tile">
            <div class="tile-icon">
                <i class="icon-room"></i>
            </div>
            <div class="tile-info">
                <h3>Room Management</h3>
                <p>Manage hotel rooms</p>
            </div>
        </a>
        
        <a href="${pageContext.request.contextPath}/pages/bookingManagement.jsp" class="admin-tile">
            <div class="tile-icon">
                <i class="icon-booking"></i>
            </div>
            <div class="tile-info">
                <h3>Bookings</h3>
                <p>Manage reservations</p>
            </div>
        </a>
    </div>
</div>

<!-- System Management Tiles -->
<div class="system-functions">
    <h3>System Management</h3>
    <div class="admin-tiles">
        <a href="${pageContext.request.contextPath}/admin/logs" class="admin-tile">
            <div class="tile-icon">
                <i class="icon-logs"></i>
            </div>
            <div class="tile-info">
                <h3>Admin Logs</h3>
                <p>View system activity logs</p>
            </div>
        </a>
        
        <a href="${pageContext.request.contextPath}/pages/paymentsManagement.jsp" class="admin-tile">
            <div class="tile-icon">
                <i class="icon-payment"></i>
            </div>
            <div class="tile-info">
                <h3>Payments</h3>
                <p>Manage payment transactions</p>
            </div>
        </a>
        
        <a href="${pageContext.request.contextPath}/pages/reviewManagement.jsp" class="admin-tile">
            <div class="tile-icon">
                <i class="icon-review"></i>
            </div>
            <div class="tile-info">
                <h3>Reviews</h3>
                <p>Manage guest reviews</p>
            </div>
        </a>
        
        <a href="${pageContext.request.contextPath}/logout" class="admin-tile">
            <div class="tile-icon">
                <i class="icon-logout"></i>
            </div>
            <div class="tile-info">
                <h3>Logout</h3>
                <p>End your session</p>
            </div>
        </a>
    </div>
</div>

<!-- Recent Activity -->
<div class="recent-activity">
    <h3>Recent Activity</h3>
    <div class="activity-list">
        <c:choose>
            <c:when test="${not empty recentLogs}">
                <c:forEach var="log" items="${recentLogs}" end="4">
                    <div class="activity-item">
                        <div class="activity-time">
                            ${log.split(",")[0]}
                        </div>
                        <div class="activity-details">
                            <strong>${log.split(",")[1]}</strong> ${log.split(",")[2]}
                        </div>
                    </div>
                </c:forEach>
                <a href="${pageContext.request.contextPath}/admin/logs" class="view-all-link">View all activity</a>
            </c:when>
            <c:otherwise>
                <div class="no-activity">
                    <p>No recent activity to display</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<!-- Add CSS for the new tile design -->
<style>
    .content.full-width {
        margin-left: 0;
        padding: 30px;
    }
    
    .welcome-section {
        margin-bottom: 30px;
    }
    
    .welcome-card {
        background-color: #fff;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        display: flex;
        align-items: center;
        padding: 20px;
    }
    
    .welcome-icon {
        width: 60px;
        height: 60px;
        border-radius: 50%;
        background-color: #f0f7ff;
        color: #3b82f6;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.5rem;
        margin-right: 20px;
    }
    
    .welcome-content h2 {
        margin: 0 0 5px 0;
        color: #1e293b;
    }
    
    .welcome-content p {
        margin: 0;
        color: #64748b;
    }
    
    .admin-functions,
    .system-functions {
        margin-bottom: 30px;
    }
    
    .admin-functions h3,
    .system-functions h3 {
        margin-bottom: 15px;
        color: #1e293b;
    }
    
    .admin-tiles {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
        gap: 20px;
    }
    
    .admin-tile {
        background-color: #fff;
        border-radius: 8px;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
        padding: 20px;
        display: flex;
        align-items: center;
        text-decoration: none;
        color: inherit;
        transition: transform 0.3s ease, box-shadow 0.3s ease;
    }
    
    .admin-tile:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
    }
    
    .tile-icon {
        width: 50px;
        height: 50px;
        border-radius: 10px;
        display: flex;
        align-items: center;
        justify-content: center;
        margin-right: 15px;
        font-size: 1.3rem;
    }
    
    .admin-tile:nth-child(1) .tile-icon {
        background-color: #f5f0ff;
        color: #8b5cf6;
    }
    
    .admin-tile:nth-child(2) .tile-icon {
        background-color: #f0f7ff;
        color: #3b82f6;
    }
    
    .admin-tile:nth-child(3) .tile-icon {
        background-color: #f0fdf4;
        color: #10b981;
    }
    
    .admin-tile:nth-child(4) .tile-icon {
        background-color: #fff7ed;
        color: #f59e0b;
    }
    
    .system-functions .admin-tile:nth-child(1) .tile-icon {
        background-color: #fef2f2;
        color: #ef4444;
    }
    
    .system-functions .admin-tile:nth-child(2) .tile-icon {
        background-color: #ecfdf5;
        color: #059669;
    }
    
    .system-functions .admin-tile:nth-child(3) .tile-icon {
        background-color: #f3f4f6;
        color: #4b5563;
    }
    
    .tile-info h3 {
        margin: 0 0 5px 0;
        font-size: 1.1rem;
        color: #1e293b;
    }
    
    .tile-info p {
        margin: 0;
        font-size: 0.9rem;
        color: #64748b;
    }
</style>

<jsp:include page="includes/footer.jsp" />

