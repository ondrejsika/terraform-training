terraform {
  required_version = ">= 1.11.0"

  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = ">= 4.0.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.7.0"
    }
  }
}


# Run Vault locally via: vault server -dev -dev-root-token-id root
provider "vault" {
  address = "http://127.0.0.1:8200"
  token   = "root"
}

# Ephemeral resources exist only during the current plan/apply. Their
# values are never written to the state file.
ephemeral "random_password" "example" {
  length  = 16
  special = false
}

# `data_json_wo` is a write-only argument: Terraform passes the value to
# the provider but never persists it in state or in the plan. Because
# Terraform can't diff a value it never stores, `data_json_wo_version` is
# bumped manually to tell Terraform the write-only value changed and the
# secret should be rewritten in Vault.
resource "vault_kv_secret_v2" "example" {
  mount = "secret"
  name  = "ephemeral-example"

  data_json_wo = jsonencode({
    password = ephemeral.random_password.example.result
  })
  data_json_wo_version = 1

  # The provider still has a `data` attribute that reads the secret back
  # from Vault after writing it, purely for drift detection. That read-back
  # would put the plaintext secret into state anyway, defeating the point
  # of using a write-only argument. `disable_read` turns that read off, at
  # the cost of Terraform no longer detecting drift on this secret.
  disable_read = true
}
