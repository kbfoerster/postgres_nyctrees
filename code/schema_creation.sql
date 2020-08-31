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
	ID SERIAL PRIAMRY KEY,
	zipcity VARCHAR (25) NOT NULL,
	zipcode INT NOT NULL
);