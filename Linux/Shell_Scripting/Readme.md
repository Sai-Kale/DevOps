# Shell Scripting Basics

## 


# Automation Scenarios:

## Specical Variables:

1. $# : The number of arguments supplied to a script.
2. $? : The exit status of the last command executed.
3. $0 : The filename of the current script.
4. $* : All the arguments are double quoted. If a script receives two arguments, $* is equivalent to $1 $2.
5. "$@" : All the arguments are individually double quoted. If a script receives two arguments, $@ is equivalent to $1 $2.
6. $$ : The process ID of the current shell. For shell scripts, this is the process ID under which they are executing.

https://stackoverflow.com/questions/22589032/what-is-the-difference-between-and (diff b/ $* and $@)

- Files that are older than 10 days(mtime) and ignoring hidden files(-not -path) and only the first directory(max depth) not recursively. **find /home/saikumar/ -maxdepth 1  -not -path "/home/saikumar/.*" -type f -mtime +10**

## Commands most used in general:

1. sed -n '1,3'p test.sh ---> prints 1 to 3 lines
2. awk '{print}' test.sh --> prints the whole file
3. awk '/Manager/{print}' test.sh ---> prints lines with the manager key word.
4. aws -F'[.]''/^version/{print $1"."$2"."$3"."$4+1}' test.sh version=20.1.2.3 --> incrememnts the version
5. sed -i 's/ten/twnety/g' test.sh --> replace a value in a file.

- Note: below scenarios commands might not work just for representation purpose.

## Scenarios 1( if-else blcok with JFrog Rest API):

- JFrog is repo where the container images or jar/var files are stored.

```sh

CICD=true
WORKSPACE=/apps/opt/users
JOB_BASE_NAME=Test_demo
if [[ $CICD == true ]]
then
echo "CI/CD pipeline is check"
file="${WORKSPACE}/html/basic_report.html"
REPORTNAME=${JOB_BASE_NAME}_${BUILD_NUMBER}.Test_Demo_10
echo "CICD Check Starting"
if [ -f "$file" ]; then
    echo "test repo found sending to artifacrtory"
    curl -H X-JFrog-Art-Api:Token -T $file https://oneartifactorycloud/artifactory/CICD/reprts/$REPORTNAME.html  ## -T (target file)  , -H (passing headers like passwd), X (for token)
else
    echo "testRepo is not found"
fi
fi

```

## Scenarios 2(For Loop with JIRA Rest API):
 
```sh


for ip in $(cat ip.txt)  # content is ip.txt --> 192.168.5.2 like that so many Ips
do
    curl -u GITLAB:Token -X PUT --data '{"update":{"lables":[{"add":""$TEAMNAME-$version""}]}}' --header "Content-Type: application/json" https://jira.com/rest/api/2/issue/2341
    curl -u GITLAB:Token -X PUT --data '{"update":{"comment":[{"add":{"body":""$version""}}]}}' --header "Content-Type: application/json" https://jira.com/rest/api/2/issue/$line
    echo "name read from file - $line"
done

```

## Scenarios 3(Array declaration to check the jar process):

```sh

#!/bin/bash

array=(helloservice hiservice nameserive mgrservice)
for line in "${array[@]}"
do
    COUNT=`ps -ef | grep $line | grep -v grep | wc -l` 
    MAX=2
    echo $line
    echo $COUNT
        if [ $COUNT -gt $MAX]
        then
            echo $line
            PROCS=`ps -ef | grep $line | grep -v grep | awk '{print $2,$11,$12,$13}' | sort -k 4`
            JAR=`echo "${PROCS}" | awk -F"-Djar_name=| " '{print $5}'`
            echo $JAR
            JAR_RUN=`echo $JAR | sed 's//,/g'`
            echo $JAR_RUN
            cd /apps/nnos/vzoomega/scripts
            ./mail.sh $line $JAR_RUN $COUNT

        fi
done

```

## Scenarios 4(Archive the data with find/mtime/tar/name command)
 
```sh

find . -type f -mtime +7 -exec mv '{}' /apps/logs/Log_Backup \;  #content older than 7 days
cd /apps/logs/Log_Backup
find /apps/logs/Log_Backup -type f -name '*log*' > include-file #include all the file names having .log in it in include-file
tar -cvf $(hostname)_$(date).tar.gz -T include-file #compressing all the tar files.

find  -type f -name '*log*' -exec rm -rf {} \; # removing all the log files now
find -type f -mtime +3 -name '*.tar.gz' -exec rm '{}' \;   #remove all the tar files older than 3 days
exit

```



