[sika.io](https://sika.io) | <ondrej@sika.io>

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
