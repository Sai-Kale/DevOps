# SERVERLESS

- Most of the serverless is desgined to handle the event-driven architecture.
- If some change happens in the DB we have an event publisher reporting to the event processor and do some analytics etc.,.
- We can implement these event driven architectures with AWS Very easily.



## AWS Lambda Invocations and Concurrency:

- AWS Lambda is a serverless where we directly upload the code and excute the same.
- We need to use source which can be used to trigger the lambda function.

### AWS Lambda Invocations:

#### Synchronous:

#### Asynchronous:

- This is the mostly used in real time scenarios for severless.



#### Event Source Mapping;

- Here the lmbda keeps checking to process anything. It polls the source for the changes.
- SQS can also trigger lambda.

![alt text](imgs/ld1.PNG "")

### Concurrency:

- We can excute the functions in parallel to a burst or account limit.
- We can check for the possible throttling errors. If those errors check the cloud watch logs.
- If there are no lambda thottle metrics then its possible its happening on the API calls in your code.
- Asynchronous lambda tries upto 3 times.

![alt text](imgs/ld2.PNG "")
![alt text](imgs/ld3.PNG "")
![alt text](imgs/ld4.PNG "")

## Lmabda Version and Aliases:


### Lambda Versions:

- We can increment the lmabda functions in increaing order of versions.
- The once we are working is the mutable version.
- Once done we can publish the chnages in incre version order.
- These Functions have unique ARN.
![alt text](imgs/ld5.PNG "")
![alt text](imgs/ld6.PNG "")
![alt text](imgs/ld7.PNG "")

### Lambda Aliases:

- We are creating the newer version of the lambda functions.
- The application code is pointing to the ALIAS and the ALIAS points to the Function. We can alter the traffic to the newer version and older version in varying percentage of traffic.(BLUE-GREEN Deployment)

![alt text](imgs/ld8.PNG "")

## AWS SQS:

### Decoupling with the SQS Queue:

-  If the web tier is directly talking to the app tier. it must keep up with the workload or it fails.
- Instead we can looslely connect them with the SQS. App tier keeps polling one by one without the loss of transactions.

![alt text](imgs/ld9.PNG "")

#### Standard and FIFO Queues:

- Standard Queue is the Best-effort ordering(doesnt gurantee the order)
- FIFO queue is the first in first out(its keeps the queue in order)

![alt text](imgs/ld10.PNG "")
![alt text](imgs/ld11.PNG "")
![alt text](imgs/ld12.PNG "")

#### SQS Dead Letter Queue:

- Its where a message failed to process is delivered.
- Its used to handle message failure.
![alt text](imgs/ld13.PNG "")
![alt text](imgs/ld17.PNG "")

#### SQS Delay Queue:

- We specify a delay in seconds. The message cannot be seen for that time frame.
- This is used if we want to delay the processing of certain information.

![alt text](imgs/ld14.PNG "")

- **Short Polling**: The consumer issues the API call to the queue and may not return all messages/return empty messages as well. It returns immediately.
- **Long Polling**: It waits for the responses to eliminate the empty responses. It returns after certain WaitTimeSeconds

![alt text](imgs/ld15.PNG "")
![alt text](imgs/ld16.PNG "")

## Application Integration Services Comparison:

![alt text](imgs/ld18.PNG "")

### SQS: 

- Building Distributed/ decoupled applications.

### SNS:

- Sending email notifications from the cloud. 

![alt text](imgs/ld19.PNG "")

### Step Functions:

- When we have a workflow to trigger multiple lambda functions in certain order of processing.
- Here we design a step wise function of what needs to triggered after which function.

![alt text](imgs/ld20.PNG "")
![alt text](imgs/ld21.PNG "")

### Simple Workflow Service:

- This is good if we have an Human interaction in between a workflow and trigger the later events after checking.

### Amazon MQ:

- Its based on Indsutry standard MQ like Atcive MQ and Rabbit MQ who wanna migrate to AWS

### Amazon Kinesis:

- Its used to collect, process and analyaze data.
- Consumers actually pull data from the kinesis.
- We need to provision the shards.(capacity)

![alt text](imgs/ld22.PNG "")

## Amazon Event Bridge:

- its a service used to check for the event sources and create an event.
- WE then have an Event Bridge event bus which has certain rules where to send to the targets .(ex: kinesis)
![alt text](imgs/ld23.PNG "")

- Examples

![alt text](imgs/ld24.PNG "")
![alt text](imgs/ld25.PNG "")

## API Gateway:

![alt text](imgs/ld26.PNG "")

### API Gateway Deployment Types:

- Edge Optimized endpoints: Using cloudfront to reduce the latency for requests around the world.

- Regional Endpoint: Usedful to reduce latency for requests originating within the same region.

- Private Endpoint: Securely expose the REST APIs only to services within the VPC or connect via Direct Connect.

![alt text](imgs/ld27.PNG "")

### Structure of an API:

![alt text](imgs/ld28.PNG "")

### API Integrations:

![alt text](imgs/ld29.PNG "")

### API Caching:

![alt text](imgs/ld30.PNG "")

### API Throttling:
![alt text](imgs/ld31.PNG "")

### API Usage Plans and API keys:

![alt text](imgs/ld32.PNG "")

# Architecture Patterns:

