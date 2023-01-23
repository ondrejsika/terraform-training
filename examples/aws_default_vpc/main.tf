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

resource "aws_default_vpc" "default" {}

resource "aws_default_security_group" "default" {
  vpc_id = aws_default_vpc.default.id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "vpc_id" {
  value = aws_default_vpc.default.id
}
