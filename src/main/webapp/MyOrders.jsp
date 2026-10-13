
<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List"%>
<%@ page import="com.tap.model.Orders"%>
<%@ page import="com.tap.model.User"%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>My Orders - Foodies</title>

<style>

/* ================= RESET ================= */

* {
    box-sizing: border-box;
}


/* ================= BODY ================= */

body {

    margin: 0;

    font-family: Arial, sans-serif;

    background: #FBF1E1;

    color: #222;
}


/* ================= NAVBAR ================= */

.navbar {

    width: 100%;

    height: 82px;

    display: flex;

    align-items: center;

    justify-content: space-between;

    padding: 0 55px;

    box-sizing: border-box;

    background: #07352f;

    border-bottom: 1px solid rgba(255, 255, 255, 0.12);

    box-shadow:
        0 5px 0 rgba(0, 0, 0, 0.08),
        0 10px 25px rgba(0, 0, 0, 0.12);

    position: relative;

    z-index: 1000;
}


/* ================= FOODIES LOGO ================= */

.logo {

    display: block;

    font-size: 30px;

    font-weight: 800;

    color: #ffffff;

    letter-spacing: 1px;

    text-decoration: none;

    text-shadow:
        0 2px 0 #04231f,
        0 4px 8px rgba(0, 0, 0, 0.25);
}


.logo span {

    color: #d9a441;
}


/* ================= NAV LINKS ================= */

.nav-links {

    display: flex;

    align-items: center;

    gap: 12px;
}


/* ================= NORMAL LINKS ================= */

.nav-links a {

    display: flex;

    align-items: center;

    justify-content: center;

    min-height: 42px;

    padding: 0 18px;

    color: #ffffff;

    text-decoration: none;

    font-size: 15px;

    font-weight: 600;

    border-radius: 12px;

    transition: all 0.25s ease;
}


/* ================= 3D HOVER ================= */

.nav-links a:hover {

    color: #07352f;

    background: #d9a441;

    transform: translateY(-3px);

    box-shadow:
        0 5px 0 #9c7427,
        0 9px 15px rgba(0, 0, 0, 0.20);
}


/* ================= CART ================= */

.nav-links a[href*="cart"] {

    background: rgba(255, 255, 255, 0.08);

    border: 1px solid rgba(255, 255, 255, 0.14);

    box-shadow:
        inset 0 1px 0 rgba(255, 255, 255, 0.12),
        0 3px 0 rgba(0, 0, 0, 0.18);
}


/* ================= MY ORDERS ================= */

.nav-links a[href*="myOrders"] {

    background: rgba(255, 255, 255, 0.08);

    border: 1px solid rgba(255, 255, 255, 0.14);

    box-shadow:
        inset 0 1px 0 rgba(255, 255, 255, 0.12),
        0 3px 0 rgba(0, 0, 0, 0.18);
}


/* ================= LOGIN ================= */

.login-btn {

    background: #d9a441 !important;

    color: #07352f !important;

    font-weight: 700 !important;

    border-radius: 12px !important;

    box-shadow:
        0 5px 0 #9c7427,
        0 8px 15px rgba(0, 0, 0, 0.20) !important;
}


.login-btn:hover {

    transform: translateY(-3px);

    background: #e5b452 !important;

    box-shadow:
        0 7px 0 #9c7427,
        0 12px 20px rgba(0, 0, 0, 0.25) !important;
}


/* ================= CONTAINER ================= */

.orders-container {

    width: 90%;

    max-width: 1050px;

    margin: 35px auto;
}


/* ================= ORDER CARD ================= */

.order-card {

    background: #ffffff;

    border-radius: 16px;

    padding: 25px;

    margin-bottom: 20px;

    box-shadow:
        0 5px 18px rgba(0, 0, 0, 0.10);

    border: 1px solid rgba(23, 74, 58, 0.08);
}


/* ================= ORDER TOP ================= */

.order-top {

    display: flex;

    align-items: center;

    justify-content: space-between;

    margin-bottom: 18px;
}


/* ================= ORDER NUMBER ================= */

.order-number {

    margin: 0;

    color: #174A3A;

    font-size: 22px;

    font-weight: 800;
}


/* ================= STATUS ================= */

.status {

    padding: 7px 14px;

    border-radius: 20px;

    background: #e5f4ea;

    color: #267348;

    font-size: 14px;

    font-weight: 700;
}


/* ================= ORDER DETAILS ================= */

.order-details {

    display: grid;

    grid-template-columns: repeat(2, 1fr);

    gap: 14px;

    padding-top: 10px;
}


/* ================= DETAIL BOX ================= */

.detail-box {

    background: #FBF1E1;

    border-radius: 10px;

    padding: 14px 16px;
}


/* ================= DETAIL LABEL ================= */

.detail-label {

    display: block;

    color: #777;

    font-size: 13px;

    margin-bottom: 5px;
}


/* ================= DETAIL VALUE ================= */

.detail-value {

    color: #174A3A;

    font-size: 16px;

    font-weight: 700;
}


/* ================= PAYMENT ================= */

