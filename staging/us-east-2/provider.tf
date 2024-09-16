#### Define the required provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket = "johny-cs2-terraform"
    key    = "staging/terraform.tfstate"
    region = "us-east-2"
  }
}

##### Configure the AWS Provider
provider "aws" {
  region = var.use2
}