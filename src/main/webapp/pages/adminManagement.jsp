<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    if (session.getAttribute("admin") == null) {
        response.sendRedirect(request.getContextPath() + "/");
        return;
    }
%>

<jsp:include page="../includes/header.jsp">
    <jsp:param name="pageTitle" value="Admin Management" />
    <jsp:param name="pageSubtitle" value="Manage administrator accounts and their privileges" />
</jsp:include>

<!-- Main Content Area -->
<main class="content">
    <!-- Page Header Actions -->
    <div class="header-actions">
        <a href="${pageContext.request.contextPath}/admin/new" class="btn-primary">
            <i class="icon-plus"></i> Register New Admin
        </a>
    </div>
    
    <!-- Notification Component -->
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
    
    <!-- Search and Filter Component -->
    <section class="filter-section">
        <div class="search-box">
            <input type="text" id="adminSearch" placeholder="Search admins..." onkeyup="filterAdmins()">
            <i class="icon-search"></i>
        </div>
    </section>
    
    <!-- Admin List Component -->
    <section class="admin-list-section">
        <div class="admin-list">
            <table id="adminTable">
                <thead>
                    <tr>
                        <th>Username</th>
                        <th>Last Logged In</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="admin" items="${admins}">
                        <tr>
                            <td>
                                <div class="admin-info">
                                    <div class="admin-avatar">${admin.username.substring(0,1).toUpperCase()}</div>
                                    <div class="admin-details">
                                        <div class="admin-name">${admin.username}</div>
                                        <div class="admin-since">Admin since ${admin.lastLoggedIn.toLocalDate()}</div>
                                    </div>
                                </div>
                            </td>
                            <td>${admin.lastLoggedIn}</td>
                            <td class="actions">
                                <a href="${pageContext.request.contextPath}/admin/edit/${admin.username}" class="btn-edit" title="Edit admin">
                                    <i class="icon-edit"></i> Edit
                                </a>
                                <form action="${pageContext.request.contextPath}/admin/" method="post" class="inline">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="username" value="${admin.username}">
                                    <button type="submit" class="btn-delete" onclick="return confirm('Are you sure you want to delete this admin?')" title="Delete admin">
                                        <i class="icon-delete"></i> Delete
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty admins}">
                        <tr>
                            <td colspan="4" class="no-data">
                                <div class="empty-state">
                                    <div class="empty-icon">
                                        <i class="icon-admin"></i>
                                    </div>
                                    <h3>No admin accounts found</h3>
                                    <p>Create your first admin account to get started</p>
                                    <a href="${pageContext.request.contextPath}/admin/new" class="btn-primary">Register Admin</a>
                                </div>
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </section>
</main>

<!-- JavaScript for filtering admins -->
<script>
    function filterAdmins() {
        const searchInput = document.getElementById('adminSearch').value.toLowerCase();
        const rows = document.querySelectorAll('#adminTable tbody tr:not(.no-data)');
        
        rows.forEach(row => {
            const username = row.querySelector('.admin-name').innerText.toLowerCase();
            const matchesSearch = username.includes(searchInput);
            
            row.style.display = matchesSearch ? '' : 'none';
        });
        
        // Show empty state if no results
        const visibleRows = document.querySelectorAll('#adminTable tbody tr:not([style*="display: none"])').length;
        const noResultsRow = document.querySelector('.no-results-row');
        
        if (visibleRows === 0 && rows.length > 0) {
            if (!noResultsRow) {
                const tbody = document.querySelector('#adminTable tbody');
                const newRow = document.createElement('tr');
                newRow.className = 'no-results-row';
                newRow.innerHTML = `
                    <td colspan="4" class="no-data">
                        <div class="empty-state">
                            <h3>No matching results</h3>
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
</script>

<jsp:include page="../includes/footer.jsp" /> 