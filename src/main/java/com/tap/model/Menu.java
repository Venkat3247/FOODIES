package com.tap.model;

public class Menu {

    private int menuid;
    private int resturantid;
    private String foodname;
    private String available;
    private String description;
    private int price;
    private int rating;
    private String imagepath;

    // Default constructor
    public Menu() {
    }

    // Constructor with all fields
    public Menu(int menuid, int resturantid, String foodname,
                String available, String description, int price,
                int rating, String imagepath) {

        this.menuid = menuid;
        this.resturantid = resturantid;
        this.foodname = foodname;
        this.available = available;
        this.description = description;
        this.price = price;
        this.rating = rating;
        this.imagepath = imagepath;
    }

    // Constructor without menuid
    public Menu(int resturantid, String foodname,
                String available, String description,
                int price, int rating, String imagepath) {

        this.resturantid = resturantid;
        this.foodname = foodname;
        this.available = available;
        this.description = description;
        this.price = price;
        this.rating = rating;
        this.imagepath = imagepath;
    }

    public int getMenuid() {
        return menuid;
    }

    public void setMenuid(int menuid) {
        this.menuid = menuid;
    }

    public int getResturantid() {
        return resturantid;
    }

    public void setResturantid(int resturantid) {
        this.resturantid = resturantid;
    }

    public String getFoodname() {
        return foodname;
    }

    public void setFoodname(String foodname) {
        this.foodname = foodname;
    }

    public String getAvailable() {
        return available;
    }

    public void setAvailable(String available) {
        this.available = available;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getImagepath() {
        return imagepath;
    }

    public void setImagepath(String imagepath) {
        this.imagepath = imagepath;
    }

    @Override
    public String toString() {

        return "Menu [menuid=" + menuid
                + ", resturantid=" + resturantid
                + ", foodname=" + foodname
                + ", available=" + available
                + ", description=" + description
                + ", price=" + price
                + ", rating=" + rating
                + ", imagepath=" + imagepath
                + "]";
    }
}