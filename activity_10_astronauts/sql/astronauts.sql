-- CS3810: Principles of Database Systems
-- Instructor: Thyago Mota
-- Description: The astronauts database

CREATE DATABASE astronauts;

DROP TABLE Astronauts;

CREATE TABLE Astronauts(
    id SERIAL PRIMARY KEY,
    lastName VARCHAR(40) NOT NULL,
    firstName VARCHAR(40) NOT NULL,
    suffix VARCHAR(5),
    gender CHAR(1) NOT NULL,
    birth DATE,
    city VARCHAR(20),
    state CHAR(30),
    country VARCHAR(25),
    status VARCHAR(30),
    daysInSpace INT NOT NULL,
    flights INT NOT NULL);

--\copy Astronauts from /var/lib/postgresql/data/astronauts.csv
--DEMILITER ',' CSV HEADER;

--\copy astronauts from 'C:\Users\noahm\PycharmProjects\23SCS3810\postgres\learn\astronauts.csv'
--WITH DELIMITER ',' CSV HEADER;

--\copy Astronauts from /var/lib/postgresql/data/astronauts.csv
--DELIMITER ',' CSV HEADER;

\copy Astronauts (lastName, firstName, suffix, gender, birth, city, state, country, status, daysInSpace, flights) from C:\Users\noahm\PycharmProjects\23SCS3810\postgres\learn\astronauts.csv DELIMITER ',' CSV HEADER;


