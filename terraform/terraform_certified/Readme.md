# TERRAFORM:

- Notes: https://docs.google.com/document/d/179clqsxOGQa-iGKu1dcmz89Vpso9-7Of8opIkXwPr_k/edit
		
		
- Terraform is Industry grade Infrastructure as Code Tool. Helps in Implementing AWS hardening guidelines. Hardening Guidelines are for security purposes in multiple accounts and infrastructure provisioning.

## Configuration Management vs IaC:
- Anisble, Chef and Puppet primarily used to CM i.e. that they are primarily used to install and manage softwares on exsisting infra.

- Terraform and Cloud Formation are infra orchestration which means they can provision infra and run servers by themselves.
- CM tools can do some degree of Infra Provisioning.
- Supports Multiple platofrms
- We can create our own plugins and its completely free.

- **TERRAFORM primary role to create, update and destroy the infrastructure resources to match the desired state described in terraform configuration.**


## Skeleton:
- on a minimum level we should be able to provide the authentication type. service provider and resource to be created.
- Documentation for AWS: https://registry.terraform.io/providers/hashicorp/aws/latest/docs
- **AMI ID are region specific.**
- each resource has a unique ARN number in AWS.
## Providers:
- Depending upon on where we want to launch our infra we need to use sepcific provider ex:aws,azure,GCP,K8S
- Whenever we update a provider in terraform file we need to run terraform init
- for terraform 0.13+ we need to provide the terraform provider details expilicilty. However, for Hashicorp maintained ones its works perfectly.
-  Ex: https://registry.terraform.io/providers/hashicorp/aws/latest/docs refer this page. for providers which are not hashicorp maintained we need to expilicilty mention the provider details.

## Resources:

- Resources are the ones we need to configure like ec2 instance and type and AMI-ID

- terraform init
  terraform plan
  terraform apply 

## Destroying the resources using terraform:

1. # terraform destroy. (destroy all the resources created under that particular folder)
2. In case if we want to destroy the specific resources only we use => # terraform destroy -target aws_instance.myec2
	Here, when we use a target flag we need to specify the local resource name type and resource name.
	ex: In below example, RESOURCE TYPE(aws_instance) and RESOURCE NAME(myec2) . Name  can be anything as per our need. refer to documentation
	before using the resource type.
	resource "aws_instance" "myec2" {
    ami = "ami-0bcf5425cdc1d8a85"
    instance_type = "t2.micro"  
	}  
3. We can also comment out the unwanted section and do terraform plan and apply. terraform thinks that the commented out section no longer required
	and destroy the same.

## TERRAFORM STATE FILE:

- All the resources current state is stored under the terraform state file. (terraform.tfstate & terraform.tfstate.backup) its really recommended NOT to mess with this files. If these files are deleted terraform has no way of knowing our current resources state.

## TERRAFORM desired state vs current state:

- In case if we have created a resource of t2.micro and we change the configuration file and make it t2.medium and try to change according to the  desired state of the file. In that case when we do a terraform plan, terraform compares the current state vs desired state. 
- Current State is updated using the # terraform refresh .
- Then # terraform plan gives a plan to achieve the desired state then do an # terraform apply accrodingly.
- Note: When we change the instance state from t2.micro to t2.medium and its EBS optimized, manually in AWS. 
		  If we try to update the desired instance to t2.micro using terraform. It might just REPLACE the instance instead of CHANGING
		  the instance type. In that case tha information on the instance can be LOST.
		  so, its always best practice to do terraform plan and READ what its doing exactly before doing any terraform apply.

- Desired State Note: For example if we update the EC2 SG from default to custom in the below example manually in AWS console.
	resource "aws_instance" "myec2" {
    ami = "ami-0bcf5425cdc1d8a85"
    instance_type = "t2.micro"  
	} 
	When we do a terraform refresh then terraform updates the current state in terraform state file. Here, if we again do the terraform apply
	it doesnt revert back the SG from custom to default as nothing related to SG is mentioned in the terraform configuration.
	hence, its important to always enter all the inputs as per the requirement in Terraform Configuration file.
- **TERRAFORM primary role to create, update and destroy the infrastructure resources to match the desired state described in terraform configuration.


## PROVIDER VERSIONING:

- Provider plugins are update seperately from terraform itself. Terraform as well keeps updating independently from provider plugin.
- At first we might use version 1 of digital ocean plugin & later change it can get updated to version 2. these changes must be noted and comes with own set of challenges.
- For Production setup, you should constrain the acceptable provider version via configuration. example below.

