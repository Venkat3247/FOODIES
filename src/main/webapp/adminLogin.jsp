
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Foodies - Admin Login</title>

<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
    background: #f5f1e8;
    min-height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
}

.login-container {
    width: 380px;
    padding: 35px;
    background: white;
    border-radius: 12px;
    box-shadow: 0 5px 20px rgba(0,0,0,0.12);
}

h2 {
    text-align: center;
    color: #245c3a;
    margin-bottom: 10px;
}

.subtitle {
    text-align: center;
    color: #777;
    margin-bottom: 25px;
}

.form-group {
    margin-bottom: 18px;
}

label {
    display: block;
    margin-bottom: 8px;
    font-weight: bold;
    color: #333;
}

input {
    width: 100%;
    padding: 12px;
    border: 1px solid #ccc;
    border-radius: 6px;
    font-size: 15px;
}

button {
    width: 100%;
    padding: 13px;
    background: #245c3a;
    color: white;
    border: none;
    border-radius: 6px;
    font-size: 16px;
    cursor: pointer;
}

button:hover {
    background: #19452b;
}

.error {
    color: red;
    text-align: center;
    margin-bottom: 15px;
}

.back-link {
    text-align: center;
    margin-top: 20px;
}

.back-link a {
    color: #245c3a;
    text-decoration: none;
}
</style>
</head>

<body>

<div class="login-container">

    <h2>Foodies Admin</h2>
    <p class="subtitle">Login to your dashboard</p>

    <% if ("1".equals(request.getParameter("error"))) { %>
        <p class="error">Invalid admin email or password.</p>
    <% } %>

    <form action="${pageContext.request.contextPath}/adminLogin"
          method="post">

        <div class="form-group">
            <label for="email">Admin Email</label>
            <input type="email"
                   id="email"
                   name="email"
                   placeholder="Enter admin email"
                   autocomplete="username"
                   required>
        </div>

        <div class="form-group">
            <label for="password">Password</label>
            <input type="password"
                   id="password"
                   name="password"
                   placeholder="Enter password"
                   autocomplete="current-password"
                   required>
        </div>

        <button type="submit">Admin Login</button>

    </form>

    <div class="back-link">
        <a href="${pageContext.request.contextPath}/login.html">
            Back to Customer Login
        </a>
    </div>

</div>

</body>
</html>
