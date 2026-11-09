
package com.tap.controller;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.Scanner;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.tap.Daoimplement.UserDaoImp;
import com.tap.model.User;

@WebServlet("/googleLogin")
public class GoogleLoginController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private static final String CLIENT_ID =
        "936389627472-9qnv2b0i1e84orbr3c61uf083ht3cp4s.apps.googleusercontent.com";

    private String getValue(String json, String key) {
        Pattern pattern = Pattern.compile(
            "\"" + key + "\"\\s*:\\s*\"?([^\",}]+)\"?"
        );

        Matcher matcher = pattern.matcher(json);

        return matcher.find() ? matcher.group(1).trim() : null;
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String credential = request.getParameter("credential");

        if (credential == null || credential.isBlank()) {
            response.setStatus(400);
            response.getWriter().write("{\"success\":false}");
            return;
        }

        String json;

        try {
            String token = URLEncoder.encode(
                credential, StandardCharsets.UTF_8);

            URL url = new URL(
                "https://oauth2.googleapis.com/tokeninfo?id_token=" + token);

            HttpURLConnection connection =
                (HttpURLConnection) url.openConnection();

            connection.setRequestMethod("GET");
            connection.setConnectTimeout(10000);
            connection.setReadTimeout(10000);

            try {
                if (connection.getResponseCode() != 200) {
                    response.setStatus(401);
                    response.getWriter().write("{\"success\":false}");
                    return;
                }

                try (Scanner scanner = new Scanner(
                        connection.getInputStream(), StandardCharsets.UTF_8)) {
                    json = scanner.useDelimiter("\\A").next();
                }
            } finally {
                connection.disconnect();
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(401);
            response.getWriter().write("{\"success\":false}");
            return;
        }

        String audience = getValue(json, "aud");
        String email = getValue(json, "email");
        String verified = getValue(json, "email_verified");
        String expiry = getValue(json, "exp");
        String issuer = getValue(json, "iss");

        boolean valid = false;

        try {
            valid = CLIENT_ID.equals(audience)
                && email != null
                && "true".equalsIgnoreCase(verified)
                && expiry != null
                && Long.parseLong(expiry) >
                   System.currentTimeMillis() / 1000
                && ("accounts.google.com".equals(issuer)
                    || "https://accounts.google.com".equals(issuer));
        } catch (NumberFormatException e) {
            valid = false;
        }

        if (!valid) {
            response.setStatus(401);
            response.getWriter().write("{\"success\":false}");
            return;
        }

        UserDaoImp dao = new UserDaoImp();
        User user = dao.getUserByEmail(email);

        if (user == null) {
            response.setStatus(404);
            response.getWriter().write("{\"success\":false,\"message\":\"Please register first\"}");
            return;
        }

        HttpSession session = request.getSession();
        session.setAttribute("loggedInUser", user);

        String redirectUrl =
            (String) session.getAttribute("checkoutRedirect");

        if (redirectUrl != null) {
            session.removeAttribute("checkoutRedirect");
            session.setAttribute("googleRedirect",
                request.getContextPath() + redirectUrl);
        } else {
            session.setAttribute("googleRedirect",
                request.getContextPath() + "/Checkout.jsp");
        }

        response.getWriter().write("{\"success\":true}");
    }
}
