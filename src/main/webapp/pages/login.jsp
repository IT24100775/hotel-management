<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <style>
        body {
            background-image: url("../images/seabreeze.png");
        }
        form {
            background: white;
            border-radius: 10px;
            margin-right: 200px;
            margin-left:800px;
            margin-top: 200px;
            padding-left:50px ;
        }
        h2{
            font-family: 'Arial', sans-serif;
            font-size: x-large;
            color: white;
            text-align: right;
            margin-right: 500px;
            margin-left: 500px;
        }
    </style>
</head>
<body>
<h2>Login</h2>
<form action="../login-servlet" method="post"><br>
    Username: <input type="text" name="username" required /><br/><br/>
    Password: <input type="password" name="password" required /><br/><br/>
    <input type="submit" value="Login"/><br/><br/>
</form>
</body>
</html>