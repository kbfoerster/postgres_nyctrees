library(DBI)
library(RPostgres)

con = dbConnect(
  drv = RPostgres::Postgres(),
  host = "localhost",
  port = 5432,
  # Please don't use plain text password in production :)
  user = "postgres",
  password = "secure_p4ssw0rd",
  dbname = "postgres"
)
