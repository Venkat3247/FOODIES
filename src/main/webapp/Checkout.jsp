
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.Map"%>
<%@ page import="com.tap.model.Cart"%>
<%@ page import="com.tap.model.CartItem"%>
<%@ page import="com.tap.model.Menu"%>
<%@ page import="com.tap.model.User"%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Checkout</title>

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/foodies-app-theme.css">

<style>
* {
	box-sizing: border-box;
}

body {
	margin: 0;
	font-family: Arial, sans-serif;
	background: linear-gradient(135deg, #FDBB2D, #22C1C3);
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
}

.back-button:hover {
	background: #fa6040;
}

/* =========================
   MAIN
   ========================= */
.checkout-container {
	width: 92%;
	max-width: 1200px;
	margin: 10px auto 50px;
	display: grid;
	grid-template-columns: 1.5fr 1fr;
	gap: 25px;
}

/* =========================
   LEFT SIDE
   ========================= */
.checkout-left {
	display: flex;
	flex-direction: column;
	gap: 20px;
}

/* =========================
   CARD
   ========================= */
.card {
	background: white;
	border-radius: 18px;
	padding: 25px;
	box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
}

.card h2 {
	margin-top: 0;
	color: #171b36;
	margin-bottom: 20px;
}

/* =========================
   FORM
   ========================= */
.form-group {
	margin-bottom: 18px;
}

.form-group label {
	display: block;
	margin-bottom: 7px;
	font-weight: bold;
	color: #333;
}

.form-group input, .form-group textarea {
	width: 100%;
	padding: 12px;
	border: 1px solid #ccc;
	border-radius: 8px;
	font-size: 15px;
	font-family: Arial, sans-serif;
}

.form-group textarea {
	min-height: 90px;
	resize: vertical;
}

/* =========================
   PAYMENT
   ========================= */
.payment-option {
	display: flex;
	align-items: center;
	gap: 12px;
	padding: 14px;
	margin-bottom: 10px;
	border: 1px solid #ddd;
	border-radius: 10px;
	cursor: pointer;
}

.payment-option:hover {
	background: #f5f5f5;
}

.payment-option input {
	width: 18px;
	height: 18px;
}

.payment-option span {
	font-weight: bold;
	color: #333;
}

/* =========================
   RIGHT SIDE
   ========================= */
.checkout-right {
	height: fit-content;
	position: sticky;
	top: 20px;
}

/* =========================
   ORDER ITEMS
   ========================= */
.order-item {
	display: flex;
	align-items: center;
	gap: 12px;
	padding: 12px 0;
	border-bottom: 1px solid #eee;
}

.order-item:last-child {
	border-bottom: none;
}

.order-item img {
	width: 65px;
	height: 60px;
	object-fit: cover;
	border-radius: 8px;
}

.order-item-details {
	flex: 1;
}

.order-item-details h3 {
	margin: 0 0 5px;
	font-size: 16px;
	color: #222;
}

.order-item-details p {
	margin: 0;
	color: #777;
	font-size: 14px;
}

.order-item-price {
	font-weight: bold;
	color: #d63031;
}

/* =========================
   SUMMARY
   ========================= */
.summary-row {
	display: flex;
	justify-content: space-between;
	margin: 15px 0;
	color: #555;
}

.total-row {
	border-top: 1px solid #ddd;
	padding-top: 18px;
	margin-top: 20px;
	font-size: 21px;
	font-weight: bold;
	color: #222;
}

/* =========================
   PLACE ORDER
   ========================= */
.place-order-button {
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
}

.place-order-button:hover {
	background: #438d63;
}

/* =========================
   RESPONSIVE
   ========================= */
@media ( max-width : 850px) {
	.checkout-container {
		grid-template-columns: 1fr;
	}
	.checkout-right {
		position: static;
	}
}

@media ( max-width : 600px) {
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

		<h1>Checkout</h1>

		<a href="<%=request.getContextPath()%>/cart" class="back-button">

			← Back to Cart </a>

	</div>


	<%
	Cart cart = (Cart) session.getAttribute("cart");
	User user = (User) session.getAttribute("loggedInUser");
	
	
	String pendingFullName =
	    (String) session.getAttribute("pendingFullName");

	String pendingPhone =
	    (String) session.getAttribute("pendingPhone");

	String pendingAddress =
	    (String) session.getAttribute("pendingAddress");
	

	if (cart == null || cart.getItems().isEmpty()) {

		response.sendRedirect(request.getContextPath() + "/cart");

		return;
	}
	%>


	<!-- =========================================
     MAIN CHECKOUT FORM
     ========================================= -->

	<form action="<%=request.getContextPath()%>/placeOrder" method="post">


		<div class="checkout-container">


			<!-- =========================
         LEFT SIDE
         ========================= -->

			<div class="checkout-left">


				<!-- =====================
             DELIVERY ADDRESS
             ===================== -->

				<div class="card">

					<h2>Delivery Address</h2>


					<div class="form-group">

						<label> Full Name </label> <input type="text" name="fullName"
							placeholder="Enter your full name" required>

					</div>


					<div class="form-group">

						<label> Phone Number </label> <input type="tel" name="phone"
							placeholder="Enter your phone number" required>

					</div>


					<div class="form-group">

						<label> Delivery Address </label>

						<textarea name="address" required><%=user != null && user.getAddress() != null ? user.getAddress() : ""%></textarea>

					</div>

				</div>



				<!-- =====================
             PAYMENT METHOD
             ===================== -->

				<div class="card">

					<h2>Payment Method</h2>


					<label class="payment-option"> <input type="radio"
						name="paymentMode" value="COD" checked> <span> 💵
							Cash on Delivery </span>

					</label> <label class="payment-option"> <input type="radio"
						name="paymentMode" value="UPI"> <span> 📱 UPI </span>

					</label> <label class="payment-option"> <input type="radio"
						name="paymentMode" value="CARD"> <span> 💳 Credit /
							Debit Card </span>

					</label>

				</div>

			</div>



			<!-- =========================
         RIGHT SIDE
         ========================= -->

			<div class="checkout-right">

				<div class="card">

					<h2>Your Order</h2>


					<%
					for (Map.Entry<Integer, CartItem> entry : cart.getItems().entrySet()) {

						CartItem cartItem = entry.getValue();

						Menu menu = cartItem.getMenu();

						String imagePath = menu.getImagepath();

						if (imagePath == null || imagePath.trim().isEmpty()) {

							imagePath = "https://placehold.co/300x200?text=Food";
						}
					%>


					<div class="order-item">


						<img src="<%=imagePath%>" alt="<%=menu.getFoodname()%>"
							onerror="this.src='https://placehold.co/300x200?text=Food';">


						<div class="order-item-details">

							<h3>

								<%=menu.getFoodname()%>

							</h3>


							<p>

								₹<%=menu.getPrice()%>

								×

								<%=cartItem.getQuantity()%>

							</p>

						</div>


						<div class="order-item-price">

							₹<%=cartItem.getTotal()%>

						</div>


					</div>


					<%
					}
					%>


					<!-- =================
                 PRICE SUMMARY
                 ================= -->


					<div class="summary-row">

						<span> Item Total </span> <span> ₹<%=cart.getTotal()%>

						</span>

					</div>


					<div class="summary-row">

						<span> Delivery Fee </span> <span> ₹40 </span>

					</div>


					<div class="summary-row total-row">

						<span> Grand Total </span> <span> ₹<%=cart.getTotal() + 40%>

						</span>

					</div>



					<!-- =================
                 PLACE ORDER
                 ================= -->

					<input type="hidden" name="totalAmount"
						value="<%=cart.getTotal() + 40%>">


					<button type="submit" class="place-order-button">Place
						Order</button>


				</div>

			</div>


		</div>

	</form>


</body>

</html>

