/*
# ScienceQtech Employee Performance Mapping.

# Course-end Project 1

## Description

    ScienceQtech is a startup that works in the Data Science field. ScienceQtech has worked on fraud detection, market basket, self-driving cars, supply chain, algorithmic early detection of lung cancer, customer sentiment, and the drug discovery field. With the annual appraisal cycle around the corner, the HR department has asked you (Junior Database Administrator) to generate reports on employee details, their performance, and on the project that the employees have undertaken, to analyze the employee database and extract specific data based on different requirements.

 
### Objective: 

    To facilitate a better understanding, managers have provided ratings for each employee which will help the HR department to finalize the employee performance mapping. As a DBA, you should find the maximum salary of the employees and ensure that all jobs are meeting the organization's profile standard. You also need to calculate bonuses to find extra cost for expenses. This will raise the overall performance of the organization by ensuring that all required employees receive training.

 

* Note: You must download the dataset from the course resource section in LMS and create a table to perform the above objective.


 

### Dataset description:

##### emp_record_table: It contains the information of all the employees.

* EMP_ID – ID of the employee
* FIRST_NAME – First name of the employee
* LAST_NAME – Last name of the employee
* GENDER – Gender of the employee
* ROLE – Post of the employee
* DEPT – Field of the employee
* EXP – Years of experience the employee has
* COUNTRY – Country in which the employee is presently living
* CONTINENT – Continent in which the country is
* SALARY – Salary of the employee
* EMP_RATING – Performance rating of the employee
* MANAGER_ID – The manager under which the employee is assigned 
* PROJ_ID – The project on which the employee is working or has worked on


##### Proj_table: It contains information about the projects.

* PROJECT_ID – ID for the project*
* PROJ_Name – Name of the project*
* DOMAIN – Field of the project*
* START_DATE – Day the project began*
* CLOSURE_DATE – Day the project was or will be completed*
* DEV_QTR – Quarter in which the project was scheduled*
* STATUS – Status of the project currently
 

##### Data_science_team: It contains information about all the employees in the Data Science team.

* EMP_ID – ID of the employee*
* FIRST_NAME – First name of the employee*
* LAST_NAME – Last name of the employee*
* GENDER – Gender of the employee*
* ROLE – Post of the employee*
* DEPT – Field of the employee*
* EXP – Years of experience the employee has*
* COUNTRY – Country in which the employee is presently living*
* CONTINENT – Continent in which the country is



### The task to be performed: 

1. Create a database named employee, then import data_science_team.csv proj_table.csv and emp_record_table.csv into the employee database from the given resources.

 
2. Create an ER diagram for the given employee database.


3. Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, and DEPARTMENT from the employee record table, and make a list of employees and details of their department.


4. Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPARTMENT, and EMP_RATING if the EMP_RATING is: 

less than two

greater than four 

between two and four


5. Write a query to concatenate the FIRST_NAME and the LAST_NAME of employees in the Finance department from the employee table and then give the resultant column alias as NAME.
 

6. Write a query to list only those employees who have someone reporting to them. Also, show the number of reporters (including the President).


7. Write a query to list down all the employees from the healthcare and finance departments using union. Take data from the employee record table.


8. Write a query to list down employee details such as EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPARTMENT, and EMP_RATING grouped by dept. Also include the respective employee rating along with the max emp rating for the department.


9. Write a query to calculate the minimum and the maximum salary of the employees in each role. Take data from the employee record table.


10. Write a query to assign ranks to each employee based on their experience. Take data from the employee record table.


11. Write a query to create a view that displays employees in various countries whose salary is more than six thousand. Take data from the employee record table.
 

12. Write a nested query to find employees with experience of more than ten years. Take data from the employee record table.


13. Write a query to create a stored procedure to retrieve the details of the employees whose experience is more than three years. Take data from the employee record table.


14. Write a query using stored functions in the project table to check whether the job profile assigned to each employee in the data science team matches the organization’s set standard.

Note: The standard being:

* For an employee with experience less than or equal to 2 years assign 'JUNIOR DATA SCIENTIST',

* For an employee with the experience of 2 to 5 years assign 'ASSOCIATE DATA SCIENTIST',

* For an employee with the experience of 5 to 10 years assign 'SENIOR DATA SCIENTIST',

* For an employee with the experience of 10 to 12 years assign 'LEAD DATA SCIENTIST',

* For an employee with the experience of 12 to 16 years assign 'MANAGER'.

 
15. Create an index to improve the cost and performance of the query to find the employee whose FIRST_NAME is ‘Eric’ in the employee table after checking the execution plan.

 
16. Write a query to calculate the bonus for all the employees, based on their ratings and salaries (Use the formula: 5% of salary * employee rating).
 

17. Write a query to calculate the average salary distribution based on the continent and country. Take data from the employee record table.
*/



