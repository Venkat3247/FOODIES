package com.tap.model;

public class Orders {
	private  int orderid;
	private int userid;
	private int resturantid;
	private int totalamount;
	private String status;
	private int orderdate;
	private double paymentmode;
	
	
	public Orders() {
		
	}


	public Orders(int orderid, int userid, int resturantid, int totalamount, String status, int orderdate,
			double paymentmode) {
		super();
		this.orderid = orderid;
		this.userid = userid;
		this.resturantid = resturantid;
		this.totalamount = totalamount;
		this.status = status;
		this.orderdate = orderdate;
		this.paymentmode = paymentmode;
	}


	public Orders(int userid, int resturantid, int totalamount, String status, int orderdate, double paymentmode) {
		super();
		this.userid = userid;
		this.resturantid = resturantid;
		this.totalamount = totalamount;
		this.status = status;
		this.orderdate = orderdate;
		this.paymentmode = paymentmode;
	}


	public int getOrderid() {
		return orderid;
	}


	public void setOrderid(int orderid) {
		this.orderid = orderid;
	}


	public int getUserid() {
		return userid;
	}


	public void setUserid(int userid) {
		this.userid = userid;
	}


	public int getResturantid() {
		return resturantid;
	}


	public void setResturantid(int resturantid) {
		this.resturantid = resturantid;
	}


	public int getTotalamount() {
		return totalamount;
	}


	public void setTotalamount(int totalamount) {
		this.totalamount = totalamount;
	}


	public String getStatus() {
		return status;
	}


	public void setStatus(String status) {
		this.status = status;
	}


	public int getOrderdate() {
		return orderdate;
	}


	public void setOrderdate(int orderdate) {
		this.orderdate = orderdate;
	}


	public double getPaymentmode() {
		return paymentmode;
	}


	public void setPaymentmode(double paymentmode) {
		this.paymentmode = paymentmode;
	}


	@Override
	public String toString() {
		return "Orders [orderid=" + orderid + ", userid=" + userid + ", resturantid=" + resturantid + ", totalamount="
				+ totalamount + ", status=" + status + ", orderdate=" + orderdate + ", paymentmode=" + paymentmode
				+ "]";
	}


}