package com.tap.Daoimplement;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.tap.Dao.ResturantDao;
import com.tap.model.Resturant;
import com.tap.util.DBConnection;

public class ResturantImp implements ResturantDao {

    private String insert = "INSERT INTO Resturant "
            + "(Resturantid, R_name, R_address, R_phone, R_cuisineType, DeliveryTime, AdmineUserId, Rating, IsActive, ImagePath) "
            + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

    private String get = "SELECT * FROM Resturant WHERE Resturantid=?";

    private String update = "UPDATE Resturant SET R_name=?, R_address=?, R_phone=?, R_cuisineType=?, "
            + "DeliveryTime=?, AdmineUserId=?, Rating=?, IsActive=?, ImagePath=? WHERE Resturantid=?";

    private String delete = "DELETE FROM Resturant WHERE Resturantid=?";

    private String getAll = "SELECT * FROM Resturant";

	@Override
	public Resturant getresturant(int Resturantid) {
		 Resturant resturant = null;

		    try (Connection con = DBConnection.getConnection();
		         PreparedStatement pstmt = con.prepareStatement(get)) {

		        pstmt.setInt(1, Resturantid);

		        ResultSet rs = pstmt.executeQuery();

		        if (rs.next()) {

		            resturant = new Resturant();

		            resturant.setResturantid(rs.getInt("Resturantid"));
		            resturant.setR_name(rs.getString("R_name"));
		            resturant.setR_address(rs.getString("R_address"));
		            resturant.setR_phone(rs.getString("R_phone"));
		            resturant.setR_cuisineType(rs.getString("R_cuisineType"));
		            resturant.setDeliveryTime(rs.getInt("DeliveryTime"));
		            resturant.setAdmineUserId(rs.getInt("AdmineUserId"));
		            resturant.setRating(rs.getString("Rating"));
		            resturant.setIsActive(rs.getString("IsActive"));
		            resturant.setImagePath(rs.getString("ImagePath"));
		        }

		    } catch (SQLException e) {
		        e.printStackTrace();
		    }

		    return resturant;
		}

	@Override
	public void addResturant(Resturant Resturant) {


		    try (Connection con = DBConnection.getConnection();
		         PreparedStatement pstmt = con.prepareStatement(insert)) {

		        pstmt.setInt(1, Resturant.getResturantid());
		        pstmt.setString(2, Resturant.getR_name());
		        pstmt.setString(3, Resturant.getR_address());
		        pstmt.setString(4, Resturant.getR_phone());
		        pstmt.setString(5, Resturant.getR_cuisineType());
		        pstmt.setInt(6, Resturant.getDeliveryTime());
		        pstmt.setInt(7, Resturant.getAdmineUserId());
		        pstmt.setString(8, Resturant.getRating());
		        pstmt.setString(9, Resturant.getIsActive());
		        pstmt.setString(10, Resturant.getImagePath());

		        pstmt.executeUpdate();

		    } catch (SQLException e) {
		        e.printStackTrace();
		    }
		}
		
	

	@Override
	public void updateResturant(Resturant Resturant) {
		 try (Connection con = DBConnection.getConnection();
		         PreparedStatement pstmt = con.prepareStatement(update)) {

		        pstmt.setString(1, Resturant.getR_name());
		        pstmt.setString(2, Resturant.getR_address());
		        pstmt.setString(3, Resturant.getR_phone());
		        pstmt.setString(4, Resturant.getR_cuisineType());
		        pstmt.setInt(5, Resturant.getDeliveryTime());
		        pstmt.setInt(6, Resturant.getAdmineUserId());
		        pstmt.setString(7, Resturant.getRating());
		        pstmt.setString(8, Resturant.getIsActive());
		        pstmt.setString(9, Resturant.getImagePath());
		        pstmt.setInt(10, Resturant.getResturantid());

		        pstmt.executeUpdate();

		    } catch (SQLException e) {
		        e.printStackTrace();
		    }
		}

		
	

	@Override
	public void deleteResturant(int Resturantid) {
		  try (Connection con = DBConnection.getConnection();
			         PreparedStatement pstmt = con.prepareStatement(delete)) {

			        pstmt.setInt(1, Resturantid);

			        pstmt.executeUpdate();

			    } catch (SQLException e) {
			        e.printStackTrace();
			    }
			}
		
	

	@Override
	public List<Resturant> getAllResturant() {
		

	    List<Resturant> resturants = new ArrayList<>();

	    try (Connection con = DBConnection.getConnection();
	         PreparedStatement pstmt = con.prepareStatement(getAll);
	         ResultSet rs = pstmt.executeQuery()) {

	        while (rs.next()) {

	            Resturant resturant = new Resturant();

	            resturant.setResturantid(rs.getInt("Resturantid"));
	            resturant.setR_name(rs.getString("R_name"));
	            resturant.setR_address(rs.getString("R_address"));
	            resturant.setR_phone(rs.getString("R_phone"));
	            resturant.setR_cuisineType(rs.getString("R_cuisineType"));
	            resturant.setDeliveryTime(rs.getInt("DeliveryTime"));
	            resturant.setAdmineUserId(rs.getInt("AdmineUserId"));
	            resturant.setRating(rs.getString("Rating"));
	            resturant.setIsActive(rs.getString("IsActive"));
	            resturant.setImagePath(rs.getString("ImagePath"));

	            resturants.add(resturant);
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return resturants;
	}


	}
	



	