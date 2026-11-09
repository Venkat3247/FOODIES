<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    // Prevent browser from showing cached admin pages
    response.setHeader("Cache-Control",
            "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    // Destroy admin session
    session.invalidate();

    // Redirect to admin login
    response.sendRedirect(
            request.getContextPath() + "/adminLogin.jsp");

    return;
%>