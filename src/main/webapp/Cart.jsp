<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.Map"%>
<%@ page import="com.tap.model.Cart"%>
<%@ page import="com.tap.model.CartItem"%>
<%@ page import="com.tap.model.Menu"%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>My Cart</title>
<link rel="stylesheet"
      href="<%= request.getContextPath() %>/css/foodies-app-theme.css">

<style>

* {
    box-sizing: border-box;
}

body {
    margin: 0;
    font-family: Arial, sans-serif;

    background: linear-gradient(
        135deg,
        #FDBB2D,
        #22C1C3
    );

    min-height: 100vh;
}


/* =========================
   HEADER
   ========================= */

.header {
    width: 92%;
    margin: auto;

    padding: 22px 0;

    display: flex;
    justify-content: space-between;
    align-items: center;
}

.header h1 {
    margin: 0;

    color: #171b36;

    font-size: 32px;
}

.back-button {
    text-decoration: none;

    background: #171b36;

    color: white;

    padding: 11px 20px;

    border-radius: 25px;

    font-weight: bold;

    transition: 0.3s;
}

.back-button:hover {
    background: #fa6040;
}


/* =========================
   MAIN CONTAINER
   ========================= */

.cart-container {
    width: 92%;
    max-width: 1200px;

    margin: 10px auto 50px;

    display: grid;

    grid-template-columns: 2fr 1fr;

    gap: 25px;
}


/* =========================
   CART ITEMS SECTION
   ========================= */

.cart-items {
    background: white;

    border-radius: 18px;

    padding: 20px;

    box-shadow:
        0 8px 20px rgba(0, 0, 0, 0.15);
}


/* =========================
   CART ITEM
   ========================= */

.cart-item {
    display: flex;

    align-items: center;

    gap: 20px;

    padding: 18px 0;

    border-bottom: 1px solid #ddd;
}

.cart-item:last-child {
    border-bottom: none;
}


/* =========================
   IMAGE
   ========================= */

.cart-item img {
    width: 120px;

    height: 100px;

    object-fit: cover;

    border-radius: 12px;
}


/* =========================
   ITEM DETAILS
   ========================= */

.item-details {
    flex: 1;
}

.item-details h2 {
    margin: 0 0 8px;

    font-size: 21px;

    color: #222;
}

.item-price {
    margin: 5px 0;

    color: #666;

    font-size: 15px;
}

.item-total {
    margin: 5px 0;

    color: #d63031;

    font-size: 17px;

    font-weight: bold;
}


/* =========================
   QUANTITY
   ========================= */

.quantity {
    display: flex;

    align-items: center;

    gap: 10px;
}

.quantity form {
    margin: 0;
}

.quantity button {
    width: 34px;

    height: 34px;

    border: none;

    border-radius: 8px;

    background: #171b36;

    color: white;

    font-size: 20px;

    cursor: pointer;

    transition: 0.2s;
}

.quantity button:hover {
    background: #fa6040;
}

.quantity strong {
    min-width: 25px;

    text-align: center;

    font-size: 17px;
}


/* =========================
   REMOVE
   ========================= */

.remove-form {
    margin-left: 5px;
}

.remove-button {
    border: none;

    background: transparent;

    color: #e53935;

    font-weight: bold;

    cursor: pointer;

    font-size: 14px;
}

.remove-button:hover {
    text-decoration: underline;
}


/* =========================
   ORDER SUMMARY
   ========================= */

.order-summary {
    background: white;

    border-radius: 18px;

    padding: 25px;

    height: fit-content;

    box-shadow:
        0 8px 20px rgba(0, 0, 0, 0.15);

    position: sticky;

    top: 20px;
}

.order-summary h2 {
    margin-top: 0;

    color: #171b36;
}


/* =========================
   SUMMARY ROW
   ========================= */

.summary-row {
    display: flex;

    justify-content: space-between;

    margin: 15px 0;

    color: #555;
}

.summary-row.total-row {
    border-top: 1px solid #ddd;

    padding-top: 18px;

    margin-top: 20px;

    color: #222;

    font-size: 21px;

    font-weight: bold;
}


/* =========================
   CHECKOUT BUTTON
   ========================= */

.checkout-button {
    width: 100%;

    border: none;

    padding: 15px;

    margin-top: 20px;

    border-radius: 10px;

    background: #57A97A;

    color: white;

    font-size: 18px;

    font-weight: bold;

    cursor: pointer;

    transition: 0.3s;
}

.checkout-button:hover {
    background: #438d63;
}


/* =========================
   ERROR MESSAGE
   ========================= */

.error {
    width: 92%;

    max-width: 1200px;

    margin: 10px auto;

    background: #ffe0e0;

    color: #c62828;

    padding: 14px 18px;

    border-radius: 10px;

    font-weight: bold;
}


/* =========================
   EMPTY CART
   ========================= */

.empty-cart {
    width: 92%;

    max-width: 700px;

    margin: 80px auto;

    background: white;

    border-radius: 18px;

    padding: 50px 30px;

    text-align: center;

    box-shadow:
        0 8px 20px rgba(0, 0, 0, 0.15);
}

.empty-cart h2 {
    color: #171b36;

    margin-bottom: 15px;
}

.empty-cart p {
    color: #666;

    margin-bottom: 25px;
}