```
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.36.0"
    }
  }
}

provider "aws" {
  # Configuration options
}

Here the version is set to 3.36.0
We can use different set of versions as <=3.0 , >=3.0 , = 3.0, ~> 3.0 (any version in range 3.x) , (>= 3.0,<= 3.3) (in between range 3.1 & 3.3)
it is IMPORTANT TO USE A FIXED VERSION for production. as automatic retirval of newer version might cause issues in production.

*There is file called ".terraform.lock.hcl" whenever you do the # terraform init using a secific version in configuration file this is created.
we can't automatically specify a newer version in a new configuration file as the earlier mentioned version is locked in that above file
created. we can upgrade to newer version using # terraform init -upgrade

```
## Attributes and Output values in TERRAFORM:

- Terraform has the capability to output the attribute of a resource with the output values.
- The output attributes are not only for user reference but also used a as input for other resources created via terraform.
- Attributes - These are the values associated with those of resource created ex: Ip value of EIP resource.
- Output - These should be mentioned in the terraform configuration as to what attribute output should be printed after resource creation
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip - Chekc the attribute section in this page.


## Referencing Cross-Account Resource Attributes:

- Cross acoount referencing refers to asociation of SG with IP addr. or Associating IP address with an Security Group or associating the resources basically
- Review the below example for EIP with AWS Instance and SG with ingress from that EIP.

```
#creating a instance
resource "aws_instance" "myec2" {
    ami = "ami-0bcf5425cdc1d8a85"
    instance_type = "t2.micro"  
}

#creating a EIP
resource "aws_eip" "lb"{
    vpc = true
}

#AWS Instance and EIP association
resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.myec2.id #these two can be fetched from attributes.Example for EIP https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip
  allocation_id = aws_eip.lb.id
}

#Creating a Security Group
resource "aws_security_group" "terraform_eip" {
  name        = "referencing_terraform"
  description = "Allow TLS inbound traffic"
  
  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${aws_eip.lb.public_ip}/32"] #   cidr_blocks = [aws_eip.lb.public_ip/32]

  }
}
```
## VARIABLES:
- instead of using the repetative varaibles we can use the source to declare repetative stuff.We can call that variable where an when required.
- If we hard code variables in all locations it will be increasingly difficult to update the stuff as we need to change everything.
- Source -> A central source where we can import values from.
- VARIABLES are extensively used in writing clean code.

- MULTIPLE approaches to variable assignment:

1. Variable Defaults: Where we create a new file called variables.tf config file and assign the default values.
 variable "source_ip"{
    default = "10.22.5.20/32"
}
We can also mention the explicit value like # terraform apply -var="instancetype=t2.micro"
If we dont have anything mentioned for var values. terraform requests us to enter during the terraform plan and apply time.
2. Variables from File:
   We can create a file called "terraform.tfvars"  and delcare the variables here. terraform bascially takes the variables from here.
   If this file is not present it takes variables from variables.tf file. If nothing is mentioned we need to enter the value during runtime.
   Best practice is to have both the files in production terraform.tfvars & varaibles.tf as varibles.tf containes the default option and later 
   we can change it in the terraform.tfvars as and when required.
Command Line Flags:
Note: We need to mention the naming convention as used above. if we need to use a custom variable file name we need to expilicilty mention 
	   while running # terraform plan -var-file="custom.tfvars"
	  

3. Environment Varaibles:
we can set a env variables in terraform using the command # export TF_VAR_instancetype="m5.large"


-  Mostly in production we used the varibles from a file.

## Data Types for VARIABLES:


```
variable "image_id"{
	type = string
	} # only the string variable type is accepted.

Example, Consider every employee in the media corp is assigned a Identification Number.
Any resource that employee creates should be created with the name of identification number only.
varibales.tf =>  variables "instance_type" {
type = number
 } # the above type doesnt allow creation of a new user which doesnt have a number. String helps in this validation.
terraform.tfvars => instance_name="jhon-123" accepts
```
- String types: string, list , map and number

- for use case refer https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elb


- For few uses cases like in the creation of ALB the variables needs to be passed as a string. 


