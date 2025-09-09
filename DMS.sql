CREATE DATABASE DMS;
USE DMS;

-----------------------------------------------------------------------------------
---                                  CREATION                                   ---
-----------------------------------------------------------------------------------
---USER
CREATE TABLE USERS (
    USER_ID INT PRIMARY KEY IDENTITY,
    NAME VARCHAR(100) NOT NULL,
    ROLE VARCHAR(50) CHECK (ROLE IN ('ADMIN', 'RESCUE TEAM', 'VOLUNTEER', 'DONOR')),
    CONTACT_INFO VARCHAR(255),
    EMAIL VARCHAR(100) UNIQUE
);

---DISASTERS
CREATE TABLE DISASTERS (
    DISASTER_ID INT PRIMARY KEY IDENTITY,
    TYPE VARCHAR(50),
    SEVERITY VARCHAR(20),
    LOCATION VARCHAR(255),
    DATE DATE
);

---RESCUETEAMS
CREATE TABLE RESCUETEAMS (
    TEAM_ID INT PRIMARY KEY IDENTITY,
    USER_ID INT FOREIGN KEY REFERENCES USERS(USER_ID),
    TEAM_NAME VARCHAR(100),
    CONTACT_NUMBER VARCHAR(15)
);

---RESOURCES
CREATE TABLE RESOURCES (
    RESOURCE_ID INT PRIMARY KEY IDENTITY,
    RESOURCE_TYPE VARCHAR(50),
    QUANTITY INT,
    LOCATION VARCHAR(255)
);

---VICTIMS
CREATE TABLE VICTIMS (
    VICTIM_ID INT PRIMARY KEY IDENTITY,
    NAME VARCHAR(100),
    AGE INT,
    STATUS VARCHAR(50) CHECK (STATUS IN ('INJURED', 'MISSING', 'DISPLACED')),
    MEDICAL_NEEDS VARCHAR(255)
);

---VOLUNTEERS
CREATE TABLE VOLUNTEERS (
    VOLUNTEER_ID INT PRIMARY KEY IDENTITY,
    USER_ID INT FOREIGN KEY REFERENCES USERS(USER_ID),
    SKILLS VARCHAR(255),
    AVAILABILITY VARCHAR(50)
);

---SHELTERS
CREATE TABLE SHELTERS (
    SHELTER_ID INT PRIMARY KEY IDENTITY,
    LOCATION VARCHAR(255),
    CAPACITY INT,
    AVAILABLE_FACILITIES VARCHAR(255)
);

---DONATIONS
CREATE TABLE DONATIONS (
    DONATION_ID INT PRIMARY KEY IDENTITY,
    USER_ID INT FOREIGN KEY REFERENCES USERS(USER_ID),
    AMOUNT DECIMAL(10,2),
    DATE DATE
);

---MEDICALASSISTANCE
CREATE TABLE MEDICALASSISTANCE (
    MEDICAL_ID INT PRIMARY KEY IDENTITY,
    VICTIM_ID INT FOREIGN KEY REFERENCES VICTIMS(VICTIM_ID),
    ASSIGNED_DOCTOR VARCHAR(100),
    HOSPITAL VARCHAR(100)
);

---EMERGENCYCALLS
CREATE TABLE EMERGENCYCALLS (
    CALL_ID INT PRIMARY KEY IDENTITY,
    DISASTER_ID INT FOREIGN KEY REFERENCES DISASTERS(DISASTER_ID),
    CALLER_NAME VARCHAR(100),
    LOCATION VARCHAR(255),
    EMERGENCY_TYPE VARCHAR(50),
    TIME DATETIME
);

---EMERGENCYCALLS
CREATE TABLE TRANSPORT (
    VEHICLE_ID INT PRIMARY KEY IDENTITY,
    VEHICLE_TYPE VARCHAR(50),
    CAPACITY INT,
    LOCATION VARCHAR(255)
);

---WEATHERFORECAST
CREATE TABLE WEATHERFORECAST (
    WEATHER_ID INT PRIMARY KEY IDENTITY,
    DATE DATE,
    LOCATION VARCHAR(255),
    WEATHER_CONDITION VARCHAR(50)
);

---AI_PREDICTIONS
CREATE TABLE AI_PREDICTIONS (
    PREDICTION_ID INT PRIMARY KEY IDENTITY,
    DISASTER_ID INT FOREIGN KEY REFERENCES DISASTERS(DISASTER_ID),
    WEATHER_ID INT FOREIGN KEY REFERENCES WEATHERFORECAST(WEATHER_ID),
    PROBABILITY FLOAT,
    PREDICTED_DATE DATE
);

