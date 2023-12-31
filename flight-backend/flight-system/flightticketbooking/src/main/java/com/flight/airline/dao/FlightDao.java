package com.flight.airline.dao;

import java.util.ArrayList;

import com.flight.airline.model.Flights;

public interface FlightDao {

	public void addFlight(String flightno, String from, String to, String dept_date, String arr_date, String dept_time,
						  String arr_time, int e_seats_left, int c_seats_left, int b_seats_left, float e_seat_price,
						  float c_seat_price, float b_seat_price, String flight_company, String status);

	
	public ArrayList<Flights> getFlight_details();
	
	public Flights getFlight(String flightno);
	
	public void updateFlight(Flights flight);
	
	public void deleteFlight(String flightno);
	
	public ArrayList<Flights> getUserFlight_details(String from, String to, String departure);

}
