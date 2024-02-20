locals {
  data = "Random Name-01"
}

output "lower" {
  value = lower(local.data)
}

output "regexall" {
  value = regexall("[a-z0-9]+", lower(local.data))
}

output "join" {
  value = join("", regexall("[a-z0-9]+", lower(local.data)))
}
