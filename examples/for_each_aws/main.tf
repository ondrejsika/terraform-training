terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.51.0"
    }
  }
}

locals {
  vms = {
    foo = {
      ami           = "ami-0c75b861029de4030"
      instance_type = "t2.micro"
    }
    bar = {
      ami           = "ami-0c75b861029de4030"
      instance_type = "t2.micro"

    }
  }
}

variable "aws_access_key" {}
variable "aws_secret_key" {}

variable "ssh_key_name" {
  default = "ondrejsika"
}

provider "aws" {
  region     = "eu-central-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

data "aws_key_pair" "default" {
  key_name = var.ssh_key_name
}

resource "aws_instance" "example" {
  for_each = local.vms

  ami           = each.value.ami
  instance_type = each.value.instance_type
  key_name      = data.aws_key_pair.default.key_name
}

output "ips" {
  value = [
    for instance in aws_instance.example : instance.public_ip
  ]
}
