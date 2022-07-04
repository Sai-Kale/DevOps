# IAM:

- We can talk to AWS using the AWS CLI, API(programmatic access), Console.
- Whenever we talk to AWS we basically authenticate using AWS IAM.
- There can be few expecptions where we can directly talk to AWS resource ex: S3 bucket to an anonymous user.
- Whever we perform an operation on AWS resources. A request context is formed. Where it verifies  whether the prinicpal(the one requesting the operation) has the authentication and authorization.
- Authorization is done via the IAM policies called Identity Based Policies(Applied to users and roles) and Resource Based Policies(Applied to AWS resources ex:S3 bucket)

![alt text](imgs/iam1.PNG "")

## Overview of Uers, Groups, Roles and Policies:

![alt text](imgs/iam2.PNG "")

- A Group bascially consists of one or more users.
- Then we can apply a policy to the group. The user gains the permissions attached to group via policy.
- Policies can be attached directly to a user or a group.
- Roles are used for delegation and they are assumed.

### Users:

- 