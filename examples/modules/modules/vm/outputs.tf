output "ipv4_address" {
  value = digitalocean_droplet.this.ipv4_address
}

output "fqdn" {
  value = digitalocean_record.this.fqdn
}
