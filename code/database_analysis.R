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



#### Visualizing 'trees' view ####

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

annadale_species = dbGetQuery(con, "SELECT species, COUNT(species) FROM nyctrees.trees WHERE year = 2015 AND ntanamefull = 'Annadale-Huguenot-Prince''s Bay-Eltingville' GROUP BY species ORDER BY COUNT(species) DESC LIMIT 10")

ggplot(data=annadale_species, aes(x=reorder(species, count), y=count)) + 
  geom_bar(stat="identity", fill="darkgreen") +
  geom_text(aes(label=count), hjust=-0.3, size=3.5) +
  scale_y_continuous(limits=c(0,4300)) + 
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1)) +
  labs(title="Top 10 Species in the Annadale-Huguenot-Prince's Bay-Eltingville Neighborhoods in 2015", y="count", x="Species") + 
  coord_flip()

dbh_dist = dbGetQuery(con, 'SELECT  tree_dbh FROM nyctrees.trees WHERE year = 2015 ')

ggplot(data=dbh_dist, aes(x=dbh_dist$tree_dbh)) + 
  geom_histogram(color="green", fill="darkgreen", binwidth = 1) +
  labs(title="Histogram of Tree Diameter at Breast Height", y="Count", x="Tree DBH") + 
  theme_classic()

dbGetQuery(con, "SELECT 3*stddev(tree_dbh) FROM nyctrees.trees AS t (stddev) WHERE year = 2015")

dbh_dist = dbGetQuery(con, 'SELECT  tree_dbh FROM nyctrees.trees WHERE year = 2015 AND tree_dbh < 27')

#### Visualizing 'locations' view ####
head(locations)


top_zipcity = dbGetQuery(con, 'SELECT zipcity, COUNT(zipcity) FROM nyctrees.locations WHERE year=2015 GROUP BY zipcity ORDER BY COUNT(zipcity) DESC LIMIT 7')

ggplot(data=top_zipcity, aes(x=reorder(zipcity, count), y=count)) + 
  geom_bar(stat="identity", fill="darkgreen") + 
  geom_text(aes(label=count), hjust=-0.3, size=3.5) +
  scale_y_continuous(limits=c(0,165000)) + 
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1)) +
  labs(title="Top 25 Neighborhood Counts in 2015", y="Count", x="Neighborhood") +
  coord_flip()


zip_labs = paste(top_zipcity$zipcity, " - ", round(100*top_zipcity$count/sum(top_zipcity$count), 1), "%")
pie(top_zipcity$count, labels=zip_labs, col=rainbow(length(top_zipcity$zipcity)), main= "Tree count by Zipcities")

#### Visualizing 'Census' view ####
head(census)
# Education source http://app.coredata.nyc/?mlb=false&ntii=&ntr=&mz=14&vtl=https%3A%2F%2Fthefurmancenter.carto.com%2Fu%2Fnyufc%2Fapi%2Fv2%2Fviz%2F98d1f16e-95fd-4e52-a2b1-b7abaf634828%2Fviz.json&mln=false&mlp=true&mlat=40.718&ptsb=&nty=&mb=roadmap&pf=%7B%22subsidies%22%3Atrue%7D&md=map&mlv=false&mlng=-73.996&btl=Borough&atp=properties


education_distribution = dbGetQuery(con, 'SELECT education FROM nyctrees.neighborhood_census WHERE year=2015')

ggplot(data=education_distribution, aes(x=education)) +
  geom_histogram(fill="darkblue") + 
  scale_y_continuous(limits=c(0,10), breaks=1:10) +
  #scale_x_discrete(breaks=0.01:0.9) +
  labs(title="Histogram of Education for Neighborhoods in 2015", y="Count", x="Education (Ratio of Population Aged 25+ with Bachelor's or Higher)")

dbDisconnect(con)
