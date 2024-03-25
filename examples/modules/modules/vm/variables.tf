variable "ssh_keys" {
  type        = list(string)
  description = "List of SSH key IDs"
}

variable "domain_name" {
  type = string
}

variable "name" {
  type = string
}

variable "size" {
  type    = string
  default = "s-1vcpu-1gb"
}

variable "image" {
  type    = string
  default = "debian-12-x64"
}

variable "region" {
  type    = string
  default = "fra1"
}
