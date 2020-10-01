# postgres_nyctrees
The purpose of this project is to create a data warehouse sceham in postgres to store the NYCTrees dataset. 

Since the data is relatively static and won't have high transaction levels, we'll opt for a schema that facilities On-Line Analytical Processing (OLAP). We'll plan on implementing a star schema to accomplish this. 

For details on the complete dataset specifically, please see the [nyctrees project](https://github.com/kbfoerster/nyctrees). This project will be using a slightly modified version, also found in the [logstash_nyctrees project](https://github.com/kbfoerster/logstash_nyctrees). 

## NYCTrees Schema

The schema being used for this database is shown below. The goal of this schema is to create a BCNF normalized data warehouse for the trees information. Specifically, the main fact table aims to give us information about a single tree that encompasses a wide array of information. Anything from tree health the census information in the surrounding neighborhood. 

![NYCTrees Schema](/Images/postgres_schema.png)

Some environments may wish to have a lower form of normalization to increase performance. However, since the main goal is to create an OLAP warehouse, this highly normalized structure will be appropriate. 

We'll begin by building a temporary table to import all of our data into, followed by each of the tables identified above. [This script](/code/schema_creation.sql) will generate all of this for us. 

With our schema and tables all created, it's time to load the data into our temporary table and load the lookup tables. [This script](/code/building_tables.sql) will take care of all of this for us, loading the entirety of our original CSV!

Finally, we'll load the data into our main fact table. [This script](/code/creating_facts_table.sql) will load all distinct instances of our data into the fact table, resulting in 990,214 entries. From the image below, we can see the facts table is loaded as expected with each entry either being a foreign key or being unique to that entry (specifically coordinates). 

![Facts Table Output](/Images/facts_output.PNG)

With our fact table created, we can now create some bonus views of our data. This will be useful if we have some projects that focus on only some smaller parts of the dataset. Specifically, we'll create 3 views around the locations, trees, and census information. [This script](/code/creating_views.sql) go through creating these views. 

The benefit of going through all of this is that our final database ends up using half as much space as our original CSV! Our original CSV is ~281 MB while our database is only 140 MB. If this dataset were even larger, like the one used in our [original project](https://github.com/kbfoerster/nyctrees), then these storage savings would be even greater! 

## Analysis

Now that our database has been created and loaded with the appropriate data, we can continue with some hypothetical analyses of the data. We'll use the [jupyter notebook found here](/code/database_analysis_notebook.ipynb) to go through all the details, but we can end up creating some visualizations like the ones below. 

Using the 'trees' view, we can see the top genera of the trees in our database. 

![Top Genera of NYCTrees](/Images/Top_Genera.png)

With this same 'trees' view, we can also see a histogram of the tree_dbh attribute across our dataset. 

![Tree Diameter at Breast Height Distribution](/Images/tree_dbh_histogram.png)

Using the 'locations' view, we can see the distribution of trees based on zipcity counts. 

![Top Zipcity by Count](/Images/Top_Zipcity_pie.png)

Using the 'neighborhood census' view, we can see the education distribution of our dataset. 

![Education histogram](/Images/education_histogram.png)

## Review

Below is a quick recap of the steps that we took during this project to get the data to its final form:
- We created a docker-compose file that created a PostgreSQL database with a pgadmin front end
- We designed a star schema in our database that would have one central fact table and other ancillary tables to lookup values as needed
- We imported the data into the ancillary tables
- We populated the fact table while mapping it to the ancillary tables
- We created several views based on our fact table
- We queried these views in R and created several visualizations

I hope you enjoyed following along while we created this OLAP database for our NYCTrees dataset! 
