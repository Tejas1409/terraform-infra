terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "tejas-terraform-state-12345"
    key            = "qa/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}

provider "aws" {
  region = "ap-south-1"
}

module "vpc" {
  source        = "../../modules/vpc"
  vpc_cidr     = "10.0.0.0/16"
  subnet_cidr  = "10.0.1.0/24"
  az           = "ap-south-1a"
  name         = "qa-vpc"
  env          = "qa"
}

module "ec2" {
  source         = "../../modules/ec2"
  ami            = "ami-0f58b397bc5c1f2e8"
  instance_type  = "t2.micro"
  subnet_id      = module.vpc.subnet_id
  vpc_id         = module.vpc.vpc_id
  name           = "qa-ec2"
  env            = "qa"
}
