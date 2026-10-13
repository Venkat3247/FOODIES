package com.tap.Dao;

import java.util.List;
import com.tap.model.Orders;

public interface OrdersDao {

    int addOrders(Orders orders);

    Orders getOrders(int orderid);

    void updateOrders(Orders orders);

    void deleteOrders(int orderid);

    List<Orders> getAllOrders();
    
    List<Orders>getOrdersByUserid(int userid);
}