-- Dropping Database
DROP DATABASE IF EXISTS employee;

-- 1. Create a database named employee, then import data_science_team.csv proj_table.csv and emp_record_table.csv into the employee database from the given resources.

-- CREATE DATABASE
CREATE DATABASE IF NOT EXISTS employee;
-- USE DATABASE
USE employee;

-- CREATE TABLES
-- proj_table
CREATE TABLE IF NOT EXISTS proj_table(
    PROJ_ID VARCHAR(6) PRIMARY KEY,
    PROJ_Name VARCHAR(40) NOT NULL,
    DOMAIN VARCHAR(30) NOT NULL,
    START_DATE DATE NOT NULL,
    CLOSURE_DATE DATE NOT NULL,
    DEV_QTR VARCHAR(2) NOT NULL,
    STATUS VARCHAR(20) NOT NULL
);

-- Data_science_team
CREATE TABLE IF NOT EXISTS data_science_team(
    EMP_ID VARCHAR(6) NOT NULL PRIMARY KEY,
    FIRST_NAME VARCHAR(30) NOT NULL,
    LAST_NAME VARCHAR(30) NOT NULL,
    GENDER VARCHAR(4) NOT NULL,
    ROLE VARCHAR(40) NOT NULL,
    DEPT VARCHAR(20) NOT NULL,
    EXP INT NOT NULL,
    COUNTRY VARCHAR(20) NOT NULL,
    CONTINENT VARCHAR(20) NOT NULL
);

-- emp_record_table
CREATE TABLE IF NOT EXISTS emp_record_table(
    EMP_ID VARCHAR(6) NOT NULL,
    FIRST_NAME VARCHAR(30) NOT NULL,
    LAST_NAME VARCHAR(30) NOT NULL,
    GENDER VARCHAR(4) NOT NULL,
    ROLE VARCHAR(40) NOT NULL,
    DEPT VARCHAR(40) NOT NULL,
    EXP INT NOT NULL,
    COUNTRY VARCHAR(20) NOT NULL,
    CONTINENT VARCHAR(20) NOT NULL,
    SALARY INT NOT NULL,
    EMP_RATING INT NOT NULL,
    MANAGER_ID VARCHAR(6) ,
    PROJ_ID VARCHAR(6),
	FOREIGN KEY (EMP_ID) REFERENCES data_science_team(EMP_ID),
	FOREIGN KEY (PROJ_ID) REFERENCES proj_table(PROJ_ID)
);

