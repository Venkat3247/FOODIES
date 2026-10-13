package com.tap.util;

public class JdbcTest1 {

	public static void main(String[] args) {
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			
		
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		
	}

}
