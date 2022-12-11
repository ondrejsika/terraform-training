terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }
  }
}

resource "random_password" "foo" {
  length  = 16
  special = false
}

output "foo" {
  value = nonsensitive(random_password.foo.result)
}

output "bar" {
  value     = sensitive("hello_world")
  sensitive = true
}
