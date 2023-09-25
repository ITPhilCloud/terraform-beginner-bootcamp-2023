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

## Terrafrom and Input Variables
### Terrafrom Cloud Variables

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


