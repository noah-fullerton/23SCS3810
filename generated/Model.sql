CREATE TABLE Physicians (
	UPNI VARCHAR(255),	-- added default type
	firstName VARCHAR(255),	-- added default type
	lastName VARCHAR(255),	-- added default type
	specialty VARCHAR(255),	-- added default type
	phoneNumber VARCHAR(255),	-- added default type
	address VARCHAR(255),	-- added default type
	email VARCHAR(255),	-- added default type
	PRIMARY KEY (UPNI)
);
CREATE TABLE Patients (
	number VARCHAR(255),	-- added default type
	firstName VARCHAR(255),	-- added default type
	lastName VARCHAR(255),	-- added default type
	address VARCHAR(255),	-- added default type
	phoneNumber VARCHAR(255),	-- added default type
	PRIMARY KEY (number)
);
CREATE TABLE HealthInsurancePlans (
	HPID VARCHAR(255),	-- added default type
	name VARCHAR(255),	-- added default type
	number VARCHAR(255),	-- added default type
	PRIMARY KEY (HPID)
);
CREATE TABLE assist (
	UPNI VARCHAR(255),	-- added default type
	number VARCHAR(255),	-- added default type
	PRIMARY KEY (UPNI, number),
	FOREIGN KEY (UPNI) REFERENCES Physicians (UPNI) ON DELETE CASCADE,
	FOREIGN KEY (number) REFERENCES Patients (number) ON DELETE CASCADE
);
CREATE TABLE have (
	number VARCHAR(255),	-- added default type
	HPID VARCHAR(255),	-- added default type
	policyNumber VARCHAR(255),	-- added default type
	PRIMARY KEY (number, HPID),
	FOREIGN KEY (number) REFERENCES Patients (number) ON DELETE CASCADE,
	FOREIGN KEY (HPID) REFERENCES HealthInsurancePlans (HPID) ON DELETE CASCADE
);
