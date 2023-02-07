variable "base_domain" {}

terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
  }
  required_version = ">= 0.13"
}

provider "digitalocean" {}

data "digitalocean_domain" "default" {
  name = var.base_domain
}

locals {
  enable = false
}

resource "digitalocean_record" "example" {
  count = local.enable ? 1 : 0

  domain = data.digitalocean_domain.default.name
  type   = "A"
  name   = "enable"
  value  = "1.1.1.1"
}
