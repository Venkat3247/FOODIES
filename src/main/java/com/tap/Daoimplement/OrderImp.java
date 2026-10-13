package com.tap.Daoimplement;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.tap.Dao.OrdersDao;
import com.tap.model.Orders;
import com.tap.util.DBConnection;

public class OrderImp implements OrdersDao {

    private String insert =
            "INSERT INTO orders(userid, resturantid, totalamount, status, orderdate, paymentmode) "
            + "VALUES (?, ?, ?, ?, ?, ?)";

    private String getOne =
            "SELECT * FROM orders WHERE orderid = ?";

    private String update =
            "UPDATE orders SET userid = ?, resturantid = ?, totalamount = ?, "
            + "status = ?, orderdate = ?, paymentmode = ? WHERE orderid = ?";

    private String delete =
            "DELETE FROM orders WHERE orderid = ?";

    private String getAll =
            "SELECT * FROM orders";

    private String getByUserid =
            "SELECT * FROM orders WHERE userid = ?";

    @Override
    public int addOrders(Orders orders) {

        int generatedOrderId = 0;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt =
                     con.prepareStatement(insert, Statement.RETURN_GENERATED_KEYS)) {

            pstmt.setInt(1, orders.getUserid());
            pstmt.setInt(2, orders.getResturantid());
            pstmt.setInt(3, orders.getTotalamount());
            pstmt.setString(4, orders.getStatus());
            pstmt.setInt(5, orders.getOrderdate());
            pstmt.setDouble(6, orders.getPaymentmode());

            pstmt.executeUpdate();

            ResultSet rs = pstmt.getGeneratedKeys();

            if (rs.next()) {
                generatedOrderId = rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return generatedOrderId;
    }

    @Override
    public Orders getOrders(int orderid) {

        Orders orders = null;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(getOne)) {

            pstmt.setInt(1, orderid);

            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {

                orders = new Orders();

                orders.setOrderid(rs.getInt("orderid"));
                orders.setUserid(rs.getInt("userid"));
                orders.setResturantid(rs.getInt("resturantid"));
                orders.setTotalamount(rs.getInt("totalamount"));
                orders.setStatus(rs.getString("status"));
                orders.setOrderdate(rs.getInt("orderdate"));
                orders.setPaymentmode(rs.getDouble("paymentmode"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return orders;
    }

    @Override
    public void updateOrders(Orders orders) {

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(update)) {

            pstmt.setInt(1, orders.getUserid());
            pstmt.setInt(2, orders.getResturantid());
            pstmt.setInt(3, orders.getTotalamount());
            pstmt.setString(4, orders.getStatus());
            pstmt.setInt(5, orders.getOrderdate());
            pstmt.setDouble(6, orders.getPaymentmode());
            pstmt.setInt(7, orders.getOrderid());

            pstmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteOrders(int orderid) {

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(delete)) {

            pstmt.setInt(1, orderid);

            pstmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<Orders> getAllOrders() {

        List<Orders> list = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(getAll)) {

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {

                Orders orders = new Orders();

                orders.setOrderid(rs.getInt("orderid"));
                orders.setUserid(rs.getInt("userid"));
                orders.setResturantid(rs.getInt("resturantid"));
                orders.setTotalamount(rs.getInt("totalamount"));
                orders.setStatus(rs.getString("status"));
                orders.setOrderdate(rs.getInt("orderdate"));
                orders.setPaymentmode(rs.getDouble("paymentmode"));

                list.add(orders);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    @Override
    public List<Orders> getOrdersByUserid(int userid) {

        List<Orders> list = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(getByUserid)) {

            pstmt.setInt(1, userid);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {

                Orders orders = new Orders();

                orders.setOrderid(rs.getInt("orderid"));
                orders.setUserid(rs.getInt("userid"));
                orders.setResturantid(rs.getInt("resturantid"));
                orders.setTotalamount(rs.getInt("totalamount"));
                orders.setStatus(rs.getString("status"));
                orders.setOrderdate(rs.getInt("orderdate"));
                orders.setPaymentmode(rs.getDouble("paymentmode"));

                list.add(orders);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}