---ALERTS
CREATE TABLE ALERTS (
    ALERT_ID INT PRIMARY KEY IDENTITY,
    DISASTER_ID INT FOREIGN KEY REFERENCES DISASTERS(DISASTER_ID),
    ALERT_MESSAGE VARCHAR(255),
    ISSUED_BY INT FOREIGN KEY REFERENCES USERS(USER_ID),
    ISSUED_DATE DATETIME
);

---INCIDENTREPORTS
CREATE TABLE INCIDENTREPORTS (
    REPORT_ID INT PRIMARY KEY IDENTITY,
    DISASTER_ID INT FOREIGN KEY REFERENCES DISASTERS(DISASTER_ID),
    USER_ID INT FOREIGN KEY REFERENCES USERS(USER_ID),
    REPORT_DETAILS TEXT,
    REPORT_DATE DATE
);



-----------------------------------------------------------------------------------
---                                 INSERTION                                   ---
-----------------------------------------------------------------------------------

INSERT INTO USERS VALUES('John Doe', 'ADMIN', '123-456-7890', 'johndoe@example.com');
INSERT INTO USERS VALUES('Jane Smith', 'RESCUE TEAM', '234-567-8901', 'janesmith@example.com');
INSERT INTO USERS VALUES('Mark Johnson', 'VOLUNTEER', '345-678-9012', 'markjohnson@example.com');
INSERT INTO USERS VALUES('Emily Davis', 'DONOR', '456-789-0123', 'emilydavis@example.com');
INSERT INTO USERS VALUES('Chris Brown', 'ADMIN', '567-890-1234', 'chrisbrown@example.com');
INSERT INTO USERS VALUES('Patricia Taylor', 'RESCUE TEAM', '678-901-2345', 'patriciataylor@example.com');
INSERT INTO USERS VALUES('Michael White', 'VOLUNTEER', '789-012-3456', 'michaelwhite@example.com');
INSERT INTO USERS VALUES('Sarah Moore', 'DONOR', '890-123-4567', 'sarahmoore@example.com');
INSERT INTO USERS VALUES('James Wilson', 'ADMIN', '901-234-5678', 'jameswilson@example.com');
INSERT INTO USERS VALUES('Linda Harris', 'RESCUE TEAM', '123-345-6789', 'lindaharris@example.com');
INSERT INTO USERS VALUES('David Clark', 'VOLUNTEER', '234-456-7890', 'davidclark@example.com');
INSERT INTO USERS VALUES('Susan Lewis', 'DONOR', '345-567-8901', 'susanlewis@example.com');
INSERT INTO USERS VALUES('John Martin', 'ADMIN', '456-678-9012', 'johnmartin@example.com');
INSERT INTO USERS VALUES('Rachel Allen', 'RESCUE TEAM', '567-789-0123', 'rachellallen@example.com');
INSERT INTO USERS VALUES('Kevin Young', 'VOLUNTEER', '678-890-1234', 'kevinyoung@example.com');

INSERT INTO DISASTERS VALUES('Earthquake', 'Severe', 'California', '2025-01-15');
INSERT INTO DISASTERS VALUES('Flood', 'Moderate', 'Texas', '2025-01-18');
INSERT INTO DISASTERS VALUES('Tornado', 'Severe', 'Kansas', '2025-02-02');
INSERT INTO DISASTERS VALUES('Fire', 'High', 'Oregon', '2025-01-25');
INSERT INTO DISASTERS VALUES('Flood', 'Severe', 'Louisiana', '2025-02-10');
INSERT INTO DISASTERS VALUES('Hurricane', 'Severe', 'Florida', '2025-02-05');
INSERT INTO DISASTERS VALUES('Earthquake', 'Moderate', 'Japan', '2025-02-14');
INSERT INTO DISASTERS VALUES('Fire', 'Low', 'Colorado', '2025-01-30');
INSERT INTO DISASTERS VALUES('Flood', 'High', 'Bangladesh', '2025-01-20');
INSERT INTO DISASTERS VALUES('Landslide', 'Moderate', 'Nepal', '2025-02-08');
INSERT INTO DISASTERS VALUES('Earthquake', 'Severe', 'Chile', '2025-01-28');
INSERT INTO DISASTERS VALUES('Tornado', 'Moderate', 'Missouri', '2025-02-11');
INSERT INTO DISASTERS VALUES('Flood', 'Severe', 'Philippines', '2025-02-16');
INSERT INTO DISASTERS VALUES('Hurricane', 'Moderate', 'Mexico', '2025-02-12');
INSERT INTO DISASTERS VALUES('Fire', 'Severe', 'Australia', '2025-01-22');