## COUNT PARAMETER: 
- The count parameters can simplify configs and let u scale resources just by increasing number.
- Instead of mentioning two ec2 instances seperately.
- however, if all the instances or IAM users getting same name is not desired.Hence, we use a COUNT.INDEX parameter.In below example,
```
resource "aws_iam_user" "lb" {
  name = "loadbalancer.${count.index}" # Here the names we get are loadbalancer.1 , loadbalancer.2 and loadbalancer.3
  count = 3
  path = "/system/"
}
However, if we need specific names passing of as a variable should work.
variable "elb_names" {
  type = list
  default = ["dev-loadbalancer", "stage-loadbalanacer","prod-loadbalancer"]
}

resource "aws_iam_user" "lb" {
  name = var.elb_names[count.index]
  count = 3
  path = "/system/"
}

```
## CONDITIONAL EXPRESSIONS:

- Depending on the variable value, one of the resource block will run if there are two resources as a part of terraform configuration.
- Conditional is bascially boolean value true or false.
- Refer the terraform practice conditional.tf config for more info.

## Local Values:
- A local value assigns a name to a expression , allowing it to be used multiple times within a module without repeating it.
- Refer to the local_values.tf file in practice
- Local values can be used for multiple different use-cases as conditional expressions.

## TERRAFORM FUNCTIONS:

- terraform has a lot of built in functions that you can used to transform and combine values.
    ex: max(10,12,9)

    output is 12 max value.
- General Syntax: funtion_name(argument1,argument2etc.,..)It doesnt support user defined functions. only avaible functions are to be used.
  try them in terraform console using #terraform console in command line.
  Refer functions.tf for more information.


## DATA SOURCES:

- Data sources allow data to be fetched or computed for use of elsewhere in terraform configuration.
- AMI-ID are sepcific to region and they keep updating so its difficult to keep updatng them.
- data source helps us to fetch the latest ami-id. it provides the information about the latest ami-id.

## DEBUGGING in Terraform:

- terraform has detailed logs which can be enabled by setting the TF_LOG environment variable to any value.
- you can set TF_LOGS to one of the log levels TRACE,DEBUG,INFO,WARN, or ERROR to change the verbosity of the logs.

- we can also export the log path-> export TF_LOG_PATH=/tmp/terraform-crash.log

## TERRAFORM FORMAT:
- formatting can be done using #terraform fmt .this helps us in formatting the code for better readability.

## VALIDATING TERRAFORM Configuration FILES:

- **terraform validate**
    it helps checks whether configuration file is syntatically correct or not.


## LOAD ORDER & SEMANTICS:

- Helps us in writing better code in terraform.
- terraform  generally loads all the tf file within the specific path in alphabetical order.
- refer to load_order and semantics.tf file.

## Dynamic BLOCKS:


- instead of adding mutilple blocks of code for example in case of ingress if there are 100 ports to be openend. its a heavy task
- terraform provides us with something called dynamic block which helps us in acheving the same.
- refer dynamic_blocks.tf for the same.

## TAINTING RESOURCES:


- the terraform taint command manually marks a terraform-managed resource as tainted , forcing it to be destrooyed and recreated on next apply.
- In case where we launch a resource using terraform and other users make unnecessary changes instead of destroying and recreating , we can taint
- that resource and next time when we do apply the resource is destroyed and recreated.

- ex: terraform taint aws_instance.myec2 (next time you do apply on the resource , its destroyed and recreated)

- most orgnaizations doesnt allow infrastructure to be modified manually.

## SPLAT EXPRESSIONS:

```
It allows to get the list of all the attributes.
resource "aws_instance" "myec2" {
    ami = "ami-0bcf5425cdc1d8a85"
    instance_type = "t2.micro"
    count =  5  
}

output "arns" {
    value = aws_instance.myec2[*].arn #using splat expressions to output the arn values of all the 5 instance created.
}

```
## TERRAFORM GRAPH:

- it allows us to generate pictorial representation the execution plan of terraform plan.
- the output of the terraform is in DOT format, which can be easily be converted into an image.
```
1)sudo yum install graphviz
2)terraform graph  > graph.dot
3)cat graph.dot | dot -Tsvg > graph.svg
copy contents from graph.svg into a file in windows and open using chrome or explorer.

SAVING TERRAFORM plan to a file:
to save the terraform plan to a file.
terraform plan -out=path #here the path you have to specify wher you want to save.
to save our particular plan and run later.

it creates a binary file.
```
## TERRAFORM OUTPUT:
- it is used to print the output variables in a specific terrform configuration
- **terraform output iam_names**

