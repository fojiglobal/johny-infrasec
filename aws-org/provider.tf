#### Define the required provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket         = "johnyd-cs2-terraform"
    key            = "aws-org/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "cs2-terraform-state-lock"
  }
}

##### Configure the AWS Provider
provider "aws" {
  region  = local.use2a
  profile = "jonasfost-882842173177"
}
