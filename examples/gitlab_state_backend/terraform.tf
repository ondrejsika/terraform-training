terraform {
  backend "http" {}

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
  name   = "gitlab-state-backend-foo"
  value  = "example.com."
}

resource "digitalocean_record" "bar" {
  domain = data.digitalocean_domain.default.name
  type   = "CNAME"
  name   = "gitlab-state-backend-bar"
  value  = "example.com."
}
