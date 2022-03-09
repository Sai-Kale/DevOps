# KUBECTL COMMANDS:

- kubectl run nginx --image nginx
  (Deploys a docker container nginx but where does it get the image from hence we need to specify the image name. By default it gets from docker hub.)
- kubectl run nginx --image=nginx --dry-run=client -o yaml
  (Generate POD Manifest YAML file (-o yaml). Don't create it(--dry-run))
- kubectl create -f pod-definition.yml 
  (creates a sample yml file for the pod creation)
- kubectl get pods
  (gets the information about the list of current running pods)
- kubectl describe pod {pod_name}
  (describes the infirmation relavant to that pod.)
- kubectl apply -f pod.yml
  (applies the pod.yml definition)
- kubectl edit pod nginx
  (Helps edit the current running pod details)
- kubectl replace -f replicaset-def.yml
  (replace the replicaset-def.yml file with new one)
- kubectl scale --replicas=6 -f replicaset-def.yml
  (scale the current replicaset with more replicas directly via command line)
- kubectl get deploymens 
  (lists all the deployments that are created)
- kubectl get all
  (lists all the pods, replicasets and deployments.)
- kubectl create deployment --image=nginx nginx
  (Create a deployment)
- kubectl create deployment --image=nginx nginx --dry-run=client -o yaml
  (Generate Deployment YAML file (-o yaml). Don't create it(--dry-run))
- kubectl create deployment --image=nginx --replicas=4 nginx --dry-run=client -o yaml > nginx-deployment.yaml
  (Generate Deployment YAML file (-o yaml). Don't create it(--dry-run) with 4 Replicas (--replicas=4))
  Note: Save it to a file, make necessary changes to the file (for example, adding more replicas) and then create the deployment.
  kubectl create -f nginx-deployment.yaml
- kubectl get pods -n default
  (get pods corresponding to default namespace)
- kubectl create -f pod-definitio.yml --namespace=dev
  (creats the pod in dev namespace instead of default)
- kubectl config set-context $(kubectl config current-context) --namespace=dev
  (change the default namespace)
- kubectl get pods --all-namespaces
- kubectl get services

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
          - name: busybox
            image: busybox    

## Pod:

- Pod is the smallest unit within a k8s cluster inside which one or more containers can run.
- refer to the pod_example.yml on how to spin up a container using the pod based yaml.
        
## ReplicaSet:

- replicaset is kind inside yaml when specified min and max ranges.
- the min number of pods will be avaiable at all the time. when the traffic increases it may go up to the max number mentioned.
- helps in HA and distributes traffic across mutiple pods.
- Refer replicaset_example.yml for yaml file.
- Here we see that under the template section we place the definition of pod. However, all the pods with relavant selectors like name are placed under this replicaset.
- One might get a doubt whats the use of mentioning if replica set matches the pod using lables and selector. consider a secnario where one pod dies , so that replica set should know what pod and container needs to be spun up hence the template definition is mandatory.
- In order to increase the number of replicas  just edit the yml file with increased number of replicas number and run - kubectl replace -f replicaset-definition.yml

## Deployments: 

- When we want to upgrade our cotainer image from v1 to v2 , we want to upgrade the same seamlessly.
- however, we dont one to upgrade allo of them at once, so that users might face some issues.
- we need to implement a strategy to update one by one using rolling updates.
- All of these capabilites are done using k8s deployments.
- Deployments yaml is same a replicaset instead use the kind as Deployment.


**Deployments > ReplicaSets > Pod**


## Services :

- the service and mutiple pods under it are matched using the lables and selectors. check them in the yaml files.
- the service by the nature itself distributed across multiple nodes.
  - ClusterIP
  - Nodeport 
  - LoadBalancer
  