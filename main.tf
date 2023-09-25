# My first change
# My second change using Gitpod

# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string
#resource "random_string" "bucket_name" {
#  lower = true
#  upper = false
#  length   = 32
#  special  = false
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
