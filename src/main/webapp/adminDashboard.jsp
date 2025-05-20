<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    if (session.getAttribute("admin") == null) {
        response.sendRedirect(request.getContextPath() + "/");
        return;
    }
%>

<body style="background: url('<%= request.getContextPath() %>/images/seabreezeadmin.png') no-repeat center center fixed; background-size: cover; min-height: 100vh;">
<jsp:include page="includes/header.jsp" />

<div class="dashboard-title">
    <h1>Admin Dashboard</h1>
</div>

<div class="dashboard-tiles">
    <a href="${pageContext.request.contextPath}/pages/adminManagement.jsp" class="dashboard-tile">
        <div class="tile-icon"><i class="icon-admin"></i></div>
        <div class="tile-info">
            <h3>Admin Management</h3>
            <p>Manage administrator accounts</p>
        </div>
    </a>
    <a href="${pageContext.request.contextPath}/pages/userManagement.jsp" class="dashboard-tile">
        <div class="tile-icon"><i class="icon-user"></i></div>
        <div class="tile-info">
            <h3>User Management</h3>
            <p>Manage user accounts</p>
        </div>
    </a>
    <a href="${pageContext.request.contextPath}/pages/roomManagement.jsp" class="dashboard-tile">
        <div class="tile-icon"><i class="icon-room"></i></div>
        <div class="tile-info">
            <h3>Room Management</h3>
            <p>Manage hotel rooms</p>
        </div>
    </a>
    <a href="${pageContext.request.contextPath}/pages/bookingManagement.jsp" class="dashboard-tile">
        <div class="tile-icon"><i class="icon-booking"></i></div>
        <div class="tile-info">
            <h3>Bookings</h3>
            <p>Manage reservations</p>
        </div>
    </a>
    <a href="${pageContext.request.contextPath}/admin/logs" class="dashboard-tile">
        <div class="tile-icon"><i class="icon-logs"></i></div>
        <div class="tile-info">
            <h3>Admin Logs</h3>
            <p>View system activity logs</p>
        </div>
    </a>
    <a href="${pageContext.request.contextPath}/pages/paymentsManagement.jsp" class="dashboard-tile">
        <div class="tile-icon"><i class="icon-payment"></i></div>
        <div class="tile-info">
            <h3>Payments</h3>
            <p>Manage payment transactions</p>
        </div>
    </a>
    <a href="${pageContext.request.contextPath}/pages/reviewManagement.jsp" class="dashboard-tile">
        <div class="tile-icon"><i class="icon-review"></i></div>
        <div class="tile-info">
            <h3>Reviews</h3>
            <p>Manage guest reviews</p>
        </div>
    </a>
    <a href="${pageContext.request.contextPath}/logout" class="dashboard-tile">
        <div class="tile-icon"><i class="icon-logout"></i></div>
        <div class="tile-info">
            <h3>Logout</h3>
            <p>End your session</p>
        </div>
    </a>
</div>

<style>
body {
    background: url('<%= request.getContextPath() %>/images/seabreezeadmin.png') no-repeat center center fixed;
    background-size: cover;
    min-height: 100vh;
}

.dashboard-title {
    text-align: center;
    margin: 40px 0;
}

.dashboard-title h1 {
    color: #167bbf;
    font-size: 2.5em;
    font-weight: bold;
    text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1);
}

.dashboard-tiles {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    gap: 32px;
    margin: 40px 0 60px 0;
}

.dashboard-tile {
    background: #fff;
    border-radius: 18px;
    box-shadow: 0 4px 24px rgba(22,123,191,0.10);
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    width: 340px;
    height: 200px;
    text-decoration: none;
    color: #167bbf;
    transition: transform 0.2s, box-shadow 0.2s;
    font-size: 1.15em;
    border: 2px solid #167bbf22;
}

.dashboard-tile:hover {
    transform: translateY(-8px) scale(1.04);
    box-shadow: 0 8px 32px rgba(22,123,191,0.18);
    background: #e6f2fb;
}

.tile-icon {
    font-size: 2.8em;
    margin-bottom: 18px;
    display: flex;
    align-items: center;
    justify-content: center;
    width: 60px;
    height: 60px;
    border-radius: 50%;
    background: #e6f2fb;
}

.tile-info h3 {
    margin: 0 0 8px 0;
    font-size: 1.25em;
    color: #167bbf;
    font-weight: bold;
}

.tile-info p {
    margin: 0;
    color: #333;
    font-size: 1em;
}

@media (max-width: 900px) {
    .dashboard-tile { width: 90vw; }
    .dashboard-tiles { gap: 18px; }
}
</style>

<jsp:include page="includes/footer.jsp" /> 