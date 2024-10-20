#### Define the required provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket         = "johny-cs2-terraform"
    key            = "qa/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "cs2-terraform-state-lock"
  }
}

##### Configure the AWS Provider
provider "aws" {
  region = local.use2a
}
