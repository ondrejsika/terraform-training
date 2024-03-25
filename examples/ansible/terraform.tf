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

resource "digitalocean_droplet" "example" {
  image  = "debian-12-x64"
  name   = "example"
  region = "fra1"
  size   = "s-1vcpu-1gb"
  ssh_keys = [
    data.digitalocean_ssh_key.default.fingerprint
  ]

  provisioner "local-exec" {
    command = "sleep 10 && make ansible HOST=${self.ipv4_address}"
  }
}

resource "digitalocean_record" "example" {
  domain = data.digitalocean_domain.default.name
  type   = "A"
  name   = digitalocean_droplet.example.name
  value  = digitalocean_droplet.example.ipv4_address
}

output "domain" {
  value = digitalocean_record.example.fqdn
}
