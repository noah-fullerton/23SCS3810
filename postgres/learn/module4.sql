DROP DATABASE test;

CREATE DATABASE test;

\c test

DROP TABLE Movies;

CREATE TABLE Movies(
    title   VARCHAR(100),
    year    INT,
    length  INT,
    genre   CHAR(10) DEFAULT '?'
);


DROP TABLE Movies;

CREATE TABLE Movies(
    title VARCHAR(100),
    year INT,
    length INT,
    genre VARCHAR(10) DEFAULT '?',
    PRIMARY KEY(title, year)
);


DROP TABLE Stars;

CREATE TABLE Stars(
    name VARCHAR(30) UNIQUE,
    gender CHAR(1) DEFAULT '?'
);


DROP TABLE Stars;

CREATE TABLE Stars(
    name VARCHAR(30),
    gender CHAR(1) DEFAULT '?',
    UNIQUE (name)
);


DROP TABLE Stars;

CREATE TABLE Stars(
    name VARCHAR(30),
    gender CHAR(1) DEFAULT '?',
    UNIQUE (name, gender)
);


DROP TABLE Stars;

CREATE TABLE Stars(
    name VARCHAR(30) PRIMARY KEY,
    gender CHAR(1) DEFAULT '?'
);


INSERT INTO Stars VALUES 
    ('Elijah Wood', 'M'),
    ('Jennifer Lawrence', 'F');

SELECT name FROM Stars;

SELECT name FROM Stars WHERE gender='F';

-- need to sort this out, the command works but containter doesn't recognize the path
\copy Stars from 'C:\Users\noahm\PycharmProjects\23SCS3810\postgres\learn\stars.csv' DELIMITER ',';

\d will give a list of relations/tables that you have