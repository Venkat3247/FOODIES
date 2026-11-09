
package com.tap.otp;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/verify-otp")
public class VerifyOTPServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null) {
            response.sendRedirect("forgotPassword.jsp");
            return;
        }

        String enteredOTP = request.getParameter("otp");
        String savedOTP = (String) session.getAttribute("resetOTP");

        Long expiry = (Long) session.getAttribute("otpExpiry");

        if (savedOTP == null || expiry == null) {
            response.getWriter().println("OTP session expired. Request a new OTP.");
            return;
        }

        if (System.currentTimeMillis() > expiry) {
            session.removeAttribute("resetOTP");
            session.removeAttribute("otpExpiry");

            response.getWriter().println("OTP expired. Request a new OTP.");
            return;
        }

        if (savedOTP.equals(enteredOTP)) {

            session.setAttribute("otpVerified", true);

            session.removeAttribute("resetOTP");
            session.removeAttribute("otpExpiry");

            response.sendRedirect("resetPassword.jsp");

        } else {
            response.getWriter().println("Invalid OTP. Please try again.");
        }
    }
}
