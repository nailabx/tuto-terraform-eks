# Tuto IRSA misconfiguration
This repo contains the necessary source code to set up your environment to follow the tutorial.
This contains the script, the cloud formation template, and the example of illegally accessing AWS services. The dangers of EKS irsa misconfigurations in aws.
## local dependency
brew install mysql
## Create User without any permissions(can access to aws console)

## Create the GitHub OIDC(for GitHub actions users)

## Create IAM admin role(for local users)

## Create IAM readonly role

## Execute script set up the readonly user to assume the two roles

## Update your terraform code accordingly

## Push to deploy it(GitHub actions users)

## Terraform apply for local users

## create a readonly kubeconfig file

## Access denied to secret through aws console

## Access denied to secret through aws cli

## Get database secret through aws pod

## Change database data.
