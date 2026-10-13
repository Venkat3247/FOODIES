
package com.tap.controller;

import java.io.IOException;

import com.tap.Daoimplement.UserDaoImp;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req,
                         HttpServletResponse resp)
            throws ServletException, IOException {

        resp.sendRedirect(req.getContextPath() + "/login.html");
    }

    @Override
    protected void doPost(HttpServletRequest req,
                          HttpServletResponse resp)
            throws ServletException, IOException {

        String email = req.getParameter("email");
        String password = req.getParameter("password");

        UserDaoImp dao = new UserDaoImp();
        User user = dao.getUserByEmailAndPassword(email, password);

        if (user != null) {

            HttpSession session = req.getSession();

            session.setAttribute("loggedInUser", user);

            // Restore checkout after login
            String redirectUrl =
                    (String) session.getAttribute("checkoutRedirect");

            if (redirectUrl != null) {
                session.removeAttribute("checkoutRedirect");
                resp.sendRedirect(req.getContextPath() + redirectUrl);
            } else {
                resp.sendRedirect(req.getContextPath() + "/Checkout.jsp");
            }

        } else {
            resp.sendRedirect(req.getContextPath() + "/login.html");
        }
    }
}
