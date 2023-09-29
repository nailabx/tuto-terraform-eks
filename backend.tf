terraform {
  backend "s3" {
    encrypt = true    
    bucket = "nailabx-gitlab-state"
    dynamodb_table = "nailabx-gitlab-state"
    key    = "temp-eks/terraform.tfstate"
    region = "us-east-1"
  }
}