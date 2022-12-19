# HELM:

- Why Helm ? suppose if we have a microservice deployment there are multiple yamls that needs to be configured and maintaing all of them can be cumbersome.
- All these files are static and cant recive param dynamically. 
- We need consistencty when we need to update those files. If someone makes a direct change of the cluster instead of the yaml file using kubectl command
- Revision history of all the changes that are being made.

- What is Helm ? similar to npm and yum on the linux. this will pkg and install the software for us.
- it is one such pkg mgr for k8s.
- it will have the entire configuration to pull and install a microservice.
- these are done with the help of commands and helm pulls it from the repositoy which is within the org for private or from internet for public.
- if you want to do a upgrade u can use (helm upgrade)
    - helm install (installs the charts)
    - helm upgrade
    - helm rollback (if you want to rollback to a previous version)
    - helm uninstall 


- Advantages of helm ? It simplfies the k8s depolyment process by reducing complexities.
- helm maintains the revision history.
- we can have the dynamic configuration. In the values.yaml helm maintains this.
- helm maintains the consistency.
- It does the intelligent deployments. It knows the order in which the yaml needs to be deployed.
- Helm has life cycle hooks for the work not related to the k8s but has be done like writing data to DB.
- Helm has inbuilt support for security the charts can be signed using cryptography and hashes can be generated when we pull from central repo helm will verify the hash to make sure its from the expected repo.


- Helm uses the concept of charts. 
- bitnami has helm repo of different charts.