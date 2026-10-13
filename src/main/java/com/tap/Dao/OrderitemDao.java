package com.tap.Dao;

import java.util.List;
import com.tap.model.Orderitem;

public interface OrderitemDao {

    void addOrderitem(Orderitem orderitem);

    Orderitem getOrderitem(int orderitemId);

    void updateOrderitem(Orderitem orderitem);

    void deleteOrderitem(int orderitemId);

    List<Orderitem> getAllOrderitem();
    
    List<Orderitem> getOrderitemByOrder(int orderid);
   
}

