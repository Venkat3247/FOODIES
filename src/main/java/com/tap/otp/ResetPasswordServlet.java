
package com.tap.otp;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import com.tap.util.DBConnection;
import org.mindrot.jbcrypt.BCrypt;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/reset-password")
public class ResetPasswordServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
            !Boolean.TRUE.equals(session.getAttribute("otpVerified"))) {

            response.sendRedirect("forgotPassword.jsp");
            return;
        }

        String email = (String) session.getAttribute("resetEmail");

        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        if (email == null || password == null || confirmPassword == null) {
            response.sendError(400, "Invalid request");
            return;
        }

        if (password.length() < 8 || password.length() > 72) {
            response.getWriter().println(
                "Password must contain 8 to 72 characters.");
            return;
        }

        if (!password.equals(confirmPassword)) {
            response.getWriter().println("Passwords do not match!");
            return;
        }

        String hashedPassword = BCrypt.hashpw(
                password, BCrypt.gensalt(12));

        String sql = "UPDATE `user` SET password = ? WHERE email = ?";

        try (Connection con = DBConnection.getConnection()) {

            if (con == null) {
                response.sendError(500, "Database connection failed");
                return;
            }

            try (PreparedStatement ps = con.prepareStatement(sql)) {

                ps.setString(1, hashedPassword);
                ps.setString(2, email);

                int result = ps.executeUpdate();

                if (result == 1) {

                    session.removeAttribute("otpVerified");
                    session.removeAttribute("resetEmail");
                    session.invalidate();

                    response.sendRedirect("login.html?reset=success");

                } else {
                    response.getWriter().println(
                        "Password update failed. Check your registered email.");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Unable to reset password");
        }
    }
}