INSERT INTO RESCUETEAMS VALUES(1, 'Team Alpha', '321-654-9870');
INSERT INTO RESCUETEAMS VALUES(2, 'Team Bravo', '432-765-0981');
INSERT INTO RESCUETEAMS VALUES(3, 'Team Charlie', '543-876-1092');
INSERT INTO RESCUETEAMS VALUES(4, 'Team Delta', '654-987-2103');
INSERT INTO RESCUETEAMS VALUES(5, 'Team Echo', '765-098-3214');
INSERT INTO RESCUETEAMS VALUES(6, 'Team Foxtrot', '876-109-4325');
INSERT INTO RESCUETEAMS VALUES(7, 'Team Golf', '987-210-5436');
INSERT INTO RESCUETEAMS VALUES(8, 'Team Hotel', '321-432-6547');
INSERT INTO RESCUETEAMS VALUES(9, 'Team India', '432-543-7658');
INSERT INTO RESCUETEAMS VALUES(10, 'Team Juliet', '543-654-8769');
INSERT INTO RESCUETEAMS VALUES(11, 'Team Kilo', '654-765-9870');
INSERT INTO RESCUETEAMS VALUES(12, 'Team Lima', '765-876-1091');
INSERT INTO RESCUETEAMS VALUES(13, 'Team Mike', '876-987-2102');
INSERT INTO RESCUETEAMS VALUES(14, 'Team November', '987-210-3213');
INSERT INTO RESCUETEAMS VALUES(15, 'Team Oscar', '321-432-5434');

INSERT INTO RESOURCES VALUES('Tents', 100, 'Texas');
INSERT INTO RESOURCES VALUES('Medicines', 200, 'California');
INSERT INTO RESOURCES VALUES('Water Bottles', 500, 'Florida');
INSERT INTO RESOURCES VALUES('Food Packages', 300, 'Oregon');
INSERT INTO RESOURCES VALUES('First Aid Kits', 150, 'Louisiana');
INSERT INTO RESOURCES VALUES('Blankets', 250, 'Missouri');
INSERT INTO RESOURCES VALUES('Generators', 30, 'Kansas');
INSERT INTO RESOURCES VALUES('Portable Toilets', 50, 'Bangladesh');
INSERT INTO RESOURCES VALUES('Rescue Boats', 20, 'Philippines');
INSERT INTO RESOURCES VALUES('Water Tanks', 40, 'Chile');
INSERT INTO RESOURCES VALUES('Medicines', 100, 'Nepal');
INSERT INTO RESOURCES VALUES('Tents', 200, 'Australia');
INSERT INTO RESOURCES VALUES('Fire Extinguishers', 30, 'Mexico');
INSERT INTO RESOURCES VALUES('Water Pumps', 10, 'Japan');
INSERT INTO RESOURCES VALUES('Portable Radios', 50, 'California');

INSERT INTO VICTIMS VALUES('Alice Green', 30, 'INJURED', 'Fractured Leg');
INSERT INTO VICTIMS VALUES('Bob White', 45, 'MISSING', 'None');
INSERT INTO VICTIMS VALUES('Charlie Black', 29, 'DISPLACED', 'Psychological Support');
INSERT INTO VICTIMS VALUES('Debbie Blue', 50, 'INJURED', 'Burns');
INSERT INTO VICTIMS VALUES('Edward Red', 35, 'MISSING', 'None');
INSERT INTO VICTIMS VALUES('Fiona Yellow', 40, 'DISPLACED', 'None');
INSERT INTO VICTIMS VALUES('George Pink', 55, 'INJURED', 'Chest Pain');
INSERT INTO VICTIMS VALUES('Holly Violet', 25, 'DISPLACED', 'None');
INSERT INTO VICTIMS VALUES('Ian Brown', 60, 'MISSING', 'None');
INSERT INTO VICTIMS VALUES('Judy Green', 38, 'INJURED', 'Head Injury');
INSERT INTO VICTIMS VALUES('Kevin Gray', 32, 'DISPLACED', 'None');
INSERT INTO VICTIMS VALUES('Lily Black', 27, 'INJURED', 'Sprained Ankle');
INSERT INTO VICTIMS VALUES('Mike Orange', 47, 'DISPLACED', 'None');
INSERT INTO VICTIMS VALUES('Nancy Purple', 53, 'MISSING', 'None');
INSERT INTO VICTIMS VALUES('Oliver Blue', 60, 'INJURED', 'Leg Injury');

