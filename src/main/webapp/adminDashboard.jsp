<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.tap.util.DBConnection" %>

<%!
    public String escapeHtml(Object value) {
        if (value == null) return "";

        return value.toString()
            .replace("&", "&amp;")
            .replace("<", "&lt;")
            .replace(">", "&gt;")
            .replace("\"", "&quot;")
            .replace("'", "&#39;");
    }
%>

<%
    // Prevent browser caching
    response.setHeader("Cache-Control",
            "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    // Admin-only access
    if (session.getAttribute("adminId") == null ||
        !"admin".equals(session.getAttribute("adminRole"))) {

        response.sendRedirect(
            request.getContextPath() + "/adminLogin.jsp");
        return;
    }

    String adminName = (String) session.getAttribute("adminUsername");

    double totalSales = 0;
    int totalCustomers = 0;
    int pendingOrders = 0;
    int completedOrders = 0;

    double[] monthlySales = new double[12];

    List<Map<String, Object>> recentOrders = new ArrayList<>();

    String[] months = {
        "Jan", "Feb", "Mar", "Apr", "May", "Jun",
        "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    };

    try (Connection con = DBConnection.getConnection()) {

        if (con == null) {
            throw new SQLException("Database connection failed.");
        }

        // Total sales
        String salesSQL =
            "SELECT COALESCE(SUM(totalamount), 0) FROM orders";

        try (PreparedStatement ps = con.prepareStatement(salesSQL);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                totalSales = rs.getDouble(1);
            }
        }

        // Total customers
        String customerSQL =
            "SELECT COUNT(*) FROM `user` WHERE role = 'customer'";

        try (PreparedStatement ps = con.prepareStatement(customerSQL);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                totalCustomers = rs.getInt(1);
            }
        }

        // Pending orders
        String pendingSQL =
            "SELECT COUNT(*) FROM orders WHERE LOWER(status) = 'pending'";

        try (PreparedStatement ps = con.prepareStatement(pendingSQL);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                pendingOrders = rs.getInt(1);
            }
        }

        // Completed orders
        String completedSQL =
            "SELECT COUNT(*) FROM orders " +
            "WHERE LOWER(status) IN ('completed', 'delivered')";

        try (PreparedStatement ps = con.prepareStatement(completedSQL);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                completedOrders = rs.getInt(1);
            }
        }

        // Monthly sales for current year
        String monthlySQL =
            "SELECT MONTH(orderdate) AS month_number, " +
            "COALESCE(SUM(totalamount), 0) AS sales " +
            "FROM orders " +
            "WHERE YEAR(orderdate) = YEAR(CURDATE()) " +
            "GROUP BY MONTH(orderdate) " +
            "ORDER BY MONTH(orderdate)";

        try (PreparedStatement ps = con.prepareStatement(monthlySQL);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                int monthNumber = rs.getInt("month_number");

                if (monthNumber >= 1 && monthNumber <= 12) {
                    monthlySales[monthNumber - 1] =
                        rs.getDouble("sales");
                }
            }
        }

        // Recent orders
        String recentSQL =
            "SELECT o.orderid, u.name, o.totalamount, " +
            "o.status, o.orderdate " +
            "FROM orders o " +
            "LEFT JOIN `user` u ON o.userid = u.userid " +
            "ORDER BY o.orderdate DESC " +
            "LIMIT 10";

        try (PreparedStatement ps = con.prepareStatement(recentSQL);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Map<String, Object> order = new HashMap<>();

                order.put("id", rs.getObject("orderid"));
                order.put("customer", rs.getString("name"));
                order.put("amount", rs.getDouble("totalamount"));
                order.put("status", rs.getString("status"));
                order.put("date", rs.getTimestamp("orderdate"));

                recentOrders.add(order);
            }
        }
    } catch (SQLException e) {
        application.log("Admin dashboard database error", e);
        request.setAttribute("dashboardError",
            "Unable to load dashboard data. Please check the database.");
    }

    double maxSales = 0;

    for (double sale : monthlySales) {
        if (sale > maxSales) {
            maxSales = sale;
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Foodies Admin Dashboard</title>

<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: Arial, sans-serif;
}

body {
    background: #101010;
    color: #ffffff;
}

.dashboard {
    display: flex;
    min-height: 100vh;
}

/* SIDEBAR */

.sidebar {
    width: 245px;
    background: #171717;
    padding: 25px 18px;
    position: fixed;
    height: 100vh;
}

.logo {
    font-size: 27px;
    font-weight: bold;
    color: #a58bff;
    margin-bottom: 40px;
    padding-left: 12px;
}

.logo span {
    color: #ffffff;
}

.menu-title {
    color: #777;
    font-size: 12px;
    margin: 20px 12px 12px;
    text-transform: uppercase;
}

.sidebar a {
    display: block;
    color: #bdbdbd;
    text-decoration: none;
    padding: 14px 15px;
    margin-bottom: 8px;
    border-radius: 8px;
    font-size: 15px;
    transition: 0.3s;
}

.sidebar a:hover,
.sidebar a.active {
    background: #6041f5;
    color: #ffffff;
}

.sidebar .logout {
    position: absolute;
    bottom: 25px;
    left: 18px;
    right: 18px;
    width: auto;
    color: #ff7777;
}

/* MAIN CONTENT */

.main {
    margin-left: 245px;
    width: calc(100% - 245px);
    padding: 30px;
}

.topbar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 35px;
    gap: 15px;
}

