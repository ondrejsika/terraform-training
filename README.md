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
