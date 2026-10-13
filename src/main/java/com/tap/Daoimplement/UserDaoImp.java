package com.tap.Daoimplement;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.tap.Dao.UserDao;
import com.tap.model.User;
import com.tap.util.DBConnection;

public class UserDaoImp implements UserDao {

    @Override
    public User getuser(int userId) {

        User user = null;

        String sql = "SELECT * FROM `user` WHERE userid=?";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement stmt = con.prepareStatement(sql)
        ) {

            stmt.setInt(1, userId);

            ResultSet res = stmt.executeQuery();

            if (res.next()) {

                int userid = res.getInt("userid");
                String name = res.getString("name");
                String username = res.getString("username");
                String email = res.getString("email");
                String password = res.getString("password");
                long phone = res.getLong("phone");
                String address = res.getString("address");
                String role = res.getString("role");
                Timestamp loginDatetime = res.getTimestamp("loginDatetime");
                Timestamp createdate = res.getTimestamp("createdate");

                user = new User(
                    userid,
                    name,
                    username,
                    email,
                    password,
                    phone,
                    address,
                    role,
                    loginDatetime,
                    createdate
                );
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return user;
    }


    @Override
    public void adduser(User user) {

        String sql = "INSERT INTO `user` "
                   + "(name,email,username,password,phone,address,role,loginDatetime,createDate) "
                   + "VALUES(?,?,?,?,?,?,?,?,?)";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement stmt = con.prepareStatement(sql)
        ) {

            stmt.setString(1, user.getName());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getUsername());
            stmt.setString(4, user.getPassword());
            stmt.setLong(5, user.getPhone());
            stmt.setString(6, user.getAddress());
            stmt.setString(7, user.getRole());
            stmt.setTimestamp(8, user.getLoginDatetime());
            stmt.setTimestamp(9, user.getCreatedate());

            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    @Override
    public void updateuser(User user) {

        String sql = "UPDATE `user` SET "
                   + "name=?,email=?,username=?,password=?,phone=?,address=?,role=? "
                   + "WHERE userid=?";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement stmt = con.prepareStatement(sql)
        ) {

            stmt.setString(1, user.getName());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getUsername());
            stmt.setString(4, user.getPassword());
            stmt.setLong(5, user.getPhone());
            stmt.setString(6, user.getAddress());
            stmt.setString(7, user.getRole());
            stmt.setInt(8, user.getUserid());

            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    @Override
    public void deletuser(int userId) {

        String sql = "DELETE FROM `user` WHERE userid=?";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement stmt = con.prepareStatement(sql)
        ) {

            stmt.setInt(1, userId);

            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    @Override
    public List<User> getAlluser() {

        List<User> users = new ArrayList<>();

        String sql = "SELECT * FROM `user`";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement stmt = con.prepareStatement(sql);
            ResultSet res = stmt.executeQuery()
        ) {

            while (res.next()) {

                int userid = res.getInt("userid");
                String name = res.getString("name");
                String username = res.getString("username");
                String email = res.getString("email");
                String password = res.getString("password");
                long phone = res.getLong("phone");
                String address = res.getString("address");
                String role = res.getString("role");
                Timestamp loginDatetime = res.getTimestamp("loginDatetime");
                Timestamp createdate = res.getTimestamp("createdate");

                User user = new User(
                    userid,
                    name,
                    username,
                    email,
                    password,
                    phone,
                    address,
                    role,
                    loginDatetime,
                    createdate
                );

                users.add(user);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return users;
    }


    // =========================================================
    // LOGIN
    // =========================================================

    @Override
    public User getUserByEmailAndPassword(String email, String password) {

        User user = null;

        email = email == null ? "" : email.trim();
        password = password == null ? "" : password.trim();

        String sql =
            "SELECT userid, name, username, email, password, phone, address, role "
          + "FROM `user` "
          + "WHERE TRIM(email) = ?";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement stmt = con.prepareStatement(sql)
        ) {

            System.out.println("================================");
            System.out.println("### FOODIES LOGIN DAO ###");

            // Check the database Java is actually connected to
            try (
                PreparedStatement dbStmt =
                    con.prepareStatement("SELECT DATABASE()");
                ResultSet dbResult =
                    dbStmt.executeQuery()
            ) {

                if (dbResult.next()) {
                    System.out.println(
                        "JAVA DATABASE = " + dbResult.getString(1)
                    );
                }
            }

            System.out.println(
                "SEARCH EMAIL = [" + email + "]"
            );

            stmt.setString(1, email);

            ResultSet res = stmt.executeQuery();

            if (res.next()) {

                String dbEmail = res.getString("email");
                String dbPassword = res.getString("password");

                System.out.println("EMAIL FOUND");
                System.out.println(
                    "DB EMAIL = [" + dbEmail + "]"
                );
                System.out.println(
                    "DB PASSWORD = [" + dbPassword + "]"
                );

                if (dbPassword != null
                        && dbPassword.trim().equals(password)) {

                    System.out.println("PASSWORD MATCH");

                    user = new User(
                    	    res.getInt("userid"),
                    	    res.getString("name"),
                    	    res.getString("username"),
                    	    res.getString("email"),
                    	    res.getString("password"),
                    	    res.getLong("phone"),
                    	    res.getString("address"),
                    	    res.getString("role"),
                    	    null,
                    	    null
                    	);

                    System.out.println(
                        "USER CREATED SUCCESSFULLY"
                    );

                } else {

                    System.out.println(
                        "PASSWORD DOES NOT MATCH"
                    );
                }

            } else {

                System.out.println(
                    "EMAIL NOT FOUND"
                );
            }

            System.out.println("================================");

        } catch (SQLException e) {

            System.out.println(
                "### LOGIN DAO SQL ERROR ###"
            );

            e.printStackTrace();
        }

        return user;
    }
}