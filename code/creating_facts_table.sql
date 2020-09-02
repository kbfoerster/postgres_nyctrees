INSERT INTO nyctrees.facts (healthstatus_id, guard_id, shoes_id, assem_id, senate_id, crack_id, cncldist_id, genus_id, species_id, 
							census_id, boroct_id, borocode_id, zipcity_id, zipcode_id, year_id, ntafull_id, nta_id, tree_dbh, longitude, latitude, x_sp, y_sp)
	SELECT DISTINCT he.id, gu.id, sh.id, am.id, se.id, cr.id, cn.id, ge.id, sp.id, ce.id, bt.id, bc.id, zt.id, zc.id, ye.id, nf.id, nb.id, tp.tree_dbh, tp.longitude, tp.latitude, tp.x_sp, tp.y_sp
	FROM nyctrees.temp_import tp
	JOIN nyctrees.healthstatus he ON tp.healthstatus = he.healthstatus
	JOIN nyctrees.inf_guard gu ON tp.infguard = gu.infguard
	JOIN nyctrees.inf_shoes sh ON tp.infshoes = sh.infshoes
	JOIN nyctrees.st_assem am ON tp.stassem = am.stassem
	JOIN nyctrees.st_senate se ON tp.stsenate = se.stsenate
	JOIN nyctrees.sidw_crack cr ON tp.sidwcrack = cr.sidwcrack
	JOIN nyctrees.cncldist cn ON tp.cncldist = cn.cncldist
	JOIN nyctrees.genus ge ON tp.genus = ge.genus
	JOIN nyctrees.species sp ON tp.species = sp.species
	JOIN nyctrees.census ce ON tp.education = ce.education
	JOIN nyctrees.boroct bt ON tp.boroct = bt.boroct
	JOIN nyctrees.borocode bc ON tp.borocode = bc.borocode
	JOIN nyctrees.zipcity zt ON tp.zipcity = zt.zipcity
	JOIN nyctrees.zipcode zc ON tp.zipcode = zc.zipcode
	JOIN nyctrees.year ye ON tp.year = ye.year
	JOIN nyctrees.neighborhood_specific nf ON tp.nta = nf.ntacode
	JOIN nyctrees.neighborhood_broad nb ON tp.ntaname = nb.ntaname;	
	
	
DROP TABLE nyctrees.temp_import;