variable "base_domain" {}
variable "vms" {
  default = {
    "1" = null
    "2" = null
  }
}

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

resource "digitalocean_droplet" "example" {
  for_each = var.vms

  image  = "debian-11-x64"
  name   = "example${each.key}"
  region = "fra1"
  size   = "s-1vcpu-1gb"
  ssh_keys = [
    data.digitalocean_ssh_key.default.fingerprint
  ]
}

resource "digitalocean_record" "example" {
  for_each = var.vms

  domain = data.digitalocean_domain.default.name
  type   = "A"
  name   = digitalocean_droplet.example[each.key].name
  value  = digitalocean_droplet.example[each.key].ipv4_address
}

output "domains" {
  value = [
    for droplet in digitalocean_record.example :
    droplet.fqdn
  ]
}

output "domains_map" {
  value = {
    for droplet in digitalocean_record.example :
    droplet.name => droplet.fqdn
  }
}
