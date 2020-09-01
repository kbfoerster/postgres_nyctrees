-- Creating our initial temporary table to copy into other individual tables
COPY nyctrees.temp_import FROM '/usr/share/data/data.csv' DELIMITER ',' CSV HEADER;

-- Copying from temp to healthstatus
INSERT INTO nyctrees.healthstatus (healthstatus)
SELECT DISTINCT healthstatus
FROM nyctrees.temp_import
ON CONFLICT DO NOTHING;

-- Copying from temp to boroct
INSERT INTO nyctrees.boroct (boroct)
SELECT DISTINCT boroct
FROM nyctrees.temp_import
ON CONFLICT DO NOTHING;

-- Copying from temp to borocode
INSERT INTO nyctrees.borocode (borocode, boroname)
SELECT DISTINCT borocode, boroname
FROM nyctrees.temp_import
ON CONFLICT DO NOTHING;

-- Copying from temp to census
INSERT INTO nyctrees.census (income, education, population, unemployment, popdensity, laborforce, poverty, diversity)
SELECT DISTINCT income, education, population, unemployment, popdensity, laborforce, poverty, diversity
FROM nyctrees.temp_import
ON CONFLICT DO NOTHING;

-- Copying from temp to cncldist
INSERT INTO nyctrees.cncldist (cncldist)
SELECT DISTINCT cncldist
FROM nyctrees.temp_import
ON CONFLICT DO NOTHING;

-- Copying from temp to genus
INSERT INTO nyctrees.genus (genus)
SELECT DISTINCT genus
FROM nyctrees.temp_import
ON CONFLICT DO NOTHING;

-- Copying from temp to inf_guard
INSERT INTO nyctrees.inf_guard (infguard)
SELECT DISTINCT infguard
FROM nyctrees.temp_import
ON CONFLICT DO NOTHING;

-- Copying from temp to inf_shoes
INSERT INTO nyctrees.inf_shoes (infshoes)
SELECT DISTINCT infshoes
FROM nyctrees.temp_import
ON CONFLICT DO NOTHING;


-- Copying from temp to neighborhood_broad
INSERT INTO nyctrees.neighborhood_broad (nta_code, ntaname)
SELECT DISTINCT nta, ntaname
FROM nyctrees.temp_import
ON CONFLICT DO NOTHING;

-- Copying from temp to neighborhood_specific
INSERT INTO nyctrees.neighborhood_specific (ntaname_full)
SELECT DISTINCT ntanamefull
FROM nyctrees.temp_import
ON CONFLICT DO NOTHING;

-- Copying from temp to sidw_crack
INSERT INTO nyctrees.sidw_crack (sidwcrack)
SELECT DISTINCT sidwcrack
FROM nyctrees.temp_import
ON CONFLICT DO NOTHING;

-- Copying from temp to species
INSERT INTO nyctrees.species (species)
SELECT DISTINCT species
FROM nyctrees.temp_import
ON CONFLICT DO NOTHING;

-- Copying from temp to st_assem
INSERT INTO nyctrees.st_assem (stassem)
SELECT DISTINCT stassem
FROM nyctrees.temp_import
ON CONFLICT DO NOTHING;

-- Copying from temp to st_senate
INSERT INTO nyctrees.st_senate (stsenate)
SELECT DISTINCT stsenate
FROM nyctrees.temp_import
ON CONFLICT DO NOTHING;

-- Copying from temp to year
INSERT INTO nyctrees.year (year)
SELECT DISTINCT year
FROM nyctrees.temp_import
ON CONFLICT DO NOTHING;

-- Copying from temp to zipcity
INSERT INTO nyctrees.zipcity (zipcity)
SELECT DISTINCT zipcity
FROM nyctrees.temp_import
ON CONFLICT DO NOTHING;

-- Copying from temp to zipcode