INSERT INTO VOLUNTEERS VALUES(3, 'First Aid, Search and Rescue', 'Available');
INSERT INTO VOLUNTEERS VALUES(4, 'Search and Rescue', 'Available');
INSERT INTO VOLUNTEERS VALUES(5, 'Medical Assistance, Logistics', 'Unavailable');
INSERT INTO VOLUNTEERS VALUES(6, 'Logistics, Food Distribution', 'Available');
INSERT INTO VOLUNTEERS VALUES(7, 'Search and Rescue, First Aid', 'Unavailable');
INSERT INTO VOLUNTEERS VALUES(8, 'Logistics, Shelter Management', 'Available');
INSERT INTO VOLUNTEERS VALUES(9, 'First Aid, Medical Assistance', 'Available');
INSERT INTO VOLUNTEERS VALUES(10, 'Logistics, Distribution', 'Unavailable');
INSERT INTO VOLUNTEERS VALUES(11, 'Search and Rescue, Emergency Response', 'Available');
INSERT INTO VOLUNTEERS VALUES(12, 'First Aid, Shelter Management', 'Available');
INSERT INTO VOLUNTEERS VALUES(13, 'Logistics, Food Distribution', 'Unavailable');
INSERT INTO VOLUNTEERS VALUES(14, 'Search and Rescue', 'Available');
INSERT INTO VOLUNTEERS VALUES(15, 'First Aid, Shelter Management', 'Available');
INSERT INTO VOLUNTEERS VALUES(1, 'Medical Assistance, Search and Rescue', 'Unavailable');
INSERT INTO VOLUNTEERS VALUES(2, 'Logistics, Distribution', 'Available');


INSERT INTO SHELTERS VALUES ('Texas', 100, 'Restrooms, Water Supply, First Aid');
INSERT INTO SHELTERS VALUES ('California', 200, 'Restrooms, Water Supply, Food Distribution');
INSERT INTO SHELTERS VALUES ('Florida', 150, 'Restrooms, Water Supply');
INSERT INTO SHELTERS VALUES ('Oregon', 120, 'Restrooms, Medical Assistance');
INSERT INTO SHELTERS VALUES ('Louisiana', 80, 'Restrooms, Food Distribution');
INSERT INTO SHELTERS VALUES ('Missouri', 50, 'Restrooms, Water Supply');
INSERT INTO SHELTERS VALUES ('Kansas', 60, 'Restrooms, Shelter Beds');
INSERT INTO SHELTERS VALUES ('Bangladesh', 500, 'Water Supply, Restrooms, First Aid');
INSERT INTO SHELTERS VALUES ('Philippines', 300, 'Water Supply, Food Distribution');
INSERT INTO SHELTERS VALUES ('Chile', 400, 'Shelter Beds, Food Distribution');
INSERT INTO SHELTERS VALUES ('Nepal', 200, 'Medical Assistance, Shelter Beds');
INSERT INTO SHELTERS VALUES ('Australia', 100, 'Food Distribution, Shelter Beds');
INSERT INTO SHELTERS VALUES ('Mexico', 150, 'Water Supply, Medical Assistance');
INSERT INTO SHELTERS VALUES ('Japan', 100, 'Water Supply, First Aid');
INSERT INTO SHELTERS VALUES ('California', 80, 'Water Supply, Medical Assistance');

INSERT INTO DONATIONS VALUES (1, 1000.00, '2025-01-15');
INSERT INTO DONATIONS VALUES (2, 500.00, '2025-01-20');
INSERT INTO DONATIONS VALUES (3, 300.00, '2025-01-18');
INSERT INTO DONATIONS VALUES (4, 1500.00, '2025-01-25');
INSERT INTO DONATIONS VALUES (5, 200.00, '2025-02-05');
INSERT INTO DONATIONS VALUES (6, 700.00, '2025-01-28');
INSERT INTO DONATIONS VALUES (7, 1000.00, '2025-02-02');
INSERT INTO DONATIONS VALUES (8, 300.00, '2025-01-30');
INSERT INTO DONATIONS VALUES (9, 600.00, '2025-01-22');
INSERT INTO DONATIONS VALUES (10, 400.00, '2025-02-12');
INSERT INTO DONATIONS VALUES (11, 800.00, '2025-01-15');
INSERT INTO DONATIONS VALUES (12, 250.00, '2025-02-05');
INSERT INTO DONATIONS VALUES (13, 950.00, '2025-01-28');
INSERT INTO DONATIONS VALUES (14, 300.00, '2025-01-20');
INSERT INTO DONATIONS VALUES (15, 1200.00, '2025-02-11');

INSERT INTO MEDICALASSISTANCE VALUES (1, 'Dr. Smith', 'Texas General');
INSERT INTO MEDICALASSISTANCE VALUES (2, 'Dr. Johnson', 'California Medical Center');
INSERT INTO MEDICALASSISTANCE VALUES (3, 'Dr. Lee', 'Florida Health Center');
INSERT INTO MEDICALASSISTANCE VALUES (4, 'Dr. Davis', 'Oregon Clinic');
INSERT INTO MEDICALASSISTANCE VALUES (5, 'Dr. Brown', 'Louisiana Medical Center');
INSERT INTO MEDICALASSISTANCE VALUES (6, 'Dr. Wilson', 'Missouri Health Hospital');
INSERT INTO MEDICALASSISTANCE VALUES (7, 'Dr. Taylor', 'Kansas Medical Center');
INSERT INTO MEDICALASSISTANCE VALUES (8, 'Dr. Thomas', 'Bangladesh Hospital');
INSERT INTO MEDICALASSISTANCE VALUES (9, 'Dr. Jackson', 'Philippines General');
INSERT INTO MEDICALASSISTANCE VALUES (10, 'Dr. Harris', 'Chile Health Center');
INSERT INTO MEDICALASSISTANCE VALUES (11, 'Dr. Clark', 'Nepal Clinic');
INSERT INTO MEDICALASSISTANCE VALUES (12, 'Dr. Walker', 'Australia Medical Center');
INSERT INTO MEDICALASSISTANCE VALUES (13, 'Dr. Robinson', 'Mexico Health Center');
INSERT INTO MEDICALASSISTANCE VALUES (14, 'Dr. Lewis', 'Japan General');
INSERT INTO MEDICALASSISTANCE VALUES (15, 'Dr. Young', 'California Health Clinic');

