
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password - Foodies</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/login.css">
</head>
<body class="login-body">

<div class="login-container">

    <div class="login-image-section">
        <div class="slider-bg active"
             style="background-image:url('images/0fa50d999107a706471179939d00c788.jpg')"></div>
        <div class="image-overlay">
            <h2>Welcome to <span>Foodies</span></h2>
            <p>The adventure you crave, the flavor you miss.</p>
        </div>
    </div>

    <div class="login-form-section">
        <div class="login-form-wrapper">

            <div class="login-header">
                <a href="index.html" class="logo">
                    <div class="logo-badge">🍔</div>
                    Food<span>ies</span>
                </a>
                <h1>Forgot Password?</h1>
                <p>Enter your registered email to receive an OTP.</p>
            </div>

            <form action="forgot-password" method="POST" class="login-form">

                <div class="form-group">
                    <label for="email">Email</label>
                    <div class="input-icon-wrapper">
                        <span class="input-icon">✉️</span>
                        <input type="email" id="email" name="email"
                               placeholder="Enter your registered email"
                               required>
                    </div>
                </div>

                <button type="submit" class="btn-primary login-btn">
                    Send OTP
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
