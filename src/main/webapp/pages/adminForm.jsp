<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    if (session.getAttribute("admin") == null) {
        response.sendRedirect(request.getContextPath() + "/");
        return;
    }
%>

<jsp:include page="../includes/header.jsp">
    <jsp:param name="pageTitle" value="${empty admin ? 'Register New' : 'Edit'} Admin" />
    <jsp:param name="pageSubtitle" value="${empty admin ? 'Create a new administrator account' : 'Modify existing administrator account'}" />
</jsp:include>

<!-- Main Content Area -->
<main class="content">
    <!-- Page Header Actions -->
    <div class="header-actions">
        <a href="${pageContext.request.contextPath}/admin/" class="btn-secondary">
            <i class="icon-back"></i> Back to Admin List
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
    
    <!-- Admin Form Card Component -->
    <section class="form-section">
        <div class="card">
            <div class="card-header">
                <h2>Admin Information</h2>
                <p>All fields marked with * are required</p>
            </div>
            
            <div class="card-body">
                <form action="${pageContext.request.contextPath}/admin/" method="post" class="admin-form">
                    <input type="hidden" name="action" value="${empty admin ? 'create' : 'update'}">
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="username">Username <span class="required">*</span></label>
                            <div class="input-with-icon">
                                <i class="icon-user"></i>
                                <input type="text" id="username" name="username" value="${admin.username}" 
                                       ${not empty admin ? 'readonly' : ''} required
                                       placeholder="Enter administrator username">
                            </div>
                            <small class="form-text">Username must be unique and cannot be changed later</small>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="password">Password ${empty admin ? '<span class="required">*</span>' : ''}</label>
                            <div class="input-with-icon">
                                <i class="icon-password"></i>
                                <input type="password" id="password" name="password" 
                                       ${empty admin ? 'required' : ''} 
                                       placeholder="${not empty admin ? 'Leave blank to keep current password' : 'Enter secure password'}">
                                <button type="button" class="toggle-password" onclick="togglePasswordVisibility()">
                                    <i class="icon-eye"></i>
                                </button>
                            </div>
                            <small class="form-text">Password should be at least 8 characters</small>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="email">Email <span class="required">*</span></label>
                            <div class="input-with-icon">
                                <i class="icon-email"></i>
                                <input type="email" id="email" name="email" value="${admin.email}" 
                                       required placeholder="Enter administrator email">
                            </div>
                            <small class="form-text">Email address for notifications</small>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="contactNumber">Contact Number</label>
                            <div class="input-with-icon">
                                <i class="icon-phone"></i>
                                <input type="tel" id="contactNumber" name="contactNumber" value="${admin.contactNumber}" 
                                       placeholder="Enter contact number">
                            </div>
                            <small class="form-text">Phone number for emergency contact</small>
                        </div>
                    </div>
                    
                    <div class="form-actions">
                        <button type="submit" class="btn-primary">
                            <i class="icon-save"></i> ${empty admin ? 'Create Admin' : 'Save Changes'}
                        </button>
                        <a href="${pageContext.request.contextPath}/admin/" class="btn-secondary">Cancel</a>
                    </div>
                </form>
            </div>
        </div>
    </section>
</main>

<!-- JavaScript for the form -->
<script>
    function togglePasswordVisibility() {
        const passwordInput = document.getElementById('password');
        const icon = document.querySelector('.toggle-password i');
        
        if (passwordInput.type === 'password') {
            passwordInput.type = 'text';
            icon.className = 'icon-eye-slash';
        } else {
            passwordInput.type = 'password';
            icon.className = 'icon-eye';
        }
    }
    
    document.addEventListener('DOMContentLoaded', function() {
        // Close notification when close button is clicked
        document.querySelectorAll('.close-notification').forEach(button => {
            button.addEventListener('click', function() {
                this.parentElement.style.display = 'none';
            });
        });
    });
</script>

<jsp:include page="../includes/footer.jsp" /> 