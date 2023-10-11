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
  cloud {
    organization = "Terraform-Beginner-Bootcamp-ITPhil"

    workspaces {
      name = "terra-house-ITPhil"
    }
  }
  

}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token = var.terratowns_access_token
}

/*module "home_rockhard_hosting" {
  source ="./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  // bucket_name = var.bucket_name
  public_path = var.rockhard.public_path
  content_version = var.rockhard.content_version
  // error_html_filepath = var.error_html_filepath
  // index_html_filepath = var.index_html_filepath
  // assets_path = var.assets_path  
  
}

resource "terratowns_home" "home_rockhard" {
  name = "Rock Hard!"
  description = <<DESCRIPTION
For all rock fans around the world. Keep on rocking!
DESCRIPTION
  domain_name = module.home_rockhard_hosting.domain_name
  //domain_name = "3fdq3gz.cloudfront.net"
  town = "melomaniac-mansion"
  content_version = var.rockhard.content_version
}*/

module "home_healthfood_hosting" {
  source ="./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  // bucket_name = var.bucket_name
  public_path = var.healthfood.public_path
  content_version = var.healthfood.content_version
  // error_html_filepath = var.error_html_filepath
  // index_html_filepath = var.index_html_filepath  
  // assets_path = var.assets_path
}

resource "terratowns_home" "home_healthfood" {
  name = "Healthy Food!"
  description = <<DESCRIPTION
Good delicious food, and it's healthy too!
DESCRIPTION
  domain_name = module.home_healthfood_hosting.domain_name
  //domain_name = "3fdq3gz.cloudfront.net"
  town = "cooker-cove"
  content_version = var.healthfood.content_version
}