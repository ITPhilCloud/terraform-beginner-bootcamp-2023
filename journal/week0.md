# Terraform Beginner Bootcamp 2023 - Week 0

- [Semantic Versioning](#semantic-versioning)
- [Install the Terraform CLI](#install-the-terraform-cli)
  * [Considerations with the Terraform CLI changes](#considerations-with-the-terraform-cli-changes)
  * [Considerations for Linux Distribution](#considerations-for-linux-distribution)
  * [Refactoring into Bash Scripts](#refactoring-into-bash-scripts)
  * [Shebang Considerations](#shebang-considerations)
    + [Execution Considerations](#execution-considerations)
    + [Linux Permissions Considerations](#linux-permissions-considerations)
- [Gitpod Lifecycle](#gitpod-lifecycle)
- [Working with ENV vars](#working-with-env-vars)
  * [env command](#env-command)
  * [Setting and Ensetting Env Vars](#setting-and-ensetting-env-vars)
  * [Printing Env vars](#printing-env-vars)
  * [Scoping of Env vars](#scoping-of-env-vars)
  * [Persisting Env Vars in Gitpod](#persisting-env-vars-in-gitpod)
- [AWS CLI Installation](#aws-cli-installation)
- [Terraform Basics](#terraform-basics)
  * [Terraform Registry](#terraform-registry)
  * [Terraform Console](#terraform-console)
    + [Terraform Init](#terraform-init)
    + [Terraform Plan](#terraform-plan)
      - [Terraform Apply](#terraform-apply)
    + [Terraform Destroy](#terraform-destroy)
    + [Terraform Lock Files](#terraform-lock-files)
    + [Terraform State Files](#terraform-state-files)
    + [Terraform Directory](#terraform-directory)
- [Issues with Terraform Cloud Login and Gitpod](#issues-with-terraform-cloud-login-and-gitpod)

## Semantic Versioning

This project will utilize semnatic versioning for its tagging.
[semver.org](https://semver.org/)

The general format:

 **MAJOR.MINOR.PATCH**, eg. `1.0.1`

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

## Install the Terraform CLI
### Considerations with the Terraform CLI changes
The Terraform installation instructions have changed due to gpg keyring changes. So we needed to refer to the latest install CLI instructions via Terraform documentation and change the scripting for install.

[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Considerations for Linux Distribution

This project is built against Ubuntu. Please consider checking your Linux distribution and change accordingly to distribution needs. 

[How To Check OS Version in Linux](https://www.howtogeek.com/206240/how-to-tell-what-distro-and-version-of-linux-you-are-running/)

Example of checking OS Version:
```
$ cat /etc/os-release 
PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```


### Refactoring into Bash Scripts
While fixing the Terraform CLI gpg deprecation issues we noticed the bash script steps were a considerable amount more code. So we decided to create a bash script to install the Terraform CLI.

- This will keep the Task File ([].gitpod.yml](.gitpod.yml)) tidy.  
- This will allow us an easier to debug and execute manually Terraform CLI install
- This will allow better portability for other projects that need to install Terraform CLI.

This bash script is located here: [./bin/install_terraform_cli](./bin/install_terraform_cli)

### Shebang Considerations

A Shebang (pronounced Sha-bang) tells the bash script what program that will interpret the script, e.g `#!/bin/bash`

ChatGPT recommended we use this format for bash: `#!/usr/bin/env bash`

- for portability for different OS distributions
- will search the user's PATH for the bash executable

[Shebang (Unix)](https://en.wikipedia.org/wiki/Shebang_(Unix))

#### Execution Considerations
When executing the bash script we can use the `./` shorthand notation.

eg. `./bin/install_terraform_cli`

If we are using a script in gitpod.yml we need to point the script to a program to interpret it.

eg. `source ./bin/install_terraform_cli`

#### Linux Permissions Considerations 

In order to make our bash scripts executable we need to change linux permissions at the user mode.

```sh
chmod u+x ./bin/install_terraform_cli
```

alternatively:
```sh
chmod 744 ./bin/install_terraform_cli
```

[chmod wikipedia](https://en.wikipedia.org/wiki/Chmod)

## Gitpod Lifecycle

We need to be careful when using the Init because it will not rerun if we restart an existing workspace.

[Gitpod Tasks](https://www.gitpod.io/docs/configure/workspaces/tasks)


## Working with ENV vars

### env command

We cam list out all Environment Variables (ENV vars) using the `env` command.

We can filter specific Environment Variables using grep, eg. `env | grep AWS_` 

### Setting and Ensetting Env Vars

In the terminal we can set using `export HELLO=WORLD`

In the terminal we can unset using `unset HELLO`

We can set an Env var temporarily when just runnig a command.

```sh
HELLO='world' ./bin/print_message
```

Within a bash script we can set an Env var without writing export eg. 

```sh
#!/usr/bin/env bash

HELLO='world'

echo $HELLO
```

### Printing Env vars

We can print an Env var using echo eg. `echo $HELLO`

### Scoping of Env vars

When you open up new bash terminals in VSCode it will not be aware of Env vars that you have set in another window.

If you want Env vars to persist across all future bash teminals, you need to set Env vars in your bash profile, eg. `.bash_profile`

### Persisting Env Vars in Gitpod

We can persist Env vars in gitpod by storing them in Gitpod Secrets Storage.

```
gp env HELLO='world'
```

All future workspaces lauched will set the Env vars for all bash terminals opened in those workspaces.

You can also set Env vars in the `gitpod.yml` but this can contain only non-sensitive Env vars.

## AWS CLI Installation

AWS CLI is installed for this project via the bash script [`./bin/install_aws_cli`](./bin/install_aws_cli)

[Getting Started Install (AWS CLI)](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

[AWS CLI Env vars](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

We can check if our AWS crentials are configured correctly by running the following AWS CLI command:

```sh
> aws sts get-caller-identity
```

If it is successful you should see a JSON payload return that looks like this:

```json
{
    "UserId": "AKIAIOSFODNN7EXAMPLE",
    "Account": "xxxxxxxxxxxx",
    "Arn": "arn:aws:iam::xxxxxxxxxxxx:user/terraform-beginner-bootcamp"
}
```

We'll need to generate AWS CLI credentials from IAM user in order to use the AWS CLI.

## Terraform Basics

### Terraform Registry

Terraform sources their providers and modules from the Terraform registry, which is located at [registry.terraform.io](https://registry.terraform.io/)

- **Providers** are interfaces to APIs that will allow to create resource in Terraform.
- **Modules** are a way to make large amounts of Terraform code modular, portable, and shareable.

[Random Terraform Provider](https://registry.terraform.io/providers/hashicorp/random/)

### Terraform Console

We can see a list of the Terraform commands by simply typing `terraform`

#### Terraform Init 

At the start of a new Terraform project we will run `terraform init` to download the binaries for the Terraform providers that we will use in the project.

#### Terraform Plan

`terraform plan`

This will generate out a changeset about the state of our infrastructure and what will be changed.

We can output this changeset i.e. "plan" to be passed to an apply, but often you can just ignore outputting.

##### Terraform Apply

`terraform apply`

This will run a plan and pass the changest to be executed by Terraform. Apply shold prompt yes or no.
If we want to automatically approve an apply we can provide the auto approve flag, eg. `terraform apply --auto-approve`

#### Terraform Destroy

`terraform destroy`

This will destroy resources.
You can also use the auto approve flag to skip the approve prompt eg. `terraform destroy --auto-approve`


#### Terraform Lock Files

`terraform.lock.hcl` file contains the locked versioning of the providers and modules that should be used with this project.

The Terraform Lock File **should be committed** to your Version Control System (VCS) eg. Github.

#### Terraform State Files 

`terraform.tfstate` file contains information about the current state of your infrastructure.
This file **should not be committed** to your VCS, as it could contain sensitive data.

If you lose this file, you lose the state of your infrastructure.

`terraform.tfstate.backup` is the previous state file.

#### Terraform Directory

`terraform` directort contains binaries of Terraform providers.

## Issues with Terraform Cloud Login and Gitpod

When attempting to run `terraform login` it will launch in bash a wiswig view to generate a token. However it does not work as expected in Gitpod VsCode in the browser.

The workaround is to manually generate a token in Terraform Cloud 

```
https://app.terraform.io/app/settings/tokens?source=terraform-login
```

Then create the file manually here:

```bash 
touch /home/gitpod/.terraform.d/credentials.tfrc.json
open /home/gitpod/.terraform.d/credentials.tfrc.json
```

Provide the following code (replace your token in the file):

```json
{
  "credentials": {
    "app.terraform.io": {
      "token": "YOUR-TERRAFORM-CLOUD-TOKEN"
    }
  }
}
```

Then open the file.

We have automated this workaround with the following bash script [./bin/generate_tfrc_credentials](./bin/generate_tfrc_credentials)


