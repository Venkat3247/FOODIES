package com.tap.model;

public class CartItem {

    private Menu menu;
    private int quantity;

    public CartItem() {
    }

    public CartItem(Menu menu, int quantity) {
        this.menu = menu;
        this.quantity = quantity;
    }

    // GET MENU
    public Menu getMenu() {
        return menu;
    }

    // SET MENU
    public void setMenu(Menu menu) {
        this.menu = menu;
    }

    // GET QUANTITY
    public int getQuantity() {
        return quantity;
    }

    // SET QUANTITY
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    // GET TOTAL PRICE FOR THIS ITEM
    public double getTotal() {

        return menu.getPrice() * quantity;
    }
}