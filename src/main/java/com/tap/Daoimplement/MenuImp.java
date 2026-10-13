package com.tap.Daoimplement;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.tap.Dao.MenuDao;
import com.tap.model.Menu;
import com.tap.util.DBConnection;

public class MenuImp implements MenuDao {

    private String insert =
            "INSERT INTO menu(resturantid, foodname, available, description, price, rating, imagepath) "
            + "VALUES (?, ?, ?, ?, ?, ?, ?)";

    private String getOne =
            "SELECT * FROM menu WHERE menuid = ?";

    private String update =
            "UPDATE menu SET resturantid = ?, foodname = ?, available = ?, "
            + "description = ?, price = ?, rating = ?, imagepath = ? "
            + "WHERE menuid = ?";

    private String delete =
            "DELETE FROM menu WHERE menuid = ?";

    private String getAll =
            "SELECT * FROM menu";

private String getByRestaurant =
        "SELECT * FROM menu WHERE resturantid = ?";

    @Override
    public void addMenu(Menu menu) {

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(insert)) {

            pstmt.setInt(1, menu.getResturantid());
            pstmt.setString(2, menu.getFoodname());
            pstmt.setString(3, menu.getAvailable());
            pstmt.setString(4, menu.getDescription());
            pstmt.setInt(5, menu.getPrice());
            pstmt.setInt(6, menu.getRating());
            pstmt.setString(7, menu.getImagepath());

            pstmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public Menu getMenu(int menuid) {

        Menu menu = null;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(getOne)) {

            pstmt.setInt(1, menuid);

            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {

                menu = new Menu();

                menu.setMenuid(rs.getInt("menuid"));
                menu.setResturantid(rs.getInt("resturantid"));
                menu.setFoodname(rs.getString("foodname"));
                menu.setAvailable(rs.getString("available"));
                menu.setDescription(rs.getString("description"));
                menu.setPrice(rs.getInt("price"));
                menu.setRating(rs.getInt("rating"));
                menu.setImagepath(rs.getString("imagepath"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return menu;
    }

    @Override
    public void updateMenu(Menu menu) {

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(update)) {

            pstmt.setInt(1, menu.getResturantid());
            pstmt.setString(2, menu.getFoodname());
            pstmt.setString(3, menu.getAvailable());
            pstmt.setString(4, menu.getDescription());
            pstmt.setInt(5, menu.getPrice());
            pstmt.setInt(6, menu.getRating());
            pstmt.setString(7, menu.getImagepath());
            pstmt.setInt(8, menu.getMenuid());

            pstmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteMenu(int menuid) {

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(delete)) {

            pstmt.setInt(1, menuid);

            pstmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<Menu> getAllMenu() {

        List<Menu> list = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(getAll)) {

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {

                Menu menu = new Menu();

                menu.setMenuid(rs.getInt("menuid"));
                menu.setResturantid(rs.getInt("resturantid"));
                menu.setFoodname(rs.getString("foodname"));
                menu.setAvailable(rs.getString("available"));
                menu.setDescription(rs.getString("description"));
                menu.setPrice(rs.getInt("price"));
                menu.setRating(rs.getInt("rating"));
                menu.setImagepath(rs.getString("imagepath"));

                list.add(menu);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

	@Override
	public List<Menu> getMenuByResturant(int Resturantid) {

	    List<Menu> list = new ArrayList<>();

	    try (Connection con = DBConnection.getConnection();
	         PreparedStatement pstmt = con.prepareStatement(getByRestaurant)) {

	        pstmt.setInt(1, Resturantid);

	        ResultSet rs = pstmt.executeQuery();

	        while (rs.next()) {

	            Menu menu = new Menu();

	            menu.setMenuid(rs.getInt("menuid"));
	            menu.setResturantid(rs.getInt("resturantid"));
	            menu.setFoodname(rs.getString("foodname"));
	            menu.setAvailable(rs.getString("available"));
	            menu.setDescription(rs.getString("description"));
	            menu.setPrice(rs.getInt("price"));
	            menu.setRating(rs.getInt("rating"));
	            menu.setImagepath(rs.getString("imagepath"));

	            list.add(menu);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return list;
	}

	
}
