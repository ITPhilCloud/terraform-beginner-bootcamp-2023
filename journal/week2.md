# Terraform Beginner Bootcamp 2023 - Week 2

## Working with Ruby

### Bundler

Bundler is a package manager for ruby. It is the primary way to install ruby packages (known as gems) for ruby.

#### Installing Gems

You need to create a Gemfile and define your gems in that file.

```
source "https://rubygems.org"

gem 'sinatra'
gem 'rake'
gem 'pry'
gem 'puma'
gem 'activerecord'
```

Then you need to run the `bundle install` command. This will install the gems on the system globally (unlike nodejs which installs packages in place in a folder called node_modules)

A Gemfile.lock will be created to lock down the gem versions used in this project.

#### Executing Ruby Scripts in the context of Bundler

We have to use `bundle exec` to tell future ruby scripts to use the gems we installed. This is the way we set context. 

### Sinatra 

Sinatra is a micro-web framework for ruby to build web-apps. It's great for mock or development servers of for very simple projects. 
You can create a web-sever is a single file.

[SINATRA](https://sinatrarb.com/)

## Terratowns Mock Server

### Running the web server

We can run the web server by executing the following commands:

```rb
bundle install
bundle exec ruby server.rb
```

All of the for our server is stored in the `server.rb` file.

### Terraform Debugging

#### Log Levels

You can set elevated log level with the command `TF_LOG=DEBUG tf init`

```bash
2023-10-06T11:12:38.779Z [INFO]  Terraform version: 1.6.0
2023-10-06T11:12:38.779Z [DEBUG] using github.com/hashicorp/go-tfe v1.34.0
2023-10-06T11:12:38.779Z [DEBUG] using github.com/hashicorp/hcl/v2 v2.18.0
2023-10-06T11:12:38.780Z [DEBUG] using github.com/hashicorp/terraform-svchost v0.1.1
2023-10-06T11:12:38.780Z [DEBUG] using github.com/zclconf/go-cty v1.14.0
2023-10-06T11:12:38.780Z [INFO]  Go runtime version: go1.21.1
2023-10-06T11:12:38.780Z [INFO]  CLI args: []string{"terraform", "init"}
2023-10-06T11:12:38.780Z [DEBUG] Attempting to open CLI config file: /home/gitpod/.terraformrc
2023-10-06T11:12:38.780Z [INFO]  Loading CLI configuration from /home/gitpod/.terraformrc
2023-10-06T11:12:38.780Z [INFO]  Loading CLI configuration from /home/gitpod/.terraform.d/credentials.tfrc.json
2023-10-06T11:12:38.780Z [DEBUG] checking for credentials in "/home/gitpod/.terraform.d/plugins"
2023-10-06T11:12:38.780Z [DEBUG] Explicit provider installation configuration is set
2023-10-06T11:12:38.781Z [INFO]  CLI command args: []string{"init"}

```

[Debugging Terraform](https://developer.hashicorp.com/terraform/internals/debugging)