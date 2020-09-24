SET search_path TO nyctrees;

-- Creating view for information specifically about trees
CREATE VIEW trees AS 
SELECT ge.genus, sp.species, tree_dbh, he.healthstatus, gu.infguard, sh.infshoes, cr.sidwcrack, ye.year, nf.ntanamefull
FROM facts
JOIN genus ge ON genus_id = ge.id
JOIN species sp ON species_id = sp.id
JOIN healthstatus he ON healthstatus_id = he.id
JOIN inf_guard gu ON guard_id = gu.id
JOIN inf_shoes sh ON shoes_id = sh.id
JOIN sidw_crack cr ON crack_id = cr.id
JOIN year ye ON year_id = ye.id
JOIN neighborhood_specific nf ON ntafull_id = nf.id;

-- Creating view for location information with trees
CREATE VIEW locations AS SELECT ge.genus,sp.species,zt.zipcity,zc.zipcode,am.stassem,se.stsenate,cn.cncldist,bt.boroct,bc.borocode,ye.year,longitude,latitude,x_sp,y_sp
FROM nyctrees.facts
JOIN nyctrees.genus ge ON genus_id = ge.id
JOIN nyctrees.species sp ON species_id = sp.id
JOIN nyctrees.zipcity zt ON zipcity_id = zt.id
JOIN nyctrees.zipcode zc ON zipcode_id = zc.id
JOIN nyctrees.st_assem am ON assem_id = am.id
JOIN nyctrees.st_senate se ON senate_id = se.id
JOIN nyctrees.cncldist cn ON cncldist_id = cn.id
JOIN nyctrees.boroct bt ON boroct_id = bt.id
JOIN nyctrees.borocode bc ON borocode_id = bc.id
JOIN nyctrees.year ye ON year_id = ye.id;

-- Creating view for census information on neighborhoods by year
CREATE VIEW neighborhood_census AS 
SELECT DISTINCT nb.ntaname, ye.year, ce.income, ce.education, ce.population, ce.unemployment, ce.popdensity, ce.laborforce, ce.poverty, ce.diversity
FROM facts
JOIN neighborhood_broad nb ON nta_id = nb.id
JOIN year ye ON year_id = ye.id
JOIN census ce ON census_id = ce.id;