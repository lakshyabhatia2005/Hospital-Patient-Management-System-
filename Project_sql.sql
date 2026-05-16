CREATE DATABASE DDB;
USE DDB;

-- ========================
-- Database Schema (DDL)
-- ========================

CREATE TABLE Department (
    Department_ID INT PRIMARY KEY,
    Department_Name VARCHAR(150) NOT NULL,
    Location VARCHAR(100),
    Phone_Number VARCHAR(10),
    D_Email VARCHAR(100)
);

CREATE TABLE Staff (
    Staff_ID INT PRIMARY KEY,
    Name VARCHAR(150) NOT NULL,
    Role VARCHAR(50),
    Department_ID INT,
    Contact_Number VARCHAR(10),
    Email VARCHAR(100),
    FOREIGN KEY (Department_ID) REFERENCES Department(Department_ID)
);

CREATE TABLE Patient (
    Patient_ID INT PRIMARY KEY,
    Name VARCHAR(150),
    DOB DATE,
    Gender VARCHAR(6),
    Contact_Number VARCHAR(10),
    Address VARCHAR(200),
    MedicalHistory JSON
);

CREATE TABLE OutPatient (
    Patient_ID INT PRIMARY KEY,
    Name VARCHAR(150),
    DOB DATE,
    Gender VARCHAR(6),
    Contact_Number VARCHAR(10),
    Address VARCHAR(200),
    MedicalHistory JSON
);

CREATE TABLE Room (
    Room_ID INT PRIMARY KEY,
    Room_Number VARCHAR(150) NOT NULL,
    Department_ID INT,
    RoomType VARCHAR(10),
    Capacity INT,
    Status VARCHAR(30),
    FOREIGN KEY (Department_ID) REFERENCES Department(Department_ID)
);

CREATE TABLE Appointment (
    Appointment_ID INT PRIMARY KEY,
    Patient_ID INT,
    Staff_ID INT,
    Appointment_Date DATE,
    Status VARCHAR(10),
    Room_ID INT,
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID),
    FOREIGN KEY (Staff_ID) REFERENCES Staff(Staff_ID),
    FOREIGN KEY (Room_ID) REFERENCES Room(Room_ID)
);

CREATE TABLE OutPatientAppointment (
    Appointment_ID INT PRIMARY KEY,
    Patient_ID INT,
    Staff_ID INT,
    Appointment_Date DATE,
    Status VARCHAR(10),
    FOREIGN KEY (Patient_ID) REFERENCES OutPatient(Patient_ID),
    FOREIGN KEY (Staff_ID) REFERENCES Staff(Staff_ID)
);

CREATE TABLE Billing (
    Billing_ID INT PRIMARY KEY,
    Appointment_ID INT,
    Amount DECIMAL(10,2),
    Payment_Status VARCHAR(10),
    Billing_Date DATE,
    Payment_Method VARCHAR(15),
    FOREIGN KEY (Appointment_ID) REFERENCES Appointment(Appointment_ID)
);

CREATE TABLE OutPatientBilling (
    Billing_ID INT PRIMARY KEY,
    Appointment_ID INT,
    Amount DECIMAL(10,2),
    Payment_Status VARCHAR(10),
    Billing_Date DATE,
    Payment_Method VARCHAR(15),
    FOREIGN KEY (Appointment_ID) REFERENCES OutPatientAppointment(Appointment_ID)
);

-- ==========================
-- DML
-- ==========================

