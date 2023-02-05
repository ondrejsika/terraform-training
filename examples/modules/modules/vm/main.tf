variable "tf_ssh_key" {}
variable "tf_domain" {}
variable "name" {}
variable "size" {
  default = "s-1vcpu-1gb"
}
variable "image" {
  default = "debian-11-x64"
}

terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
  }
  required_version = ">= 0.13"
}

resource "digitalocean_droplet" "this" {
  image  = var.image
  name   = var.name
  region = "fra1"
  size   = var.size
  ssh_keys = [
    var.tf_ssh_key.fingerprint
  ]
}

resource "digitalocean_record" "this" {
  domain = var.tf_domain.name
  type   = "A"
  name   = digitalocean_droplet.this.name
  value  = digitalocean_droplet.this.ipv4_address
}

output "ipv4_address" {
  value = digitalocean_droplet.this.ipv4_address
}

output "fqdn" {
  value = digitalocean_record.this.fqdn
}
