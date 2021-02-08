<!-- vimvars: b:markdown_embedded_syntax={'sh':'bash','js':'javascript'} -->
# NoSQL databases

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
```sh
yay -S mongodb
```

Configuration file is `/etc/mongodb.conf`.

Default data store path is `/data/db`. Create it with 'rwx' permissions for user mongodb.

### Interpreter

To start interpreter:
```sh
mongo
mongo -u admin -p admin --authenticationDatabase admin
```

Run javascript on command line:
```sh
mongo -u admin -p admin --authenticationDatabase admin -eval 'db.collection.find()' mydb
```
Run javascript from stdin:
```sh
mongo -u admin -p admin --authenticationDatabase admin <<END_JS
"use strict";
use mydb;
db.collection.find();
END_JS
```

Run quietly:
```sh
mongo -quiet ...
```

Authenticate from inside the interpreter:
```js
db.auth('myuser', 'mypassword');
db.auth('myuser', passwordPrompt());
```

To get help:
```js
db.help()
```

Print version:
```js
db.version()
```

The interpreter can also be run in script mode. Script are written in Javascript, so the syntax is different from the shell.
See [Write Scripts for the mongo Shell](https://docs.mongodb.com/manual/tutorial/write-scripts-for-the-mongo-shell/).
Example of running a Javascript:
```bash
mongo mylocaldb myscript.js
```

Exit:
```js
exit
```

Select database in the interpreter:
```
use admin
```
or in Javascript:
```js
conn = new Mongo();
db = conn.getDB("myDatabase");
```

### Security

 * [Introduction to MongoDB](https://docs.mongodb.com/manual/introduction/).
 * [User Management Methods](https://docs.mongodb.com/manual/reference/method/js-user-management/).
 * [Manage Users and Roles](https://docs.mongodb.com/manual/tutorial/manage-users-and-roles/).
 * [Collection-Level Access Control](https://docs.mongodb.com/manual/core/collection-level-access-control/).
 * [Role-Based Access Control](https://docs.mongodb.com/manual/core/authorization/).
 * [Privilege Actions](https://docs.mongodb.com/manual/reference/privilege-actions/).
 * [db.auth()](https://docs.mongodb.com/manual/reference/method/db.auth/).

Create an admin user:
```js
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
```cfg
security:
 authorization: enabled

setParameter:
  enableLocalhostAuthBypass: false
```

Authenticate when connecting with `mongo`:
```bash
mongo -u admin -p admin --authenticationDatabase "admin"
```
Or from inside `mongo`:
```js
db.auth('myuser', 'mypassword');
```

List users:
```js
db.getUsers()
```

Create read-only user for a database mydb:
```js
use mydb
db.createUser({user:'pierrick',pwd:'cea', roles:[ "read"]})
```
Roles can be defined for other database as well:
```js
use mydb
db.createUser({user:'pierrick',pwd:'cea', roles:[ { role: "read", db: "fake_exhalobase"}]})
```

Create read/write user:
```js
use mydb
db.createUser({user:'pierrick',pwd:'cea', roles:["readWrite"]})
```

#### Roles

 * [Create a User-Defined Role](https://docs.mongodb.com/manual/tutorial/manage-users-and-roles/#create-a-user-defined-role).

Print defined roles:
```js
db.getRoles({showPrivileges:1})
```

Create a role:
```js
db.createRole(
   {
     role: "manageOpRole",
     privileges: [
       { resource: { cluster: true }, actions: [ "killop", "inprog" ] },
       { resource: { db: "", collection: "" }, actions: [ "killCursors" ] }
     ],
     roles: []
   }
)
```

"Except for roles created in the admin database, a role can only include privileges that apply to its database and can only inherit from other roles in its database."

To grant a role (from another database) to a user:
```js
db.grantRolesToUser("<username>", { role: "<role>", db: "<database>" })
```

### Cloning a database

 * [Copy/Clone a Database](https://docs.mongodb.com/manual/reference/program/mongodump/#mongodump-example-copy-clone-database).

In two steps:
```sh
mongodump --archive="mongodump-test-db" --db=test
mongorestore --archive="mongodump-test-db" --nsFrom='test.*' --nsTo='examples.*'
```

In one step:
```sh
mongodump --archive --db=test | mongorestore --archive  --nsFrom='test.*' --nsTo='examples.*'
```

There is an option `--dumpDbUsersAndRoles` for `mongodump` for dumping users and roles, and an option `--restoreDbUsersAndRoles` for `mongorestore` for restoring users and roles. However restoring users does not work when restoring to a different destination database (`--toDb`), it seems only to work when restoring to the same database name.

### Managing databases

Getting statistics about a database:
```js
db.stats()
```

Create a database, or switch to it:
```js
use mydb
```

Print current database:
```js
db
```

List all databases:
```js
show dbs
```
Note: to exist, a database must at least contain one document.

Drop a database:
```js
db.dropDatabase()
```

### Collections

Collections are automatically created when inserting documents. However it is possible to create an empty collection, in order to define particular options, using the following command:
```js
db.createCollection("mycol", { capped : true, autoIndexId : true, size : 6142800, max : 10000 } )
```

To insert a document into a collection:
```js
db.mycol.insert({"name" : "tutorialspoint"})
```

To list all collections of a database:
```js
show collections
```

To list the content of a collection:
```js
db.mycol.find()
```
or
```js
db.mycol.find().pretty()
```
to have JSON printed with new lines.

Search with a filter:
```js
db.mycol.find({myfield:'myvalue'})
```

To drop a collection:
```js
db.mycol.drop()
```

### Datatypes

See  [MongoDB - datatypes](https://www.tutorialspoint.com/mongodb/mongodb_datatype.htm).

### Transferring files

 * [A primer for GridFS using the MongoDB driver](http://mongodb.github.io/node-mongodb-native/api-articles/nodekoarticle2.html).
 * [GridFS](https://docs.mongodb.com/manual/core/gridfs/).
