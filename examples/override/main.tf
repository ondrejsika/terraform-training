terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.3.1"
    }
  }
}

resource "random_string" "example" {
  length           = 64
  special          = false
  override_special = "/@£$"
}

output "example" {
  value = random_string.example.result
}
