<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" href="../CSS/login.css">
</head>
<body>
<form action="../login-servlet" method="post"><br>
    <img src="../images/logoblue.png" alt="logo" style="display: block; margin-right: 200px; margin-left: 75px;" width=150px height="auto"><br>
    <h2>Login</h2>
     <input type="text" name="username" placeholder="Username" required /><br/><br/>
     <input type="password" name="password" placeholder="Password" required /><br/><br/>
     <input type="submit" value="Login"/><br/><br/>
</form>
</body>
</html>