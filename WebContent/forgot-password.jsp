<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Forgot Password - Ocean View Resort</title>

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

body{
    height:100vh;
    display:flex;
    justify-content:center;
    align-items:center;
    background:#f4f6f9;
}

.back-home{
    position:absolute;
    top:30px;
    left:40px;
    text-decoration:none;
    color:#000000;
    font-size:16px;
    font-weight: bold;
}

.login-container{
    width:850px;
    height:450px;
    display:flex;
    background:#fff;
    border-radius:15px;
    overflow:hidden;
    box-shadow:0 10px 25px rgba(0,0,0,0.1);
}

.login-info{
    flex:1;
    background: linear-gradient(135deg, #0093E9, #00C9A7);
    color:#fff;
    display:flex;
    flex-direction:column;
    justify-content:center;
    align-items:center;
    padding:40px;
    text-align:center;
}

.login-info h2{
    font-size:28px;
    margin-bottom:20px;
}

.login-info p{
    font-size:15px;
    line-height:1.6;
    opacity:0.9;
}

.login-form{
    flex:1;
    display:flex;
    flex-direction:column;
    justify-content:center;
    align-items:center;
    padding:40px;
}

.login-form h2{
    margin-bottom:25px;
    color:#333;
}

.login-form form{
    width:100%;
    max-width:320px;
    display:flex;
    flex-direction:column;
}

.login-form input[type="text"]{
    padding:12px;
    margin-bottom:15px;
    border:1px solid #ddd;
    border-radius:6px;
    font-size:14px;
}

.login-form button{
    padding:12px;
    background:#00AEEF;
    color:#fff;
    border:none;
    border-radius:6px;
    font-size:15px;
    cursor:pointer;
    transition:0.3s;
}

.login-form button:hover{
    background:#0077c8;
}

.message{
    margin-top:15px;
    font-size:14px;
    color:red;
    text-align:center;
}

.login-form a{
    margin-top:15px;
    text-decoration:none;
    color:#0093E9;
    font-size:14px;
}

.login-form a:hover{
    text-decoration:underline;
}

</style>
</head>

<body>

<a href="login.jsp" class="back-home"> Back to Login</a>

<div class="login-container">

    <div class="login-info">
        <h2>Ocean View Resort</h2>
        <p>
            Forgot your password? <br>
            Enter your username and we will retrieve your account details.
        </p>
    </div>

    <div class="login-form">
        <h2>Password Assistance</h2>

        <form action="ForgotPasswordServlet" method="post">
            <input type="text" name="username" placeholder="Enter your Username" required>
            <button type="submit">Request Password Reset</button>
        </form>

        <div class="message">
            ${message}
        </div>

        <a href="login.jsp">Back to Login</a>
    </div>

</div>

</body>
</html>