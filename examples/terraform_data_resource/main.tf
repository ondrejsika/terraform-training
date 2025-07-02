resource "terraform_data" "example" {
  lifecycle {
    ignore_changes = [
      input,
    ]
  }
  input = {
    first_run = timestamp()
    message   = "Hello World!"
  }
}

output "example" {
  value = terraform_data.example.output
}
