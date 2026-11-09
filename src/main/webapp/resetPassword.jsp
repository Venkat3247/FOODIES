
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    Boolean verified = (Boolean) session.getAttribute("otpVerified");

    if (!Boolean.TRUE.equals(verified)) {
        response.sendRedirect("forgotPassword.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset Password - Foodies</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/login.css">
</head>
<body class="login-body">

<div class="login-container">

    <div class="login-image-section">
        <div class="slider-bg active"
             style="background-image:url('images/41129dbf061ee8e0fcddee01dab0a782.jpg')"></div>
        <div class="image-overlay">
            <h2>Welcome to <span>Foodies</span></h2>
            <p>Good Food. Great Mood. Unforgettable.</p>
        </div>
    </div>

    <div class="login-form-section">
        <div class="login-form-wrapper">

            <div class="login-header">
                <a href="index.html" class="logo">
                    <div class="logo-badge">🍔</div>
                    Food<span>ies</span>
                </a>
                <h1>Reset Password</h1>
                <p>Create your new Foodies account password.</p>
            </div>

            <form action="reset-password" method="POST" class="login-form">

                <div class="form-group">
                    <label for="password">New Password</label>
                    <div class="input-icon-wrapper">
                        <span class="input-icon">🔒</span>
                        <input type="password" id="password"
                               name="password"
                               placeholder="Enter new password"
                               minlength="8" maxlength="72"
                               required>
                    </div>
                </div>

                <div class="form-group">
                    <label for="confirmPassword">Confirm Password</label>
                    <div class="input-icon-wrapper">
                        <span class="input-icon">🔒</span>
                        <input type="password" id="confirmPassword"
                               name="confirmPassword"
                               placeholder="Confirm new password"
                               minlength="8" maxlength="72"
                               required>
                    </div>
                </div>

                <button type="submit" class="btn-primary login-btn">
                    Update Password
                </button>

            </form>

            <div class="login-footer">
                <p><a href="login.html">← Back to Login</a></p>
            </div>

        </div>
    </div>

</div>
</body>
</html>
