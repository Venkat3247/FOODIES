package com.tap.Daoimplement;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.tap.Dao.OrderitemDao;
import com.tap.model.Orderitem;
import com.tap.util.DBConnection;

public class OrderitemImp implements OrderitemDao {

    private String insert =
            "INSERT INTO orderitem(orderid, menuid, quantity, price) VALUES (?, ?, ?, ?)";

    private String getOne =
            "SELECT * FROM orderitem WHERE orderitemid = ?";

    private String update =
            "UPDATE orderitem SET orderid = ?, menuid = ?, quantity = ?, price = ? "
            + "WHERE orderitemid = ?";

    private String delete =
            "DELETE FROM orderitem WHERE orderitemid = ?";

    private String getAll =
            "SELECT * FROM orderitem";
    private String OrderitemByOrder = "SELECT * FROM orderitem WHERE orderid = ?";

    @Override
    public void addOrderitem(Orderitem orderitem) {

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(insert)) {

            pstmt.setInt(1, orderitem.getOrderid());
            pstmt.setInt(2, orderitem.getMenuId());
            pstmt.setInt(3, orderitem.getQuantity());
            pstmt.setInt(4, orderitem.getPrice());

            pstmt.executeUpdate();

            System.out.println("Orderitem added successfully");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public Orderitem getOrderitem(int orderitemId) {

        Orderitem orderitem = null;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(getOne)) {

            pstmt.setInt(1, orderitemId);

            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {

                orderitem = new Orderitem();

                orderitem.setOrderitemId(rs.getInt("orderitemid"));
                orderitem.setOrderid(rs.getInt("orderid"));
                orderitem.setMenuId(rs.getInt("menuid"));
                orderitem.setQuantity(rs.getInt("quantity"));
                orderitem.setPrice(rs.getInt("price"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return orderitem;
    }

    @Override
    public void updateOrderitem(Orderitem orderitem) {

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(update)) {

            pstmt.setInt(1, orderitem.getOrderid());
            pstmt.setInt(2, orderitem.getMenuId());
            pstmt.setInt(3, orderitem.getQuantity());
            pstmt.setInt(4, orderitem.getPrice());
            pstmt.setInt(5, orderitem.getOrderitemId());

            pstmt.executeUpdate();

            System.out.println("Orderitem updated successfully");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteOrderitem(int orderitemId) {

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(delete)) {

            pstmt.setInt(1, orderitemId);

            pstmt.executeUpdate();

            System.out.println("Orderitem deleted successfully");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<Orderitem> getAllOrderitem() {

        List<Orderitem> list = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(getAll)) {

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {

                Orderitem orderitem = new Orderitem();

                orderitem.setOrderitemId(rs.getInt("orderitemid"));
                orderitem.setOrderid(rs.getInt("orderid"));
                orderitem.setMenuId(rs.getInt("menuid"));
                orderitem.setQuantity(rs.getInt("quantity"));
                orderitem.setPrice(rs.getInt("price"));

                list.add(orderitem);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    @Override
    public List<Orderitem> getOrderitemByOrder(int orderid) {

        List<Orderitem> list = new ArrayList<>();


        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(OrderitemByOrder)) {

            pstmt.setInt(1, orderid);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {

                Orderitem orderitem = new Orderitem();

                orderitem.setOrderitemId(rs.getInt("orderitemid"));
                orderitem.setOrderid(rs.getInt("orderid"));
                orderitem.setMenuId(rs.getInt("menuid"));
                orderitem.setQuantity(rs.getInt("quantity"));
                orderitem.setPrice(rs.getInt("price"));

                list.add(orderitem);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

}