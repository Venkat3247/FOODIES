package com.tap.controller;

import java.io.IOException;

import com.tap.Daoimplement.UserDaoImp;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/signup")
public class SignupController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req,
                           HttpServletResponse resp)
            throws ServletException, IOException {

        System.out.println("================================");
        System.out.println("SIGNUP CONTROLLER");
        System.out.println("================================");

        String name = req.getParameter("name");
        String username = req.getParameter("username");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String phoneParameter = req.getParameter("phone");
        String address = req.getParameter("address");

        System.out.println("NAME = " + name);
        System.out.println("USERNAME = " + username);
        System.out.println("EMAIL = " + email);

        if (name == null || name.trim().isEmpty()
                || username == null || username.trim().isEmpty()
                || email == null || email.trim().isEmpty()
                || password == null || password.trim().isEmpty()
                || phoneParameter == null || phoneParameter.trim().isEmpty()
                || address == null || address.trim().isEmpty()) {

            resp.sendRedirect(req.getContextPath() + "/signup.html");
            return;
        }

        long phone;

        try {
            phone = Long.parseLong(phoneParameter.trim());
        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/signup.html");
            return;
        }

        User user = new User(
            name.trim(),
            username.trim(),
            email.trim(),
            password.trim(),
            phone,
            address.trim(),
            "customer"
        );

        UserDaoImp userDao = new UserDaoImp();

        userDao.adduser(user);

        System.out.println("USER SIGNUP COMPLETED");

        resp.sendRedirect(req.getContextPath() + "/login.html");
    }
}