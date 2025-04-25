terraform {
  required_version = ">= 1.11.4"

  backend "s3" {
    bucket         = "myproject-tfstate"
    key            = "bastion/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "myproject-tfstate-lock"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.95.0"
    }
  }
}

provider "aws" {
  region = var.region
}