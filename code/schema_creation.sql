CREATE SCHEMA IF NOT EXISTS nyctrees AUTHORIZATION postgres;

CREATE TABLE IF NOT EXISTS nyctrees.temp_import (
	nta varchar (4),
	ntaname VARCHAR (40),
	boroct INT,
	borocode INT, 
	boroname VARCHAR (15),
	cncldist INT,
	infguard BOOLEAN,
	infshoes BOOLEAN,
	latitude REAL,
	longitude REAL,
	sidwcrack BOOLEAN,
	stassem INT,
	stsenate INT,
	healthstatus VARCHAR (5),
	tree_dbh INT,
	x_sp REAL,
	y_sp REAL,
	zipcity VARCHAR(25),
	zipcode INT,
	year INT,
	income REAL,
	education REAL,
	population REAL,
	unemployment REAL,
	popdensity REAL,
	laborforce REAL,
	poverty REAL,
	diversity REAL,
	genus VARCHAR (25),
	species VARCHAR (25),
	ntanamefull VARCHAR (65)
);

CREATE TABLE IF NOT EXISTS nyctrees.healthstatus (
	ID SERIAL PRIMARY KEY,
	healthstatus VARCHAR (5) NOT NULL
);

CREATE TABLE IF NOT EXISTS nyctrees.neighborhood_specific (
	ID SERIAL PRIMARY KEY,
	ntanamefull VARCHAR(65) NOT NULL
);

CREATE TABLE IF NOT EXISTS nyctrees.neighborhood_broad (
	ID SERIAL PRIMARY KEY,
	ntacode VARCHAR(4) NOT NULL,
	ntaname VARCHAR (40) NOT NULL
);

CREATE TABLE IF NOT EXISTS nyctrees.census (
	ID SERIAL PRIMARY KEY,
	income REAL NOT NULL,
	education REAL NOT NULL,
	population REAL NOT NULL,
	unemployment REAL NOT NULL,
	popdensity REAL NOT NULL,
	laborforce REAL NOT NULL,
	poverty REAL NOT NULL,
	diversity REAL NOT NULL
);

CREATE TABLE IF NOT EXISTS nyctrees.boroct (
	ID SERIAL PRIMARY KEY,
	boroct INT NOT NULL,
);

CREATE TABLE IF NOT EXISTS nyctrees.borocode (
	ID SERIAL PRIMARY KEY,
	borocode INT NOT NULL,
	boroname VARCHAR (15) NOT NULL
)

CREATE TABLE IF NOT EXISTS nyctrees.zipcity (
	ID SERIAL PRIMARY KEY,
	zipcity VARCHAR (25) NOT NULL
);

CREATE TABLE IF NOT EXISTS nyctrees.zipcode (
	ID SERIAL PRIMARY KEY,
	zipcode INT NOT NULL
)

CREATE TABLE IF NOT EXISTS nyctrees.year (
	ID SERIAL PRIMARY KEY,
	year INT NOT NULL
);

CREATE TABLE IF NOT EXISTS nyctrees.sidw_crack (
	ID SERIAL PRIMARY KEY,
	sidwcrack BOOLEAN NOT NULL
);

CREATE TABLE IF NOT EXISTS nyctrees.cncldist (
	ID SERIAL PRIMARY KEY,
	cncldist INT NOT NULL
);

CREATE TABLE IF NOT EXISTS nyctrees.st_senate (
	ID SERIAL PRIMARY KEY,
	stsenate INT NOT NULL
);

CREATE TABLE IF NOT EXISTS nyctrees.st_assem (
	ID SERIAL PRIMARY KEY,
	stassem INT NOT NULL
);

CREATE TABLE IF NOT EXISTS nyctrees.inf_shoes (
	ID SERIAL PRIMARY KEY,
	infshoes BOOLEAN NOT NULL
);

CREATE TABLE IF NOT EXISTS nyctrees.inf_guard (
	ID SERIAL PRIMARY KEY,
	infguard BOOLEAN NOT NULL
);

CREATE TABLE IF NOT EXISTS nyctrees.species (
	ID SERIAL PRIMARY KEY,
	species VARCHAR (25)
);

CREATE TABLE IF NOT EXISTS nyctrees.genus (
	ID SERIAL PRIMARY KEY,
	genus VARCHAR (25)
);

CREATE TABLE IF NOT EXISTS nyctrees.facts (
	healthstatus_id INT REFERENCES nyctrees.healthstatus(ID),
	guard_id INT REFERENCES nyctrees.inf_guard(ID),
	shoes_id INT REFERENCES nyctrees.inf_shoes(ID),
	assem_id INT REFERENCES nyctrees.st_assem(ID),
	senate_id INT REFERENCES nyctrees.st_senate(ID),
	crack_id INT REFERENCES nyctrees.sidw_crack(ID),
	cncldist_id INT REFERENCES nyctrees.cncldist(ID),
	genus_id INT REFERENCES nyctrees.genus(ID),
	species_id INT REFERENCES nyctrees.species(ID),
	census_id INT REFERENCES nyctrees.census(ID),
	boroct_id INT REFERENCES nyctrees.boroct(ID),
	borocode_id INT REFERENCES nyctrees.borocode(ID),
	zipcity_id INT REFERENCES nyctrees.zipcity(ID),
	zipcode_id INT REFERENCES nyctrees.zipcode(ID),
	year_id INT REFERENCES nyctrees.year(ID),
	ntafull_id INT REFERENCES nyctrees.neighborhood_specific(ID),
	nta_id INT REFERENCES nyctrees.neighborhood_broad(ID),
	tree_dbh INT NOT NULL,
	longitude REAL NOT NULL,
	latitude REAL NOT NULL,
	x_sp REAL NOT NULL,
	y_sp REAL NOT NULL
);