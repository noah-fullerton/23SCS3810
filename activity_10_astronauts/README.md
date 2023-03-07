The goal of this activity is to create a database of living astronauts and use it to answer a few queries. 

## Part I - Database Schema 

You should use astronauts as the name of your database.  This database should have a single table named **Astronauts** with the following relational schema: 

```
Astronauts(id: integer, lastName: string, firstName: string, suffix: string, gender: char, birth: date, city: string, state: string, country: string, status: string, daysInSpace: integer, flights: integer)  
```
 
Save all SQL commands in a file called [astronauts.sql](sql/astronauts.sql).  

Primary key id should be an auto-incremented field (serial in Postgres).  Attributes city, state, and country define the location where each astronaut was born. The attribute state should be set to NULL if country is different than in the United States. The attribute status can be: “active” (currently working), “retired.”  

Populate the astronauts table using [astronauts.csv](sql/astronauts.csv).

## Part II - Queries  

When you are done populating your table, you should write the following queries using SQL syntax.  Save all query commands in astronauts.sql.  

a) the total number of astronauts. 

SELECT COUNT(*) as TOTAL FROM Astronauts;

b) the total number of American astronauts. 

SELECT COUNT(*) as TOTAL FROM Astronauts WHERE country = 'USA';

c) the list of nationalities of all astronauts in alphabetical order. 

SELECT country FROM Astronauts ORDER BY country;

d) all astronaut names ordered by last name (use the format Last Name, First Name, Suffix to display the names). 

SELECT lastName FROM Astronauts ORDER BY lastName, FirstName, Suffix;

e) the total number of astronauts by gender. 


f) the total number of female astronauts that are still active. 

g) the total number of American female astronauts that are still active. 

h) the list of all American female astronauts that are still active ordered by last name (use the same name format used in d). 

i) the list of Chinese astronauts, displaying only their names and ages (use the same name format used in d). 

SELECT CONCAT(lastName, ',', firstName) AS name, birth, date_part
('year', AGE(birth)) AS age FROM Astronauts WHERE country = 'China' ORDER BY lastName;

j) the total number of astronauts by country. 

SELECT COUNT(*) AS total, country FROM Astronauts GROUP BY country ORDER BY 1 DESC;

k) the total number of American astronauts per state ordered by the totals in
descending order. 

SELECT COUNT(*) AS total, state FROM Astronauts WHERE country ='USA' GROUP BY state ORDER BY 1 DESC;
 
l) the total number of astronauts by statuses (i.e., active or retired). 

SELECT COUNT(*) AS total, status FROM Astronauts GROUP BY status;

m) name and age of all non-American astronauts in alphabetical order (use the same name format used in d). 


n) the average age of all American astronauts that are still active. 

SELECT AVG(date_part('year', AGE(birth))) AS "avg age" FROM Astronauts WHERE country = 'USA' AND status = 'Active';