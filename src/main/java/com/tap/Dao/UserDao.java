package com.tap.Dao;

import java.util.List;

import com.tap.model.User;

public interface UserDao {

    User getuser(int userId);

    User getUserByEmailAndPassword(String email, String password);

    void adduser(User user);

    void updateuser(User user);

    void deletuser(int userId);

    List<User> getAlluser();
}