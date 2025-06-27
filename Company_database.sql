CREATE DATABASE COMPANY;

CREATE TABLE DEPART (
    dept_no INT PRIMARY KEY,
    dept_name VARCHAR(50) UNIQUE NOT NULL,
    total_employees INT CHECK (total_employees >= 0),
    location VARCHAR(100) NOT NULL
);

CREATE TABLE EMPLOYEE (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50) NOT NULL,
    birth_date DATE NOT NULL,
    gender CHAR(1) CHECK (gender IN ('M', 'F')),
    dept_no INT,
    address VARCHAR(100),
    designation VARCHAR(50) NOT NULL,
    salary DECIMAL(10, 2) CHECK (salary >= 0),
    experience DECIMAL(3,1) CHECK (experience >= 0),
    email VARCHAR(100) UNIQUE NOT NULL,
    FOREIGN KEY (dept_no) REFERENCES DEPART(dept_no)
);

CREATE TABLE PROJECT (
    proj_id INT PRIMARY KEY,
    type_of_project VARCHAR(50) NOT NULL,
    status VARCHAR(20) CHECK (status IN ('ongoing', 'completed', 'pending')),
    start_date DATE NOT NULL,
    emp_id INT,
    FOREIGN KEY (emp_id) REFERENCES EMPLOYEE(emp_id)
);

INSERT INTO DEPART VALUES 
(101, 'CIVIL', 2, 'Hyderabad'),
(102, 'MCA', 3, 'Bangalore'),
(103, 'MECH', 0, 'Pune'),
(104, 'EEE', 1, 'Chennai'),
(105, 'CE', 2, 'Mumbai');

INSERT INTO EMPLOYEE VALUES 
(1, 'Anita', '1998-06-15', 'F', 101, 'Hyd', 'Engineer', 35000, 1.5, 'anita@company.com'),
(2, 'Asha', '2000-06-23', 'F', 102, 'Blr', 'Analyst', 30000, 0.8, 'asha@company.com'),
(3, 'Arun', '1995-11-10', 'M', 104, 'Chn', 'Technician', 25000, 6, 'arun@company.com'),
(4, 'Karan', '1992-03-12', 'M', 101, 'Hyd', 'Manager', 45000, 8, 'karan@company.com'),
(5, 'Akshara', '1999-06-05', 'F', 105, 'Mum', 'Developer', 22000, 0.5, 'akshara@company.com');

INSERT INTO PROJECT VALUES 
(1, 'Bridge Design', 'ongoing', '2023-08-01', 1),
(2, 'Software Dev', 'completed', '2022-09-01', 2),
(3, 'Transformer', 'pending', '2024-01-15', 3),
(4, 'Building Plan', 'ongoing', '2024-12-01', 4),
(5, 'Data System', 'completed', '2023-02-11', 5);

-- query sql to above data

DELETE FROM DEPART WHERE total_employees < 1;

SELECT emp_name, designation 
FROM EMPLOYEE 
WHERE gender = 'F' 
ORDER BY emp_name DESC;

SELECT emp_name 
FROM EMPLOYEE 
WHERE emp_name LIKE 'A%a';

SELECT emp_name, salary 
FROM EMPLOYEE 
WHERE salary = (SELECT MIN(salary) FROM EMPLOYEE);

SELECT COUNT(*) AS total_mca_employees 
FROM EMPLOYEE 
WHERE dept_no = (SELECT dept_no FROM DEPART WHERE dept_name = 'MCA');

SELECT * 
FROM EMPLOYEE 
WHERE MONTH(birth_date) = MONTH(CURRENT_DATE());

SELECT E.emp_name, D.dept_name, 
CONCAT(E.emp_name, ' works in department ', D.dept_name) AS statement 
FROM EMPLOYEE E 
JOIN DEPART D ON E.dept_no = D.dept_no 
WHERE D.dept_name = 'CE';

SELECT emp_name 
FROM EMPLOYEE 
WHERE experience < 1;

SELECT D.dept_name, E.emp_name, E.experience 
FROM EMPLOYEE E 
JOIN DEPART D ON E.dept_no = D.dept_no 
WHERE E.experience > 5
ORDER BY D.dept_name;