CREATE SCHEMA IF NOT EXISTS nyctrees AUTHORIZATION postgres;

CREATE TABLE IF NOT EXISTS nyctrees.healthstatus (
	ID SERIAL PRIMARY KEY,
	healthstatus boolean NOT NULL
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
	income INT NOT NULL,
	education INT NOT NULL,
	population INT NOT NULL,
	unemployment INT NOT NULL,
	popdensity INT NOT NULL,
	laborforce INT NOT NULL,
	poverty INT NOT NULL,
	diversity INT NOT NULL
);

CREATE TABLE IF NOT EXISTS nyctrees.boro (
	ID SERIAL PRIMARY KEY,
	boroct INT NOT NULL,
	borocode INT NOT NULL,
	boroname VARCHAR (15) NOT NULL
);

CREATE TABLE IF NOT EXISTS nyctrees.zip (
	ID SERIAL PRIMARY KEY,
	zipcity VARCHAR (25) NOT NULL,
	zipcode INT NOT NULL
);

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
	boro_id INT REFERENCES nyctrees.boro(ID),
	zip_id INT REFERENCES nyctrees.zip(ID),
	year_id INT REFERENCES nyctrees.year(ID),
	ntafull_id INT REFERENCES nyctrees.neighborhood_specific(ID),
	nta_id INT REFERENCES nyctrees.neighborhood_broad(ID),
	tree_dbh INT NOT NULL,
	longitude INT NOT NULL,
	latitude INT NOT NULL,
	x_sp INT NOT NULL,
	y_sp INT NOT NULL
);