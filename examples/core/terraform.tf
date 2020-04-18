variable "base_domain" {}

provider "digitalocean" {}

resource "digitalocean_ssh_key" "default" {
  name       = "default"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "digitalocean_domain" "default" {
  name = var.base_domain
}
