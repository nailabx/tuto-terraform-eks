terraform {
  backend "s3" {
    encrypt = true    
    bucket = "nailabx-tuto-state"
    dynamodb_table = "nailabx-tuto-state"
    key    = "temp-eks/terraform.tfstate"
    region = "us-east-1"
  }
}