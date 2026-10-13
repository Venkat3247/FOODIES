package com.tap.Dao;

import java.util.List;

import com.tap.model.Resturant;

public interface ResturantDao {
	Resturant getresturant(int Resturantid);
	void addResturant(Resturant Resturant );
	void updateResturant(Resturant Resturant);
	void deleteResturant(int Resturantid);
	
	List<Resturant>getAllResturant();

}
