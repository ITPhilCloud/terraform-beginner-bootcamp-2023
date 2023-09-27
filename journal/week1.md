# Terraform Beginner Bootcamp 2023 - Week 1

## Root Module Structure

Our root module structure is as follows:

```
PROJECT_ROOT
|
├── main.tf            - everything else
├── variables.tf       - stores the structure of input variables
├── terraform.tfvars   - the data of variables we want to load into our Terraform project
├── providers.tf       - defines required providers and their configuration
├── outputs.tf         - store our outputs
└── README.md          - required for root modules
```

[Terraform Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)

## Terraform and Input Variables
### Terraform Cloud Variables

In Terraform we can set two kinds of variables:
- Environment Variables - those you would set in your bash terminal, eg. AWS credentials
- Terraform Variables - those that you would normally set in your tfvars file

We can set Terraform Cloud variables to be sensitive, so they are not shown visibly in the UI.


### Loading Terraform Input Variables

[Terraform Input Variables](https://developer.hashicorp.com/terraform/language/values/variables)

### var flag
We can use the `-var` flag to set an input variable or override a variable in the tfvars file, eg. `terraform -var user_id="my-user_id"`

### var-file flag
To set a larger number of variables, it is more convenient to specify their values in a variable definitions file (filename ending in either `.tfvars` or `.tfvars.json`), eg. `terraform apply -var-file="testing.tfvars"`.

A variable definitions file consists only of variable name assignments:

```
image_id = "ami-abc123"
availability_zone_names = [
  "us-east-1a",
  "us-west-1c",
]

```

[Terraform Variable Definitions (.tfvars) Files](https://developer.hashicorp.com/terraform/language/values/variables#variable-definitions-tfvars-files)


### terraform.tfvars

This is the default file to load in terraform variables in bulk. 

### auto.tfvars 

Terraform automatically loads a number of variable definitions files if they are present:

Files named exactly `terraform.tfvars` or `terraform.tfvars.json`. And also any files with names ending in `.auto.tfvars` or `.auto.tfvars.json`.

### Order of Terraform variables

Mechanisms for setting variables can be used together in any combination. If the same variable is assigned multiple values, Terraform uses the **last** value it finds, overriding any previous values.

Terraform loads variables in the following order, if present:

```
- The -var and -var-file options on the command line, in the order they are provided.

- *.auto.tfvars or *.auto.tfvars.json files, processed in lexical order of their filenames.

- terraform.tfvars.json file

- terraform.tfvars file

- Environment variables
```

[Terraform Variable Precedence](https://developer.hashicorp.com/terraform/language/values/variables#variable-definition-precedence)


## Dealing With Configuratin Drift

## What happens is we lose our state file?

If you lose your statefile, you most likely have to tear down all your cloud infrastructure manually.

You can use Terrafrom import, but it won't work for all cloud resources. You need to check the Terraform providers documentation for which resources support import.

### Fix Missing Resources with Terraform Import

`terraform import aws_s3_bucket.bucket bucket-name`

[Terraform Import](https://developer.hashicorp.com/terraform/cli/import)
[AWS S3 Bucket Import](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#import)

### Fix Manual Configuration

If someone deletes or modifies cloud resources manually through clickops, we run `terraform plan` to attempt to rectify our infrastructre, fixing configuration drift.

## Fix using Terraform Refresh

```sh
terraform apply -refresh-only -auto-approve
```
`Warning: This command is deprecated`


## Terraform Modules

### Terraform Module Structure

It is recommended to place modules in a `modules` directory when locally developing modules, but you can name it whatever you like. 

### Passing Input Variables

We can pass input variables to our module. 

The module has to declare the terraform variables in its own variables.tf

```tf
module "terrahouse_aws" {
  source ="./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
}
```


### Module Sources 

Using the source we can import the module from various places, eg.:

- locally
- Gtihub
- Terraform Registry


```tf
module "terrahouse_aws" {
  source ="./modules/terrahouse_aws"
}
```

[Modules Sources](https://developer.hashicorp.com/terraform/language/modules/sources)


## Consdirations when using ChatGPT to write Terraform

LLMs, such as ChatGPT may not be trained non the latest documentation or information about Terraform.
It may likely produce older examples that could be deprecated, often affecting providers.


## Setting S3 static website hosting options

After setting module configuration for S3 static website hosting, terraform plan command would thro an error: 

gitpod /workspace/terraform-beginner-bootcamp-2023 (27-s3-static-website-hosting) $ tf plan

│ Error: creating Amazon S3 (Simple Storage) Bucket (ubvpz8q6vyj9w1rxsidtrdluflsr639r): BucketAlreadyOwnedByYou: Your previous request to create the named bucket succeeded and you already own it.
│       status code: 409, request id: 3NF9Z2ZYW58AMHJQ, host id: Ml2a9Srit5N6gApo7HG4oajtkuGQD9IhTpf8yfc7WK9cw08aoNyYGBZvDICPqtRAFHiSWFzOEWY=
│ 
│   with module.terrahouse_aws.aws_s3_bucket.website_bucket,
│   on modules/terrahouse_aws/main.tf line 21, in resource "aws_s3_bucket" "website_bucket":
│   21: resource "aws_s3_bucket" "website_bucket" {

This was resolved by manually deleting S3 bucket and rerunning tf plan command.

## Working with Files in Terraform

### Fileexsists function

This is a build in Terraform function to check the existance of a file.

```tf
    condition     = fileexists(var.index_html_filepath)
```

[Terraform fileexists Function](https://developer.hashicorp.com/terraform/language/functions/fileexists)

## Filemd5

[Terraform filemd5 Function](https://developer.hashicorp.com/terraform/language/functions/filemd5)

### Path Variable

In Terraform there is a special variable called `path` that allows us to reference local paths:

- path.module = get the path for the current module
- path.root = get the path for the root module

[Special Path Variable](https://developer.hashicorp.com/terraform/language/expressions/references#filesystem-and-workspace-info)


```
# Upload the index.html file to the S3 bucket
resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"
  source = "${path.root}/public/index.html"
  etag = filemd5(var.index_html_filepath)
}
```


### Etags 

Etags help to detect file changes in the data, eg. if the contents of our index.html has changed  

[Etags](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/ETag)



