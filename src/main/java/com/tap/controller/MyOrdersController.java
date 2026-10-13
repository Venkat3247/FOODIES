package com.tap.controller;

import java.io.IOException;
import java.util.List;

import com.tap.Daoimplement.OrderImp;
import com.tap.model.Orders;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/myOrders")
public class MyOrdersController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req,
                          HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();

        User user = (User) session.getAttribute("loggedInUser");

        if (user == null) {
            resp.sendRedirect(
                req.getContextPath() + "/login.html"
            );
            return;
        }

        OrderImp orderImp = new OrderImp();

        List<Orders> orders =
                orderImp.getOrdersByUserid(user.getUserid());

        req.setAttribute("orders", orders);

        req.getRequestDispatcher("/MyOrders.jsp")
           .forward(req, resp);
    }
}