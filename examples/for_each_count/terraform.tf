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

data "digitalocean_ssh_key" "default" {
  name = "default"
}

data "digitalocean_domain" "default" {
  name = var.base_domain
}

locals {
  count     = 20
  count_set = toset([for i in range(local.count) : tostring(i)])
}

resource "digitalocean_record" "example" {
  for_each = local.count_set

  domain = data.digitalocean_domain.default.name
  type   = "A"
  name   = "for-each-count-${each.key}"
  value  = "1.1.1.1"
}

output "domains" {
  value = [
    for instance in digitalocean_record.example : instance.fqdn
  ]
}
