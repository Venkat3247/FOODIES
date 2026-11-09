
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Verify OTP - Foodies</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/login.css">
</head>
<body class="login-body">

<div class="login-container">

    <div class="login-image-section">
        <div class="slider-bg active"
             style="background-image:url('images/19b1d1de8401c5288a7e61ced33cb99.jpg')"></div>
        <div class="image-overlay">
            <h2>Welcome to <span>Foodies</span></h2>
            <p>Your favorite food is just one step away.</p>
        </div>
    </div>

    <div class="login-form-section">
        <div class="login-form-wrapper">

            <div class="login-header">
                <a href="index.html" class="logo">
                    <div class="logo-badge">🍔</div>
                    Food<span>ies</span>
                </a>
                <h1>Verify OTP</h1>
                <p>Enter the 6-digit OTP sent to your email.</p>
            </div>

            <form action="verify-otp" method="POST" class="login-form">

                <div class="form-group">
                    <label for="otp">Enter OTP</label>
                    <div class="input-icon-wrapper">
                        <span class="input-icon">🔐</span>
                        <input type="text" id="otp" name="otp"
                               placeholder="Enter 6-digit OTP"
                               maxlength="6"
                               pattern="[0-9]{6}"
                               inputmode="numeric"
                               autocomplete="one-time-code"
                               required>
                    </div>
                </div>

                <button type="submit" class="btn-primary login-btn">
                    Verify OTP
                </button>

            </form>

            <div class="login-footer">
                <p><a href="forgotPassword.jsp">Request a new OTP</a></p>
                <p><a href="login.html">← Back to Login</a></p>
            </div>

        </div>
    </div>

</div>
</body>
</html>