.topbar h1 {
    font-size: 27px;
}

.topbar p {
    color: #999;
    margin-top: 7px;
}

.admin-info {
    background: #202020;
    padding: 12px 18px;
    border-radius: 10px;
    color: #c8baff;
}

/* SUMMARY CARDS */

.cards {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 20px;
    margin-bottom: 30px;
}

.card {
    background: #1c1c1c;
    padding: 24px;
    border-radius: 13px;
    border: 1px solid #292929;
}

.card p {
    color: #999;
    font-size: 14px;
    margin-bottom: 15px;
}

.card h2 {
    font-size: 27px;
    color: #ffffff;
}

.card .icon {
    font-size: 24px;
    margin-bottom: 15px;
}

/* CONTENT GRID */

.content-grid {
    display: grid;
    grid-template-columns: 1.3fr 1fr;
    gap: 22px;
    margin-bottom: 25px;
}

.panel {
    background: #1c1c1c;
    border: 1px solid #292929;
    border-radius: 13px;
    padding: 25px;
}

.panel h2 {
    font-size: 19px;
    margin-bottom: 25px;
}

/* SALES CHART */

.chart {
    height: 230px;
    display: flex;
    align-items: flex-end;
    justify-content: space-around;
    gap: 10px;
    border-bottom: 1px solid #444;
    padding: 0 5px;
}

.chart-item {
    height: 100%;
    flex: 1;
    display: flex;
    flex-direction: column;
    justify-content: flex-end;
    align-items: center;
    gap: 10px;
}

.bar {
    width: 65%;
    min-height: 3px;
    background: linear-gradient(180deg, #987cff, #6041f5);
    border-radius: 6px 6px 0 0;
}

.chart-item span {
    color: #999;
    font-size: 12px;
    padding-bottom: 8px;
}

/* QUICK STATS */

.quick-stat {
    background: #252525;
    padding: 20px;
    border-radius: 10px;
    margin-bottom: 15px;
}

.quick-stat p {
    color: #999;
    font-size: 14px;
    margin-bottom: 10px;
}

.quick-stat h2 {
    font-size: 25px;
    color: #a58bff;
}

/* ORDERS TABLE */

.orders-panel {
    background: #1c1c1c;
    padding: 25px;
    border-radius: 13px;
    border: 1px solid #292929;
    overflow-x: auto;
}

.orders-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 15px;
    margin-bottom: 22px;
}

.orders-header h2 {
    font-size: 19px;
}

.search {
    background: #292929;
    color: white;
    border: 1px solid #444;
    padding: 10px 13px;
    border-radius: 7px;
    outline: none;
}

table {
    width: 100%;
    border-collapse: collapse;
    min-width: 650px;
}

th {
    text-align: left;
    color: #999;
    font-size: 13px;
    padding: 15px 12px;
    border-bottom: 1px solid #393939;
}

td {
    padding: 17px 12px;
    border-bottom: 1px solid #303030;
    font-size: 14px;
}

.status {
    display: inline-block;
    padding: 6px 12px;
    border-radius: 20px;
    font-size: 12px;
    background: #333;
}

.pending {
    color: #ffc66d;
    background: #49391e;
}

.completed,
.delivered {
    color: #6fe3a0;
    background: #183c2a;
}

.cancelled {
    color: #ff8585;
    background: #482323;
}

.empty {
    text-align: center;
    color: #999;
    padding: 30px;
}

.error {
    color: #ff8585;
    background: #482323;
    padding: 14px;
    border-radius: 8px;
    margin-bottom: 20px;
}

/* RESPONSIVE */

@media (max-width: 1000px) {
    .cards {
        grid-template-columns: repeat(2, 1fr);
    }

    .content-grid {
        grid-template-columns: 1fr;
    }
}

@media (max-width: 650px) {
    .sidebar {
        width: 75px;
        padding: 20px 8px;
    }

    .logo {
        font-size: 15px;
        padding-left: 5px;
    }

    .sidebar a {
        font-size: 11px;
        padding: 12px 5px;
        text-align: center;
    }

    .menu-title {
        display: none;
    }

    .sidebar .logout {
        left: 8px;
        right: 8px;
    }

    .main {
        margin-left: 75px;
        width: calc(100% - 75px);
        padding: 18px 12px;
    }

    .cards {
        grid-template-columns: 1fr;
    }

    .topbar {
        align-items: flex-start;
        flex-direction: column;
    }
}
</style>
</head>

<body>

