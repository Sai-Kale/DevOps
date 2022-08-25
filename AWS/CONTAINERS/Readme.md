# Docker Containers and PaaS

## Docker & MicroService Architecture:

![alt text](imgs/c1.PNG "")

## Amazon ECS:

- ECS runs a ECS Cluster
- ECS Cluster is a logical grouping of tasks. A taks is mostly a Docker Container Running.
- A Task is defined in task(container) definition.
- The images are stored in the private registry mentioned in the task definition.
- ECS services are used to maintain the desired number of tasks.
- These tasks runs on a ECS Container Instance which we need to provision we can place them in auro scaling group as well.
![alt text](imgs/c2.PNG "")
![alt text](imgs/c3.PNG "")


- We have two types of launch types EC2 and Fargate.
- Ec2 is where we have to provision the instance and maintain. Where as the fargate is serverless.
- For fargate docker images must come from ECR no docker registry is supported.

![alt text](imgs/c4.PNG "")


- We genrally gives the permission to the EC2 instance via IAM Instance role those are applied to the Containers running as well.
- We can add a role to the ECS taks itself as well.
- By default they have all the perms IAM instance role has.
![alt text](imgs/c5.PNG "")

- For fargate its simple as IAM taks roles are only present.

![alt text](imgs/c6.PNG "")

### ECS Netowrking Modes:

![alt text](imgs/c7.PNG "")

### ECS Spot Intance & Draining:

![alt text](imgs/c8.PNG "")

### SCALING ECS:

- With ECS we have two type of scaling. Service Auto Scaling and Cluster Auto Scaling.
![alt text](imgs/c9.PNG "")

#### Service Auto Scaling:
![alt text](imgs/c10.PNG "")

![alt text](imgs/c11.PNG "")

#### Cluster Auto Scaling:

- ASG here is linked to ECS using a Capacity Provider.

![alt text](imgs/c12.PNG "")

![alt text](imgs/c13.PNG "")

### ECS With ALB:

- We have each container exposed on PORT 80 but how to make sure that traffic is distributed across the containers from the web request over the port 80. This is done by Dynamic Port Mapping.
- Dynamic port is allocated to the Host and mapped to the container port.
- ALB will listen on port 80 from the web and forwards the requests  to correct containers as it understands the Dynamic Host Mapping.
![alt text](imgs/c14.PNG "")


## EKS:

- This is the service required to run K8S .
- They need a standardized container orchestration service agnostic to the platform
![alt text](imgs/c15.PNG "")
![alt text](imgs/c16.PNG "")

## Elastic Bean Stalk:

- Its basically acts a Platform as a serv
- EBS is a solution that provides fully managed solution for WEB Applications.
- We can create a complete solution within the network.
![alt text](imgs/c17.PNG "")

- THis is primarliy used where we want to just upload the code and want AWS to basically manage everything once required options are selected.
- It support several apps java, docker, .net etc.,..

- THere are several layers to the Elastic Bean Stalk.
- THere are applications containing environments, configs and their versions. We can have multiple versions attached to an application.
- Ex : we have an application code in S3 and each indivdual version is pointed to an S3 bucket. we can actually deploy these versions to different environments.
![alt text](imgs/c18.PNG "")

- In Elastic Bean Stalk we have web servers that listen on Port 80.
- Workers are specialized apps that have a background procesing that listens on SQS queue.

![alt text](imgs/c19.PNG "")

### Updating Elastic Bean Stalk:

![alt text](imgs/c20.PNG "")

- For B/G we need to use some kind of Route 53 to route traffic to other instances.
![alt text](imgs/c21.PNG "")

# Architecture Patterns:

![alt text](imgs/c22.PNG "")
![alt text](imgs/c23.PNG "")
![alt text](imgs/c24.PNG "")
![alt text](imgs/c25.PNG "")


### LAB:

- **FARGATE CLUSTER**
- Create a fargate cluster.
- Configure Cluster.
- view cluster
- we can create new task and enter the taks definition.



- **Elastic Bean Stalk**
- choose code and upload the same.
- create newer environments.
- Swap environment URL's