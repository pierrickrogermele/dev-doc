DATABASES
=========

## Relational databases

 * [Introduction to Relational Database Design](http://www.edm2.com/0612/msql7.html).

### Design

#### Database schema symbols

	⎯┼⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯┼⎯     one-to-one
	
	                  /
	⎯┼⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯     one-to-many
	                  \
	
	\                 /
	⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯     many-to-many
	/                 \
	
	⎯┼┼⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯     mandatory participation
	
	
	                  /
	⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯O⎯     optional participation
	                  \

### Lookup table

A lookup table = a validation table.

It's table where values (often string values) that are constant or quasi-constant during the lifetime of the database are stored.

Example 1: a table for states that store the two letter state code, and the state name.

Example 2: a categories table that store a category ID and the category name.

### Self referencing table

A self referencing table is one which has a foreign key that uses its own primary key.

Example 1:
A table members with fields: MemberID, MbrFirstName, MbrLastName, SponsorID, etc. Where the SponsorID is a foreign key that uses MemberID.

Example 2 (in a many-to-many relationship):
A table parts with fields: PartID, PartName, etc.
And a table PartComponents with fields: PartID, ComponentID. Where PartID and ComponentID are foreign keys that use parts.PartID.

### Subset table

A subset table is a table that adds information to a main table.

Example:
A table employee with fields EmplID, EmpFirstName, EmpLastName, HomePhone, etc.
With a table compensation with fields EmplID, HourlyRate, CommissionRate, etc.

### Normalization

From "The Art of SQL, Stéphane Faroult, Ed. O'Reilly".

AIM: application of logical rigor.
	
#### 2nd Normal Form (2NF)

This norm consists in two points:
1. Ensure atomicity. Attributes must be atomic. Atomicity allows to respect:
	_ the ability to perform an efficient search
	_ data correctness.
   The idea is to do not put different items in one field. In other words: not make too much general fields. Car example: don't make a general column safety_equipment with ABS and airbags inside, but make two columns (ABS and Airbags).

2. Check dependence on the whole key. If we have a table car that lists all existing cars, we need to create a models table to store information that is common for one model and not repeat this information for each instance of a model inside the car table.
  This is for:
	_ avoiding data redundancy
	_ ensure query performance (because a table with too many columns will be slow to query)
	
#### 3rd Normal Form (3NF)

The most common of norms.

Imposes 2NF + a 3rd point:
	
3. Check attribute independence. A field's value must not be inferable from another field's value.

A common case is when two fields cannot contain values at the same time. When field A has a value, we know field B is NULL. This violates the 3NF.
	
#### Boyce-Codd Normal Form (BCNF)

Usually a database in 3NF is also in BCNF.
It is not BCNF if in one table several columns are all unique identifiers of rows.
	
#### 5th Normal Form (5NF)

Usually a database in 3NF is also in 5NF.

### MySQL

#### Case statement

```mysql
case id
	when 1 then 0
	when 4 then 1
	else id
end
```

### Oracle

PL/SQL (Procedural Language/Structured Query Language): Oracle's extension of SQL.

#### Case statement

In Oracle, there is an equivalent of case statement: `decode()`.

### PostgreSQL

#### Starting server

Start server from shell manually:
```bash
postgres -D /usr/local/var/postgres
```

#### Initializing a repository

`initdb` initializes a database repository (i.e.: the folder where all databases are stored).

#### Creating a new database

Create a new database for the running user:
```bash
createdb dbname
```

#### Deleting a database

```sql
drop databases dbname
```

#### Running SQL commands

For running SQL commands, you need to start the `psql` command:
```bash
psql -h hostname -p port -U username database
```

To run an SQL file:
```bash
psql -h hostname -p port -U username -W passwd -f file.sql database
```

`psql` special commands:

Command         Description
------------    --------------------
\list           List databases.
\du             List users.
\dt             List all tables of a database.
\q              Quit.
\d+ mytable     Get information about a table.

#### Create database

```sql
create database mydb;
```

#### Create user

```sql
create user myuser with encrypted password 'mypass';
grant all privileges on database mydb to myuser;
```

#### Dumping and restoring

For dumping a database into a file:
```bash
pg_dump -C -h host -U user dbname
```

For copying a database:
```bash
pg_dump ... | psql ...
```

To restore a database from a binary file dumped by `pg_dump`.
```bash
pg_restore -d dbname filename
```

#### Copy

 * [COPY](https://www.postgresql.org/docs/9.5/static/sql-copy.html).

Output a CSV file:
```sql
\copy (select * from mytab) To myfile.csv With csv

Output a CSV file with a header:
```sql
\copy (select * from mytab) To myfile.csv With csv header
```

### MS SQL Server

#### Creating a new database

Launch "Management Studio".

Right clik on "Databases", then "New database".

#### Set access rights for a database

Right click on the database, then `Property` --> `Authorisations` --> `Add...`
Select or unselect authorized actions: `Connect`, `Select`, ...

## NoSQL

NoSQL est un buzzword pour désigner une catégorie de système de gestion de base de données (abr. SGBD) destinés à manipuler des bases de données géantes pour des sites web de très grande audience tels que Google, Amazon.com, Facebook ou eBay. Cette catégorie de produits fait le compromis d'abandonner certaines fonctionnalités classiques des SGBD relationnels au profit de la simplicité, la performance et une montée en charge (scalabilité) élevée.

Ex: Project Voldemort, Cassandra Project, Dynomite, HBase, Hypertable, CouchDB et MongoDB.

 * [NoSQL for Games and Gaming](http://info.couchbase.com/rs/302-GJY-034/images/NoSQL_for_Games_and_Gaming.pdf?mkt_tok=eyJpIjoiWldJNVlqZGtPV1JpTVdaaSIsInQiOiJ2T0RjblQ3SkJha0g4Q3VXWHNOejRVWUZiZ1JTUVl3a0Z4VFRDZlcxeUJISisyVUFiWTNlNDVTQzJkWStRY1V1M3dYUlVsUUlPNk90eUg3XC9aNTVFNThHSDYwXC9DY0hqdDFSV0NLc1lZcjVrPSJ9), by Couchbase.

## Triplestore

Made to store RDF (Resource Description Framework) data.

 * [Triplestore](https://en.wikipedia.org/wiki/Triplestore).
 * [Resource Description Framework](https://en.wikipedia.org/wiki/Resource_Description_Framework).
   - [Notation3](https://en.wikipedia.org/wiki/Notation3).

A Triplestore stores information like "Bob is 35".
