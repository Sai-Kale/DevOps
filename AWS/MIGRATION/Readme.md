# Migration Services


## AWS Migration Tools Overview:

![alt text](imgs/m1.PNG "")

### AWS Application Discovery Services:

- First phase of migration to disccoveer about the on-prem service.
- It collects data about servers in the on-prem DC.
- We can use this to connect to the On prem DC via VPN or Direct Connect or Internet.


![alt text](imgs/m2.PNG "")
- We might have a VM ware on on-prem then we can use a agentless discovery and establish a connection to AWS Application Discovery Service. THat populates the data.

- If we running on Hyper-V we need to install a agent that installs on windows/ linux instance that pushed the data to the AWS ADS.
- Then we can query this data that is being stored in S3 using the amazon athena to get  insights.
- Discovery Connector is a Agentless (VmWare) and Discovery Agent is where we need to install Agent.(Hyper-V/physical)

![alt text](imgs/m3.PNG "")

### AWS DB Migration Service(DMS):

- Used to migrate the the on-prem DB to the AWS.
- It gives a lot options how we can migrate.
- if we want to convert the schema we need to use the schema conversion tool.

![alt text](imgs/m4.PNG "")
![alt text](imgs/m5.PNG "")
![alt text](imgs/m6.PNG "")

### AWS Server Migration Service:

- Its used to migrate the servers as the name suggests.
- its migrates VMWare, Hyper-V and Azure VM to EC2.
![alt text](imgs/m7.PNG "")
- Once the AWS SMS Connector is installed on the on-prem servers it will create an AMI.
- From SMS we can see CloudWatch Events and can perfrom the Lambda actions on that.
- We can alos create a CFT from SMS and CloudFormation can lauch the EC2 instances.
![alt text](imgs/m8.PNG "")

### AWS Data Sync:

- If we have an NAS/File Server(NFS or SMB) then we can install DataSync agent that connects to software sys. Then its replicated on to the S3 or FSx for windows or EFS for Linux.

![alt text](imgs/m9.PNG "")

- Data Sync has various destinations namely S3, FSx, EFS.
- We can use a AWS Snow Cone device.

### AWS SNow Family:

- These are physical volumes of storage.
- Very much useful of we have limited bandwidth but want to transfer data verry quickly to AWS.

![alt text](imgs/m10.PNG "")
![alt text](imgs/m111.PNG "")

# Architecure Patterns:

![alt text](imgs/m11.PNG "")
![alt text](imgs/m12.PNG "")
