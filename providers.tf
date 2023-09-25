terraform {
#    backend "remote" {
#    hostname = "app.terraform.io"
#    organization = "Terraform-Beginner-Bootcamp-ITPhil"
#
#    workspaces {
#      name = "terra-house-ITPhil"
#    }
#  }
#
#  cloud {
#    organization = "Terraform-Beginner-Bootcamp-ITPhil"
#
#    workspaces {
#      name = "terra-house-ITPhil"
#    }
#  }
  
  required_providers {
#    random = {
#      source = "hashicorp/random"
#      version = "3.5.1"
#    }
        aws = {
      source = "hashicorp/aws"
      version = "5.17.0"
    }
  }
}

provider "aws" {
  # Configuration options
}

provider "random" {
  # Configuration options
}