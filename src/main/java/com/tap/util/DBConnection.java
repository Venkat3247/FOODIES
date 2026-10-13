package com.tap.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    static String url = "jdbc:mysql://localhost:3306/foodies";
    static String name = "root";
    static String password = "root";

    public static Connection getConnection() {

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection con = DriverManager.getConnection(url, name, password);

            System.out.println("DATABASE CONNECTED");

            return con;

        } catch (ClassNotFoundException e) {
            System.out.println("DRIVER NOT FOUND");
            e.printStackTrace();

        } catch (SQLException e) {
            System.out.println("DATABASE CONNECTION FAILED");
            System.out.println("Message: " + e.getMessage());
            System.out.println("SQL State: " + e.getSQLState());
            System.out.println("Error Code: " + e.getErrorCode());
            e.printStackTrace();
        }

        return null;
    }
}
	 