terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.51.0"
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
  ami           = "ami-0c75b861029de4030"
  instance_type = "t2.micro"
  key_name      = data.aws_key_pair.default.key_name
}

output "ip_addr" {
  value = aws_instance.example.public_ip
}
