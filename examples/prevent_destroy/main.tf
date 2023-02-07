terraform {
  required_providers {
    null = {
      source = "hashicorp/null"
    }
  }
  required_version = ">= 0.13"
}

resource "null_resource" "foo" {
  lifecycle {
    prevent_destroy = true
  }
}

resource "null_resource" "bar" {}
