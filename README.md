# Schools-Database-System
School Management System Database: A robust SQL Server database implementation for managing educational institutions. Features a relational schema for students, teachers, departments, and course offerings, with automated grading logic via SQL triggers and functions.
Project Overview
This project provides a comprehensive SQL-based backend solution for a School Management System. It is designed to handle the core administrative and academic operations of a school, including student enrollment, faculty management, course scheduling, and automated academic performance tracking.

The database is built with MS SQL Server and focuses on data integrity, relational mapping, and automated business logic.

## Key Features
Relational Schema: Optimized 3rd Normal Form (3NF) design to ensure zero data redundancy.

Automated Grading: A custom T-SQL Scalar Function and Trigger automatically calculate and assign letter grades (A-F) whenever a numeric score is inserted or updated.

Complex Relationships: Handles many-to-many (M:N) relationships between Students and Guardians.

Data Validation: Implements CHECK constraints for grade levels, scores, and scheduling logic (e.g., ensuring EndTime > StartTime).

Advanced Reporting: Includes complex queries for:

Top-performing students per course.

Teacher workload analysis.

Class averages and enrollment statistics.

Dynamic weekly scheduling.

## Database Schema
-The system consists of 8 primary tables:

-DEPARTMENT: Academic departments (Math, Science, etc.).

-COURSE: Course catalog with grade-level targeting.

-TEACHER: Faculty profiles linked to departments.

-STUDENT: Detailed student records.

-OFERING: The bridge between Courses and Teachers, including schedule and room data.

-ENROLLMENT: Maps students to offerings, tracking scores and automated grades.

-GUARDIAN: Contact information for parents/guardians.

-STUDENT_GUARDIAN: Linking table for the M:N student-guardian relationship.

## Technical Stack
Language: T-SQL (Transact-SQL)

Platform: Microsoft SQL Server , VS Code

## Installation & Usage
Open SQL Server Management Studio (SSMS).

Create a new database named SCHOOL:
    CREATE DATABASE SCHOOL;
Copy and execute the script provided in school_db.sql.

The script will automatically:

Create the schema.

Populate initial data for all tables.

Deploy the GetGrade function and trg_SetGrade trigger.

### C# Desktop Application: Installation & Usage
1. Prerequisites
Visual Studio (2019 or newer recommended) with the .NET Desktop Development workload installed.

.NET Framework 4.7.2 or higher.

System.Data.SqlClient library (usually included, but can be added via NuGet).

2. Setup & Configuration
Open the Project: Open your solution file (.sln) in Visual Studio.

Configure Connection String: In DashboardForm.cs, locate the SqlConnection declaration. Update the Data Source to match your local SQL Server instance name:

C#
// Replace OMAMA\SQLEXPRESS with your actual Server Name
SqlConnection con = new SqlConnection(@"Data Source = YOUR_SERVER_NAME ; Initial Catalog = SCHOOL ; Integrated Security=True");
UI Design: Ensure you have a Panel named panelMain in your Form designer, as the code uses this to dynamically inject buttons and tables.

3. Build and Run
Press F5 or click the Start button in Visual Studio.

The application will initialize and attempt to connect to your SCHOOL database.

## Sample Queries Included
The project includes a suite of analytical queries for administration:

Workload Analysis: Count of courses taught by each teacher.

Student Progress: Average scores per grade level.

Scheduling: Weekly timetable sorted by day and time.

Academic Excellence: Identifying the highest score in every course.