## TERRAFORM SETTINGS:
- the special terraform block to cofigure some of the terraform behaviours itself, such as minimum terraform version to apply to our configuration.
```
Example doing a config setting for terraform version
terraform {
	required_version = "> 0.13" #makes sure if someone uses the version below that throws some error.
	}


similarly we have the provider version as well that we need to specify.

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~>3.0" #anything in 3.x range. In real use cases we mostly use only one version for production.
    }
  }
}

few srpcific files are desinged for some versions in that case this is useful a lot.
```

## DEALING WITH LARGE INFRSTRUCTURE:

- When we have a large infrastructure there is a API limit on the provider.
- Switch to smaller infra which can be applied independently.
- if not we can slow down the terraform plan by using the  terraform plan -refresh=flase  or we can use terraform plan -target=ec2 flag as well.


- to skip the yes command each time we can use terraform apply -auto-approve.

## ZIPMAP FUNCTION:

- zipmap function basically creates a map from a list of keys and a list of values.

    apple , red > apple = red.

## TERRAFORM PROVISOINERS:

- When we create a web server EC2 instance. it doesnt have any web sever softwares installed.
- What if we need end to end solution.
- Provisioners help to execute script on remote or local machine as a part of resource creation.
    Ex: when a new ec2 instance is created. terraform needs to install nginx web server.
    organization can provison their entire infra with the help of provisoners as soon as the instance is created.

- TERRAFORM has the capability to tune the proviosners on both at the time of reosurce creation as well as destruction.

- There are two type of provisioners 1) Local exec and 2) Remote Exec
        **Local-Exec** : if we want to execute something on the machine where the terraform has been running.
        https://www.terraform.io/docs/language/resources/provisioners/local-exec.html
        **Remote-Exec**: if we want terraform to execute on a remote server.
        https://www.terraform.io/docs/language/resources/provisioners/remote-exec.html
        Local-exec helps in triggering the anisble playbook once the instance is created in a real life use case.
        Provisoners are further dividend into create time provsioners and destroy time provisoners.
        Creation-time provisoner: these are run only during the creation , not during the updating or anyother time in the lifecycle
						*** if create time provisoner fails then the resource is marked as tainted
        Destroy time provsioner: destroy provsioners are run before the resource is destroyed.

## Failure Behaviour:

there are two conditions for failures
if the provisoner fail it either continues or else marks the resource as tainted



## TERRAFORM MODULES AND WORKSPACES:

- DRY Principle in software engineering: Dont Repeat Yourself aimed at reducing then number of times you repeat something using modules for example if we keep calling the same ec2 instance everytime instead of repeating everytime its better to use module everywhere

- modules are reusable parts for different projects.

## CHALLENGES WITH MODULES:

- Different env may require diff set of reosuces. so when we hard code the isntance values it gets difficult for creation and maintainence of different environments. we can make use of varaibles instead of doing that.

## TERRAFORM REGISTRY:

- terraform registry is repository of modules written by the terraform community.

- Verified modules are available and reviewed by hashicorp and updated by vendor.
    https://registry.terraform.io/ -> terraform registry.

## TERRAFORM WORKSPACES:

- TERRAFORM helps us to have multiple workspaces each workspaces will have to different set of environment varaibles associated.
- similarly on the lines of Dev, QA and Production.

- **terraform workspace -h** 
- Usage: terraform workspace

```
  new, list, show, select and delete Terraform workspaces.

Subcommands:
    delete    Delete a workspace
    list      List Workspaces
    new       Create a new workspace
    select    Select a workspace
    show      Show the name of the current workspace

```
## REMOTE STATE MANAGEMENT with Terraform:

- We have been working locally. Its better to use GIT as the local space might crash.

- Make sure NOT to commit code while ACCESS_KEY and SECRET_ACCESS_KEY are present in tf file as this is security voilation. even though we use some kind of environment variable or refer a file "${file("../rds_pass.txt")" function to refer to password the terraform.tfstate file contains all the details of the password. **so its NOT ideal to commit the terraform.tfstate file to the GIT.
```
Supported MOdule Sources:

Local paths
Terraform Registry
Github
Bitbuket
HTTP URLs
S3 bucket
GCS Bucket

refer : https://www.terraform.io/docs/language/modules/sources.html
Ex: for git
module "consul" {
	source = "git::https://example.com/git"
}
in the above example if you want to refer to different branch we can use "git::https://example.com/git?ref=development" (for development branch)
```
## TERRAFORM & GITIGNORE:

