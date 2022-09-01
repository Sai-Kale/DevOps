## CI/CD:

![alt text](imgs/j1.png "")


1. Build Tool (maven):

- Install java (sudo amazon-linux-extras install java-openjdk11)
- Install maven
    - https://maven.apache.org/install.html
    - https://maven.apache.org/download.cgi

![alt text](imgs/maven1.png "")

- sample spring boot code:
    - https://github.com/Sai-Kale/springboot-hello.git  (sringboot_hello)
    - https://github.com/Sai-Kale/springboot-webapplication.git (springbootwebapplication)
- Maven Basics (https://github.com/Sai-Kale/springboot-webapplication.git)

2. Sonarqube (Build, Code Quality & Analysis Tool):

![alt text](imgs/sonar.png "")
- Install Sonarqube:
    - we need atleast 3 GB of ram (t3.medium)
    - docker run -d --name sonarqube -p 9000:9000 <image_name>
    - clone the repo (https://github.com/Sai-Kale/realtime-project-demo.git)
    - Sonar- Maven Integration (https://docs.sonarqube.org/latest/analysis/scan/sonarscanner-for-maven/)

    - get the sonar command from the sonarqube UI (mvn clean verify sonar:sonar   -Dsonar.projectKey=java   -Dsonar.host.url=http://35.76.107.24:9000   -Dsonar.login=sqp_49df4988939d66b3a85fa1243144be7931774175 )
    - change the code and see if the sonarqube fails or not (System.out.println("get customers is called by getcustomers"))
    /home/ec2-user/realtime-project-demo/src/main/java/com/cloudtechmasters/realtimeprojectdemo
- Integrate Sonarqube and PostgreSQL:
    - https://medium.com/aleph-universe/setup-a-sonarqube-instance-in-less-than-30-minutes-cbc665ea9814

3. Nexus repo:
    - create new t3.medium
    - https://ahgh.medium.com/how-to-setup-sonatype-nexus-3-repository-manager-using-docker-7ff89bc311ce
    - now make maven to send artifacts to nexus repo
    https://www.baeldung.com/maven-deploy-nexus
    ```
    
   <Repository>
      <id>nexus-releases</id>
      <url>http://35.72.182.74:8081/repository/maven-releases/</url>
   </Repository>
   <snapshotRepository>
      <id>nexus-snapshots</id>
      <url>http://35.72.182.74:8081/repository/maven-snapshots/</url>
   </snapshotRepository>

   ```
   - now when we do mvn deploy it fails as it doesnt have the credentials declared anywhere. declare those in settings.xml in mvn conf file.
   ```
   <servers>
   <server>
      <id>nexus-snapshots</id>
      <username>admin</username>
      <password>admin</password>
   </server>
    </servers>
    ```
    - this should pusht the artifacts to the nexus repo.

4. **Integration with Jenkins**

![alt text](imgs/jenkins.png "")
```
$ sudo mkdir -p /var/jenkins_home

$ sudo chown -R 1000:1000 /var/jenkins_home/

$ docker run -p 8080:8080 -p 50000:50000 -v /var/jenkins_home:/var/jenkins_home --name jenkins -d jenkins/jenkins:lts

```
- install maven 
-  sudo docker exec -u root -t -i [container-id] bash
- apt-get update & apt-get install
- export PATH=/usr/share/maven/bin/conf:$PATH
- in jenkins global tool configuration add maven installation path
- maven (/usr/share/maven/)
- add a github webhook to trigger the build. (https://www.blazemeter.com/blog/how-to-integrate-your-github-repository-to-your-jenkins-project)
- in the plugins install the maven integration and the in the jobs maven project keeps showing.

5. **CI/CD** :

- Build docker images and push to AWS ECR.

![alt text](imgs/jenkins1.png "")

- create  a java server along with maven and integrate sonar.
- git clone https://github.com/Sai-Kale/springboot-maven-micro
- Sonar- Maven Integration (https://docs.sonarqube.org/latest/analysis/scan/sonarscanner-for-maven/)

- **Dockerfile to create docker image**
```
FROM java:8
COPY target/springboot-maven-micro*.jar app.jar
ENTRYPOINT ["java","-jar","app.jar"]
```

- now setup the ECR by giving the ECR isntance role to the EC2 instance.
- once its working create a CD server by giving the ECR instance role and install docker and aws cli2.
- then try and run the container from ECR in the local to check if its working fine.
- docker container run --name=container_name -p 8080:8080 -d 436771193637.dkr.ecr.ap-northeast-1.amazonaws.com/java_image:latest
- ip:8080/course-svc/getAllDevopsTools

6. Jenkins CI/CD:


