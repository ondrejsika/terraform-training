output "example" {
  value = join("", regexall("[a-z0-9]+", lower("Random Name-01")))
}
