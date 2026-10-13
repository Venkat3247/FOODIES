package com.tap.model;

import java.sql.Timestamp;

public class User {
	private int userid;
	private String name;
	private String username;
	private String email;
	private String password;
	private long phone;
	private String address;
	private String role;
	private Timestamp loginDatetime;
	private Timestamp createdate;
	
	public  User() {
		
	}

	public User(int userid, String name, String username, String email, String password, long phone, String address,
			String role, Timestamp loginDatetime, Timestamp createdate) {
		super();
		this.userid = userid;
		this.name = name;
		this.username = username;
		this.email = email;
		this.password = password;
		this.phone = phone;
		this.address = address;
		this.role = role;
		this.loginDatetime = loginDatetime;
		this.createdate = createdate;
	}

	public User(String name, String username, String email, String password, long phone, String address, String role) {
		super();
		this.name = name;
		this.username = username;
		this.email = email;
		this.password = password;
		this.phone = phone;
		this.address = address;
		this.role = role;
	}

	public User(int userid, String name, String username, String email, String password, long phone, String address,
			String role) {
		super();
		this.userid = userid;
		this.name = name;
		this.username = username;
		this.email = email;
		this.password = password;
		this.phone = phone;
		this.address = address;
		this.role = role;
		
	}

	public int getUserid() {
		return userid;
	}

	public void setUserid(int userid) {
		this.userid = userid;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public long getPhone() {
		return phone;
	}

	public void setPhone(long phone) {
		this.phone = phone;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public Timestamp getLoginDatetime() {
		return loginDatetime;
	}

	public void setLoginDatetime(Timestamp loginDatetime) {
		this.loginDatetime = loginDatetime;
	}

	public Timestamp getCreatedate() {
		return createdate;
	}

	public void setCreatedate(Timestamp createdate) {
		this.createdate = createdate;
	}

	@Override
	public String toString() {
		return "User [userid=" + userid + ", name=" + name + ", username=" + username + ", email=" + email
				+ ", password=" + password + ", phone=" + phone + ", address=" + address + ", role=" + role
				+ ", loginDatetime=" + loginDatetime + ", createdate=" + createdate + "]";
	}
	
	
	

}