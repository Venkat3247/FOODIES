package com.tap.model;

import java.util.LinkedHashMap;
import java.util.Map;

public class Cart {

    private Map<Integer, CartItem> items;
    private int restaurantId;

    public Cart() {
        items = new LinkedHashMap<>();
        restaurantId = 0;
    }

    // ADD ITEM
    public boolean addItem(Menu menu) {

        // First item decides the restaurant
        if (items.isEmpty()) {
            restaurantId = menu.getResturantid();
        }

        // Do not allow different restaurant items
        if (restaurantId != menu.getResturantid()) {
            return false;
        }

        int menuId = menu.getMenuid();

        // If item already exists, increase quantity
        if (items.containsKey(menuId)) {

            CartItem existingItem = items.get(menuId);

            existingItem.setQuantity(
                existingItem.getQuantity() + 1
            );

        } else {

            // New item
            CartItem newItem = new CartItem(menu, 1);

            items.put(menuId, newItem);
        }

        return true;
    }

    // INCREASE QUANTITY
    public void increaseQuantity(int menuId) {

        if (items.containsKey(menuId)) {

            CartItem item = items.get(menuId);

            item.setQuantity(
                item.getQuantity() + 1
            );
        }
    }

    // DECREASE QUANTITY
    public void decreaseQuantity(int menuId) {

        if (items.containsKey(menuId)) {

            CartItem item = items.get(menuId);

            int quantity = item.getQuantity();

            if (quantity > 1) {

                item.setQuantity(quantity - 1);

            } else {

                items.remove(menuId);
            }

            // If cart becomes empty
            if (items.isEmpty()) {
                restaurantId = 0;
            }
        }
    }

    // REMOVE ONE ITEM
    public void removeItem(int menuId) {

        items.remove(menuId);

        // If cart becomes empty
        if (items.isEmpty()) {
            restaurantId = 0;
        }
    }

    // CLEAR CART
    public void clearCart() {

        items.clear();
        restaurantId = 0;
    }

    // GET CART ITEMS
    public Map<Integer, CartItem> getItems() {
        return items;
    }

    // GET RESTAURANT ID
    public int getRestaurantId() {
        return restaurantId;
    }

    // GET TOTAL PRICE
    public double getTotal() {

        double total = 0;

        for (CartItem item : items.values()) {

            total += item.getTotal();
        }

        return total;
    }

    // GET TOTAL NUMBER OF ITEMS
    public int getTotalItems() {

        int count = 0;

        for (CartItem item : items.values()) {

            count += item.getQuantity();
        }

        return count;
    }
}