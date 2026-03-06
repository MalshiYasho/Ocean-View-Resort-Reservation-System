<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login - Ocean View Resort</title>

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
    color:#0f0f0f;
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

.login-form input[type="text"],
.login-form input[type="password"]{
    padding:12px;
    margin-bottom:15px;
    border:1px solid #ddd;
    border-radius:6px;
    font-size:14px;
}

.options{
    display:flex;
    justify-content:space-between;
    align-items:center;
    font-size:13px;
    margin-bottom:20px;
}

.options a{
    text-decoration:none;
    color:#0093E9;
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

</style>
</head>

<body>

<a href="index.html" class="back-home"> Back to Home</a>

<div class="login-container">

    <div class="login-info">
        <h2>Ocean View Resort</h2>
        <p>
            Welcome to the management portal. <br>
            Please log in to access the reservation and management system.
        </p>
    </div>

    <div class="login-form">
        <h2>Login</h2>

        <% if (request.getAttribute("errorMessage") != null) { %>
            <div style="color: red; text-align: center; margin-bottom: 15px; font-size: 14px; font-weight: bold;">
                <%= request.getAttribute("errorMessage") %>
            </div>
        <% } %>

        <form action="LoginServlet" method="post">

            <input type="text" id="username" name="username" placeholder="Username" required>

            <input type="password" id="password" name="password" placeholder="Password" required>

            <div class="options">
                <label>
                    <input type="checkbox" name="remember"> Remember me
                </label>
                <a href="forgot-password.jsp">Forgot password?</a>
            </div>

            <button type="submit">Login</button>

        </form>
    </div>

</div>

</body>

<script>
window.onload = function() {
    const cookies = document.cookie.split(';');
    let username = '', password = '';
    cookies.forEach(cookie => {
        const [key, value] = cookie.trim().split('=');
        if (key === 'username') username = value;
        if (key === 'password') password = value;
    });
    if (username) document.getElementById('username').value = decodeURIComponent(username);
    if (password) document.getElementById('password').value = decodeURIComponent(password);
}
</script>

</html>