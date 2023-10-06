# My first change
# My second change using Gitpod

# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string
#resource "random_string" "bucket_name" {
#  lower = true
#  upper = false
#  length   = 32
#  special  = false
#}

terraform {
    required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
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
  

}

provider "terratowns" {
  endpoint = "http://localhost:4567/api"
  user_uuid="e328f4ab-b99f-421c-84c9-4ccea042c7d1"
  token="9b49b3fb-b8e9-483c-b703-97ba88eef8e0"
}


#module "terrahouse_aws" {
#  source ="./modules/terrahouse_aws"
#  user_uuid = var.user_uuid
#  bucket_name = var.bucket_name
#  error_html_filepath = var.error_html_filepath
#  index_html_filepath = var.index_html_filepath
#  content_version = var.content_version
#}
