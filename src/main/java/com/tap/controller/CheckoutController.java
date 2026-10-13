
package com.tap.controller;

import java.io.IOException;

import com.tap.model.Cart;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/checkout")
public class CheckoutController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req,
                         HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();

        Cart cart = (Cart) session.getAttribute("cart");

        if (cart == null || cart.getItems().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        User user = (User) session.getAttribute("loggedInUser");

        // If the customer is not logged in, remember the checkout URL.
        if (user == null) {
            session.setAttribute("checkoutRedirect", "/checkout");

            resp.sendRedirect(req.getContextPath() + "/login.html");
            return;
        }

        req.setAttribute("cart", cart);
        req.setAttribute("user", user);

        req.getRequestDispatcher("/Checkout.jsp")
           .forward(req, resp);
    }
}
