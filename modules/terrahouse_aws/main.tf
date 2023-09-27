
terraform{
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

#provider "aws" {
#  # Configuration options
#}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
resource "aws_s3_bucket" "website_bucket" {
  # Bucket Naming Rules
  # https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html?icmpid=docs_amazons3_console
  #bucket = random_string.bucket_name.result
  bucket = var.bucket_name

    tags = {
    UserUuid = var.user_uuid
  }
}