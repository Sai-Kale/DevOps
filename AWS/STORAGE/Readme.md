# AWS Storage Services

## EBS Deployment and Volume types:

- We can attach an instance with mutiple EBS volumes
- Both EBS volume and instacne should be n the same availability zone.
- we can also attach mutiple instaces with the same EBS volume known as EBS multi attach (currently only available for EC2 nitro instances). But that can only within the same AZ
![alt text](imgs/st1.PNG "")


- EBS SSD backed volumes:
    - we have two type gp and io (within them we might have different capacities)
    - gp is general purpose and io is for Input Output optimized.
![alt text](imgs/ecst2.PNG "")

- EBS HDD-Backed Volumes:
    - generally used for data ware housing, where we need lower cost and infrequently accesses data like log archiving etc.,.
![alt text](imgs/st3.PNG "")



- We have max IOPS depending upon the size of the EBS volume.
- In some io type we can choose the IOPS and in gp3 we can also choose but not in gp2.


## EBS Copying, ecnryption and Sharing:

- We have EBS volume attached to an EC2 in same AZ.
- We then createa snapshot of EBS. that is point of time backup of EBS volume.
- then we can restore that snapshot in a different AZ. 
- We can also create an AMI from that volume. so that when we spin up new EC2 instance its attached to the snapshot volume.


![alt text](imgs/st4.PNG "")
![alt text](imgs/st5.PNG "")

- **Encryption**:
    - volume is encrypted , then its retained in the snapshot in same AZ.
    - we can copy an unencrypted snapshot and encrypt in new region.
    - we can create an encrypted volume from an unencrypted snapshot.
    - we cannot create a encrypted AMI from an unencrypted snapshot. we can share the AMI with other accounts and make it public.
    - we can copy the snapshot and change the encryption key and region as well.
    - IF we want to create a encrypted AMI from an encrypted snapshot we cannot use AWS KMS key. we need to use our own custom key to share it with other accounts. Cant share that publicly.
    -  we can copy the an encrypted AMI and change the encryption key and region.
    - we can take an encrypted AMI and spin EC2 instacne with a different encryption key.
    - we can take an unencrypted AMI and spin EC2 instacne and enable encryption.
    - we can create an encrypted volume from an encrypted snapshot.
![alt text](imgs/st6.PNG "")
![alt text](imgs/st7.PNG "")


## EBS vs Instance Store:

### Instance Store:
- Instance store is something that we get with the root where the OS is installed and its very fast.
- they are physically attached to the host computer where we run our isntances.
- its epehermal i.e when you reboot all the content is lost.
- they are great for temp storage which change frequently and can be okay to lose.
- its used for performance intense and okay to lost the data.
- Instance store cannot be detached/reattached.
![alt text](imgs/st8.PNG "")


![alt text](imgs/st10.PNG "")

## AWS EFS(Elastic File System):

- EFS is a Network Attached Storage. it works for linux only.
- We attach to NAS server via a NIC of the server. The NAS(Network Attached Storage) Server shares file systems over the network
- Linux uses NFS protocol to connect to these mount drives where as SMP for windows.
- We can connect thousansds of isntacnes to the EFS over different regions and also on-prem infra as well.
- we acn create automatic backups and lifecycle mgmt.
- We can also choose the performance and thorughput as well.
- We can also enable ecryption.

![alt text](imgs/st11.PNG "")

- if the EFS is in a different VPC in a different we have to make sure that there is VPC peering connection to the VPC where the EFS is present.
- Also we have to mount using the IP address of the mount target not DNS.

![alt text](imgs/st12.PNG "")


## AWS S3:

### S3 Refresh:

- Its a object based storage system which we can acccess iver the internet.
- it stores file in something called bucket. within the buckets we have the folders and objects(files).
- Objects(Files) are like keys and the path leading to the objects are values.
- An object also consists of information like (metadata, sub resources, Access control information etc.,..)
- We can connect to the S3 from the VPC via IGW which is over the internet or **via the S3 gateway endpoint which is a private connection over the AWS network from the VPC.**
![alt text](imgs/st13.PNG "")

- **Types of Storage System in AWS**:
    - File base (connected using the NFS protocol (EFS))
    - object based (connected over the REST API protocol(GET, PUT, DELETE etc.,..))
    - Volume based (attached directly to the instance as drives HDD or SSD)
![alt text](imgs/st14.PNG "")


### S3 Storage Classes:

