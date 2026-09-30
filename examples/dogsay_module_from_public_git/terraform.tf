module "dogsay" {
  source = "git::https://github.com/ondrejsika/terraform-training.git//modules/dogsay"

  text = "Hello from public Git repository!"
}

output "dogsay_output" {
  value = module.dogsay.output
}