-- Department (10 rows)
INSERT INTO Department
(Department_ID, Department_Name, Location, Phone_Number, D_Email)
VALUES
(1, 'Cardiology', '1st Floor', '0123456781', 'cardio@hospital.com'),
(2, 'Neurology', '2nd Floor', '0123456782', 'neuro@hospital.com'),
(3, 'Orthopedics', '3rd Floor', '0123456783', 'ortho@hospital.com'),
(4, 'Pediatrics', '4th Floor', '0123456784', 'ped@hospital.com'),
(5, 'Dermatology', '5th Floor', '0123456785', 'derma@hospital.com'),
(6, 'Ophthalmology', '6th Floor', '0123456786', 'eye@hospital.com'),
(7, 'ENT', '7th Floor', '0123456787', 'ent@hospital.com'),
(8, 'Emergency', 'Ground Floor', '0123456788', 'er@hospital.com'),
(9, 'Gastroenterology', '8th Floor', '0123456789', 'gastro@hospital.com'),
(10, 'ICU', '9th Floor', '0123456790', 'icu@hospital.com');

-- Staff (10 rows)
INSERT INTO Staff VALUES
(101, 'Dr. Smith', 'Head',   1, '0123457001', 'smith@hospital.com'),
(102, 'Dr. Lee', 'Head',     2, '0123457002', 'lee@hospital.com'),
(103, 'Dr. Patel', 'Head',   3, '0123457003', 'patel@hospital.com'),
(104, 'Dr. Kim', 'Head',     4, '0123457004', 'kim@hospital.com'),
(105, 'Dr. Brown', 'Head',   5, '0123457005', 'brown@hospital.com'),
(106, 'Dr. Clark', 'Head',   6, '0123457006', 'clark@hospital.com'),
(107, 'Dr. Adams', 'Head',   7, '0123457007', 'adams@hospital.com'),
(108, 'Dr. Jones', 'Head',   8, '0123457008', 'jones@hospital.com'),
(109, 'Dr. Garcia', 'Head',  9, '0123457009', 'garcia@hospital.com'),
(110, 'Dr. Wilson', 'Head', 10, '0123457010', 'wilson@hospital.com');

-- IN Patient (10 rows)
INSERT INTO Patient VALUES
(1001, 'John Doe',    '1980-05-12', 'Male',   '9876543210', '123 Elm St', '{"allergies":["penicillin"],"surgeries":[{"name":"appendectomy","year":2010}]}'),
(1002, 'Jane Smith',  '1992-07-20', 'Female', '9876543211', '125 Oak St', '{"allergies":[],"surgeries":[]}'),
(1003, 'Alice Lee',   '1975-03-09', 'Female', '9876543212', '127 Pine St', '{"allergies":["aspirin"],"surgeries":[{"name":"knee replacement","year":2018}]}'),
(1004, 'Bob Patel',   '2000-01-31', 'Male',   '9876543213', '129 Cedar St', '{"allergies":[],"surgeries":[{"name":"tonselectomy","year":2012}]}'),
(1005, 'Tom Kim',     '1985-09-15', 'Male',   '9876543214', '131 Maple St', '{"allergies":["penicillin"],"surgeries":[]}'),
(1006, 'Mary Brown',  '1983-12-18', 'Female', '9876543215', '133 Spruce St', '{"allergies":["latex"],"surgeries":[]}'),
(1007, 'Lisa Clark',  '1994-02-20', 'Female', '9876543216', '135 Birch St', '{"allergies":[],"surgeries":[]}'),
(1008, 'Mike Adams',  '1972-11-05', 'Male',   '9876543217', '137 Fir St', '{"allergies":["nuts"],"surgeries":[{"name":"bypass","year":2015}]}'),
(1009, 'Sara Jones',  '1991-05-11', 'Female', '9876543218', '139 Cherry St', '{"allergies":[],"surgeries":[]}'),
(1010, 'Sam Garcia',  '1986-06-22', 'Male',   '9876543219', '141 Willow St', '{"allergies":["pollen"],"surgeries":[]}');

