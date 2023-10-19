# Tuto IRSA misconfiguration
This repo contains the necessary source code to set up your environment to follow the tutorial.
This contains the script, the cloud formation template, and the example of illegally accessing AWS services. The dangers of EKS irsa misconfigurations in aws.
## local dependency
Make sure you have installed kubectl, terraform and aws cli.
* kubectl on macosx
```shell
brew install kubernetes-cli
```
* terraform on macosx
```shell
brew install terraform
```

* aws cli on macosx
```shell
brew install awscli
```
## Create User with any permissions(can access only to aws console)
[Click here to access to aws console](https://us-east-1.console.aws.amazon.com/iamv2/home?region=us-east-1#/users)
![create aws user](images/aws-user.png)
## Create the GitHub OIDC(for GitHub actions users)
Use the [github-oidc.yaml](templates/github-oidc.yaml) to create GitHub Actions IAM role. This cloudformation template give a full admin access(Not recommended).
[cloudformation aws console](https://us-east-1.console.aws.amazon.com/cloudformation/home?region=us-east-1)
## Create IAM admin role(for local users)
Use the [admin-role.yaml](templates/admin-role.yaml) to create Admin IAM role that test user will use. This cloudformation template give a full admin access(Not recommended).
[cloudformation aws console](https://us-east-1.console.aws.amazon.com/cloudformation/home?region=us-east-1)
## Create IAM readonly role
Use the [test-role.yaml](templates/test-role.yaml) to create describe eks IAM role that test user will use. This cloudformation template give only access to kubeconfig eks.
[cloudformation aws console](https://us-east-1.console.aws.amazon.com/cloudformation/home?region=us-east-1)
## Execute script set up the readonly user to assume the two roles
Create an access key and secret key for the test only. Copy the access key and secret key to configure aws cli.
Run the following command
```shell
aws configure
```
copy and paste the access key type enter. Keep all the remaining as default.
copy and paste the secret key type enter.
## Update your terraform code accordingly
Make the necessary changes in the [variables file](variables.tf) accordingly. Base on the name you choose for the role 
## Push to deploy it(GitHub actions users)

## Terraform apply for local users

## create a readonly kubeconfig file

## Access denied to secret through aws console

## Access denied to secret through aws cli

## Get database secret through aws pod

## Change database data.
