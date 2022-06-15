resource "random_string" "example" {
  special          = true
  override_special = "_"
}
