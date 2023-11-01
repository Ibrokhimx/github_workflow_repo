terraform {
  cloud {
    organization = "pitt412"

    workspaces {
      name = "infra-vpc"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source   = "./modules/vpc/"
  vpc_cidr = "10.0.0.0/16" #var.vpc_cidr
  prefix   = local.prefix
}

module "subnets" {
  source = "./modules/subnet/"
  dynamic = module.vpc.dynamics_vpc_id
  prefix = local.prefix
  subnets = {
    my_first_subnet_using_module = {
      cidr_block        = "10.0.1.0/24"
      availability_zone = "us-east-1c"
    }
    my-demo2-subnet = {
      cidr_block        = "10.0.2.0/24"
      availability_zone = "us-east-1a"
    }
    my-demo3-subnet = {
      cidr_block        = "10.0.3.0/24"
      availability_zone = "us-east-1b"
    }
  }
}

module "security" {
  source          = "./modules/security_groups"
  security_groups = var.security_groups
  vpc_id          = module.vpc.vpc_id
}