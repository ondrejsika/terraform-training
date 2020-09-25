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

module "foo" {
  source = "./modules/vm"
  tf_ssh_key = data.digitalocean_ssh_key.default
  tf_domain = data.digitalocean_domain.default
  name = "foo"
}

module "bar" {
  source = "./modules/vm"
  tf_ssh_key = data.digitalocean_ssh_key.default
  tf_domain = data.digitalocean_domain.default
  name = "bar"
}

output "foo_ip_addr" {
  value = module.foo.ipv4_address
}
output "foo_fqdn" {
  value = module.foo.fqdn
}
output "bar_ip_addr" {
  value = module.bar.ipv4_address
}
output "bar_fqdn" {
  value = module.bar.fqdn
}

