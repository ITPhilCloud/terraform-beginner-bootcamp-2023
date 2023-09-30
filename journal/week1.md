# Terraform Beginner Bootcamp 2023 - Week 1

## Fixing Tags

[How To Delete Local and Remote Tags on Git](https://devconnected.com/how-to-delete-local-and-remote-tags-on-git/)


Locally delete a tag.

```sh
$ git tag -d <tag_name>
```

Remotely delete a tag.

```sh
$ git push --delete origin tagname
```

Checkout the commit that you want to retag. Grab the sha from your Github history. 

```sh
git checkout <SHA>
git tag Major.minor.patch
git push --tags 
git checkout main
``` 

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


## Terraform Locals

Locals allow us to define local variables. It can be very useful when we need to transform data into another format and have it referenced as a variable.


```tf
locals {
    s3_origin_id = "MyS3Origin"
}

```

[Terraform Local Values](https://developer.hashicorp.com/terraform/language/values/locals)

## Terraform Data Sources 

This allows us to source data from cloud resources.

This is useful when we want to reference cloud resources without importing them.

```tf
data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
```

[Terraform Data Sources](https://developer.hashicorp.com/terraform/language/data-sources)


## Working with JSON

We use the jsonencode Function to create the json policy inline in the hcl.

```tf
> jsonencode({"hello"="world"})
{"hello":"world"}
```
[Terraform jsonencode Function](https://developer.hashicorp.com/terraform/language/functions/jsonencode)


### Changing the Lifecyle of Resources

[Terraform Meta-Argument Lifecycle](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle)

## Terraform Data

Plain data values such as Local Values and Input Variables don't have any side-effects to plan against and so they aren't valid in replace_triggered_by. You can use terraform_data's behavior of planning an action each time input changes to indirectly use a plain value to trigger replacement.

```tf
resource "terraform_data" "content_version" {
  input = var.content_version
}
```

[The terraform_data Managed Resource Type](https://developer.hashicorp.com/terraform/language/resources/terraform-data)

## Provisioners

Provisioners allow you to execute commands on compute instances, eg. AWS CLI command.

They are not recommended for use by Hashicorp because configuration management tools such as Ansible are a better fit, but the functionality exists.  

[Terraform Provisioners](https://developer.hashicorp.com/terraform/language/resources/provisioners/syntax)

### Local-exec

This will execute a command on the machine running the Terraform commands, eg. init, plan, apply

```tf
resource "aws_instance" "web" {
  # ...

  provisioner "local-exec" {
    command = "echo The server's IP address is ${self.private_ip}"
  }
}
```

[local-exec Provisioner](https://developer.hashicorp.com/terraform/language/resources/provisioners/local-exec)


```sh
gitpod /workspace/terraform-beginner-bootcamp-2023 (33-invalidate-cloudfront-distribution) $ tf apply --auto-approve
```

gives error:

module.terrahouse_aws.terraform_data.invalidate_cache (local-exec): /bin/sh: 2: --distribution-id: not found
╷
│ Error: local-exec provisioner error
│ 
│   with module.terrahouse_aws.terraform_data.invalidate_cache,
│   on modules/terrahouse_aws/resource-cdn.tf line 124, in resource "terraform_data" "invalidate_cache":
│  124:   provisioner "local-exec" {
│ 
│ Error running command 'aws cloudfront create-invalidation \ 
│ --distribution-id E3JF6HRBJO695L \
│ --paths '/*'
│ ': exit status 127. Output: Warning: Input is not a terminal (fd=0).
│ 
│ 
│ /bin/sh: 2: --distribution-id: not found
│ 
╵
A simple rerun resolved the issue.


### Remote-exec

This will execute a command on a machine which you target. You will need to provide credentials such as ssh to get into the machine.

```tf
resource "aws_instance" "web" {
  # ...

  # Establishes connection to be used by all
  # generic remote provisioners (i.e. file/remote-exec)
  connection {
    type     = "ssh"
    user     = "root"
    password = var.root_password
    host     = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "puppet apply",
      "consul join ${aws_instance.web.private_ip}",
    ]
  }
}

```

[remote-exec Provisioner](https://developer.hashicorp.com/terraform/language/resources/provisioners/remote-exec)


## For Each Expressions 

For Each allows us to iterate over complex data types

```sh
[for s in var.list : upper(s)]

```

This is useful when you are creating multiples of a cloud resource and you want to reduce the amount of repetitive terraform code.

[for Expressions](https://developer.hashicorp.com/terraform/language/expressions/for)