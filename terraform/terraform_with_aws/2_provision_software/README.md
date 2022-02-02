# 2.0 Software Provisioning :
 
- There are 2 ways to provision software on your instances
- You can build your own custom AMI and bundle your software with the image
        - Packer is a great tool to do this
- Another way is to boot standardized AMIs, and then install the software on it
you need
        - Using file uploads
        - Using remote exec
        - Using automation tools like chef, puppet, ansible
- In general if we to upload files using provisioner.

```
resource "aws_instance" "example" {
ami = "${lookup(var.AMIS, var.AWS_REGION)}"
instance_type = "t2.micro"
provisioner "file" {
        source = "app.conf" #upload the file in the current folder
        destination = "/etc/myapp.conf" #destination in the server created where it needs to be placed.
    }
}

```

- In conjunction with the remote-exec we can execute the script on the remote host. for this we need to use the remote connection.

```
resource "aws_instance" "example" {
ami = "${lookup(var.AMIS, var.AWS_REGION)}"
instance_type = "t2.micro"
provisioner "file" {
source = "script.sh"
destination = "/opt/script.sh"
connection {  #to connect to the remote host
        user = "${var.instance_username}"
        password = "${var.instance_password}"
  }
   }
}
```

- by default the connection type is ssh if we want to change it you can declare the type using type function.
- Typically on AWS we will be using the aws key pairs

```
resource "aws_key_pair" "mykey" {
key_name = "mykey"
public_key = "ssh-rsa my-public-key"
}
resource "aws_instance" "example" {
ami = "${lookup(var.AMIS, var.AWS_REGION)}"
instance_type = "t2.micro"
key_name = "${aws_key_pair.mykey.key_name}"
provisioner "file" {
source = "script.sh"
destination = "/opt/script.sh"
connection {
        user = "${var.instance_username}"
        private_key = "${file(${var.path_to_private_key})}"
  }
   }
}

```

- similarly we can use remote-exec to execute a script on the server created.

```
resource "aws_instance" "example" {
ami = "${lookup(var.AMIS, var.AWS_REGION)}"
instance_type = "t2.micro"
provisioner "file" {
source = "script.sh"
destination = "/opt/script.sh"
}
provisioner "remote-exec" {
        inline = [
        "chmod +x /opt/script.sh",
        "/opt/script.sh arguments"
        ]
 }
}
```
- ssh-keygen -f mykey

# 2.1 Output attributes in terraform:

- Terraform keeps attributes of all the resources you create
- Those attributes can be queried and outputted
        - eg. the aws_instance resource has the attribute public_ip
- This can be useful just to output valuable information or to feed information
to external software

```
resource "aws_instance" "example" {
ami = "${lookup(var.AMIS, var.AWS_REGION)}"
instance_type = "t2.micro"
}
output "ip" {
value = "${aws_instance.example.public_ip}"
}
```

- You can refer to any attribute by specifying the following elements in your variable:
        - The resource type: aws_instance
        - The resource name: example
        - The attribute name: public_ip


- we can output the attributes to the local location local-exec. the outputted IP values may be used to execute the ansible playbook.

# 2.2 Remote State :

- Terraform keeps the remote state of the infrastructure
- It stores it in a file called terraform.tfstate
- There is also a backup of the previous state in terraform.tfstate.backup
- When you execute terraform apply, a new terraform.tfstate and backup is written
- This is how terraform keeps track of the remote state
        - If the remote state changes and you hit terraform apply again, terraform will
        make changes to meet the correct remote state again
        - e.g. you terminate an instance that is managed by terraform, after terraform
        apply it will be started again
 # 2.2.1 Terraform Remote State backend :
  - Declared inside the versions block.
  ```
  terraform {
        backend "consul" {
        address = "demo.consul.io" # hostname of consul cluster
        path = "terraform/myproject"
        }
        }
 ```
  terraform {
  required_version = ">= 1.0"
  backend "s3" {
        bucket = "mybucket"
        key = "terraform/myproject"
        region = "eu-west-1"
  }
  }
  ```
 - Then perform the terraform init to initialize the backend.

# 2.3 Data Sources :

- For certain providers (like AWS), terraform provides datasources
- Datasources provide you with dynamic information
- A lot of data is available by AWS in a structured format using their API
- Terraform also exposes this information using data sources
- Examples:
  • List of AMIs
  • List of availability Zones
- Another great example is the datasource that gives you all IP addresses in
use by AWS
- This is great if you want to filter traffic based on an AWS region.
        Ex:  allow all traffic from amazon instances in Europe
- Filtering traffic in AWS can be done using security groups.
```
data "aws_ip_ranges" "european_ec2" {
regions = [ "eu-west-1", "eu-central-1" ]
services = [ "ec2" ]
}
resource "aws_security_group" "from_europe" {
name = "from_europe"
ingress {
from_port = "443"
to_port = "443"
protocol = "tcp"
cidr_blocks = [ "${data.aws_ip_ranges.european_ec2.cidr_blocks}" ]
}
tags {
CreateDate = "${data.aws_ip_ranges.european_ec2.create_date}"
SyncToken = "${data.aws_ip_ranges.european_ec2.sync_token}"
}
}

```

# 2.4 Modules :

- Modules are used to make terraform more organized.
- We can use third party modules wich are already pre exsisitng from github.
- Reuse the parts of the code. 
        Ex: to setup a VPC network in AWS.
- If we a module from git we write as below.

```
module "module-example" {
source = "github.com/wardviaene/terraform-module-example"
}

module "module-example" {
source = "./module-example"
}

```
- Pass arguments to the module.

```
module "module-example" {
source = "./module-example"
region = "us-west-1"
    ip-range = "10.0.0.0/8"
    cluster-size = "3"
}

```
- If we open the modules folder we just again have the terraform files.
- Use the output from the module in the main part of your code:

```
output "some-output" {
value = "${module.module-example.aws-cluster}"
}

```


# 2.5 Templates Provider :

- The template provider can help creating customized configuration files
- You can build templates based on variables from terraform resource
attributes (e.g. a public IP address)
- The result is a string that can be used as a variable in terraform
        - The string contains a template
        - e.g. a configuration file
- Can be used to create generic templates or cloud init configs
- In AWS, you can pass commands that need to be executed when the
instance starts for the first time
- In AWS this is called "user-data"
- If you want to pass user-data that depends on other information in
terraform (e.g. IP addresses), you can use the provider template