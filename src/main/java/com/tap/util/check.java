package com.tap.util;

import java.sql.Connection;

public class check {
	public static void main(String[]args) {
		
	
		 Connection con= DBConnection.getConnection();
				 
		 if(con !=null) {
			 System.out.println("yes");
		 }
		 else {
			 System.out.println("no");
		 }
				 }
		 
}
	



