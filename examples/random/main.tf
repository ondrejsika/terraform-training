terraform {
  required_providers {
    digitalocean = {
      source = "hashicorp/random"
    }
  }
}

resource "random_password" "passwords" {
  count = 5

  length           = 16
  special          = true
  override_special = "_"
}

resource "random_pet" "pets" {
  count = 5
}

output "passwords" {
  value     = random_password.passwords.*.result
  sensitive = true
}

output "passwords_nonsensitive" {
  value = [for el in random_password.passwords.*.result : nonsensitive(el)]
}

output "pets" {
  value = random_pet.pets.*.id
}
