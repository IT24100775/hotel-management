<%@ page session="true" %>
<%
    String username = (String) session.getAttribute("username");
%>
<div class="navbar" style="overflow: visible">
    <div class="nav-left">
        <img src="<%= request.getContextPath() %>/images/hotellogo.png" height="110px" width="140px">
    </div>
    <div class="nav-center">
        <a href="<%= request.getContextPath() %>/index.jsp">Home</a>
        <a href="<%= request.getContextPath() %>/index.jsp#AboutUs">About Us</a>
        <a href="#">Rooms</a>
        <%
            if (username != null && !username.isEmpty()) {
        %>
        <a href="#">Book Now</a>
        <%
        } else {
        %>
        <a href="../login.jsp" onclick="alert('Please log in or sign up to book.'); return false;">Book Now</a>
        <%
            }
        %>
        <a href="#">Reviews</a>
    </div>

    <div class="nav-right">
        <%
            if (username != null && !username.isEmpty()) {
        %>
        <div class="dropdown">
            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false" style="color: white; text-decoration: none;">
                <img src="<%= request.getContextPath() %>/images/human.png" alt="default User" style="width:40px; height:40px; border-radius:50%;" />
                Hello, <%= username %>
            </a>
            <ul class="dropdown-menu">
                <li><a class="dropdown-item" style="color: #000000" href="<%= request.getContextPath() %>/pages/viewprofile.jsp">View Profile</a></li>
                <li><a class="dropdown-item" style="color: #000000" href="<%= request.getContextPath() %>/pages/updateprofile.jsp">Update Profile</a></li>
                <li><a class="dropdown-item" style="color: #000000" href="<%= request.getContextPath() %>/logout-servlet">Logout</a></li>
            </ul>
        </div>
        <%
        } else {
        %>
        <div style="color: white; text-align: center; padding: 10px;">
            <a href="<%= request.getContextPath() %>/pages/login.jsp" style="color: white; text-decoration: none;">Login</a>
            <a href="<%= request.getContextPath() %>/pages/signup.jsp" style="color: white; text-decoration: none;">Sign up</a>
        </div>
        <%
            }
        %>
    </div>
</div>
