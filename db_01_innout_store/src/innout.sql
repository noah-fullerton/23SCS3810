-- CS3810: Principles of Database Systems
-- Instructor: Thyago Mota
-- Student(s): Noah Fullerton
-- Description: SQL for the In-N-Out Store

DROP DATABASE innout;

CREATE DATABASE innout;

\c innout


-- TODO: table create statements
DROP TABLE Records;
DROP TABLE Sales;
DROP TABLE Customers;
DROP TABLE Items;
DROP TABLE ItemCategories;



DROP TABLE Customers;
CREATE TABLE Customers(
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    gender CHAR(1) NOT NULL DEFAULT '?'
);

DROP TABLE ItemCategories;
CREATE TABLE ItemCategories(
    code CHAR(3) PRIMARY KEY,
    descr VARCHAR(50)
);

DROP TABLE Items;
CREATE TABLE Items(
    code SERIAL PRIMARY KEY,
    descr VARCHAR(50),
    current_price FLOAT(20),
    category_code CHAR(3),
    FOREIGN KEY (category_code) REFERENCES ItemCategories(code)
);


DROP TABLE Sales;
CREATE TABLE Sales(
    code SERIAL PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    number_of_items INTEGER,
    total_cost FLOAT(20),
    cust_id INTEGER,
    FOREIGN KEY (cust_id) REFERENCES Customers(id)
);

DROP TABLE Records;
CREATE TABLE Records(
    cust_id INTEGER,
    FOREIGN KEY (cust_id) REFERENCES Customers(id),
    item_code INTEGER,
    FOREIGN KEY (item_code) REFERENCES Items(code),
    cost_at_time FLOAT(20),
    sales_code INTEGER,
    FOREIGN KEY (sales_code) REFERENCES Sales(code)
);


-- TODO: table insert statements

INSERT INTO Customers (name, gender) VALUES
('Olu Fann', 'M'),
('Eian Parker', 'M'),
('Isis Gaston', 'F'),
('Lola Mitchell', 'F');

INSERT INTO Customers(name) VALUES
('Rae Rae Claire');

INSERT INTO ItemCategories VALUES
('BVR', 'Beverages'),
('DRY', 'Dairy'),
('PRD', 'Produce'),
('FRZ', 'Frozen'),
('BKY', 'Bakery'),
('MEA', 'Meat');


INSERT INTO Items (descr, current_price, category_code) VALUES
('A pinch of baking powder', 1.25, 'BKY'),
('A 47lb frozen turkey', 67.33, 'MEA'),
('A supersized kale smoothie', 9.67, 'BVR'),
('A shot of whole milk', 4.32, 'DRY'),
('A bundle of 64 eggo wafles', 19.95, 'FRZ'),
('A seven-layer wedding cake', 599.99, 'BKY'),
('A cactus from an alien planet?', 9999.99, NULL);


--sale_date, sale_time, number_of_items, cust_id
INSERT INTO Sales (sale_date, sale_time, number_of_items, total_cost, cust_id) VALUES
('2023-03-06', '08:38:43', 4, 82.48, 1),
('2023-03-07', '09:47:25', 1, 67.33, 2),
('2023-02-06', '04:26:35', 3, 15.15, 2),
('2023-04-19', '12:14:12', 1, 599.99, 3),
('2023-03-06', '03:21:25', 4, 27.8, 2),
('2023-02-13', '11:31:29', 2, 10009.66, 4)
;

--cust_id, item_code, cost_at_time, sales_code
INSERT INTO Records VALUES
    (1, 2, 67.33, 1),
    (1, 1, 1.25, 1),
    (1, 3, 9.67, 1),
    (1, 4, 4.23, 1),
    (2, 2, 67.33, 2),
    (2, 1, 1.25, 3),
    (2, 3, 9.67, 3),
    (2, 4, 4.23, 3),
    (3, 5, 599.99, 4),
    (2, 3, 9.67, 5),
    (2, 4, 4.23, 5),
    (2, 3, 9.67, 5),
    (2, 4, 4.23, 5),
    (4, 3, 9.67, 6),
    (4, 7, 9999.99, 6);

-- TODO: SQL queries

-- a) all customer names in alphabetical order

SELECT name FROM Customers ORDER BY name;

-- b) number of items (labeled as total_items) in the database 

SELECT COUNT(*) AS total_items FROM Items;

-- c) number of customers (labeled as number_customers) by gender

SELECT gender, COUNT(*) AS number_customers FROM Customers GROUP BY gender ORDER BY gender;

-- d) a list of all item codes (labeled as code) and descriptions (labeled as description) followed by their category descriptions (labeled as category) in numerical order of their codes (items that do not have a category should not be displayed)

SELECT A.code, A.descr, B.descr AS category FROM Items A
JOIN ItemCategories B
ON A.category_code = B.code
ORDER BY A.code;

-- e) a list of all item codes (labeled as code) and descriptions (labeled as description) in numerical order of their codes for the items that do not have a category

SELECT code, descr FROM Items
WHERE category_code IS NULL
ORDER BY code;

-- f) a list of the category descriptions (labeled as category) that do not have an item in alphabetical order

SELECT A.descr AS category FROM ItemCategories A
WHERE NOT EXISTS
(SELECT category_code
FROM Items B
WHERE A.code = B.category_code);

-- g) set a variable named "ID" and assign a valid customer id to it; then show the content of the variable using a select statement

\set ID 2
SELECT * FROM Customers
WHERE id = :ID;

-- h) a list describing all items purchased by the customer identified by the variable "ID" (you must used the variable), showing, the date of the purchase (labeled as date), the time of the purchase (labeled as time and in hh:mm:ss format), the item's description (labeled as item), the quantity purchased (labeled as qtt), the item price (labeled as price), and the total amount paid (labeled as total_paid).

SELECT sale_date AS date, sale_time AS time, B.descr AS item,
B.current_price AS price, 
COUNT(item_code) AS qty,
SUM(B.current_price) AS total_paid
FROM

(SELECT * FROM Sales A
JOIN 

(SELECT * FROM Items A
JOIN Records B
ON A.code = B.item_code) B

ON A.code = B.sales_code
WHERE A.cust_id = :ID

ORDER BY a.sale_date) B
GROUP BY sale_date, sale_time, B.descr, B.current_price, B.total_cost, item_code
ORDER BY sale_date
;

-- i) the total amount of sales per day showing the date and the total amount paid in chronological order

SELECT sale_date, SUM(total_cost) as total_amount_paid, COUNT(*) as sales_per_day 
FROM Sales GROUP BY sale_date ORDER BY sale_date;

-- j) the description of the top item (labeled as item) in sales with the total sales amount (labeled as total_paid)

SELECT Items.descr as item, SUM(Records.cost_at_time) as total_paid FROM Items, Records 
WHERE Items.code = Records.item_code GROUP BY Items.descr 
ORDER BY SUM(Records.cost_at_time) DESC LIMIT 1;

-- k) the descriptions of the top 3 items (labeled as item) in number of times they were purchased, showing that quantity as well (labeled as total)

SELECT Items.descr as item, COUNT(*) as total FROM Items, Records 
WHERE Items.code = Records.item_code GROUP BY Items.descr 
ORDER BY COUNT(*) DESC LIMIT 3;

-- l) the name of the customers who never made a purchase 

SELECT A.name FROM Customers A
WHERE NOT EXISTS
(SELECT A.name
FROM Sales B
WHERE A.id = B.cust_id);