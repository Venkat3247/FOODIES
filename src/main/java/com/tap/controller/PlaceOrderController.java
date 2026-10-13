package com.tap.controller;

import java.io.IOException;
import java.util.Map;

import com.tap.Daoimplement.OrderImp;
import com.tap.Daoimplement.OrderitemImp;
import com.tap.model.Cart;
import com.tap.model.CartItem;
import com.tap.model.Menu;
import com.tap.model.Orderitem;
import com.tap.model.Orders;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/placeOrder")
public class PlaceOrderController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req,
                           HttpServletResponse resp)
            throws ServletException, IOException {

        System.out.println("================================");
        System.out.println("PLACE ORDER CONTROLLER");
        System.out.println("================================");

        HttpSession session = req.getSession();

        // =========================
        // CHECK LOGIN
        // =========================
  
     // CHECK LOGIN AND PRESERVE CHECKOUT DETAILS

     User user = (User) session.getAttribute("loggedInUser");

     if (user == null) {

         // Save the details entered on Checkout.jsp
         String fullName = req.getParameter("fullName");
         String phone = req.getParameter("phone");
         String address = req.getParameter("address");

         session.setAttribute("pendingFullName",
                 fullName == null ? "" : fullName);

         session.setAttribute("pendingPhone",
                 phone == null ? "" : phone);

         session.setAttribute("pendingAddress",
                 address == null ? "" : address);

         // Return to checkout after login
         session.setAttribute("checkoutRedirect", "/checkout");

         resp.sendRedirect(req.getContextPath() + "/login.html");
         return;
     }
     

        // =========================
        // GET CART
        // =========================

        Cart cart = (Cart) session.getAttribute("cart");

        if (cart == null || cart.getItems().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        // =========================
        // GET TOTAL AMOUNT
        // =========================

        String totalAmountParameter = req.getParameter("totalAmount");

        int totalAmount;

        try {
            totalAmount = (int) Double.parseDouble(totalAmountParameter);
        } catch (Exception e) {
            totalAmount = (int) cart.getTotal() + 40;
        }

        System.out.println("USER ID = " + user.getUserid());
        System.out.println("TOTAL AMOUNT = " + totalAmount);

        // =========================
        // GET RESTAURANT ID
        // =========================

        int restaurantId = 0;

        for (Map.Entry<Integer, CartItem> entry
                : cart.getItems().entrySet()) {

            CartItem cartItem = entry.getValue();

            Menu menu = cartItem.getMenu();

            if (menu != null) {
                restaurantId = menu.getResturantid();
                break;
            }
        }

        if (restaurantId == 0) {
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        System.out.println("RESTAURANT ID = " + restaurantId);

        // =========================
        // PAYMENT MODE
        // =========================

        String paymentMode = req.getParameter("paymentMode");

        double paymentModeValue = 0;

        if ("COD".equalsIgnoreCase(paymentMode)) {
            paymentModeValue = 1;
        } else if ("UPI".equalsIgnoreCase(paymentMode)) {
            paymentModeValue = 2;
        } else if ("CARD".equalsIgnoreCase(paymentMode)) {
            paymentModeValue = 3;
        }

        System.out.println("PAYMENT MODE = " + paymentMode);

        // =========================
        // CREATE ORDER
        // =========================

        Orders orders = new Orders(
            user.getUserid(),
            restaurantId,
            totalAmount,
            "Placed",
            (int) (System.currentTimeMillis() / 1000),
            paymentModeValue
        );

        // =========================
        // SAVE ORDER
        // =========================

        OrderImp orderImp = new OrderImp();

        int orderId = orderImp.addOrders(orders);

        System.out.println("GENERATED ORDER ID = " + orderId);

        // =========================
        // ORDER FAILED
        // =========================

        if (orderId == 0) {

            resp.setContentType("text/html;charset=UTF-8");

            resp.getWriter().println(
                "<!DOCTYPE html>"
                + "<html>"
                + "<head>"
                + "<meta charset='UTF-8'>"
                + "<title>Order Failed</title>"
                + "<style>"
                + "body{"
                + "font-family:Arial,sans-serif;"
                + "background:#FBF1E1;"
                + "text-align:center;"
                + "padding-top:100px;"
                + "}"
                + ".box{"
                + "background:white;"
                + "width:450px;"
                + "margin:auto;"
                + "padding:40px;"
                + "border-radius:15px;"
                + "box-shadow:0 5px 20px rgba(0,0,0,0.15);"
                + "}"
                + "h1{color:#b52b2b;}"
                + "</style>"
                + "</head>"
                + "<body>"
                + "<div class='box'>"
                + "<h1>Order Could Not Be Placed</h1>"
                + "<p>Please check the server console and try again.</p>"
                + "</div>"
                + "</body>"
                + "</html>"
            );

            return;
        }

        // =========================
        // SAVE ORDER ITEMS
        // =========================

        OrderitemImp orderitemImp = new OrderitemImp();

        for (Map.Entry<Integer, CartItem> entry
                : cart.getItems().entrySet()) {

            CartItem cartItem = entry.getValue();

            Menu menu = cartItem.getMenu();

            if (menu != null) {

                Orderitem orderitem = new Orderitem(
                    0,
                    orderId,
                    menu.getMenuid(),
                    cartItem.getQuantity(),
                    menu.getPrice()
                );

                orderitemImp.addOrderitem(orderitem);
            }
        }

        // =========================
        // CLEAR CART
        // =========================

        cart.clearCart();

        session.setAttribute("lastOrderId", orderId);

        // =========================
        // SUCCESS PAGE
        // =========================

        resp.setContentType("text/html;charset=UTF-8");

        resp.getWriter().println(

            "<!DOCTYPE html>"

            + "<html>"

            + "<head>"

            + "<meta charset='UTF-8'>"

            + "<meta name='viewport' "
            + "content='width=device-width, initial-scale=1.0'>"

            + "<title>Order Successful - Foodies</title>"

            // =========================
            // LOTTIE PLAYER
            // =========================

            + "<script "
            + "src='https://unpkg.com/@lottiefiles/lottie-player@latest/dist/lottie-player.js'>"
            + "</script>"

            + "<style>"

            + "*{"
            + "box-sizing:border-box;"
            + "}"

            + "body{"
            + "margin:0;"
            + "font-family:Arial,sans-serif;"
            + "background:#FBF1E1;"
            + "min-height:100vh;"
            + "display:flex;"
            + "align-items:center;"
            + "justify-content:center;"
            + "padding:30px;"
            + "}"

            + ".box{"
            + "background:#ffffff;"
            + "width:100%;"
            + "max-width:520px;"
            + "padding:25px 40px 40px;"
            + "border-radius:20px;"
            + "text-align:center;"
            + "box-shadow:0 8px 30px rgba(0,0,0,0.12);"
            + "}"

            + ".animation{"
            + "width:600px;"
            + "height:400px;"
            + "margin:0 auto 0;"
            + "}"

            + "h1{"
            + "color:#174A3A;"
            + "font-size:30px;"
            + "margin:0 0 12px;"
            + "}"

            + ".message{"
            + "color:#666666;"
            + "font-size:16px;"
            + "margin-bottom:20px;"
            + "}"

            + ".order-id{"
            + "font-size:21px;"
            + "font-weight:bold;"
            + "color:#B8872D;"
            + "margin:10px 0;"
            + "}"

            + ".total{"
            + "font-size:18px;"
            + "font-weight:bold;"
            + "color:#174A3A;"
            + "margin-bottom:28px;"
            + "}"

            + ".buttons{"
            + "display:flex;"
            + "gap:12px;"
            + "justify-content:center;"
            + "flex-wrap:wrap;"
            + "}"

            + ".btn{"
            + "display:inline-block;"
            + "text-decoration:none;"
            + "padding:13px 20px;"
            + "border-radius:8px;"
            + "font-size:15px;"
            + "font-weight:700;"
            + "transition:0.2s ease;"
            + "}"

            + ".order-again{"
            + "background:#174A3A;"
            + "color:white;"
            + "}"

            + ".order-again:hover{"
            + "background:#0f382c;"
            + "}"

            + ".my-orders{"
            + "background:#D6A84F;"
            + "color:#174A3A;"
            + "}"

            + ".my-orders:hover{"
            + "background:#c99b3e;"
            + "}"

            + "@media(max-width:600px){"

            + ".box{"
            + "padding:20px 20px 30px;"
            + "}"

            + ".animation{"
            + "width:180px;"
            + "height:180px;"
            + "}"

            + "h1{"
            + "font-size:25px;"
            + "}"

            + ".btn{"
            + "width:100%;"
            + "}"

            + "}"

            + "</style>"

            + "</head>"

            + "<body>"

            + "<div class='box'>"

            // =========================
            // LOTTIE ANIMATION
            // =========================

            + "<div class='animation'>"

            + "<lottie-player "
            + "src='https://lottie.host/52326421-6afc-4fec-aa03-9c2e09cde085/6Lsffe781v.json' "
            + "background='transparent' "
            + "speed='1' "
            + "style='width:600px;height:400px;' "
            + "loop "
            + "autoplay>"
            + "</lottie-player>"

            + "</div>"

            // =========================
            // SUCCESS MESSAGE
            // =========================

            + "<h1>Order Placed Successfully! 🎉</h1>"

            + "<p class='message'>"
            + "Your delicious food is on the way!"
            + "</p>"

            + "<p class='order-id'>"
            + "Order ID: " + orderId
            + "</p>"

            + "<p class='total'>"
            + "Total Amount: ₹" + totalAmount
            + "</p>"

            // =========================
            // BUTTONS
            // =========================

            + "<div class='buttons'>"

            + "<a class='btn order-again' "
            + "href='" + req.getContextPath() + "/resturant'>"
            + "🍴 Order Food Again"
            + "</a>"

            + "<a class='btn my-orders' "
            + "href='" + req.getContextPath() + "/myOrders'>"
            + "📦 My Orders"
            + "</a>"

            + "</div>"

            + "</div>"

            + "</body>"

            + "</html>"
        );
    }
}