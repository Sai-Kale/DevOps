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