-- OUT Patient (10 rows)
INSERT INTO OutPatient VALUES
(2001, 'Peter Pioneer', '1981-10-17', 'Male',    '9876543301', '201 Aspen St', '{"allergies":["morphine"],"surgeries":[{"name":"hernia","year":2018}]}'),
(2002, 'Lisa River',    '1977-08-12', 'Female',  '9876543302', '203 Magnolia St', '{"allergies":[],"surgeries":[]}'),
(2003, 'George Best',   '1985-04-09', 'Male',    '9876543303', '205 Palm St', '{"allergies":["dust"],"surgeries":[]}'),
(2004, 'Eva Grant',     '1992-12-22', 'Female',  '9876543304', '207 Olive St', '{"allergies":["penicillin"],"surgeries":[{"name":"tonsillectomy","year":2011}]}'),
(2005, 'Mona Singh',    '1990-06-27', 'Female',  '9876543305', '209 Maple St', '{"allergies":[],"surgeries":[]}'),
(2006, 'Kane Morris',   '1983-03-15', 'Male',    '9876543306', '211 Cedar St', '{"allergies":["pollen"],"surgeries":[]}'),
(2007, 'Rose Tyler',    '1987-05-19', 'Female',  '9876543307', '213 Pine St', '{"allergies":["peanut"],"surgeries":[]}'),
(2008, 'Henry Ford',    '1978-09-13', 'Male',    '9876543308', '215 Oak St', '{"allergies":["gluten"],"surgeries":[] }'),
(2009, 'Gina Costa',    '1993-11-06', 'Female',  '9876543309', '217 Elm St', '{"allergies":[],"surgeries":[]}'),
(2010, 'Rick James',    '1982-04-24', 'Male',    '9876543310', '219 Spruce St', '{"allergies":["aspirin"],"surgeries":[]}');

-- Room (10 rows)
INSERT INTO Room VALUES
(201, 'C101', 1, 'ICU', 2, 'Available'),
(202, 'N201', 2, 'General', 6, 'Occupied'),
(203, 'O301', 3, 'ICU', 2, 'Available'),
(204, 'P401', 4, 'General', 4, 'Available'),
(205, 'D501', 5, 'General', 5, 'Occupied'),
(206, 'E601', 6, 'ICU', 3, 'Available'),
(207, 'T701', 7, 'General', 2, 'Available'),
(208, 'ER01', 8, 'ICU', 3, 'Occupied'),
(209, 'G801', 9, 'General', 2, 'Available'),
(210, 'I901', 10, 'ICU', 1, 'Available');

-- Appointment (10 rows)
INSERT INTO Appointment VALUES
(301, 1001, 101, '2025-11-01', 'Scheduled', 201),
(302, 1002, 102, '2025-11-02', 'Completed', 202),
(303, 1003, 103, '2025-11-03', 'Scheduled', 203),
(304, 1004, 104, '2025-11-04', 'Cancelled', 204),
(305, 1005, 105, '2025-11-05', 'Scheduled', 205),
(306, 1006, 106, '2025-11-06', 'Completed', 206),
(307, 1007, 107, '2025-11-07', 'Scheduled', 207),
(308, 1008, 108, '2025-11-08', 'Scheduled', 208),
(309, 1009, 109, '2025-11-09', 'Completed', 209),
(310, 1010, 110, '2025-11-10', 'Scheduled', 210);

-- OutPatientAppointment (10 rows for OutPatients)
INSERT INTO OutPatientAppointment VALUES
(401, 2001, 101, '2025-11-01', 'Scheduled'),
(402, 2002, 102, '2025-11-02', 'Completed'),
(403, 2003, 103, '2025-11-03', 'Scheduled'),
(404, 2004, 104, '2025-11-04', 'Cancelled'),
(405, 2005, 105, '2025-11-05', 'Scheduled'),
(406, 2006, 106, '2025-11-06', 'Completed'),
(407, 2007, 107, '2025-11-07', 'Scheduled'),
(408, 2008, 108, '2025-11-08', 'Scheduled'),
(409, 2009, 109, '2025-11-09', 'Completed'),
(410, 2010, 110, '2025-11-10', 'Scheduled');

