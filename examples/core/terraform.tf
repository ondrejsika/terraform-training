variable "base_domain" {}

provider "digitalocean" {}

resource "digitalocean_ssh_key" "default" {
  name       = "default"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "digitalocean_domain" "default" {
  name = var.base_domain
}

output "ssh_key_name" {
  value = digitalocean_ssh_key.default.name
}

output "base_domain" {
  value = digitalocean_domain.default.name
}
