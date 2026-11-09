
package com.tap.controller;

import java.io.IOException;
import java.util.List;

import com.tap.Daoimplement.OrderImp;
import com.tap.model.Orders;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/adminOrders")
public class AdminOrdersController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        // Allow only logged-in admins
        if (request.getSession().getAttribute("adminId") == null) {
            response.sendRedirect(
                request.getContextPath() + "/adminLogin.jsp");
            return;
        }

        try {
            OrderImp orderImp = new OrderImp();

            List<Orders> allOrders = orderImp.getAllOrders();

            request.setAttribute("allOrders", allOrders);

            request.getRequestDispatcher("/adminOrders.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            throw new ServletException(
                "Unable to load admin orders", e);
        }
    }
}
