package com.tap.controller;

import java.io.IOException;
import java.util.List;

import com.tap.Daoimplement.ResturantImp;
import com.tap.model.Resturant;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/resturant")
public class servletcontroller extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        System.out.println("Resturant servlet called");

        ResturantImp resturantImp = new ResturantImp();

        List<Resturant> allResturant =
                resturantImp.getAllResturant();

        System.out.println("Restaurant count = " + allResturant.size());

        req.setAttribute("allResturant", allResturant);

        RequestDispatcher rd =
                req.getRequestDispatcher("/resturant.jsp");

        rd.forward(req, resp);
    }
}