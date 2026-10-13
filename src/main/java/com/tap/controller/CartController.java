
package com.tap.controller;

import java.io.IOException;

import com.tap.Dao.MenuDao;
import com.tap.Daoimplement.MenuImp;
import com.tap.model.Cart;
import com.tap.model.Menu;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/cart")
public class CartController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req,
                          HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        HttpSession session = req.getSession();

        Cart cart = (Cart) session.getAttribute("cart");

        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }

        // ADD ITEM
        if ("add".equals(action)) {

            String menuIdParameter = req.getParameter("menuId");
            int menuId;

            try {
                menuId = Integer.parseInt(menuIdParameter);
            } catch (Exception e) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST,
                        "Invalid menu ID");
                return;
            }

            MenuDao menuDao = new MenuImp();
            Menu menu = menuDao.getMenu(menuId);

            if (menu == null) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND,
                        "Menu item not found");
                return;
            }

            if (menu.getAvailable() == null
                    || !menu.getAvailable().equalsIgnoreCase("yes")) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST,
                        "Menu item is unavailable");
                return;
            }

            boolean added = cart.addItem(menu);

            if (!added) {
                session.setAttribute(
                    "cartError",
                    "You can only add items from one restaurant at a time."
                );

                resp.sendError(HttpServletResponse.SC_CONFLICT,
                        "You can only add items from one restaurant at a time.");
                return;
            }

            session.setAttribute("cart", cart);

            resp.setContentType("text/plain;charset=UTF-8");
            resp.setStatus(HttpServletResponse.SC_OK);
            resp.getWriter().print(cart.getTotalItems());
            return;
        }

        // PLUS
        if ("plus".equals(action)) {
            updateQuantity(req, resp, cart, true);
            return;
        }

        // MINUS
        if ("minus".equals(action)) {
            updateQuantity(req, resp, cart, false);
            return;
        }

        // REMOVE ITEM
        if ("remove".equals(action)) {
            try {
                int menuId = Integer.parseInt(req.getParameter("menuId"));
                cart.removeItem(menuId);
                session.setAttribute("cart", cart);
                resp.sendRedirect(req.getContextPath() + "/cart");
            } catch (Exception e) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST,
                        "Invalid menu ID");
            }
            return;
        }

        // CLEAR CART
        if ("clear".equals(action)) {
            cart.clearCart();
            session.setAttribute("cart", cart);
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        resp.sendError(HttpServletResponse.SC_BAD_REQUEST,
                "Unknown cart action");
    }

    private void updateQuantity(HttpServletRequest req,
                                HttpServletResponse resp,
                                Cart cart,
                                boolean increase)
            throws IOException {

        try {
            int menuId = Integer.parseInt(req.getParameter("menuId"));

            if (increase) {
                cart.increaseQuantity(menuId);
            } else {
                cart.decreaseQuantity(menuId);
            }

            req.getSession().setAttribute("cart", cart);

            resp.setContentType("text/plain;charset=UTF-8");
            resp.getWriter().print(cart.getTotalItems());

        } catch (Exception e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid menu ID");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req,
                         HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();

        Object cartObject = session.getAttribute("cart");
        Cart cart;

        if (cartObject instanceof Cart) {
            cart = (Cart) cartObject;
        } else {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }

        // RETURN CART COUNT ONLY
        if ("count".equals(req.getParameter("action"))) {
            resp.setContentType("text/plain;charset=UTF-8");
            resp.setCharacterEncoding("UTF-8");
            resp.setHeader("Cache-Control", "no-store");
            resp.getWriter().print(cart.getTotalItems());
            return;
        }

        // NORMAL CART PAGE
        req.setAttribute("cart", cart);

        Object error = session.getAttribute("cartError");

        if (error != null) {
            req.setAttribute("cartError", error);
            session.removeAttribute("cartError");
        }

        req.getRequestDispatcher("/Cart.jsp").forward(req, resp);
    }
}
