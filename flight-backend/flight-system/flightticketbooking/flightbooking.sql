-- Create database
CREATE DATABASE IF NOT EXISTS flightfinal;
USE flightfinal;

-- Create admin credentials table
DROP TABLE IF EXISTS admin_credentials;
CREATE TABLE admin_credentials (
  id INT NOT NULL AUTO_INCREMENT,
  username VARCHAR(25),
  password VARCHAR(25),
  email_id VARCHAR(30),
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

-- Insert admin credentials sample data
INSERT INTO admin_credentials (username, password, email_id) VALUES
('admin1', 'password123', 'admin1@example.com'),
('admin2', 'securePass', 'admin2@example.com'),
('john_doe', 'pass1234', 'john.doe@email.com'),
('jane_smith', 'adminPass', 'jane.smith@email.com'),
('superuser', 'strongPassword', 'superuser@example.com');


-- Create user details table
DROP TABLE IF EXISTS user_details;
CREATE TABLE user_details (
  u_id INT NOT NULL AUTO_INCREMENT,
  u_name VARCHAR(50) NOT NULL,
  u_gender VARCHAR(10) NOT NULL,
  u_address VARCHAR(100) NOT NULL,
  u_email_id VARCHAR(50) NOT NULL,
  u_contact VARCHAR(10) NOT NULL,
  u_username VARCHAR(30) NOT NULL,
  u_password VARCHAR(30) NOT NULL,
  u_promo VARCHAR(10) NOT NULL DEFAULT 0,
  PRIMARY KEY (u_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

-- Insert user credentials sample data
INSERT INTO user_details (u_name, u_gender, u_address, u_email_id, u_contact, u_username, u_password) VALUES
('John Doe', 'Male', '123 Main St, Cityville', 'john.doe@example.com', '1234567890', 'johndoe', 'password123'),
('Jane Smith', 'Female', '456 Oak Ave, Townsville', 'jane.smith@example.com', '9876543210', 'janesmith', 'securePass'),
('Bob Johnson', 'Male', '789 Elm Blvd, Villagetown', 'bob.johnson@example.com', '5556667777', 'bobjohnson', 'pass1234'),
('Alice Williams', 'Female', '321 Pine Ln, Hamletville', 'alice.williams@example.com', '8889990000', 'alicewilliams', 'adminPass'),
('Charlie Brown', 'Male', '654 Birch Dr, Countryside', 'charlie.brown@example.com', '1112223333', 'charliebrown', 'strongPassword');


-- Create flight details table with Comfort class
DROP TABLE IF EXISTS flight_details;
CREATE TABLE IF NOT EXISTS flight_details (
  id INT NOT NULL AUTO_INCREMENT,
  flightno VARCHAR(10) NOT NULL,
  from_city VARCHAR(20) NOT NULL,
  to_city VARCHAR(20) NOT NULL,
  departure_date VARCHAR(20) NOT NULL,
  arrival_date VARCHAR(20) NOT NULL,
  departure_time VARCHAR(20) NOT NULL,
  arrival_time VARCHAR(20) NOT NULL,
  e_seats_left INT NOT NULL DEFAULT 45,
  b_seats_left INT NOT NULL DEFAULT 15,
  c_seats_left INT NOT NULL DEFAULT 20,
  e_price INT NOT NULL,
  b_price INT NOT NULL,
  c_price INT NOT NULL,
  flight_company VARCHAR(40) NOT NULL,
  status VARCHAR(20) NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

-- Insert flight details sample data
INSERT INTO flight_details (
  flightno, 
  from_city, 
  to_city, 
  departure_date, 
  arrival_date, 
  departure_time, 
  arrival_time, 
  e_seats_left, 
  b_seats_left, 
  c_seats_left, 
  e_price, 
  b_price, 
  c_price, 
  flight_company, 
  status
) VALUES
('FL123', 'Calgary', 'Los Angeles', '2023-12-01', '2023-12-01', '08:00 AM', '12:00 PM', 40, 10, 15, 300, 700, 500, 'Airline A', 'Scheduled'),
('FL456', 'Calgary', 'New York', '2023-12-02', '2023-12-02', '10:00 AM', '02:00 PM', 30, 12, 18, 250, 600, 450, 'Airline B', 'Scheduled'),
('FL789', 'Vancouver', 'Los Angeles', '2023-12-03', '2023-12-03', '12:00 PM', '04:00 PM', 35, 8, 22, 350, 800, 550, 'Airline C', 'Scheduled'),
('FL101', 'New York', 'Calgary', '2023-12-04', '2023-12-04', '02:00 PM', '06:00 PM', 25, 15, 20, 400, 900, 600, 'Airline D', 'Scheduled'),
('FL202', 'Vancouver', 'Los Angeles', '2023-12-05', '2023-12-05', '04:00 PM', '08:00 PM', 20, 5, 25, 320, 750, 480, 'Airline E', 'Scheduled');


-- Create passenger details table
DROP TABLE IF EXISTS passenger_details;
CREATE TABLE passenger_details (
  p_id INT NOT NULL,
  p_pnr VARCHAR(25) NOT NULL,
  p_name VARCHAR(50) NOT NULL,
  p_age VARCHAR(3) NOT NULL,
  p_sex VARCHAR(10) NOT NULL,
  p_fno VARCHAR(10) NOT NULL,
  p_from VARCHAR(10) NOT NULL,
  p_to VARCHAR(10) NOT NULL,
  p_dedate DATE DEFAULT NULL,
  p_ardate DATE DEFAULT NULL,
  p_detime VARCHAR(20) NOT NULL,
  p_artime VARCHAR(20) NOT NULL,
  p_status VARCHAR(20) NOT NULL,
  p_class VARCHAR(10) NOT NULL,
  p_seatno INT NOT NULL,
  p_email VARCHAR(30) DEFAULT NULL,
  p_bookingdate DATE DEFAULT NULL,
  PRIMARY KEY (p_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO passenger_details (p_id, p_pnr, p_name, p_age, p_sex, p_fno, p_from, p_to, p_dedate, p_ardate, p_detime, p_artime, p_status, p_class, p_seatno, p_email, p_bookingdate)
VALUES
(1, 'PNR123', 'John Doe', '30', 'Male', 'F101', 'CityA', 'CityB', '2023-01-15', '2023-01-16', '10:00 AM', '12:00 PM', 'Confirmed', 'Economy', 23, 'john.doe@email.com', '2023-01-05'),
(2, 'PNR456', 'Jane Smith', '25', 'Female', 'F202', 'CityC', 'CityD', '2023-02-20', '2023-02-21', '02:30 PM', '04:30 PM', 'Pending', 'Business', 7, 'jane.smith@email.com', '2023-02-10'),
(3, 'PNR789', 'Bob Johnson', '45', 'Male', 'F303', 'CityX', 'CityY', '2023-03-10', '2023-03-11', '08:45 AM', '10:45 AM', 'Confirmed', 'FirstClass', 1, 'bob.johnson@email.com', '2023-02-28'),
(4, 'PNR101', 'Alice Brown', '28', 'Female', 'F404', 'CityM', 'CityN', '2023-04-05', '2023-04-06', '05:15 PM', '07:15 PM', 'Cancelled', 'Economy', 14, 'alice.brown@email.com', '2023-03-25');

-- Modify auto-increment for passenger details table
ALTER TABLE passenger_details MODIFY p_id INT NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

-- Create PNR table
DROP TABLE IF EXISTS PNR;
CREATE TABLE PNR (
  PNR_NO VARCHAR(20),
  TOTAL_AMOUNT DOUBLE
);

-- insert sample PNR data
INSERT INTO PNR (PNR_NO, TOTAL_AMOUNT) VALUES
('PNR123', 450.75),
('PNR456', 800.50),
('PNR789', 1200.25),
('PNR101', 600.00),
('PNR202', 950.75);

-- Create Promo Table
CREATE TABLE promo_codes(
	promo_code VARCHAR(20),
    promo_value DOUBLE
);

INSERT INTO promo_codes (promo_code, promo_value) VALUES
('promo1', 300),
('promo2', 100);





