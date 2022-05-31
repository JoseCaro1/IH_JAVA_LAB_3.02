DROP SCHEMA IF EXISTS blogs;
CREATE SCHEMA blogs;

USE blogs;

CREATE TABLE author (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255),
    PRIMARY KEY (id)
);

CREATE TABLE post (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255),
    word_count INT,
    views INT,
    author_id INT,
    PRIMARY KEY (id),
    FOREIGN KEY (author_id)
        REFERENCES author (id)
);

DROP SCHEMA IF EXISTS flights;
CREATE SCHEMA flights;
USE flights;
CREATE TABLE aircraft(
aircraft VARCHAR(255) NOT NULL,
seats INT NOT NULL,
PRIMARY KEY (aircraft));

CREATE TABLE vuelos(
flight_number VARCHAR(255) NOT NULL,
aircraft VARCHAR(255) NOT NULL,
mileage BIGINT NOT NULL,
PRIMARY KEY(flight_number),
foreign key (aircraft) REFERENCES aircraft(aircraft));

CREATE TABLE customer(
id INT AUTO_INCREMENT NOT NULL,
nombre VARCHAR(255),
status ENUM('Gold','Silver','None') NOT NULL,
customer_mileage BIGINT NOT NULL,
PRIMARY KEY (id)
);

CREATE TABLE customer_flights(
id INT NOT NULL AUTO_INCREMENT,
customer_id INT NOT NULL,
flight_number VARCHAR(255) NOT NULL,
PRIMARY KEY (id),
FOREIGN KEY (customer_id) REFERENCES customer(id),
FOREIGN KEY (flight_number) REFERENCES vuelos(flight_number)
);

INSERT INTO aircraft(aircraft, seats) VALUES
("Boeing 747",  400),
("Airbus A330", 236),
("Boeing 777",  264);

INSERT INTO vuelos(flight_number, mileage, aircraft) VALUES
("DL143", 135, "Boeing 747"),
("DL122", 4370 , "Airbus A330"),
("DL53", 2078, "Boeing 777"),
("DL222", 1765, "Airbus A330"),
("DL37", 531, "Boeing 747");

INSERT INTO customer(nombre, status, customer_mileage) VALUES
("Agustine Riviera", "Silver", 115235),
("Alaina Sepulvida", "None", 6008),
("Tom Jones", "Gold", 205767),
("Sam Rio", "None", 2653),
("Jessica James", "Silver", 127656),
("Ana Janco", "Silver", 136773),
("Jennifer Cortez", "Gold", 300582),
("Christian Janco", "Silver", 14642);


INSERT INTO customer_flights(id, customer_id, flight_number) VALUES
(1, 1, "DL143"),
(2, 1,"DL122"),
(3, 2,  "DL122"),
(4, 3, "DL122"),
(5, 3, "DL53"),
(6, 4, "DL143"),
(7,4, "DL37"),
(8, 5, "DL143"),
(9, 5, "DL122"),
(10, 6, "DL222"),
(11, 7, "DL222"),
(12, 8, "DL222");


-- In the Airline database write the SQL script to get the total number of flights in the database
SELECT COUNT(*) from vuelos;

-- In the Airline database write the SQL script to get the average flight distance
SELECT AVG(mileage) FROM vuelos;

-- In the Airline database write the SQL script to get the average number of seats
SELECT AVG(seats) FROM aircraft;

-- In the Airline database write the SQL script to get the average number of miles flown by customers grouped by status
SELECT status, AVG(customer_mileage) FROM customer GROUP BY status;

-- In the Airline database write the SQL script to get the maximum number of miles flown by customers grouped by status
SELECT status, MAX(customer_mileage) FROM customer GROUP BY status;

-- In the Airline database write the SQL script to get the total number of aircraft with a name containing Boeing
SELECT COUNT(*) FROM aircraft WHERE aircraft LIKE 'Boeing%';

-- In the Airline database write the SQL script to find all flights with a distance between 300 and 2000 miles
SELECT *  FROM vuelos WHERE mileage BETWEEN 300 AND 2000;

-- In the Airline database write the SQL script to find the average flight distance booked grouped by customer status (this should require a join)
SELECT  status,AVG(mileage) from customer JOIN customer_flights ON customer_id=customer.id JOIN vuelos ON vuelos.flight_number = customer_flights.flight_number GROUP BY customer.status ;

-- In the Airline database write the SQL script to find the most aircraft most often booked by gold status members (this should require a join)
SELECT status,MAX(aircraft) from customer_flights,customer,vuelos WHERE customer.id=customer_flights.customer_id AND vuelos.flight_number = customer_flights.flight_number AND status = 'Gold' ;

