package com.tap.controller;

import java.io.IOException;
import java.util.List;

import com.tap.Daoimplement.MenuImp;
import com.tap.model.Menu;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/menu")
public class Menucontroller extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req,
                          HttpServletResponse resp)
            throws ServletException, IOException {

        String id = req.getParameter("resturantId");

        System.out.println("Restaurant ID = " + id);

        // Check whether restaurant ID is present
        if (id == null || id.trim().isEmpty()) {

            resp.sendRedirect(
                req.getContextPath() + "/resturant"
            );

            return;
        }

        int resturantId;

        // Convert restaurant ID to integer
        try {

            resturantId = Integer.parseInt(id);

        } catch (NumberFormatException e) {

            resp.sendRedirect(
                req.getContextPath() + "/resturant"
            );

            return;
        }

        // Create Menu DAO implementation
        MenuImp menuimp = new MenuImp();

        // Get menu items for selected restaurant
        List<Menu> menulist =
                menuimp.getMenuByResturant(resturantId);

        System.out.println(
            "Menu List Size = " + menulist.size()
        );

        // Send menu list to JSP
        req.setAttribute(
            "allmenu",
            menulist
        );

        // Open Menu JSP
        req.getRequestDispatcher(
            "/Menu.jsp"
        ).forward(req, resp);
    }
}