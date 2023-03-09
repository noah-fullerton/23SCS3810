-- CS3810: Principles of Database Systems
-- Instructor: Thyago Mota
-- Description: The employees database

-- TODO: create database employees
CREATE TABLE Employees(
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    sal DECIMAL(8,2) NOT NULL,
    FOREIGN KEY (deptCode) REFERENCES Departments(code)
);

-- TODO: create table departments
CREATE TABLE Employees(
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    sal DECIMAL(8,2) NOT NULL,
    deptCode CHAR(2),
    FOREIGN KEY (deptCode) REFERENCES Departments(code)
);

CREATE TABLE Departments(
    code PRIMARY KEY CHAR(2),
    name VARCHAR(30)
);

-- TODO: populate table departments

INSERT INTO Departments VALUES
('HR', "Human Resources"),
('IT', 'Information Technology'),
('SL', 'Sales');

INSERT INTO Employees (name, sal, deptCode) VALUES
('Sam Mai Tai', 50000, 'HR');
('John', 60000, 'HR');
('Mary', 80000, 'IT')
('Harry', 100, NULL)

-- TODO: create table employees

-- TODO: populate table Employees

-- TODO: a) list all rows in Departments.

SELECT * FROM Departments;

-- TODO: b) list only the codes in Departments.

SELECT code FROM Departments;

-- TODO: c) list all rows in Employees.

SELECT * FROM Employees;

-- TODO: d) list only the names in Employees in alphabetical order.

SELECT name FROM Employees ORDER BY 1;

-- TODO: e) list only the names and salaries in Employees, from the highest to the lowest salary.

SELECT name, salary FROM Employees ORDER BY 2 DESC;

-- TODO: f) list the cartesian product of Employees and Departments.

SELECT * FROM Employees, Departments;

-- TODO: g) do the natural join of Employees and Departments; the result should be exactly the same as the cartesian product; do you know why?

SELECT id, deptCode, code FROM Employees
NATURAL JOIN Departments
ORDER BY id, code;

-- TODO: i) do an equi join of Employees and Departments matching the rows by Employees.deptCode and Departments.code (hint: use JOIN and the ON clause).

SELECT * FROM Employees, Departments WHERE deptCode = code;



-- TODO: j) same as previous query but project name and salary of the employees plus the description of their departments.

SELECT name, salary, 'desc'
FROM Employees A
INNER JOIN Departments B
ON A.deptCode = B.code;

-- TODO: k) same as previous query but only the employees that earn less than 60000.

-- TODO: l) same as query ‘i’  but only the employees that earn more than ‘Jose Caipirinha’.

-- TODO: m) list the left outer join of Employees and Departments (use the ON clause to match by department code); how does the result of this query differs from query ‘i’?

-- TODO: n) from query ‘m’, how would you do the left anti-join?

-- TODO: o) show the number of employees per department.

-- TODO: p) same as query ‘o’ but I want to see the description of each department (not just their codes).
