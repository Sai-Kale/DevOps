![alt text](imgs/ci_cd.PNG "")

# DOCKER_BASICS:

![alt text](imgs/docker1.PNG "")

- Docker uses a client-server architecture. Client is nothing but where we install the docker application. This becomes the docker host.
- docker build will convert the file into an image
- docker pull will pull the image from the registry
- docker run will run the image as a container.

![alt text](imgs/docker2.PNG "")

- Docker image is a read only, inert template comes with the instructions for deploying containers.
- Docker image consists of collection of files (layers) that pack together all necessities - such as dependncies, source code and related libs.


- Dockerfile has (mutiple layers) set of commands do a certain task.

![alt text](imgs/docker3.PNG "")

```
FROM ubuntu:12.04   (base image and we can't have more than two from in a dockerfile; )

MAINTAINER Saikumar Kale <saikumar.aero@gmail.com>  (maintainer name can be declared here to know who developed these)

ENV USE_HTTP 0   (in ENV we can declare various env variables to pass certain values here USE_HTTP value is 0)

COPY ./setenv.sh /tmp/ (Docker copies just copied the shell script into the tmp folder)

# we have ADD as well . Difference between copy and add is  ADD allows <src> to be a URL and copies the content from the URL also ADD allows the source to be a zip file (Resources from remote URLs are not decompressed) and it unips the contents automatically to the destination withint the container. Docker recommends to use COPY so as when we want to copy the zip files we dont accidentally spill all the files open within the container.

RUN sudo apt-get update  

RUN sudo -E pip install scipy  :0.18.1 

RUN cd /usr/src/py; sudo python ./setup.py install 

#RUN helps us in installing software, dependencies, it can run any shell command inside the container.

EXPOSE 8888 (helps exposing the application port to the container port 888 which helps in communicating the outside world. )

ADD runcmd.sh / (Using ADD instead of COPY)

RUN chmod u+x /runcmd.sh 

CMD echo "hello from docker python" 

# Docker has a default entrypoint which is /bin/sh -c but does not have a default command. The ENTRYPOINT specifies a command that will always be executed when the container starts. The CMD specifies arguments that will be fed to the ENTRYPOINT.
# we can pass arguments via cli and entrypoint as well.

```

![alt text](imgs/docker4.PNG "")

- docker run -it -name c1 -d -p 82:80 ubuntu
(it mean interactive mode, name given to the container, d is detached runs in background, p is port mapping for docker application to the host port)

- docker exec -it c1 bash 
(we use exec to go into the container )

- docker commit c1 apache-on-ubuntu:1.0 
(to save the container data as new image)

- docker save apache-on-ubtunu:1.0 --output backup.tar 
(to save the image as tar)

- docker load -i backup.tar (to unzip the image from tar)

- docker start/stop/restart/push/pull (other docker commands)
- docker build Dockerfile

## Container States:

![alt text](imgs/docker5.PNG "")

- there are 5 states created, running,  restarting, exited , pause.
- create state containers are created by not started or consumed any cpu
- restarting state 4 restart policies that we can decide to use.
- exited when we container is terminated. No cpu and memory are consumed by the container.

## Docker Networking: 

![alt text](imgs/docker6.PNG "")

- Bridge : The default network driver. Bridge networks apply to the containers running on same docker daemon host.
- Host: For standalone containers, remove network isolation and use host's networking directly.
- overlay: overlay network connect multiple docker daemons together and enable swarm services to commuincate with each other.you can use overlay network to communicate b/w swarm and standalone container, or b/w two standalone containers on different docker daemons.
- Check the picture for more clarity.








######################################################## DOCKER COMMANDS #################################

# Docker Compose Basics

## Assignment Compose CLI Basics

cd sample-02

docker-compose up

ctrl-c

docker-compose down

docker-compose up -d

docker-compose ps

docker-compose logs

docker-compose exec web sh

curl localhost

exit

(edit Dockerfile, and add RUN apk add --update curl)

docker-compose up -d

docker-compose up -d --build

docker-compose exec web sh

curl localhost

exit

docker-compose down

#Docker Node Best Practices
#
-> COPY , not ADD
-> npm/yarn to install during the build, use anything as per your comfort but better to use npm
-> CMD node, not npm( npm requires another app to run, instead of node running it runs as node as sub process of npm)
	not as literal as in Dockerfile, doesnt work well with the init or PID 1 process ex:with SIGKILL etc)


#Base Image Guidelines
#
-> Stick to Even Numbered major release
-> Dont use: latest tag
-> All images on docker hub these day default on the base debain i.e you get apt pkg mgr
-> start with debian while migrating (debian will have more os dependencies & heavy image)
-> Move to Alpine later (alpine is very small base image)
-> Dont use slime or on-build

#When to use Debian, Alpine or Something Else
-> Alpine is securtiy focused & small
-> But debain/ubuntu are smaller now too
-> ~100 MB space savings isnt signiicant
-> Alpine has its own issues
-> Alpine CVE scanning fails
-> Enterprise may require CentOS or Debian or Ubuntu


# Making the use of offical centos/redhat image and install node js to create a node js image
#
-> Install Node in the offical centos image
-> Copy Dockerfile lines from  the node:14
-> Use ENV to specify a node version
-> this will take a few tries
-> Useful for knowing how to make ur own node, but only if you have to

#Least Privilege: using node user
-> Official Node Images have a node user
-> But its not used by default
-> DO this after apt/apk and npm i -g
-> Do this before npm i
-> May cause permissions issue with write access
-> May require chown node:node

#Change user from root to node for least privilege user:
>USER node (creates the user node and try creating stuff with that user)
>WORKDIR always creates folders with root permission 
>Work around is to use RUN mkdir app && chown node:node . (installs the npm in the app dir as the node will have the perms now)
> if you want to login into docker shell as root bypassing node user (docker-compose exec -u root)

#Making efficient Images
-> pick proper FROM
-> Line order matters
-> Least changing lines put em up on the top
-> for node there would be atleast two copy lines
	1) Copy only the package and lock files
	2) then run the npm install and 
	3) then copy everything else
-> In the copy command put an astreik* at the end this says docker copy if its there else ignore so that the build doesnt fail
	COPY package.json package-lock.json* ./
-> always pin install pkg managers atop in Dockerfile and use specific versions if possible


#Node Process Mgmt, Correcting Lifetime events in Container, Properly replacing nodes, Correcting Node assumptions
->  CMD command at the end of Dockerfile is important 
-> One nom/node problm is They dont listen for the proper shutdown signal by default

#PID 1 problem
-> Init or PID 1 process has two responsobilites i.e reap zombie process & pass signlas to sub process
-> Zombie is not that big node issue
-> Focus on proper node shutdown
-> Proper CMD for node shut down .
-> Docker uses 3 different signals to stop app (SIGINT/SIGKILL/SIGTERM)
-> SIGINT/SIGTERM allow a graceful shutdown
-> npm doesnt respond to these signals
-> node doesnt repond by default,ut can be done via code.
-> Docker provides a backup INIT process


################################################################################
