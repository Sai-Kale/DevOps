# Terraform Commands :

- terraform apply   -> applies state
- terraform destroy   -> destroy the infra(use with caution)
- terraform fmt   -> rewrite terraform config files to canonical format and style
- terraform get    -> Downlaod and update the modules
- terraform graph -> Create a visual representation of config or execution plan
- terraform import [options] ADDRESS   -> Import will try and find the infrastructure resource identified with ID and import the state into 
                                            terraform.tfstate with resource id ADDRESS
- output [options] [NAME]     -> Output any of your resources. Using NAME will only output a specific resource.
- plan   -> terraform plan, show the changes to be made to the infrastructure
- push   -> Push changes to Atlas, Hashicorp’s Enterprise tool that can automatically run terraform from a centralized server
- refresh  -> Refresh the remote state. Can identify differences between state file and remote state
- remote  -> Configure remote state storage
- show -> Show human readable output from a state or a plan
- state -> Use this command for advanced state management, e.g. Rename a resource with terraform state mv aws_instance.example aws_instance.production
- taint  -> Manually mark a resource as tainted, meaning it will be destructed and recreated at the next apply
- validate  -> validate syntax
- untaint  -> undo a taint
