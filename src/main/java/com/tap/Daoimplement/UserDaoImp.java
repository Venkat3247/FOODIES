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

    if (email == null || password == null) {
        return null;
    }

    String sql =
        "SELECT userid, name, username, email, password, " +
        "phone, address, role " +
        "FROM `user` WHERE TRIM(email) = ?";

    try (
        Connection con = DBConnection.getConnection();
        PreparedStatement stmt = con.prepareStatement(sql)
    ) {

        stmt.setString(1, email.trim());

        try (ResultSet res = stmt.executeQuery()) {

            if (res.next()) {

                String dbPassword = res.getString("password");

                // Temporary support for existing plain-text passwords
                if (dbPassword != null &&
                    dbPassword.equals(password)) {

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
                }
            }
        }

    } catch (SQLException e) {
        e.printStackTrace();
    }

    return user;
}

    
    public User getUserByEmail(String email) {

        User user = null;

        String sql = "SELECT * FROM `user` WHERE TRIM(email)=?";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement stmt = con.prepareStatement(sql)
        ) {

            stmt.setString(1, email.trim());

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {

                user = new User(
                    rs.getInt("userid"),
                    rs.getString("name"),
                    rs.getString("username"),
                    rs.getString("email"),
                    rs.getString("password"),
                    rs.getLong("phone"),
                    rs.getString("address"),
                    rs.getString("role"),
                    rs.getTimestamp("loginDatetime"),
                    rs.getTimestamp("createdate")
                );
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return user;
    }
}