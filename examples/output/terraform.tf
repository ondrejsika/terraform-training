output "message" {
  value = "Output"
}

output "secret" {
  value = "Sensitive Output"
  sensitive = true
}
