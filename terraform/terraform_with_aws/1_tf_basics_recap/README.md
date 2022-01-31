# 1. Terraform Basics

# 1.1 Infrastructure as Code (Iac) :

- Infrastructure as Code (IaC) is the managing and provisioning of infrastructure through code instead of through manual processes.
- With IaC, configuration files are created that contain your infrastructure specifications, which makes it easier to edit and distribute configurations. It also ensures that you provision the same environment every time.

![alt text](../imgs/Iac.JPG "Iac")

# 1.2 Terraform Installation :

```
mkdir terraform

wget https://releases.hashicorp.com/terraform/1.1.4/terraform_1.1.4_linux_amd64.zip

unzip terraform_1.1.4_linux_amd64.zip

export PATH=/Users/{user_name}/{terraform_path}/:$PATH
or push the unzipped terraform to /bin using sudo and give root priviliges.

```

# 1.3 Understanding Terraform :

# 1.4 AWS account setup : 

- set up the aws account to spin up the resources.


# 1.5 Terraform Variables:

- variables :  Input variables let you customize aspects of Terraform modules without altering the module's own source code
- types of variables : var, map, list, boolean etc.,..
```
mkdir terraform_test
cd terraform_test

vi main.tf
    variable "myvar" {
        type = string
        default = "hello terraform"
}

variable "mymap" {
        type = map
        default = {
                mykey = "my value"
        }
}

variable "mylists" {
        type = list
        default = [1,2,3]
}

var.myvar
"${var.myvar}"

var.mymap
var.mymap["mykey"]
"${var.mymap["mykey"]"

var.mylists
element(var.mylists, 1) #print the first element 
slice(var.mylists, 0, 2) #print the first two element

```

- Now we shall create a sample file to spin up aws instance

```
vi main.tf # enter below

provider "aws" {

}


resource "aws_instance" "example" {
        ami = var.AMIS[var.aws_region] or "${lookup(var.AMIS,var.aws_region)}"
        instance_type = var.instance_type
}

vi variables.tf #enter below

variable "aws_region" {
        type = string
}

variable "instance_type" {
        type = string
        default  = "t2.micro"
}

variable "AMIS" {
        type = map(string)
        default = {
                us-east-1 = "ami_id"
        }
}

vi terraform.tfvars #enter below

aws_region="us-east-1"

```

- These are very much updated in the latest versions of terraform. You can now have more control over the variables, and have for and
for-each loops, which where not possible with earlier versions.
- You don’t have to specify the type in variables, but it’s recommended
- types (string, number, boolean)

```
variable "a-string" {
type = string
}
variable "this-is-a-number" {
type = number
}
variable "true-or-false" {
type = bool
}
```
- We also have terraform complex types
    - list(type) : List: [0,1,5,2]
    - set(type) : A "set" is like a list, but it doesn’t keep the order you put it in, and can only contain unique values.
                 Ex: A list that has [5, 1, 1, 2] becomes [1,2,5] in a set (when you output it, terraform will sort it)
    - map(type) : Map: {"key" = "value"}
    - object(attr_name=type) : An object is like a map, but each element can have a different type. 
      Ex: {
            firstname = "John"
            housenumber = 10
        }
    - tuple : An tuple is like a list, but each element can have a different type. Ex: [0, "string", false]
- The most common types are list and map, the other ones are only used
sporadically
-   The ones you should remember are the simple variable types string,
number, bool and the list & map
- You can also let terraform decide on the type:
    Ex: variable "a-string" {
        default = "this is a string"
        }
        variable "this-is-a-list" {
        default = [ "list of", "strings" ]
        }

# 1.6 AWS Access key & Secret Key and different files in terraform:

- We should not keep all the stuff in one file.
- Use variables to hide secrets as it poses seurity threat. Us them as secrets in the CI tool .
- Use varaibles file for the stuff that might change and easy to re-use. DRY priniciple should be followed.
- 4 different files- provider.tf, main.tf, variables.tf, terraform.tfvars, data.tf, versions.tf