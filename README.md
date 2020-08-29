# postgres_nyctrees
The purpose of this project is to create a data warehouse sceham in postgres to store the NYCTrees dataset. 

Since the data is relatively static and won't have high transaction levels, we'll opt for a schema that facilities On-Line Analytical Processing (OLAP). We'll plan on implementing a star schema to accomplish this. 

For details on the complete dataset specifically, please see the [nyctrees project](https://github.com/kbfoerster/nyctrees). This project will be using a slightly modified version, also found in the [logstash_nyctrees project](https://github.com/kbfoerster/logstash_nyctrees). 

## NYCTrees Schema

The schema being used for this database is shown below. The goal of this schema is to create a BCNF normalized data warehouse for the trees information. Specifically, the main fact table aims to give us information about a single tree that encompasses a wide array of information. Anything from tree health the census information in the surrounding neighborhood. 

![NYCTrees Schema](/Images/postgres_schema.png)

Some environments may wish to have a lower form of normalization to increase performance. However, since the main goal is to create an OLAP warehouse, this highly normalized structure will be appropriate. 