INSERT INTO EMERGENCYCALLS (DISASTER_ID, CALLER_NAME, LOCATION, EMERGENCY_TYPE, TIME) VALUES
(1, 'Alice Green', 'California', 'Fire', '2025-01-15 08:00'),
(2, 'Bob White', 'Texas', 'Flood', '2025-01-18 09:00'),
(3, 'Charlie Black', 'Kansas', 'Tornado', '2025-02-02 07:30'),
(4, 'Debbie Blue', 'Oregon', 'Fire', '2025-01-25 10:00'),
(5, 'Edward Red', 'Louisiana', 'Flood', '2025-02-10 12:15'),
(6, 'Fiona Yellow', 'Florida', 'Hurricane', '2025-02-05 14:45'),
(7, 'George Pink', 'Japan', 'Earthquake', '2025-02-14 16:00'),
(8, 'Holly Violet', 'Missouri', 'Flood', '2025-01-30 18:00'),
(9, 'Ian Brown', 'Bangladesh', 'Flood', '2025-01-20 19:30'),
(10, 'Judy Green', 'Nepal', 'Landslide', '2025-02-08 20:15'),
(11, 'Kevin Gray', 'Chile', 'Earthquake', '2025-01-28 21:00'),
(12, 'Lily Black', 'Missouri', 'Flood', '2025-02-11 22:45'),
(13, 'Mike Orange', 'Philippines', 'Flood', '2025-02-16 23:00'),
(14, 'Nancy Purple', 'Mexico', 'Hurricane', '2025-02-12 00:30'),
(15, 'Oliver Blue', 'Australia', 'Fire', '2025-01-22 01:00');

INSERT INTO TRANSPORT VALUES ('Ambulance', 2, 'California');
INSERT INTO TRANSPORT VALUES ('Rescue Boat', 10, 'Texas');
INSERT INTO TRANSPORT VALUES ('Truck', 20, 'Florida');
INSERT INTO TRANSPORT VALUES ('Helicopter', 5, 'Oregon');
INSERT INTO TRANSPORT VALUES ('Ambulance', 2, 'Louisiana');
INSERT INTO TRANSPORT VALUES ('Truck', 15, 'Missouri');
INSERT INTO TRANSPORT VALUES ('Rescue Boat', 10, 'Kansas');
INSERT INTO TRANSPORT VALUES ('Helicopter', 6, 'Bangladesh');
INSERT INTO TRANSPORT VALUES ('Truck', 20, 'Chile');
INSERT INTO TRANSPORT VALUES ('Ambulance', 3, 'Nepal');
INSERT INTO TRANSPORT VALUES ('Rescue Boat', 15, 'Australia');
INSERT INTO TRANSPORT VALUES ('Truck', 25, 'Mexico');
INSERT INTO TRANSPORT VALUES ('Ambulance', 4, 'Japan');
INSERT INTO TRANSPORT VALUES ('Helicopter', 5, 'California');
INSERT INTO TRANSPORT VALUES ('Rescue Boat', 12, 'Philippines');

INSERT INTO WEATHERFORECAST VALUES ('2025-01-15', 'California', 'Clear');
INSERT INTO WEATHERFORECAST VALUES ('2025-01-18', 'Texas', 'Rainy');
INSERT INTO WEATHERFORECAST VALUES ('2025-02-02', 'Kansas', 'Stormy');
INSERT INTO WEATHERFORECAST VALUES ('2025-01-25', 'Oregon', 'Sunny');
INSERT INTO WEATHERFORECAST VALUES ('2025-02-05', 'Florida', 'Windy');
INSERT INTO WEATHERFORECAST VALUES ('2025-02-14', 'Japan', 'Clear');
INSERT INTO WEATHERFORECAST VALUES ('2025-01-20', 'Louisiana', 'Rainy');
INSERT INTO WEATHERFORECAST VALUES ('2025-01-30', 'Missouri', 'Clear');
INSERT INTO WEATHERFORECAST VALUES ('2025-02-08', 'Bangladesh', 'Stormy');
INSERT INTO WEATHERFORECAST VALUES ('2025-01-28', 'Chile', 'Sunny');
INSERT INTO WEATHERFORECAST VALUES ('2025-02-11', 'Nepal', 'Cloudy');
INSERT INTO WEATHERFORECAST VALUES ('2025-01-22', 'Australia', 'Windy');
INSERT INTO WEATHERFORECAST VALUES ('2025-02-12', 'Mexico', 'Clear');
INSERT INTO WEATHERFORECAST VALUES ('2025-02-16', 'Philippines', 'Rainy');
INSERT INTO WEATHERFORECAST VALUES ('2025-02-05', 'Florida', 'Clear');

