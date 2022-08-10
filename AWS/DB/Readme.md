# DB

## RDS:

- RDS is managed relational databse.
- These runs on EC2 instance so you must choose an instance type
- Types of RDS AWS Supports 
    - Amazon Aurora
    - MySQL
    - MariaDB
    - Oracle
    - PostgreSQL
- We can scale the DB Instance Vertically.
- For DR We have RDS Deployed as Multi-AZ.
- We can scale out horizontally with mutiple READ replicas.
![alt text](imgs/db1.PNG "")
- Below are differences b/w Multi-AZ and Read Replicas.
- **Multi-AZ cant be cross region where for read replicas can be cross-region**
![alt text](imgs/db2.PNG "")


### RDS Backup and recovery:

#### Automated backups:

- We have automated backup option while spinning up the DB Instance.
- We can configure a backup window. Either we can choose the window or No preference(automatically chosen for us). 
- It creates a snapshot of the DB and will retain as per the retention period mentioned.(35 days max)
- Restore can be to any point in time during the retention period.
![alt text](imgs/db3.PNG "")

#### Manual backups amazon RDS:

- Manual backups are also using the snapshots.
- However these do not expire.
- Maintence may require taking the DB offline.
![alt text](imgs/db4.PNG "")
![alt text](imgs/db5.PNG "")

### RDS Security:

- It can have a public IP but generally its internal and we dont assign a public IP.
- Encryption at rest and transit. Can be enabled only when creation.
- We can have SG for RDS instance and allow traffic only from App server on port 3306
- We have SSL to add encryption in transit.(AES 256)
![alt text](imgs/db6.PNG "")


![alt text](imgs/db7.PNG "")
![alt text](imgs/db8.PNG "")
![alt text](imgs/db9.PNG "")


## AWS Aurora DB:

-  Its AWS Properity DB.
- Core Features of Aurora.
- it only provides MySQL and PostgreSQL.

![alt text](imgs/db10.PNG "")
![alt text](imgs/db11.PNG "")

### Aurora Automated Deployment Options:

- Auora Fault Tolerance and aurora replicas
- Aurora has 6 copies of data within a region. 
- Writes will happen across the AZ to keep them in SYNC.
- We can scale out the read request across the AZ
- we can promote any Aurora replica to primary. Using the tier we can select  which should be promoted first.
![alt text](imgs/db12.PNG "")

#### Aurora Cross-region:
- Aurora has cross-region replicas with the Asynchronous repllication. With 6 copies of data with in each region.
![alt text](imgs/db13.PNG "")
#### Aurora Global DB:
- We also have the Aurora Global DB. with writes in the Primary Region and writes in the secondary region.

![alt text](imgs/db14.PNG "")
#### Aurora Multi Master:
- Multi-Master with all of them supporting the read/writes. We cannot have cross-region.
- Can restart one of them without impacting the others.
![alt text](imgs/db15.PNG "")
#### Aurora Serverless:

- Aurora Serverless which have DB instances sitting before them have the router fleet which seemlessly scale the Aurora DB.
![alt text](imgs/db16.PNG "")
![alt text](imgs/db17.PNG "")

### Amazon Anti Patterns and Alternatives:

- If we want to control the underlying software and OS patching dont use the RDS.
- We must have to maintain the upgrades and scaling and patching in this case.
![alt text](imgs/db18.PNG "")
![alt text](imgs/db19.PNG "")

#### Scenario where the EC2 DB is required:
![alt text](imgs/db20.PNG "")

## Amazon ElasticCache:

- ElasticCache is an In-memory DB that helps in providing fast access to data.
- Fully managed implementations of Redis and Memcached.
- Its a key/value store. In-memory DB high performance and low latency.
![alt text](imgs/db21.PNG "")
- Can be put in-front of DB RDS and DynamoDB.
- Writes still goes to the DB. THen when you read the data its cached in teh ElasticCache.
![alt text](imgs/db22.PNG "")
![alt text](imgs/db23.PNG "")

- **Elastic Cache is often used for storing Session State**

### Scalability with Elastic cache:

![alt text](imgs/db24.PNG "")
![alt text](imgs/db26.PNG "")
![alt text](imgs/db27.PNG "")
![alt text](imgs/db28.PNG "")

## Dynamo DB:

- Fully managed NoSQL DB(have flexible schema). Key/Value store and Document store.
- Fully serverless and Non-relational,key-value type of DB.
- Push button scaling.
![alt text](imgs/db29.PNG "")
- Its made up of tables and items(which has attributes)
- TTL let you define when items in a table expire.
![alt text](imgs/db30.PNG "")

- DynamoDb has parition key + sort key created for the primary key which will have attributes.
![alt text](imgs/db31.PNG "")

![alt text](imgs/db32.PNG "")

#### Dynamo DB Capcity Modes and RCUs/WCUs:

- We have two capacity modes on-demand and provisioned(where we specify the RCS/WCU)
![alt text](imgs/db33.PNG "")
![alt text](imgs/db34.PNG "")
![alt text](imgs/db35.PNG "")


### Dynamo DB Streams:

- We have an app that performs some action on DynamoDB. Every time a action is taken a record is written in Dynamo DB stream. Each time a record is written to the DynamoDB stream a lambda function is triggered. The lambda can do the appropriate actions.
![alt text](imgs/db36.PNG "")
- We can captrure the time-ordered seq of item-level modifications which stores it for 24 hrs. We can configure what can be written to the stream.
![alt text](imgs/db37.PNG "")


### Dynamo DB DAX:

- DAX is an accelerator for the sub-millisecond latency for the DynamoDB.
- As Dynamo DB is public service we can configure a DAX within the VPC which has the cache stored in it.
- Make sure we give the required perms in the SG.
![alt text](imgs/db38.PNG "")
- DAX is only utilized for READS.
![alt text](imgs/db39.PNG "")

#### DAX vs Elastic Cache:
![alt text](imgs/db40.PNG "")

### Dynamo DB Global Tables:

- It is where we have mutiple Regions for Dynamo DB where we can write/read.
- Replication is Asynchronous.
 ![alt text](imgs/db41.PNG "")
- This is requried in scenarios where we need ready to failover solution that can take Writes and HA.
- We can write both the regions so its a multi-region multi-master solution.

## Architectural Patterns:

![alt text](imgs/db42.PNG "")
![alt text](imgs/db43.PNG "")
![alt text](imgs/db44.PNG "")
![alt text](imgs/db45.PNG "")
![alt text](imgs/db46.PNG "")
![alt text](imgs/db47.PNG "")

###### LABS:

- Create a Dynamo DB
    - 
