terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
  }
  required_version = ">= 0.13"
}

variable "base_domain" {}

provider "digitalocean" {}

data "digitalocean_ssh_key" "default" {
  name = "default"
}

data "digitalocean_domain" "default" {
  name = var.base_domain
}

module "nfs" {
  source  = "ondrejsika/do-nfs/module"
  version = "2.0.0"
  ssh_keys = [
    data.digitalocean_ssh_key.default.id,
  ]
}

resource "digitalocean_record" "nfs" {
  domain = data.digitalocean_domain.default.name
  type   = "A"
  name   = "nfs"
  value  = module.nfs.ipv4_address
}

output "domain" {
  value = digitalocean_record.nfs.fqdn
}
