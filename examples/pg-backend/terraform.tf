terraform {
  backend "pg" {
    conn_str = "postgres://postgres:example@127.0.0.1:15432/postgres?sslmode=disable"
  }
}

variable "base_domain" {}
variable "do_token" {}

provider "digitalocean" {
  token = var.do_token
}

data "digitalocean_domain" "default" {
  name = var.base_domain
}

resource "digitalocean_record" "foo" {
  domain = data.digitalocean_domain.default.name
  type   = "CNAME"
  name   = "foobar2"
  value  = "example.com."
}

output "domain" {
  value = digitalocean_record.foo.fqdn
}
