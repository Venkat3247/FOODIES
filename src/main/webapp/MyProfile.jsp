<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>
<%@ page import="com.tap.util.DBConnection" %>

<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    if (session.getAttribute("loggedInUser") == null) {
        response.sendRedirect(request.getContextPath() + "/login.html");
        return;
    }

    com.tap.model.User loggedInUser =
        (com.tap.model.User) session.getAttribute("loggedInUser");

    int userId = loggedInUser.getUserid();

    String name = "";
    String email = "";
    String phone = "";
    String address = "";
    String message = "";
    String messageType = "";

    // Update profile
    if ("POST".equalsIgnoreCase(request.getMethod())) {

        String newName = request.getParameter("name");
        String newEmail = request.getParameter("email");
        String newPhone = request.getParameter("phone");
        String newAddress = request.getParameter("address");

        if (newName == null || newEmail == null ||
            newPhone == null || newAddress == null ||
            newName.trim().isEmpty() ||
            newEmail.trim().isEmpty()) {

            message = "Name and email are required.";
            messageType = "error";

        } else {

            String updateSQL =
                "UPDATE `user` SET name=?, email=?, phone=?, address=? WHERE userid=?";

            try (Connection con = DBConnection.getConnection();
                 PreparedStatement ps = con.prepareStatement(updateSQL)) {

                ps.setString(1, newName.trim());
                ps.setString(2, newEmail.trim());
                ps.setString(3, newPhone.trim());
                ps.setString(4, newAddress.trim());
                ps.setInt(5, userId);

                int result = ps.executeUpdate();

                if (result > 0) {

                    message = "Profile updated successfully!";
                    messageType = "success";

                    name = newName.trim();
                    email = newEmail.trim();
                    phone = newPhone.trim();
                    address = newAddress.trim();

                    // Update session user object
                    loggedInUser.setName(name);
                    loggedInUser.setEmail(email);
                    loggedInUser.setPhone(Long.parseLong(phone));
                    loggedInUser.setAddress(address);

                    session.setAttribute("loggedInUser", loggedInUser);

                } else {
                    message = "Profile update failed.";
                    messageType = "error";
                }

            } catch (SQLIntegrityConstraintViolationException e) {
                message = "This email address is already registered.";
                messageType = "error";

            } catch (Exception e) {
                application.log("Profile update error", e);
                message = "Something went wrong while updating your profile.";
                messageType = "error";
            }
        }
    }

    // Load customer profile
    if (!"POST".equalsIgnoreCase(request.getMethod()) ||
        messageType.equals("error")) {

        String selectSQL =
            "SELECT name, email, phone, address FROM `user` WHERE userid=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(selectSQL)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    name = rs.getString("name");
                    email = rs.getString("email");
                    phone = rs.getString("phone");
                    address = rs.getString("address");
                }
            }

        } catch (Exception e) {
            application.log("Profile loading error", e);
            message = "Unable to load your profile.";
            messageType = "error";
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>My Profile - Foodies</title>

<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: Arial, sans-serif;
}

body {
    background: #f7f3e9;
    color: #222;
}

.navbar {
    background: #173d2c;
    color: white;
    padding: 18px 7%;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.logo {
    font-size: 25px;
    font-weight: bold;
    color: #e9c46a;
}

.navbar a {
    color: white;
    text-decoration: none;
    margin-left: 22px;
    font-size: 14px;
}

.container {
    max-width: 650px;
    margin: 45px auto;
    padding: 0 18px;
}

.profile-card {
    background: white;
    padding: 35px;
    border-radius: 14px;
    box-shadow: 0 5px 25px rgba(0,0,0,0.08);
}

.profile-heading {
    text-align: center;
    margin-bottom: 30px;
}

.profile-heading h1 {
    color: #173d2c;
    margin-bottom: 8px;
}

.profile-heading p {
    color: #777;
    font-size: 14px;
}

.avatar {
    width: 75px;
    height: 75px;
    background: #173d2c;
    color: #e9c46a;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 30px;
    margin: 0 auto 15px;
}

.form-group {
    margin-bottom: 19px;
}

label {
    display: block;
    font-size: 14px;
    font-weight: bold;
    margin-bottom: 8px;
    color: #333;
}

input, textarea {
    width: 100%;
    padding: 13px;
    border: 1px solid #ddd;
    border-radius: 7px;
    outline: none;
    font-size: 14px;
}

input:focus, textarea:focus {
    border-color: #246b48;
}

textarea {
    resize: vertical;
    min-height: 90px;
}

.save-btn {
    width: 100%;
    padding: 14px;
    background: #173d2c;
    color: white;
    border: none;
    border-radius: 7px;
    font-size: 16px;
    cursor: pointer;
    margin-top: 8px;
}

.save-btn:hover {
    background: #246b48;
}

.message {
    padding: 12px;
    margin-bottom: 20px;
    border-radius: 7px;
    font-size: 14px;
}

.success {
    background: #d9f5e3;
    color: #176536;
}

.error {
    background: #ffe0e0;
    color: #a32222;
}

@media(max-width: 600px) {
    .navbar {
        padding: 15px;
    }

    .navbar a {
        margin-left: 8px;
        font-size: 12px;
    }

    .profile-card {
        padding: 22px;
    }
}
</style>
</head>

<body>

<nav class="navbar">
    <div class="logo">FOODIES</div>

    <div>
        <a href="resturant.jsp">Home</a>
        <a href="MyOrders.jsp">My Orders</a>
        <a href="Cart.jsp">Cart</a>
    </div>
</nav>

<div class="container">

    <div class="profile-card">

        <div class="profile-heading">

            <div class="avatar">👤</div>

            <h1>My Profile</h1>
            <p>View and update your personal information</p>

        </div>

        <% if (!message.isEmpty()) { %>
            <div class="message <%= messageType %>">
                <%= message %>
            </div>
        <% } %>

        <form method="post"
              action="<%= request.getContextPath() %>/MyProfile.jsp">

            <div class="form-group">
                <label for="name">Full Name</label>
                <input type="text"
                       id="name"
                       name="name"
                       value="<%= name == null ? "" : name.replace("&", "&amp;").replace("\"", "&quot;").replace("<", "&lt;").replace(">", "&gt;") %>"
                       required>
            </div>

            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email"
                       id="email"
                       name="email"
                       value="<%= email == null ? "" : email.replace("&", "&amp;").replace("\"", "&quot;").replace("<", "&lt;").replace(">", "&gt;") %>"
                       required>
            </div>

            <div class="form-group">
                <label for="phone">Phone Number</label>
                <input type="tel"
                       id="phone"
                       name="phone"
                       value="<%= phone == null ? "" : phone.replace("&", "&amp;").replace("\"", "&quot;").replace("<", "&lt;").replace(">", "&gt;") %>">
            </div>

            <div class="form-group">
                <label for="address">Address</label>
                <textarea id="address"
                          name="address"><%= address == null ? "" : address.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;") %></textarea>
            </div>

            <button type="submit" class="save-btn">
                Save Changes
            </button>

        </form>

    </div>

</div>

</body>
</html>
