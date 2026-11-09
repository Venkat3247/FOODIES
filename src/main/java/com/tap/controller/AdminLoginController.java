
package com.tap.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.mindrot.jbcrypt.BCrypt;

import com.tap.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/adminLogin")
public class AdminLoginController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || password == null
                || email.trim().isEmpty() || password.isEmpty()) {

            response.sendRedirect(
                request.getContextPath() + "/adminLogin.jsp?error=1");
            return;
        }

        String sql = "SELECT userid, username, role, password "
                   + "FROM `user` WHERE email = ? AND role = 'admin'";

        boolean isValid = false;
        int adminId = 0;
        String adminUsername = null;

        try (Connection con = DBConnection.getConnection()) {

            if (con == null) {
                throw new ServletException("Database connection failed.");
            }

            try (PreparedStatement ps = con.prepareStatement(sql)) {

                ps.setString(1, email.trim());

                try (ResultSet rs = ps.executeQuery()) {

                    while (rs.next()) {

                        String storedPassword = rs.getString("password");

                        try {
                            if (storedPassword != null
                                    && BCrypt.checkpw(password, storedPassword)) {

                                isValid = true;
                                adminId = rs.getInt("userid");
                                adminUsername = rs.getString("username");
                                break;
                            }

                        } catch (IllegalArgumentException e) {
                            // Invalid password hash
                        }
                    }
                }
            }

            if (isValid) {

                HttpSession session = request.getSession(true);
                request.changeSessionId();

                session.setAttribute("adminId", adminId);
                session.setAttribute("adminUsername", adminUsername);
                session.setAttribute("adminRole", "admin");

                response.sendRedirect(
                    request.getContextPath() + "/adminDashboard.jsp");

            } else {

                response.sendRedirect(
                    request.getContextPath() + "/adminLogin.jsp?error=1");
            }

        } catch (Exception e) {
            throw new ServletException("Admin login failed.", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        response.sendRedirect(
            request.getContextPath() + "/adminLogin.jsp");
    }
}
