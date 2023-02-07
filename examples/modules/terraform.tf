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

  name        = "foo"
  domain_name = data.digitalocean_domain.default.name
  ssh_keys = [
    data.digitalocean_ssh_key.default.id,
  ]
}

module "bar" {
  source = "./modules/vm"
  name   = "bar"

  domain_name = data.digitalocean_domain.default.name
  ssh_keys = [
    data.digitalocean_ssh_key.default.id,
  ]
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