- .gitignore -> helps us in ignoring few files that doesnt need to be commited.
- File to be Ignored:
    .terraform
    terraform.tfvars (may contain the sensitive information)
    terraform.tfstate (should be stored in remote side)
    crash.log (if terraform crashed files are added to log called crash.log we can ignore that as well.)

    refer this common usage: https://github.com/github/gitignore/blob/master/Terraform.gitignore

## Remote Backend:
- the terraform.tfstate files are not stores in git due to sensitive information
- they are stored in terraform remote backend

## TERRAFORM supports lot of backend types one among them is s3 however,there are lot them supported including consul.
## types of backend:
1. standard backend type	 refer: https://www.terraform.io/docs/language/settings/backends/index.html
2. all features of standard + remote management

## Implementing S3 Backend:

- create a file called backend.tf (then terraform knows where to store the tfstate file)
- when you do a terraform init , backend is initialized. if terraform doesnt pull s3 information please provide access key and secret_acess_key as well

## TERRAFORM State File Locking:

- whenever you perform a function terraform locks the file for that time.
- when two persons perform on the same time it may corrupt the terraform.tfstate file.
- to avoid this terraform locks the tfstate file when an operation is performed.
- whenever you do a terraform plan it would lock the file.
- this locking feature in not avaible in all backend.

- S3 supports state locking using dynamo DB
- we need to enter the dynamob table name in backend.tf  file.

## TERRAFORM State MANAGEMENT:

- Never modify the terraform.tfstate file directly. instead use the below commands for any usage.

```
terraform state list (lists all the resources in tf state file) https://www.terraform.io/docs/cli/commands/state/list.html
terraform mv:If you want to rename a instance we can use #terraform state mv aws_instance.weapp  aws_instance.myec2
if you directly change the instance name in terraform.tfstate file the next time you run terraform appl it destriys and creates the instance.
instead use terraform mv.
terraform pull: #terraform state pull it bascially pulls the information present in the terraform state file.
terraform push: #terraform state push the terraform state push is used to push a local state file to remote state.
				it should be rarely used.
terraform rm:this command is used to remove items in the terraform state.
				items removed are not physically destroyed.
				i.e if you rm a instance it continues to run in console, but terraform cant manage it anymore as its removed from terraform state
terraform state show: if you want to see attributes of a single resource inside the state file.
					terraform state show aws_iam_user.lb
					
TERRAFORM IMPORT:
It might happen somebody has created a resource manually. In such case, if you want to make any changes to instance has to be done manually.
import helps us to import the instance into a tf file.
#terraform import aws_instance.ec2 instance_id

```
## SECURITY PRIMER:

- Dont put the ACCESS_KEY and SECRET_ACCESS_KEY in the providers.tf or in the providers coloumn in the terraform configuration file.
- If we want multiple providers and create resources across regions use ALIAS .

## MULTIPLE resources in MULTIPLE accounts ?
- Create a credentials file and refer the same in the providers list where we want to use them.
- Refer them in providers config

## TERRAFORM WITH STS:(do this lab later)

```
When we have multiple accouts in AWS instead of using multiple ACCESS_KEY and SECRET_ACCESS_KEY , we have an identity account
where we have single set of username & password , access & secret keys. 
In order to create resources the STS user need to assume a role(assume role policy needs to be attached to STS user before that) 
to create resources inside the AWS. that can be done by using below command
aws sts assume-role --role-arn (arnvalue) --role-session-name saikuma-testing


Samething in terraform as follows:

this has to be configure inside the providers.tf
provider "aws" {
	region = "ap-south-1"
	assume_role {
	  role_arn = "arn_value"
	  session_name = "saikumar-demo"
	}
}

Sensitive parameter:
in the output parameter we can out the sensitive value to be true so that pasword isnt displayed on the screen.

```
## TERRAFORM CLoud:

- terraform cloud manages terraform runs in a consistent  and reliable environment with various features like acceess controls, private registry for sharing modules, policy controls and others.
- This has features like sentinel(policy check) and few checks in place.
- Terraform cloud is alternative to the cli version which we are using.
- we can integrate terraform cloud with the VCS(git)

- Sentinel policy: is a policy check we create before creation of actual resource. ex: check if tags are present.
- Policy should be a part of policy set in TF cloud.

## Terraform Backend Operations:
- We can use the remote operations like terraform plan and terraform apply on CLI but it applies at the cloud level.
- only the log output shows up on the console.
- we need to configure backend.hcl and provider of terraform cloud


