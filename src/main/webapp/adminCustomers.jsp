
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.tap.model.User" %>

<%
    if (session.getAttribute("adminId") == null) {
        response.sendRedirect(
            request.getContextPath() + "/adminLogin.jsp");
        return;
    }

    List<User> allCustomers =
        (List<User>) request.getAttribute("allCustomers");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Foodies - Manage Customers</title>

<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
    background: #FBF1E1;
    color: #2D2418;
}

.navbar {
    background: #174A3A;
    color: white;
    padding: 22px 35px;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.logo {
    font-size: 27px;
    font-weight: bold;
}

.logo span {
    color: #D6A84F;
}

.navbar a {
    color: #D6A84F;
    text-decoration: none;
    font-weight: bold;
}

.container {
    padding: 30px;
}

h1 {
    color: #174A3A;
    margin-bottom: 10px;
}

.subtitle {
    margin-bottom: 25px;
    color: #665744;
}

.table-container {
    overflow-x: auto;
    background: white;
    border-radius: 10px;
    box-shadow: 0 5px 15px rgba(0,0,0,0.1);
}

table {
    width: 100%;
    border-collapse: collapse;
    min-width: 850px;
}

th {
    background: #174A3A;
    color: white;
    padding: 15px;
    text-align: left;
}

td {
    padding: 14px 15px;
    border-bottom: 1px solid #eee3d2;
}

tr:hover td {
    background: #fff9ef;
}

.empty {
    padding: 25px;
    text-align: center;
    color: #665744;
}

.back {
    display: inline-block;
    margin-top: 22px;
    padding: 11px 18px;
    background: #174A3A;
    color: white;
    text-decoration: none;
    border-radius: 6px;
}

@media (max-width: 600px) {
    .container {
        padding: 18px;
    }
}
</style>
</head>

<body>

<header class="navbar">
    <div class="logo">Food<span>ies</span> Admin</div>

    <a href="<%= request.getContextPath() %>/adminDashboard.jsp">
        Dashboard
    </a>
</header>

<main class="container">

    <h1>Manage Customers</h1>
    <p class="subtitle">Registered customers in your Foodies application.</p>

    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th>Customer ID</th>
                    <th>Name</th>
                    <th>Username</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Address</th>
                </tr>
            </thead>

            <tbody>
            <%
                if (allCustomers != null && !allCustomers.isEmpty()) {
                    for (User customer : allCustomers) {
            %>
                <tr>
                    <td><%= customer.getUserid() %></td>
                    <td><%= customer.getName() %></td>
                    <td><%= customer.getUsername() %></td>
                    <td><%= customer.getEmail() %></td>
                    <td><%= customer.getPhone() %></td>
                    <td><%= customer.getAddress() %></td>
                </tr>
            <%
                    }
                } else {
            %>
                <tr>
                    <td colspan="6" class="empty">
                        No registered customers found.
                    </td>
                </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>

    <a class="back"
       href="<%= request.getContextPath() %>/adminDashboard.jsp">
       Back to Dashboard
    </a>

</main>

</body>
</html>
