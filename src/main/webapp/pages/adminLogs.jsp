<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    if (session.getAttribute("admin") == null) {
        response.sendRedirect(request.getContextPath() + "/");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Activity Logs</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
</head>
<body>
    <!-- Left Sidebar Navigation Component -->
    <nav class="sidebar">
        <div class="sidebar-header">
            <h3>HRS Admin</h3>
        </div>
        <ul>
            <li><a href="${pageContext.request.contextPath}/dashboard">Dashboard</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/">Admin Management</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/new">Register Admin</a></li>
            <li class="active"><a href="${pageContext.request.contextPath}/admin/logs">Admin Logs</a></li>
            <li class="submenu-header">Hotel Management</li>
            <li><a href="${pageContext.request.contextPath}/roomManagement.jsp">Manage Rooms</a></li>
            <li><a href="${pageContext.request.contextPath}/userManagement.jsp">Manage Users</a></li>
            <li><a href="${pageContext.request.contextPath}/bookingManagement.jsp">Manage Bookings</a></li>
            <li><a href="${pageContext.request.contextPath}/paymentsManagement.jsp">Manage Payments</a></li>
            <li><a href="${pageContext.request.contextPath}/reviewManagement.jsp">Manage Reviews</a></li>
        </ul>
    </nav>

    <!-- Main Content Area -->
    <main class="content">
        <!-- Page Header Component -->
        <header class="page-header">
            <div class="header-content">
                <h1>Admin Activity Logs</h1>
                <p>View and monitor all administrative actions in the system</p>
            </div>
            <div class="header-actions">
                <button class="btn-secondary" id="exportLogBtn">
                    <i class="icon-export"></i> Export Logs
                </button>
            </div>
        </header>
        
        <!-- Search and Filter Component -->
        <section class="filter-section">
            <div class="search-box">
                <input type="text" id="logSearch" placeholder="Search logs..." onkeyup="filterLogs()">
                <i class="icon-search"></i>
            </div>
            <div class="filter-options">
                <label>Filter by admin:</label>
                <select id="adminFilter" onchange="filterLogs()">
                    <option value="">All Admins</option>
                    <c:forEach var="log" items="${logs}">
                        <c:set var="logParts" value="${log.split(',')}" />
                        <c:set var="adminName" value="${logParts[1]}" />
                        <c:if test="${!adminNames.contains(adminName)}">
                            <c:set var="adminNames" value="${adminNames},${adminName}" scope="page" />
                            <option value="${adminName}">${adminName}</option>
                        </c:if>
                    </c:forEach>
                </select>
                
                <label>Date range:</label>
                <input type="date" id="startDate" onchange="filterLogs()">
                <span>to</span>
                <input type="date" id="endDate" onchange="filterLogs()">
            </div>
        </section>
        
        <!-- Logs List Component -->
        <section class="logs-section">
            <div class="logs-list">
                <table id="logsTable">
                    <thead>
                        <tr>
                            <th>Timestamp</th>
                            <th>Admin</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="log" items="${logs}">
                            <c:set var="logParts" value="${log.split(',')}" />
                            <tr data-admin="${logParts[1]}" data-date="${logParts[0].substring(0, 10)}">
                                <td class="timestamp">
                                    <div class="timestamp-full">${logParts[0]}</div>
                                    <div class="timestamp-relative">
                                        <!-- This would be calculated in real app -->
                                        <script>
                                            document.write(getRelativeTime("${logParts[0]}"));
                                        </script>
                                    </div>
                                </td>
                                <td class="admin-col">
                                    <div class="admin-info">
                                        <div class="admin-avatar">${logParts[1].substring(0,1).toUpperCase()}</div>
                                        <div class="admin-name">${logParts[1]}</div>
                                    </div>
                                </td>
                                <td class="action-col">
                                    <div class="action-type">
                                        <c:choose>
                                            <c:when test="${logParts[2].contains('Created')}">
                                                <span class="action-badge create">Create</span>
                                            </c:when>
                                            <c:when test="${logParts[2].contains('Updated')}">
                                                <span class="action-badge update">Update</span>
                                            </c:when>
                                            <c:when test="${logParts[2].contains('Deleted')}">
                                                <span class="action-badge delete">Delete</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="action-badge other">Other</span>
                                            </c:otherwise>
                                        </c:choose>
                                        ${logParts[2]}
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty logs}">
                            <tr>
                                <td colspan="3" class="no-data">
                                    <div class="empty-state">
                                        <div class="empty-icon">
                                            <i class="icon-logs"></i>
                                        </div>
                                        <h3>No activity logs found</h3>
                                        <p>Admin activities will be recorded here when performed</p>
                                    </div>
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </section>
    </main>
    
    <!-- Footer Component -->
    <footer class="dashboard-footer">
        <p>&copy; 2023 Hotel Reservation System - Admin Module</p>
    </footer>
    
    <!-- JavaScript for the logs page -->
    <script>
        function getRelativeTime(timestamp) {
            // This is a simplified version - in a real app, you'd use a more robust solution
            const now = new Date();
            const logDate = new Date(timestamp);
            const diffMs = now - logDate;
            const diffMins = Math.floor(diffMs / 60000);
            
            if (diffMins < 1) return 'Just now';
            if (diffMins < 60) return diffMins + ' mins ago';
            
            const diffHours = Math.floor(diffMins / 60);
            if (diffHours < 24) return diffHours + ' hours ago';
            
            const diffDays = Math.floor(diffHours / 24);
            if (diffDays < 30) return diffDays + ' days ago';
            
            return timestamp.substring(0, 10); // Just return the date part
        }
        
        function filterLogs() {
            const searchInput = document.getElementById('logSearch').value.toLowerCase();
            const adminFilter = document.getElementById('adminFilter').value;
            const startDate = document.getElementById('startDate').value;
            const endDate = document.getElementById('endDate').value;
            
            const rows = document.querySelectorAll('#logsTable tbody tr:not(.no-data)');
            
            rows.forEach(row => {
                const adminName = row.getAttribute('data-admin');
                const logDate = row.getAttribute('data-date');
                const logText = row.textContent.toLowerCase();
                
                // Check all filter conditions
                const matchesSearch = logText.includes(searchInput);
                const matchesAdmin = adminFilter === '' || adminName === adminFilter;
                
                let matchesDate = true;
                if (startDate && logDate < startDate) matchesDate = false;
                if (endDate && logDate > endDate) matchesDate = false;
                
                row.style.display = (matchesSearch && matchesAdmin && matchesDate) ? '' : 'none';
            });
            
            // Show empty state if no results
            const visibleRows = document.querySelectorAll('#logsTable tbody tr:not([style*="display: none"])').length;
            const noResultsRow = document.querySelector('.no-results-row');
            
            if (visibleRows === 0 && rows.length > 0) {
                if (!noResultsRow) {
                    const tbody = document.querySelector('#logsTable tbody');
                    const newRow = document.createElement('tr');
                    newRow.className = 'no-results-row';
                    newRow.innerHTML = `
                        <td colspan="3" class="no-data">
                            <div class="empty-state">
                                <h3>No matching logs found</h3>
                                <p>Try adjusting your search or filter criteria</p>
                            </div>
                        </td>
                    `;
                    tbody.appendChild(newRow);
                }
            } else if (noResultsRow) {
                noResultsRow.remove();
            }
        }
        
        document.getElementById('exportLogBtn').addEventListener('click', function() {
            alert('Export functionality would be implemented here');
        });
    </script>
</body>
</html> 