terraform {
  cloud {
    organization = "pitt412"

    workspaces {
      name = "oct-31-lab"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}