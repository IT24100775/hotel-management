<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Signup</title>
    <link rel="stylesheet" href="../CSS/signup.css">
</head>
<body style="background-image: url('../images/bglogin.jpg');">

<form action="../signup-servlet" method="post">
    <img src="../images/logoblue.png" alt="logo" style="display: block; margin-right: 200px; margin-left: 75px;" width=150px height="auto"><br>
    <h2>Sign Up</h2>
    <input type="text" name="fullname" placeholder="Full Name" required/><br/><br/>
    <input type="text" name="username" placeholder="Username" required /><br/><br/>
   <input type="password" name="password" placeholder="Password" required /><br/><br/>
    <input type="submit" value="Sign up"/>
</form>
</body>
</html>