INSERT INTO AI_PREDICTIONS VALUES (1, 1, 0.75, '2025-01-12');
INSERT INTO AI_PREDICTIONS VALUES (2, 2, 0.80, '2025-01-17');
INSERT INTO AI_PREDICTIONS VALUES (3, 3, 0.85, '2025-02-01');
INSERT INTO AI_PREDICTIONS VALUES (4, 4, 0.90, '2025-01-24');
INSERT INTO AI_PREDICTIONS VALUES (5, 5, 0.70, '2025-02-09');
INSERT INTO AI_PREDICTIONS VALUES (6, 6, 0.95, '2025-02-04');
INSERT INTO AI_PREDICTIONS VALUES (7, 7, 0.60, '2025-02-13');
INSERT INTO AI_PREDICTIONS VALUES (8, 8, 0.80, '2025-01-29');
INSERT INTO AI_PREDICTIONS VALUES (9, 9, 0.85, '2025-01-19');
INSERT INTO AI_PREDICTIONS VALUES (10, 10, 0.90, '2025-02-07');
INSERT INTO AI_PREDICTIONS VALUES (11, 11, 0.70, '2025-01-21');
INSERT INTO AI_PREDICTIONS VALUES (12, 12, 0.75, '2025-02-10');
INSERT INTO AI_PREDICTIONS VALUES (13, 13, 0.85, '2025-02-06');
INSERT INTO AI_PREDICTIONS VALUES (14, 14, 0.90, '2025-02-11');
INSERT INTO AI_PREDICTIONS VALUES (15, 15, 0.65, '2025-01-23');

INSERT INTO ALERTS VALUES (1, 'Severe Earthquake in California. Evacuate immediately.', 1, '2025-01-15 08:30');
INSERT INTO ALERTS VALUES (2, 'Flood warning in Texas. Seek higher ground.', 2, '2025-01-18 09:15');
INSERT INTO ALERTS VALUES (3, 'Tornado warning in Kansas. Take shelter.', 3, '2025-02-02 08:00');
INSERT INTO ALERTS VALUES (4, 'Fire alert in Oregon. Evacuate the area.', 4, '2025-01-25 10:30');
INSERT INTO ALERTS VALUES (5, 'Flood alert in Louisiana. Prepare for evacuation.', 5, '2025-02-10 12:00');
INSERT INTO ALERTS VALUES (6, 'Hurricane warning in Florida. Seek shelter immediately.', 6, '2025-02-05 14:00');
INSERT INTO ALERTS VALUES (7, 'Earthquake alert in Japan. Prepare for aftershocks.', 7, '2025-02-14 16:15');
INSERT INTO ALERTS VALUES (8, 'Flood warning in Missouri. Avoid flooded areas.', 8, '2025-01-30 18:30');
INSERT INTO ALERTS VALUES (9, 'Flood alert in Bangladesh. Evacuate the region.', 9, '2025-01-20 19:45');
INSERT INTO ALERTS VALUES (10, 'Landslide risk in Nepal. Avoid high-risk zones.', 10, '2025-02-08 20:30');
INSERT INTO ALERTS VALUES (11, 'Earthquake warning in Chile. Stay alert.', 11, '2025-01-28 21:15');
INSERT INTO ALERTS VALUES (12, 'Flood alert in Missouri. Seek shelter.', 12, '2025-02-11 23:15');
INSERT INTO ALERTS VALUES (13, 'Flood warning in Philippines. Evacuate the area.', 13, '2025-02-16 23:30');
INSERT INTO ALERTS VALUES (14, 'Hurricane warning in Mexico. Seek safety immediately.', 14, '2025-02-12 00:45');
INSERT INTO ALERTS VALUES (15, 'Fire warning in Australia. Evacuate affected areas.', 15, '2025-02-17 01:00');

