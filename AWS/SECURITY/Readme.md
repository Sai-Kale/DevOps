# SECURITY

## Build Secure Multi-Tier Architecture:

![alt text](imgs/se1.png "") 

- We are going to place CloudFront as first serving layer.
- We will use https by enabling the SSL certs.(AWS Cert Manager)
- We will enable ACL and AWS Sheild(prevents DDoS) on CloudFront (advance costs more money)
- AWS WAF is also used for more granular security.
- NACL and SG are present.
- We will log from CLoudFront and ALB to an S3 bucket.
- We will enable AWS Config to make sure that encryption and certain settings are enabled on S3 or not.
- Amazon Inspector to make sure if security best practices are followed are not.
- EBS volumes are also encrypted.
- We will be having an SNS topic configured for Inspector, AWS Config and WAF to notify for any changes.
- We can increase more security as well.


## Encryption at Rest vs Transit:

![alt text](imgs/se2.png "") 
![alt text](imgs/se3.png "") 

## AWS Certificate Manager:

- Create & Stores Certs. Also roates the key.
![alt text](imgs/se4.png "") 
![alt text](imgs/se5.png "") 

## AWS KMS:

- Symmetric Encryption(Single Key to encrypt and decrypt) and Asymmetric Encryption(Public and Private keys to encrypt and decrypt)
![alt text](imgs/se6.png "")
- These CMK can encrypt only 4kb data, for more data we need to use Data Encryption Keys. Secured by CloudHSM.

![alt text](imgs/se7.png "")

- AWS Managed CMKs
![alt text](imgs/se8.png "")

- Data Encryption Keys
![alt text](imgs/se9.png "")

- Comparison
![alt text](imgs/se10.png "")

## Cloud HSM:

- its a cloud-based hardware security module.
- Hight level security.

![alt text](imgs/se11.png "")
![alt text](imgs/se12.png "")

## AWS Macie:

- Maice is a fully manged data security and data privacy service to protect sensitive data on S3.
![alt text](imgs/se14.png "")

## AWS Config:

- its evalutes the configuration of resources against the desired configuration.

![alt text](imgs/se15.png "")
![alt text](imgs/se16.png "")

## AWS Inspector:

- runs assestments to check for securty exposures.
- we need to install this agent on EC2. (checkks for the host hardening, vlunerable software, securty best practices.)
- It performs the network assesments without agents.
- it check the configuration of network what ports are avaialble from outisde.

## AWS WAF:

- Web Application Firewall.
- it lets us creae rules for the web traffic based on the conditions.
![alt text](imgs/se17.png "")
![alt text](imgs/se18.png "").
![alt text](imgs/se19.png "")
![alt text](imgs/se20.png "")
![alt text](imgs/se21.png "")

## AWS Sheild:

- Its used to protect against the DDoS attacks. when someone is sending a large amounts of data or requests continously.

![alt text](imgs/se22.png "")

## AWS Guard Duty:

![alt text](imgs/se25.png "")

# Architecture Patterns:

![alt text](imgs/se23.png "")
![alt text](imgs/se24.png "")


#### LAB:


1. Part 1:
    - creating SG:
        - ALB frontend (allow all inbound traffic)
        - ec2 backend (inbound http from alb)
        - edit oubtbound rules for alb frontend to ec2 backend
    - create kms keys
        - mydatakey (symmetric key)
        - key usage enabel own acount and organizaiton.
        - key uage perms AWS Service role for auto scaling.
        - check the policy and finish.
    - aws certificate manager (need wn domain name)
        - get started (request public cert)
        - email validation.
        - repeat the same for the alb (domain being alb.(domain_name))
        - go to email and confirm
    - SNS topic kep it ready.
        - stnaard, mynotification, create topic
        - got to subscription > topic ARN > email > enter your email
        - got to email and confirm teh subscription.

2. Part 2:
    - create private subnets:
        - two private subnets in two regions.
        - create a private route table. associate private subnet to the RT.
        - create a NAT gateway , put in a public subnet. 
        - private RT add this NAT Gateway route.
    - IAM:
        - create a role > instance profile for EC2.
        - S3 read only access and SSM (ec2_ssm_s3_role)
        - create a bucket in S3.(upload the index.txt file )
        - copy the user data code and use it in the user data profile while launching the instance.

        - create a launch template (chhose ec2 backend SG)
        - EBS volumes > encryption > kms >  key id
        - Advance details > paste useer data
        - create a launch template.

```
<html>
<head>
<style>
body {
  background-color: #33342D;
}
h1 { color: white; }
h1 {
 text-align:center
}
</style>
</head>
<body>

<h1>This Amazon EC2 instance is located in Availability Zone:</h1>
  <h1>INSTANCEID</h1>

</body>
</html>

```
```
#!/bin/bash
yum update -y
yum install httpd -y
systemctl start httpd
systemctl enable httpd
cd /var/www/html
aws s3 cp s3://bucket-name/index.txt ./
EC2AZ=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone) 
sed "s/INSTANCEID/$EC2AZ/" index.txt > index.html

```
3. Part 3:
    - add a custom header in clufront origin rules that makes sure that ALB ccepts conenctions only with that header.
    ![alt text](imgs/se13.png "")
    - this makes sure we cant acces the ALB directly.
    - create a ASG and launch tempalte from earlier section, choose the private subnets.
    - capatiy all 2 > done
    - create ALB > https for listner > choose public facing subnets for public facing LB
    - choose the certificate for alb.
    - choose the alb fronte end SG
    - create TG register targets as EC2 instances.

    - create a Cloudfron distrbution. 
    - select the origin and enter alb.labs.net
    - https > cloudfront uses https to connect alb
    - distribution settings > alternate domain names > labs.net
    - custom SSL cert 
    - index.html as default roo object

    - route 53 go to hostes zone 
    - create a couple records.
    - route trffic alias to cloudfront.> choose clou front create records.
    - alb.lab.et > alias to alb and choose the LB.

    - we can connect dirctly to the lb but we dont want to connect directly we want to direct them throught the cloudfront 
    - we need to create the custom headers before that normal redirection to to alb is working from clodfront.
    - orign settings > cludfront > x-custom-header (value-abvd)
    - got ot alb > listerners > edit rules > insert rule > http haeader > X-Customer-header (value enter)
    - direct route reutnr fixed response (connect via cloudfront)
    - access the LB front cloud frontend.


4. Part 4:
    - ALB . edit attributes> acces logss > s3 bucket logging.
    - s3 check for the creation of logs.
    - cloudfront > setup logging from there as well.
    - edit > standard logging.
    - log prefix > create folder cloudfront in S3 > coudfront/ 

    - create AWS COnfig by all defaults
    - rules > aws manged rules > encryption s3 encryption
    - another alb crt reuqired >
    - manged actions > automatic remediateion > enable encrption (dont enable for this lab)    
    - delviery method choose and SNS topic to  email. (can leave for the lab) 
    
    - AWS System manager > run command > serach for inspector > choose instances manually 
    - got to inspector check for the assements required. > include all ec2 isntacnes.
    - duration the to 15 min > create the same.



5. part 5:
    - enable AWS WAF . 
    - Add the CF distribution and add aws resources.
    - AWS mnaged rules > aws IP reputation list.
    - add own rules > rate limit (100) > limit max req form a singl IP in a 5 min period. > block.
    - send 500 requests at once and see forbidden request

    - AWS Sheild  standard is enabled by default.
    - 