-- Billing (10 rows)
INSERT INTO Billing VALUES
(501, 301, 5000.00, 'Paid', '2025-11-01', 'Credit Card'),
(502, 302, 2500.00, 'Unpaid', '2025-11-02', 'Cash'),
(503, 303, 7000.00, 'Paid', '2025-11-03', 'Debit Card'),
(504, 304, 1200.00, 'Paid', '2025-11-04', 'Credit Card'),
(505, 305, 3200.00, 'Paid', '2025-11-05', 'Insurance'),
(506, 306, 8000.00, 'Unpaid', '2025-11-06', 'Cash'),
(507, 307, 1500.00, 'Paid', '2025-11-07', 'Insurance'),
(508, 308, 2100.00, 'Paid', '2025-11-08', 'Credit Card'),
(509, 309, 4300.00, 'Unpaid', '2025-11-09', 'Debit Card'),
(510, 310, 2600.00, 'Paid', '2025-11-10', 'Cash');

-- OutPatientBilling (10 rows)
INSERT INTO OutPatientBilling VALUES
(601, 401, 1300.00, 'Paid', '2025-11-01', 'Cash'),
(602, 402, 1800.00, 'Unpaid', '2025-11-02', 'Credit Card'),
(603, 403, 2400.00, 'Paid', '2025-11-03', 'Debit Card'),
(604, 404, 900.00, 'Paid', '2025-11-04', 'Credit Card'),
(605, 405, 1100.00, 'Paid', '2025-11-05', 'Insurance'),
(606, 406, 1200.00, 'Unpaid', '2025-11-06', 'Cash'),
(607, 407, 800.00, 'Paid', '2025-11-07', 'Insurance'),
(608, 408, 1700.00, 'Paid', '2025-11-08', 'Credit Card'),
(609, 409, 2500.00, 'Unpaid', '2025-11-09', 'Debit Card'),
(610, 410, 1400.00, 'Paid', '2025-11-10', 'Cash');

-- =========================
-- Indexes for Performance
-- =========================

CREATE INDEX idx_patient_name ON Patient(Name);
CREATE INDEX idx_appointment_patient ON Appointment(Patient_ID);
CREATE INDEX idx_billing_appointment ON Billing(Appointment_ID);
CREATE INDEX idx_outpatient_name ON OutPatient(Name);
CREATE INDEX idx_outappointment_patient ON OutPatientAppointment(Patient_ID);
CREATE INDEX idx_outbilling_appointment ON OutPatientBilling(Appointment_ID);
CREATE INDEX idx_room_status ON Room(Status);

SHOW INDEXES FROM Patient;
SHOW INDEXES FROM OutPatient;
SHOW INDEXES FROM Appointment;
SHOW INDEXES FROM OutPatientAppointment;
SHOW INDEXES FROM Billing;
SHOW INDEXES FROM OutPatientBilling;
SHOW INDEXES FROM Room;

-- ==========================================
-- Key SELECT Queries (Complex/Joins/Agg)
-- ==========================================

-- 1. Patient, doctor, last appointment (IN + OUT)
SELECT 'InPatient' AS PatientType, p.Name, s.Name AS Doctor, a.Appointment_Date
FROM Patient p
JOIN Appointment a ON p.Patient_ID = a.Patient_ID
JOIN Staff s ON a.Staff_ID = s.Staff_ID
UNION ALL
SELECT 'OutPatient' AS PatientType, op.Name, s.Name AS Doctor, opa.Appointment_Date
FROM OutPatient op
JOIN OutPatientAppointment opa ON op.Patient_ID = opa.Patient_ID
JOIN Staff s ON opa.Staff_ID = s.Staff_ID
ORDER BY Appointment_Date DESC;

-- 2. Total billing per patient (IN + OUT)
SELECT 'InPatient' AS PatientType, p.Name, SUM(b.Amount) AS Total_Billed
FROM Patient p
JOIN Appointment a ON p.Patient_ID = a.Patient_ID
JOIN Billing b ON a.Appointment_ID = b.Appointment_ID
GROUP BY p.Name
UNION ALL
SELECT 'OutPatient' AS PatientType, op.Name, SUM(ob.Amount) AS Total_Billed
FROM OutPatient op
JOIN OutPatientAppointment opa ON op.Patient_ID = opa.Patient_ID
JOIN OutPatientBilling ob ON opa.Appointment_ID = ob.Appointment_ID
GROUP BY op.Name;

