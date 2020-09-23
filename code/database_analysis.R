library(DBI)
library(RPostgres)
library(ggplot2)
library(forcats)

con = dbConnect(
  drv = RPostgres::Postgres(),
  host = "localhost",
  port = 5432,
  # Please don't use plain text password in production :)
  user = "postgres",
  password = "secure_p4ssw0rd",
  dbname = "postgres"
)

trees = dbGetQuery(con, 'SELECT * FROM nyctrees.trees')
locations = dbGetQuery(con, 'SELECT * FROM nyctrees.locations')
census = dbGetQuery(con, 'SELECT * FROM nyctrees.neighborhood_census')



#### Visualizing 'trees' view

# First we can see expected columns/entries are displaying correctly
head(locations)

# Creating our initial bargraph
ggplot(data=trees, aes(x=fct_infreq(genus))) + geom_bar(stat="count") + theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))

top_genus = dbGetQuery(con, 'SELECT genus, COUNT(genus) FROM nyctrees.trees WHERE year = 2015 GROUP BY genus  ORDER BY COUNT(genus) DESC LIMIT 15')

ggplot(data=top_genus, aes(x=reorder(genus, count), count)) + 
  coord_flip() +
  geom_bar(stat="identity", fill="darkgreen") + 
  geom_text(aes(label=count), hjust=-0.3, size=3.5) +
  scale_y_continuous(limits=c(0,87500)) + 
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) + 
  labs(title="Top 15 Genus Counts in 2015", y="Count", x="Genus")
  
top_species = dbGetQuery(con, 'SELECT species, COUNT(species) FROM nyctrees.trees WHERE year = 2015 GROUP BY species ORDER BY COUNT(species) DESC LIMIT 15')

ggplot(data=top_species, aes(x=reorder(species, count), count)) + 
  coord_flip() +
  geom_bar(stat="identity", fill="darkblue") + 
  geom_text(aes(label=count), hjust=-0.3, size=3.5) +
  scale_y_continuous(limits=c(0,87500)) + 
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) + 
  labs(title="Top 15 Species Counts in 2015", y="Count", x="Genus")

top_locations = dbGetQuery(con, 'SELECT ntanamefull, COUNT(ntanamefull) FROM nyctrees.trees WHERE year=2015 GROUP BY ntanamefull ORDER BY COUNT(ntanamefull) DESC LIMIT 25')

ggplot(data=top_locations, aes(x=reorder(ntanamefull, count), y=count)) + 
  geom_bar(stat="identity", fill="darkgreen") + 
  geom_text(aes(label=count), hjust=-0.3, size=3.5) +
  scale_y_continuous(limits=c(0,11500)) + 
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1)) +
  labs(title="Top 25 Neighborhood Counts in 2015", y="Count", x="Neighborhood") +
  coord_flip()

annadale_species = dbGetQuery(con, "SELECT species, COUNT(species) FROM nyctrees.trees WHERE year = 2015 AND ntanamefull = 'Annadale-Huguenot-Prince''s Bay-Eltingville' GROUP BY species ORDER BY COUNT(species) DESC LIMIT 10")

ggplot(data=annadale_species, aes(x=reorder(species, count), y=count)) + 
  geom_bar(stat="identity", fill="darkgreen") +
  geom_text(aes(label=count), hjust=-0.3, size=3.5) +
  scale_y_continuous(limits=c(0,11500)) + 
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1)) +
  labs(title="Top 10 Species in the Annadale-Huguenot-Prince's Bay-Eltingville Neighborhoods in 2015", y="count", x="Species") + 
  coord_flip()

dbDisconnect(con)
