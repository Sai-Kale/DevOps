# KUBECTL COMMANDS:

- kubectl run nginx --image nginx
  (Deploys a docker container nginx but where does it get the image from hence we need to specify the image name. By default it gets from docker hub.)
- kubectl create -f pod-definition.yml 
  (creates a sample yml file for the pod creation)
- kubectl get pods
  (gets the information about the list of current running pods)
- kubectl describe pod {pod_name}
  (describes the infirmation relavant to that pod.)

# K8S YAML:

- Each and every yaml file within the k8s always contains 4 top level feilds.
  apiVersion:
  kind:
  metadata:
  spec:
- Depending upon the kind, apiVersion is defined. these are just **strings**
  ex: Pod  -> v1
      Service -> v1
      ReplicaSet -> apps/v1
      Deployment -> apps/v1
- Metadata is the data about the object. Its in the form of a **dictionary**. 
  we can have any number of lables for a given object.
  Ex: metadata:
        name: myapp-prod
        lables: 
          app: myapp
          version: v1
          type: frontend
- spec is where we give the container information. these are in the form of **list/array**
  Ex: spec:
        containers:
          - name: nginx-frontend   (here the "-" represents the first element in the list, as we can mention mutiple images and mutiple container will be spun up with in the POD)
            image: nginx  
