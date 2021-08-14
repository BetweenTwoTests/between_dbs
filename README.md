# between_dbs
Sample DDL and test data for testing database schema types. 
Intended as DDL for checking of a specific DB can be consumed by external source (e.g. Spark) via DB connectors.


## Folder structure

```
.
├── between_dbs.Rproj ......................................... R project that should be opened if running R scripts
|
├── README.md ................................................. this file
|
├── {db}_{version} ............................................ DB type & version
│   ├── DDL 
│       ├── {db}_{version}_schema_ddl.sql ..................... CREATE TABLE statements for the DB version
│   ├── INSERTS 
│       ├── {db}_{version}_{table_name}_insert.sql ............ INSERT INTO statements for the {table_name}
│       ├── {db}_{version}_{table_name}_insert.csv ............ CSV file for the underlying data {table_name}
│       ├── ...
│   ├── {db}_{version}_generate_inserts.R ..................... R Script to generate /INSERTS/* files
|
├── {db}_{version} 
|   ....
```
