-- Creating our initial temporary table to copy into other individual tables
COPY temp_import FROM '/usr/share/data/data.csv' DELIMITER ',' CSV HEADER;

-- Copying from temp to healthstatus
INSERT INTO healthstatus (healthstatus)
SELECT DISTINCT healthstatus
FROM temp_import
ON CONFLICT DO NOTHING;

-- Copying from temp to boroct
INSERT INTO boroct (boroct)
SELECT DISTINCT boroct
FROM temp_import
ON CONFLICT DO NOTHING;

-- Copying from temp to borocode
INSERT INTO borocode (borocode, boroname)
SELECT DISTINCT borocode, boroname
FROM temp_import
ON CONFLICT DO NOTHING;

-- Copying from temp to census
INSERT INTO census (income, education, population, unemployment, popdensity, laborforce, poverty, diversity)
SELECT DISTINCT income, education, population, unemployment, popdensity, laborforce, poverty, diversity
FROM temp_import
ON CONFLICT DO NOTHING;

-- Copying from temp to cncldist
INSERT INTO cncldist (cncldist)
SELECT DISTINCT cncldist
FROM temp_import
ON CONFLICT DO NOTHING;

-- Copying from temp to genus
INSERT INTO genus (genus)
SELECT DISTINCT genus
FROM temp_import
ON CONFLICT DO NOTHING;

-- Copying from temp to inf_guard
INSERT INTO inf_guard (infguard)
SELECT DISTINCT infguard
FROM temp_import
ON CONFLICT DO NOTHING;

-- Copying from temp to inf_shoes
INSERT INTO inf_shoes (infshoes)
SELECT DISTINCT infshoes
FROM temp_import
ON CONFLICT DO NOTHING;


-- Copying from temp to neighborhood_broad
INSERT INTO neighborhood_broad (ntaname)
SELECT DISTINCT ntaname
FROM temp_import
ON CONFLICT DO NOTHING;

-- Copying from temp to neighborhood_specific
INSERT INTO neighborhood_specific (ntacode, ntanamefull)
SELECT DISTINCT nta, ntanamefull
FROM temp_import
ON CONFLICT DO NOTHING;

-- Copying from temp to sidw_crack
INSERT INTO sidw_crack (sidwcrack)
SELECT DISTINCT sidwcrack
FROM temp_import
ON CONFLICT DO NOTHING;

-- Copying from temp to species
INSERT INTO species (species)
SELECT DISTINCT species
FROM temp_import
ON CONFLICT DO NOTHING;

-- Copying from temp to st_assem
INSERT INTO st_assem (stassem)
SELECT DISTINCT stassem
FROM temp_import
ON CONFLICT DO NOTHING;

-- Copying from temp to st_senate
INSERT INTO st_senate (stsenate)
SELECT DISTINCT stsenate
FROM temp_import
ON CONFLICT DO NOTHING;

-- Copying from temp to year
INSERT INTO year (year)
SELECT DISTINCT year
FROM temp_import
ON CONFLICT DO NOTHING;

-- Copying from temp to zipcity
INSERT INTO zipcity (zipcity)
SELECT DISTINCT zipcity
FROM temp_import
ON CONFLICT DO NOTHING;

-- Copying from temp to zipcode
INSERT INTO zipcode (zipcode)
SELECT DISTINCT zipcode
FROM temp_import
ON CONFLICT DO NOTHING;