-- CS3810: Principles of Database Systems
-- Instructor: Thyago Mota
-- Student: Noah Fullerton
-- Description: a database of occupations

CREATE DATABASE occupations;

\c occupations

DROP TABLE IF EXISTS Occupations;

--Create relation
CREATE TABLE Occupations(
    Code VARCHAR(12),
    Occupation VARCHAR(500),
    JobFamily VARCHAR(500)
);

--Populate relation from .csv file, change path to your path
\copy Occupations from C:\Users\noahm\PycharmProjects\23SCS3810\hwk_05_occupations\src\occupations.csv DELIMITER ',' CSV HEADER;

-- TODO: a) the total number of occupations (expect 1016).

SELECT COUNT (*) FROM Occupations;

-- TODO: b) a list of all job families in alphabetical order (expect 23).

SELECT JobFamily FROM Occupations GROUP BY JobFamily ORDER BY JobFamily;

-- TODO: c) the total number of job families (expect 23)
SELECT COUNT (DISTINCT JobFamily) FROM Occupations;

-- TODO: d) the total number of occupations per job family in alphabetical order of job family.

SELECT COUNT(*) AS total, JobFamily FROM Occupations GROUP BY JobFamily ORDER BY JobFamily;

-- TODO: e) the number of occupations in the "Computer and Mathematical" job family (expect 38)

SELECT COUNT(*) AS total FROM Occupations WHERE JobFamily = 'Computer and Mathematical' GROUP BY JobFamily;

-- BONUS POINTS

-- TODO: f) an alphabetical list of occupations in the "Computer and Mathematical" job family.

SELECT Occupation FROM Occupations WHERE JobFamily = 'Computer and Mathematical' ORDER BY Occupation;

-- TODO: g) an alphabetical list of occupations in the "Computer and Mathematical" job family that begins with the word "Database"

SELECT Occupation FROM Occupations WHERE SUBSTRING(Occupation, 1, 8) = 'Database' AND JobFamily = 'Computer and Mathematical';
