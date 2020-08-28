# postgres_nyctrees
The purpose of this project is to create a data warehouse sceham in postgres to store the NYCTrees dataset. 

Since the data is relatively static and won't have high transaction levels, we'll opt for a schema that facilities On-Line Analytical Processing (OLAP). We'll plan on implementing a star schema to accomplish this. 

For details on the complete dataset specifically, please see the [nyctrees project](https://github.com/kbfoerster/nyctrees). This project will be using a slightly modified version, also found in the [logstash_nyctrees project](https://github.com/kbfoerster/logstash_nyctrees). 
