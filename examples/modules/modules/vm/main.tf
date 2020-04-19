variable "tf_ssh_key" {}
variable "tf_domain" {}
variable "name" {}
variable "size" {
  default = "s-1vcpu-1gb"
}
variable "image" {
  default = "debian-10-x64"
}

resource "digitalocean_droplet" "default" {
  image    = var.image
  name     = var.name
  region   = "fra1"
  size     = var.size
  ssh_keys = [
    var.tf_ssh_key.fingerprint
  ]
}

resource "digitalocean_record" "default" {
  domain = var.tf_domain.name
  type   = "A"
  name   = digitalocean_droplet.default.name
  value  = digitalocean_droplet.default.ipv4_address
}

output "ipv4_address" {
  value = digitalocean_droplet.default.ipv4_address
}

output "fqdn" {
  value = digitalocean_record.default.fqdn
}
