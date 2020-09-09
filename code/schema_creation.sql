CREATE SCHEMA IF NOT EXISTS nyctrees AUTHORIZATION postgres;
SET search_path TO nyctrees;

CREATE TABLE IF NOT EXISTS temp_import (
	nta varchar (4),
	ntaname VARCHAR (40),
	boroct INT,
	borocode INT, 
	boroname VARCHAR (15),
	cncldist INT,
	infguard BOOLEAN,
	infshoes BOOLEAN,
	longitude NUMERIC(10,8),
	latitude NUMERIC(10,8),
	sidwcrack BOOLEAN,
	stassem INT,
	stsenate INT,
	healthstatus VARCHAR (5),
	tree_dbh INT,
	x_sp NUMERIC(13,6),
	y_sp NUMERIC(13,6),
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

CREATE TABLE IF NOT EXISTS healthstatus (
	ID SERIAL PRIMARY KEY,
	healthstatus VARCHAR (5) NOT NULL
);

CREATE TABLE IF NOT EXISTS neighborhood_specific (
	ID SERIAL PRIMARY KEY,
	ntacode VARCHAR(4) NOT NULL,
	ntanamefull VARCHAR(65) NOT NULL
);

CREATE TABLE IF NOT EXISTS neighborhood_broad (
	ID SERIAL PRIMARY KEY,
	ntaname VARCHAR (40) NOT NULL
);

CREATE TABLE IF NOT EXISTS census (
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

CREATE TABLE IF NOT EXISTS boroct (
	ID SERIAL PRIMARY KEY,
	boroct INT NOT NULL,
);

CREATE TABLE IF NOT EXISTS borocode (
	ID SERIAL PRIMARY KEY,
	borocode INT NOT NULL,
	boroname VARCHAR (15) NOT NULL
);

CREATE TABLE IF NOT EXISTS zipcity (
	ID SERIAL PRIMARY KEY,
	zipcity VARCHAR (25) NOT NULL
);

CREATE TABLE IF NOT EXISTS zipcode (
	ID SERIAL PRIMARY KEY,
	zipcode INT NOT NULL
);

CREATE TABLE IF NOT EXISTS year (
	ID SERIAL PRIMARY KEY,
	year INT NOT NULL
);

CREATE TABLE IF NOT EXISTS sidw_crack (
	ID SERIAL PRIMARY KEY,
	sidwcrack BOOLEAN NOT NULL
);

CREATE TABLE IF NOT EXISTS cncldist (
	ID SERIAL PRIMARY KEY,
	cncldist INT NOT NULL
);

CREATE TABLE IF NOT EXISTS st_senate (
	ID SERIAL PRIMARY KEY,
	stsenate INT NOT NULL
);

CREATE TABLE IF NOT EXISTS st_assem (
	ID SERIAL PRIMARY KEY,
	stassem INT NOT NULL
);

CREATE TABLE IF NOT EXISTS inf_shoes (
	ID SERIAL PRIMARY KEY,
	infshoes BOOLEAN NOT NULL
);

CREATE TABLE IF NOT EXISTS inf_guard (
	ID SERIAL PRIMARY KEY,
	infguard BOOLEAN NOT NULL
);

CREATE TABLE IF NOT EXISTS species (
	ID SERIAL PRIMARY KEY,
	species VARCHAR (25)
);

CREATE TABLE IF NOT EXISTS genus (
	ID SERIAL PRIMARY KEY,
	genus VARCHAR (25)
);

CREATE TABLE IF NOT EXISTS facts (
	healthstatus_id INT REFERENCES healthstatus(ID),
	guard_id INT REFERENCES inf_guard(ID),
	shoes_id INT REFERENCES inf_shoes(ID),
	assem_id INT REFERENCES st_assem(ID),
	senate_id INT REFERENCES st_senate(ID),
	crack_id INT REFERENCES sidw_crack(ID),
	cncldist_id INT REFERENCES cncldist(ID),
	genus_id INT REFERENCES genus(ID),
	species_id INT REFERENCES species(ID),
	census_id INT REFERENCES census(ID),
	boroct_id INT REFERENCES boroct(ID),
	borocode_id INT REFERENCES borocode(ID),
	zipcity_id INT REFERENCES zipcity(ID),
	zipcode_id INT REFERENCES zipcode(ID),
	year_id INT REFERENCES year(ID),
	ntafull_id INT REFERENCES neighborhood_specific(ID),
	nta_id INT REFERENCES neighborhood_broad(ID),
	tree_dbh INT NOT NULL,
	longitude NUMERIC(10,8) NOT NULL,
	latitude NUMERIC(10,8) NOT NULL,
	x_sp NUMERIC(13,6) NOT NULL,
	y_sp NUMERIC (13,6) NOT NULL
);