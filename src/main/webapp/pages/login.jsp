<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Login</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/admin.css">
</head>
<body class="login-page">
    <div class="login-container">
        <div class="login-card">
            <div class="login-header">
                <h1>Hotel Reservation System</h1>
                <h2>Admin Login</h2>
            </div>
            
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
            
            <form action="${pageContext.request.contextPath}/login" method="post" class="login-form">
                <div class="form-group">
                    <label for="username">Username</label>
                    <div class="input-with-icon">
                        <i class="icon-user"></i>
                        <input type="text" id="username" name="username" required 
                               placeholder="Enter your username">
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="password">Password</label>
                    <div class="input-with-icon">
                        <i class="icon-password"></i>
                        <input type="password" id="password" name="password" required
                               placeholder="Enter your password">
                        <button type="button" class="toggle-password" onclick="togglePasswordVisibility()">
                            <i class="icon-eye"></i>
                        </button>
                    </div>
                </div>
                
                <div class="form-actions login-actions">
                    <button type="submit" class="btn-primary login-btn">
                        <i class="icon-login"></i> Login
                    </button>
                </div>
            </form>
        </div>
    </div>
    
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
</body>
</html> 