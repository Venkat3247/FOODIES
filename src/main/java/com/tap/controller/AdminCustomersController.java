
package com.tap.controller;

import java.io.IOException;
import java.util.List;

import com.tap.Daoimplement.UserDaoImp;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/adminCustomers")
public class AdminCustomersController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        // Check admin login
        if (request.getSession().getAttribute("adminId") == null) {
            response.sendRedirect(
                request.getContextPath() + "/adminLogin.jsp");
            return;
        }

        try {
            UserDaoImp userDao = new UserDaoImp();

            List<User> allUsers = userDao.getAlluser();

            // Show customers only, not admin accounts
            allUsers.removeIf(user ->
                !"customer".equalsIgnoreCase(user.getRole()));

            request.setAttribute("allCustomers", allUsers);

            request.getRequestDispatcher("/adminCustomers.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            throw new ServletException(
                "Unable to load customers", e);
        }
    }
}