.shop-button {
    display: inline-block;

    text-decoration: none;

    background: #57A97A;

    color: white;

    padding: 13px 25px;

    border-radius: 10px;

    font-weight: bold;
}

.shop-button:hover {
    background: #438d63;
}


/* =========================
   RESPONSIVE
   ========================= */

@media (max-width: 850px) {

    .cart-container {
        grid-template-columns: 1fr;
    }

    .order-summary {
        position: static;
    }
}

@media (max-width: 600px) {

    .cart-item {
        flex-wrap: wrap;
    }

    .cart-item img {
        width: 100px;

        height: 85px;
    }

    .item-details {
        min-width: 180px;
    }

    .header {
        flex-direction: column;

        gap: 15px;
    }
}

</style>

</head>


<body>


<!-- =========================
     HEADER
     ========================= -->

<div class="header">

    <h1>🛒 My Cart</h1>

    <a
        href="<%= request.getContextPath() %>/resturant"
        class="back-button">

        ← Continue Shopping

    </a>

</div>


<%

Cart cart = (Cart) request.getAttribute("cart");

String cartError =
    (String) request.getAttribute("cartError");

if (cartError != null) {

%>

<div class="error">

    <%= cartError %>

</div>

<%

}

if (cart == null || cart.getItems().isEmpty()) {

%>


<!-- =========================
     EMPTY CART
     ========================= -->

<div class="empty-cart">

    <h2>Your cart is empty 🛒</h2>

    <p>
        Add some delicious food to your cart and come back here.
    </p>

    <a
        href="<%= request.getContextPath() %>/resturant"
        class="shop-button">

        Browse Restaurants

    </a>

</div>


<%

} else {

%>


<!-- =========================
     CART + SUMMARY
     ========================= -->

<div class="cart-container">


    <!-- =====================
         CART ITEMS
         ===================== -->

    <div class="cart-items">

        <h2>
            Your Items
        </h2>


<%

for (Map.Entry<Integer, CartItem> entry
        : cart.getItems().entrySet()) {

    CartItem cartItem = entry.getValue();

    Menu menu = cartItem.getMenu();

    String imagePath = menu.getImagepath();

    if (imagePath == null ||
        imagePath.trim().isEmpty()) {

        imagePath =
            "https://placehold.co/600x400?text=Food+Image";
    }

%>


        <div class="cart-item">


            <!-- FOOD IMAGE -->

            <img
                src="<%= imagePath %>"
                alt="<%= menu.getFoodname() %>"
                onerror="this.src='https://placehold.co/600x400?text=Food+Image';"
            >


            <!-- FOOD DETAILS -->

            <div class="item-details">

                <h2>
                    <%= menu.getFoodname() %>
                </h2>

                <p class="item-price">

                    ₹<%= menu.getPrice() %>
                    ×
                    <%= cartItem.getQuantity() %>

                </p>

                <p class="item-total">

                    ₹<%= cartItem.getTotal() %>

                </p>

            </div>


            <!-- QUANTITY -->

            <div class="quantity">


                <!-- MINUS -->

                <form
                    action="<%= request.getContextPath() %>/cart"
                    method="post">

                    <input
                        type="hidden"
                        name="action"
                        value="minus">

                    <input
                        type="hidden"
                        name="menuId"
                        value="<%= menu.getMenuid() %>">

                    <button type="submit">
                        −
                    </button>

                </form>


                <strong>
                    <%= cartItem.getQuantity() %>
                </strong>


                <!-- PLUS -->

                <form
                    action="<%= request.getContextPath() %>/cart"
                    method="post">

                    <input
                        type="hidden"
                        name="action"
                        value="plus">

                    <input
                        type="hidden"
                        name="menuId"
                        value="<%= menu.getMenuid() %>">

                    <button type="submit">
                        +
                    </button>

                </form>

            </div>


            <!-- REMOVE -->

            <form
                action="<%= request.getContextPath() %>/cart"
                method="post"
                class="remove-form">

                <input
                    type="hidden"
                    name="action"
                    value="remove">

                <input
                    type="hidden"
                    name="menuId"
                    value="<%= menu.getMenuid() %>">

                <button
                    type="submit"
                    class="remove-button">

                    Remove

                </button>

            </form>


        </div>


<%

}

%>


    </div>


    <!-- =====================
         ORDER SUMMARY
         ===================== -->

    <div class="order-summary">

        <h2>
            Order Summary
        </h2>


        <div class="summary-row">

            <span>
                Items
            </span>

            <span>
                <%= cart.getTotalItems() %>
            </span>

        </div>


        <div class="summary-row">

            <span>
                Item Total
            </span>

            <span>
                ₹<%= cart.getTotal() %>
            </span>

        </div>


        <div class="summary-row">

            <span>
                Delivery Fee
            </span>

            <span>
                ₹40
            </span>

        </div>


        <div class="summary-row total-row">

            <span>
                Total
            </span>

            <span>
                ₹<%= cart.getTotal() + 40 %>
            </span>

        </div>


        <!-- CHECKOUT -->

        <form
            action="<%= request.getContextPath() %>/checkout"
            method="get">

            <button
                type="submit"
                class="checkout-button">

                Proceed to Checkout

            </button>

        </form>


    </div>


</div>


<%

}

%>


</body>

</html>