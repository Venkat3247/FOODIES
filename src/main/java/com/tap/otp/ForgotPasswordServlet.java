
package com.tap.otp;

import java.io.IOException;
import java.security.SecureRandom;

import com.tap.otp.util.EmailUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/forgot-password")
public class ForgotPasswordServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");

        try {
            // Generate 6-digit OTP
            String otp = String.format("%06d",
                    new SecureRandom().nextInt(1000000));

            // Send OTP to email
            EmailUtil.sendOTP(email, otp);

            // Store OTP in session
            HttpSession session = request.getSession();
            session.setAttribute("resetOTP", otp);
            session.setAttribute("resetEmail", email);
            session.setAttribute("otpExpiry",
                    System.currentTimeMillis() + (5 * 60 * 1000));

            response.sendRedirect("verifyOTP.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Unable to send OTP. Please try again.");
        }
    }
}
