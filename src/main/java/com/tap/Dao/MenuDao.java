package com.tap.Dao;

import java.util.List;
import com.tap.model.Menu;

public interface MenuDao {

    void addMenu(Menu menu);

    Menu getMenu(int menuid);

    void updateMenu(Menu menu);

    void deleteMenu(int menuid);

    List<Menu> getAllMenu();
    List<Menu> getMenuByResturant(int Resturantid);
}