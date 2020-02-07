NoSQL databases
===============

## RRDtool

 * [RRDtool](https://en.wikipedia.org/wiki/RRDtool).

## Triplestore

Made to store RDF (Resource Description Framework) data.

 * [Triplestore](https://en.wikipedia.org/wiki/Triplestore).
 * [Resource Description Framework](https://en.wikipedia.org/wiki/Resource_Description_Framework).
   - [Notation3](https://en.wikipedia.org/wiki/Notation3).

A Triplestore stores information like "Bob is 35".

## MongoDB

 * [MongoDB Tutorial](https://www.tutorialspoint.com/mongodb/).
 * [MongoDB Tutorials](https://docs.mongodb.com/manual/tutorial/).

RDBMS       | MongoDB
----------- | -------
Database    | Database
Table       | Collection
Tuple/Row   | Document
column      | Field
Primary Key | Primary Key (Default key `_id` provided by MongoDB itself)

 * Documents are written in JSON.
 * No concept of relationship between collections.
 * Data is stored and transferred using [BSON](https://fr.wikipedia.org/wiki/BSON) format.

### Installation

On ArchLinux:
```
yay -S mongodb
```

Configuration file is `/etc/mongodb.conf`.

Default data store path is `/data/db`. Create it with 'rwx' permissions for user mongodb.

### Interpreter

To start interpreter:
```bash
mongo
mongo -u admin -p admin --authenticationDatabase "admin"
```

To get help:
```
db.help()
```

Print version:
```
db.version()
```

The interpreter can also be run in script mode. Script are written in Javascript, so the syntax is different from the shell.
See [Write Scripts for the mongo Shell](https://docs.mongodb.com/manual/tutorial/write-scripts-for-the-mongo-shell/).
Example of running a Javascript:
```bash
mongo mylocaldb muyscript.js
```

Exit:
```
exit
```

Select database in the interpreter:
```
use admin
```
or in Javascript:
```javascript
conn = new Mongo();
db = conn.getDB("myDatabase");
```

### Security

 * [User Management Methods](https://docs.mongodb.com/manual/reference/method/js-user-management/).
 * [Collection-Level Access Control](https://docs.mongodb.com/manual/core/collection-level-access-control/).
 * [Role-Based Access Control](https://docs.mongodb.com/manual/core/authorization/).
 * [Privilege Actions](https://docs.mongodb.com/manual/reference/privilege-actions/).

Create an admin user:
```
use admin
db.createUser(
	{
		user: "myUserAdmin",
		pwd: passwordPrompt(), // or cleartext password
		roles: [{ role: 'root', db: 'admin' }, { role: "userAdminAnyDatabase", db: "admin" }, "readWriteAnyDatabase" ]
	}
)
```

Inside the configuration file `/etc/mongodb.conf` set:
```
security:
 authorization: enabled

setParameter:
  enableLocalhostAuthBypass: false
```

When connecting with `mongo`:
```bash
mongo -u admin -p admin --authenticationDatabase "admin"
```

List users:
```
db.getUsers()
```

Create read-only user for a database mydb:
```
use mydb
db.createUser({user:'pierrick',pwd:'cea', roles:[ "read"]})
```
Roles can be defined for other database as well:
```
use mydb
db.createUser({user:'pierrick',pwd:'cea', roles:[ { role: "read", db: "fake_exhalobase"}]})
```

Create read/write user:
```
use mydb
db.createUser({user:'pierrick',pwd:'cea', roles:["readWrite"]})
```

### Managing databases

Getting statistics about a database:
```
db.stats()
```

Create a database, or switch to it:
```
use mydb
```

Print current database:
```
db
```

List all databases:
```
show dbs
```
Note: to exist, a database must at least contain one document.

Drop a database:
```
db.dropDatabase()
```

### Collections

Collections are automatically created when inserting documents. However it is possible to create an empty collection, in order to define particular options, using the following command:
```
db.createCollection("mycol", { capped : true, autoIndexId : true, size : 6142800, max : 10000 } )
```

To insert a document into a collection:
```
db.mycol.insert({"name" : "tutorialspoint"})
```

To list all collections of a database:
```
show collections
```

To list the content of a collection:
```
db.mycol.find()
```
or
```
db.mycol.find().pretty()
```
to have JSON printed with new lines.

To drop a collection:
```
db.mycol.drop()
```

### Datatypes

See  [MongoDB - datatypes](https://www.tutorialspoint.com/mongodb/mongodb_datatype.htm).

### Transferring files

 * [A primer for GridFS using the MongoDB driver](http://mongodb.github.io/node-mongodb-native/api-articles/nodekoarticle2.html).
 * [GridFS](https://docs.mongodb.com/manual/core/gridfs/).
