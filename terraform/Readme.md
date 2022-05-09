
# Terraform Cheat Sheet:

## Plan, Deploy & Clean Infrastructure: 

t = terraform 

- t apply --auto-approve (Apply changes without prompting to enter yes)
- t destroy --auto-approve  (Apply changes without prompting to enter yes o destroy the infra)
- t plan -out plan.out ( output the deployment plan to plan.out)
- t apply plan.out ( use the plan.out file to deploy infrstrcture)
- t plan -destroy ( output a detroy plan)
- t apply -target=aws_instance.my_ec2 (Only apply/deploy  changes to targted resource)
- t apply -var my_region_variable=us-east-1 (Pass a variable via command-line while applying a configuration)
- t apply -lock=true (lock the state file so it can't be modified by any other terraform apply or modification action)
- t apply refresh=false (Do not reconcile state file with real-world resources , help with large complex deployments for saving deployment time)
- t refresh ( reconcile the state in terrform state file with real-world resources)
- t providers ( get information about providers used in current configuration)

## Terraform Workspaces:

- t workspace new my_new_workspace
- t workspace select default
- t workspace list 

## terraform state manipulation

- t state show aws_instance.my_ec2 (show the details stored in the terraform state file for that rsource)
- t state pull > terraform.tfstate (downlad and output terraform state to a file)
- t state replace-provider hashicorp/aws registry.custom.com/aws ( replace the provider)
- t state list (list all the resources tracked in the state file)

## Terraform Import and Outputs:

- t import aws_instance.new_ec2_in-stance i-abcd1234 (Import ec2 instance with id i-abcd1234 into the terraform reousource named "new_ec2_instance" of type "aws_instance"
- t output (output vars as stated int the code)
- t output instance_public_ip (list a specfic declared output)
- t output -json  (print the output in the json format)

## Terraform tain & untaint :

- terraform taint aws_instance.my_ec2 (taint resource to be recreated on the next apply)
- terraform untaint aws_instance.my_ec2 (remove taint form a resource )
- t force-unlock LOCK_ID (force unlock a locked sate file)

## Terraform Cloud :

- t login (obtain and save APi token for terraform cloud)
- t logout 

## terraform graph:

- t graph | dot -Tpng > graph.png (produces a PNG diagram showing relationship and dependencies b/w terraform resources in your configuration/code)

## Terraform CLI tricks:

- t install-autocomplete (setup auto completion, requires logging back in)

## Format and validate the terraform code:

- terraform fmt (format code as per the tf canonical format)
- t validate (validate code of the syntax)
- t validate validate -backend=false (validate code skip backend validation)

## Intialize Terraform Directory:

- t init (intialize a directory, pull down providers )
- t init -get-plugins=false 
- t init -verify-plugins=false

## Otherss:

- t version
- t get -update-true (downlad and update modules in the root module)

## Terraform Console :

- echo "aws_instance.my_ec2.public_ip: | terraform console  (display the my_ec2 instance public ip as present in the state file )
