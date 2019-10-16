NoSQL databases
===============

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

### Interpreter

To start interpreter:
```bash
mongo
```

To get help:
```
db.help()
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

#### Managing databases

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

#### Collections

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