-- 3. Patients with penicillin allergy from JSON (IN + OUT)
SELECT Name FROM Patient
WHERE JSON_CONTAINS(MedicalHistory, '["penicillin"]', '$.allergies')
UNION
SELECT Name FROM OutPatient
WHERE JSON_CONTAINS(MedicalHistory, '["penicillin"]', '$.allergies');

-- 4. Available rooms by department
SELECT d.Department_Name, COUNT(*) AS AvailableRooms
FROM Room r
JOIN Department d ON r.Department_ID = d.Department_ID
WHERE r.Status = 'Available'
GROUP BY d.Department_Name;

-- 5. Find patients (IN) whose total billing is above average for their appointments (CSQ)
SELECT p.Name, 
       (SELECT SUM(b.Amount) 
        FROM Billing b
        JOIN Appointment a ON b.Appointment_ID = a.Appointment_ID
        WHERE a.Patient_ID = p.Patient_ID) AS PatientTotalBilling
FROM Patient p
WHERE (SELECT SUM(b.Amount) 
       FROM Billing b
       JOIN Appointment a ON b.Appointment_ID = a.Appointment_ID
       WHERE a.Patient_ID = p.Patient_ID) >
      (SELECT AVG(subtotal)
       FROM (SELECT SUM(b2.Amount) AS subtotal
             FROM Billing b2
             JOIN Appointment a2 ON b2.Appointment_ID = a2.Appointment_ID
             GROUP BY a2.Patient_ID) AS avgs);

-- 6. Find OutPatients whose total billing is above the average billing amount for OutPatient appointments (CSQ)
SELECT op.Name, 
       (SELECT SUM(ob.Amount) 
        FROM OutPatientBilling ob
        JOIN OutPatientAppointment opa ON ob.Appointment_ID = opa.Appointment_ID
        WHERE opa.Patient_ID = op.Patient_ID) AS PatientTotalBilling
FROM OutPatient op
WHERE (SELECT SUM(ob.Amount) 
       FROM OutPatientBilling ob
       JOIN OutPatientAppointment opa ON ob.Appointment_ID = opa.Appointment_ID
       WHERE opa.Patient_ID = op.Patient_ID) >
      (SELECT AVG(subtotal)
       FROM (SELECT SUM(ob2.Amount) AS subtotal
             FROM OutPatientBilling ob2
             JOIN OutPatientAppointment opa2 ON ob2.Appointment_ID = opa2.Appointment_ID
             GROUP BY opa2.Patient_ID) AS avgs);

-- 7. List the rooms assigned to departments located on the "1st Floor"
SELECT r.Room_Number, r.Status
FROM Room r
WHERE r.Department_ID IN (
    SELECT Department_ID FROM Department WHERE Location = '1st Floor'
);

-- =======================================
-- Procedures, Triggers, Transactions
-- =======================================

-- Procedure: Add new IN Patient
DELIMITER $$
CREATE PROCEDURE AddNewPatient(
    IN pName VARCHAR(150), IN pDOB DATE, IN pGender VARCHAR(6),
    IN pContact VARCHAR(10), IN pAddress VARCHAR(200), IN pMedicalHistory JSON)
BEGIN
    INSERT INTO Patient (Name, DOB, Gender, Contact_Number, Address, MedicalHistory)
    VALUES (pName, pDOB, pGender, pContact, pAddress, pMedicalHistory);
END $$
DELIMITER ;

-- Procedure: Add new OUT Patient
DELIMITER $$
CREATE PROCEDURE AddNewOutPatient(
    IN pName VARCHAR(150), IN pDOB DATE, IN pGender VARCHAR(6),
    IN pContact VARCHAR(10), IN pAddress VARCHAR(200), IN pMedicalHistory JSON)