<div class="dashboard">

    <!-- SIDEBAR -->

    <aside class="sidebar">

        <div class="logo">
            FOOD<span>IES</span>
        </div>

        <p class="menu-title">Main Menu</p>

        <a href="adminDashboard.jsp" class="active">
            ▦ Dashboard
        </a>

        <a href="adminOrders.jsp">
            🛒 Orders
        </a>

        <a href="#">
            🍔 Food Items
        </a>

        <a href="#">
            📊 Analytics
        </a>

        <a href="#">
            🎁 Discounts
        </a>

        <a href="adminCustomers.jsp">
            👥 Customers
        </a>

        <a href="#">
            ⚙ Settings
        </a>

        <a href="${pageContext.request.contextPath}/adminLogout.jsp"
           class="logout">
            ⇦ Log out
        </a>

    </aside>


    <!-- MAIN CONTENT -->

    <main class="main">

        <div class="topbar">

            <div>
                <h1>Dashboard</h1>
                <p>Welcome back! Here's your restaurant overview.</p>
            </div>

            <div class="admin-info">
                Admin: <%= escapeHtml(adminName) %>
            </div>

        </div>


        <% if (request.getAttribute("dashboardError") != null) { %>
            <div class="error">
                <%= escapeHtml(request.getAttribute("dashboardError")) %>
            </div>
        <% } %>


        <!-- SUMMARY CARDS -->

        <section class="cards">

            <div class="card">
                <div class="icon">💰</div>
                <p>Total Sales</p>
                <h2>₹<%= String.format("%,.2f", totalSales) %></h2>
            </div>

            <div class="card">
                <div class="icon">👥</div>
                <p>Total Customers</p>
                <h2><%= totalCustomers %></h2>
            </div>

            <div class="card">
                <div class="icon">🛒</div>
                <p>Pending Orders</p>
                <h2><%= pendingOrders %></h2>
            </div>

            <div class="card">
                <div class="icon">✅</div>
                <p>Completed Orders</p>
                <h2><%= completedOrders %></h2>
            </div>

        </section>


        <!-- SALES AND QUICK STATS -->

        <section class="content-grid">

            <div class="panel">

                <h2>Monthly Sales - <%= Calendar.getInstance().get(Calendar.YEAR) %></h2>

                <div class="chart">

                    <% for (int i = 0; i < 12; i++) {
                        int height = maxSales > 0
                            ? (int)((monthlySales[i] / maxSales) * 100)
                            : 0;
                    %>

                        <div class="chart-item">

                            <div class="bar"
                                 title="₹<%= String.format("%,.2f", monthlySales[i]) %>"
                                 style="height:<%= height %>%;">
                            </div>

                            <span><%= months[i] %></span>

                        </div>

                    <% } %>

                </div>

            </div>


            <div class="panel">

                <h2>Quick Overview</h2>

                <div class="quick-stat">
                    <p>Total Customers</p>
                    <h2><%= totalCustomers %></h2>
                </div>

                <div class="quick-stat">
                    <p>Pending Orders</p>
                    <h2><%= pendingOrders %></h2>
                </div>

                <div class="quick-stat">
                    <p>Completed Orders</p>
                    <h2><%= completedOrders %></h2>
                </div>

            </div>

        </section>


        <!-- RECENT ORDERS -->

        <section class="orders-panel">

            <div class="orders-header">

                <h2>Recent Orders</h2>

                <input type="text"
                       id="searchInput"
                       class="search"
                       placeholder="Search orders..."
                       onkeyup="searchOrders()">

            </div>

            <table id="ordersTable">

                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Customer</th>
                        <th>Amount</th>
                        <th>Status</th>
                        <th>Order Date</th>
                    </tr>
                </thead>

                <tbody>

                    <% if (recentOrders.isEmpty()) { %>

                        <tr>
                            <td colspan="5" class="empty">
                                No orders found.
                            </td>
                        </tr>

                    <% } else {
                        for (Map<String, Object> order : recentOrders) {

                            String status = String.valueOf(order.get("status"));
                            String statusClass = status == null
                                ? ""
                                : status.toLowerCase(Locale.ROOT);
                    %>

                        <tr>

                            <td>#<%= escapeHtml(order.get("id")) %></td>

                            <td><%= escapeHtml(order.get("customer")) %></td>

                            <td>
                                ₹<%= String.format("%,.2f",
                                    (Double) order.get("amount")) %>
                            </td>

                            <td>
                                <span class="status <%= escapeHtml(statusClass) %>">
                                    <%= escapeHtml(status) %>
                                </span>
                            </td>

                            <td>
                                <%= escapeHtml(order.get("date")) %>
                            </td>

                        </tr>

                    <%  }
                       }
                    %>

                </tbody>

            </table>

        </section>

    </main>

</div>


<script>
function searchOrders() {

    let input = document.getElementById("searchInput");
    let filter = input.value.toLowerCase();

    let table = document.getElementById("ordersTable");
    let rows = table.getElementsByTagName("tr");

    for (let i = 1; i < rows.length; i++) {

        let text = rows[i].innerText.toLowerCase();

        rows[i].style.display =
            text.includes(filter) ? "" : "none";
    }
}
</script>

</body>
</html>