INSERT INTO INCIDENTREPORTS VALUES (1, 1, 'Severe earthquake caused multiple building collapses.', '2025-01-16');
INSERT INTO INCIDENTREPORTS VALUES (2, 2, 'Heavy rains flooded streets and homes.', '2025-01-19');
INSERT INTO INCIDENTREPORTS VALUES (3, 3, 'Tornado destroyed several houses and power lines.', '2025-02-03');
INSERT INTO INCIDENTREPORTS VALUES (4, 4, 'Wildfire spread rapidly due to strong winds.', '2025-01-26');
INSERT INTO INCIDENTREPORTS VALUES (5, 5, 'Major flooding in coastal areas.', '2025-02-11');
INSERT INTO INCIDENTREPORTS VALUES (6, 6, 'High-speed winds and rain caused devastation.', '2025-02-06');
INSERT INTO INCIDENTREPORTS VALUES (7, 7, 'Moderate earthquake shook buildings, minor damage reported.', '2025-02-15');
INSERT INTO INCIDENTREPORTS VALUES (8, 8, 'Forest fire started near residential areas.', '2025-01-31');
INSERT INTO INCIDENTREPORTS VALUES (9, 9, 'Severe flooding affected thousands of people.', '2025-01-21');
INSERT INTO INCIDENTREPORTS VALUES (10, 10, 'Heavy rains triggered a landslide, blocking roads.', '2025-02-09');
INSERT INTO INCIDENTREPORTS VALUES (11, 11, 'Strong tremors felt, causing significant damage.', '2025-01-29');
INSERT INTO INCIDENTREPORTS VALUES (12, 12, 'Tornado destroyed farmlands and power lines.', '2025-02-12');
INSERT INTO INCIDENTREPORTS VALUES (13, 13, 'Heavy rainfall led to widespread flooding.', '2025-02-17');
INSERT INTO INCIDENTREPORTS VALUES (14, 14, 'Hurricane caused infrastructure damage and power outages.', '2025-02-13');
INSERT INTO INCIDENTREPORTS VALUES (15, 15, 'Massive bushfire spread across dry lands.', '2025-01-23');


-----------------------------------------------------------------------------------
---                                  RETRIVE                                    ---
-----------------------------------------------------------------------------------
SELECT * FROM USERS;
SELECT * FROM DISASTERS;
SELECT * FROM RESCUETEAMS;
SELECT * FROM RESOURCES;
SELECT * FROM VICTIMS;
SELECT * FROM VOLUNTEERS;
SELECT * FROM SHELTERS;
SELECT * FROM DONATIONS;
SELECT * FROM MEDICALASSISTANCE;
SELECT * FROM EMERGENCYCALLS;
SELECT * FROM TRANSPORT;
SELECT * FROM WEATHERFORECAST;
SELECT * FROM AI_PREDICTIONS;
SELECT * FROM ALERTS;
SELECT * FROM INCIDENTREPORTS;



-----------------------------------------------------------------------------------
---                                   QUERY                                     ---
-----------------------------------------------------------------------------------

---Basic SELECT Queries

---1.List all users and their roles
SELECT USER_ID, NAME, ROLE FROM USERS;

---2.Get all disasters that occurred in first month of 2025
SELECT * FROM DISASTERS
WHERE DATE BETWEEN '2025-01-01' AND '2025-01-31';


---3.Show all victims who are injured
SELECT * FROM VICTIMS WHERE STATUS = 'INJURED';

---4.Display donations made above ₹1,000
SELECT * FROM DONATIONS WHERE AMOUNT > 1000;

---5.List all available shelters with capacity over 100
SELECT * FROM SHELTERS WHERE CAPACITY > 100;


---JOIN Queries

---6.List rescue teams with their user names
SELECT RT.TEAM_ID, U.NAME, RT.TEAM_NAME 
FROM RESCUETEAMS RT
JOIN USERS U ON RT.USER_ID = U.USER_ID;

---7.Show volunteers and their skills
SELECT V.VOLUNTEER_ID, U.NAME, V.SKILLS 
FROM VOLUNTEERS V
JOIN USERS U ON V.USER_ID = U.USER_ID;

---8.List donations with donor name and amount
SELECT D.DONATION_ID, U.NAME AS DONOR_NAME, D.AMOUNT 
FROM DONATIONS D
JOIN USERS U ON D.USER_ID = U.USER_ID;

---9.Display alerts with disaster type and issuer name
SELECT A.ALERT_MESSAGE, D.TYPE AS DISASTER_TYPE, U.NAME AS ISSUER 
FROM ALERTS A
JOIN DISASTERS D ON A.DISASTER_ID = D.DISASTER_ID
JOIN USERS U ON A.ISSUED_BY = U.USER_ID;

---10.Get AI predictions with disaster and weather condition
SELECT A.PREDICTION_ID, D.TYPE AS DISASTER, W.WEATHER_CONDITION, A.PROBABILITY 
FROM AI_PREDICTIONS A
JOIN DISASTERS D ON A.DISASTER_ID = D.DISASTER_ID
JOIN WEATHERFORECAST W ON A.WEATHER_ID = W.WEATHER_ID;

