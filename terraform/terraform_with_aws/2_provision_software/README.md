# 2.0 Software Provisioning :
 
- There are 2 ways to provision software on your instances
- You can build your own custom AMI and bundle your software with the image
        - Packer is a great tool to do this
- Another way is to boot standardized AMIs, and then install the software on it
you need
        - Using file uploads
        - Using remote exec
        - Using automation tools like chef, puppet, ansible
- the