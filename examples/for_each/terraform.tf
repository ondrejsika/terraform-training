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
  vms = {
    foo = {
      image = "debian-12-x64"
      size  = "s-1vcpu-1gb"
    }
    bar = {
      image = "debian-12-x64"
      size  = "s-1vcpu-1gb"
    }
  }
}

resource "digitalocean_droplet" "example" {
  for_each = local.vms

  image  = each.value.image
  name   = "example-${each.key}"
  region = "fra1"
  size   = each.value.size
  ssh_keys = [
    data.digitalocean_ssh_key.default.fingerprint
  ]
}

resource "digitalocean_record" "example" {
  for_each = local.vms


  domain = data.digitalocean_domain.default.name
  type   = "A"
  name   = digitalocean_droplet.example[each.key].name
  value  = digitalocean_droplet.example[each.key].ipv4_address
}

output "domains" {
  value = [
    for instance in digitalocean_record.example : instance.fqdn
  ]
}