---Advanced Joins

---11.LEFT JOIN: List all disasters and any reports filed
SELECT D.TYPE, R.REPORT_DETAILS 
FROM DISASTERS D
LEFT JOIN INCIDENTREPORTS R ON D.DISASTER_ID = R.DISASTER_ID;

---12.RIGHT JOIN: Victims who received medical help
SELECT V.NAME, M.HOSPITAL 
FROM MEDICALASSISTANCE M
RIGHT JOIN VICTIMS V ON M.VICTIM_ID = V.VICTIM_ID;

---13.FULL OUTER JOIN: All users and their donations (including non-donors)
SELECT U.NAME, D.AMOUNT 
FROM USERS U
FULL OUTER JOIN DONATIONS D ON U.USER_ID = D.USER_ID;

---Aggregate Functions

---14.Count number of disasters per location
SELECT LOCATION, COUNT(*) AS TOTAL_DISASTERS 
FROM DISASTERS 
GROUP BY LOCATION;

---15.Total donation amount received
SELECT SUM(AMOUNT) AS TOTAL_DONATIONS FROM DONATIONS;

---16.Average donation amount
SELECT AVG(AMOUNT) AS AVERAGE_DONATION FROM DONATIONS;

---17.Maximum and minimum capacity of shelters
SELECT MAX(CAPACITY) AS MAX_CAPACITY, MIN(CAPACITY) AS MIN_CAPACITY 
FROM SHELTERS;

---18.Count of victims by status
SELECT STATUS, COUNT(*) AS COUNT 
FROM VICTIMS 
GROUP BY STATUS;


---GROUP BY and ORDER BY

---19.Top 5 donors by amount
SELECT U.NAME, SUM(D.AMOUNT) AS TOTAL_DONATED
FROM DONATIONS D
JOIN USERS U ON D.USER_ID = U.USER_ID
GROUP BY U.NAME
ORDER BY TOTAL_DONATED DESC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;

---20.Number of volunteers per availability status
SELECT AVAILABILITY, COUNT(*) AS TOTAL 
FROM VOLUNTEERS 
GROUP BY AVAILABILITY;

---21.Number of calls received per disaster
SELECT D.TYPE, COUNT(*) AS CALL_COUNT 
FROM EMERGENCYCALLS C
JOIN DISASTERS D ON C.DISASTER_ID = D.DISASTER_ID
GROUP BY D.TYPE;


---Views

---22.Create a view for active volunteers
CREATE VIEW ACTIVE_VOLUNTEERS AS
SELECT V.VOLUNTEER_ID, U.NAME, V.SKILLS 
FROM VOLUNTEERS V
JOIN USERS U ON V.USER_ID = U.USER_ID
WHERE V.AVAILABILITY = 'AVAILABLE';
select * from ACTIVE_VOLUNTEERS;

---23.View of total victims and their medical status
CREATE VIEW VICTIM_MEDICAL_INFO AS
SELECT V.NAME, V.STATUS, M.HOSPITAL, M.ASSIGNED_DOCTOR 
FROM VICTIMS V
LEFT JOIN MEDICALASSISTANCE M ON V.VICTIM_ID = M.VICTIM_ID;
select * from VICTIM_MEDICAL_INFO;

---24.View of disasters and corresponding alerts
CREATE VIEW DISASTER_ALERTS AS
SELECT D.TYPE, D.LOCATION, A.ALERT_MESSAGE, A.ISSUED_DATE 
FROM DISASTERS D
JOIN ALERTS A ON D.DISASTER_ID = A.DISASTER_ID;
select * from DISASTER_ALERTS;


---Date and Time Functions

---25.List all incidents reported in the last 30 days
SELECT *
FROM DISASTERS
WHERE date >= '2025-01-01' AND date < '2025-02-01';


---26.Show emergency calls received this week
SELECT call_id, disaster_id, caller_name, location, emergency_type, time
FROM EMERGENCYCALLS
WHERE time >= DATEADD(DAY, -7, '2025-02-16') 
  AND time <= '2025-02-16';


---27.Get weather forecast for the next 7 days
SELECT *
FROM WEATHERFORECAST
WHERE date BETWEEN '2025-02-10' AND '2025-02-17';


---Transport & Logistics Queries

---28.List transport vehicles available in 'California'
SELECT * FROM TRANSPORT WHERE LOCATION = 'California';

---29.Average transport capacity per vehicle type
SELECT VEHICLE_TYPE, AVG(CAPACITY) AS AVG_CAPACITY 
FROM TRANSPORT 
GROUP BY VEHICLE_TYPE;

---30.Show all vehicles sorted by capacity (descending)
SELECT * FROM TRANSPORT 
ORDER BY CAPACITY DESC;