![alt text](imgs/ld33.PNG "")
![alt text](imgs/ld34.PNG "")
![alt text](imgs/ld35.PNG "")
![alt text](imgs/ld36.PNG "")
![alt text](imgs/ld37.PNG "")




### LAB:

### Serverless App for Architecture:

![alt text](imgs/LAB.PNG "")

```
## PART 1 - SQS - Lambda - DynamoDB Table ##

Set region:
    Region: us-east-1

Note your AWS account number: *ACCOUNT NUMBER*

Create DDB Table:
	Name: ProductVisits
	Partition key: ProductVisitKey
	
Create SQS Queue:
	Name: ProductVisitsDataQueue
	Type: Standard
	
Note the Queue URL: *QUEUE URL*

Go to AWS Lambda and create function
	Name: productVisitsDataHandler
	Runtime: Node.js 12.x
	Role: create new role from templates
	Role name: lambdaRoleForSQSPermissions
	Add policy templates: "Simple microservice permissions" and Amazon SQS poller permissions"
	
From actions menu in front of function code heading upload a zip file (DCTProductVisitsTracking.zip)

Go back to SQS and open "ProductVisitsDataQueue"

Configure Lambda function trigger and specify Lambda function:
    Name: productVisitsDataHandler

Go to AWS CLI and send messages:
    AWS CLI Command: `aws sqs send-message --queue-url *QUEUE URL* --message-body file://message-body-1.json`
    Modify: Queue name and file name
    File location: Code/build-a-serverless-app/part-1

## PART 2 - DynamoDB Streams - Lambda - S3 Data Lake ##

Go to DDB table

Enable stream for "New Image"

Create S3 bucket in same region:
	Name: product-visits-datalake
    Modify: bucket name by adding letters/numbers at end to be unique
    Region: us-east-1

Go to IAM and create a policy:
	Name: productVisitsLoadingLambdaPolicy
	JSON: Copy contents of "lambda-policy.json"
	Modify: Replace account number / region / names as required

Account number: *ACCOUNT NUMBER*

Create a role:
	Use case: Lambda
	Policy: productVisitsLoadingLambdaPolicy
	Name: productVisitsLoadingLambdaRole

Unzip "DCTProductVisitsDataLake.zip" 

Edit index.js and update bucket name entry:

Bucket: 'product-visits-datalake'

Note: Change bucket name to YOUR bucket name

Then zip up contents (don't zip the whole folder) into "DCTProductVisitsDataLake.zip"

Create a function:
	Name: productVisitsDatalakeLoadingHandler
	Runtime: Node.js 12.x
	Role: productVisitsLoadingLambdaRole
	
Upload the code: DCTProductVisitsDataLake.zip

Go to DDB and open table

Choose Export and stream and create a trigger

Select function:
    Name: productVisitsDatalakeLoadingHandler

Go to AWS CLI and send messages:
    AWS CLI Command: `aws sqs send-message --queue-url *QUEUE URL* --message-body file://message-body-1.json`
    Modify: Queue name and file name
    File location: Code/build-a-serverless-app/part-2

## PART 3 - S3 Static Website - API Gateway REST API - Lambda ##

Create IAM Policy:
	JSON: Copy from lambda-policy.json
	Updates: change account number
	Name: productVisitsSendMessageLambdaPolicy

Account Number: *ACCOUNT NUMBER*
	
Create an IAM role:
	Use case: Lambda
	Policy: productVisitsSendMessageLambdaPolicy
	Name: productVisitsSendMessageLambdaRole
	
	
Unzip "DCTProductVisitForm.zip"

Edit index.js for backend and update queue name:

QueueUrl: "*QUEUE URL*"

Note: change above URL to YOUR queue URL

Then zip the backend folder contents to backend.zip

Create a Lambda function:
	Name: productVisitsSendDataToQueue
	Runtime: Node.js 12.x
	Role: productVisitsSendMessageLambdaRole
	
Upload code: backend.zip

Go to Amazon API Gateway

Create a REST API and select New API:
	Name: productVisit
	Endpoint type: Regional
	
Create a resource:
	Resource name: productVisit
	Resource path: /productVisit
	Enable CORS
	
Create a method:
	Type: PUT
	Integration type: Lambda function
	Use Lambda Proxy Integration
	Function: productVisitsSendDataToQueue
	
Deploy API - Actions > Deploy API

Create a new stage called "dev"

Go to SDK Generation and generate using platform "JavaScript"

Copy contents of donwloaded file to frontent folder. Change the logo image

Create a bucket:
	Name: product-visits-webform
    Updates: Add letters/numbers to bucket name to be unique
	Region: us-east-1
	Turn off block public access
    
	
Enable static website hosting:
	Index: index.html
	Policy: copy contents of frontend-bucket-policy.json (edit bucket name)
	
Edit CORS settings by adding contents of cors-config.json

Edit index.html with correct Region if required:

region: 'us-east-1' // set this to the region you are running in.

Use command line to change to folder containing the frontend directory

Upload contents with AWS CLI command (change bucket name)

`aws s3 sync ./frontend s3://product-visits-webform`

Copy the object URL for index.html

Use URL to access application and then submit data using the form

## PART 4:

- Enable CloudTrail Logs if an changes made to the S3 Static Website Bucket.
- Then we trigger a Event Bridge Rule to send an SNS Notification.

```