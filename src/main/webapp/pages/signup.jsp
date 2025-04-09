<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Signup</title>
</head>
<body>
<h2>Signup</h2>
<form action="signup-servlet" method="post">
    Full Name: <input type="text" name="fullname" required /><br/><br/>
    Username: <input type="text" name="username" required /><br/><br/>
    Password: <input type="password" name="password" required /><br/><br/>
    <input type="submit" value="Signup"/>
</form>
</body>
</html>
