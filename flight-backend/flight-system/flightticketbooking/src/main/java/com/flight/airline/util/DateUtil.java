package com.flight.airline.util;

import java.util.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;

public class DateUtil {

	public static Date convertToDate(String s) {
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("dd/MM/yyyy");

		Date date1;
		try {

			date1 = simpleDateFormat.parse(s);
			return date1;
		} catch (ParseException e) {
			e.printStackTrace();
		}

		return null;

	}
}