-- LOAD DATA
-- proj_table
LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/proj_table.csv'
INTO TABLE proj_table
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Data_science_team
LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/data_science_team.csv'
INTO TABLE data_science_team
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- emp_record_table
LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/emp_record_table.csv'
INTO TABLE emp_record_table
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Uncomment next line if the file loads automatically else load CSV files manually
/*
-- 2. Create an ER diagram for the given employee database.
-- ER Diagram

-- 3. Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, and DEPARTMENT from the employee record table, and make a list of employees and details of their department.
SELECT 
    emp_record_table.EMP_ID,
    emp_record_table.FIRST_NAME,
    emp_record_table.LAST_NAME,
    emp_record_table.GENDER,
    emp_record_table.DEPT
FROM
    emp_record_table;

-- 4. Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPARTMENT, and EMP_RATING if the EMP_RATING is: 

-- less than two

SELECT 
    emp_record_table.EMP_ID,
    emp_record_table.FIRST_NAME,
    emp_record_table.LAST_NAME,
    emp_record_table.GENDER,
    emp_record_table.DEPT,
    emp_record_table.EMP_RATING
FROM
    emp_record_table
WHERE
    emp_record_table.EMP_RATING < 2
    ORDER BY emp_record_table.EMP_RATING;

-- greater than four 
SELECT 
    emp_record_table.EMP_ID,
    emp_record_table.FIRST_NAME,
    emp_record_table.LAST_NAME,
    emp_record_table.GENDER,
    emp_record_table.DEPT,
    emp_record_table.EMP_RATING

FROM
    emp_record_table
WHERE
    emp_record_table.EMP_RATING > 4
    ORDER BY emp_record_table.EMP_RATING;
    
-- between two and four
SELECT 
    emp_record_table.EMP_ID,
    emp_record_table.FIRST_NAME,
    emp_record_table.LAST_NAME,
    emp_record_table.GENDER,
    emp_record_table.DEPT,
    emp_record_table.EMP_RATING
FROM
    emp_record_table
WHERE
    emp_record_table.EMP_RATING BETWEEN 2 AND 4
    ORDER BY emp_record_table.EMP_RATING;

-- 5. Write a query to concatenate the FIRST_NAME and the LAST_NAME of employees in the Finance department from the employee table and then give the resultant column alias as NAME.
SELECT 
    CONCAT(emp_record_table.FIRST_NAME,
            ' ',
            emp_record_table.LAST_NAME) AS NAME
FROM
    emp_record_table;

-- 6. Write a query to list only those employees who have someone reporting to them. Also, show the number of reporters (including the President).
SELECT 
    emp_record_table.FIRST_NAME,
    emp_record_table.LAST_NAME,
    COUNT(emp_record_table.MANAGER_ID) AS NUMBER_OF_REPORTERS
FROM
    emp_record_table
    GROUP BY emp_record_table.MANAGER_ID
    HAVING COUNT(emp_record_table.MANAGER_ID) > 0
    ORDER BY emp_record_table.MANAGER_ID;

-- 7. Write a query to list down all the employees from the healthcare and finance departments using union. Take data from the employee record table.
SELECT *
FROM
    emp_record_table
WHERE
    emp_record_table.DEPT = 'HEALTHCARE'
UNION
SELECT *
FROM
    emp_record_table
WHERE
    emp_record_table.DEPT = 'FINANCE'
    ORDER BY EMP_ID;

-- 8. Write a query to list down employee details such as EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPARTMENT, and EMP_RATING grouped by dept. Also include the respective employee rating along with the max emp rating for the department.
SELECT
    MAX(emp_record_table.EMP_RATING)
FROM
    emp_record_table
GROUP BY emp_record_table.DEPT
ORDER BY emp_record_table.DEPT;

-- 9. Write a query to calculate the minimum and the maximum salary of the employees in each role. Take data from the employee record table.
SELECT 
    emp_record_table.ROLE,
    MIN(emp_record_table.SALARY) AS MINIMUM_SALARY,
    MAX(emp_record_table.SALARY) AS MAXIMUM_SALARY
FROM
    emp_record_table
GROUP BY emp_record_table.ROLE
ORDER BY emp_record_table.ROLE;

-- 10. Write a query to assign ranks to each employee based on their experience. Take data from the employee record table.
SELECT 
    emp_record_table.EMP_ID, 
    concat(emp_record_table.FIRST_NAME,
            ' ',
            emp_record_table.LAST_NAME) as NAME IF NOT EXISTS,
    emp_record_table.DEPT,
    emp_record_table.EXP,
    rank() OVER(ORDER BY emp_record_table.EXP DESC) as EMP_EXP_RANK
FROM
    emp_record_table

-- 11. Write a query to create a view that displays employees in various countries whose salary is more than six thousand. Take data from the employee record table.
CREATE VIEW 
    emp_salary_view AS
SELECT 
    emp_record_table.EMP_ID,
    emp_record_table.FIRST_NAME,
    emp_record_table.LAST_NAME,
    emp_record_table.SALARY,
    emp_record_table.COUNTRY
FROM
    emp_record_table
WHERE
    emp_record_table.SALARY > 6000
    ORDER BY emp_record_table.SALARY;

-- 12. Write a nested query to find employees with experience of more than ten years. Take data from the employee record table.
SELECT
    emp_record_table.EMP_ID,
    emp_record_table.FIRST_NAME,
    emp_record_table.LAST_NAME,
    emp_record_table.EXP
FROM
    emp_record_table
WHERE
    emp_record_table.EXP > 10
    ORDER BY emp_record_table.EXP;

-- 13. Write a query to create a stored procedure to retrieve the details of the employees whose experience is more than three years. Take data from the employee record table.
SELECT *
FROM
    emp_record_table
WHERE
    emp_record_table.EXP > 3
    ORDER BY emp_record_table.EXP;

-- 14. Write a query using stored functions in the project table to check whether the job profile assigned to each employee in the data science team matches the organization’s set standard.

-- Note: The standard being:

-- * For an employee with experience less than or equal to 2 years assign 'JUNIOR DATA SCIENTIST',
-- * For an employee with the experience of 2 to 5 years assign 'ASSOCIATE DATA SCIENTIST',
-- * For an employee with the experience of 5 to 10 years assign 'SENIOR DATA SCIENTIST',
-- * For an employee with the experience of 10 to 12 years assign 'LEAD DATA SCIENTIST',
-- * For an employee with the experience of 12 to 16 years assign 'MANAGER'.
delimiter //
CREATE FUNCTION 
    check_role(exp int)
RETURNS VARCHAR(40)
DETERMINISTIC
BEGIN
DECLARE 
    chck VARCHAR(40);
IF EXP <= 2 THEN
    SET chck = "JUNIOR DATA SCIENTIST";
elseif exp > 2 AND exp <= 5 THEN
    SET chck = "ASSOCIATE DATA SCIENTIST";
elseif exp > 5 AND exp <= 10 THEN
    SET chck = "SENIOR DATA SCIENTIST";
elseif exp > 10 AND exp <= 12 THEN
    SET chck = "LEAD DATA SCIENTIST";
elseif exp > 12 AND exp <= 16 THEN
    SET chck = "MANAGER";
end if;
RETURN(chck);
END //
delimiter ;
-- checking Data Science Team
SELECT
    emp_record_table.EMP_ID,
    emp_record_table. FIRST_NAME,
    emp_record_table.LAST_NAME, 
    emp_record_table.ROLE, 
    emp_record_table.EXP,
    check_role(exp)
FROM 
    data_science_team 
WHERE data_science_team.ROLE != check_role(exp);

-- 15. Create an index to improve the cost and performance of the query to find the employee whose FIRST_NAME is ‘Eric’ in the employee table after checking the execution plan.
CREATE INDEX 
    emp_first_name_index ON emp_record_table(FIRST_NAME);
SELECT *
FROM
    emp_record_table
WHERE
    emp_record_table.FIRST_NAME = 'Eric';

-- 16. Write a query to calculate the bonus for all the employees, based on their ratings and salaries (Use the formula: 5% of salary * employee rating).
SELECT
    emp_salary_view.EMP_ID,
    emp_salary_view.NAME,
    emp_salary_view.DEPT,
    emp_salary_view.SALARY,
    emp_salary_view.EMP_RATING,
    (emp_salary_view.SALARY * 0.05 * emp_salary_view.EMP_RATING) AS BONUS
FROM
    emp_salary_view
ORDER BY emp_salary_view.BONUS DESC;

-- 17. Write a query to calculate the average salary distribution based on the continent and country. Take data from the employee record table.
SELECT
    emp_record_table.COUNTRY,
    emp_record_table.CONTINENT,
    AVG(emp_record_table.SALARY) AS AVERAGE_SALARY
FROM
    emp_record_table
GROUP BY emp_record_table.COUNTRY, emp_record_table.CONTINENT
ORDER BY emp_record_table.CONTINENT, emp_record_table.COUNTRY;