BEGIN
    INSERT INTO OutPatient (Name, DOB, Gender, Contact_Number, Address, MedicalHistory)
    VALUES (pName, pDOB, pGender, pContact, pAddress, pMedicalHistory);
END $$
DELIMITER ;

-- Audit trail feature: Table + trigger for Billing inserts
CREATE TABLE Billing_Audit (
    Audit_ID INT AUTO_INCREMENT PRIMARY KEY,
    Billing_ID INT,
    Amount DECIMAL(10,2),
    Action VARCHAR(10),
    ActionTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$
CREATE TRIGGER Billing_Insert_Audit
AFTER INSERT ON Billing
FOR EACH ROW
BEGIN
    INSERT INTO Billing_Audit (Billing_ID, Amount, Action) 
    VALUES (NEW.Billing_ID, NEW.Amount, 'INSERT');
END $$
DELIMITER ;

-- Transaction example for IN Patient and Billing
START TRANSACTION;
INSERT INTO Patient VALUES (1011, 'New Patient', '1970-01-02', 'Male', '9876543220', '150 Palm St', '{}');
SAVEPOINT before_billing;
INSERT INTO Billing VALUES (511, 301, 2700.00, 'Paid', '2025-11-11', 'Cash');
-- ROLLBACK TO SAVEPOINT before_billing; -- Uncomment to rollback
COMMIT;

-- Transaction example for OUT Patient and Billing
START TRANSACTION;
INSERT INTO OutPatient VALUES (2011, 'New OutPatient', '1982-06-10', 'Female', '9876543320', '221 Palm St', '{}');
SAVEPOINT before_billing_out;
INSERT INTO OutPatientBilling VALUES (611, 401, 2100.00, 'Paid', '2025-11-11', 'Cash');
-- ROLLBACK TO SAVEPOINT before_billing_out; -- Uncomment to rollback
COMMIT;

-- =======================================
-- Example UPDATE / DELETE ops / ALTER
-- =======================================

-- Update the contact number of a patient (IN)
UPDATE Patient
SET Contact_Number = '9998887777'
WHERE Patient_ID = 1001;

-- Update the contact number of an OUT patient
UPDATE OutPatient
SET Contact_Number = '8889997777'
WHERE Patient_ID = 2001;

-- Delete a patient (IN)
DELETE FROM Patient
WHERE Patient_ID = 1011;

-- Delete an out patient (OUT)
DELETE FROM OutPatient
WHERE Patient_ID = 2011;

-- Add a New Column
ALTER TABLE Patient
ADD Blood_Group VARCHAR(5);

-- Modify the Data Type of a Column
ALTER TABLE Staff
MODIFY COLUMN Contact_Number VARCHAR(15);

-- =======================================
-- Task
-- =======================================

-- List all patients who have visited in the last six months (from Appointment table):

SELECT DISTINCT p.Patient_ID, p.Name, p.DOB, p.Gender, p.Contact_Number, p.Address
FROM Patient p
JOIN Appointment a ON p.Patient_ID = a.Patient_ID
WHERE a.Appointment_Date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH);


-- Generate hospital revenue from outpatient and inpatient appointments (Billing and OutPatientBilling):
SELECT 'InPatient' AS Patient_Type, SUM(b.Amount) AS Total_Revenue
FROM Billing b
UNION ALL
SELECT 'OutPatient' AS Patient_Type, SUM(opb.Amount) AS Total_Revenue
FROM OutPatientBilling opb;


-- Identify department with highest patient admissions past year
SELECT d.Department_Name, COUNT(*) AS Patient_Admissions
FROM Appointment a
JOIN Staff s ON a.Staff_ID = s.Staff_ID
JOIN Department d ON s.Department_ID = d.Department_ID
WHERE a.Appointment_Date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
GROUP BY d.Department_Name
ORDER BY Patient_Admissions DESC
LIMIT 1;




