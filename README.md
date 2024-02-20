[Ondrej Sika (sika.io)](https://sika.io) | <ondrej@sika.io> | [course ->](#course)

# Terraform Training

## Course

## About Me - Ondrej Sika

__Freelance DevOps Engineer, Consultant & Lecturer__

- Complete DevOps Pipeline
- Open Source / Linux Stack
- Cloud & On-Premise
- Technologies: Git, Gitlab, Gitlab CI, Docker, Kubernetes, Terraform, Prometheus, ELK / EFK, Rancher, Proxmox, DigitalOcean, AWS


## Star, Create Issues, Fork, and Contribute

Feel free to star this repository or fork it.

If you found bug, create issue or pull request.

Also feel free to propose improvements by creating issues.


## Chat

For sharing links & "secrets".

- Slack - https://sikapublic.slack.com/
- Microsoft Teams
- https://sika.link/chat (tlk.io)

## DevOps Kniha (Czech only)

[![](./images/devops_kniha.jpg)](https://kniha.sika.io)

<https://kniha.sika.io>

## What is a Terraform

Terraform is a tool for building, changing, and versioning infrastructure safely and efficiently. Terraform can manage existing and popular service providers as well as custom in-house solutions.

Configuration files describe to Terraform the components needed to run a single application or your entire datacenter. Terraform generates an execution plan describing what it will do to reach the desired state, and then executes it to build the described infrastructure. As the configuration changes, Terraform is able to determine what changed and create incremental execution plans which can be applied. [more at the Terraform website](https://www.terraform.io/intro/index.html)

## Why Terraform

- Infrastructure as Code
- Resource Graph
- Execution Plans
- Change Automation

## Terraform vs Others

Terraform provides a flexible abstraction of resources and providers. This model allows for representing everything from physical hardware, virtual machines, and containers, to email and DNS providers. [more at Terraform website](https://www.terraform.io/intro/vs/index.html)

### Terraform vs Ansible, Puppet, ...

Configuration management tools install and manage software on a machine that already exists. Terraform is not a configuration management tool, and it allows existing tooling to focus on their strengths: bootstrapping and initializing resources.

### Terraform vs. CloudFormation

CloudFormation is very similar tool as Terraform. CloudFormation is AWS native and you're not able to mange any non-AWS resources using CloufFormation. For example, you have AWS for computing, but you have Cloudflare DNS and few servers on GCP or Digital Ocean. You can't use CloudFormation to manage all those resources in one graph, but you can use Terraform to do that.

### Terraform vs Pulumi

- <https://pulumi.com>

Pulumi and Terraform differ in that Terraform requires the use of a domain-specific language: HashiCorp Configuration Language (HCL). In contrast, Pulumi allows you to use familiar general purpose languages like Python, TypeScript, JavaScript, Go, .NET, Java, and markup languages like YAML.

-- <https://www.pulumi.com/docs/intro/vs/terraform/#differences>

## How Terraform Works

Terraform create Graph of your desired resources described in manifest files, compares them with actual state (which is stored in state file or backend) and apply only changes using APIs of resource providers.

## Install Terraform

### Mac

Using __brew__:

```
brew cask install terraform
```

### Linux

Download from <https://terraform.io/downloads.html>

or using [slu](https://github.com/sikalabs/slu):

```
slu install-bin terraform
```

### Windows

Using __winget__:

```
winget install -e --id Hashicorp.Terraform
```

Using __chocolatey__:

```
choco install terraform
```

## Global Configuration

- Using `$HOME/.terraformrc` (on Unix)
- Using `%APPDATA%\terraform.rc` (on Windows)
- Using environment variables

### Provider Plugin Cache

<https://www.terraform.io/cli/config/config-file#provider-plugin-cache>

Using `.terraformrc`

```hcl
plugin_cache_dir = "$HOME/.terraform.d/plugin-cache"
```

Using environment variables

```sh
# .bashrc or .zshrc
export TF_PLUGIN_CACHE_DIR=$HOME/.terraform.d/plugin-cache
```

## Build Infrastructure

### Gitignore

Base `.gitignore` for Terraform projects

```gitignore
.terraform
*.tfstate
*.tfvars
!*.EXAMPLE.tfvars
*.tfplan
.terraform.tfstate.lock.info
*.backup
override.tf

# Infracost
.infracost
.infracost-reports
```

Generate `.gitignore` using **slu**:

```
slu file-templates gitignore --terraform
```

or

```
slu ft gi --terraform
```

## VSCode Terraform Plugin

Official from HashiCorp

<https://marketplace.visualstudio.com/items?itemName=HashiCorp.terraform>

## VSCode Format on Save

```json
"[terraform]": {
  "editor.formatOnSave": true
}
```

### Simple Infrastructure Example

Here is example ifrastructure described in `terraform.tf`. Components will be described later.

```hcl
provider "digitalocean" {}

resource "digitalocean_ssh_key" "default" {
  name       = "default"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "digitalocean_droplet" "example" {
  image    = "debian-11-x64"
  name     = "example"
  region   = "fra1"
  size     = "s-1vcpu-1gb"
  ssh_keys = [
    digitalocean_ssh_key.default.fingerprint
  ]
}

output "ip_addr" {
  value = digitalocean_droplet.example.ipv4_address
}
```

## Configuration Language

- Expressions - https://www.terraform.io/docs/configuration/expressions.html
- Built-in Functions - https://www.terraform.io/docs/configuration/functions.html

## Terraform Environment Variables

### `TF_CLI_ARGS`

<https://developer.hashicorp.com/terraform/cli/config/environment-variables#tf_cli_args-and-tf_cli_args_name>

```sh
export TF_CLI_ARGS=-refresh=false
```

## Terraform CLI

### My Bash/ZSH Aliases

```sh
alias tf=terraform
alias tfi="terraform init"
alias tfa="terraform apply"
alias tfd="terraform destroy"
alias tfp="terraform plan"
alias tfs="terraform show"
alias tfo="terraform output"
```

### PowerShell Aliases

```powershell
Set-Alias -Name tf -Value terraform
```

```powershell
Set-Alias -Name tfi -Value "terraform init"
Set-Alias -Name tfa -Value "terraform apply"
Set-Alias -Name tfd -Value "terraform destroy"
Set-Alias -Name tfp -Value "terraform plan"
Set-Alias -Name tfs -Value "terraform show"
Set-Alias -Name tfo -Value "terraform output"
```

### `terraform init`

Download providers & setup modules. You have to call `terraform init` when you want to add or update providers and modules.

```
terraform init
```

### `terraform lock`

Create `.terraform.lock.hcl` which will lock providers versions. This file will be used by `terraform init` to download providers.

- https://developer.hashicorp.com/terraform/cli/commands/providers/lock

```
terraform providers lock \
  -platform=darwin_arm64 \
  -platform=darwin_amd64 \
  -platform=linux_arm64 \
  -platform=linux_amd64
```

### `terraforn plan`

Terraform plan creates execution plan. Compare your `.tf` manifests with actual state and determines which resources has to be created, updated or deleted.

You can run `terraform plan` to see execution plan. Your plan will be shown but be NOT saved for apply. If you run `terraform apply`, execution plan will be created again.

```
terraform plan
```

If you want to save the plan and execute it, you can use parameter `-out terraform.tfplan` and your plan will be saved for future apply.

```
terraform plan -out terraform.tfplan
```

### `terraform apply`

Terraform apply apply your desired state to actual state.

`terraform plan` create execution plan (as `terraform plan`) and apply it. Terraform apply ask you for `yes` to confirm execution. If you say anything other than yes, Terraform will abort execution.

```
terraform apply
```

If you want run `terraform apply` in CI for example, you can confirm execution using parameter `-auto-approve`.

```
terraform apply -auto-approve
```

If you want to apply plan created by `terraform plan`, you have to use:

```
terraform apply terraform.tfplan
```

### `terraform output`

Terraform output shows outputs defined in `.tf` files. Those outputs are also shown on end of apply.

```
terraform output
```

You can specify single output using `terraform output <output_name>`. Example:

```
terraform output ip_addr
```

### `terraform taint`

Mark resource for force recreate in next apply.

```sh
terraform taint digitalocean_droplet.example
```

### `terraform untaint`

Remove taint from resource

```sh
terraform untaint digitalocean_droplet.example
```

### `terraform destroy`

Terraform destroy destroys your ifrastructure created by Terraform.

```
terraform destroy
```

You can also use `-auto-approve`, for example for CI.

```
terraform destroy -auto-approve
```

## Provider

A plugin for Terraform that makes a collection of related resources available. A provider plugin is responsible for understanding API interactions with some kind of service and exposing resources based on that API.

Terraform providers are generally tied to a specific infrastructure provider, which might be DigitalOceam, AWS, CloudFlare, ...

List of official providers: <https://www.terraform.io/docs/providers/index.html>

### Environment Variable Configuration

This example requires DO token in `DIGITALOCEAN_TOKEN` environment varible.

```hcl
provider "digitalocean" {}
```

### Terraform Variable Configuration

```hcl
variable "digitalocean_token" {}

provider "digitalocean" {
  token = var.digitalocean_token
}
```

Variable can be set in `.tfvars` file:

```hcl
# terraform.tfvars
digitalocean_token = "xxx"
```

or in environment variable `TF_VAR_digitalocean_token`. **This is case sensitive.**

or using comand line argument `-var=digitalocean_token=xxx`

More about input variables: https://www.terraform.io/docs/configuration/variables.html


### Digital Ocean Provider

[docs](https://www.terraform.io/docs/providers/do/index.html)

## Resource

Examples:

```hcl
resource "digitalocean_ssh_key" "default" {
  name       = "default"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "digitalocean_droplet" "example" {
  image    = "debian-11-x64"
  name     = "example"
  region   = "fra1"
  size     = "s-1vcpu-1gb"
  ssh_keys = [
    digitalocean_ssh_key.default.fingerprint
  ]
}
```

### Data Source

A resource-like object that can be configured in Terraform's configuration language.

Unlike resources, data sources do not create or manage infrastructure. Instead, they return information about some kind of external object in the form of readable attributes. This allows a Terraform configuration to make use of information defined outside of Terraform, or defined by another separate Terraform configuration.

```hcl
data "digitalocean_ssh_key" "default" {
  name = "default"
}
```

Example usage:

```hcl
data "digitalocean_ssh_key" "default" {
  name = "default"
}

resource "digitalocean_droplet" "example" {
  image    = "debian-11-x64"
  name     = "example"
  region   = "fra1"
  size     = "s-1vcpu-1gb"
  ssh_keys = [
    data.digitalocean_ssh_key.default.fingerprint
  ]
}
```

### Output

Outputs are by default accessible on end of apply

```hcl
output "message" {
  value = "Output"
}
```

If you have senstitive data in output, you can use `sensitive = true` and output data will be NOT shown.

```hcl
output "secret" {
  value = "Sensitive Output"
  sensitive = true
}
```

To see your output use:

```
terraform output <name>
```

Eg.:

```
terraform output message
terraform output secret
```

![outputs](images/outputs.png)

## Mark as Sensitive or Not Sensitive

- `sensitive` - Mark data as sensitive.
- `nonsensitive` - Mark sensitive data as not sensitive.

```hcl
resource "random_password" "foo" {
  length  = 16
  special = false
}

output "foo" {
  value = nonsensitive(random_password.foo.result)
}
```

See full example [examples/sensitive](./examples/sensitive)

## Locals

```hcl
locals {
  image = "debian-11-x64"
  size  = "s-1vcpu-1gb"
}

resource "digitalocean_droplet" "foo" {
  name  = "foo"
  image = local.image
  size  = local.size
  ...
}
```

## Count

You can manage multiple resources from same configuration using count.

```hcl
resource "digitalocean_droplet" "example" {
  count = 5

  image    = "debian-11-x64"
  ...
}
```

## For Each

```hcl
resource "digitalocean_droplet" "example" {
  for_each = {
    foo = {
      image = "debian-11-x64"
      size = "s-1vcpu-1gb"
    }
    bar = {
      image = "debian-11-x64"
      size = "s-2vcpu-2gb"
    }
  }

  name  = each.key
  image = each.value.image
  size  = each.value.size
  ...
}
```

## Conditions (if)

There is no `if` or another condition implementation in Terraform. You can use `count` workaround to achieve this.

```hcl
locals {
  enable = true
}

resource "digitalocean_record" "example" {
  count = local.enable ? 1 : 0

  ...
}
```

## Random Provider

- https://registry.terraform.io/providers/hashicorp/random/latest/docs

```hcl
resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_"
}
```

Example [./examples/random](./examples/random)

## Provisioners

Provisioners start provisioning of the resource using external tool. For example Ansible or Puppet. By default provisioners run when resource is created.

There are many provisioners, see docs: https://www.terraform.io/docs/provisioners/index.html

### Connections

[Docs](https://www.terraform.io/docs/provisioners/connection.html)

Most provisioners require access to the remote resource via SSH or WinRM, and expect a nested connection block with details about how to connect.

```hcl
connection {
  type = "ssh"
  user = "root"
  host = self.ipv4_address
}
```

### Local Exec

[Docs](https://www.terraform.io/docs/provisioners/local-exec.html)

Execute command on local machine

```hcl
provisioner "local-exec" {
  command = "sh ./apply-ansible.sh ${self.ipv4_address}"
}
```

### Remote Exec

[Docs](https://www.terraform.io/docs/provisioners/remote-exec.html)

Execute command on remote machine. Require `connection` block.

```hcl
provisioner "remote-exec" {
  inline = [
    "apt-get update",
    "apt-get install -y nginx",
  ]
}
```

### File

[Docs](https://www.terraform.io/docs/provisioners/file.html)

Copy file from local machine to remote. Require `connection` block.

```hcl
provisioner "file" {
  source      = "index.html"
  destination = "/var/www/html/index.html"
}
```

### Destroy Time Provisioners

By default, provisioners are executed when resource is created. If you specify `when = destroy`, provisioner will be executed on resorce removal.

```hcl
provisioner "local-exec" {
  when    = destroy
  command = "sh ./backup.sh ${self.ipv4_address}"
}
```

## Cloud Init

- DevOps Live (recording) - https://www.youtube.com/watch?v=hSyBBLWRXLs
- DevOps Live (repo with examples) - https://github.com/ondrejsika/devopslive/tree/master/2021-01-21_cloud_init

```hcl
resource "digitalocean_droplet" "example" {
  ...
  user_data = <<EOF
#cloud-config
ssh_pwauth: yes
password: asdfasdf2020
write_files:
- path: /html/index.html
  permissions: "0755"
  owner: root:root
  content: |
    <h1>Hello from Cloud Init
chpasswd:
  expire: false
runcmd:
  - |
    apt update
    apt install -y curl sudo git nginx
    curl -fsSL https://ins.oxs.cz/slu-linux-amd64.sh | sudo sh
    cp /html/index.html /var/www/html/index.html
EOF
}
```

## Lifecycle

[Docs](https://www.terraform.io/language/meta-arguments/lifecycle)

### Create Before Destroy

```hcl
resource "azurerm_resource_group" "example" {
  lifecycle {
    create_before_destroy = true
  }

  # ...
}
```

## Prevent Destroy

```hcl
resource "aws_instance" "example" {
  lifecycle {
    prevent_destroy = true
  }

  # ...
}
```

## Ignore Changes

```hcl
resource "aws_instance" "example" {
  lifecycle {
    ignore_changes = [
      tags,
    ]
  }

  # ...
}
```

## Backends

[Docs](https://www.terraform.io/docs/backends/index.html)

A "backend" in Terraform determines how state is loaded and how an operation such as apply is executed. This abstraction enables non-local file state storage, remote execution, etc.

### Backend Types

- HTTP - https://developer.hashicorp.com/terraform/language/settings/backends/http
- S3 - https://www.terraform.io/docs/backends/types/s3.html
- Etcd - https://www.terraform.io/docs/backends/types/etcd.html
- Consul - https://www.terraform.io/docs/backends/types/consul.html
- Postgress - https://www.terraform.io/docs/backends/types/pg.html

### Gitlab Backend (HTTP)

See the example [examples/gitlab_state_backend](./examples/gitlab_state_backend)

```tf
# terraform.tf

terraform {
  backend "http" {}
}
```

```Makefile
# Makefile
STATE_NAME = main

terraform-state-init:
ifndef GITLAB_DOMAIN
	$(error GITLAB_DOMAIN is undefined)
endif
ifndef GITLAB_PROJECT_ID
	$(error GITLAB_PROJECT_ID is undefined)
endif
ifndef GITLAB_USERNAME
	$(error GITLAB_USERNAME is undefined)
endif
ifndef GITLAB_TOKEN
	$(error GITLAB_TOKEN is undefined)
endif
	terraform init \
		-backend-config="address=https://${GITLAB_DOMAIN}/api/v4/projects/${GITLAB_PROJECT_ID}/terraform/state/${STATE_NAME}" \
		-backend-config="lock_address=https://${GITLAB_DOMAIN}/api/v4/projects/${GITLAB_PROJECT_ID}/terraform/state/${STATE_NAME}/lock" \
		-backend-config="unlock_address=https://${GITLAB_DOMAIN}/api/v4/projects/${GITLAB_PROJECT_ID}/terraform/state/${STATE_NAME}/lock" \
		-backend-config="username=${GITLAB_USERNAME}" \
		-backend-config="password=${GITLAB_TOKEN}" \
		-backend-config="lock_method=POST" \
		-backend-config="unlock_method=DELETE" \
		-backend-config="retry_wait_min=5"
```

### Azure Backend

You can specify config in `.tf` file:

```tf
terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "tfstate8637959853"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    # -backend-config="resource_group_name=storage-account-example" -backend-config="storage_account_name=example8637959853" -backend-config="container_name=example" -backend-config="key=terraform.tfstate"
  }
}
```

Or you can define backend and setup via `-backend-config` parameter in `terraform init`.

```tf
terraform {
  backend "azurerm" {}
}
```

and

```bash
terraform init \
  -backend-config="resource_group_name=tfstate" \
  -backend-config="storage_account_name=tfstate8637959853" \
  -backend-config="container_name=tfstate" \
  -backend-config="key=terraform.tfstate"
```

### Postgres Backend

[Docs](https://www.terraform.io/docs/backends/types/pg.html)

You can store state in Postgres and let team to cooperate.

You can specify connection in `.tf` file:

```hcl
terraform {
  backend "pg" {
    conn_str = "postgres://postgres:example@127.0.0.1:15432/postgres?sslmode=disable"
  }
}
```

Keep sensitive data off your Terraform files:

```hcl
terraform {
  backend "pg" {}
}
```

And specify connection on init:

```
terraform init -backend-config="conn_str=postgres://postgres:example@127.0.0.1:15432/postgres?sslmode=disable"
```

### Remote Backend

[Docs](https://www.terraform.io/docs/backends/types/remote.html)

Remote backend store state and execute operations from Terraform Cloud.

If you want to use Remote Backend, use this:

```hcl
terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "ondrejsika"
    workspaces {
      name = "demo"
    }
  }
}
```

## Terraform Import

- https://developer.hashicorp.com/terraform/cli/import
- https://developer.hashicorp.com/terraform/cli/commands/import

```
terraform import aws_instance.foo i-abcdefgh
```

## Modules

[Docs](https://www.terraform.io/docs/modules/index.html) | [Configuration Docs](https://www.terraform.io/docs/configuration/modules.html)

A module is a container for multiple resources that are used together. Modules can be used to create lightweight abstractions, so that you can describe your infrastructure in terms of its architecture, rather than directly in terms of physical objects.

See example modules in [modules example](examples/modules)

## Terraform Registry

[Docs](https://www.terraform.io/docs/registry/index.html) |
[Registry (registry.terraform.io)](https://registry.terraform.io) |
[My Modules](https://registry.terraform.io/modules/ondrejsika)

The Terraform Registry is a repository of modules written by the Terraform community. The registry can help you get started with Terraform more quickly, see examples of how Terraform is written, and find pre-made modules for infrastructure components you require.

### Example: NFS server on DigitalOcean

See my __terraform-module-do-nfs__ module:

- Github - https://github.com/ondrejsika/terraform-module-do-nfs
- Terraform Registry - https://registry.terraform.io/modules/ondrejsika/do-nfs

```hcl
module "nfs" {
  source  = "ondrejsika/do-nfs/module"
  version = "1.0.0"
  tf_ssh_key = data.digitalocean_ssh_key.default
}
```

Example usage here [examples/registry](examples/registry)

## Override Files

[Docs](https://www.terraform.io/docs/configuration/override.html)

```hcl
# terraform.tf
resource "aws_instance" "web" {
  instance_type = "t2.micro"
  ami           = "ami-408c7f28"
}
```

```hcl
# override.tf
resource "aws_instance" "web" {
  ami = "foo"
}
```

will be merged into:

```hcl
resource "aws_instance" "web" {
  instance_type = "t2.micro"
  ami           = "foo"
}
```

## Infracost

Infracost helps engineering teams see how code changes affect their cloud costs. It scans a Terraform code and checks over 3 million prices to create a simple, understandable cost estimate before launch. Users can view helpful comments like: “This change will increase your AWS bill by 25%.”

**[infracost.io](https://infracost.io)**

## tflint

- https://github.com/terraform-linters/tflint

### Install tflint

Bash script (Linux):

```
curl -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash
```

or using `slu`:

```
slu install-bin tflint
```

Homebrew (macOS):

```
brew install tflint
```

Chocolatey (Windows):

```
choco install tflint
```

### Example

Run `tflint` in your Terraform workspace directory

```
tflint
```

```
tflint --module
```

## !! Cleanup Digitalocean Account After Training !!

Delete everything from Digitalocean account after training.

```
make cleanup-digitalocean-account-after-training
```

## Terradozer

Terradozer is a tool to destroy all resources using only Terraform state.

<https://github.com/jckuester/terradozer>

## Weird Terraform Providers

- Spotify - <https://github.com/conradludgate/terraform-provider-spotify>
- Dominos - <https://github.com/nat-henderson/terraform-provider-dominos>

## What Next?

### Hashicorp Meetups

I organize Hashicorp Meetups in Prague. More information at [meetups.hashicorp.cz](https://meetups.hashicorp.cz).

### My Terraform Repositories

- EN - https://ondrej-sika.com/repositories/#terraform
- CS - https://ondrej-sika.cz/repozitare/#terraform

or check all my Terraform repositories on Github: [github.com/ondrejsika](https://github.com/ondrejsika?tab=repositories&q=terraform&type=&language=)

More articles on my Czech website about Terraform:

<https://ondrej-sika.cz/terraform/>

## Thank you! & Questions?

That's it. Do you have any questions? __Let's go for a beer!__ or [schedule a beer](https://calendly.com/ondrejsika/beer)

### Ondrej Sika

- email: <ondrej@sika.io>
- web: <https://sika.io>
- twitter: [@ondrejsika](https://twitter.com/ondrejsika)
- linkedin:	[/in/ondrejsika/](https://linkedin.com/in/ondrejsika/)
- Newsletter, Slack, Facebook & Linkedin Groups: <https://join.sika.io>

_Do you like the course? Write me recommendation on Twitter (with handle `@ondrejsika`) and LinkedIn (add me [/in/ondrejsika](https://www.linkedin.com/in/ondrejsika/) and I'll send you request for recommendation). __Thanks__._

Wanna to go for a beer or do some work together? Just [book me](https://book-me.sika.io) :)

## Training Sessions

#### 2023-10-09 Tieto

- Repo from the training - https://github.com/sika-training-examples/2023-10-09-terraform-example-project-tieto

#### 2023-02-06 CRA

- Example Terraform Infrastructure Monorepo - https://github.com/sika-training-examples/2023-02-06--terrafrom--demo

#### 2023-01-24 ZooControl

- Example Terraform Infrastructure Monorepo - https://github.com/sika-training-examples/2023-01-24--zoocontrol--terraform--example-monorepo
- Step by Steps - https://github.com/sika-training-examples/2023-01-24--zoocontrol--terraform--basic-steps
- Gitlab Variables in Terraform - https://github.com/sika-training-examples/2023-01-24--zoocontrol--terraform-gitlab-variables-in-terraform

#### 2023-01-10 TTC

- Example Terraform Infrastructure Monorepo - https://github.com/sika-training-examples/2023-01-10-ttc-terraform-example-project
