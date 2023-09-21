# Terraform Beginner Bootcamp 2023

## Semantic Versioning :mage:

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

- This will keep the Gitpod Task File ([].gitpod.yml](.gitpod.yml)) tidy.  
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

### Github Lifecycle (Before, Init, Command)

We need to be careful when using the Init because it will not rerun if we restart an existing workspace.

[Gitpod Tasks](https://www.gitpod.io/docs/configure/workspaces/tasks)


### Working with ENV vars

#### env command

We cam list out all Environment Variables (ENV vars) using the `env` command.

We can filter specific Environment Variables using grep, eg. `env | grep AWS_` 

#### Setting and Ensetting Env Vars

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

#### Printing Env vars

We can print an Env var using echo eg. `echo $HELLO`

#### Scoping of Env vars

When you open up new bash terminals in VSCode it will not be aware of Env vars that you have set in another window.

If you want Env vars to persist across all future bash teminals, you need to set Env vars in your bash profile, eg. `.bash_profile`

#### Persisting Env Vars in Gitpod

We can persist Env vars in gitpod by storing them in Gitpod Secrets Storage.

```
gp env HELLO='world'
```

All future workspaces lauched will set the Env vars for all bash terminals opened in those workspaces.

You can also set Env vars in the `gitpod.yml` but this can contain only non-sensitive Env vars.

### AWS CLI Installation

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