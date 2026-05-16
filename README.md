# 🏥 Hospital Patient Management System
### A Relational Database Project using MySQL

> Designed to centralize and streamline hospital operations — from patient records and appointments to billing and audit trails.

---


## 📌 Problem Statement

Hospitals face major operational inefficiencies due to scattered, manually maintained records for patients, appointments, room assignments, and billing. This leads to data inconsistency, service delays, and lack of reliable performance insights. This project solves that with a unified relational database system.

---

## 🎯 Objectives

- Maintain accurate and unified In-Patient & Out-Patient records
- Automate appointment scheduling, billing cycles, and room allocation
- Provide analytical insights for staff and hospital management
- Ensure secure, auditable transaction logs for financial compliance
- Improve decision-making through structured, query-ready data

---

## 🗃️ Database Schema

The system contains **9 interconnected tables**:

| Table | Description |
|-------|-------------|
| `Department` | Stores all hospital departments (Cardiology, ICU, ENT, etc.) |
| `Staff` | Doctors and department heads linked to their departments |
| `Patient` | In-patient records with demographics and JSON medical history |
| `OutPatient` | Out-patient records with the same structure as Patient |
| `Room` | Room details — type (ICU/General), capacity, and occupancy status |
| `Appointment` | In-patient appointments linked to Patient, Staff, and Room |
| `OutPatientAppointment` | Appointment records specifically for out-patients |
| `Billing` | Billing for in-patient appointments (amount, payment method, status) |
| `OutPatientBilling` | Billing records for out-patient appointments |

### Entity Relationships
- `Staff` → `Department` (FK)
- `Room` → `Department` (FK)
- `Appointment` → `Patient`, `Staff`, `Room` (FK)
- `OutPatientAppointment` → `OutPatient`, `Staff` (FK)
- `Billing` → `Appointment` (FK)
- `OutPatientBilling` → `OutPatientAppointment` (FK)

---

## ⚙️ Key SQL Features Implemented

### ✅ DDL & DML
- Full schema creation with `PRIMARY KEY`, `FOREIGN KEY`, `NOT NULL`, and `DECIMAL` constraints
- Sample data inserted for 10 departments, 10 staff, 10 in-patients, 10 out-patients, rooms, appointments, and billing records

### ✅ Advanced Queries
- `UNION ALL` queries combining In-Patient and Out-Patient data
- **JSON querying** using `JSON_CONTAINS()` to find patients with specific allergies
- **Correlated Subqueries (CSQ)** to find patients billed above the average
- Room availability grouped by department
- Revenue generation from both patient types combined

### ✅ Stored Procedures
```sql
-- Add new In-Patient
CALL AddNewPatient('Name', '1990-01-01', 'Male', '9876543210', 'Address', '{}');

-- Add new Out-Patient
CALL AddNewOutPatient('Name', '1990-01-01', 'Female', '9876543210', 'Address', '{}');
```

### ✅ Trigger — Billing Audit Trail
```sql
-- Automatically logs every billing insert into Billing_Audit table
CREATE TRIGGER Billing_Insert_Audit
AFTER INSERT ON Billing
FOR EACH ROW ...
```

### ✅ Transactions with SAVEPOINT
```sql
START TRANSACTION;
INSERT INTO Patient ...;
SAVEPOINT before_billing;
INSERT INTO Billing ...;
-- ROLLBACK TO SAVEPOINT before_billing; -- optional rollback
COMMIT;
```

### ✅ ALTER Operations
- Added `Blood_Group` column to `Patient` table
- Modified `Contact_Number` data type in `Staff` table

---

## 📊 Sample Analytical Queries

```sql
-- 1. List all patients who visited in the last 6 months
SELECT DISTINCT p.Patient_ID, p.Name ...
WHERE a.Appointment_Date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH);

-- 2. Total hospital revenue (In-Patient + Out-Patient)
SELECT 'InPatient', SUM(Amount) FROM Billing
UNION ALL
SELECT 'OutPatient', SUM(Amount) FROM OutPatientBilling;

-- 3. Department with highest admissions in the past year
SELECT d.Department_Name, COUNT(*) AS Admissions
...ORDER BY Admissions DESC LIMIT 1;
```

---

## 🛠️ Tech Stack

| Tool | Usage |
|------|-------|
| MySQL | Database engine |
| SQL (DDL + DML) | Schema design and data manipulation |
| JSON (MySQL) | Flexible medical history storage |
| Stored Procedures | Reusable patient insertion logic |
| Triggers | Automated billing audit |
| Transactions | Safe, rollback-capable data operations |

---

## 📁 Files in This Repository

| File | Description |
|------|-------------|
| `Project_sql.sql` | Complete SQL script — schema, data, queries, procedures, triggers |
| `SCHEMA.docx` | Entity descriptions, normalization rules, and constraint summary |
| `Report.docx` | Full project report — problem statement, objectives, and conclusion |
| `SQL_PROJECT_PPT.pptx` | Presentation slides for the project |

---

## ▶️ How to Run

1. Make sure MySQL is installed and running
2. Open MySQL Workbench or any SQL client
3. Run `Project_sql.sql` — it creates the database, tables, inserts data, and runs all queries
4. The database `DDB` will be created automatically

```bash
mysql -u root -p < Project_sql.sql
```

---

## 📈 Future Scope

- Build a frontend UI (web/mobile) for non-technical hospital staff
- Connect to a reporting dashboard (e.g., Power BI, Tableau)
- Add role-based access control for security
- Test performance at production scale with thousands of records

---

## ⚠️ Limitations

- No frontend — currently SQL-only
- Not yet tested at large-scale hospital data volumes
- JSON support requires MySQL 5.7.8+

---