.payment {

    color: #555;

    font-weight: 600;
}


/* ================= EMPTY ORDERS ================= */

.empty-orders {

    background: #ffffff;

    border-radius: 16px;

    padding: 60px 30px;

    text-align: center;

    box-shadow:
        0 5px 18px rgba(0, 0, 0, 0.10);
}


.empty-orders h2 {

    margin: 0 0 10px;

    color: #174A3A;

    font-size: 25px;
}


.empty-orders p {

    color: #777;

    margin-bottom: 25px;
}


/* ================= ORDER NOW BUTTON ================= */

.back-btn {

    display: inline-flex;

    align-items: center;

    justify-content: center;

    min-height: 42px;

    padding: 0 18px;

    background: #d9a441;

    color: #07352f;

    text-decoration: none;

    font-size: 15px;

    font-weight: 700;

    border-radius: 12px;

    box-shadow:
        0 5px 0 #9c7427,
        0 8px 15px rgba(0, 0, 0, 0.20);

    transition: all 0.25s ease;
}


.back-btn:hover {

    transform: translateY(-3px);

    background: #e5b452;

    box-shadow:
        0 7px 0 #9c7427,
        0 12px 20px rgba(0, 0, 0, 0.25);
}


/* ================= MOBILE ================= */

@media (max-width: 800px) {

    .navbar {

        height: auto;

        padding: 18px 25px;

        flex-direction: column;

        gap: 15px;
    }

    .nav-links {

        flex-wrap: wrap;

        justify-content: center;
    }

    .nav-links a {

        padding: 0 12px;
    }
}


@media (max-width: 700px) {

    .orders-container {

        width: 94%;

        margin: 25px auto;
    }

    .order-details {

        grid-template-columns: 1fr;
    }

    .order-top {

        align-items: flex-start;

        gap: 10px;

        flex-direction: column;
    }
}

</style>

</head>


<body>


<%
User user = (User) session.getAttribute("loggedInUser");

if (user == null) {

    response.sendRedirect(
        request.getContextPath() + "/login.html"
    );

    return;
}

List<Orders> orders =
        (List<Orders>) request.getAttribute("orders");
%>




<!-- ================= NAVBAR ================= -->
<nav class="navbar">

    <a href="<%= request.getContextPath() %>/resturant"
       class="logo">
        Food<span>ies</span>
    </a>

    <div class="nav-links">

        <a href="<%= request.getContextPath() %>/resturant">
            Home
        </a>

        <a href="<%= request.getContextPath() %>/resturant">
            Restaurants
        </a>

        <a href="<%= request.getContextPath() %>/resturant">
            Menu
        </a>

        <a href="<%= request.getContextPath() %>/cart"
           class="cart-link">
            🛒 Cart
        </a>

        <a href="<%= request.getContextPath() %>/myOrders"
           class="my-orders-link">
            My Orders
        </a>

        <a href="<%= request.getContextPath() %>/login.html"
           class="login-btn">
            Login
        </a>

    </div>

</nav>



<!-- ================= ORDERS ================= -->

<div class="orders-container">


<%

if (orders == null || orders.isEmpty()) {

%>


    <!-- ================= EMPTY ================= -->

    <div class="empty-orders">

        <h2>
            No Orders Yet
        </h2>

        <p>
            You haven't placed any orders yet.
        </p>

        <a href="<%= request.getContextPath() %>/resturant"
           class="back-btn">

            Order Now

        </a>

    </div>


<%

} else {

    for (Orders order : orders) {

%>


    <!-- ================= ORDER CARD ================= -->

    <div class="order-card">


        <!-- ORDER TOP -->

        <div class="order-top">

            <h2 class="order-number">

                Order #<%= order.getOrderid() %>

            </h2>


            <span class="status">

                <%= order.getStatus() %>

            </span>

        </div>


        <!-- ORDER DETAILS -->

        <div class="order-details">


            <!-- RESTAURANT -->

            <div class="detail-box">

                <span class="detail-label">

                    Restaurant ID

                </span>

                <span class="detail-value">

                    <%= order.getResturantid() %>

                </span>

            </div>


            <!-- TOTAL -->

            <div class="detail-box">

                <span class="detail-label">

                    Total Amount

                </span>

                <span class="detail-value">

                    ₹<%= order.getTotalamount() %>

                </span>

            </div>


            <!-- PAYMENT -->

            <div class="detail-box">

                <span class="detail-label">

                    Payment Method

                </span>

                <span class="detail-value payment">

<%

double payment = order.getPaymentmode();

if (payment == 1) {

%>

                    Cash on Delivery

<%

} else if (payment == 2) {

%>

                    UPI

<%

} else if (payment == 3) {

%>

                    Card

<%

} else {

%>

                    Not Available

<%

}

%>

                </span>

            </div>


            <!-- ORDER ID -->

            <div class="detail-box">

                <span class="detail-label">

                    Order ID

                </span>

                <span class="detail-value">

                    #<%= order.getOrderid() %>

                </span>

            </div>


        </div>

    </div>


<%

    }

}

%>


</div>


</body>

</html>

