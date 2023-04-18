-- CS3810: Principles of Database Systems
-- Instructor: Thyago Mota
-- Student(s): Noah Fullerton
-- Description: IPPS database

DROP DATABASE ipps;

CREATE DATABASE ipps;

\c ipps

Rndrng_Prvdr_CCN: The CMS Certification Number (CCN) of the provider billing for outpatient hospital services.
* Rndrng_Prvdr_Org_Name: The name of the provider.
* Rndrng_Prvdr_St: The street address in which the provider is physically located.
* Rndrng_Prvdr_City: The city in which the provider is physically located.
* Rndrng_Prvdr_State_Abrvtn: The state abbreviation for the state in which the provider is physically located.
* Rndrng_Prvdr_State_FIPS: The state FIPS code for the state in which the provider is physically located.
* Rndrng_Prvdr_Zip5: The zip code in which the provider is physically located.
* Rndrng_Prvdr_RUCA: The Rural-Urban Commuting Area (RUCA) code for the zip code in which the provider is physically located.
* Rndrng_Prvdr_RUCA_Desc: The description of the RUCA code.
* DRG_Cd: Classification system that groups similar clinical conditions (diagnoses) and the procedures furnished by the hospital during the stay.
* DRG_Desc: Description of the classification system (DRG) that groups similar clinical conditions (diagnoses) and the procedures furnished by the hospital during the stay.
* Tot_Dschrgs: The number of discharges billed by all providers for inpatient hospital services.
* Avg_Submtd_Cvrd_Chrg: The average charge of all providers' services covered by Medicare for discharges in the DRG. In other words: **what the provider billed Medicare (on average) for the diagnosis**.  
* Avg_Tot_Pymt_Amt: The average total payments to all providers for the DRG including the MS-DRG amount, teaching,  disproportionate share, capital, and outlier payments for all cases. In other words: **what Medicare actually paid (on average) for the diagnosis, including amounts paid by the patients**. 
* Avg_Mdcr_Pymt_Amt: The average amount that Medicare pays to the provider for Medicare's share of the MS-DRG. In other words: *

DROP TABLE Stats;
DROP TABLE DRGs;
DROP TABLE Providers;
DROP TABLE RUCAs;

CREATE TABLE RUCAs(
    Rndrng_Prvdr_RUCA FLOAT PRIMARY KEY NOT NULL,
    Rndrng_Prvdr_RUCA_Desc VARCHAR(100)
);

CREATE TABLE Providers(
    Rndrng_Prvdr_CCN INT PRIMARY KEY NOT NULL,
    Rndrng_Prvdr_Org_Name VARCHAR(50),
    Rndrng_Prvdr_St VARCHAR(50),
    Rndrng_Prvdr_City VARCHAR(30),
    Rndrng_Prvdr_State_Abrvtn VARCHAR(3),
    Rndrng_Prvdr_State_FIPS INT,
    Rndrng_Prvdr_Zip5 INT, 
    RUCA_cd FLOAT,
    FOREIGN KEY (RUCA_cd) REFERENCES RUCAs(Rndrng_Prvdr_RUCA),
    DRG_Cd INT,
    FOREIGN KEY (DRG_Cd) REFERENCES DRGs(DRG_Cd)
);

CREATE TABLE DRGs(
    DRG_Cd INT PRIMARY KEY NOT NULL,
    DRG_Desc VARCHAR(75)
);

CREATE TABLE Stats(
    Tot_Dschrgs INT NOT NULL,
    Avg_Submtd_Cvrd_Chrg FLOAT,
    Avg_Tot_Pymt_Amt FLOAT,
    Avg_Mdcr_Pymt_Amt FLOAT,
    PRIMARY KEY(Tot_Dschrgs, Avg_Submtd_Cvrd_Chrg, Avg_Tot_Pymt_Amt, Avg_Mdcr_Pymt_Amt),
    Rndrng_Prvdr_CCN INT,
    FOREIGN KEY (Rndrng_Prvdr_CCN) REFERENCES Providers(Rndrng_Prvdr_CCN)
);


INSERT INTO RUCAS VALUES
(1, 'Metropolitan area core: primary flow within an urbanized area of 50,000 and greater');

CREATE USER "admin" PASSWORD '135791';
GRANT ALL ON TABLE Providers TO "admin";
GRANT ALL ON TABLE RUCAs TO "admin";
GRANT ALL ON TABLE DRGs TO "admin";
GRANT ALL ON TABLE Stats TO "admin";

-- queries

-- a) List all diagnosis in alphabetical order.    

-- b) List the names and correspondent states (including Washington D.C.) of all of the providers in alphabetical order (state first, provider name next, no repetition). 

-- c) List the total number of providers.

-- d) List the total number of providers per state (including Washington D.C.) in alphabetical order (also printing out the state).  

-- e) List the providers names in Denver (CO) or in Lakewood (CO) in alphabetical order  

-- f) List the number of providers per RUCA code (showing the code and description)

-- g) Show the DRG description for code 308 

-- h) List the top 10 providers (with their correspondent state) that charged (as described in Avg_Submtd_Cvrd_Chrg) the most for the DRG code 308. Output should display the provider name, their city, state, and the average charged amount in descending order.   

-- i) List the average charges (as described in Avg_Submtd_Cvrd_Chrg) of all providers per state for the DRG code 308. Output should display the state and the average charged amount per state in descending order (of the charged amount) using only two decimals. 

-- j) Which provider and clinical condition pair had the highest difference between the amount charged (as described in Avg_Submtd_Cvrd_Chrg) and the amount covered by Medicare only (as described in Avg_Mdcr_Pymt_Amt)?
