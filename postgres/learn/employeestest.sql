DROP DATABASE emptest;

CREATE DATABASE emptest;


\c emptest

DROP TABLE Employees_A;

CREATE TABLE Employees_A(
    id INT PRIMARY KEY,
    name VARCHAR(100)
);

DROP TABLE Employees_B;

CREATE TABLE Employees_B(
    id INT PRIMARY KEY,
    name VARCHAR(100)
);

INSERT INTO Employees_A VALUES 
    (1, 'John'),
    (2, 'Anna'),
    (3, 'Josh');

INSERT INTO Employees_B VALUES
    (1, 'John'),
    (4, 'Nathan'),
    (5, 'Gloria');

SELECT * FROM Employees_A
    UNION
SELECT * FROM Employees_B;

SELECT * FROM Employees_A
    UNION ALL
SELECT * FROM Employees_B;

SELECT * FROM Employees_A A
    WHERE EXISTS (
        SELECT * FROM Employees_B B
        WHERE A.id = B.id AND A.name = B.name
    );



GO BACK AND DO THE OTHER SHIT BOI


DROP TABLE Employees;

CREATE TABLE Employees(
    id INT PRIMARY KEY,
    name VARCHAR(30),
    code VARCHAR(2)
);

DROP TABLE Departments;


CREATE TABLE Departments(
    code VARCHAR(2),
    description VARCHAR(50)
);

INSERT INTO Employees VALUES
    (1, 'John', 'HR'),
    (2, 'Mary', 'IT'),
    (3, 'Harry', NULL),
    (4, 'Rebeca', NULL);

INSERT INTO Departments VALUES
    (2, 'Anna'),
    (3, 'Josh');

SELECT * FROM Employees
NATURAL JOIN Departments;

DROP TABLE Employees;

CREATE TABLE Employees(
    id INT PRIMARY KEY,
    name VARCHAR(30),
    depCode VARCHAR(2)
);

SELECT * FROM Emplloyees A 
INNER JOIN Departments B 
ON A.depCode = B.code;