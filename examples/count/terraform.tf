variable "base_domain" {}
variable "vm_count" {
  default = 3
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
  count = var.vm_count

  image  = "debian-10-x64"
  name   = "example${count.index}"
  region = "fra1"
  size   = "s-1vcpu-1gb"
  ssh_keys = [
    data.digitalocean_ssh_key.default.fingerprint
  ]
}

resource "digitalocean_record" "example" {
  count = var.vm_count

  domain = data.digitalocean_domain.default.name
  type   = "A"
  name   = digitalocean_droplet.example[count.index].name
  value  = digitalocean_droplet.example[count.index].ipv4_address
}

output "domains" {
  value = digitalocean_record.example.*.fqdn
}
