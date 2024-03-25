variable "base_domain" {}

terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
  }
}

provider "digitalocean" {}

locals {
  vm_count = 2
}

data "digitalocean_ssh_key" "default" {
  name = "default"
}

data "digitalocean_domain" "default" {
  name = var.base_domain
}

resource "digitalocean_droplet" "example" {
  count = local.vm_count

  image  = "debian-12-x64"
  name   = "example"
  region = "fra1"
  size   = "s-1vcpu-1gb"
  ssh_keys = [
    data.digitalocean_ssh_key.default.fingerprint
  ]
}

resource "digitalocean_record" "example" {
  count = local.vm_count

  domain = data.digitalocean_domain.default.name
  type   = "A"
  name   = digitalocean_droplet.example[count.index].name
  value  = digitalocean_droplet.example[count.index].ipv4_address
}

output "ansible-hosts" {
  value = {
    "all" : {
      "hosts" : [
        for vm in digitalocean_droplet.example :
        vm.ipv4_address
      ]
    }
  }
}

output "domains" {
  value = [
    for record in digitalocean_record.example :
    record.fqdn
  ]
}
