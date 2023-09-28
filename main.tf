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

module "terrahouse_aws" {
  source ="./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
  error_html_filepath = var.error_html_filepath
  index_html_filepath = var.index_html_filepath
  content_version = var.content_version
}
