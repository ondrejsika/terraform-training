locals {
  enable = true
}

resource "random_password" "main" {
  count = local.enable ? 1 : 0

  length  = 10
  special = false
}

locals {
  random_password_result = length(random_password.main) == 1 ? random_password.main[0].result : sensitive("---")
}

output "random_password" {
  value = nonsensitive(local.random_password_result)
}
