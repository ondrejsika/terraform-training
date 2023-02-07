resource "digitalocean_droplet" "this" {
  image    = var.image
  name     = var.name
  region   = var.region
  size     = var.size
  ssh_keys = var.ssh_keys
}

resource "digitalocean_record" "this" {
  domain = var.domain_name
  type   = "A"
  name   = digitalocean_droplet.this.name
  value  = digitalocean_droplet.this.ipv4_address
}
