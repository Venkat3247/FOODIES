package com.tap.model;

public class Orderitem {
	private int OrderitemId;
	private int Orderid;
	private int MenuId;
	private int Quantity;
	private int price;
	
	
	public Orderitem() {
		
		
	}


	public Orderitem(int orderitemId, int orderid, int menuId, int quantity, int price) {
		super();
		OrderitemId = orderitemId;
		Orderid = orderid;
		MenuId = menuId;
		Quantity = quantity;
		this.price = price;
	}


	public int getOrderitemId() {
		return OrderitemId;
	}


	public void setOrderitemId(int orderitemId) {
		OrderitemId = orderitemId;
	}


	public int getOrderid() {
		return Orderid;
	}


	public void setOrderid(int orderid) {
		Orderid = orderid;
	}


	public int getMenuId() {
		return MenuId;
	}


	public void setMenuId(int menuId) {
		MenuId = menuId;
	}


	public int getQuantity() {
		return Quantity;
	}


	public void setQuantity(int quantity) {
		Quantity = quantity;
	}


	public int getPrice() {
		return price;
	}


	public void setPrice(int price) {
		this.price = price;
	}


	@Override
	public String toString() {
		return "Orderitem [OrderitemId=" + OrderitemId + ", Orderid=" + Orderid + ", MenuId=" + MenuId + ", Quantity="
				+ Quantity + ", price=" + price + "]";
	}
	
	
}