
package com.tap.controller;

import java.io.IOException;

import org.mindrot.jbcrypt.BCrypt;

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

        String name = req.getParameter("name");
        String username = req.getParameter("username");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String phoneParameter = req.getParameter("phone");
        String address = req.getParameter("address");

        // Check required fields
        if (name == null || name.trim().isEmpty()
                || username == null || username.trim().isEmpty()
                || email == null || email.trim().isEmpty()
                || password == null || password.isEmpty()
                || phoneParameter == null || phoneParameter.trim().isEmpty()
                || address == null || address.trim().isEmpty()) {

            resp.sendRedirect(req.getContextPath()
                    + "/signup.html?error=empty");
            return;
        }

        name = name.trim();
        username = username.trim();
        email = email.trim();
        address = address.trim();
        phoneParameter = phoneParameter.trim();

        // Password validation
        if (password.length() < 8) {
            resp.sendRedirect(req.getContextPath()
                    + "/signup.html?error=password");
            return;
        }

        // Phone validation: exactly 10 digits
        if (!phoneParameter.matches("[0-9]{10}")) {
            resp.sendRedirect(req.getContextPath()
                    + "/signup.html?error=phone");
            return;
        }

        long phone = Long.parseLong(phoneParameter);

        UserDaoImp userDao = new UserDaoImp();

        // Check duplicate email
        User existingUser = userDao.getUserByEmail(email);

        if (existingUser != null) {
            resp.sendRedirect(req.getContextPath()
                    + "/signup.html?error=email");
            return;
        }

        // Hash password using BCrypt
        String hashedPassword = BCrypt.hashpw(
                password,
                BCrypt.gensalt(12)
        );

        // Create user
        User user = new User(
                name,
                username,
                email,
                hashedPassword,
                phone,
                address,
                "customer"
        );

        userDao.adduser(user);

        // Signup successful
        resp.sendRedirect(req.getContextPath()
                + "/signup.html?success=1");
    }
}
