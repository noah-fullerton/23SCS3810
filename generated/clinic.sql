CREATE TABLE Physicians (
	upni VARCHAR(255),	-- added default type
	email VARCHAR(255),	-- added default type
	first_name VARCHAR(255),	-- added default type
	last_name VARCHAR(255),	-- added default type
	address VARCHAR(255),	-- added default type
	phone VARCHAR(255),	-- added default type
	specialty VARCHAR(255),	-- added default type
	PRIMARY KEY (upni)
);
CREATE TABLE Patients (
	id VARCHAR(255),	-- added default type
	first_name VARCHAR(255),	-- added default type
	last_name VARCHAR(255),	-- added default type
	address VARCHAR(255),	-- added default type
	phone VARCHAR(255),	-- added default type
	PRIMARY KEY (id)
);
CREATE TABLE Insurances (
	HPID VARCHAR(255),	-- added default type
	name VARCHAR(255),	-- added default type
	tool_free VARCHAR(255),	-- added default type
	PRIMARY KEY (HPID)
);
CREATE TABLE attends (
	upni VARCHAR(255),	-- added default type
	id VARCHAR(255),	-- added default type
	PRIMARY KEY (upni, id),
	FOREIGN KEY (upni) REFERENCES Physicians (upni) ON DELETE CASCADE,
	FOREIGN KEY (id) REFERENCES Patients (id) ON DELETE CASCADE
);
CREATE TABLE has (
	id VARCHAR(255),	-- added default type
	HPID VARCHAR(255),	-- added default type
	policy_number VARCHAR(255),	-- added default type
	PRIMARY KEY (id, HPID),
	FOREIGN KEY (id) REFERENCES Patients (id) ON DELETE CASCADE,
	FOREIGN KEY (HPID) REFERENCES Insurances (HPID) ON DELETE CASCADE
);
