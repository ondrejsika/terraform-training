[sika.io](https://sika.io) | <ondrej@sika.io> | [course ->](#course)

# Terraform Training

    Ondrej Sika <ondrej@ondrejsika.com>
    https://github.com/ondrejsika/terraform-training

Source of my Terraform training

## Install Terraform

### Mac

Using __brew__:

```
brew cask install terraform
```

### Linux

Download from <https://terraform.io/downloads.html>

### Windows

Using __chocolatey__:

```
choco install terraform
```

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


## Live Chat

For sharing links & "secrets".

<https://tlk.io/sika-tf>


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

## How Terraform Works

Terraform create Graph of your desired resources described in manifest files, compares them with actual statate (which is stored in state file or backend) and apply only changes using APIs of resource providers.


## Build Infrastructure

### Gitignore

Base `.gitignore` for Terraform projects

```gitignore
.terraform
*.tfstate*
*.tfvars
*.tfplan
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
  image    = "debian-10-x64"
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

## Terraform CLI

### `terraform init`

Download providers & setup modules. You have to call `terraform init` when you want to add or update providers and modules.

```
terraform init
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


### Environment Variable Configuration

This example requires DO token in `DIGITALOCEAN_TOKEN` environment varible.

```hcl
provider "digitalocean" {}
```

### Terraform Variable Configuration

```hcl
variable "do_token" {}

provider "digitalocean" {
  token = var.do_token
}
```

Variable can be set in `.tfvars` file:

```hcl
# terraform.tfvars
do_token = "xxx"
```

or in environment variable `TF_VAR_do_token`

or using comand line argument `-var=do_token=xxx`

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
  image    = "debian-10-x64"
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
  image    = "debian-10-x64"
  name     = "example"
  region   = "fra1"
  size     = "s-1vcpu-1gb"
  ssh_keys = [
    # here
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

## Thank you! & Questions?

That's it. Do you have any questions? __Let's go for a beer!__

### Ondrej Sika

- email: <ondrej@sika.io>
- web: <https://sika.io>
- twitter: [@ondrejsika](https://twitter.com/ondrejsika)
- linkedin:	[/in/ondrejsika/](https://linkedin.com/in/ondrejsika/)
- Newsletter, Slack, Facebook & Linkedin Groups: <https://join.sika.io>

_Do you like the course? Write me recommendation on Twitter (with handle `@ondrejsika`) and LinkedIn (add me [/in/ondrejsika](https://www.linkedin.com/in/ondrejsika/) and I'll send you request for recommendation). __Thanks__._

Wanna to go for a beer or do some work together? Just [book me](https://book-me.sika.io) :)
