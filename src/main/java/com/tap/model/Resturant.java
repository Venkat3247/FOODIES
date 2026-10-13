package com.tap.model;

public class Resturant {
	private int Resturantid;
	private String R_name;
	private String R_address;
	private String R_phone;
	private String R_cuisineType;
	private int DeliveryTime;
	private int AdmineUserId;
	private String Rating;
	private String IsActive;
	private String ImagePath;
	
	
	
	public Resturant() {
		
	}



	public Resturant(int resturantid, String r_name, String r_address, String r_phone, String r_cuisineType,
			int deliveryTime, int admineUserId, String rating, String isActive, String imagePath) {
		super();
		Resturantid = resturantid;
		R_name = r_name;
		R_address = r_address;
		R_phone = r_phone;
		R_cuisineType = r_cuisineType;
		DeliveryTime = deliveryTime;
		AdmineUserId = admineUserId;
		Rating = rating;
		IsActive = isActive;
		ImagePath = imagePath;
	}



	public Resturant(String r_name, String r_address, String r_phone, String r_cuisineType, int deliveryTime,
			int admineUserId, String rating, String isActive, String imagePath) {
		super();
		R_name = r_name;
		R_address = r_address;
		R_phone = r_phone;
		R_cuisineType = r_cuisineType;
		DeliveryTime = deliveryTime;
		AdmineUserId = admineUserId;
		Rating = rating;
		IsActive = isActive;
		ImagePath = imagePath;
	}



	public int getResturantid() {
		return Resturantid;
	}



	public void setResturantid(int resturantid) {
		Resturantid = resturantid;
	}



	public String getR_name() {
		return R_name;
	}



	public void setR_name(String r_name) {
		R_name = r_name;
	}



	public String getR_address() {
		return R_address;
	}



	public void setR_address(String r_address) {
		R_address = r_address;
	}



	public String getR_phone() {
		return R_phone;
	}



	public void setR_phone(String r_phone) {
		R_phone = r_phone;
	}



	public String getR_cuisineType() {
		return R_cuisineType;
	}



	public void setR_cuisineType(String r_cuisineType) {
		R_cuisineType = r_cuisineType;
	}



	public int getDeliveryTime() {
		return DeliveryTime;
	}



	public void setDeliveryTime(int deliveryTime) {
		DeliveryTime = deliveryTime;
	}



	public int getAdmineUserId() {
		return AdmineUserId;
	}



	public void setAdmineUserId(int admineUserId) {
		AdmineUserId = admineUserId;
	}



	public String getRating() {
		return Rating;
	}



	public void setRating(String rating) {
		Rating = rating;
	}



	public String getIsActive() {
		return IsActive;
	}



	public void setIsActive(String isActive) {
		IsActive = isActive;
	}



	public String getImagePath() {
		return ImagePath;
	}



	public void setImagePath(String imagePath) {
		ImagePath = imagePath;
	}



	@Override
	public String toString() {
		return "Resturant [Resturantid=" + Resturantid + ", R_name=" + R_name + ", R_address=" + R_address
				+ ", R_phone=" + R_phone + ", R_cuisineType=" + R_cuisineType + ", DeliveryTime=" + DeliveryTime
				+ ", AdmineUserId=" + AdmineUserId + ", Rating=" + Rating + ", IsActive=" + IsActive + ", ImagePath="
				+ ImagePath + "]";
	}
	


}