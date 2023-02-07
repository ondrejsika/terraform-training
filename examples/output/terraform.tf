output "message" {
  value = "Output"
}

output "secret" {
  value     = "Sensitive Output"
  sensitive = true
}

output "list" {
  value = [
    "foo",
    "bar",
  ]
}

output "map" {
  value = {
    hello = "ahoj"
    world = "svete"
  }
}
