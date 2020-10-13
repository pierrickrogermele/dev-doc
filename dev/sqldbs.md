Relational databases
====================

 * [Introduction to Relational Database Design](http://www.edm2.com/0612/msql7.html).
 * [SQL Tutorial](https://www.w3schools.com/sql/default.asp).
 * [SQL 92](http://www.contrib.andrew.cmu.edu/~shadow/sql/sql1992.txt).

## Design

### Database schema symbols

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

## Lookup table

A lookup table = a validation table.

It's a table where values (often string values) that are constant or quasi-constant during the lifetime of the database are stored.

Example 1: a table for states that store the two letter state code, and the state name.

Example 2: a categories table that store a category ID and the category name.

## Self referencing table

A self referencing table is one which has a foreign key that uses its own primary key.

Example 1:
A table members with fields: MemberID, MbrFirstName, MbrLastName, SponsorID, etc. Where the SponsorID is a foreign key that uses MemberID.

Example 2 (in a many-to-many relationship):
A table parts with fields: PartID, PartName, etc.
And a table PartComponents with fields: PartID, ComponentID. Where PartID and ComponentID are foreign keys that use parts.PartID.

## Subset table

A subset table is a table that adds information to a main table.

Example:
A table employee with fields EmplID, EmpFirstName, EmpLastName, HomePhone, etc.
With a table compensation with fields EmplID, HourlyRate, CommissionRate, etc.

## Normalization

From "The Art of SQL, Stéphane Faroult, Ed. O'Reilly".

AIM: application of logical rigor.
	
### 2nd Normal Form (2NF)

This norm consists in two points:
1. Ensure atomicity. Attributes must be atomic. Atomicity allows to respect:
	_ the ability to perform an efficient search
	_ data correctness.
   The idea is to do not put different items in one field. In other words: not make too much general fields. Car example: don't make a general column safety_equipment with ABS and airbags inside, but make two columns (ABS and Airbags).

2. Check dependence on the whole key. If we have a table car that lists all existing cars, we need to create a models table to store information that is common for one model and not repeat this information for each instance of a model inside the car table.
  This is for:
	_ avoiding data redundancy
	_ ensure query performance (because a table with too many columns will be slow to query)
	
### 3rd Normal Form (3NF)

The most common of norms.

Imposes 2NF + a 3rd point:
	
3. Check attribute independence. A field's value must not be inferable from another field's value.

A common case is when two fields cannot contain values at the same time. When field A has a value, we know field B is NULL. This violates the 3NF.
	
### Boyce-Codd Normal Form (BCNF)

Usually a database in 3NF is also in BCNF.
It is not BCNF if in one table several columns are all unique identifiers of rows.
	
### 5th Normal Form (5NF)

Usually a database in 3NF is also in 5NF.

## Partitioning

From "The Art of SQL", p. 115

Large tables and indices can be partitioned. This leads to more scalable architectures, by allowing increased concurrency and parallelism.

### Round-robin partitioning

The tables have one or more partitions assigned to it (on different disks).
Each new insertion is done on one of the partitions, in a round-robin fashion. So the data is scattered arbitrarily.

### Data-driven partitioning

The values in one or more columns determine the partition into which insert the row.

 1. The partitioned view solution
For instance a table figures is spliced into 12 tables corresponding to the months (jan_figures, feb_figures, ..., dec_figures).
Then the tables are reunited inside a single figures table ("partitioned view", or "merge table" (MySQL)).

Drawbacks:
 - The DBMS is not informed of the logical relationship which links the different partition tables.
 - We have no way to enforce uniqueness properly across tables, except using a check constraint on each table in order to check the month.
 - We have to build dynamically the insert statements.
 - When querying for the past 30 days, we have most often to query two tables. If the column that rules the placement of rows is part of the definition of the partitioned view, then the DBMS will be able to treat a query on the view and limit the scope to the proper subset of tables. If not, then we will have to build the query dynamically or run a global query on the view.

 2. True data-driven partitioning
One or several columns are defined as "partition key".

   a. Hash-partitioning: an hash algorithm is run on the partition key. So it does not take into account the distribution of data values. However it ensures very fast access to rows.

   b. Range-partitioning: gather data into groups according to continuous data ranges. Ideally suited for dealing with historical data.	An "else" partition is set up for catching everything that might slip through the net.

   c. List-partitioning: this is a tailor-made (manual) solution. For each partition, a set of values of the partition key for this partition is defined manually.

Sub-partitions (partitions inside a partition) are possible, and can involve several types of partitioning (e.g.: hash-partitions within a range-partition).

Data-driven partitioning is not a panacea for resolving concurrency problems.
For instance, if we partition a table by weeks, and so have 52 partitions. Then during each week, everybody will insert in the same table. On the other hand, if we partition geographically, the inserts should be spread over all partitions.
Thus partitioning is useful to speed up either retrieval or insertion, but not both at the same time, or at least not all type of retrievals and insertions.

Partitioning is not always a solution. For instance in a database of purchase orders, when one big customer represent 80% of the sells, it's no use to partition according to the customer ID.
In consequence, partitioning is well suited when data is uniformly spread in respect to the partitioning key.

Avoid partitioning on values which may change in future, since an "update" of a partition key value inside a partitioned database means a "delete" + an "insert", which are costly. However exceptions can exist, and having a partition key which can be updated isn't necessarily bad (see the process queue example with partition key on type or status, inside "The Art of SQL", p. 121).

## Standard SQL

 * [SQL Tutorial](https://www.tutorialspoint.com/sql/index.htm).

### Comments

```sql
-- a comment on one line
```

```sql
/* a comment
   on several
   lines */
```

### Data types

 * [Standard SQL Data Types](https://cloud.google.com/bigquery/docs/reference/standard-sql/data-types).

Type        | Description
----------- | -------------------------
float64     | 8 bytes float.
numeric     | 16 bytes float.
text        |
int64       |
bool        |
string      | variable length unicode character string
date        |
varchar(255)| 

### List tables

```sql
select table_name from information_schema.tables where table_catalog='ratppcc' and table_schema='public';
```

### create table

Create a table with an auto-incremented column:
```sql
create table mytable (
	   id int not null auto_increment);
```

Create a table with a primary key:
```sql
create table mytable (
	   id int not null,
	   primary key(id));
```

Create a table with a reference to a primary key of another table:
```sql
create table mytable (
	   local_id int not null,
	   other_id int not null,
	   foreign key(other_id) references other_table(id));
```

### drop table

rop a table:
```sql
drop table if exists mytable;
```

Show tables of current database:
```sql
show tables;
```

### alter table

### insert into

Insert into a table:
```sql
insert into mytable (col1, col2, col3, ...) values (val1, val2, val3, ...);
```

### index

Create an index:
```sql
create index indexname on tablename(columnname);
```

Show all indices of a table:
```sql
show index from tablename;
```

Remove an index:
```sql
drop index indexname on tablename;
```

Indices implementation: usually they are implemented as tree structures to allow fast insertion, update and deletion.

Use of a function when accessing an index must be prohibited. For instance, writing the following where clause:
```sql
where f(indexed_column) = 'some value'
```
will disable the indexed search since the function f() has no reason to respect the sorting order of `indexed_column`. The RDBMS will thus execute a sequential data scan.
A classical example is when looking for a substring inside an index:
```sql
where substr(name, 3, 1) = 'R'
```
Another classical example is when looking for a date. Suppose you have an indexed column `date_entered` which contains a date+time value, and you want to retrieve all rows of a particular day (whatever is the time). If you run something like this:
```sql
where date_entered = to_date('18-JUN-1815', 'DD-MON-YYYY')
```
you would only retrieve the rows whose date is exactly the 18th June 1815 at 00:00.
So you would tempted to use the trunc() function on the date column in order to get rid of the time and write:
```sql
where trunc(date_entered) = to_date('18-JUN-1815', 'DD-MON-YYYY')
```
Of course this query will work, and thus correct the previous mistake, but you will also go without the index on `date_entered`.
It would be better to use inequalities:
```sql
where date_entered >= to_date('18-JUN-1815', 'DD-MON-YYYY') and date_entered < to_date('19-JUN-1815', 'DD-MON-YYYY')
```

Attention with implicit conversions by RDBMS. For instance Oracle will convert the column to integer implicitly in order to execute the following where clause:
```sql
where account_number = 12345
```
The implicit conversion is done on the column because we would like the comparison '0000012345' = 12345 to work, and also because we would like to detected checking of the column value (if the conversion of a value in the column is not possible, it will raise an error). Such implicit conversions prevent the use of indexes.

#### Key generation

How to generate a new unique key value ?

See "The Art of SQL", p. 70.

 0. Use unique identifier if already available instead of generating new key value, which has moreover no link whatsoever to the data.

 1. Looking for the greatest numerical value and incrementing by one, can be subject to issues in a concurrent environment.

 2. Using a "next value" that has to be locked each time we need to get a new key (and increase the "next value") serializes and slows down accesses.

 3. Using a system-generated key (auto-increment key) in a concurrent environment, leads to generate numbers that are in close proximity to each other. Consequently all the processes, when inserting these new key values, will converge on the same index page and RDBMS will have to serialize.

 4. Some RDBMS, like Oracle, propose the use of REVERSE INDEXES, i.e. indexes in which the sequence of bits are inversed transparently. This solves the issue of point 3, since integer or string keys won't be stored in natural order inside the tree (close numbers won't be stored next to each other). However, using a string reversed index, will prohibit us of using a search syntax like:
```sql
where name like 'M%'
```
since the RDBMS won't be able to use the index to optimize this request. This is because the tree is no more constructed using an alphabetical comparison function. Same issue arises for timestamp indexes.

 5. Some RDBMS propose the use of hash indexes. A hash index uses a hash function to transform its value into a meaningless randomly distributed numeric key. Two close values will be transformed into two distant values, thus avoiding collisions. This doesn't prevent two values to be transformed into the same hash value, but reduces drastically such a probability. However hash index prohibits range searches.

#### Index and order of filtering conditions

From "The Art of SQL", p.91:
```sql
select distinct c.custname
from customers c
	join orders o
		on o.custid = c.custid
	join orderdetail od
		on od.ordid = o.ordid
	join articles a
		on a.artid = od.artid
where c.city = 'GOTHAM'
	and a.artname = 'BATMOBILE'
	and o.ordered >= somefunc;
```
STEPS followed by the RDBMS
 1. Look for rows in customers table where city is GOTHAM.
 2. Search the orders table for rows belonging to customer custid. Which means that custid column should be indexed in orders table.
 3. A clever optimizer will see the condition on order date in where clause, and will filter lines from table orders before performing the join on custid. A less clever optimizer won't see the condition. To help this less clever optimizer, we can move the condition from the where clause to the join clause:
```sql
	join orders o
		on o.custid = c.custid
		and o.ordered >= somefunc
```
 4. If the primary key of orderdetail table is (ordid, artid), then an index is available on ordid and the RDBMS can make use of that. If not the primary key is (artid, ordid) then no index is present on ordid, and the join will be slow. A solution is to provide a separate indexing of ordid column.

#### IOT and heap structure --

By default tables are organized in heap structures.

In Oracle, one can specify a table to be an IOT (Index-Organized Table). This means that all of the data of the table will be stored into an index built on the primary key. This saves storage and time, since data is stored with the index.
In a IOT one must be careful about insertion. If the table holds few columns then insert will be fast, otherwise it will be slower than in regular tables organized in heap structures.

### Select

Limit size of selection:
```sql
select * from mytable limit 100;
```

Count all rows of a request:
```sql
select count(*) from mytable;
```

Select specific columns:
```sql
select mycol from mytable;
```

If a column contains special characters like `.`, use backsticks around column name:
```sql
select `my.col` from mytable;
```
The backsticks can also be used in join and where clauses:
```sql
select `my.col` from mytable join table2 on table2.id = mytable.`my.id.col` where table2.`my.other.col` = `my.col`;
```

### Join

#### Old join syntax

This syntax is equivalent to the explicit "inner join" notation.

```sql
select distinct c.custname
from customers c,
	 orders o,
	 orderdetail od,
	 articales a
where c.city = 'GOTHAM'
	and c.custid = o.custid
	and o.ordid = od.ordid
	and od.artid = a.artid
	and a.artname = 'BATMOBILE'
	and o.ordered >= somefunc;
```

#### Inner join

```sql
select distinct c.custname
from customers c
inner join orders o on c.custid = o.custid
inner join orderdetail od on o.ordid = od.ordid
inner join articales a on od.artid = a.artid
where c.city = 'GOTHAM'
	and a.artname = 'BATMOBILE'
	and o.ordered >= somefunc;
```

### Boolean

```sql
select * from mytab where mycol = TRUE;
```

### Pattern matching

 * [PostgreSQL pattern matching](http://www.postgresql.org/docs/8.3/static/functions-matching.html).

```sql
select * from mytab where mycolumn like 'n%';
```

### Strings

Put in uppercase/lowercase:
```sql
select * from mytab where upper(mycolumn) = 'ZAP';
```

### Where

Testing if equal:
```sql
select * from mytab where mycol = 2;
```

Testing if different:
```sql
select * from mytab where mycol != 'zap';
```

### Distinct

`distinct` keyword asks for result filtering, by removing duplicated rows.
From "The Art of SQL", p.91:
```sql
select distinct c.custname
from customers c
	join orders o
		on o.custid = c.custid
	join orderdetail od
		on od.ordid = o.ordid
	join articles a
		on a.artid = od.artid
where c.city = 'GOTHAM'
	and a.artname = 'BATMOBILE'
	and o.ordered >= somefunc;
```

This query could return a "wrong" or unexpected result, by removing customer homonyms.
See `exists` and `in` for better solutions.

### Exists

From "The Art of SQL", p.93:
```sql
select c.custname
from customers c
where c.city = 'GOTHAM'
	and exists (select null
	            from orders o,
	            	orderdetail od,
					articles a
				where a.artname = 'BATMOBILE'
					and a.artid = od.artid
					and od.ordid = o.ordid
					and o.custid = c.custid -- <-- correlated subquery, the inner select makes reference to the outer select.
					and o.ordered >= somefunc);
```
The use of the exists keyword in our case, creates a link between the outer query and the inner query. If executed as it is, we would first loop on all customers of GOTHAM city and for each of them execute the inner query in order to know if he/she has bought a batmobile recently. A clever optimizer would/might rewrite the query so it performs better. But a less clever one won't.
Note that it is important to have the custid column of the orders table indexed.

See `in` for a solution with an uncorrelated subquery.

### Combined updates

It is often more efficient to run a single update command for multiple fields, even we reset some fields to the same values, than to run multiple updates, one for each field.
Example with the use of the case statement (from "The Art of SQL", p. 44):
```sql
update tbo_invoice_extractor
	set pga_status = (case pga_status
		                when 1 then 0
		                when 3 then 0
		                else pga_status
		              end),
		rd_status  = (case rd_status
		                when 1 then 0
						when 3 then 0
						else rd_status
		              end)
	where (pga_status in (1,3) or rd_status in (1,3)) and inv_type = 0;
```

### In

Check if a value is in a list:
```sql
select * from mytab where myfield in ('zap', 'hop', 'plouf');
```

Check if a value isn't in a list:
```sql
select * from mytab where myfield not in ('zap', 'hop', 'plouf');
```

From "The Art of SQL", p.94:
```sql
select c.custname
from customers
where city = 'GOTHAM'
	and custid in
		(select o.custid
	     from orders o,
	   	      orderdetail od,
		      articles a
		      where a.artname = 'BATMOBILE'
		      and a.artid = od.artid
		      and od.ordid = o.ordid
		      and o.ordered >= somefunc);
```
The inner query doesn't depend on the outer query, it is an uncorrelated subquery and so will be executed only once.

The outer query performs a test of existence of a custid inside the result list of custids of the inner query. In case the list of custids is very long, we could use the same solution (i.e.: use of the in keyword) inside the inner query:
```sql
select c.custname
from customers
where city = 'GOTHAM'
	and custid in
		(select o.custid
	     from orders
	     where ordered >= somefunc
	     	and ordid in (select od.ordid
						  from orderdetail od,
						       articles a
		                  where a.artname = 'BATMOBILE'
		                  and a.artid = od.artid));
```

## SQLite

 * [Datatypes In SQLite Version 3](https://www.sqlite.org/datatype3.html).

## MySQL

 * [9.3.1 How MySQL Uses Indexes](http://dev.mysql.com/doc/refman/5.7/en/mysql-indexes.html).

### Install & run

Installing on macOS:
```bash
brew install mysql
```

Running mysql:
```bash
mysql.server start
```

Installing MariaDB on Archlinux:
```bash
sudo pacman -S mariadb
sudo mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
sudo systemctl enable --now mariadb
```

### Command line

Enter a root session:
```bash
mysql -u root
```

Change root password:
```bash
mysqladmin -u root password NEWPASSWORD
```

Check that the server is running:
```bash
mysqladmin version
mysqladmin variables
```

List databases:
```bash
mysqlshow -uroot
```

List containt of a database:
```bash
mysqlshow -uroot mydatabase
```

To run a command or start a SQL shell:
```bash
mysql [--user=<user_name> --password=<password>] [-e "<SQL command>"] <database>
```

Connect to mysql shell:
```bash
mysql -h host -u user -p=password
```
or if you want mysql to prompt for password
```bash
mysql -h host -u user -p
```

Run an SQL command:
```bash
mysql -e "SELECT Host,Db,User FROM db" mysql
```

Run an SQL script file:
```bash
mysql db_name < text_file
```

### Shell commands

Quit shell:
```mysql
quit
```

### Security

To get a list of users:
```mysql
select user, host, password from mysql.user;
```

Add a user account:
```mysql
create user myuser identified by 'mypassword';
```

Remove user account:
```mysql
drop user myuser
```

Grant access:
```mysql
grant all privileges on mydb.* to 'myuser'@'localhost' identified by 'mypassword';
```

Grant a user the right to create databases matching a pattern:
```mysql
grant all privileges on `mydbprefix\_%` . * to 'myuser'@'localhost';
```

Set password:
```mysql
set password for 'myuser'@'localhost' = password(''); -- no password
set password for 'myuser'@'localhost' = password('mypassword');
```

To check privileges, first login:
```bash
mysql -y myuser
```
Then run:
```mysql
show grants;
```

### Creating and using a database

Create a database:
```mysql
create database mydb;
```

Print list of databases:
```mysql
show databases;
```

Use a database:
```mysql
use mydb;
```

Recreate a database and use it:
```mysql
drop database if exists mydb;
create database mydb character set utf8;
use mydb;
```

### Tables

List table:
```mysql
show tables;
```

Show columns of a table:
```mysql
show columns from mytable;
```

View the execution plan of the database engine:
```mysql
explain myquery;
```

Optimize a table:
```mysql
optimize table mytable;
```

Analyze a table:
```mysql
analyze table mytable;
```

### Import/export CSV file

 * [Import CSV File Into MySQL Table](http://www.mysqltutorial.org/import-csv-file-mysql-table/).

### Strings

By default MySQL is installed with latin1 encoding.

To set the encoding for a whole database:
```mysql
create database foreign_sales character set utf8;
```

To set the encoding of a field of a table:
```mysql
create table my_table
(
	some_field  varchar(20) character set utf8
);
```

When connecting to a database, the following command must be run before issuing commands (insert, select or update) with UTF8 characters:
```mysql
set names utf8;
```

### Case statement

```mysql
case id
	when 1 then 0
	when 4 then 1
	else id
end
```

## Oracle

PL/SQL (Procedural Language/Structured Query Language): Oracle's extension of SQL.

### Case statement

In Oracle, there is an equivalent of case statement: `decode()`.

## PostgreSQL

### Installation

 * [PostgreSQL](https://wiki.archlinux.org/index.php/PostgreSQL#Installation).

Before running commands with postgresql, one must first become the postgres user:
```bash
sudo -iu postgres
```

### Starting server

Start server from shell manually:
```bash
postgres -D /usr/local/var/postgres
```

or start service with systemd:
```bash
systemctl start postgresql
```

### Interpreter

```bash
psql
```

Connect onto specific database:
```bash
psql -h hostname -p port -U username -W database
```

Run as `postgres` user:
```bash
sudo -u postgres psql
```

### Initializing a repository

`initdb` initializes a database repository (i.e.: the folder where all databases are stored).

### Creating a new database

Create a new database for the running user:
```bash
createdb dbname
```

From SQL:
```sql
create database mydb;
```

### Selecting a database

```
\connect mydb
\c mydb
```

### Deleting a database

```sql
drop database dbname;
```

### Running SQL commands

For running SQL commands, you need to start the `psql` command:
```bash
psql -h hostname -p port -U username database
```

To run an SQL file:
```bash
psql -h hostname -p port -U username -W -f file.sql database
```

`psql` special commands:

Command         Description
------------    --------------------
\list           List databases.
\du             List users.
\dt             List all tables of a database.
\q              Quit.
\d+ mytable     Get information about a table.

### Users

Create user
```sql
create user myuser with encrypted password 'mypass';
grant all privileges on database mydb to myuser;
```

Reset user's password:
```sql
ALTER USER ratpuser WITH PASSWORD 'ratp';
```

### Dumping and restoring

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

### Table

Show table info:
```
\d mytable
```

### Copy

 * [COPY](https://www.postgresql.org/docs/9.5/static/sql-copy.html).

Output a CSV file:
```sql
\copy (select * from mytab) To myfile.csv With csv

Output a CSV file with a header:
```sql
\copy (select * from mytab) To myfile.csv With csv header
```

### Data types

 * [Chapter 8. Data Types](https://www.postgresql.org/docs/9.5/datatype.html).

Type                     | Description
------------------------ | ------------------
timestamp                | 
timestamp with time zone | 
text                     | variable unlimited length

## MS SQL Server

### Creating a new database

Launch "Management Studio".

Right clik on "Databases", then "New database".

### Set access rights for a database

Right click on the database, then `Property` --> `Authorisations` --> `Add...`
Select or unselect authorized actions: `Connect`, `Select`, ...

