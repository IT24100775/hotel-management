<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<script>
    // Close notification buttons
    document.querySelectorAll('.close-notification').forEach(button => {
        button.addEventListener('click', function() {
            this.closest('.notification').style.display = 'none';
        });
    });
</script>
</body>
</html>

<style>
  .main-footer {
    background: #167bbf;
    color: white;
    padding: 30px 0 10px 0;
    text-align: center;
    font-size: 1.1em;
    margin-top: 40px;
  }
  .main-footer a {
    color: white;
    text-decoration: underline;
  }
  .main-footer a:hover {
    color: #ffeb3b;
  }
</style>
<footer class="main-footer">
  <p><b>Explore</b><br>
      <a href="<%= request.getContextPath() %>/index.jsp">Home</a> | 
      <a href="<%= request.getContextPath() %>/index.jsp">About Us</a> | 
      <a href="#">Rooms</a> | 
      <a href="<%= request.getContextPath() %>/index.jsp">Login</a> | 
      <a href="<%= request.getContextPath() %>/pages/signup.jsp">Sign Up</a>
  <br><br><b>Get in Touch</b><br>
   Hotel Contact Information<br>
      <a href="mailto:info@seabreeze.com">info@seabreeze.com</a><br>
   +94 113 393 830<br><br>
      <b>Follow Us</b><br>
    <img src="<%= request.getContextPath() %>/images/socialmedia.png" height="50" width="200" align="center"><br><br>
   ©2025 The Seabreeze Hotel, Inc. All rights reserved</p>
</footer> 