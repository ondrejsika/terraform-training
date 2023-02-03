terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "sikademo"
    workspaces {
      name = "demo"
    }
  }

  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
  }
  required_version = ">= 0.13"
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
  name   = "foobar"
  value  = "example.com."
}

output "domain" {
  value = digitalocean_record.foo.fqdn
}