![alt text](imgs/st15.PNG "")

- There are two more addition to the storage classes S3 glacier instant retrival and S3 glacier fleixble retrival.

![alt text](imgs/s3_storage.PNG "")


### S3 Lifecycle Policies:

- We have two different type of actions in Lifecycle Policies.
    - **Transistion Action:**
        - We can trasistion among in different storage classes in a particular order. Refer below pic.
        ![alt text](imgs/st16.PNG "") 
        - we can create a lifecycle policy via CLI/API using an XML or JSON file.
        ![alt text](imgs/st17.PNG "") 
    - **Expiration Actions:**
        - when/who can delete the objects in the bucket.

### S3 Versioning and Replication:

#### Versioning:
- versioning means keeping multiple variants of an object in the same bucket.
- its used preserve, retrieve, and restore.
- prevents accidental deletion.
![alt text](imgs/st18.PNG "")

### Replication:
- Versioning must be enabled to use replication.
- We have Cross Region Replication(CRR). Replicate the objects across different regions.  
- We have Same Region Replication(SRR). replication of the obejects across differnt accounts within the same region.
![alt text](imgs/st19.PNG "")

### S3 Encryption:

![alt text](imgs/st20.PNG "") 
![alt text](imgs/st21.PNG "")
![alt text](imgs/st22.PNG "")

- We can prevent unencrypted object uploads using the bukcet policies.
![alt text](imgs/st23.PNG "")

### S3 Pre-Signed URLs:

- This are mainly used to give some one temporary access to the bucket and objects.
- Its direct way of giving the access to bucket objects for any user in the world.
- it can be set to expire after certain amount of time.
![alt text](imgs/st24.PNG "")

### Server Access Logging:
- We can record all the activites happening on the bucket.
- this events can has to be stored on a different bucket and give the current bucket to write log delviery perms.

![alt text](imgs/st25.PNG "")

### S3 Event Notifications:

- We can send a notification to SNS,SQS or lambda in case of something happens in the bucket(PUT, GET etc.,,)
- we can place a policy in the queue to recieve messages from the S3 bucket.

![alt text](imgs/st26.PNG "")


### S3 bucket policies:

![alt text](imgs/st_policy.jpg "")


## AWS Storage Gteway:

- **its a service to connect our on-prem storage to AWS.**
- it runs on a hyper-v or instacen where this service runs in the on-prem infra.
- Depending on the type of gateway connection mutiple methods are used to connect.
- 

![alt text](imgs/st27.PNG "")

- Types of Storage Gateways in AWS:
    - **File Gateway**:
        - Acting as a virtual NAS server.
        - Uses SMB / NFS protocol to connect.
        - To provide connection to AWS S3 from the on-prem via AWS Storage Gateway.
        - this in turn provides low latency for frequently accessed data acting as a local cache.
        ![alt text](imgs/st28.PNG "")
        ![alt text](imgs/st29.PNG "")
    - **Volume Gateway**:
        - Acting as a virtual object based storage.
        - uses iSCSI protocl.
        - uses cached voume mode or stored volume mode.
        ![alt text](imgs/st30.PNG "")
        ![alt text](imgs/st31.PNG "")
    - **Tape Gateway**:
        - backup service on prem. once if we want to remove from backup they are stored in any of the S3 bcukets.
        - Mostly used for the deep archival for historcal backups.
        ![alt text](imgs/st33.PNG "")
        ![alt text](imgs/st34.PNG "")

###### LABS:

- create a ec2 instacne and mount an EFS in a different region in a different VPC.
- efs > select vpc > customize > lifecycle mgmgt > performance and encryption > choose the EFS policy.
- we need enable the NFS port(2049) on the SG. EFS will have mutiple SG attached to it in different AZ.
- we can also create acccess point to enable connection via VPC endpoint.
- do the below steps to mount the volume.

```
# Install amazon-efs-utils on EC2
sudo yum -y install amazon-efs-utils

# Create mount directory and mount file system
sudo mkdir /mnt/efs
sudo mount -t efs fs-d82ea12e:/ /mnt/efs   #fs-d82ea12e (file system ID)

# Change into mount directory and create directory and file on file system
cd /mnt/efs
sudo mkdir test-directory
sudo chown ec2-user test-directory
cd test-directory
touch test-file.txt
ls -la

```

- create S3 Lifecycle policies: 
    - create a lifecycle rules to expire or transistion.
- check on the encryptions in place.

